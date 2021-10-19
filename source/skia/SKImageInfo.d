module skia.SKImageInfo;


import skia.Definitions;
import skia.MathTypes;
import skia.SkiaApi;
import skia.SKColorSpace;
import skia.EnumMappings;

import std.concurrency : initOnce;


/**
 * 
 */
struct SKImageInfo // : IEquatable<SKImageInfo>
{
	enum SKImageInfo Empty = SKImageInfo(0, 0, SKColorType.Unknown);

	private __gshared bool _isInitialized = false;

	private __gshared int _platformColorAlphaShift;
	private __gshared int _platformColorRedShift;
	private __gshared int _platformColorGreenShift;
	private __gshared int _platformColorBlueShift;
	
	private static bool initializePlatformColor ()
	{
		int* a = &_platformColorAlphaShift;
		int* r = &_platformColorRedShift;
		int* g = &_platformColorGreenShift;
		int* b = &_platformColorBlueShift;

		SkiaApi.sk_color_get_bit_shift (a, r, g, b);

		return true;
	}
	
	static SKColorType PlatformColorType() {
		__gshared SKColorType inst;
		return initOnce!inst(SkiaApi.sk_colortype_get_default_8888 ().FromNative ());
	}

	static int PlatformColorAlphaShift() {
		initOnce!_isInitialized(initializePlatformColor());
		return _platformColorAlphaShift;
	}

	static int PlatformColorRedShift() {
		initOnce!_isInitialized(initializePlatformColor());
		return _platformColorRedShift;
	}

	static int PlatformColorGreenShift() {
		initOnce!_isInitialized(initializePlatformColor());
		return _platformColorGreenShift;
	}

	static int PlatformColorBlueShift() {
		initOnce!_isInitialized(initializePlatformColor());
		return _platformColorBlueShift;
	}

	int Width; // { get; set; }

	int Height; // { get; set; }

	SKColorType ColorType; // { get; set; }

	SKAlphaType AlphaType; // { get; set; }

	SKColorSpace ColorSpace; // { get; set; }

	this (int width, int height)
	{
		Width = width;
		Height = height;
		ColorType = PlatformColorType;
		AlphaType = SKAlphaType.Premul;
		ColorSpace = null;
	}

	this (int width, int height, SKColorType colorType)
	{
		Width = width;
		Height = height;
		ColorType = colorType;
		AlphaType = SKAlphaType.Premul;
		ColorSpace = null;
	}

	this (int width, int height, SKColorType colorType, SKAlphaType alphaType)
	{
		Width = width;
		Height = height;
		ColorType = colorType;
		AlphaType = alphaType;
		ColorSpace = null;
	}

	this (int width, int height, SKColorType colorType, SKAlphaType alphaType, SKColorSpace colorspace)
	{
		Width = width;
		Height = height;
		ColorType = colorType;
		AlphaType = alphaType;
		ColorSpace = colorspace;
	}

	int BytesPerPixel()
	{
		return ColorType.GetBytesPerPixel ();
	}

	int BitsPerPixel() { return BytesPerPixel * 8; }

	int BytesSize() { return Width * Height * BytesPerPixel; }

	long BytesSize64() { return cast(long)Width * cast(long)Height * cast(long)BytesPerPixel; }

	int RowBytes() { return Width * BytesPerPixel; }

	long RowBytes64() { return cast(long)Width * cast(long)BytesPerPixel; }

	bool IsEmpty() { return Width <= 0 || Height <= 0; }

	bool IsOpaque() { return AlphaType == SKAlphaType.Opaque; }

	SKSizeI Size() { return SKSizeI (Width, Height); }

	SKRectI Rect() { return SKRectI.Create (Width, Height); }

	SKImageInfo WithSize (SKSizeI size)
	{
		return WithSize (size.Width, size.Height);
	}

	SKImageInfo WithSize (int width, int height)
	{
		SKImageInfo copy = this;
		copy.Width = width;
		copy.Height = height;
		return copy;
	}

	SKImageInfo WithColorType (SKColorType newColorType)
	{
		SKImageInfo copy = this;
		copy.ColorType = newColorType;
		return copy;
	}

	SKImageInfo WithColorSpace (SKColorSpace newColorSpace)
	{
		SKImageInfo copy = this;
		copy.ColorSpace = newColorSpace;
		return copy;
	}

	SKImageInfo WithAlphaType (SKAlphaType newAlphaType)
	{
		SKImageInfo copy = this;
		copy.AlphaType = newAlphaType;
		return copy;
	}

	// bool Equals (SKImageInfo obj) =>
	// 	ColorSpace == obj.ColorSpace &&
	// 	Width == obj.Width &&
	// 	Height == obj.Height &&
	// 	ColorType == obj.ColorType &&
	// 	AlphaType == obj.AlphaType;

	// override bool Equals (object obj) =>
	// 	obj is SKImageInfo f && Equals (f);

	// static bool operator == (SKImageInfo left, SKImageInfo right) =>
	// 	left.Equals (right);

	// static bool operator != (SKImageInfo left, SKImageInfo right) =>
	// 	!left.Equals (right);

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (ColorSpace);
	// 	hash.Add (Width);
	// 	hash.Add (Height);
	// 	hash.Add (ColorType);
	// 	hash.Add (AlphaType);
	// 	return hash.ToHashCode ();
	// }


  	static void UpdateNative (ref SKImageInfo managed, ref SKImageInfoNative native)
	{
		SKColorSpace colorSpace = managed.ColorSpace;
		if(colorSpace !is null && colorSpace.Handle() !is null) {
			native.colorspace = cast(sk_colorspace_t*)colorSpace.Handle();
		} else {
			native.colorspace = null;
		}

		// native.colorspace = managed.ColorSpace?.Handle ?? null;
		native.width = managed.Width;
		native.height = managed.Height;
		native.colorType = managed.ColorType.ToNative ();
		native.alphaType = managed.AlphaType;
	}

	static SKImageInfoNative FromManaged (ref SKImageInfo managed)
	{
		SKImageInfoNative imageInfo;

		SKColorSpace colorSpace = managed.ColorSpace;
		if(colorSpace !is null && colorSpace.Handle() !is null) {
			imageInfo.colorspace = cast(sk_colorspace_t*)colorSpace.Handle();
		} else {
			imageInfo.colorspace = null;
		}
		imageInfo.width = managed.Width;
		imageInfo.height = managed.Height;
		imageInfo.colorType = managed.ColorType.ToNative ();
		imageInfo.alphaType = managed.AlphaType;

		return imageInfo;
	}

	static SKImageInfo ToManaged (ref SKImageInfoNative native)
	{
		SKImageInfo imageInfo;

		imageInfo.ColorSpace = SKColorSpace.GetObject (native.colorspace);
		imageInfo.Width = native.width;
		imageInfo.Height = native.height;
		imageInfo.ColorType = native.colorType.FromNative ();
		imageInfo.AlphaType = native.alphaType;

		return imageInfo;
	}

}
