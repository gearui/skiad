module skia.Definitions;

import skia.Exceptions;
import skia.MathTypes;
import skia.SKColor;

import std.conv;
import std.datetime;
import std.typecons;

alias DataWriter = void delegate(const(ubyte)[] data);

alias NullableFloat = Nullable!float;

enum SKCodecOrigin
{
	TopLeft = 1,
	TopRight = 2,
	BottomRight = 3,
	BottomLeft = 4,
	LeftTop = 5,
	RightTop = 6,
	RightBottom = 7,
	LeftBottom = 8,
}

enum SKEncoding
{
	Utf8 = 0,
	Utf16 = 1,
	Utf32 = 2,
}

enum SKFontStyleWeight
{
	Invisible = 0,
	Thin = 100,
	ExtraLight = 200,
	Light = 300,
	Normal = 400,
	Medium = 500,
	SemiBold = 600,
	Bold = 700,
	ExtraBold = 800,
	Black = 900,
	ExtraBlack = 1000,
}

enum SKFontStyleWidth
{
	UltraCondensed = 1,
	ExtraCondensed = 2,
	Condensed = 3,
	SemiCondensed = 4,
	Normal = 5,
	SemiExpanded = 6,
	Expanded = 7,
	ExtraExpanded = 8,
	UltraExpanded = 9,
}

enum SKColorType
{
	Unknown = 0,
	Alpha8 = 1,
	Rgb565 = 2,
	Argb4444 = 3,
	Rgba8888 = 4,
	Rgb888x = 5,
	Bgra8888 = 6,
	Rgba1010102 = 7,
	Rgb101010x = 8,
	Gray8 = 9,
	RgbaF16 = 10,
	RgbaF16Clamped = 11,
	RgbaF32 = 12,
	Rg88 = 13,
	AlphaF16 = 14,
	RgF16 = 15,
	Alpha16 = 16,
	Rg1616 = 17,
	Rgba16161616 = 18,
}


enum SKColorTypeNative {
	// UNKNOWN_SK_COLORTYPE = 0
	Unknown = 0,
	// ALPHA_8_SK_COLORTYPE = 1
	Alpha8 = 1,
	// RGB_565_SK_COLORTYPE = 2
	Rgb565 = 2,
	// ARGB_4444_SK_COLORTYPE = 3
	Argb4444 = 3,
	// RGBA_8888_SK_COLORTYPE = 4
	Rgba8888 = 4,
	// RGB_888X_SK_COLORTYPE = 5
	Rgb888x = 5,
	// BGRA_8888_SK_COLORTYPE = 6
	Bgra8888 = 6,
	// RGBA_1010102_SK_COLORTYPE = 7
	Rgba1010102 = 7,
	// RGB_101010X_SK_COLORTYPE = 8
	Rgb101010x = 8,
	// GRAY_8_SK_COLORTYPE = 9
	Gray8 = 9,
	// RGBA_F16_NORM_SK_COLORTYPE = 10
	RgbaF16Norm = 10,
	// RGBA_F16_SK_COLORTYPE = 11
	RgbaF16 = 11,
	// RGBA_F32_SK_COLORTYPE = 12
	RgbaF32 = 12,
	// R8G8_UNORM_SK_COLORTYPE = 13
	R8g8Unorm = 13,
	// A16_FLOAT_SK_COLORTYPE = 14
	A16Float = 14,
	// R16G16_FLOAT_SK_COLORTYPE = 15
	R16g16Float = 15,
	// A16_UNORM_SK_COLORTYPE = 16
	A16Unorm = 16,
	// R16G16_UNORM_SK_COLORTYPE = 17
	R16g16Unorm = 17,
	// R16G16B16A16_UNORM_SK_COLORTYPE = 18
	R16g16b16a16Unorm = 18,
}

enum SKPixelGeometry {
	// UNKNOWN_SK_PIXELGEOMETRY = 0
	Unknown = 0,
	// RGB_H_SK_PIXELGEOMETRY = 1
	RgbHorizontal = 1,
	// BGR_H_SK_PIXELGEOMETRY = 2
	BgrHorizontal = 2,
	// RGB_V_SK_PIXELGEOMETRY = 3
	RgbVertical = 3,
	// BGR_V_SK_PIXELGEOMETRY = 4
	BgrVertical = 4,
}

bool IsBgr (SKPixelGeometry pg)
{
	return pg == SKPixelGeometry.BgrHorizontal || pg == SKPixelGeometry.BgrVertical;
}

bool IsRgb (SKPixelGeometry pg)
{
	return pg == SKPixelGeometry.RgbHorizontal || pg == SKPixelGeometry.RgbVertical;
}

bool IsVertical (SKPixelGeometry pg)
{
	return pg == SKPixelGeometry.BgrVertical || pg == SKPixelGeometry.RgbVertical;
}

bool IsHorizontal (SKPixelGeometry pg)
{
	return pg == SKPixelGeometry.BgrHorizontal || pg == SKPixelGeometry.RgbHorizontal;
}


enum SKTextEncoding {
	// UTF8_SK_TEXT_ENCODING = 0
	Utf8 = 0,
	// UTF16_SK_TEXT_ENCODING = 1
	Utf16 = 1,
	// UTF32_SK_TEXT_ENCODING = 2
	Utf32 = 2,
	// GLYPH_ID_SK_TEXT_ENCODING = 3
	GlyphId = 3,
}

SKTextEncoding ToTextEncoding (SKEncoding encoding)
{
	switch(encoding)
	{
		case SKEncoding.Utf8: return SKTextEncoding.Utf8;
		case SKEncoding.Utf16: return SKTextEncoding.Utf16;
		case SKEncoding.Utf32: return SKTextEncoding.Utf32;
		default:
			throw new ArgumentOutOfRangeException (to!string (encoding));
	}
}

SKEncoding ToEncoding (SKTextEncoding encoding)
{
	switch(encoding)
	{
		case SKTextEncoding.Utf8: return SKEncoding.Utf8;
		case SKTextEncoding.Utf16: return SKEncoding.Utf16;
		case SKTextEncoding.Utf32: return SKEncoding.Utf32;
		default:
			throw new ArgumentOutOfRangeException (to!string (encoding));
	}
}

// SkImageInfo.cpp - SkColorTypeBytesPerPixel
int GetBytesPerPixel (SKColorType colorType)
{
	switch(colorType)
	{
		// 0
		case SKColorType.Unknown : return 0;
		// 1
		case SKColorType.Alpha8 : return 1;
		case SKColorType.Gray8 : return 1;
		// 2
		case SKColorType.Rgb565 : return 2;
		case SKColorType.Argb4444 : return 2;
		case SKColorType.Rg88 : return 2;
		case SKColorType.Alpha16 : return 2;
		case SKColorType.AlphaF16 : return 2;
		// 4
		case SKColorType.Bgra8888 : return 4;
		case SKColorType.Rgba8888 : return 4;
		case SKColorType.Rgb888x : return 4;
		case SKColorType.Rgba1010102 : return 4;
		case SKColorType.Rgb101010x : return 4;
		case SKColorType.Rg1616 : return 4;
		case SKColorType.RgF16 : return 4;
		// 8
		case SKColorType.RgbaF16Clamped : return 8;
		case SKColorType.RgbaF16 : return 8;
		case SKColorType.Rgba16161616 : return 8;
		// 16
		case SKColorType.RgbaF32 : return 16;
		//
		default:
			throw new ArgumentOutOfRangeException (to!string (colorType));
	}
}


enum SKAlphaType {
	// UNKNOWN_SK_ALPHATYPE = 0
	Unknown = 0,
	// OPAQUE_SK_ALPHATYPE = 1
	Opaque = 1,
	// PREMUL_SK_ALPHATYPE = 2
	Premul = 2,
	// UNPREMUL_SK_ALPHATYPE = 3
	Unpremul = 3,
}

/**
 * 
 */
// SkImageInfo.cpp - SkColorTypeValidateAlphaType
static SKAlphaType GetAlphaType (SKColorType colorType, SKAlphaType alphaType = SKAlphaType.Premul)
{
	switch (colorType) {
		case SKColorType.Unknown:
			alphaType = SKAlphaType.Unknown;
			break;

		// opaque or premul
		case SKColorType.Alpha8:
		case SKColorType.Alpha16:
		case SKColorType.AlphaF16:
			if (SKAlphaType.Unpremul == alphaType) {
				alphaType = SKAlphaType.Premul;
			}
			break;

		// any
		case SKColorType.Argb4444:
		case SKColorType.Rgba8888:
		case SKColorType.Bgra8888:
		case SKColorType.Rgba1010102:
		case SKColorType.RgbaF16Clamped:
		case SKColorType.RgbaF16:
		case SKColorType.RgbaF32:
		case SKColorType.Rgba16161616:
			break;

		// opaque
		case SKColorType.Gray8:
		case SKColorType.Rg88:
		case SKColorType.Rg1616:
		case SKColorType.RgF16:
		case SKColorType.Rgb565:
		case SKColorType.Rgb888x:
		case SKColorType.Rgb101010x:
			alphaType = SKAlphaType.Opaque;
			break;

		default:
			throw new ArgumentOutOfRangeException (to!string (colorType));
	}

	return alphaType;
}


enum SKSurfacePropsFlags {
	// NONE_SK_SURFACE_PROPS_FLAGS = 0
	None = 0,
	// USE_DEVICE_INDEPENDENT_FONTS_SK_SURFACE_PROPS_FLAGS = 1 << 0
	UseDeviceIndependentFonts = 1,
}


/**
 * 
 */
struct SKSurfaceProps // : IEquatable<SKSurfaceProps>
{
	SKPixelGeometry PixelGeometry; // { readonly get; set; }
	SKSurfacePropsFlags Flags; // { readonly get; set; }

	// const bool Equals (SKSurfaceProps obj) =>
	// 	PixelGeometry == obj.PixelGeometry &&
	// 	Flags == obj.Flags;

	// const override bool Equals (object obj) =>
	// 	obj is SKSurfaceProps f && Equals (f);

	// static bool operator == (SKSurfaceProps left, SKSurfaceProps right) =>
	// 	left.Equals (right);

	// static bool operator != (SKSurfaceProps left, SKSurfaceProps right) =>
	// 	!left.Equals (right);

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (PixelGeometry);
	// 	hash.Add (Flags);
	// 	return hash.ToHashCode ();
	// }
}


enum SKZeroInitialized {
	// YES_SK_CODEC_ZERO_INITIALIZED = 0
	Yes = 0,
	// NO_SK_CODEC_ZERO_INITIALIZED = 1
	No = 1,
}


enum SKTransferFunctionBehavior
{
	Ignore = 1,
	Respect = 0,
}


struct SKCodecOptions // : IEquatable<SKCodecOptions>
{
	enum SKCodecOptions Default = SKCodecOptions (SKZeroInitialized.No);


	this (SKZeroInitialized zeroInitialized)
	{
		ZeroInitialized = zeroInitialized;
		// Subset = null;
		FrameIndex = 0;
		PriorFrame = -1;
	}
	this (SKZeroInitialized zeroInitialized, SKRectI subset)
	{
		ZeroInitialized = zeroInitialized;
		Subset = subset;
		FrameIndex = 0;
		PriorFrame = -1;
	}
	this (SKRectI subset)
	{
		ZeroInitialized = SKZeroInitialized.No;
		Subset = subset;
		FrameIndex = 0;
		PriorFrame = -1;
	}
	this (int frameIndex)
	{
		ZeroInitialized = SKZeroInitialized.No;
		Subset = Nullable!(SKRectI).init;
		FrameIndex = frameIndex;
		PriorFrame = -1;
	}
	this (int frameIndex, int priorFrame)
	{
		ZeroInitialized = SKZeroInitialized.No;
		// Subset = null;
		FrameIndex = frameIndex;
		PriorFrame = priorFrame;
	}

	SKZeroInitialized ZeroInitialized; // { readonly get; set; }
	Nullable!SKRectI Subset; // { readonly get; set; }
	bool HasSubset() { return !Subset.isNull; }
	int FrameIndex; //{ readonly get; set; }
	int PriorFrame; // { readonly get; set; }

	SKTransferFunctionBehavior PremulBehavior() {
		return SKTransferFunctionBehavior.Respect;
	}

	// const bool Equals (SKCodecOptions obj) =>
	// 	ZeroInitialized == obj.ZeroInitialized &&
	// 	Subset == obj.Subset &&
	// 	FrameIndex == obj.FrameIndex &&
	// 	PriorFrame == obj.PriorFrame;

	// const override bool Equals (object obj) =>
	// 	obj is SKCodecOptions f && Equals (f);

	// static bool operator == (SKCodecOptions left, SKCodecOptions right) =>
	// 	left.Equals (right);

	// static bool operator != (SKCodecOptions left, SKCodecOptions right) =>
	// 	!left.Equals (right);

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (ZeroInitialized);
	// 	hash.Add (Subset);
	// 	hash.Add (FrameIndex);
	// 	hash.Add (PriorFrame);
	// 	return hash.ToHashCode ();
	// }
}

/**
 * 
 */
// struct SKFontMetrics
// {
// 	private enum uint flagsUnderlineThicknessIsValid = (1U << 0);
// 	private enum uint flagsUnderlinePositionIsValid = (1U << 1);
// 	private enum uint flagsStrikeoutThicknessIsValid = (1U << 2);
// 	private enum uint flagsStrikeoutPositionIsValid = (1U << 3);

// 	float Top() { return fTop; }

// 	float Ascent() { return fAscent; }

// 	float Descent() { return fDescent; }

// 	float Bottom() { return fBottom; }

// 	float Leading() { return fLeading; }

// 	float AverageCharacterWidth() { return fAvgCharWidth; }

// 	float MaxCharacterWidth() { return fMaxCharWidth; }

// 	float XMin() { return fXMin; }

// 	float XMax() { return fXMax; }

// 	float XHeight() { return fXHeight; }

// 	float CapHeight() { return fCapHeight; }

// 	Nullable!float UnderlineThickness() { return GetIfValid (fUnderlineThickness, flagsUnderlineThicknessIsValid); }
// 	Nullable!float UnderlinePosition() { return GetIfValid (fUnderlinePosition, flagsUnderlinePositionIsValid); }
// 	Nullable!float StrikeoutThickness() { return GetIfValid (fStrikeoutThickness, flagsStrikeoutThicknessIsValid); }
// 	Nullable!float StrikeoutPosition() { return GetIfValid (fStrikeoutPosition, flagsStrikeoutPositionIsValid); }

// 	private Nullable!float GetIfValid (float value, uint flag) 
// 	{
// 		return (fFlags & flag) == flag ? value : NullableFloat.init;
// 	}
// }

/**
 * 
 */
struct SKLattice // : IEquatable<SKLattice>
{
	int[] XDivs; //  { readonly get; set; }
	int[] YDivs; //  { readonly get; set; }
	SKLatticeRectType[] RectTypes; //  { readonly get; set; }
	Nullable!SKRectI  Bounds; //  { readonly get; set; }
	SKColor[] Colors; //  { readonly get; set; }

	// bool Equals (SKLattice obj) 
	// {
	// 	return
	// 	XDivs == obj.XDivs &&
	// 	YDivs == obj.YDivs &&
	// 	RectTypes == obj.RectTypes &&
	// 	Bounds == obj.Bounds &&
	// 	Colors == obj.Colors;
	// }

	// override bool Equals (object obj) =>
	// 	obj is SKLattice f && Equals (f);

	// static bool operator == (SKLattice left, SKLattice right) =>
	// 	left.Equals (right);

	// static bool operator != (SKLattice left, SKLattice right) =>
	// 	!left.Equals (right);

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (XDivs);
	// 	hash.Add (YDivs);
	// 	hash.Add (RectTypes);
	// 	hash.Add (Bounds);
	// 	hash.Add (Colors);
	// 	return hash.ToHashCode ();
	// }
}


/**
 * 
 */
struct SKDocumentPdfMetadata // : IEquatable<SKDocumentPdfMetadata>
{
	enum float DefaultRasterDpi = 72.0f;
	enum int DefaultEncodingQuality = 101;

	enum SKDocumentPdfMetadata Default = SKDocumentPdfMetadata (DefaultRasterDpi, false, DefaultEncodingQuality);

	private this(float rasterDpi, bool pdfA, int encodingQuality)
	{
		RasterDpi = rasterDpi;
		PdfA = pdfA;
		EncodingQuality = encodingQuality;
	}

	this(float rasterDpi)
	{
		Title = null;
		Author = null;
		Subject = null;
		Keywords = null;
		Creator = null;
		Producer = null;
		// Creation = null;
		// Modified = null;
		RasterDpi = rasterDpi;
		PdfA = false;
		EncodingQuality = DefaultEncodingQuality;
	}

	this(int encodingQuality)
	{
		Title = null;
		Author = null;
		Subject = null;
		Keywords = null;
		Creator = null;
		Producer = null;
		// Creation = null;
		// Modified = null;
		RasterDpi = DefaultRasterDpi;
		PdfA = false;
		EncodingQuality = encodingQuality;
	}

	this(float rasterDpi, int encodingQuality)
	{
		Title = null;
		Author = null;
		Subject = null;
		Keywords = null;
		Creator = null;
		Producer = null;
		// Creation = null;
		// Modified = null;
		RasterDpi = rasterDpi;
		PdfA = false;
		EncodingQuality = encodingQuality;
	}

	string Title; //  { readonly get; set; }
	string Author; //  { readonly get; set; }
	string Subject; //  { readonly get; set; }
	string Keywords; //  { readonly get; set; }
	string Creator; //  { readonly get; set; }
	string Producer; //  { readonly get; set; }
	Nullable!SysTime Creation; //  { readonly get; set; }
	Nullable!SysTime Modified; //  { readonly get; set; }
	float RasterDpi; //  { readonly get; set; }
	bool PdfA; //  { readonly get; set; }
	int EncodingQuality; //  { readonly get; set; }

	// const bool Equals (SKDocumentPdfMetadata obj) =>
	// 	Title == obj.Title &&
	// 	Author == obj.Author &&
	// 	Subject == obj.Subject &&
	// 	Keywords == obj.Keywords &&
	// 	Creator == obj.Creator &&
	// 	Producer == obj.Producer &&
	// 	Creation == obj.Creation &&
	// 	Modified == obj.Modified &&
	// 	RasterDpi == obj.RasterDpi &&
	// 	PdfA == obj.PdfA &&
	// 	EncodingQuality == obj.EncodingQuality;

	// const override bool Equals (object obj) =>
	// 	obj is SKDocumentPdfMetadata f && Equals (f);

	// static bool operator == (SKDocumentPdfMetadata left, SKDocumentPdfMetadata right) =>
	// 	left.Equals (right);

	// static bool operator != (SKDocumentPdfMetadata left, SKDocumentPdfMetadata right) =>
	// 	!left.Equals (right);

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (Title);
	// 	hash.Add (Author);
	// 	hash.Add (Subject);
	// 	hash.Add (Keywords);
	// 	hash.Add (Creator);
	// 	hash.Add (Producer);
	// 	hash.Add (Creation);
	// 	hash.Add (Modified);
	// 	hash.Add (RasterDpi);
	// 	hash.Add (PdfA);
	// 	hash.Add (EncodingQuality);
	// 	return hash.ToHashCode ();
	// }
}

enum SKColorSpaceFlags
{
	None = 0,
	NonLinearBlending = 0x1,
}


enum SKLatticeRectType {
	// DEFAULT_SK_LATTICE_RECT_TYPE = 0
	Default = 0,
	// TRANSPARENT_SK_LATTICE_RECT_TYPE = 1
	Transparent = 1,
	// FIXED_COLOR_SK_LATTICE_RECT_TYPE = 2
	FixedColor = 2,
}


enum SKPath1DPathEffectStyle {
	// TRANSLATE_SK_PATH_EFFECT_1D_STYLE = 0
	Translate = 0,
	// ROTATE_SK_PATH_EFFECT_1D_STYLE = 1
	Rotate = 1,
	// MORPH_SK_PATH_EFFECT_1D_STYLE = 2
	Morph = 2,
}

enum SKTrimPathEffectMode {
	// NORMAL_SK_PATH_EFFECT_TRIM_MODE = 0
	Normal = 0,
	// INVERTED_SK_PATH_EFFECT_TRIM_MODE = 1
	Inverted = 1,
}

/**
 * 
 */
struct SKImageInfoNative {
	// sk_colorspace_t* colorspace
	void* colorspace;

	// int32_t width
	int width;

	// int32_t height
	int height;

	// sk_colortype_t colorType
	SKColorTypeNative colorType;

	// sk_alphatype_t alphaType
	SKAlphaType alphaType;

	// const bool Equals (SKImageInfoNative obj) {
	// 	return colorspace == obj.colorspace && width == obj.width && height == obj.height && colorType == obj.colorType && alphaType == obj.alphaType
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKImageInfoNative f && Equals (f)
	// }

	// static bool operator == (SKImageInfoNative left, SKImageInfoNative right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKImageInfoNative left, SKImageInfoNative right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (colorspace);
	// 	hash.Add (width);
	// 	hash.Add (height);
	// 	hash.Add (colorType);
	// 	hash.Add (alphaType);
	// 	return hash.ToHashCode ();
	// }


  	// static void UpdateNative (ref SKImageInfo managed, ref SKImageInfoNative native)
	// {
	// 	SKColorSpace colorSpace = managed.ColorSpace;
	// 	if(colorSpace !is null && colorSpace.Handle() !is null) {
	// 		native.colorspace = cast(sk_colorspace_t*)colorSpace.Handle();
	// 	} else {
	// 		native.colorspace = null;
	// 	}

	// 	// native.colorspace = managed.ColorSpace?.Handle ?? null;
	// 	native.width = managed.Width;
	// 	native.height = managed.Height;
	// 	native.colorType = managed.ColorType.ToNative ();
	// 	native.alphaType = managed.AlphaType;
	// }

	// static SKImageInfoNative FromManaged (ref SKImageInfo managed)
	// {
	// 	SKImageInfoNative imageInfo;

	// 	SKColorSpace colorSpace = managed.ColorSpace;
	// 	if(colorSpace !is null && colorSpace.Handle() !is null) {
	// 		imageInfo.colorspace = cast(sk_colorspace_t*)colorSpace.Handle();
	// 	} else {
	// 		imageInfo.colorspace = null;
	// 	}
	// 	imageInfo.width = managed.Width;
	// 	imageInfo.height = managed.Height;
	// 	imageInfo.colorType = managed.ColorType.ToNative ();
	// 	imageInfo.alphaType = managed.AlphaType;

	// 	return imageInfo;
	// }

	// static SKImageInfo ToManaged (ref SKImageInfoNative native)
	// {
	// 	SKImageInfo imageInfo;

	// 	imageInfo.ColorSpace = SKColorSpace.GetObject (native.colorspace);
	// 	imageInfo.Width = native.width;
	// 	imageInfo.Height = native.height;
	// 	imageInfo.ColorType = native.colorType.FromNative ();
	// 	imageInfo.AlphaType = native.alphaType;

	// 	return imageInfo;
	// }

}