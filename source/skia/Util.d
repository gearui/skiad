module skia.Util;

import skia.Definitions;
import skia.Exceptions;

// import skia.SkiaApi;

import std.math;
import std.range;

enum
{
	UTF8,
	UTF16,
	UTF32
}

bool HasFlag(E)(E e, E flag) if (is(E == enum))
{
	if (e & flag)
		return true;

	return false;
}

struct Utils
{
	enum float NearlyZero = 1.0f / (1 << 12);

	static byte[] AsSpan(void* ptr, int size)
	{
		return (cast(byte*) ptr)[0 .. size];
	}

	static const(byte)[] AsReadOnlySpan(void* ptr, int size)
	{
		return cast(const(byte)[])(ptr[0 .. size]);
	}

	static bool NearlyEqual(float a, float b, float tolerance)
	{
		return abs(a - b) <= tolerance;
	}

	static byte[] GetBytes(SKEncoding encoding, const(char)[] text)
	{
		return cast(byte[]) text.dup;
		// if (text.Length == 0)
		// 	return new byte[0];

		// char* t = text; {
		// 	var byteCount = encoding.GetByteCount (t, text.Length);
		// 	if (byteCount == 0)
		// 		return new byte[0];

		// 	var bytes = new byte[byteCount];
		// 	byte* b = bytes;
		// 	encoding.GetBytes (t, text.Length, b, byteCount);
		// 	return bytes;
		// }
	}

	// static RentedArray!(T) RentArray(T)(int length)
	// {
	// 	return new RentedArray!(T)(length);
	// }

	// ref struct RentedArray(T)
	// {
	// 	this(int length)
	// 	{
	// 		Array = ArrayPool!(T).Shared.Rent(length);
	// 		span = new Span!(T)(Array, 0, length);
	// 	}

	// 	const T[] Array;

	// 	const Span!(T) span;

	// 	int Length()
	//   {
	//     return span.Length;
	//   } 

	// 	void Dispose()
	// 	{
	// 		// return ArrayPool!(T).Shared.Return(Array);
	// 	}

	// 	// static explicit operator T[](RentedArray!(T) scope)
	// 	// {
	// 	// 	return scope.Array;
	// 	// }

	// 	// static implicit operator Span!(T)(RentedArray!(T) scope)
	// 	// {
	// 	// 	return scope.Span;
	// 	// }

	// 	// static implicit operator ReadOnlySpan!(T)(RentedArray!(T) scope)
	// 	// {
	// 	// 	return scope.Span;
	// 	// }
	// }

	// static bool IsAssignableFrom(this Type type, Type c)
	// {
	// 	return type.GetTypeInfo().IsAssignableFrom(c.GetTypeInfo());
	// }
}

/**
 * 
 */
class StringUtilities
{
	enum string NullTerminator = "\0";

	// GetUnicodeStringLength

	private static int GetUnicodeStringLength(SKTextEncoding encoding)
	{
		switch (encoding)
		{
		case SKTextEncoding.Utf8:
			return 1;
		case SKTextEncoding.Utf16:
			return 1;
		case SKTextEncoding.Utf32:
			return 2;
		default:
			// throw new ArgumentOutOfRangeException(encoding.stringof(
			// 		"Encoding {encoding} is not supported."));
			throw new ArgumentOutOfRangeException("Encoding {encoding} is not supported.");
		}
	}

	// GetCharacterByteSize

	static int GetCharacterByteSize(SKTextEncoding encoding)
	{
		switch (encoding)
		{
		case SKTextEncoding.Utf8:
			return 1;
		case SKTextEncoding.Utf16:
			return 2;
		case SKTextEncoding.Utf32:
			return 4;
		default:
			// throw new ArgumentOutOfRangeException(encoding.stringof(
			// 		"Encoding {encoding} is not supported."));
			throw new ArgumentOutOfRangeException("Encoding {encoding} is not supported.");
		}
	}

	// GetUnicodeCharacterCode

	// static int GetUnicodeCharacterCode(string character, SKTextEncoding encoding)
	// {
	// 	if (character is null)
	// 		throw new ArgumentNullException(character.stringof);
	// 	if (GetUnicodeStringLength(encoding) != character.Length)
	// 		throw new ArgumentException(character.stringof,
	// 				"Only a single character can be specified.");

	// 	GetEncodedText bytes = GetEncodedText(character, encoding);
	// 	return BitConverter.ToInt32(bytes, 0);
	// }

	// GetEncodedText

	static byte[] GetEncodedText(string text, SKEncoding encoding)
	{
		return GetEncodedText(cast(const(char)[]) text, encoding.ToTextEncoding());
	}

	static byte[] GetEncodedText(string text, SKTextEncoding encoding)
	{
		return GetEncodedText(cast(const(char)[]) text, encoding);
	}

	static byte[] GetEncodedText(string text, SKTextEncoding encoding, bool addNull)
	{
		if (!text.empty && addNull)
			text ~= NullTerminator;

		return GetEncodedText(cast(const(char)[]) text, encoding);
	}

	static byte[] GetEncodedText(const(char)[] text, SKTextEncoding encoding)
	{
		// switch (encoding)
		// {
		// case SKTextEncoding.Utf8:
		// 	return Encoding.UTF8.GetBytes(text);
		// case SKTextEncoding.Utf16:
		// 	return Encoding.Unicode.GetBytes(text);
		// case SKTextEncoding.Utf32:
		// 	return Encoding.UTF32.GetBytes(text);
		// default:
		// 	// throw new ArgumentOutOfRangeException(encoding.stringof(
		// 	// 		"Encoding {encoding} is not supported."));
		//   	throw new ArgumentOutOfRangeException("Encoding {encoding} is not supported.");
		// }
		return cast(byte[]) text;
	}

	// GetString

	// static string GetString(void* data, int dataLength, SKTextEncoding encoding)
	// {
	// 	return GetString(data.AsReadOnlySpan(dataLength), 0, dataLength, encoding);
	// }

	// static string GetString(byte[] data, SKTextEncoding encoding)
	// {
	// 	return GetString(data, 0, data.Length, encoding);
	// }

	// static string GetString(byte[] data, int index, int count, SKTextEncoding encoding)
	// {
	// 	if (data is null)
	// 		throw new ArgumentNullException(data.stringof);

	// 	switch (encoding)
	// 	{
	// 	case SKTextEncoding.Utf8:
	// 		return Encoding.UTF8.GetString(data, index, count);
	// 	case SKTextEncoding.Utf16:
	// 		return Encoding.Unicode.GetString(data, index, count);
	// 	case SKTextEncoding.Utf32:
	// 		return Encoding.UTF32.GetString(data, index, count);
	// 	default:
	// 		throw new ArgumentOutOfRangeException(encoding.stringof(
	// 				"Encoding {encoding} is not supported."));
	// 	}
	// }

	// static string GetString(const(byte)[] data, SKTextEncoding encoding)
	// {
	// 	return GetString(data, 0, data.Length, encoding);
	// }

	// static string GetString(const(byte)[] data, int index, int count, SKTextEncoding encoding)
	// {
	// 	data = data.Slice(index, count);

	// 	if (data.Length == 0)
	// 		return string.Empty;

	// 	byte* bp = data;

	// 		switch (encoding)
	// 		{
	// 		case SKTextEncoding.Utf8:
	// 			return Encoding.UTF8.GetString(bp, data.Length);
	// 		case SKTextEncoding.Utf16:
	// 			return Encoding.Unicode.GetString(bp, data.Length);
	// 		case SKTextEncoding.Utf32:
	// 			return Encoding.UTF32.GetString(bp, data.Length);
	// 		default:
	// 			throw new ArgumentOutOfRangeException(encoding.stringof(
	// 					"Encoding {encoding} is not supported."));
	// 		}

	// }

}
