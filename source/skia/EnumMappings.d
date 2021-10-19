module skia.EnumMappings;

// import skia.SKColorTypeNative;
import skia.Definitions;
import skia.Exceptions;

enum GRBackend {
	Metal = 0,
	OpenGL = 1,
	Vulkan = 2,
	Dawn = 3,
}

enum GRPixelConfig {
	Unknown = 0,
	Alpha8 = 1,
	Gray8 = 2,
	Rgb565 = 3,
	Rgba4444 = 4,
	Rgba8888 = 5,
	Rgb888 = 6,
	Bgra8888 = 7,
	Srgba8888 = 8,

	Sbgra8888 = 9,
	Rgba1010102 = 10,

	RgbaFloat = 11,

	RgFloat = 12,
	AlphaHalf = 13,
	RgbaHalf = 14,
	Alpha8AsAlpha = 15,
	Alpha8AsRed = 16,
	AlphaHalfAsLum = 17,
	AlphaHalfAsRed = 18,
	Gray8AsLum = 19,
	Gray8AsRed = 20,
	RgbaHalfClamped = 21,
	Alpha16 = 22,
	Rg1616 = 23,
	Rgba16161616 = 24,
	RgHalf = 25,
	Rg88 = 26,
	Rgb888x = 27,
	RgbEtc1 = 28,
}


enum GRBackendNative {
	// METAL_GR_BACKEND = 0
	Metal = 0,
	// DAWN_GR_BACKEND = 1
	Dawn = 1,
	// OPENGL_GR_BACKEND = 2
	OpenGL = 2,
	// VULKAN_GR_BACKEND = 3
	Vulkan = 3,
}

alias ToNative = SkiaExtensions.ToNative;
alias FromNative = SkiaExtensions.FromNative;

class SkiaExtensions {
	static GRBackendNative ToNative(GRBackend backend) {
		switch (backend) {
		case GRBackend.Metal:
			return GRBackendNative.Metal;
		case GRBackend.OpenGL:
			return GRBackendNative.OpenGL;
		case GRBackend.Vulkan:
			return GRBackendNative.Vulkan;
		case GRBackend.Dawn:
			return GRBackendNative.Dawn;
		default:
			throw new ArgumentOutOfRangeException(backend.stringof);
		}
	}

	static GRBackend FromNative(GRBackendNative backend) {
		switch (backend) {
		case GRBackendNative.Metal:
			return GRBackend.Metal;
		case GRBackendNative.OpenGL:
			return GRBackend.OpenGL;
		case GRBackendNative.Vulkan:
			return GRBackend.Vulkan;
		case GRBackendNative.Dawn:
			return GRBackend.Dawn;
		default:
			throw new ArgumentOutOfRangeException(backend.stringof);
		}
	}

	static SKColorTypeNative ToNative(SKColorType colorType) {
		switch (colorType) {
		case SKColorType.Unknown:
			return SKColorTypeNative.Unknown;
		case SKColorType.Alpha8:
			return SKColorTypeNative.Alpha8;
		case SKColorType.Rgb565:
			return SKColorTypeNative.Rgb565;
		case SKColorType.Argb4444:
			return SKColorTypeNative.Argb4444;
		case SKColorType.Rgba8888:
			return SKColorTypeNative.Rgba8888;
		case SKColorType.Rgb888x:
			return SKColorTypeNative.Rgb888x;
		case SKColorType.Bgra8888:
			return SKColorTypeNative.Bgra8888;
		case SKColorType.Rgba1010102:
			return SKColorTypeNative.Rgba1010102;
		case SKColorType.Rgb101010x:
			return SKColorTypeNative.Rgb101010x;
		case SKColorType.Gray8:
			return SKColorTypeNative.Gray8;
		case SKColorType.RgbaF16Clamped:
			return SKColorTypeNative.RgbaF16Norm;
		case SKColorType.RgbaF16:
			return SKColorTypeNative.RgbaF16;
		case SKColorType.RgbaF32:
			return SKColorTypeNative.RgbaF32;
		case SKColorType.Rg88:
			return SKColorTypeNative.R8g8Unorm;
		case SKColorType.AlphaF16:
			return SKColorTypeNative.A16Float;
		case SKColorType.RgF16:
			return SKColorTypeNative.R16g16Float;
		case SKColorType.Alpha16:
			return SKColorTypeNative.A16Unorm;
		case SKColorType.Rg1616:
			return SKColorTypeNative.R16g16Unorm;
		case SKColorType.Rgba16161616:
			return SKColorTypeNative.R16g16b16a16Unorm;
		default:
			throw new ArgumentOutOfRangeException(colorType.stringof);
		}
	}

	static SKColorType FromNative(SKColorTypeNative colorType) {
		switch (colorType) {
		case SKColorTypeNative.Unknown:
			return SKColorType.Unknown;
		case SKColorTypeNative.Alpha8:
			return SKColorType.Alpha8;
		case SKColorTypeNative.Rgb565:
			return SKColorType.Rgb565;
		case SKColorTypeNative.Argb4444:
			return SKColorType.Argb4444;
		case SKColorTypeNative.Rgba8888:
			return SKColorType.Rgba8888;
		case SKColorTypeNative.Rgb888x:
			return SKColorType.Rgb888x;
		case SKColorTypeNative.Bgra8888:
			return SKColorType.Bgra8888;
		case SKColorTypeNative.Rgba1010102:
			return SKColorType.Rgba1010102;
		case SKColorTypeNative.Rgb101010x:
			return SKColorType.Rgb101010x;
		case SKColorTypeNative.Gray8:
			return SKColorType.Gray8;
		case SKColorTypeNative.RgbaF16Norm:
			return SKColorType.RgbaF16Clamped;
		case SKColorTypeNative.RgbaF16:
			return SKColorType.RgbaF16;
		case SKColorTypeNative.RgbaF32:
			return SKColorType.RgbaF32;
		case SKColorTypeNative.R8g8Unorm:
			return SKColorType.Rg88;
		case SKColorTypeNative.A16Float:
			return SKColorType.AlphaF16;
		case SKColorTypeNative.R16g16Float:
			return SKColorType.RgF16;
		case SKColorTypeNative.A16Unorm:
			return SKColorType.Alpha16;
		case SKColorTypeNative.R16g16Unorm:
			return SKColorType.Rg1616;
		case SKColorTypeNative.R16g16b16a16Unorm:
			return SKColorType.Rgba16161616;
		default:
			throw new ArgumentOutOfRangeException(colorType.stringof);
		}
	}

}
