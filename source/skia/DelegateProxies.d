module skia.DelegateProxies;

import std.experimental.logger;
import skia.Definitions;
import skia.SkiaApi;
import skia.SKMatrix;

import core.memory;
import std.functional;
import skia.DelegateProxies;

// delegates

alias SKBitmapReleaseDelegate = void delegate (void* address, void* context);

alias SKDataReleaseDelegate = void delegate (void* address, void* context);

alias SKImageRasterReleaseDelegate = void delegate (void* pixels, void* context);

alias SKImageTextureReleaseDelegate = void delegate (void* context);

alias SKSurfaceReleaseDelegate = void delegate (void* address, void* context);

alias GRGlGetProcDelegate = void* delegate (void* context, string name);

alias GRGlGetProcedureAddressDelegate = void* delegate (string name);

alias GRVkGetProcedureAddressDelegate = void* delegate (string name, void* instance, void* device);

// TODO: Tasks pending completion -@Administrator at 2021-01-18T11:39:32+08:00
// 
// alias SKGlyphPathDelegate = void delegate (SKPath path, SKMatrix matrix);


alias UserDataDelegate = Object delegate();

// delegate wrappers

/**
 * 
 */
struct DelegateWrapper(T) {
	T del;

	this(T del) {
		this.del = del;
	}

}

alias SKBitmapReleaseDelegateWrapper = DelegateWrapper!SKBitmapReleaseDelegate;
alias SKDataReleaseDelegateWrapper = DelegateWrapper!SKDataReleaseDelegate;
alias GRGlGetProcedureAddressDelegateWrapper = DelegateWrapper!GRGlGetProcedureAddressDelegate;
alias GRVkGetProcedureAddressDelegateWrapper = DelegateWrapper!GRVkGetProcedureAddressDelegate;


struct DelegateProxies
{
	// references to the proxy implementations

	static SKBitmapReleaseProxyDelegate SKBitmapReleaseDelegateProxy () { return &SKBitmapReleaseDelegateProxyImplementation; }
	static SKDataReleaseProxyDelegate SKDataReleaseDelegateProxy () { return &SKDataReleaseDelegateProxyImplementation; }
	static SKImageRasterReleaseProxyDelegate SKImageRasterReleaseDelegateProxy () { return &SKImageRasterReleaseDelegateProxyImplementation; }
	static SKImageRasterReleaseProxyDelegate SKImageRasterReleaseDelegateProxyForCoTaskMem () { return &SKImageRasterReleaseDelegateProxyImplementationForCoTaskMem; }
	static SKImageTextureReleaseProxyDelegate SKImageTextureReleaseDelegateProxy () { return &SKImageTextureReleaseDelegateProxyImplementation; }
	static SKSurfaceRasterReleaseProxyDelegate SKSurfaceReleaseDelegateProxy () { return &SKSurfaceReleaseDelegateProxyImplementation; }
	static GRGlGetProcProxyDelegate GRGlGetProcDelegateProxy () { return &GRGlGetProcDelegateProxyImplementation; }
	static GRVkGetProcProxyDelegate GRVkGetProcDelegateProxy () { return &GRVkGetProcDelegateProxyImplementation; }
	static SKGlyphPathProxyDelegate SKGlyphPathDelegateProxy () { return &SKGlyphPathDelegateProxyImplementation; }

	// proxy implementations
	extern(C) private static void SKBitmapReleaseDelegateProxyImplementation (void* address, void* context)
	{
		warning("TODO - start");

		SKBitmapReleaseDelegateWrapper* wrapper = cast(SKBitmapReleaseDelegateWrapper*)context;

		SKBitmapReleaseDelegate del = wrapper.del;
		if(del !is null) {
			scope(exit) {
				// Assuming that the callback is invoked only once, the
				// added root can be removed again now to allow the GC
				// to collect it later.
				GC.removeRoot(context);
				GC.clrAttr(context, GC.BlkAttr.NO_MOVE);
			}

			try {
				del(address, null);
			} catch(Throwable t) {
				warning(t);
			}
		}

		warning("TODO - done");
		// auto del = Get<SKBitmapReleaseDelegate> ((void*)context, out var gch);
		// try {
		// 	del.Invoke ((void*)address, null);
		// } finally {
		// 	gch.Free ();
		// }
	}
	extern(C) private static void SKDataReleaseDelegateProxyImplementation (void* address, void* context)
	{
		warning("TODO - start");

		SKDataReleaseDelegateWrapper* wrapper = cast(SKDataReleaseDelegateWrapper*)context;

		SKDataReleaseDelegate del = wrapper.del;
		if(del !is null) {
			scope(exit) {
				GC.removeRoot(context);
				GC.clrAttr(context, GC.BlkAttr.NO_MOVE);
			}

			try {
				del(address, null);
			} catch(Throwable t) {
				warning(t);
			}
		}

		warning("TODO - done");
	}
	
	extern(C) private static void SKImageRasterReleaseDelegateProxyImplementationForCoTaskMem (void* pixels, void* context)
	{
		warning("TODO");
		// Marshal.FreeCoTaskMem ((void*)pixels);
	}

	extern(C) private static void SKImageRasterReleaseDelegateProxyImplementation (void* pixels, void* context)
	{
		warning("TODO");
		// auto del = Get<SKImageRasterReleaseDelegate> ((void*)context, out var gch);
		// try {
		// 	del.Invoke ((void*)pixels, null);
		// } finally {
		// 	gch.Free ();
		// }
	}

	extern(C) private static void SKImageTextureReleaseDelegateProxyImplementation (void* context)
	{

		warning("TODO");

		// auto del = Get<SKImageTextureReleaseDelegate> ((void*)context, out var gch);
		// try {
		// 	del.Invoke (null);
		// } finally {
		// 	gch.Free ();
		// }
	}

	extern(C) private static void SKSurfaceReleaseDelegateProxyImplementation (void* address, void* context)
	{
		warning("TODO");
		// auto del = Get<SKSurfaceReleaseDelegate> ((void*)context, out var gch);
		// try {
		// 	del.Invoke ((void*)address, null);
		// } finally {
		// 	gch.Free ();
		// }
	}

	extern(C) private static void* GRGlGetProcDelegateProxyImplementation (void* context, void* name)
	{
		warning("TODO");
		return null;

		// auto del = Get<GRGlGetProcedureAddressDelegate> ((void*)context, out _);
		// return del.Invoke (Marshal.PtrToStringAnsi ((void*)name));
	}

	extern(C) private static void* GRVkGetProcDelegateProxyImplementation (void* context, void* name, void* instance, void* device)
	{
		warning("TODO");
		return null;
		// auto del = Get<GRVkGetProcedureAddressDelegate> ((void*)context, out _);

		// return del.Invoke (Marshal.PtrToStringAnsi ((void*)name), instance, device);
	}

	extern(C) private static void SKGlyphPathDelegateProxyImplementation (void* pathOrNull, SKMatrix* matrix, void* context)
	{
		warning("TODO");
		// auto del = Get<SKGlyphPathDelegate> ((void*)context, out _);
		// auto path = SKPath.GetObject (pathOrNull, false);
		// del.Invoke (path, *matrix);
	}


	static T Create(T) (T nativeDel, void* context)
	{
		if (context is null) {
			return T.init;
		}

		// Make sure that it is not collected even if it is no
		// longer referenced from D code (stack, GC heap, …).
		GC.addRoot(cast(void*)context);

		// Also ensure that a moving collector does not relocate
		// the object.
		GC.setAttr(cast(void*)context, GC.BlkAttr.NO_MOVE);

		// gch = GCHandle.Alloc (managedDel);
		// GCHandle.ToIntPtr (gch);
		return nativeDel;
	}

	// static void Create (T nativeDel, void* context)
	// {
	// 	if (context is null) {
	// 		return T.init;
	// 	}

	// 	// Make sure that it is not collected even if it is no
	// 	// longer referenced from D code (stack, GC heap, …).
	// 	GC.addRoot(cast(void*)context);

	// 	// Also ensure that a moving collector does not relocate
	// 	// the object.
	// 	GC.setAttr(cast(void*)context, GC.BlkAttr.NO_MOVE);

	// 	// gch = GCHandle.Alloc (managedDel);
	// 	// GCHandle.ToIntPtr (gch);
	// 	return nativeDel;
	// }

	// user data delegates

	// static void* CreateUserData (Object userData, bool makeWeak = false)
	// {
	// 	UserDataDelegate del = () { return userData; } ;

	// 	void* ctx ;
	// 	Create (del, out _, ctx);
	// 	return ctx;
	// }
}
