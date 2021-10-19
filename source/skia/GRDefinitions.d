module skia.GRDefinitions;

import skia.Definitions;
import skia.EnumMappings;
import skia.Exceptions;
import skia.MathTypes;
import skia.SkiaApi;

alias GRBackendObject = void*;

// struct GRBackendRenderTargetDesc : IEquatable<GRBackendRenderTargetDesc>
struct GRBackendRenderTargetDesc {
	// int Width { get; set; }
	// int Height { get; set; }
	// GRPixelConfig Config { get; set; }
	// GRSurfaceOrigin Origin { get; set; }
	// int SampleCount { get; set; }
	// int StencilBits { get; set; }
	// GRBackendObject RenderTargetHandle { get; set; }
	int Width;
	int Height;
	GRPixelConfig Config;
	GRSurfaceOrigin Origin;
	int SampleCount;
	int StencilBits;
	GRBackendObject RenderTargetHandle;

	const SKSizeI Size() {
		return SKSizeI(Width, Height);
	}

	const SKRectI Rect() {
		return SKRectI(0, 0, Width, Height);
	}

	// const bool Equals(GRBackendRenderTargetDesc obj) {
	// 	return Width == obj.Width && Height == obj.Height && Config == obj.Config
	// 		&& Origin == obj.Origin && SampleCount == obj.SampleCount
	// 		&& StencilBits == obj.StencilBits && RenderTargetHandle == obj.RenderTargetHandle;
	// }

	// const override bool Equals (object obj)
	// {
	//   return obj is GRBackendRenderTargetDesc f && Equals (f);
	// }

	// static bool operator == (GRBackendRenderTargetDesc left, GRBackendRenderTargetDesc right)
	// {
	//   return left.Equals (right);
	// }

	// static bool operator != (GRBackendRenderTargetDesc left, GRBackendRenderTargetDesc right)
	// {
	//   return !left.Equals (right);
	// }

	// const override int GetHashCode ()
	// {
	// 	auto hash = new HashCode ();
	// 	hash.Add (Width);
	// 	hash.Add (Height);
	// 	hash.Add (Config);
	// 	hash.Add (Origin);
	// 	hash.Add (SampleCount);
	// 	hash.Add (StencilBits);
	// 	hash.Add (RenderTargetHandle);
	// 	return hash.ToHashCode ();
	// }
}

enum GRGlBackendState : uint {
	None = 0,
	RenderTarget = 1 << 0,
	TextureBinding = 1 << 1,
	View = 1 << 2, // scissor and viewport
	Blend = 1 << 3,
	MSAAEnable = 1 << 4,
	Vertex = 1 << 5,
	Stencil = 1 << 6,
	PixelStore = 1 << 7,
	Program = 1 << 8,
	FixedFunction = 1 << 9,
	Misc = 1 << 10,
	PathRendering = 1 << 11,
	All = 0xffff
}

enum GRBackendState : uint {
	None = 0,
	All = 0xffffffff,
}

struct GRGlFramebufferInfo {
	// unsigned int fFBOID
	private uint fFBOID;
	uint FramebufferObjectId() {
		return fFBOID;
	}

	void FramebufferObjectId(uint value) {
		fFBOID = value;
	}

	// unsigned int fFormat
	private uint fFormat;
	uint Format() {
		return fFormat;
	}

	void Format(uint value) {
		fFormat = value;
	}

    // override bool opEquals(Object obj) {
    //     GRGlFramebufferInfo pp = cast(GRGlFramebufferInfo) obj;
    //     if (pp  is null)
    //         return false;
    //     return fFBOID == obj.fFBOID && fFormat == obj.fFormat;
    // }

    // override size_t toHash() @trusted nothrow {
    //     return hashOf(fFBOID) + hashOf(fFormat);
    // }

	this(uint fboId) {
		fFBOID = fboId;
		fFormat = 0;
	}

	this(uint fboId, uint format) {
		fFBOID = fboId;
		fFormat = format;
	}
}

struct GRGlTextureInfo {
	// unsigned int fTarget
	private uint fTarget;
	uint Target() {
		return fTarget;
	}

	void Target(uint value) {
		fTarget = value;
	}

	// unsigned int fID
	private uint fID;
	uint Id() {
		return fID;
	}

	void Id(uint value) {
		fID = value;
	}

	// unsigned int fFormat
	private uint fFormat;
	uint Format() {
		return fFormat;
	}

	void Format(uint value) {
		fFormat = value;
	}

    // override bool opEquals(Object obj) {
    //     GRGlTextureInfo pp = cast(GRGlTextureInfo) obj;
    //     if (pp  is null)
    //         return false;
    //     return fTarget == obj.fTarget && fID == obj.fID && fFormat == obj.fFormat;
    // }

    // override size_t toHash() @trusted nothrow {
    //     return hashOf(fTarget) + hashOf(fID) + hashOf(fFormat);
    // }

	this(uint target, uint id) {
		fTarget = target;
		fID = id;
		fFormat = 0;
	}

	this(uint target, uint id, uint format) {
		fTarget = target;
		fID = id;
		fFormat = format;
	}
}

enum GRBackendTextureDescFlags {
	None = 0,
	RenderTarget = 1,
}

struct GRBackendTextureDesc // : IEquatable<GRBackendTextureDesc>
{
	GRBackendTextureDescFlags Flags; // { get; set; }
	GRSurfaceOrigin Origin; // { get; set; }
	int Width; // { get; set; }
	int Height; // { get; set; }
	GRPixelConfig Config; // { get; set; }
	int SampleCount; //{ get; set; }
	GRBackendObject TextureHandle; // { get; set; }

	const SKSizeI Size() {
		return SKSizeI(Width, Height);
	}

	const SKRectI Rect() {
		return SKRectI(0, 0, Width, Height);
	}

	// const bool Equals (GRBackendTextureDesc obj) =>
	// 	Flags == obj.Flags &&
	// 	Origin == obj.Origin &&
	// 	Width == obj.Width &&
	// 	Height == obj.Height &&
	// 	Config == obj.Config &&
	// 	SampleCount == obj.SampleCount &&
	// 	TextureHandle == obj.TextureHandle;

	// const override bool Equals (object obj) =>
	// 	obj is GRBackendTextureDesc f && Equals (f);

	// static bool operator == (GRBackendTextureDesc left, GRBackendTextureDesc right) =>
	// 	left.Equals (right);

	// static bool operator != (GRBackendTextureDesc left, GRBackendTextureDesc right) =>
	// 	!left.Equals (right);

	// const override int GetHashCode ()
	// {
	// 	auto hash == new HashCode ();
	// 	hash.Add (Flags);
	// 	hash.Add (Origin);
	// 	hash.Add (Width);
	// 	hash.Add (Height);
	// 	hash.Add (Config);
	// 	hash.Add (SampleCount);
	// 	hash.Add (TextureHandle);
	// 	return hash.ToHashCode ();
	// }
}


// struct GRGlBackendTextureDesc : IEquatable<GRGlBackendTextureDesc>
struct GRGlBackendTextureDesc {
	// GRBackendTextureDescFlags Flags { get; set; }
	// GRSurfaceOrigin Origin { get; set; }
	// int Width { get; set; }
	// int Height { get; set; }
	// GRPixelConfig Config { get; set; }
	// int SampleCount { get; set; }
	// GRGlTextureInfo TextureHandle { get; set; }
	GRBackendTextureDescFlags Flags; //{ get; set; }
	GRSurfaceOrigin Origin; //{ get; set; }
	int Width; // { get; set; }
	int Height; // { get; set; }
	GRPixelConfig Config; // { get; set; }
	int SampleCount; // { get; set; }
	GRGlTextureInfo TextureHandle; //{ get; set; }

	const SKSizeI Size() {
		return SKSizeI(Width, Height);
	}

	const SKRectI Rect() {
		return SKRectI(0, 0, Width, Height);
	}

	const bool Equals(GRGlBackendTextureDesc obj) {
		return Flags == obj.Flags && Origin == obj.Origin && Width == obj.Width
			&& Height == obj.Height && Config == obj.Config
			&& SampleCount == obj.SampleCount && TextureHandle == obj.TextureHandle;
	}

	// const override bool Equals (object obj)
	// {
	//   return 	obj is GRGlBackendTextureDesc f && Equals (f);
	// }

	// static bool operator == (GRGlBackendTextureDesc left, GRGlBackendTextureDesc right)
	// {
	//   return 	left.Equals (right);
	// }

	// static bool operator != (GRGlBackendTextureDesc left, GRGlBackendTextureDesc right)
	// {
	//   return !left.Equals (right);
	// }

	// const override int GetHashCode() {
	// 	auto hash = new HashCode();
	// 	hash.Add(Flags);
	// 	hash.Add(Origin);
	// 	hash.Add(Width);
	// 	hash.Add(Height);
	// 	hash.Add(Config);
	// 	hash.Add(SampleCount);
	// 	hash.Add(TextureHandle);
	// 	return hash.ToHashCode();
	// }
}



alias ToGlSizedFormat = SkiaExtensions.ToGlSizedFormat;
alias ToColorType = SkiaExtensions.ToColorType;

class SkiaExtensions {
	// static uint ToGlSizedFormat (this SKColorType colorType)
	static uint ToGlSizedFormat(SKColorType colorType) {
		switch (colorType) {
		case SKColorType.Unknown:
			return 0;
		case SKColorType.Alpha8:
			return GRGlSizedFormat.ALPHA8;
		case SKColorType.Gray8:
			return GRGlSizedFormat.LUMINANCE8;
		case SKColorType.Rgb565:
			return GRGlSizedFormat.RGB565;
		case SKColorType.Argb4444:
			return GRGlSizedFormat.RGBA4;
		case SKColorType.Rgba8888:
			return GRGlSizedFormat.RGBA8;
		case SKColorType.Rgb888x:
			return GRGlSizedFormat.RGB8;
		case SKColorType.Bgra8888:
			return GRGlSizedFormat.BGRA8;
		case SKColorType.Rgba1010102:
			return GRGlSizedFormat.RGB10_A2;
		case SKColorType.AlphaF16:
			return GRGlSizedFormat.R16F;
		case SKColorType.RgbaF16:
			return GRGlSizedFormat.RGBA16F;
		case SKColorType.RgbaF16Clamped:
			return GRGlSizedFormat.RGBA16F;
		case SKColorType.Alpha16:
			return GRGlSizedFormat.R16;
		case SKColorType.Rg1616:
			return GRGlSizedFormat.RG16;
		case SKColorType.Rgba16161616:
			return GRGlSizedFormat.RGBA16;
		case SKColorType.RgF16:
			return GRGlSizedFormat.RG16F;
		case SKColorType.Rg88:
			return GRGlSizedFormat.RG8;
		case SKColorType.Rgb101010x:
			return 0;
		case SKColorType.RgbaF32:
			return 0;
		default:
			throw new ArgumentOutOfRangeException(colorType.stringof);
		}
	}

	// static uint ToGlSizedFormat (this GRPixelConfig config)
	static uint ToGlSizedFormat(GRPixelConfig config) {
		switch (config) {
		case GRPixelConfig.Unknown:
			return 0;
		case GRPixelConfig.Alpha8:
			return GRGlSizedFormat.ALPHA8;
		case GRPixelConfig.Alpha8AsAlpha:
			return GRGlSizedFormat.ALPHA8;
		case GRPixelConfig.Alpha8AsRed:
			return GRGlSizedFormat.ALPHA8;
		case GRPixelConfig.Gray8:
			return GRGlSizedFormat.LUMINANCE8;
		case GRPixelConfig.Gray8AsLum:
			return GRGlSizedFormat.LUMINANCE8;
		case GRPixelConfig.Gray8AsRed:
			return GRGlSizedFormat.LUMINANCE8;
		case GRPixelConfig.Rgb565:
			return GRGlSizedFormat.RGB565;
		case GRPixelConfig.Rgba4444:
			return GRGlSizedFormat.RGBA4;
		case GRPixelConfig.Rgba8888:
			return GRGlSizedFormat.RGBA8;
		case GRPixelConfig.Rgb888:
			return GRGlSizedFormat.RGB8;
		case GRPixelConfig.Rgb888x:
			return GRGlSizedFormat.RGBA8;
		case GRPixelConfig.Rg88:
			return GRGlSizedFormat.RG8;
		case GRPixelConfig.Bgra8888:
			return GRGlSizedFormat.BGRA8;
		case GRPixelConfig.Srgba8888:
			return GRGlSizedFormat.SRGB8_ALPHA8;
		case GRPixelConfig.Rgba1010102:
			return GRGlSizedFormat.RGB10_A2;
		case GRPixelConfig.AlphaHalf:
			return GRGlSizedFormat.R16F;
		case GRPixelConfig.AlphaHalfAsLum:
			return GRGlSizedFormat.LUMINANCE16F;
		case GRPixelConfig.AlphaHalfAsRed:
			return GRGlSizedFormat.R16F;
		case GRPixelConfig.RgbaHalf:
			return GRGlSizedFormat.RGBA16F;
		case GRPixelConfig.RgbaHalfClamped:
			return GRGlSizedFormat.RGBA16F;
		case GRPixelConfig.RgbEtc1:
			return GRGlSizedFormat.COMPRESSED_ETC1_RGB8;
		case GRPixelConfig.Alpha16:
			return GRGlSizedFormat.R16;
		case GRPixelConfig.Rg1616:
			return GRGlSizedFormat.RG16;
		case GRPixelConfig.Rgba16161616:
			return GRGlSizedFormat.RGBA16;
		case GRPixelConfig.RgHalf:
			return GRGlSizedFormat.RG16F;
		default:
			throw new ArgumentOutOfRangeException(config.stringof);
		}
	}

	// static GRPixelConfig ToPixelConfig (this SKColorType colorType)
	static GRPixelConfig ToPixelConfig(SKColorType colorType) {
		switch (colorType) {
		case SKColorType.Unknown:
			return GRPixelConfig.Unknown;
		case SKColorType.Alpha8:
			return GRPixelConfig.Alpha8;
		case SKColorType.Gray8:
			return GRPixelConfig.Gray8;
		case SKColorType.Rgb565:
			return GRPixelConfig.Rgb565;
		case SKColorType.Argb4444:
			return GRPixelConfig.Rgba4444;
		case SKColorType.Rgba8888:
			return GRPixelConfig.Rgba8888;
		case SKColorType.Rgb888x:
			return GRPixelConfig.Rgb888;
		case SKColorType.Bgra8888:
			return GRPixelConfig.Bgra8888;
		case SKColorType.Rgba1010102:
			return GRPixelConfig.Rgba1010102;
		case SKColorType.AlphaF16:
			return GRPixelConfig.AlphaHalf;
		case SKColorType.RgbaF16:
			return GRPixelConfig.RgbaHalf;
		case SKColorType.RgbaF16Clamped:
			return GRPixelConfig.RgbaHalfClamped;
		case SKColorType.Alpha16:
			return GRPixelConfig.Alpha16;
		case SKColorType.Rg1616:
			return GRPixelConfig.Rg1616;
		case SKColorType.Rgba16161616:
			return GRPixelConfig.Rgba16161616;
		case SKColorType.RgF16:
			return GRPixelConfig.RgHalf;
		case SKColorType.Rg88:
			return GRPixelConfig.Rg88;
		case SKColorType.Rgb101010x:
			return GRPixelConfig.Unknown;
		case SKColorType.RgbaF32:
			return GRPixelConfig.Unknown;
		default:
			throw new ArgumentOutOfRangeException(colorType.stringof);
		}
	}

	// static SKColorType ToColorType (this GRPixelConfig config)
	static SKColorType ToColorType(GRPixelConfig config) {
		switch (config) {
		case GRPixelConfig.Unknown:
			return SKColorType.Unknown;
		case GRPixelConfig.Alpha8:
			return SKColorType.Alpha8;
		case GRPixelConfig.Gray8:
			return SKColorType.Gray8;
		case GRPixelConfig.Rgb565:
			return SKColorType.Rgb565;
		case GRPixelConfig.Rgba4444:
			return SKColorType.Argb4444;
		case GRPixelConfig.Rgba8888:
			return SKColorType.Rgba8888;
		case GRPixelConfig.Rgb888:
			return SKColorType.Rgb888x;
		case GRPixelConfig.Bgra8888:
			return SKColorType.Bgra8888;
		case GRPixelConfig.Srgba8888:
			return SKColorType.Rgba8888;
		case GRPixelConfig.Rgba1010102:
			return SKColorType.Rgba1010102;
		case GRPixelConfig.AlphaHalf:
			return SKColorType.AlphaF16;
		case GRPixelConfig.RgbaHalf:
			return SKColorType.RgbaF16;
		case GRPixelConfig.Alpha8AsAlpha:
			return SKColorType.Alpha8;
		case GRPixelConfig.Alpha8AsRed:
			return SKColorType.Alpha8;
		case GRPixelConfig.AlphaHalfAsLum:
			return SKColorType.AlphaF16;
		case GRPixelConfig.AlphaHalfAsRed:
			return SKColorType.AlphaF16;
		case GRPixelConfig.Gray8AsLum:
			return SKColorType.Gray8;
		case GRPixelConfig.Gray8AsRed:
			return SKColorType.Gray8;
		case GRPixelConfig.RgbaHalfClamped:
			return SKColorType.RgbaF16Clamped;
		case GRPixelConfig.Alpha16:
			return SKColorType.Alpha16;
		case GRPixelConfig.Rg1616:
			return SKColorType.Rg1616;
		case GRPixelConfig.Rgba16161616:
			return SKColorType.Rgba16161616;
		case GRPixelConfig.RgHalf:
			return SKColorType.RgF16;
		case GRPixelConfig.Rg88:
			return SKColorType.Rg88;
		case GRPixelConfig.Rgb888x:
			return SKColorType.Rgb888x;
		case GRPixelConfig.RgbEtc1:
			return SKColorType.Rgb888x;
		default:
			throw new ArgumentOutOfRangeException(config.stringof);
		}
	}

}

struct GRGlSizedFormat {
	// Unsized formats
	enum STENCIL_INDEX = 0x1901;
	enum DEPTH_COMPONENT = 0x1902;
	enum DEPTH_STENCIL = 0x84F9;
	enum RED = 0x1903;
	enum RED_INTEGER = 0x8D94;
	enum GREEN = 0x1904;
	enum BLUE = 0x1905;
	enum ALPHA = 0x1906;
	enum LUMINANCE = 0x1909;
	enum LUMINANCE_ALPHA = 0x190A;
	enum RG_INTEGER = 0x8228;
	enum RGB = 0x1907;
	enum RGB_INTEGER = 0x8D98;
	enum SRGB = 0x8C40;
	enum RGBA = 0x1908;
	enum RG = 0x8227;
	enum SRGB_ALPHA = 0x8C42;
	enum RGBA_INTEGER = 0x8D99;
	enum BGRA = 0x80E1;

	// Stencil index sized formats
	enum STENCIL_INDEX4 = 0x8D47;
	enum STENCIL_INDEX8 = 0x8D48;
	enum STENCIL_INDEX16 = 0x8D49;

	// Depth component sized formats
	enum DEPTH_COMPONENT16 = 0x81A5;

	// Depth stencil sized formats
	enum DEPTH24_STENCIL8 = 0x88F0;

	// Red sized formats
	enum R8 = 0x8229;
	enum R16 = 0x822A;
	enum R16F = 0x822D;
	enum R32F = 0x822E;

	// Red integer sized formats
	enum R8I = 0x8231;
	enum R8UI = 0x8232;
	enum R16I = 0x8233;
	enum R16UI = 0x8234;
	enum R32I = 0x8235;
	enum R32UI = 0x8236;

	// Luminance sized formats
	enum LUMINANCE8 = 0x8040;
	enum LUMINANCE16F = 0x881E;

	// Alpha sized formats
	enum ALPHA8 = 0x803C;
	enum ALPHA16 = 0x803E;
	enum ALPHA16F = 0x881C;
	enum ALPHA32F = 0x8816;

	// Alpha integer sized formats
	enum ALPHA8I = 0x8D90;
	enum ALPHA8UI = 0x8D7E;
	enum ALPHA16I = 0x8D8A;
	enum ALPHA16UI = 0x8D78;
	enum ALPHA32I = 0x8D84;
	enum ALPHA32UI = 0x8D72;

	// RG sized formats
	enum RG8 = 0x822B;
	enum RG16 = 0x822C;
	//enum R16F = 0x822D;
	//enum R32F = 0x822E;
	enum RG16F = 0x822F;

	// RG sized integer formats
	enum RG8I = 0x8237;
	enum RG8UI = 0x8238;
	enum RG16I = 0x8239;
	enum RG16UI = 0x823A;
	enum RG32I = 0x823B;
	enum RG32UI = 0x823C;

	// RGB sized formats
	enum RGB5 = 0x8050;
	enum RGB565 = 0x8D62;
	enum RGB8 = 0x8051;
	enum SRGB8 = 0x8C41;

	// RGB integer sized formats
	enum RGB8I = 0x8D8F;
	enum RGB8UI = 0x8D7D;
	enum RGB16I = 0x8D89;
	enum RGB16UI = 0x8D77;
	enum RGB32I = 0x8D83;
	enum RGB32UI = 0x8D71;

	// RGBA sized formats
	enum RGBA4 = 0x8056;
	enum RGB5_A1 = 0x8057;
	enum RGBA8 = 0x8058;
	enum RGB10_A2 = 0x8059;
	enum SRGB8_ALPHA8 = 0x8C43;
	enum RGBA16F = 0x881A;
	enum RGBA32F = 0x8814;
	enum RG32F = 0x8230;
	enum RGBA16 = 0x805B;

	// RGBA integer sized formats
	enum RGBA8I = 0x8D8E;
	enum RGBA8UI = 0x8D7C;
	enum RGBA16I = 0x8D88;
	enum RGBA16UI = 0x8D76;
	enum RGBA32I = 0x8D82;
	enum RGBA32UI = 0x8D70;

	// BGRA sized formats
	enum BGRA8 = 0x93A1;

	// Compressed texture sized formats
	enum COMPRESSED_ETC1_RGB8 = 0x8D64;
}
