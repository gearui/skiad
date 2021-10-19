module skia.SKPaint;

import skia.SKObject;
import skia.SKFont;
import skia.SkiaApi;
import skia.SKColor;
import skia.SKColorF;
import skia.SKColorFilter;
import skia.SKShader;
import skia.SKMaskFilter;
import skia.SKColorSpace;
import skia.SKImageFilter;
import skia.SKTypeface;
import skia.Definitions;
import skia.SKPath;
import skia.MathTypes;
import skia.SKPathEffect;
import skia.SKTextBlob;
import skia.Exceptions;

import std.experimental.logger;

enum SKPaintHinting {
	NoHinting = 0,
	Slight = 1,
	Normal = 2,
	Full = 3,
}

class SKPaint : SKObject, ISKSkipObjectRegistration {
	private SKFont font;

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_compatpaint_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKPaint instance.");
		}
	}

	this(SKFont font) {
		this(null, true);

		if (font is null)
			throw new ArgumentNullException(font.stringof);

		Handle = SkiaApi.sk_compatpaint_new_with_font(cast(sk_font_t*) font.Handle);

		if (Handle is null)
			throw new InvalidOperationException("Unable to create a new SKPaint instance.");
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	override void Dispose() {
		return super.Dispose();
	}

	protected override void DisposeNative() {
		return SkiaApi.sk_compatpaint_delete(cast(sk_compatpaint_t*) Handle);
	}

	// Reset

	void Reset() {
		return SkiaApi.sk_compatpaint_reset(cast(sk_compatpaint_t*) Handle);
	}

	// properties

	bool IsAntialias() {
		return SkiaApi.sk_paint_is_antialias(cast(sk_paint_t*) Handle);
	}

	void IsAntialias(bool value) {
		SkiaApi.sk_paint_set_antialias(cast(sk_paint_t*) Handle, value);
	}

	bool IsDither() {
		return SkiaApi.sk_paint_is_dither(cast(sk_paint_t*) Handle);
	}

	void IsDither(bool value) {
		SkiaApi.sk_paint_set_dither(cast(sk_paint_t*) Handle, value);
	}

	bool IsVerticalText() {
		return false;
	}

	bool IsLinearText() {
		return GetFont().LinearMetrics;
	}

	void SubpixelText(bool value) {
		GetFont().Subpixel = value;
	}

	bool LcdRenderText() {
		return GetFont().Edging == SKFontEdging.SubpixelAntialias;
	}

	void LcdRenderText(bool value) {
		GetFont().Edging = value ? SKFontEdging.SubpixelAntialias : SKFontEdging.Antialias;
	}

	bool IsEmbeddedBitmapText() {
		return GetFont().EmbeddedBitmaps;
	}

	void IsEmbeddedBitmapText(bool value) {
		GetFont().EmbeddedBitmaps = value;
	}

	bool IsAutohinted() {
		return GetFont().ForceAutoHinting;
	}

	void IsAutohinted(bool value) {
		GetFont().ForceAutoHinting = value;
	}

	SKPaintHinting HintingLevel() {
		return cast(SKPaintHinting) GetFont().Hinting;
	}

	void HintingLevel(SKPaintHinting value) {
		GetFont().Hinting = cast(SKFontHinting) value;
	}

	bool FakeBoldText() {
		return GetFont().Embolden;
	}

	void FakeBoldText(bool value) {
		GetFont().Embolden = value;
	}

	bool DeviceKerningEnabled() {
		return false;
	}

	bool IsStroke() {
		return Style != SKPaintStyle.Fill;
	}

	void IsStroke(bool value) {
		Style = value ? SKPaintStyle.Stroke : SKPaintStyle.Fill;
	}

	SKPaintStyle Style() {
		return SkiaApi.sk_paint_get_style(cast(sk_paint_t*) Handle);
	}

	void Style(SKPaintStyle value) {
		SkiaApi.sk_paint_set_style(cast(sk_paint_t*) Handle, value);
	}

	SKColor Color() {
		return cast(SKColor) SkiaApi.sk_paint_get_color(cast(sk_paint_t*) Handle);
	}

	void Color(SKColor value) {
		SkiaApi.sk_paint_set_color(cast(sk_paint_t*) Handle, cast(uint) value);
	}

	SKColorF ColorF() {

		SKColorF color4f;
		SkiaApi.sk_paint_get_color4f(cast(sk_paint_t*) Handle, &color4f);
		return color4f;
	}

	void ColorF(SKColorF value) {

		SkiaApi.sk_paint_set_color4f(cast(sk_paint_t*) Handle, &value, null);
	}

	void SetColor(SKColorF color, SKColorSpace colorspace) {
		return SkiaApi.sk_paint_set_color4f(cast(sk_paint_t*) Handle, &color,
				cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null));
	}

	float StrokeWidth() {
		return SkiaApi.sk_paint_get_stroke_width(cast(sk_paint_t*) Handle);
	}

	void StrokeWidth(float value) {
		SkiaApi.sk_paint_set_stroke_width(cast(sk_paint_t*) Handle, value);
	}

	float StrokeMiter() {
		return SkiaApi.sk_paint_get_stroke_miter(cast(sk_paint_t*) Handle);
	}

	void StrokeMiter(float value) {
		SkiaApi.sk_paint_get_stroke_miter(cast(sk_paint_t*) Handle);
	}

	SKStrokeCap StrokeCap() {
		return SkiaApi.sk_paint_get_stroke_cap(cast(sk_paint_t*) Handle);
	}

	void StrokeCap(SKStrokeCap value) {
		SkiaApi.sk_paint_set_stroke_cap(cast(sk_paint_t*) Handle, value);
	}

	SKStrokeJoin StrokeJoin() {
		return SkiaApi.sk_paint_get_stroke_join(cast(sk_paint_t*) Handle);
	}

	void StrokeJoin(SKStrokeJoin value) {
		SkiaApi.sk_paint_set_stroke_join(cast(sk_paint_t*) Handle, value);
	}

	SKShader Shader() {
		return SKShader.GetObject(SkiaApi.sk_paint_get_shader(cast(sk_paint_t*) Handle));
	}

	void Shader(SKShader value) {
		SkiaApi.sk_paint_set_shader(cast(sk_paint_t*) Handle,
				cast(sk_shader_t*)(value is null ? null : value.Handle));
	}

	SKMaskFilter MaskFilter() {
		return SKMaskFilter.GetObject(SkiaApi.sk_paint_get_maskfilter(cast(sk_paint_t*) Handle));
	}

	void MaskFilter(SKMaskFilter value) {
		SkiaApi.sk_paint_set_maskfilter(cast(sk_paint_t*) Handle,
				cast(sk_maskfilter_t*)(value is null ? null : value.Handle));
	}

	SKColorFilter ColorFilter() {
		return SKColorFilter.GetObject(SkiaApi.sk_paint_get_colorfilter(cast(sk_paint_t*) Handle));
	}

	void ColorFilter(SKColorFilter value) {
		SkiaApi.sk_paint_set_colorfilter(cast(sk_paint_t*) Handle,
				cast(sk_colorfilter_t*)(value is null ? null : value.Handle));
	}

	SKImageFilter ImageFilter() {
		return SKImageFilter.GetObject(SkiaApi.sk_paint_get_imagefilter(cast(sk_paint_t*) Handle));
	}

	void ImageFilter(SKImageFilter value) {
		SkiaApi.sk_paint_set_imagefilter(cast(sk_paint_t*) Handle,
				cast(sk_imagefilter_t*)(value is null ? null : value.Handle));
	}

	SKBlendMode BlendMode() {
		return SkiaApi.sk_paint_get_blendmode(cast(sk_paint_t*) Handle);
	}

	void BlendMode(SKBlendMode value) {
		SkiaApi.sk_paint_set_blendmode(cast(sk_paint_t*) Handle, value);
	}

	SKFilterQuality FilterQuality() {
		return SkiaApi.sk_paint_get_filter_quality(cast(sk_paint_t*) Handle);
	}

	void FilterQuality(SKFilterQuality value) {
		SkiaApi.sk_paint_set_filter_quality(cast(sk_paint_t*) Handle, value);
	}

	SKTypeface Typeface() {
		return GetFont().Typeface;
	}

	void Typeface(SKTypeface value) {
		GetFont().Typeface = value;
	}

	float TextSize() {
		return GetFont().Size;
	}

	void TextSize(float value) {
		GetFont().Size = value;
	}

	SKTextAlign TextAlign() {
		return SkiaApi.sk_compatpaint_get_text_align(cast(sk_compatpaint_t*) Handle);

	}

	void TextAlign(SKTextAlign value) {
		SkiaApi.sk_compatpaint_set_text_align(cast(sk_compatpaint_t*) Handle, value);
	}

	SKTextEncoding TextEncoding() {
		return SkiaApi.sk_compatpaint_get_text_encoding(cast(sk_compatpaint_t*) Handle);
	}

	void TextEncoding(SKTextEncoding value) {

		SkiaApi.sk_compatpaint_set_text_encoding(cast(sk_compatpaint_t*) Handle, value);
	}

	float TextScaleX() {
		return GetFont().ScaleX;
	}

	void TextScaleX(float value) {
		GetFont().ScaleX = value;
	}

	float TextSkewX() {
		return GetFont().SkewX;
	}

	void TextSkewX(float value) {
		GetFont().SkewX = value;
	}

	SKPathEffect PathEffect() {
		return SKPathEffect.GetObject(SkiaApi.sk_paint_get_path_effect(cast(sk_paint_t*) Handle));
	}

	void PathEffect(SKPathEffect value) {
		SkiaApi.sk_paint_set_path_effect(cast(sk_paint_t*) Handle,
				cast(sk_path_effect_t*)(value is null ? null : value.Handle));
	}

	// FontSpacing

	float FontSpacing() {
		return GetFont().Spacing;
	}

	// FontMetrics

	SKFontMetrics FontMetrics() {
		return GetFont().Metrics;
	}

	float GetFontMetrics(out SKFontMetrics metrics) {
		return GetFont().GetFontMetrics(metrics);
	}

	float GetFontMetrics(out SKFontMetrics metrics, float scale) {
		return GetFontMetrics(metrics);
	}

	// Clone

	SKPaint Clone() {
		return GetObject(SkiaApi.sk_compatpaint_clone(cast(sk_compatpaint_t*) Handle));
	}

	// MeasureText

	float MeasureText(string text) {
		return GetFont().MeasureText(text, this);
	}

	// float MeasureText(const(char)[] text) {
	// 	return GetFont().MeasureText(text, this);
	// }

	float MeasureText(byte[] text) {
		return GetFont().MeasureText(text, TextEncoding, this);
	}

	float MeasureText(const(byte)[] text) {
		return GetFont().MeasureText(text, TextEncoding, this);
	}

	float MeasureText(void* buffer, int length) {
		return GetFont().MeasureText(buffer, length, TextEncoding, this);
	}

	float MeasureText(void* buffer, void* length) {
		return GetFont().MeasureText(buffer, cast(int) length, TextEncoding, this);
	}

	float MeasureText(string text, ref SKRect bounds) {
		return GetFont().MeasureText(text, bounds, this);
	}

	// float MeasureText(const(char)[] text, ref SKRect bounds) {
	// 	return GetFont().MeasureText(text, bounds, this);
	// }

	float MeasureText(byte[] text, ref SKRect bounds) {
		return GetFont().MeasureText(text, TextEncoding, bounds, this);
	}

	float MeasureText(const(byte)[] text, ref SKRect bounds) {
		return GetFont().MeasureText(text, TextEncoding, bounds, this);
	}

	float MeasureText(void* buffer, int length, ref SKRect bounds) {
		return GetFont().MeasureText(buffer, length, TextEncoding, bounds, this);
	}

	float MeasureText(void* buffer, void* length, ref SKRect bounds) {
		return GetFont().MeasureText(buffer, cast(int) length, TextEncoding, bounds, this);
	}

	// BreakText

	long BreakText(string text, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(text, maxWidth, measuredWidth, this);
	}

	long BreakText(string text, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(text, maxWidth, measuredWidth, this);
	}

	long BreakText(string text, float maxWidth, out float measuredWidth, out string measuredText) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto charsRead = GetFont().BreakText(text, maxWidth, measuredWidth, this);
		if (charsRead == 0) {
			measuredText = null;
			return 0;
		}
		if (charsRead == text.length) {
			measuredText = text;
			return text.length;
		}
		measuredText = text[0 .. charsRead];
		return charsRead;
	}

	long BreakText(const(char)[] text, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(text, maxWidth, measuredWidth, this);
	}

	long BreakText(const(char)[] text, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(text, maxWidth, measuredWidth, this);
	}

	long BreakText(byte[] text, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(text, TextEncoding, maxWidth, measuredWidth, this);
	}

	long BreakText(byte[] text, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(text, TextEncoding, maxWidth, measuredWidth, this);

	}

	long BreakText(const(byte)[] text, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(text, TextEncoding, maxWidth, measuredWidth, this);
	}

	long BreakText(const(byte)[] text, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(text, TextEncoding, maxWidth, measuredWidth, this);
	}

	long BreakText(void* buffer, int length, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(buffer, length, TextEncoding, maxWidth, measuredWidth, this);
	}

	long BreakText(void* buffer, int length, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(buffer, length, TextEncoding, maxWidth, measuredWidth, this);
	}

	long BreakText(void* buffer, void* length, float maxWidth) {
		float measuredWidth;
		return GetFont().BreakText(buffer, cast(int) length, TextEncoding,
				maxWidth, measuredWidth, this);
	}

	long BreakText(void* buffer, void* length, float maxWidth, out float measuredWidth) {
		return GetFont().BreakText(buffer, cast(int) length, TextEncoding,
				maxWidth, measuredWidth, this);
	}

	// GetTextPath

	SKPath GetTextPath(string text, float x, float y) {
		return GetFont().GetTextPath(text, SKPoint(x, y));
	}

	SKPath GetTextPath(const(char)[] text, float x, float y) {
		return GetFont().GetTextPath(text, SKPoint(x, y));
	}

	SKPath GetTextPath(byte[] text, float x, float y) {
		return GetFont().GetTextPath(text, TextEncoding, SKPoint(x, y));
	}

	SKPath GetTextPath(const(byte)[] text, float x, float y) {
		return GetFont().GetTextPath(text, TextEncoding, SKPoint(x, y));
	}

	SKPath GetTextPath(void* buffer, int length, float x, float y) {
		return GetFont().GetTextPath(buffer, length, TextEncoding, SKPoint(x, y));

	}

	SKPath GetTextPath(void* buffer, void* length, float x, float y) {
		return GetFont().GetTextPath(buffer, cast(int) length, TextEncoding, SKPoint(x, y));
	}

	SKPath GetTextPath(string text, SKPoint[] points) {
		return GetFont().GetTextPath(text, points);
	}

	SKPath GetTextPath(const(char)[] text, const(SKPoint)[] points) {
		return GetFont().GetTextPath(text, points);
	}

	SKPath GetTextPath(byte[] text, SKPoint[] points) {
		return GetFont().GetTextPath(text, TextEncoding, points);
	}

	SKPath GetTextPath(const(byte)[] text, const(SKPoint)[] points) {
		return GetFont().GetTextPath(text, TextEncoding, points);
	}

	SKPath GetTextPath(void* buffer, int length, SKPoint[] points) {
		return GetFont().GetTextPath(buffer, length, TextEncoding, points);
	}

	SKPath GetTextPath(void* buffer, int length, const(SKPoint)[] points) {
		return GetFont().GetTextPath(buffer, length, TextEncoding, points);
	}

	SKPath GetTextPath(void* buffer, void* length, SKPoint[] points) {
		return GetFont().GetTextPath(buffer, cast(int) length, TextEncoding, points);
	}

	// GetFillPath

	SKPath GetFillPath(SKPath src) {
		return GetFillPath(src, 1f);
	}

	SKPath GetFillPath(SKPath src, float resScale) {
		auto dst = new SKPath();

		if (GetFillPath(src, dst, resScale)) {
			return dst;
		} else {
			dst.Dispose();
			return null;
		}
	}

	SKPath GetFillPath(SKPath src, SKRect cullRect) {
		return GetFillPath(src, cullRect, 1f);
	}

	SKPath GetFillPath(SKPath src, SKRect cullRect, float resScale) {
		auto dst = new SKPath();

		if (GetFillPath(src, dst, cullRect, resScale)) {
			return dst;
		} else {
			dst.Dispose();
			return null;
		}
	}

	bool GetFillPath(SKPath src, SKPath dst) {
		return GetFillPath(src, dst, 1f);
	}

	bool GetFillPath(SKPath src, SKPath dst, float resScale) {
		if (src is null)
			throw new ArgumentNullException(src.stringof);
		if (dst is null)
			throw new ArgumentNullException(dst.stringof);

		return SkiaApi.sk_paint_get_fill_path(cast(sk_paint_t*) Handle,
				cast(sk_path_t*) src.Handle, cast(sk_path_t*) dst.Handle, null, resScale);
	}

	bool GetFillPath(SKPath src, SKPath dst, SKRect cullRect) {
		return GetFillPath(src, dst, cullRect, 1f);
	}

	bool GetFillPath(SKPath src, SKPath dst, SKRect cullRect, float resScale) {
		if (src is null)
			throw new ArgumentNullException(src.stringof);
		if (dst is null)
			throw new ArgumentNullException(dst.stringof);

		return SkiaApi.sk_paint_get_fill_path(cast(sk_paint_t*) Handle,
				cast(sk_path_t*) src.Handle, cast(sk_path_t*) dst.Handle, &cullRect, resScale);
	}

	// CountGlyphs

	int CountGlyphs(string text) {
		return GetFont().CountGlyphs(text);
	}

	int CountGlyphs(const(char)[] text) {
		return GetFont().CountGlyphs(text);
	}

	int CountGlyphs(byte[] text) {
		return GetFont().CountGlyphs(text, TextEncoding);
	}

	int CountGlyphs(const(byte)[] text) {
		return GetFont().CountGlyphs(text, TextEncoding);
	}

	int CountGlyphs(void* text, int length) {
		return GetFont().CountGlyphs(text, length, TextEncoding);
	}

	// GetGlyphs

	ushort[] GetGlyphs(string text) {
		return GetFont().GetGlyphs(text);
	}

	ushort[] GetGlyphs(const(char)[] text) {
		return GetFont().GetGlyphs(text);
	}

	ushort[] GetGlyphs(byte[] text) {
		return GetFont().GetGlyphs(text, TextEncoding);
	}

	ushort[] GetGlyphs(const(byte)[] text) {
		return GetFont().GetGlyphs(text, TextEncoding);
	}

	ushort[] GetGlyphs(void* text, int length) {
		return GetFont().GetGlyphs(text, length, TextEncoding);
	}

	// ContainsGlyphs

	bool ContainsGlyphs(string text) {
		return GetFont().ContainsGlyphs(text);
	}

	bool ContainsGlyphs(const(char)[] text) {
		return GetFont().ContainsGlyphs(text);
	}

	bool ContainsGlyphs(byte[] text) {
		return GetFont().ContainsGlyphs(text, TextEncoding);
	}

	bool ContainsGlyphs(const(byte)[] text) {
		return GetFont().ContainsGlyphs(text, TextEncoding);
	}

	bool ContainsGlyphs(void* text, int length) {
		return GetFont().ContainsGlyphs(text, length, TextEncoding);
	}

	bool ContainsGlyphs(void* text, void* length) {
		return GetFont().ContainsGlyphs(text, cast(int) length, TextEncoding);
	}

	// GetGlyphPositions

	SKPoint[] GetGlyphPositions(string text, SKPoint origin = SKPoint.Empty) {
		return GetFont().GetGlyphPositions(text, origin);
	}

	SKPoint[] GetGlyphPositions(const(char)[] text, SKPoint origin = SKPoint.Empty) {
		return GetFont().GetGlyphPositions(text, origin);
	}

	SKPoint[] GetGlyphPositions(const(byte)[] text, SKPoint origin = SKPoint.Empty) {
		return GetFont().GetGlyphPositions(text, TextEncoding, origin);
	}

	SKPoint[] GetGlyphPositions(void* text, int length, SKPoint origin = SKPoint.Empty) {
		return GetFont().GetGlyphPositions(text, length, TextEncoding, origin);
	}

	// GetGlyphOffsets

	float[] GetGlyphOffsets(string text, float origin = 0f) {
		return GetFont().GetGlyphOffsets(text, origin);
	}

	float[] GetGlyphOffsets(const(char)[] text, float origin = 0f) {
		return GetFont().GetGlyphOffsets(text, origin);
	}

	float[] GetGlyphOffsets(byte[] text, float origin = 0f) {
		return GetFont().GetGlyphOffsets(text, TextEncoding, origin);
	}

	float[] GetGlyphOffsets(void* text, int length, float origin = 0f) {
		return GetFont().GetGlyphOffsets(text, length, TextEncoding, origin);
	}

	// GetGlyphWidths

	float[] GetGlyphWidths(string text) {
		return GetFont().GetGlyphWidths(text, this);
	}

	float[] GetGlyphWidths(char[] text) {
		return GetFont().GetGlyphWidths(text, this);
	}

	float[] GetGlyphWidths(byte[] text) {
		return GetFont().GetGlyphWidths(text, TextEncoding, this);
	}

	float[] GetGlyphWidths(void* text, int length) {
		return GetFont().GetGlyphWidths(text, length, TextEncoding, this);
	}

	float[] GetGlyphWidths(string text, out SKRect[] bounds) {
		return GetFont().GetGlyphWidths(text, bounds, this);
	}

	float[] GetGlyphWidths(char[] text, out SKRect[] bounds) {
		return GetFont().GetGlyphWidths(text, bounds, this);
	}

	float[] GetGlyphWidths(byte[] text, out SKRect[] bounds) {
		return GetFont().GetGlyphWidths(text, TextEncoding, bounds, this);
	}

	float[] GetGlyphWidths(void* text, int length, out SKRect[] bounds) {
		return GetFont().GetGlyphWidths(text, length, TextEncoding, bounds, this);
	}

	// GetTextIntercepts

	float[] GetTextIntercepts(string text, float x, float y, float upperBounds, float lowerBounds) {
		return GetTextIntercepts(cast(char[]) text, x, y, upperBounds, lowerBounds);
	}

	float[] GetTextIntercepts(char[] text, float x, float y, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.Create(cast(byte[]) text, SKTextEncoding.Utf8,
				GetFont(), SKPoint(x, y));
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetTextIntercepts(byte[] text, float x, float y, float upperBounds, float lowerBounds) {
		return GetTextIntercepts(cast(const(byte)[]) text, x, y, upperBounds, lowerBounds);
	}

	float[] GetTextIntercepts(const(byte)[] text, float x, float y,
			float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.Create(text, TextEncoding, GetFont(), SKPoint(x, y));
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetTextIntercepts(void* text, void* length, float x, float y,
			float upperBounds, float lowerBounds) {
		return GetTextIntercepts(text, cast(int) length, x, y, upperBounds, lowerBounds);
	}

	float[] GetTextIntercepts(void* text, int length, float x, float y,
			float upperBounds, float lowerBounds) {
		if (text is null && length != 0)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.Create(text, length, TextEncoding, GetFont(), SKPoint(x, y));
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	// GetTextIntercepts (SKTextBlob)

	float[] GetTextIntercepts(SKTextBlob text, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		return text.GetIntercepts(upperBounds, lowerBounds, this);
	}

	// GetPositionedTextIntercepts

	float[] GetPositionedTextIntercepts(string text, SKPoint[] positions,
			float upperBounds, float lowerBounds) {
		return GetPositionedTextIntercepts(cast(const(char)[]) text, positions,
				upperBounds, lowerBounds);
	}

	float[] GetPositionedTextIntercepts(const(char)[] text,
			const(SKPoint)[] positions, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreatePositioned(text, GetFont(), positions);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetPositionedTextIntercepts(byte[] text, SKPoint[] positions,
			float upperBounds, float lowerBounds) {
		return GetPositionedTextIntercepts(cast(const(byte)[]) text, positions,
				upperBounds, lowerBounds);
	}

	float[] GetPositionedTextIntercepts(const(byte)[] text,
			const(SKPoint)[] positions, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreatePositioned(text, TextEncoding, GetFont(), positions);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetPositionedTextIntercepts(void* text, int length,
			SKPoint[] positions, float upperBounds, float lowerBounds) {
		return GetPositionedTextIntercepts(text, cast(void*) length, positions,
				upperBounds, lowerBounds);
	}

	float[] GetPositionedTextIntercepts(void* text, void* length,
			SKPoint[] positions, float upperBounds, float lowerBounds) {
		if (text is null && length !is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreatePositioned(text, cast(int) length,
				TextEncoding, GetFont(), positions);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	// GetHorizontalTextIntercepts

	float[] GetHorizontalTextIntercepts(string text, float[] xpositions, float y,
			float upperBounds, float lowerBounds) {
		return GetHorizontalTextIntercepts(cast(const(char)[]) text, xpositions,
				y, upperBounds, lowerBounds);
	}

	float[] GetHorizontalTextIntercepts(const(char)[] text,
			const(float)[] xpositions, float y, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreateHorizontal(text, GetFont(), xpositions, y);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetHorizontalTextIntercepts(byte[] text, float[] xpositions, float y,
			float upperBounds, float lowerBounds) {
		return GetHorizontalTextIntercepts(cast(const(byte)[]) text, xpositions,
				y, upperBounds, lowerBounds);
	}

	float[] GetHorizontalTextIntercepts(const(byte)[] text,
			const(float)[] xpositions, float y, float upperBounds, float lowerBounds) {
		if (text is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreateHorizontal(text, TextEncoding, GetFont(), xpositions, y);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	float[] GetHorizontalTextIntercepts(void* text, int length,
			float[] xpositions, float y, float upperBounds, float lowerBounds) {
		return GetHorizontalTextIntercepts(text, cast(void*) length,
				xpositions, y, upperBounds, lowerBounds);
	}

	float[] GetHorizontalTextIntercepts(void* text, void* length,
			float[] xpositions, float y, float upperBounds, float lowerBounds) {
		if (text is null && length !is null)
			throw new ArgumentNullException(text.stringof);

		auto blob = SKTextBlob.CreateHorizontal(text, cast(int) length,
				TextEncoding, GetFont(), xpositions, y);
		scope (exit) {
			blob.Dispose();
		}

		return blob.GetIntercepts(upperBounds, lowerBounds, this);
	}

	// Font

	SKFont ToFont() {
		return SKFont.GetObject(SkiaApi.sk_compatpaint_make_font(cast(sk_compatpaint_t*) Handle));
	}

	SKFont GetFont() {
		if(font is null) {
			sk_font_t* fontPtr = SkiaApi.sk_compatpaint_get_font(
					cast(sk_compatpaint_t*) Handle);
			SKFont skFont = SKFont.GetObject(fontPtr, false);
			font = OwnedBy(skFont, this);
		}

		return font;
		// return font ? font : OwnedBy(SKFont.GetObject(SkiaApi.sk_compatpaint_get_font(
		// 		cast(sk_compatpaint_t*) Handle), false), this);
	}

	//

	static SKPaint GetObject(void* handle) {
		return handle is null ? null : new SKPaint(handle, true);
	}

}
