module skia.SKData;

import skia.Definitions;
import skia.DelegateProxies;
import skia.Exceptions;
import skia.SkiaApi;
import skia.SKObject;
import skia.SKStream;

import std.algorithm;
import std.math;
import std.range;
import std.string;


/**
 * 
 */
class SKData : SKObject, ISKNonVirtualReferenceCounted
{
	// We pick a value that is the largest multiple of 4096 that is still smaller than the large object heap threshold (85K).
	// The CopyTo/CopyToAsync buffer is short-lived and is likely to be collected at Gen0, and it offers a significant
	// improvement in Copy performance.
	enum int CopyBufferSize = 81920;

	private __gshared SKData empty;

	shared static this()
	{
		empty = new SKDataStatic (SkiaApi.sk_data_new_empty ());
	}

	static void EnsureStaticInstanceAreInitialized ()
	{
		// IMPORTANT: do not remove to ensure that the static instances
		//            are initialized before any access is made to them
	}

	this (void* x, bool owns)
	{
		super (x, owns);
	}

	protected override void Dispose (bool disposing)
	{
		return super.Dispose (disposing);
	}

	override void Dispose ()
	{
		 super.Dispose ();
	}

	void ReferenceNative () { return SkiaApi.sk_data_ref (cast(sk_data_t*)Handle); }

	void UnreferenceNative () { return SkiaApi.sk_data_unref (cast(sk_data_t*)Handle); }

	static SKData Empty () { return empty; }

	// CreateCopy

	static SKData CreateCopy (void* bytes, ulong length)
	{
		// if (!PlatformConfiguration.Is64Bit && length > uint.max)
		// 	throw new ArgumentOutOfRangeException (length.stringof, "The length exceeds the size of pointers.");
		return GetObject (SkiaApi.sk_data_new_with_copy (cast(void*)bytes, cast(size_t) length));
	}

	static SKData CreateCopy ( byte[] bytes)
	{
		return CreateCopy (bytes, bytes.length);
	}

	static SKData CreateCopy (byte[] bytes, size_t length)
	{
		byte* b = bytes.ptr;
		return GetObject (SkiaApi.sk_data_new_with_copy (b, length));
	}

	// static SKData CreateCopy (const(byte)[] bytes)
	// {
	// 	byte* b = bytes.ptr;
	// 	return CreateCopy (cast(void*)b, bytes.length);
	// }

	// Create

	static SKData Create (int size)
	{
		return GetObject (SkiaApi.sk_data_new_uninitialized (cast(size_t) size));
	}

	static SKData Create (size_t size)
	{
		version(X86) {
			if (size > uint.max)
				throw new ArgumentOutOfRangeException (size.stringof, "The size exceeds the size of pointers.");
		}
			
		return GetObject (SkiaApi.sk_data_new_uninitialized (size));
	}

	static SKData Create (string filename)
	{
		if (filename.empty())
			throw new ArgumentException ("The filename cannot be empty.", filename.stringof);

		// auto utf8path = StringUtilities.GetEncodedText (filename, SKTextEncoding.Utf8, true);
		auto utf8path = filename.toStringz();
		byte* u = cast(byte*)utf8path;
		return GetObject (SkiaApi.sk_data_new_from_file (u.stringof));
	}

	// static SKData Create (Stream stream)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);
	// 	if (stream.CanSeek) {
	// 		return Create (stream, stream.Length);
	// 	} else {
	// 		auto memory =  new SKDynamicMemoryWStream ();
	// 		scope(exit) {
	// 		    memory.Dispose();
	// 		}

	// 		using (var managed = new SKManagedStream (stream)) {
	// 			managed.CopyTo (memory);
	// 		}
	// 		return memory.DetachAsData ();
	// 	}
	// }

	// static SKData Create (Stream stream, int length)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	 SKManagedStream managed = new SKManagedStream (stream);
	// 	return Create (managed, length);
	// }

	// static SKData Create (Stream stream, ulong length)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	 SKManagedStream managed = new SKManagedStream (stream);
	// 	return Create (managed, length);
	// }

	// static SKData Create (Stream stream, long length)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	SKManagedStream managed = new SKManagedStream (stream);
	// 	return Create (managed, length);
	// }

	static SKData Create (SKStream stream)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

		return Create (stream, stream.Length);
	}

	static SKData Create (SKStream stream, int length)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

		return GetObject (SkiaApi.sk_data_new_from_stream (cast(sk_stream_t*)stream.Handle, cast(size_t)length));
	}

	static SKData Create (SKStream stream, ulong length)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

		return GetObject (SkiaApi.sk_data_new_from_stream (cast(sk_stream_t*)stream.Handle, cast(size_t)length));
	}

	static SKData Create (SKStream stream, long length)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

		return GetObject (SkiaApi.sk_data_new_from_stream (cast(sk_stream_t*)stream.Handle, cast(size_t)length));
	}

	// static SKData Create (void* address, int length)
	// {
	// 	return Create (address, length, null, null);
	// }

  static SKData Create (void* address, size_t length)
	{
		return Create (address, length, null, null);
	}

	static SKData Create (void* address, size_t length, SKDataReleaseDelegate releaseProc)
	{
		return Create (address, length, releaseProc, null);
	}

	static SKData Create (void* address, size_t length, SKDataReleaseDelegate releaseProc, void* context)
	{
		// SKDataReleaseDelegate del = releaseProc !is null && context !is null
		// 	? new SKDataReleaseDelegate ((addr, _) () { return releaseProc (addr, context)) }
		// 	: releaseProc;


		SKDataReleaseDelegate del = releaseProc;
		if(releaseProc !is null && context !is null) {
			del = (addr, _t) { releaseProc (addr, context); };
		}


		// https://www.cnblogs.com/zhaox583132460/p/3402243.html
		// FIXME: Needing refactor or cleanup -@putao at 2021-01-10T21:25:11+08:00
		// More tests needed
		SKDataReleaseDelegateWrapper wrapper = SKDataReleaseDelegateWrapper(del);

		void* ctx = cast(void*)&wrapper;
		SKDataReleaseProxyDelegate releaseProxy = DelegateProxies.SKDataReleaseDelegateProxy;
		SKDataReleaseProxyDelegate proxy = DelegateProxies.Create (releaseProxy, ctx);

		return GetObject (SkiaApi.sk_data_new_with_proc (cast(void*)address, length, proxy, ctx));
	}

	static SKData FromCString (string str)
	{
		// auto bytes = Encoding.ASCII.GetBytes (str ?? string.Empty);
		byte[] bytes = cast(byte[])str.dup;

		return SKData.CreateCopy (bytes, bytes.length + 1); // + 1 for the terminating char
	}

	// Subset

	SKData Subset (ulong offset, ulong length)
	{
		version(X86) {
			if (length > uint.max)
				throw new ArgumentOutOfRangeException (length.stringof, "The length exceeds the size of pointers.");
			if (offset > uint.max)
				throw new ArgumentOutOfRangeException (offset.stringof, "The offset exceeds the size of pointers.");
		}
		return GetObject (SkiaApi.sk_data_new_subset (cast(sk_data_t*)Handle, cast(size_t) offset, cast(size_t) length));
	}

	// ToArray

	byte[] ToArray ()
	{
		byte[] array = cast(byte[])AsSpan ().dup;
		// GC.KeepAlive (this);
		return array;
	}

	// properties

	bool IsEmpty () { return Size == 0; }

	long Size () { return cast(long)SkiaApi.sk_data_get_size (cast(sk_data_t*)Handle); }

	void* Data () { return cast(void*)SkiaApi.sk_data_get_data (cast(sk_data_t*)Handle); }

	// AsStream

	// Stream AsStream ()
	// {
	// 	return new SKDataStream (this, false);
	// }


	// Stream AsStream (bool streamDisposesData)
	// {
	// 	return new SKDataStream (this, streamDisposesData);
	// }


	// AsSpan

	const(byte)[] AsSpan ()
	{
		void* data = cast(void*)Data;
		return cast(const(byte)[]) data[0 .. Size()];
	}

	// SaveTo
	void SaveTo (DataWriter target)
	{
		if (target is null)
			throw new ArgumentNullException (target.stringof);

		void* ptr = Data;
		long total = Size;
		// ubyte[] buffer =  new ubyte[CopyBufferSize];

		for (long left = total; left > 0;) {
			auto copyCount = cast(int)min (CopyBufferSize, left);
			target(cast(ubyte[]) ptr[0..copyCount]);
			left -= copyCount;
			ptr += copyCount;
		}
	}	

	// void SaveTo (Stream target)
	// {
	// 	if (target is null)
	// 		throw new ArgumentNullException (target.stringof);

	// 	void* ptr = Data;
	// 	long total = Size;
	// 	byte[] buffer =  new byte[CopyBufferSize]; // Utils.RentArray<byte> (CopyBufferSize);
	// 	scope(exit) {
	// 	    buffer.Dispose();
	// 	}

	// 	for (var left = total; left > 0;) {
	// 		auto copyCount = cast(int)min (CopyBufferSize, left);
	// 		// Marshal.Copy (ptr, buffer, 0, copyCount);
	// 		buffer[0..copyCount] = ptr[0..copyCount];

	// 		left -= copyCount;
	// 		ptr += copyCount;
	// 		target.Write (buffer, 0, copyCount);
	// 	}
	// 	// GC.KeepAlive (this);
	// }

	static SKData GetObject (void* handle)
	{
    return GetOrAddObject!(SKData)(handle, delegate SKData (h, o) { return new SKData (h, o);});
	}
 }

	//

	// private class SKDataStream // : UnmanagedMemoryStream
	// {
	// 	private SKData host;
	// 	private bool disposeHost;

	// 	this (SKData host, bool disposeHost = false)
	// 	{
	// 		// super(cast(byte *) host.Data, host.Size);
	// 		this.host = host;
	// 		this.disposeHost = disposeHost;
	// 	}

	// 	protected  void Dispose (bool disposing)
	// 	// protected override void Dispose (bool disposing)
	// 	{
	// 		super.Dispose (disposing);
	// 		if (disposeHost) {
	// 			if(host !is null) host.Dispose ();
	// 		}
	// 		host = null;
	// 	}
	// }

	//

	private final class SKDataStatic : SKData
	{
		this (void* x)
		{
			super (x, true);
			IgnorePublicDispose = true;
		}
	}

