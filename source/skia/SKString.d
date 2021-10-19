module skia.SKString;

import skia.SkiaApi;
import skia.Definitions;
import skia.Exceptions;
import skia.SKObject;

class SKString : SKObject, ISKSkipObjectRegistration
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	this()
	{
		super(SkiaApi.sk_string_new_empty(), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKString instance.");
		}
	}

	this(byte[] src, long length)
	{
		super(CreateCopy(src, length), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to copy the SKString instance.");
		}
	}

	private static void* CreateCopy(byte[] src, long length)
	{
		byte* s = src.ptr;
		return SkiaApi.sk_string_new_with_copy(cast(const(char)*)s, cast(size_t)length);
	}

	this(byte[] src)
	{
		this(src, cast(long)src.length);
	}

	this(string str)
	{
		this(cast(byte[])str);
	}

	override string toString()
	{
		auto cstr = SkiaApi.sk_string_get_c_str(cast(sk_string_t*)Handle);
		auto clen = SkiaApi.sk_string_get_size(cast(sk_string_t*)Handle);
		// return StringUtilities.GetString(cast(void*) cstr, cast(int) clen, SKTextEncoding.Utf8);
		return cast(string)cstr[0..clen].dup;
	}

	string opCast(string)() {
		return toString();
	}

	static SKString Create(string str)
	{
		if (str is null)
		{
			return null;
		}
		return new SKString(str);
	}

	// protected override void Dispose(bool disposing)
	// {
	// 	return super.Dispose(disposing);
	// }

	protected override void DisposeNative()
	{
		return SkiaApi.sk_string_destructor(cast(sk_string_t*)Handle);
	}

	static SKString GetObject(void* handle)
	{
		return handle is null ? null : new SKString(cast(sk_string_t*)handle, true);
	}
}
