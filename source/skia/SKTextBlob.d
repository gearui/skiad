module skia.SKTextBlob;

import skia.Exceptions;
import skia.SkiaApi;
import skia.SKObject;
import skia.Util;
import skia.SKFont;
import skia.Definitions;
import skia.MathTypes;
import skia.SKPath;
import skia.SKPaint;
import skia.SKRunBuffer;
import skia.SKPathMeasure;

import std.typecons;
import std.experimental.logger;

/**
 * 
 */
class SKTextBlob : SKObject, ISKNonVirtualReferenceCounted, ISKSkipObjectRegistration {
	this(void* x, bool owns) {
		super(x, owns);
	}

	void ReferenceNative() {
		return SkiaApi.sk_textblob_ref(cast(sk_textblob_t*) Handle);
	}

	void UnreferenceNative() {
		return SkiaApi.sk_textblob_unref(cast(sk_textblob_t*) Handle);
	}

	SKRect Bounds() {
		SKRect bounds;
		SkiaApi.sk_textblob_get_bounds(cast(sk_textblob_t*) Handle, &bounds);
		return bounds;
	}

	uint UniqueId() {
		return SkiaApi.sk_textblob_get_unique_id(cast(sk_textblob_t*) Handle);
	}

	// Create

	static SKTextBlob Create(string text, SKFont font, SKPoint origin = SKPoint.Empty) {
		return Create(cast(const(byte)[]) text, SKTextEncoding.Utf8, font, origin);
	}

	// static SKTextBlob Create (const(char)[] text, SKFont font, SKPoint origin = SKPoint.Empty)
	// {
	// 	void* t = text.ptr;
	// 	return Create (t, text.length * 2, SKTextEncoding.Utf16, font, origin);
	// }

	// static SKTextBlob Create (void* text, int length, SKTextEncoding encoding, SKFont font, SKPoint origin = SKPoint.Empty)
	// {
	// 	return Create (text.AsReadOnlySpan (length), encoding, font, origin);
	// }

	static SKTextBlob Create(const(byte)[] text, SKTextEncoding encoding,
			SKFont font, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return Create(t, cast(int) text.length, encoding, font, origin);
	}

	static SKTextBlob Create(void* text, int length, SKTextEncoding encoding,
			SKFont font, SKPoint origin = SKPoint.Empty) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto count = font.CountGlyphs(text, length, encoding);
		if (count <= 0)
			return null;

		SKTextBlobBuilder builder = new SKTextBlobBuilder();
		scope (exit) {
			builder.Dispose();
		}

		SKPositionedRunBuffer buffer = builder.AllocatePositionedRun(font, count);
		font.GetGlyphs(text, length, encoding, buffer.GetGlyphSpan());
		font.GetGlyphPositions(buffer.GetGlyphSpan(), buffer.GetPositionSpan(), origin);

		return builder.Build();
	}

	// CreateHorizontal

	static SKTextBlob CreateHorizontal(string text, SKFont font, const(float)[] positions, float y) {
		return CreateHorizontal(cast(const(char)[]) text, font, positions, y);
	}

	static SKTextBlob CreateHorizontal(const(char)[] text, SKFont font,
			const(float)[] positions, float y) {
		void* t = cast(void*) text.ptr;
		return CreateHorizontal(t, cast(int) text.length, SKTextEncoding.Utf8, font, positions, y);
	}

	// static SKTextBlob CreateHorizontal (void* text, int length, SKTextEncoding encoding, SKFont font, const(float)[] positions, float y)
	// {
	// 	return CreateHorizontal (text.AsReadOnlySpan (length), encoding, font, positions, y);
	// }

	static SKTextBlob CreateHorizontal(const(byte)[] text,
			SKTextEncoding encoding, SKFont font, const(float)[] positions, float y) {
		void* t = cast(void*) text.ptr;
		return CreateHorizontal(t, cast(int) text.length, encoding, font, positions, y);
	}

	static SKTextBlob CreateHorizontal(void* text, int length,
			SKTextEncoding encoding, SKFont font, const(float)[] positions, float y) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto count = font.CountGlyphs(text, length, encoding);
		if (count <= 0)
			return null;

		auto builder = new SKTextBlobBuilder();
		scope (exit) {
			builder.Dispose();
		}

		auto buffer = builder.AllocateHorizontalRun(font, count, y);
		font.GetGlyphs(text, length, encoding, buffer.GetGlyphSpan());
		// positions.CopyTo (buffer.GetPositionSpan ());
		return builder.Build();
	}

	// CreatePositioned

	static SKTextBlob CreatePositioned(string text, SKFont font, const(SKPoint)[] positions) {
		return CreatePositioned(cast(const(char)[]) text, font, positions);
	}

	static SKTextBlob CreatePositioned(const(char)[] text, SKFont font, const(SKPoint)[] positions) {
		void* t = cast(void*) text.ptr;
		return CreatePositioned(t, cast(int) text.length, SKTextEncoding.Utf8, font, positions);
	}

	// static SKTextBlob CreatePositioned (void* text, int length, SKTextEncoding encoding, SKFont font, const(SKPoint)[] positions)
	// {
	// 	return CreatePositioned (text.AsReadOnlySpan (length), encoding, font, positions);
	// }

	static SKTextBlob CreatePositioned(const(byte)[] text,
			SKTextEncoding encoding, SKFont font, const(SKPoint)[] positions) {
		void* t = cast(void*) text.ptr;
		return CreatePositioned(t, cast(int) text.length, encoding, font, positions);
	}

	static SKTextBlob CreatePositioned(void* text, int length,
			SKTextEncoding encoding, SKFont font, const(SKPoint)[] positions) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto count = font.CountGlyphs(text, length, encoding);
		if (count <= 0)
			return null;

		auto builder = new SKTextBlobBuilder();
		scope (exit) {
			builder.Dispose();
		}

		auto buffer = builder.AllocatePositionedRun(font, count);
		font.GetGlyphs(text, length, encoding, buffer.GetGlyphSpan());
		// positions.CopyTo (buffer.GetPositionSpan ());
		return builder.Build();
	}

	// CreateRotationScale

	static SKTextBlob CreateRotationScale(string text, SKFont font,
			const(SKRotationScaleMatrix)[] positions) {
		return CreateRotationScale(cast(const(char)[]) text, font, positions);
	}

	static SKTextBlob CreateRotationScale(const(char)[] text, SKFont font,
			const(SKRotationScaleMatrix)[] positions) {
		void* t = cast(void*) text.ptr;
		// return CreateRotationScale (t, cast(int)text.length * 2, SKTextEncoding.Utf16, font, positions);
		return CreateRotationScale(t, cast(int) text.length, SKTextEncoding.Utf8, font, positions);
	}

	// static SKTextBlob CreateRotationScale (void* text, int length, SKTextEncoding encoding, SKFont font, const(SKRotationScaleMatrix)[] positions)
	// {
	// 	return CreateRotationScale (text.AsReadOnlySpan (length), encoding, font, positions);
	// }

	static SKTextBlob CreateRotationScale(const(byte)[] text,
			SKTextEncoding encoding, SKFont font, const(SKRotationScaleMatrix)[] positions) {
		void* t = cast(void*) text.ptr;
		return CreateRotationScale(t, cast(int) text.length, encoding, font, positions);
	}

	static SKTextBlob CreateRotationScale(void* text, int length,
			SKTextEncoding encoding, SKFont font, const(SKRotationScaleMatrix)[] positions) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto count = font.CountGlyphs(text, length, encoding);
		if (count <= 0)
			return null;

		auto builder = new SKTextBlobBuilder();
		scope (exit) {
			builder.Dispose();
		}

		auto buffer = builder.AllocateRotationScaleRun(font, count);
		font.GetGlyphs(text, length, encoding, buffer.GetGlyphSpan());
		// positions.CopyTo (buffer.GetRotationScaleSpan ());
		return builder.Build();
	}

	// CreatePathPositioned

	static SKTextBlob CreatePathPositioned(string text, SKFont font, SKPath path,
			SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		return CreatePathPositioned(cast(const(char)[]) text, font, path, textAlign, origin);
	}

	static SKTextBlob CreatePathPositioned(const(char)[] text, SKFont font, SKPath path,
			SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return CreatePathPositioned(t, cast(int) text.length,
				SKTextEncoding.Utf8, font, path, textAlign, origin);
	}

	// static SKTextBlob CreatePathPositioned (void* text, int length, SKTextEncoding encoding, SKFont font, SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty)
	// {
	// 	return CreatePathPositioned (text.AsReadOnlySpan (length), encoding, font, path, textAlign, origin);
	// }

	static SKTextBlob CreatePathPositioned(const(byte)[] text, SKTextEncoding encoding, SKFont font,
			SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		void* t = cast(void*) text.ptr;
		return CreatePathPositioned(t, cast(int) text.length, encoding, font,
				path, textAlign, origin);
	}

	static SKTextBlob CreatePathPositioned(void* text, int length, SKTextEncoding encoding, SKFont font,
			SKPath path, SKTextAlign textAlign = SKTextAlign.Left, SKPoint origin = SKPoint.Empty) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto count = font.CountGlyphs(text, length, encoding);
		if (count <= 0)
			return null;

		// we use temporary arrays because we might only use part of the text
		// Utils.RentArray!(ushort) glyphs = Utils.RentArray!(ushort) (count);
		ushort[] glyphs = new ushort[count];
		// auto glyphWidths =  Utils.RentArray!(float) (glyphs.length);
		float[] glyphWidths = new float[glyphs.length];
		// scope(exit) {
		//     glyphWidths.Dispose();
		// }

		// auto glyphOffsets =  Utils.RentArray!SKPoint (glyphs.length);
		SKPoint[] glyphOffsets = new SKPoint[glyphs.length];
		// scope(exit) {
		//     glyphOffsets.Dispose();
		// }

		font.GetGlyphs(text, length, encoding, glyphs);
		font.GetGlyphWidths(glyphs, glyphWidths, null);
		font.GetGlyphPositions(glyphs, glyphOffsets, origin);

		auto builder = new SKTextBlobBuilder();
		scope (exit) {
			builder.Dispose();
		}

		builder.AddPathPositionedRun(glyphs, font, glyphWidths, glyphOffsets, path, textAlign);
		return builder.Build();
	}

	// GetIntercepts

	float[] GetIntercepts(float upperBounds, float lowerBounds, SKPaint paint = null) {
		int n = CountIntercepts(upperBounds, lowerBounds, paint);
		auto intervals = new float[n];
		GetIntercepts(upperBounds, lowerBounds, intervals, paint);
		return intervals;
	}

	void GetIntercepts(float upperBounds, float lowerBounds, float[] intervals, SKPaint paint = null) {
		auto bounds = new float[2];
		bounds[0] = upperBounds;
		bounds[1] = lowerBounds;
		float* i = intervals.ptr;
		void* handle = null;
		if (paint !is null && paint.Handle !is null) {
			handle = paint.Handle;
		}
		SkiaApi.sk_textblob_get_intercepts(cast(sk_textblob_t*) Handle,
				bounds.ptr, i, cast(sk_paint_t*) handle);
	}

	// CountIntercepts

	int CountIntercepts(float upperBounds, float lowerBounds, SKPaint paint = null) {
		auto bounds = new float[2];
		bounds[0] = upperBounds;
		bounds[1] = lowerBounds;
		void* handle = null;
		if (paint !is null && paint.Handle !is null) {
			handle = paint.Handle;
		}
		return SkiaApi.sk_textblob_get_intercepts(cast(sk_textblob_t*) Handle,
				bounds.ptr, null, cast(sk_paint_t*) handle);
	}

	//

	static SKTextBlob GetObject(void* handle) {
		return handle is null ? null : new SKTextBlob(handle, true);
	}
}

/**
 * 
 */
class SKTextBlobBuilder : SKObject, ISKSkipObjectRegistration {
	this(void* x, bool owns) {
		super(x, owns);
	}

	this() {
		this(SkiaApi.sk_textblob_builder_new(), true);
	}

	// protected override void Dispose(bool disposing) {
	// 	return super.Dispose(disposing);
	// }

	protected override void DisposeNative() {
		return SkiaApi.sk_textblob_builder_delete(cast(sk_textblob_builder_t*) Handle);
	}

	// override void Dispose() {
	// 	return super.Dispose();
	// }

	// Build

	SKTextBlob Build() {
		auto blob = SKTextBlob.GetObject(
				SkiaApi.sk_textblob_builder_make(cast(sk_textblob_builder_t*) Handle));
		// GC.KeepAlive (this);
		return blob;
	}

	// AddRun

	void AddRun(const(ushort)[] glyphs, SKFont font, SKPoint origin = SKPoint.Empty) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto buffer = AllocatePositionedRun(font, cast(int) glyphs.length);
		// glyphs.CopyTo (buffer.GetGlyphSpan ());
		font.GetGlyphPositions(buffer.GetGlyphSpan(), buffer.GetPositionSpan(), origin);
	}

	// AddHorizontalRun

	void AddHorizontalRun(const(ushort)[] glyphs, SKFont font, const(float)[] positions, float y) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto buffer = AllocateHorizontalRun(font, cast(int) glyphs.length, y);
		// glyphs.CopyTo (buffer.GetGlyphSpan ());
		// positions.CopyTo (buffer.GetPositionSpan ());
	}

	// AddPositionedRun

	void AddPositionedRun(const(ushort)[] glyphs, SKFont font, const(SKPoint)[] positions) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto buffer = AllocatePositionedRun(font, cast(int) glyphs.length);
		// glyphs.CopyTo (buffer.GetGlyphSpan ());
		// positions.CopyTo (buffer.GetPositionSpan ());
	}

	// AddRotationScaleRun 

	void AddRotationScaleRun(const(ushort)[] glyphs, SKFont font,
			const(SKRotationScaleMatrix)[] positions) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		auto buffer = AllocateRotationScaleRun(font, cast(int) glyphs.length);
		// glyphs.CopyTo (buffer.GetGlyphSpan ());
		// positions.CopyTo (buffer.GetRotationScaleSpan ());
	}

	// AddPathPositionedRun

	void AddPathPositionedRun(const(ushort)[] glyphs, SKFont font, const(float)[] glyphWidths,
			SKPoint[] glyphOffsets, SKPath path, SKTextAlign textAlign = SKTextAlign.Left) {
		auto pathMeasure = new SKPathMeasure(path);
		scope (exit) {
			pathMeasure.Dispose();
		}

		auto contourLength = pathMeasure.Length();

		auto textLength = glyphOffsets[glyphs.length - 1].X + glyphWidths[glyphs.length - 1];
		auto alignment = cast(int) textAlign * 0.5f;
		auto startOffset = glyphOffsets[0].X + (contourLength - textLength) * alignment;

		auto firstGlyphIndex = 0;
		auto pathGlyphCount = 0;

		// auto glyphTransforms =  Utils.RentArray<SKRotationScaleMatrix> (glyphs.length);
		// scope(exit) {
		//     glyphTransforms.Dispose();
		// }
		SKRotationScaleMatrix[] glyphTransforms = new SKRotationScaleMatrix[glyphs.length];

		// TODO: deal with multiple contours?
		for (int index = 0; index < glyphOffsets.length; index++) {
			auto glyphOffset = glyphOffsets[index];
			auto halfWidth = glyphWidths[index] * 0.5f;
			auto pathOffset = startOffset + glyphOffset.X + halfWidth;

			// TODO: clip glyphs on both ends of paths
			SKPoint position;
			SKPoint tangent;

			if (pathOffset >= 0 && pathOffset < contourLength
					&& pathMeasure.GetPositionAndTangent(pathOffset, position, tangent)) {
				if (pathGlyphCount == 0)
					firstGlyphIndex = index;

				auto tx = tangent.X;
				auto ty = tangent.Y;

				auto px = position.X;
				auto py = position.Y;

				// horizontally offset the position using the tangent vector
				px -= tx * halfWidth;
				py -= ty * halfWidth;

				// vertically offset the position using the normal vector  (-ty, tx)
				auto dy = glyphOffset.Y;
				px -= dy * ty;
				py += dy * tx;

				glyphTransforms[pathGlyphCount++] = SKRotationScaleMatrix(tx, ty, px, py);
			}
		}

		auto glyphSubset = glyphs[firstGlyphIndex .. firstGlyphIndex + pathGlyphCount];
		auto positions = glyphTransforms[0 .. pathGlyphCount];

		AddRotationScaleRun(glyphSubset, font, positions);
	}

	// AllocateRun

	SKRunBuffer AllocateRun(SKFont font, int count, float x, float y, Nullable!SKRect bounds) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		SKRunBufferInternal runbuffer;

		if (!bounds.isNull) {
			SKRect b = bounds.get();
			SkiaApi.sk_textblob_builder_alloc_run(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, x, y, &b, &runbuffer);
		} else {
			SkiaApi.sk_textblob_builder_alloc_run(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, x, y, null, &runbuffer);
		}

		return new SKRunBuffer(runbuffer, count);
	}

	// AllocateHorizontalRun
	SKHorizontalRunBuffer AllocateHorizontalRun(SKFont font, int count, float y) {
		// return AllocateHorizontalRun ( font,  count,  y, SKRect());
		return null;
	}

	SKHorizontalRunBuffer AllocateHorizontalRun(SKFont font, int count, float y,
			Nullable!SKRect bounds) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		SKRunBufferInternal runbuffer;

		if (!bounds.isNull) {
			SKRect b = bounds.get();
			SkiaApi.sk_textblob_builder_alloc_run_pos_h(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, y, &b, &runbuffer);
		} else {
			SkiaApi.sk_textblob_builder_alloc_run_pos_h(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, y, null, &runbuffer);
		}

		return new SKHorizontalRunBuffer(runbuffer, count);
	}

	// AllocatePositionedRun

	SKPositionedRunBuffer AllocatePositionedRun(SKFont font, int count,
			Nullable!SKRect bounds = Nullable!SKRect.init) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		SKRunBufferInternal runbuffer;

		if (bounds.isNull) {
			SkiaApi.sk_textblob_builder_alloc_run_pos(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, null, &runbuffer);
		} else {
			warning("22");
			SKRect b = bounds.get();
			SkiaApi.sk_textblob_builder_alloc_run_pos(cast(sk_textblob_builder_t*) Handle,
					cast(sk_font_t*) font.Handle, count, &b, &runbuffer);
		}

		return new SKPositionedRunBuffer(runbuffer, count);
	}

	// AllocateRotationScaleRun

	SKRotationScaleRunBuffer AllocateRotationScaleRun(SKFont font, int count) {
		if (font is null)
			throw new ArgumentNullException(font.stringof);

		SKRunBufferInternal runbuffer;
		SkiaApi.sk_textblob_builder_alloc_run_rsxform(cast(sk_textblob_builder_t*) Handle,
				cast(sk_font_t*) font.Handle, count, &runbuffer);

		return new SKRotationScaleRunBuffer(runbuffer, count);
	}

	// OBSOLETE OVERLOADS

	// AddRun

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs, string text, uint[] clusters) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddRun(font, x, y, glyphs, utf8Text, clusters);
	}

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs, string text,
			uint[] clusters, SKRect bounds) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddRun(font, x, y, glyphs, utf8Text, clusters, bounds);
	}

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs) {
		// return AddRun (font, x, y, glyphs, const(byte)[].Empty, null, null);

		// return AddRun (font, x, y, glyphs, (const(byte)[]).init, null, null);
	}

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs, SKRect bounds) {
		AddRun(font, x, y, glyphs, (const(byte)[]).init, null, bounds);
	}

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs, byte[] text, uint[] clusters) {
		//  AddRun (font, x, y, glyphs, text, clusters, null);
	}

	void AddRun(SKPaint font, float x, float y, ushort[] glyphs, byte[] text,
			uint[] clusters, SKRect bounds) {
		AddRun(font, x, y, glyphs, text, clusters, bounds);
	}

	// AddRun (spans)

	void AddRun(SKPaint font, float x, float y, const(ushort)[] glyphs) {
		//  AddRun (font, x, y, glyphs, (const(byte)[]).init, null, null);
	}

	// void AddRun (SKPaint font, float x, float y, const(ushort)[] glyphs1 Nullable!SKRect bounds)
	// {
	// 	return AddRun (font, x, y, glyphs, (const(byte)[]).init, null, bounds);
	// }

	void AddRun(SKPaint font, float x, float y, const(ushort)[] glyphs,
			const(byte)[] text, const(uint)[] clusters) {
		//  AddRun (font, x, y, glyphs, text, clusters, null);
	}

	// void AddRun (SKPaint font, float x, float y, const(ushort)[] glyphs, const(byte)[] text, const(uint)[] clusters1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);
	// 	if (glyphs.empty())
	// 		throw new ArgumentNullException (glyphs.stringof);

	// 	if (!text.empty()) {
	// 		if (clusters.empty())
	// 			throw new ArgumentNullException (clusters.stringof);
	// 		if (glyphs.length != clusters.length)
	// 			throw new ArgumentException ("The number of glyphs and clusters must be the same.");
	// 	}

	// 	auto run = AllocateRun (font, glyphs.length, x, y, text.empty() ? 0 : text.length, bounds);
	// 	run.SetGlyphs (glyphs);

	// 	if (!text.empty()) {
	// 		run.SetText (text);
	// 		run.SetClusters (clusters);
	// 	}
	// }

	// AddHorizontalRun

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs,
			float[] positions, string text, uint[] clusters) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddHorizontalRun(font, y, glyphs, positions, utf8Text, clusters);
	}

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs,
			float[] positions, string text, uint[] clusters, SKRect bounds) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddHorizontalRun(font, y, glyphs, positions, utf8Text, clusters, bounds);
	}

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs, float[] positions) {
		//  AddHorizontalRun (font, y, glyphs, positions, (const(byte)[]).init, null, null);
	}

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs, float[] positions, SKRect bounds) {
		AddHorizontalRun(font, y, glyphs, positions, (const(byte)[]).init, null, bounds);
	}

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs,
			float[] positions, byte[] text, uint[] clusters) {
		//  AddHorizontalRun (font, y, glyphs, positions, text, clusters, null);
	}

	void AddHorizontalRun(SKPaint font, float y, ushort[] glyphs,
			float[] positions, byte[] text, uint[] clusters, SKRect bounds) {
		AddHorizontalRun(font, y, glyphs, positions, text, clusters, bounds);
	}

	// AddHorizontalRun (spans)

	void AddHorizontalRun(SKPaint font, float y, const(ushort)[] glyphs, const(float)[] positions) {
		//  AddHorizontalRun (font, y, glyphs, positions, (const(byte)[]).init, null, null);
	}

	// void AddHorizontalRun (SKPaint font, float y, const(ushort)[] glyphs, const(float)[] positions1, Nullable!SKRect bounds)
	// {
	// 	return AddHorizontalRun (font, y, glyphs, positions, const(byte)[].Empty, null, bounds);
	// }

	void AddHorizontalRun(SKPaint font, float y, const(ushort)[] glyphs,
			const(float)[] positions, const(byte)[] text, const(uint)[] clusters) {
		//  AddHorizontalRun (font, y, glyphs, positions, text, clusters, null);
	}

	// void AddHorizontalRun (SKPaint font, float y, const(ushort)[] glyphs, const(float)[] positions, const(byte)[] text, const(uint)[] clusters1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);
	// 	if (glyphs.empty())
	// 		throw new ArgumentNullException (glyphs.stringof);
	// 	if (positions.empty())
	// 		throw new ArgumentNullException (positions.stringof);
	// 	if (glyphs.length != positions.length)
	// 		throw new ArgumentException ("The number of glyphs and positions must be the same.");

	// 	if (!text.empty()) {
	// 		if (clusters.empty())
	// 			throw new ArgumentNullException (clusters.stringof);
	// 		if (glyphs.length != clusters.length)
	// 			throw new ArgumentException ("The number of glyphs and clusters must be the same.");
	// 	}

	// 	auto run = AllocateHorizontalRun (font, glyphs.length, y, text.empty() ? 0 : text.length, bounds);
	// 	run.SetGlyphs (glyphs);
	// 	run.SetPositions (positions);

	// 	if (!text.empty()) {
	// 		run.SetText (text);
	// 		run.SetClusters (clusters);
	// 	}
	// }

	// AddPositionedRun

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions,
			string text, uint[] clusters) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddPositionedRun(font, glyphs, positions, utf8Text, clusters);
	}

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions,
			string text, uint[] clusters, SKRect bounds) {
		auto utf8Text = StringUtilities.GetEncodedText(text, SKTextEncoding.Utf8);
		AddPositionedRun(font, glyphs, positions, utf8Text, clusters, bounds);
	}

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions) {
		//  AddPositionedRun (font, glyphs, positions, (const(byte)[]).init, null, null);
	}

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions, SKRect bounds) {
		AddPositionedRun(font, glyphs, positions, (const(byte)[]).init, null, bounds);
	}

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions,
			byte[] text, uint[] clusters) {
		//  AddPositionedRun (font, glyphs, positions, text, clusters, null);
	}

	void AddPositionedRun(SKPaint font, ushort[] glyphs, SKPoint[] positions,
			byte[] text, uint[] clusters, SKRect bounds) {
		AddPositionedRun(font, glyphs, positions, text, clusters, bounds);
	}

	// AddPositionedRun (spans)

	void AddPositionedRun(SKPaint font, const(ushort)[] glyphs, const(SKPoint)[] positions) {
		//  AddPositionedRun (font, glyphs, positions, (const(byte)[]).init, null, null);
	}

	// void AddPositionedRun (SKPaint font, const(ushort)[] glyphs, const(SKPoint)[] positions1 Nullable!SKRect bounds)
	// {
	// 	return AddPositionedRun (font, glyphs, positions, const(byte)[].Empty, null, bounds);
	// }

	void AddPositionedRun(SKPaint font, const(ushort)[] glyphs,
			const(SKPoint)[] positions, const(byte)[] text, const(uint)[] clusters) {
		//  AddPositionedRun (font, glyphs, positions, text, clusters, null);
	}

	// void AddPositionedRun (SKPaint font, const(ushort)[] glyphs, const(SKPoint)[] positions, const(byte)[] text, const(uint)[] clusters1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);
	// 	if (glyphs.empty())
	// 		throw new ArgumentNullException (glyphs.stringof);
	// 	if (positions.empty())
	// 		throw new ArgumentNullException (positions.stringof);
	// 	if (glyphs.length != positions.length)
	// 		throw new ArgumentException ("The number of glyphs and positions must be the same.");

	// 	if (!text.empty()) {
	// 		if (clusters.empty())
	// 			throw new ArgumentNullException (clusters.stringof);
	// 		if (glyphs.length != clusters.length)
	// 			throw new ArgumentException ("The number of glyphs and clusters must be the same.");
	// 	}

	// 	auto run = AllocatePositionedRun (font, glyphs.length, text.empty() ? 0 : text.length, bounds);
	// 	run.SetGlyphs (glyphs);
	// 	run.SetPositions (positions);

	// 	if (!text.empty()) {
	// 		run.SetText (text);
	// 		run.SetClusters (clusters);
	// 	}
	// }

	// AllocateRun

	SKRunBuffer AllocateRun(SKPaint font, int count, float x, float y) {
		// return AllocateRun (font, count, x, y, 0, null);
		return null;
	}

	// SKRunBuffer AllocateRun (SKPaint font, int count, float x, float y1 Nullable!SKRect bounds)
	// {
	// 	return AllocateRun (font, count, x, y, 0, bounds);
	// }

	// SKRunBuffer AllocateRun (SKPaint font, int count, float x, float y, int textByteCount)
	// {
	// 	return AllocateRun (font, count, x, y, textByteCount);
	// }

	// SKRunBuffer AllocateRun (SKPaint font, int count, float x, float y, int textByteCount1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);

	// 	auto originalEncoding = font.TextEncoding;
	// 	try {
	// 		font.TextEncoding = SKTextEncoding.GlyphId;

	// 		SKRunBufferInternal runbuffer;
	// 		if (bounds is SKRect b) {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text (Handle, font.GetFont ().Handle, count, x, y, textByteCount, &b, &runbuffer);
	// 		} else {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text (Handle, font.GetFont ().Handle, count, x, y, textByteCount, null, &runbuffer);
	// 		}

	// 		return new SKRunBuffer (runbuffer, count, textByteCount);

	// 	} finally {
	// 		font.TextEncoding = originalEncoding;
	// 	}
	// }

	// AllocateHorizontalRun

	SKHorizontalRunBuffer AllocateHorizontalRun(SKPaint font, int count, float y) {
		return AllocateHorizontalRun(font, count, y, 0);
	}

	// SKHorizontalRunBuffer AllocateHorizontalRun (SKPaint font, int count, float y1 Nullable!SKRect bounds)
	// {
	// 	return AllocateHorizontalRun (font, count, y, 0, bounds);
	// }

	SKHorizontalRunBuffer AllocateHorizontalRun(SKPaint font, int count, float y, int textByteCount) {
		return AllocateHorizontalRun(font, count, y, textByteCount);
	}

	// SKHorizontalRunBuffer AllocateHorizontalRun (SKPaint font, int count, float y, int textByteCount1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);

	// 	auto originalEncoding = font.TextEncoding;
	// 	try {
	// 		font.TextEncoding = SKTextEncoding.GlyphId;

	// 		SKRunBufferInternal runbuffer;
	// 		SKRect b = cast(SKRect)bounds;
	// 		if (bounds is SKRect b) {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text_pos_h (Handle, font.GetFont ().Handle, count, y, textByteCount, &b, &runbuffer);
	// 		} else {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text_pos_h (Handle, font.GetFont ().Handle, count, y, textByteCount, null, &runbuffer);
	// 		}

	// 		return new SKHorizontalRunBuffer (runbuffer, count, textByteCount);
	// 	} finally {
	// 		font.TextEncoding = originalEncoding;
	// 	}
	// }

	// AllocatePositionedRun

	// SKPositionedRunBuffer AllocatePositionedRun (SKPaint font, int count)
	// {
	// 	return AllocatePositionedRun (font, count, 0);
	// }

	// SKPositionedRunBuffer AllocatePositionedRun (SKPaint font, int count1 Nullable!SKRect bounds)
	// {
	// 	return AllocatePositionedRun (font, count, 0, bounds);
	// }

	// SKPositionedRunBuffer AllocatePositionedRun (SKPaint font, int count, int textByteCount)
	// {
	// 	return AllocatePositionedRun (font, count, textByteCount);
	// }

	// SKPositionedRunBuffer AllocatePositionedRun (SKPaint font, int count, int textByteCount1 Nullable!SKRect bounds)
	// {
	// 	if (font is null)
	// 		throw new ArgumentNullException (font.stringof);

	// 	auto originalEncoding = font.TextEncoding;
	// 	try {
	// 		font.TextEncoding = SKTextEncoding.GlyphId;

	// 		SKRunBufferInternal runbuffer;
	// 		if (bounds is SKRect b) {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text_pos (Handle, font.GetFont ().Handle, count, textByteCount, &b, &runbuffer);
	// 		} else {
	// 			SkiaApi.sk_textblob_builder_alloc_run_text_pos (Handle, font.GetFont ().Handle, count, textByteCount, null, &runbuffer);
	// 		}

	// 		return new SKPositionedRunBuffer (runbuffer, count, textByteCount);
	// 	} finally {
	// 		font.TextEncoding = originalEncoding;
	// 	}
	// }
}
