module skia.SKObject;

import skia.Definitions;
import skia.Exceptions;
import skia.IDisposable;
import skia.SkiaApi;
import std.experimental.logger;

import core.atomic;
import core.sync.condition;
import core.sync.mutex;
import core.sync.rwmutex;


/**
 * 
 */
class SKObject : SKNativeObject, ISKReferenceCounted
{
    // private const object locker = new object ();

// FIXME: Needing refactor or cleanup -@putao at 2020-12-27T16:44:22+08:00
// 
    // private ConcurrentDictionary<void*, SKObject> ownedObjects;
    // private ConcurrentDictionary<void*, SKObject> keepAliveObjects;
    private SKObject[void*] ownedObjects;
    private SKObject[void*] keepAliveObjects;
    
    private Mutex _ownedObjectsMutex;
    private Mutex _keepAliveObjectsMutex;

    // shared static this()
    // {
    //     // SkiaSharpVersion.CheckNativeLibraryCompatible (true);

    //     // SKColorSpace.EnsureStaticInstanceAreInitialized ();
    //     // SKData.EnsureStaticInstanceAreInitialized ();
    //     // SKFontManager.EnsureStaticInstanceAreInitialized ();
    //     // SKTypeface.EnsureStaticInstanceAreInitialized ();
    // }

    this (void* handle, bool owns)
    {
        _ownedObjectsMutex = new Mutex();
        _keepAliveObjectsMutex = new Mutex();
        super (handle, owns);
    }

    // protected override void Dispose (bool disposing) {
    //     return super.Dispose (disposing);
    // }

    // override void Dispose ()
    // {
    //     if (IgnorePublicDispose)
    //         return;

    //     DisposeInternal ();
    // }

    override void* Handle() {
        return super.Handle();
    }

    override void Handle(void* value) {
        if (value is null) {
            DeregisterHandle (Handle, this);
            super.Handle = value;
        } else {
            super.Handle = value;
            RegisterHandle (Handle, this);
        }
    }


    // SKObject[void*] OwnedObjects() {
    //     return ownedObjects;
    // }

    // SKObject[void*] KeepAliveObjects() {
    //     return keepAliveObjects;
    // }

    void registerOwnedObject(void* handle, SKObject obj) {
        _ownedObjectsMutex.lock();
        scope(exit) {
            _ownedObjectsMutex.unlock();
        }

        ownedObjects[handle] = obj;
    }

    void registerKeepAliveObject(void* handle, SKObject obj) {
        _ownedObjectsMutex.lock();
        scope(exit) {
            _ownedObjectsMutex.unlock();
        }

        keepAliveObjects[handle] = obj;
    }

    protected override void DisposeUnownedManaged ()
    {
        if (ownedObjects !is null) {
            foreach (SKObject c; ownedObjects.byValue()) {
                if(c is null) continue;
                
                version(SKIA_DEBUG) {
                    tracef("SKObject: %s, OwnsHandle: %s", typeid(c), c.OwnsHandle);
                }

                if (!c.OwnsHandle)
                    c.DisposeInternal ();
            }
        }
    }

    protected override void DisposeManaged ()
    {
        if (ownedObjects !is null) {
            foreach (SKObject c; ownedObjects.byValue()) {
                if (c !is null && c.OwnsHandle)
                    c.DisposeInternal ();
            }
            ownedObjects.clear ();
        }
        keepAliveObjects.clear ();
    }

    protected override void DisposeNative ()
    {
        ISKReferenceCounted refcnt = cast(ISKReferenceCounted)this;
        if (refcnt !is null)
            refcnt.SafeUnRef ();
    }

    static TSkiaObject GetOrAddObject(TSkiaObject) (void* handle, Func!(void*, bool, TSkiaObject) objectFactory)
        if(is(TSkiaObject : SKObject))
    {
        if (handle is null)
            return null;

        return HandleDictionary.GetOrAddObject!(TSkiaObject) (handle, true, true, objectFactory);
    }

    static TSkiaObject GetOrAddObject(TSkiaObject) (void* handle, bool owns, Func!(void*, bool, TSkiaObject) objectFactory)
        if(is(TSkiaObject : SKObject))
    {
        trace("xxxx");

        if (handle is null)
            return null;

        return HandleDictionary.GetOrAddObject!(TSkiaObject) (handle, owns, true, objectFactory);
    }

    static TSkiaObject GetOrAddObject(TSkiaObject) (void* handle, bool owns, bool unrefExisting, Func!(void*, bool, TSkiaObject) objectFactory)
        if(is(TSkiaObject : SKObject))
    {
        if (handle is null)
            return null;

        return HandleDictionary.GetOrAddObject!(TSkiaObject) (handle, owns, unrefExisting, objectFactory);
    }

    static void RegisterHandle (void* handle, SKObject instance)
    {
        if (handle is null || instance is null)
            return;
        HandleDictionary.RegisterHandle (handle, instance);
    }

    static void DeregisterHandle (void* handle, SKObject instance)
    {
        if (handle is null)
            return;

        HandleDictionary.DeregisterHandle (handle, instance);
    }

    static bool GetInstance(TSkiaObject) (void* handle, ref TSkiaObject instance)
        if(is(TSkiaObject : SKObject))
    {
        if (handle is null) {
            instance = null;
            return false;
        }

        return HandleDictionary.GetInstance!(TSkiaObject) (handle, instance);
    }

    // indicate that the user cannot dispose the object
    void PreventPublicDisposal ()
    {
        IgnorePublicDispose = true;
    }

    // indicate that the ownership of this object is now in the hands of
    // the native object
    void RevokeOwnership (SKObject newOwner)
    {
        OwnsHandle = false;
        IgnorePublicDispose = true;

        if (newOwner is null)
            DisposeInternal ();
        else {
            newOwner.registerOwnedObject(Handle, this);
        }
    }

    // indicate that the child is controlled by the native code and
    // the managed wrapper should be disposed when the owner is
    static T OwnedBy(T) (T child, SKObject owner)
        if(is(T : SKObject))
    {
        if (child !is null) {
            owner.registerOwnedObject(child.Handle, child);
            // owner.OwnedObjects[child.Handle] = child;
        }

        return child;
    }

    // indicate that the child was created by the managed code and
    // should be disposed when the owner is
    static T Owned(T) (T owner, SKObject child)
        if(is(T : SKObject))
    {
        if (child !is null) {
            if (owner !is null){
                owner.registerOwnedObject(child.Handle, child);
                // owner.OwnedObjects[child.Handle] = child;
            }
            else
                child.Dispose ();
        }

        return owner;
    }

    // indicate that the chile should not be garbage collected while
    // the owner still lives
    static T Referenced(T) (T owner, SKObject child)
        if(is(T : SKObject))
    {
        if (child !is null && owner !is null) {
            // owner.KeepAliveObjects[child.Handle] = child;
            owner.registerKeepAliveObject(child.Handle, child);

        }

        return owner;
    }

    static T[] PtrToStructureArray(T) (void* intPtr, int count)
    {
        warning("TODO");
        auto items = new T[count];
        // var size = Marshal.SizeOf!(T) ();
        // for (var i = 0; i < count; i++) {
        //     var newPtr = new void* (intPtr.ToInt64 () + (i * size));
        //     items[i] = Marshal.PtrToStructure<T> (newPtr);
        // }
        return items;
    }

    // static T PtrToStructure<T> (void* intPtr, int index)
    // {
    //     var size = Marshal.SizeOf<T> ();
    //     var newPtr = new void* (intPtr.ToInt64 () + (index * size));
    //     return Marshal.PtrToStructure<T> (newPtr);
    // }
}


/**
 * 
 */
class SKNativeObject : IDisposable
{
    bool fromFinalizer = false;

    private shared int isDisposed = 0;

    this (void* handle)
    {
        this (handle, true);
    }

    this (void* handle, bool ownsHandle)
    {
        version(SKIA_DEBUG) {
            tracef("SkObject: %s, ownsHandle: %s", typeid(this), ownsHandle);
        }
        Handle = handle;
        OwnsHandle = ownsHandle;
    }

    ~this ()
    {
        fromFinalizer = true;
        Dispose (false);
    }

    private void* _handle = null;
    void* Handle() { 
        return _handle;
    }

    protected void Handle(void* value) {
        _handle = value;
    }

    private bool _ownsHandle = false;
    protected bool OwnsHandle() { 
        return _ownsHandle;
    }

    protected void OwnsHandle(bool value) {
        _ownsHandle = value;
    }

    private bool _ignorePublicDispose = false;
    protected bool IgnorePublicDispose() { 
        return _ignorePublicDispose;
    }

    protected void IgnorePublicDispose(bool value) {
        _ignorePublicDispose = value;
    }

    protected bool IsDisposed() {
        return isDisposed == 1;
    }

    protected void DisposeUnownedManaged ()
    {
        // dispose of any managed resources that are not actually owned
    }

    protected void DisposeManaged ()
    {
        // dispose of any managed resources
    }

    protected void DisposeNative ()
    {
        // dispose of any unmanaged resources
    }

    protected void Dispose (bool disposing)
    {
        // if (Interlocked.CompareExchange (ref isDisposed, 1, 0) != 0)
        //     return;
        int v = cas(&isDisposed, 1, 0);
        if(v != 0) {
            return;
        }

        // dispose any objects that are owned/created by native code
        if (disposing)
            DisposeUnownedManaged ();

        // destroy the native object
        if (Handle !is null && OwnsHandle)
            DisposeNative ();

        // dispose any remaining managed-created objects
        if (disposing) 
            DisposeManaged ();

        Handle = null;
    }

    void Dispose ()
    {
        if (IgnorePublicDispose)
            return;

        DisposeInternal ();
    }

    protected void DisposeInternal ()
    {
        Dispose (true);
        // FIXME: Needing refactor or cleanup -@putao at 2020-12-27T16:08:53+08:00
        // 
        // GC.SuppressFinalize (this);
    }
}


/**
 * SKObjectExtensions
 */
bool IsUnique (void* handle, bool isVirtual)
{
    if (isVirtual)
        return SkiaApi.sk_refcnt_unique (cast(sk_refcnt_t*)handle);
    else
        return SkiaApi.sk_nvrefcnt_unique (cast(sk_nvrefcnt_t*)handle);
}

int GetReferenceCount (void* handle, bool isVirtual)
{
    if (isVirtual)
        return SkiaApi.sk_refcnt_get_ref_count (cast(sk_refcnt_t*)handle);
    else
        return SkiaApi.sk_nvrefcnt_get_ref_count (cast(sk_nvrefcnt_t* )handle);
}

void SafeRef (ISKReferenceCounted obj)
{
    ISKNonVirtualReferenceCounted nvrefcnt = cast(ISKNonVirtualReferenceCounted)obj;
    if (nvrefcnt !is nvrefcnt)
        nvrefcnt.ReferenceNative ();
    else
        SkiaApi.sk_refcnt_safe_unref (cast(sk_refcnt_t*)obj.Handle);
}

void SafeUnRef (ISKReferenceCounted obj)
{
    ISKNonVirtualReferenceCounted nvrefcnt = cast(ISKNonVirtualReferenceCounted)obj;
    if (nvrefcnt !is nvrefcnt)
        nvrefcnt.UnreferenceNative ();
    else
        SkiaApi.sk_refcnt_safe_unref (cast(sk_refcnt_t*)obj.Handle);
}

int GetReferenceCount (ISKReferenceCounted obj)
{
    ISKNonVirtualReferenceCounted skObj = cast(ISKNonVirtualReferenceCounted)obj;
    if (skObj !is null)
        return SkiaApi.sk_nvrefcnt_get_ref_count (cast(sk_nvrefcnt_t*)obj.Handle);
    else
        return SkiaApi.sk_refcnt_get_ref_count (cast(sk_refcnt_t*)obj.Handle);
}


/**
 * 
 */
interface ISKReferenceCounted
{
    void* Handle();
}


/**
 * 
 */
interface ISKNonVirtualReferenceCounted : ISKReferenceCounted
{
    void ReferenceNative ();

    void UnreferenceNative ();
}


/**
 * 
 */
interface ISKSkipObjectRegistration
{
}


alias Func(T, R) = R delegate(T);
alias Func(T1, T2, R) = R delegate(T1, T2);
alias Func(T1, T2, T3, R) = R delegate(T1, T2, T3);
alias Func(T1, T2, T3, T4, R) = R delegate(T1, T2, T3, T4);
alias Func(T1, T2, T3, T4, T5, R) = R delegate(T1, T2, T3, T4, T5);

package struct HandleDictionary {
    private __gshared Object[void*] instances;
    private __gshared Mutex instancesLock;

    shared static this() {
        instancesLock = new Mutex();
    }

    /// <summary>
    /// Retrieve the living instance if there is one, or null if not.
    /// </summary>
    /// <returns>The instance if it is alive, or null if there is none.</returns>
    static bool GetInstance(TSkiaObject) (void* handle, ref TSkiaObject instance)
        if(is(TSkiaObject : SKObject))
    {
        if (handle is null) {
            instance = null;
            return false;
        }

        // FIXME: Needing refactor or cleanup -@putao at 2021-01-01T12:20:15+08:00
        // 
        // if (SkipObjectRegistrationType.IsAssignableFrom (typeof (TSkiaObject))) {
        //     instance = null;
        //     return false;
        // }

        instancesLock.lock();
        try {
            return GetInstanceNoLocks (handle, instance);
        } finally {
            instancesLock.unlock();
        }
    }

    /// <summary>
    /// Retrieve or create an instance for the native handle.
    /// </summary>
    /// <returns>The instance, or null if the handle was null.</returns>
    static TSkiaObject GetOrAddObject(TSkiaObject) (void* handle, bool owns, bool unrefExisting, Func!(void*, bool, TSkiaObject) objectFactory)
        if(is(TSkiaObject : SKObject))
    {
        if (handle is null)
            return null;

//         if (SkipObjectRegistrationType.IsAssignableFrom (typeof (TSkiaObject))) {
// #if THROW_OBJECT_EXCEPTIONS
//             throw new InvalidOperationException (
//                 "For some reason, the object was constructed using a factory function instead of the constructor. " +
//                 "H: {handle.ToString ("x")} Type: {typeof (TSkiaObject)}");
// #else
//             return objectFactory.Invoke (handle, owns);
// #endif
//         }

        instancesLock.lock();

        try {
            TSkiaObject instance;
            if (GetInstanceNoLocks!(TSkiaObject)(handle, instance)) {
                // some object get automatically referenced on the native side,
                // but managed code just has the same reference
                ISKReferenceCounted refcnt = cast(ISKReferenceCounted)instance;
                if (unrefExisting && refcnt !is null) {
                    if (refcnt.GetReferenceCount () == 1) {
                        throw new InvalidOperationException ( "About to unreference an object that has no references. ");
                        // throw new InvalidOperationException (
                        //     "About to unreference an object that has no references. " ~
                        //     format("H: {handle.ToString (\"%02X\")} Type: {instance.GetType ()}"));
                    }
                    refcnt.SafeUnRef ();
                }

                return instance;
            }

            TSkiaObject obj = objectFactory(handle, owns);

            return obj;
        } catch(Exception ex) {
            warning(ex);
            return TSkiaObject.init;
        } finally {
            instancesLock.unlock();
        }
    }

    /// <summary>
    /// Retrieve the living instance if there is one, or null if not. This does not use locks.
    /// </summary>
    /// <returns>The instance if it is alive, or null if there is none.</returns>
    private static bool GetInstanceNoLocks(TSkiaObject) (void* handle, TSkiaObject instance)
        if(is(TSkiaObject : SKObject))
    {
        auto itemPtr = handle in instances;
        if(itemPtr !is null) {
            TSkiaObject match = cast(TSkiaObject)*itemPtr;
            if(match is null) {
                warning("A managed object exists for the handle, but is not the expected type.");
            } else {
                instance = match;
                return true;
            }
        } 

        instance = null;
        return false;
    }

    /// <summary>
    /// Registers the specified instance with the dictionary.
    /// </summary>
    static void RegisterHandle (void* handle, SKObject instance)
    {
        if (handle is null || instance is null)
            return;

        ISKSkipObjectRegistration objectRegistration = cast(ISKSkipObjectRegistration)instance;
        if (objectRegistration !is null)
            return;

        SKObject objectToDispose = null;
        instancesLock.lock();

        try {
            Object oldValue;
            auto itemPtr = handle in instances;

            if(itemPtr !is null) {
                oldValue = *itemPtr;
                SKObject obj = cast(SKObject)oldValue;
                if(obj is null) {
                    warning("No a SKObject");
                } else {
                    if (obj.OwnsHandle) {
                        // a mostly recoverable error
                        // if there is a managed object, then maybe something happened and the native object is dead
                        // throw new InvalidOperationException (
                        //     "A managed object already exists for the specified native object. " +
                        //     "H: {handle.ToString ("x")} Type: ({obj.GetType ()}, {instance.GetType ()})");
                        throw new Exception("A managed object already exists for the specified native object. ");
                    }

                    objectToDispose = obj;
                }
            }

            instances[handle] = instance;
        } finally {
            instancesLock.unlock();
            // instancesLock.ExitWriteLock ();
        }

        // dispose the object we just replaced
        if(objectToDispose !is null) {
            objectToDispose.DisposeInternal ();
        }
    }

    /// <summary>
    /// Removes the registered instance from the dictionary.
    /// </summary>
    static void DeregisterHandle (void* handle, SKObject instance)
    {
        if (handle is null)
            return;

        ISKSkipObjectRegistration objectRegistration = cast(ISKSkipObjectRegistration)instance;
        if (objectRegistration !is null)
            return;

        instancesLock.lock();

        try {

            void* weak;
            auto itemPtr = handle in instances;
            if(itemPtr !is null) {
                SKObject obj = cast(SKObject)*itemPtr;
                if(*itemPtr is null || obj is instance) {
                    instances.remove(handle);
                } else {
                    warning("A managed object did not exist for the specified native object. " );
                }
            } else {
                warning("A managed object did not exist for the specified native object. " );
            }

        } finally {
            instancesLock.unlock();
        }
    }
}