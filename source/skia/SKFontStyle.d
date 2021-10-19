module skia.SKFontStyle;

import skia.SKObject;
import skia.Definitions;
import skia.SkiaApi;
import std.concurrency : initOnce;

class SKFontStyle : SKObject, ISKSkipObjectRegistration {
	// private static const SKFontStyle normal;
	// private static const SKFontStyle bold;
	// private static const SKFontStyle italic;
	// private static const SKFontStyle boldItalic;

	static SKFontStyle normal() {
		__gshared SKFontStyle inst;
		return initOnce!inst(new SKFontStyleStatic(SKFontStyleWeight.Normal,
				SKFontStyleWidth.Normal, SKFontStyleSlant.Upright));
	}

	static SKFontStyle bold() {
		__gshared SKFontStyle inst;
		return initOnce!inst(new SKFontStyleStatic(SKFontStyleWeight.Bold,
				SKFontStyleWidth.Normal, SKFontStyleSlant.Upright));
	}

	static SKFontStyle italic() {
		__gshared SKFontStyle inst;
		return initOnce!inst(new SKFontStyleStatic(SKFontStyleWeight.Normal,
				SKFontStyleWidth.Normal, SKFontStyleSlant.Italic));
	}

	static SKFontStyle boldItalic() {
		__gshared SKFontStyle inst;
		return initOnce!inst(new SKFontStyleStatic(SKFontStyleWeight.Bold,
				SKFontStyleWidth.Normal, SKFontStyleSlant.Italic));
	}

	// static SKFontStyle ()
	// {
	// 	normal = new SKFontStyleStatic (SKFontStyleWeight.Normal, SKFontStyleWidth.Normal, SKFontStyleSlant.Upright);
	// 	bold = new SKFontStyleStatic (SKFontStyleWeight.Bold, SKFontStyleWidth.Normal, SKFontStyleSlant.Upright);
	// 	italic = new SKFontStyleStatic (SKFontStyleWeight.Normal, SKFontStyleWidth.Normal, SKFontStyleSlant.Italic);
	// 	boldItalic = new SKFontStyleStatic (SKFontStyleWeight.Bold, SKFontStyleWidth.Normal, SKFontStyleSlant.Italic);
	// }

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SKFontStyleWeight.Normal, SKFontStyleWidth.Normal, SKFontStyleSlant.Upright);
	}

	this(SKFontStyleWeight weight, SKFontStyleWidth width, SKFontStyleSlant slant) {
		this(cast(int) weight, cast(int) width, slant);
	}

	this(int weight, int width, SKFontStyleSlant slant) {
		this(SkiaApi.sk_fontstyle_new(weight, width, slant), true);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	protected override void DisposeNative() {
		return SkiaApi.sk_fontstyle_delete(cast(sk_fontstyle_t*) Handle);
	}

	int Weight() {
		return SkiaApi.sk_fontstyle_get_weight(cast(sk_fontstyle_t*) Handle);
	}

	int Width() {
		return SkiaApi.sk_fontstyle_get_width(cast(sk_fontstyle_t*) Handle);
	}

	SKFontStyleSlant Slant() {
		return SkiaApi.sk_fontstyle_get_slant(cast(sk_fontstyle_t*) Handle);
	}

	static SKFontStyle Normal() {
		return normal;
	}

	static SKFontStyle Bold() {
		return bold;
	}

	static SKFontStyle Italic() {
		return italic;
	}

	static SKFontStyle BoldItalic() {
		return boldItalic;
	}

	//

	static SKFontStyle GetObject(void* handle) {
		return handle is null ? null : new SKFontStyle(handle, true);
	}

}

private final class SKFontStyleStatic : SKFontStyle {
	this(SKFontStyleWeight weight, SKFontStyleWidth width, SKFontStyleSlant slant) {
		super(weight, width, slant);
		IgnorePublicDispose = true;
	}
}
