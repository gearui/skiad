module skia.SKMaskFilter;

import skia.Definitions;
import skia.Exceptions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;

enum SKBlurMaskFilterFlags {
	None = 0x00,
	IgnoreTransform = 0x01,
	HighQuality = 0x02,
	All = IgnoreTransform | HighQuality,
}

// TODO: `getFormat`
// TODO: `computeFastBounds`

class SKMaskFilter : SKObject {
	private enum float BlurSigmaScale = 0.57735f;
	enum int TableMaxLength = 256;

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	static float ConvertRadiusToSigma(float radius) {
		return radius > 0 ? BlurSigmaScale * radius + 0.5f : 0.0f;
	}

	static float ConvertSigmaToRadius(float sigma) {
		return sigma > 0.5f ? (sigma - 0.5f) / BlurSigmaScale : 0.0f;
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma) {
		return GetObject(SkiaApi.sk_maskfilter_new_blur(blurStyle, sigma));
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma, bool respectCTM) {
		return GetObject(SkiaApi.sk_maskfilter_new_blur_with_flags(blurStyle, sigma, respectCTM));
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma, SKBlurMaskFilterFlags flags) {
		return CreateBlur(blurStyle, sigma, true);
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma, SKRect occluder) {
		return CreateBlur(blurStyle, sigma, true);
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma,
			SKRect occluder, SKBlurMaskFilterFlags flags) {
		return CreateBlur(blurStyle, sigma, true);
	}

	static SKMaskFilter CreateBlur(SKBlurStyle blurStyle, float sigma,
			SKRect occluder, bool respectCTM) {
		return CreateBlur(blurStyle, sigma, respectCTM);
	}

	static SKMaskFilter CreateTable(ubyte[] table) {
		if (table is null)
			throw new ArgumentNullException(table.stringof);
		if (table.length != TableMaxLength)
			throw new ArgumentException("Table must have a length of {SKColorTable.MaxLength}.",
					table.stringof);
		ubyte* t = table.ptr;
		return GetObject(SkiaApi.sk_maskfilter_new_table(t));
	}

	static SKMaskFilter CreateGamma(float gamma) {
		return GetObject(SkiaApi.sk_maskfilter_new_gamma(gamma));
	}

	static SKMaskFilter CreateClip(ubyte min, ubyte max) {
		return GetObject(SkiaApi.sk_maskfilter_new_clip(min, max));
	}

	static SKMaskFilter GetObject(void* handle) {
		return GetOrAddObject!(SKMaskFilter)(handle, (h, o) { return new SKMaskFilter(h, o); });
	}

}
