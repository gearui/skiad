module skia.SKFont;

import skia.SkiaApi;
import skia.SKPaint;
import skia.Definitions;
import skia.Exceptions;
import skia.MathTypes;
import skia.SKPath;
import skia.SKTypeface;
import skia.Dictionary;
import skia.SKObject;
import skia.IDisposable;
import std.range;
import skia.Exceptions;
import skia.SKMatrix;
import skia.SKPathMeasure;

import std.experimental.logger;
import std.algorithm;

/**
 * 
 */
class SKFont : SKObject {
	enum float DefaultSize = 12f;
	enum float DefaultScaleX = 1f;
	enum float DefaultSkewX = 0f;

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_font_new(), true);
		if (Handle is null)
			throw new InvalidOperationException("Unable to create a new SKFont instance.");
	}

	this(SKTypeface typeface, float size = DefaultSize,
			float scaleX = DefaultScaleX, float skewX = DefaultSkewX) {
		void* handle = null;
		if (typeface !is null)
			handle = typeface.Handle();
		this(SkiaApi.sk_font_new_with_values(cast(sk_typeface_t*) handle, size,
				scaleX, skewX), true);
		if (Handle is null)
			throw new InvalidOperationException("Unable to create a new SKFont instance.");
	}

	protected override void DisposeNative() {
		return SkiaApi.sk_font_delete(cast(sk_font_t*) Handle);
	}

	bool ForceAutoHinting() {
		return SkiaApi.sk_font_is_force_auto_hinting(cast(sk_font_t*) Handle);
	}

	void ForceAutoHinting(bool value) {
		SkiaApi.sk_font_set_force_auto_hinting(cast(sk_font_t*) Handle, value);
	}

	bool EmbeddedBitmaps() {
		return SkiaApi.sk_font_is_embedded_bitmaps(cast(sk_font_t*) Handle);
	}

	void EmbeddedBitmaps(bool value) {
		SkiaApi.sk_font_set_embedded_bitmaps(cast(sk_font_t*) Handle, value);
	}

	bool Subpixel() {
		return SkiaApi.sk_font_is_subpixel(cast(sk_font_t*) Handle);
	}

	void Subpixel(bool value) {
		SkiaApi.sk_font_set_subpixel(cast(sk_font_t*) Handle, value);
	}

	bool LinearMetrics() {
		return SkiaApi.sk_font_is_linear_metrics(cast(sk_font_t*) Handle);
	}

	void LinearMetrics(bool value) {
		SkiaApi.sk_font_set_linear_metrics(cast(sk_font_t*) Handle, value);
	}

	bool Embolden() {
		return SkiaApi.sk_font_is_embolden(cast(sk_font_t*) Handle);
	}

	void Embolden(bool value) {
		SkiaApi.sk_font_set_embolden(cast(sk_font_t*) Handle, value);
	}

	bool BaselineSnap() {
		return SkiaApi.sk_font_is_baseline_snap(cast(sk_font_t*) Handle);
	}

	void BaselineSnap(bool value) {
		SkiaApi.sk_font_set_baseline_snap(cast(sk_font_t*) Handle, value);
	}

	SKFontEdging Edging() {
		return SkiaApi.sk_font_get_edging(cast(sk_font_t*) Handle);
	}

	void Edging(SKFontEdging value) {
		SkiaApi.sk_font_set_edging(cast(sk_font_t*) Handle, value);
	}

	SKFontHinting Hinting() {
		return SkiaApi.sk_font_get_hinting(cast(sk_font_t*) Handle);
	}

	void Hinting(SKFontHinting value) {
		SkiaApi.sk_font_set_hinting(cast(sk_font_t*) Handle, value);
	}

	SKTypeface Typeface() {
		return SKTypeface.GetObject(SkiaApi.sk_font_get_typeface(cast(sk_font_t*) Handle));
	}

	void Typeface(SKTypeface value) {
		SkiaApi.sk_font_set_typeface(cast(sk_font_t*) Handle,
				cast(sk_typeface_t*)(value is null ? null : value.Handle));
	}

	float Size() {
		return SkiaApi.sk_font_get_size(cast(sk_font_t*) Handle);
	}

	void Size(float value) {
		SkiaApi.sk_font_set_size(cast(sk_font_t*) Handle, value);
	}

	float ScaleX() {
		return SkiaApi.sk_font_get_scale_x(cast(sk_font_t*) Handle);
	}

	void ScaleX(float value) {
		SkiaApi.sk_font_set_scale_x(cast(sk_font_t*) Handle, value);
	}

	float SkewX() {
		return SkiaApi.sk_font_get_skew_x(cast(sk_font_t*) Handle);
	}

	void SkewX(float value) {
		SkiaApi.sk_font_set_skew_x(cast(sk_font_t*) Handle, value);
	}

	// FontSpacing

	float Spacing() {
		return SkiaApi.sk_font_get_metrics(cast(sk_font_t*) Handle, null);
	}

	// FontMetrics

	SKFontMetrics Metrics() {

		SKFontMetrics metrics;
		GetFontMetrics(metrics);
		return metrics;

	}

	float GetFontMetrics(out SKFontMetrics metrics) {
		SKFontMetrics* m = &metrics;
		return SkiaApi.sk_font_get_metrics(cast(sk_font_t*) Handle, m);
	}

	// GetGlyph

	ushort GetGlyph(int codepoint) {
		return SkiaApi.sk_font_unichar_to_glyph(cast(sk_font_t*) Handle, codepoint);
	}

	// GetGlyphs

	ushort[] GetGlyphs(const(int)[] codepoints) {
		auto glyphs = new ushort[codepoints.length];
		GetGlyphs (codepoints, glyphs);
		return glyphs;
	}

	void GetGlyphs(const(int)[] codepoints, ushort[] glyphs) {
		if (codepoints.empty())
			return;

		if (glyphs.length != codepoints.length)
			throw new ArgumentException("The length of glyphs must be the same as the length of codepoints.",
					glyphs.stringof);

		int* up = cast(int*)codepoints.ptr;
		ushort* gp = glyphs.ptr;
		SkiaApi.sk_font_unichars_to_glyphs(cast(sk_font_t*) Handle, up,
				cast(int) codepoints.length, gp);
	}

	// GetGlyphs

	ushort[] GetGlyphs(string text) {
		return GetGlyphs(cast(const(char)[]) text);
	}

	ushort[] GetGlyphs(const(char)[] text) {
		void* t = cast(void*) text.ptr;
		return GetGlyphs(t, cast(int) text.length, SKTextEncoding.Utf8);
	}

	ushort[] GetGlyphs(const(byte)[] text, SKTextEncoding encoding) {
		void* t = cast(void*) text.ptr;
		return GetGlyphs(t, cast(int) text.length, encoding);
	}

	// ushort[] GetGlyphs (void* text, int length, SKTextEncoding encoding)
	// {
	//     return GetGlyphs (cast(void*)text, length, encoding);
	// }

	void GetGlyphs(string text, ushort[] glyphs) {
		return GetGlyphs(cast(const(char)[]) text, glyphs);
	}

	void GetGlyphs(const(char)[] text, ushort[] glyphs) {
		void* t = cast(void*) text.ptr;
		GetGlyphs(t, cast(int) text.length, SKTextEncoding.Utf8, glyphs);
	}

	void GetGlyphs(const(byte)[] text, SKTextEncoding encoding, ushort[] glyphs) {
		void* t = cast(void*) text.ptr;
		GetGlyphs(t, cast(int) text.length, encoding, glyphs);
	}

	// void GetGlyphs (void* text, int length, SKTextEncoding encoding, ushort[] glyphs)
	// {
	//     return GetGlyphs (cast(void*)text, length, encoding, glyphs);
	// }

	ushort[] GetGlyphs(void* text, int length, SKTextEncoding encoding) {
		if (!ValidateTextArgs(text, length, encoding))
			return new ushort[0];

		int n = CountGlyphs(text, length, encoding);
		tracef("n: %d, length: %d, encoding: %s", n, length, encoding);
		if (n <= 0)
			return [];

		auto glyphs = new ushort[n];
		GetGlyphs(text, length, encoding, glyphs);
		return glyphs;
	}

	void GetGlyphs(void* text, int length, SKTextEncoding encoding, ushort[] glyphs) {
		if (!ValidateTextArgs(text, length, encoding))
			return;

		ushort* gp = glyphs.ptr;
		SkiaApi.sk_font_text_to_glyphs(cast(sk_font_t*) Handle, text,
				cast(int) length, encoding, gp, cast(int) glyphs.length);
	}

	// ContainsGlyph

	bool ContainsGlyph(int codepoint) {
		return GetGlyph(codepoint) != 0;
	}

	// ContainsGlyphs

	bool ContainsGlyphs(const(int)[] codepoints) {
		return ContainsGlyphs(GetGlyphs(codepoints));
	}

	bool ContainsGlyphs(string text) {
		return ContainsGlyphs(GetGlyphs(text));
	}

	bool ContainsGlyphs(const(char)[] text) {
		return ContainsGlyphs(GetGlyphs(text));
	}

	bool ContainsGlyphs(const(byte)[] text, SKTextEncoding encoding) {
		return ContainsGlyphs(GetGlyphs(text, encoding));
	}

	bool ContainsGlyphs(void* text, int length, SKTextEncoding encoding) {
		return ContainsGlyphs(GetGlyphs(text, length, encoding));
	}

	private bool ContainsGlyphs(ushort[] glyphs) {
		// return Array.IndexOf (glyphs, cast(ushort)0) == -1;
		return false;
	}

	// CountGlyphs

	int CountGlyphs(string text) {
		return CountGlyphs(cast(const(char)[]) text);
	}

	int CountGlyphs(const(char)[] text) {
		void* t = cast(void*) text.ptr;
		return CountGlyphs(t, cast(int) text.length, SKTextEncoding.Utf8);
	}

	int CountGlyphs(const(byte)[] text, SKTextEncoding encoding) {
		void* t = cast(void*) text.ptr;
		return CountGlyphs(t, cast(int) text.length, encoding);
	}


	int CountGlyphs(void* text, int length, SKTextEncoding encoding) {
		if (!ValidateTextArgs(text, length, encoding))
			return 0;

		// int len = SkiaApi.sk_font_text_to_glyphs(cast(sk_font_t*) Handle, text,
		// 		cast(size_t) length, encoding, null, 0);

		// tracef("len: %d", len);
		// return len;

		return SkiaApi.sk_font_text_to_glyphs(cast(sk_font_t*) Handle, text,
				cast(size_t) length, encoding, null, 0);
	}

	// MeasureText (text)

	float MeasureText (string text, SKPaint paint = null)
	{
		void* t = cast(void*) text.ptr;
		return MeasureText(t, cast(int) text.length, SKTextEncoding.Utf8, null, paint);
	}

	// float MeasureText(const(char)[] text, SKPaint paint = null) {
	// 	void* t = cast(void*) text.ptr;
	// 	return MeasureText(t, cast(int) text.length, SKTextEncoding.Utf8, null, paint);
	// }

	float MeasureText(const(byte)[] text, SKTextEncoding encoding, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		return MeasureText(t, cast(int) text.length, encoding, null, paint);
	}

	float MeasureText(void* text, int length, SKTextEncoding encoding, SKPaint paint = null) {
		return MeasureText(cast(void*) text, length, encoding, null, paint);
	}

	float MeasureText(string text, out SKRect bounds, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		SKRect* b = &bounds;
		return MeasureText(t, cast(int) text.length, SKTextEncoding.Utf8, b, paint);
	}

	float MeasureText(const(byte)[] text, SKTextEncoding encoding,
			out SKRect bounds, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		SKRect* b = &bounds;
		return MeasureText(t, cast(int) text.length, encoding, b, paint);
	}

	float MeasureText(void* text, int length, SKTextEncoding encoding,
			out SKRect bounds, SKPaint paint = null) {
		SKRect* b = &bounds;
		return MeasureText(cast(void*) text, length, encoding, b, paint);
	}

	float MeasureText(void* text, int length, SKTextEncoding encoding,
			SKRect* bounds, SKPaint paint) {
		if (!ValidateTextArgs(text, length, encoding))
			return 0;

		float measuredWidth;
		void* paintHandle = null;
		if(paint !is null) {
			paintHandle = paint.Handle;
		}

		SkiaApi.sk_font_measure_text_no_return(cast(sk_font_t*) Handle, text,
				length, encoding, bounds, cast(sk_paint_t*)paintHandle, &measuredWidth);
		return measuredWidth;
	}

	// MeasureText (glyphs)

	float MeasureText(ushort[] glyphs, SKPaint paint = null) {
		ushort* gp = glyphs.ptr;
		return MeasureText(gp, cast(int) glyphs.length * 2, SKTextEncoding.GlyphId, null, paint);
	}

	float MeasureText(ushort[] glyphs, out SKRect bounds, SKPaint paint = null) {
		ushort* gp = glyphs.ptr;
		SKRect* b = &bounds;
		return MeasureText(gp, cast(int) glyphs.length * 2, SKTextEncoding.GlyphId, b, paint);
	}

	// BreakText

	int BreakText(string text, float maxWidth, out float measuredWidth, SKPaint paint = null) {
		return BreakText(cast(const(char)[]) text, maxWidth, measuredWidth, paint);
	}

	int BreakText(const(char)[] text, float maxWidth, out float measuredWidth, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		float* mw = &measuredWidth;
		{
			auto bytesRead = BreakText(t, cast(int) text.length,
					SKTextEncoding.Utf8, maxWidth, mw, paint);
			return bytesRead / 2;
		}
	}

	int BreakText(const(byte)[] text, SKTextEncoding encoding, float maxWidth,
			out float measuredWidth, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		float* mw = &measuredWidth;
		return BreakText(t, cast(int) text.length, encoding, maxWidth, mw, paint);
	}

	int BreakText(void* text, int length, SKTextEncoding encoding, float maxWidth,
			out float measuredWidth, SKPaint paint = null) {
		float* mw = &measuredWidth;
		return BreakText(cast(void*) text, length, encoding, maxWidth, mw, paint);
	}

	int BreakText(void* text, int length, SKTextEncoding encoding, float maxWidth,
			float* measuredWidth, SKPaint paint) {
		if (!ValidateTextArgs(text, length, encoding))
			return 0;

		return cast(int) SkiaApi.sk_font_break_text(cast(sk_font_t*) Handle, text,
				length, encoding, maxWidth, measuredWidth,
				cast(sk_paint_t*)(paint.Handle ? paint.Handle : null));
	}

	// GetGlyphPositions (text)

	SKPoint[] GetGlyphPositions(string text, SKPoint origin = SKPoint.Empty) {
		return GetGlyphPositions(cast(const(char)[]) text, origin);
	}

	SKPoint[] GetGlyphPositions(const(char)[] text, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		// return GetGlyphPositions(t, cast(int) text.length * 2, SKTextEncoding.Utf16, origin);
		return GetGlyphPositions(t, cast(int) text.length, SKTextEncoding.Utf8, origin);
	}

	SKPoint[] GetGlyphPositions(const(byte)[] text, SKTextEncoding encoding,
			SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return GetGlyphPositions(t, cast(int) text.length, encoding, origin);
	}

	// SKPoint[] GetGlyphPositions (void* text, int length, SKTextEncoding encoding, SKPoint origin = SKPoint.Empty)
	// {
	//     return GetGlyphPositions (cast(void*)text, length, encoding, origin);
	// }

	void GetGlyphPositions(string text, SKPoint[] offsets, SKPoint origin = SKPoint.Empty) {
		return GetGlyphPositions(cast(const(char)[]) text, offsets, origin);
	}

	void GetGlyphPositions(const(char)[] text, SKPoint[] offsets, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		// GetGlyphPositions(t, cast(int) text.length * 2, SKTextEncoding.Utf16, offsets, origin);
		GetGlyphPositions(t, cast(int) text.length, SKTextEncoding.Utf8, offsets, origin);
	}

	void GetGlyphPositions(const(byte)[] text, SKTextEncoding encoding,
			SKPoint[] offsets, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		GetGlyphPositions(t, cast(int) text.length, encoding, offsets, origin);
	}

	SKPoint[] GetGlyphPositions(void* text, int length, SKTextEncoding encoding, SKPoint origin) {
		if (!ValidateTextArgs (text, cast(int)length, encoding))
			return [];

		auto n = CountGlyphs (text, cast(int)length, encoding);
		if (n <= 0)
			return [];

		SKPoint[] positions = new SKPoint[n];
		GetGlyphPositions (text, length, encoding, positions, origin);
		return positions;
	}

	void GetGlyphPositions (void* text, int length, SKTextEncoding encoding, SKPoint[] offsets, SKPoint origin)
	{
		warning("TODO");

		if (!ValidateTextArgs (text, length, encoding))
			return;

		auto n = offsets.length;
		if (n <= 0)
			return;

		// auto glyphs =  Utils.RentArray<ushort> (n);
		// scope(exit) {
		//     glyphs.Dispose();
		// }

		// GetGlyphs (text, length, encoding, glyphs);
		// GetGlyphPositions (glyphs, offsets, origin);
	}

	// GetGlyphPositions (glyphs)

	SKPoint[] GetGlyphPositions(const(ushort)[] glyphs, SKPoint origin = SKPoint.Empty) {
		SKPoint[] positions = new SKPoint[glyphs.length];
		GetGlyphPositions (glyphs, positions, origin);
		return positions;
	}

	void GetGlyphPositions(const(ushort)[] glyphs, SKPoint[] positions, SKPoint origin = SKPoint.Empty) {
		if (glyphs.length != positions.length)
			throw new ArgumentException("The length of glyphs must be the same as the length of positions.",
					positions.stringof);

		ushort* gp = cast(ushort*)glyphs.ptr;
		SKPoint* pp = positions.ptr;
		SkiaApi.sk_font_get_pos(cast(sk_font_t*) Handle, gp, cast(int) glyphs.length, pp, &origin);
	}

	// GetGlyphOffsets (text)

	float[] GetGlyphOffsets(string text, float origin = 0f) {
		return GetGlyphOffsets(cast(const(char)[]) text, origin);
	}

	float[] GetGlyphOffsets(const(char)[] text, float origin = 0f) {
		void* t = cast(void*) text.ptr;
		return GetGlyphOffsets(t, cast(int) text.length, SKTextEncoding.Utf8, origin);
	}

	float[] GetGlyphOffsets(byte[] text, SKTextEncoding encoding, float origin = 0f) {
		void* t = text.ptr;
		return GetGlyphOffsets(t, cast(int) text.length, encoding, origin);
	}

	// float[] GetGlyphOffsets (void* text, int length, SKTextEncoding encoding, float origin = 0f)
	// {
	//     return GetGlyphOffsets (cast(void*)text, length, encoding, origin);
	// }

	void GetGlyphOffsets(string text, float[] offsets, float origin = 0f) {
		GetGlyphOffsets(cast(char[]) text, offsets, origin);
	}

	void GetGlyphOffsets(char[] text, float[] offsets, float origin = 0f) {
		void* t = text.ptr;
		GetGlyphOffsets(t, cast(int) text.length, SKTextEncoding.Utf8, offsets, origin);
	}

	void GetGlyphOffsets(byte[] text, SKTextEncoding encoding, float[] offsets, float origin = 0f) {
		void* t = text.ptr;
		GetGlyphOffsets(t, cast(int) text.length, encoding, offsets, origin);
	}

	void GetGlyphOffsets(void* text, int length, SKTextEncoding encoding,
			float[] offsets, float origin = 0f) {
		return GetGlyphOffsets(cast(void*) text, length, encoding, offsets, origin);
	}

	float[] GetGlyphOffsets(void* text, int length, SKTextEncoding encoding, float origin) {
		if (!ValidateTextArgs(text, length, encoding))
			return new float[0];

		auto n = CountGlyphs(text, length, encoding);
		if (n <= 0)
			return new float[0];

		auto offsets = new float[n];
		GetGlyphOffsets(text, length, encoding, offsets, origin);
		return offsets;
	}

	// void GetGlyphOffsets (void* text, int length, SKTextEncoding encoding, float[] offsets, float origin)
	// {
	// 	if (!ValidateTextArgs (text, length, encoding))
	// 		return;

	// 	auto n = offsets.length;
	// 	if (n <= 0)
	// 		return;

	// 	auto glyphs =  Utils.RentArray<ushort> (n);
	// 	scope(exit) {
	// 	    glyphs.Dispose();
	// 	}

	// 	GetGlyphs (text, length, encoding, glyphs);
	// 	GetGlyphOffsets (glyphs, offsets, origin);
	// }

	// GetGlyphOffsets (glyphs)

	float[] GetGlyphOffsets(ushort[] glyphs, float origin = 0f) {
		auto offsets = new float[glyphs.length];
		GetGlyphOffsets(glyphs, offsets, origin);
		return offsets;
	}

	void GetGlyphOffsets(ushort[] glyphs, float[] offsets, float origin = 0f) {
		if (glyphs.length != offsets.length)
			throw new ArgumentException("The length of glyphs must be the same as the length of offsets.",
					offsets.stringof);

		ushort* gp = glyphs.ptr;
		float* pp = offsets.ptr;
		SkiaApi.sk_font_get_xpos(cast(sk_font_t*) Handle, gp, cast(int) glyphs.length, pp, origin);
	}

	// GetGlyphWidths (text)

	float[] GetGlyphWidths(string text, SKPaint paint = null) {
		return GetGlyphWidths(cast(char[]) text, paint);
	}

	float[] GetGlyphWidths(char[] text, SKPaint paint = null) {
		void* t = text.ptr;
		return GetGlyphWidths(t, cast(int) text.length, SKTextEncoding.Utf8, paint);
	}

	float[] GetGlyphWidths(byte[] text, SKTextEncoding encoding, SKPaint paint = null) {
		void* t = text.ptr;
		return GetGlyphWidths(t, cast(int) text.length, encoding, paint);
	}

	// float[] GetGlyphWidths (void* text, int length, SKTextEncoding encoding, SKPaint paint = null)
	// {
	//     return GetGlyphWidths (cast(void*)text, length, encoding, paint);
	// }

	float[] GetGlyphWidths(string text, out SKRect[] bounds, SKPaint paint = null) {
		return GetGlyphWidths(cast(char[]) text, bounds, paint);
	}

	float[] GetGlyphWidths(char[] text, out SKRect[] bounds, SKPaint paint = null) {
		void* t = text.ptr;
		return GetGlyphWidths(t, cast(int) text.length, SKTextEncoding.Utf8, bounds, paint);
	}

	float[] GetGlyphWidths(byte[] text, SKTextEncoding encoding,
			out SKRect[] bounds, SKPaint paint = null) {
		void* t = text.ptr;
		return GetGlyphWidths(t, cast(int) text.length, encoding, bounds, paint);
	}

	// float[] GetGlyphWidths (void* text, int length, SKTextEncoding encoding, out SKRect[] bounds, SKPaint paint = null)
	// {
	//     return GetGlyphWidths (cast(void*)text, length, encoding,  bounds, paint);
	// }

	void GetGlyphWidths(string text, float[] widths, SKRect[] bounds, SKPaint paint = null) {
		return GetGlyphWidths(cast(char[]) text, widths, bounds, paint);
	}

	void GetGlyphWidths(const(char)[] text, float[] widths, SKRect[] bounds, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		GetGlyphWidths(t, cast(int) text.length, SKTextEncoding.Utf8, widths, bounds, paint);
	}

	void GetGlyphWidths(const(byte)[] text, SKTextEncoding encoding,
			float[] widths, SKRect[] bounds, SKPaint paint = null) {
		void* t = cast(void*) text.ptr;
		GetGlyphWidths(t, cast(int) text.length, encoding, widths, bounds, paint);
	}

	// void GetGlyphWidths (void* text, int length, SKTextEncoding encoding, float[] widths, SKRect[] bounds, SKPaint paint = null)
	// {
	//     return GetGlyphWidths (cast(void*)text, length, encoding, widths, bounds, paint);
	// }

	float[] GetGlyphWidths(void* text, int length, SKTextEncoding encoding, SKPaint paint) {
		if (!ValidateTextArgs(text, length, encoding))
			return new float[0];

		auto n = CountGlyphs(text, length, encoding);
		if (n <= 0)
			return new float[0];

		auto widths = new float[n];
		GetGlyphWidths(text, length, encoding, widths, null, paint);
		return widths;
	}

	float[] GetGlyphWidths(void* text, int length, SKTextEncoding encoding,
			out SKRect[] bounds, SKPaint paint) {
		if (!ValidateTextArgs(text, length, encoding)) {
			bounds = new SKRect[0];
			return new float[0];
		}

		auto n = CountGlyphs(text, length, encoding);
		if (n <= 0) {
			bounds = new SKRect[0];
			return new float[0];
		}

		bounds = new SKRect[n];
		auto widths = new float[n];
		GetGlyphWidths(text, length, encoding, widths, bounds, paint);
		return widths;
	}

	void GetGlyphWidths(void* text, int length, SKTextEncoding encoding,
			float[] widths, SKRect[] bounds, SKPaint paint) {

		warning("TODO");
		if (!ValidateTextArgs (text, length, encoding))
			return;

		auto n = max(widths.length, bounds.length);
		if (n <= 0)
			return;

		// // make sure that the destination spans are either empty/null or the same length
		// if (widths.length != 0 && widths.length != n)
		// 	throw new ArgumentException ("The length of widths must be equal to the length of bounds or empty.", widths.stringof);
		// if (bounds.length != 0 && bounds.length != n)
		// 	throw new ArgumentException ("The length of bounds must be equal to the length of widths or empty.", bounds.stringof);

		// auto glyphs =  Utils.RentArray<ushort> (n);
		// scope(exit) {
		//     glyphs.Dispose();
		// }

		// GetGlyphs (text, length, encoding, glyphs);
		// GetGlyphWidths (glyphs, widths, bounds, paint);
	}

	// GetGlyphWidths (glyphs)

	float[] GetGlyphWidths(const(ushort)[] glyphs, SKPaint paint = null) {
		auto widths = new float[glyphs.length];
		GetGlyphWidths(glyphs, widths, null, paint);
		return widths;
	}

	float[] GetGlyphWidths(const(ushort)[] glyphs, out SKRect[] bounds, SKPaint paint = null) {
		auto widths = new float[glyphs.length];
		bounds = new SKRect[glyphs.length];
		GetGlyphWidths(glyphs, widths, bounds, paint);
		return widths;
	}

	void GetGlyphWidths(const(ushort)[] glyphs, float[] widths, SKRect[] bounds, SKPaint paint = null) {
		ushort* gp = cast(ushort*) glyphs;
		float* wp = widths.ptr;
		SKRect* bp = bounds.ptr;
		{
			auto w = widths.length > 0 ? wp : null;
			auto b = bounds.length > 0 ? bp : null;
			SkiaApi.sk_font_get_widths_bounds(cast(sk_font_t*) Handle, gp,
					cast(int) glyphs.length, w, b,
					cast(sk_paint_t*)(paint.Handle ? paint.Handle : null));
		}
	}

	// GetGlyphPath

	SKPath GetGlyphPath(ushort glyph) {
		auto path = new SKPath();
		if (!SkiaApi.sk_font_get_path(cast(sk_font_t*) Handle, glyph,
				cast(sk_path_t*) path.Handle)) {
			path.Dispose();
			path = null;
		}
		return path;
	}

	// GetTextPath (text)

	SKPath GetTextPath(string text, SKPoint origin = SKPoint.Empty) {
		return GetTextPath(cast(const(char)[]) text, origin);
	}

	SKPath GetTextPath(const(char)[] text, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return GetTextPath(t, cast(int) text.length, SKTextEncoding.Utf8, origin);
	}

	SKPath GetTextPath(const(byte)[] text, SKTextEncoding encoding, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return GetTextPath(t, cast(int) text.length, encoding, origin);
	}

	SKPath GetTextPath(void* text, int length, SKTextEncoding encoding, SKPoint origin) {
		auto path = new SKPath();
		if (!ValidateTextArgs(text, length, encoding))
			return path;

		SkiaApi.sk_text_utils_get_path(text, length, encoding,
				origin.X, origin.Y, cast(sk_font_t*) Handle, cast(sk_path_t*) path.Handle);
		return path;
	}

	// GetTextPath (positioned)

	SKPath GetTextPath(string text, const(SKPoint)[] positions) {
		return GetTextPath(cast(const(char)[]) text, positions);
	}

	SKPath GetTextPath(const(char)[] text, const(SKPoint)[] positions) {
		void* t = cast(void*) text.ptr;
		return GetTextPath(t, cast(int) text.length, SKTextEncoding.Utf8, positions);
	}

	SKPath GetTextPath(const(byte)[] text, SKTextEncoding encoding, const(SKPoint)[] positions) {
		void* t = cast(void*) text.ptr;
		return GetTextPath(t, cast(int) text.length, encoding, positions);
	}

	// SKPath GetTextPath (void* text, int length, SKTextEncoding encoding, const(SKPoint)[] positions)
	// {
	//     return GetTextPath (cast(void*)text, length, encoding, positions);
	// }

	SKPath GetTextPath(void* text, int length, SKTextEncoding encoding, const(SKPoint)[] positions) {
		if (!ValidateTextArgs(text, length, encoding))
			return new SKPath();

		auto path = new SKPath();
		SKPoint* p = cast(SKPoint*) positions;
		SkiaApi.sk_text_utils_get_pos_path(text, length, encoding,
				p, cast(sk_font_t*) Handle, cast(sk_path_t*) path.Handle);
		return path;
	}

	// GetGlyphPaths

	// void GetGlyphPaths (const(ushort)[] glyphs, SKGlyphPathDelegate glyphPathDelegate)
	// {
	// 	auto proxy = DelegateProxies.Create (glyphPathDelegate, DelegateProxies.SKGlyphPathDelegateProxy, out var gch, out var ctx);
	// 	try {
	// 		ushort* g = glyphs;
	// 		SkiaApi.sk_font_get_paths (Handle, g, glyphs.length, proxy, cast(void*)ctx);
	// 	} finally {
	// 		gch.Free ();
	// 	}
	// }

	// GetTextPathOnPath (text)

	SKPath GetTextPathOnPath(string text, SKPath path,
			SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		return GetTextPathOnPath(cast(const(char)[]) text, path, textAlign, origin);
	}

	SKPath GetTextPathOnPath(const(char)[] text, SKPath path,
			SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return GetTextPathOnPath(t, cast(int) text.length,
				SKTextEncoding.Utf8, path, textAlign, origin);
	}

	SKPath GetTextPathOnPath(const(byte)[] text, SKTextEncoding encoding, SKPath path,
			SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return GetTextPathOnPath(t, cast(int) text.length, encoding, path, textAlign, origin);
	}

	SKPath GetTextPathOnPath(void* text, int length, SKTextEncoding encoding,
			SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		return GetTextPathOnPath(cast(void*) text, length, encoding, path, textAlign, origin);
	}

	// SKPath GetTextPathOnPath (void* text, int length, SKTextEncoding encoding, SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty)
	// {
	// 	if (!ValidateTextArgs (text, length, encoding))
	// 		return new SKPath ();

	// 	auto n = CountGlyphs (text, length, encoding);
	// 	if (n <= 0)
	// 		return new SKPath ();

	// 	auto glyphs =  Utils.RentArray<ushort> (n);
	// 	scope(exit) {
	// 	    glyphs.Dispose();
	// 	}

	// 	GetGlyphs (text, length, encoding, glyphs);

	// 	return GetTextPathOnPath (glyphs, path, textAlign, origin);
	// }

	// GetTextPathOnPath (glyphs)

	// SKPath GetTextPathOnPath (const(ushort)[] glyphs, SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty)
	// {
	// 	if (path is null)
	// 		throw new ArgumentNullException (path.stringof);

	// 	if (glyphs.length == 0)
	// 		return new SKPath ();

	// 	auto glyphWidths =  Utils.RentArray<float> (glyphs.length);
	// 	scope(exit) {
	// 	    glyphWidths.Dispose();
	// 	}

	// 	auto glyphOffsets =  Utils.RentArray<SKPoint> (glyphs.length);
	// 	scope(exit) {
	// 	    glyphOffsets.Dispose();
	// 	}

	// 	GetGlyphWidths (glyphs, glyphWidths, SKRect[].Empty);
	// 	GetGlyphPositions (glyphs, glyphOffsets, origin);

	// 	return GetTextPathOnPath (glyphs, glyphWidths, glyphOffsets, path, textAlign);
	// }

	SKPath GetTextPathOnPath(const(ushort)[] glyphs, const(float)[] glyphWidths,
			SKPoint[] glyphPositions, SKPath path, SKTextAlign textAlign = SKTextAlign.Left) {
		if (glyphs.length != glyphWidths.length)
			throw new ArgumentException("The number of glyphs and glyph widths must be the same.");
		if (glyphs.length != glyphPositions.length)
			throw new ArgumentException("The number of glyphs and glyph offsets must be the same.");
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		if (glyphs.length == 0)
			return new SKPath();

		auto glyphPathCache = new GlyphPathCache(this);
		scope (exit) {
			glyphPathCache.Dispose();
		}

		auto pathMeasure = new SKPathMeasure(path);
		scope (exit) {
			pathMeasure.Dispose();
		}

		auto contourLength = pathMeasure.Length;

		auto textLength = glyphPositions[glyphs.length - 1].X + glyphWidths[glyphs.length - 1];
		auto alignment = cast(int) textAlign * 0.5f;
		auto startOffset = glyphPositions[0].X + (contourLength - textLength) * alignment;

		auto textPath = new SKPath();

		// TODO: deal with multiple contours?
		for (int index = 0; index < glyphPositions.length; index++) {
			auto glyphOffset = glyphPositions[index];
			auto gw = glyphWidths[index];
			auto x0 = startOffset + glyphOffset.X;
			auto x1 = x0 + gw;

			if (x1 >= 0 && x0 <= contourLength) {
				auto glyphId = glyphs[index];
				auto glyphPath = glyphPathCache.GetPath(glyphId);
				if (glyphPath !is null) {
					auto transformation = SKMatrix.CreateTranslation(x0, glyphOffset.Y);
					MorphPath(textPath, glyphPath, pathMeasure, transformation);
				}
			}
		}

		return textPath;
	}

	static void MorphPath(SKPath dst, SKPath src, SKPathMeasure meas, in SKMatrix matrix) {
		// TODO:
		// Need differentially more subdivisions when the follow-path is curvy. Not sure how to determine
		// that, but we need it. I guess a cheap answer is let the caller tell us, but that seems like a
		// cop-out. Another answer is to get Skia's Rob Johnson to figure it out.

		auto it = src.CreateIterator(false);
		scope (exit) {
			it.Dispose();
		}

		SKPathVerb verb;

		SKPoint[] srcP = new SKPoint[4];
		SKPoint[] dstP = new SKPoint[4];

		while ((verb = it.Next(srcP)) != SKPathVerb.Done) {
			switch (verb) {
			case SKPathVerb.Move:
				MorphPoints(dstP, srcP, 1, meas, matrix);
				dst.MoveTo(dstP[0]);
				break;
			case SKPathVerb.Line:
				// turn lines into quads to look bendy
				srcP[0].X = (srcP[0].X + srcP[1].X) * 0.5f;
				srcP[0].Y = (srcP[0].Y + srcP[1].Y) * 0.5f;
				MorphPoints(dstP, srcP, 2, meas, matrix);
				dst.QuadTo(dstP[0], dstP[1]);
				break;
			case SKPathVerb.Quad:
				MorphPoints(dstP, srcP[1 .. 1 + 2], 2, meas, matrix);
				dst.QuadTo(dstP[0], dstP[1]);
				break;
			case SKPathVerb.Conic:
				MorphPoints(dstP, srcP[1 .. 1 + 2], 2, meas, matrix);
				dst.ConicTo(dstP[0], dstP[1], it.ConicWeight());
				break;
			case SKPathVerb.Cubic:
				MorphPoints(dstP, srcP[1 .. 1 + 3], 3, meas, matrix);
				dst.CubicTo(dstP[0], dstP[1], dstP[2]);
				break;
			case SKPathVerb.Close:
				dst.Close();
				break;
			default:
				// Debug.Fail ("Unknown verb when iterating points in glyph path.");
				break;
			}
		}
	}

	static void MorphPoints(SKPoint[] dst, SKPoint[] src, int count,
			SKPathMeasure meas, in SKMatrix matrix) {
		for (int i = 0; i < count; i++) {
			SKPoint s = matrix.MapPoint(src[i].X, src[i].Y);
			SKPoint p;
			SKPoint t;
			if (!meas.GetPositionAndTangent(s.X, p, t)) {
				// set to 0 if the measure failed, so that we just set dst == pos
				t = SKPoint.Empty;
			}

			// y-offset the point in the direction of the normal vector on the path.
			dst[i] = SKPoint(p.X - t.Y * s.Y, p.Y + t.X * s.Y);
		}
	}

	// Utils

	private bool ValidateTextArgs(void* text, int length, SKTextEncoding encoding) {
		if (length == 0)
			return false;

		if (text is null)
			throw new ArgumentNullException(text.stringof);

		return true;
	}

	//

	static SKFont GetObject(void* handle, bool owns = true) {
		return GetOrAddObject!(SKFont)(handle, delegate SKFont(h, o) {
			return new SKFont(h, o);
		});
	}

}

//

class GlyphPathCache : Dictionary!(ushort, SKPath), IDisposable {
	SKFont font;

	SKFont Font() {
		return font;
	}

	this(SKFont font) {
		this.font = font;
	}

	SKPath GetPath(ushort glyph) {
		SKPath path;
		if (!TryGetValue(glyph, path)) {
			path = Font.GetGlyphPath(glyph);
			this[glyph] = path;
		}

		return path;
	}

	void Dispose() {
		foreach (SKPath path; Values) {
			if (path !is null)
				path.Dispose();
		}
		Clear();
	}
}
