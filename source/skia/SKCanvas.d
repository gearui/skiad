module skia.SKCanvas;

import skia.Exceptions;
import skia.SkiaApi;
import skia.SKObject;
import skia.SKTextBlob;
import skia.MathTypes;
import skia.Definitions;
import skia.SKPath;
import skia.SKBitmap;
import skia.SKPaint;
import skia.SKMatrix;
import skia.SKColor;
import skia.SKImage;
import skia.SKFont;
import skia.SKRegion;
import skia.SKData;
import skia.SKRoundRect;
import skia.SKPicture;
import skia.SKDrawable;
import skia.SKSurface;
import skia.SKVertices;
import skia.IDisposable;
import skia.SKColors;

import std.typecons;

import std.experimental.logger;

// TODO: carefully consider the `PeekPixels`, `ReadPixels`

class SKCanvas : SKObject
{
	private enum PatchCornerCount = 4;
	private enum PatchCubicsCount = 12;

	this (void* handle, bool owns)
	{
		super(handle, owns);
	}

	this (SKBitmap bitmap)
	{
    this (null, true);
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		Handle = SkiaApi.sk_canvas_new_from_bitmap (cast(sk_bitmap_t*)bitmap.Handle);
	}

// 	protected override void Dispose (bool disposing)
// 	{
// 		return super.Dispose (disposing);
// 	}

//   override void Dispose()
//   {
//     return super.Dispose();
//   }

	protected override void DisposeNative ()
	{
		return SkiaApi.sk_canvas_destroy (cast(sk_canvas_t*)Handle);
	}

	void Discard ()
	{
		return SkiaApi.sk_canvas_discard (cast(sk_canvas_t*)Handle);
	}

	// QuickReject

	bool QuickReject (SKRect rect)
	{
		return SkiaApi.sk_canvas_quick_reject (cast(sk_canvas_t*)Handle, &rect);
	}

	bool QuickReject (SKPath path)
	{
		if (path is null)
			throw new ArgumentNullException (path.stringof);
		return path.IsEmpty || QuickReject (path.Bounds);
	}

	// Save*

	int Save ()
	{
		if (Handle is null)
			throw new ObjectDisposedException ("SKCanvas");
		return SkiaApi.sk_canvas_save (cast(sk_canvas_t*)Handle);
	}

	int SaveLayer (SKRect limit, SKPaint paint)
	{
		return SkiaApi.sk_canvas_save_layer (cast(sk_canvas_t*)Handle, &limit, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	int SaveLayer (SKPaint paint)
	{
		return SkiaApi.sk_canvas_save_layer (cast(sk_canvas_t*)Handle, null, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	int SaveLayer ()
	{
		return SaveLayer (null);
	}

	// DrawColor

	void DrawColor (SKColor color, SKBlendMode mode = SKBlendMode.Src)
	{
		SkiaApi.sk_canvas_draw_color (cast(sk_canvas_t*)Handle, cast(uint)color, mode);
	}

	// DrawLine

	void DrawLine (SKPoint p0, SKPoint p1, SKPaint paint)
	{
		DrawLine (p0.X, p0.Y, p1.X, p1.Y, paint);
	}

	void DrawLine (float x0, float y0, float x1, float y1, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_line (cast(sk_canvas_t*)Handle, x0, y0, x1, y1, cast(sk_paint_t*)paint.Handle);
	}

	// Clear

	void Clear ()
	{
		DrawColor (SKColors.Empty, SKBlendMode.Src);
	}

	void Clear (SKColor color)
	{
		DrawColor (color, SKBlendMode.Src);
	}

	// Restore*

	void Restore ()
	{
		SkiaApi.sk_canvas_restore (cast(sk_canvas_t*)Handle);
	}

	void RestoreToCount (int count)
	{
		SkiaApi.sk_canvas_restore_to_count (cast(sk_canvas_t*)Handle, count);
	}

	// Translate

	void Translate (float dx, float dy)
	{
		SkiaApi.sk_canvas_translate (cast(sk_canvas_t*)Handle, dx, dy);
	}

	void Translate (SKPoint point)
	{
		SkiaApi.sk_canvas_translate (cast(sk_canvas_t*)Handle, point.X, point.Y);
	}

	// Scale

	void Scale (float s)
	{
		SkiaApi.sk_canvas_scale (cast(sk_canvas_t*)Handle, s, s);
	}

	void Scale (float sx, float sy)
	{
		SkiaApi.sk_canvas_scale (cast(sk_canvas_t*)Handle, sx, sy);
	}

	void Scale (SKPoint size)
	{
		SkiaApi.sk_canvas_scale (cast(sk_canvas_t*)Handle, size.X, size.Y);
	}

	void Scale (float sx, float sy, float px, float py)
	{
		Translate (px, py);
		Scale (sx, sy);
		Translate (-px, -py);
	}

	// Rotate*

	void RotateDegrees (float degrees)
	{
		SkiaApi.sk_canvas_rotate_degrees (cast(sk_canvas_t*)Handle, degrees);
	}

	void RotateRadians (float radians)
	{
		SkiaApi.sk_canvas_rotate_radians (cast(sk_canvas_t*)Handle, radians);
	}

	void RotateDegrees (float degrees, float px, float py)
	{
		Translate (px, py);
		RotateDegrees (degrees);
		Translate (-px, -py);
	}

	void RotateRadians (float radians, float px, float py)
	{
		Translate (px, py);
		RotateRadians (radians);
		Translate (-px, -py);
	}

	// Skew

	void Skew (float sx, float sy)
	{
		SkiaApi.sk_canvas_skew (cast(sk_canvas_t*)Handle, sx, sy);
	}

	void Skew (SKPoint skew)
	{
		SkiaApi.sk_canvas_skew (cast(sk_canvas_t*)Handle, skew.X, skew.Y);
	}

	// Concat

	void Concat (ref SKMatrix m)
	{
		SKMatrix* ptr = &m;
        SkiaApi.sk_canvas_concat (cast(sk_canvas_t*)Handle, ptr);
	}

	// Clip*

	void ClipRect (SKRect rect, SKClipOperation operation = SKClipOperation.Intersect, bool antialias = false)
	{
		SkiaApi.sk_canvas_clip_rect_with_operation (cast(sk_canvas_t*)Handle, &rect, operation, antialias);
	}

	void ClipRoundRect (SKRoundRect rect, SKClipOperation operation = SKClipOperation.Intersect, bool antialias = false)
	{
		if (rect is null)
			throw new ArgumentNullException (rect.stringof);

		SkiaApi.sk_canvas_clip_rrect_with_operation (cast(sk_canvas_t*)Handle, cast(sk_rrect_t*)rect.Handle, operation, antialias);
	}

	void ClipPath (SKPath path, SKClipOperation operation = SKClipOperation.Intersect, bool antialias = false)
	{
		if (path is null)
			throw new ArgumentNullException (path.stringof);

		SkiaApi.sk_canvas_clip_path_with_operation (cast(sk_canvas_t*)Handle,cast(sk_path_t*) path.Handle, operation, antialias);
	}

	void ClipRegion (SKRegion region, SKClipOperation operation = SKClipOperation.Intersect)
	{
		if (region is null)
			throw new ArgumentNullException (region.stringof);

		SkiaApi.sk_canvas_clip_region (cast(sk_canvas_t*)Handle, cast(sk_region_t*)region.Handle, operation);
	}

	SKRect LocalClipBounds() {
        SKRect bounds;
        GetLocalClipBounds (bounds);
        return bounds;
	}

	SKRectI DeviceClipBounds() {
        SKRectI bounds;
        GetDeviceClipBounds (bounds);
        return bounds;
	}

	bool IsClipEmpty() { return SkiaApi.sk_canvas_is_clip_empty (cast(sk_canvas_t*)Handle); }

	bool IsClipRect() { return SkiaApi.sk_canvas_is_clip_rect (cast(sk_canvas_t*)Handle); }

	bool GetLocalClipBounds (ref SKRect bounds)
	{
		SKRect* b = &bounds;
		return SkiaApi.sk_canvas_get_local_clip_bounds (cast(sk_canvas_t*)Handle, b);
	}

	bool GetDeviceClipBounds (ref SKRectI bounds)
	{
		SKRectI* b = &bounds;
		return SkiaApi.sk_canvas_get_device_clip_bounds (cast(sk_canvas_t*)Handle, b);
	}

	// DrawPaint

	void DrawPaint (SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_paint (cast(sk_canvas_t*)Handle, cast(sk_paint_t*)paint.Handle);
	}

	// DrawRegion

	void DrawRegion (SKRegion region, SKPaint paint)
	{
		if (region is null)
			throw new ArgumentNullException (region.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_region (cast(sk_canvas_t*)Handle, cast(sk_region_t*)region.Handle, cast(sk_paint_t*)paint.Handle);
	}

	// DrawRect

	void DrawRect (float x, float y, float w, float h, SKPaint paint)
	{
		DrawRect (SKRect.Create (x, y, w, h), paint);
	}

	void DrawRect (SKRect rect, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_rect (cast(sk_canvas_t*)Handle, &rect, cast(sk_paint_t*)paint.Handle);
	}

	// DrawRoundRect

	void DrawRoundRect (SKRoundRect rect, SKPaint paint)
	{
		if (rect is null)
			throw new ArgumentNullException (rect.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_rrect (cast(sk_canvas_t*)Handle, cast(sk_rrect_t*)rect.Handle, cast(sk_paint_t*)paint.Handle);
	}

	void DrawRoundRect (float x, float y, float w, float h, float rx, float ry, SKPaint paint)
	{
		DrawRoundRect (SKRect.Create (x, y, w, h), rx, ry, paint);
	}

	void DrawRoundRect (SKRect rect, float rx, float ry, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_round_rect (cast(sk_canvas_t*)Handle, &rect, rx, ry, cast(sk_paint_t*)paint.Handle);
	}

	void DrawRoundRect (SKRect rect, SKSize r, SKPaint paint)
	{
		DrawRoundRect (rect, r.Width, r.Height, paint);
	}

	// DrawOval

	void DrawOval (float cx, float cy, float rx, float ry, SKPaint paint)
	{
		DrawOval (SKRect (cx - rx, cy - ry, cx + rx, cy + ry), paint);
	}

	void DrawOval (SKPoint c, SKSize r, SKPaint paint)
	{
		DrawOval (c.X, c.Y, r.Width, r.Height, paint);
	}

	void DrawOval (SKRect rect, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_oval (cast(sk_canvas_t*)Handle, &rect, cast(sk_paint_t*)paint.Handle);
	}

	// DrawCircle

	void DrawCircle (float cx, float cy, float radius, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_circle (cast(sk_canvas_t*)Handle, cx, cy, radius, cast(sk_paint_t*)paint.Handle);
	}

	void DrawCircle (SKPoint c, float radius, SKPaint paint)
	{
		DrawCircle (c.X, c.Y, radius, paint);
	}

	// DrawPath

	void DrawPath (SKPath path, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		if (path is null)
			throw new ArgumentNullException (path.stringof);
		SkiaApi.sk_canvas_draw_path (cast(sk_canvas_t*)Handle, cast(sk_path_t*)path.Handle, cast(sk_paint_t*)paint.Handle);
	}

	// DrawPoints

	void DrawPoints (SKPointMode mode, SKPoint[] points, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		if (points is null)
			throw new ArgumentNullException (points.stringof);
		SKPoint* p = points.ptr;
		SkiaApi.sk_canvas_draw_points (cast(sk_canvas_t*)Handle, mode, cast(void*)points.length, p, cast(sk_paint_t*)paint.Handle);
	}

	// DrawPoint

	void DrawPoint (SKPoint p, SKPaint paint)
	{
		DrawPoint (p.X, p.Y, paint);
	}

	void DrawPoint (float x, float y, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_point (cast(sk_canvas_t*)Handle, x, y, cast(sk_paint_t*)paint.Handle);
	}

	void DrawPoint (SKPoint p, SKColor color)
	{
		DrawPoint (p.X, p.Y, color);
	}

	void DrawPoint (float x, float y, SKColor color)
	{
        SKPaint paint = new SKPaint();
		scope(exit) {
			paint.Dispose();
		}

        paint.Color = color;
        paint.BlendMode = SKBlendMode.Src;

        DrawPoint (x, y, paint);
	}

	// DrawImage

	void DrawImage (SKImage image, SKPoint p, SKPaint paint = null)
	{
		DrawImage (image, p.X, p.Y, paint);
	}

	void DrawImage (SKImage image, float x, float y, SKPaint paint = null)
	{
		if (image is null)
			throw new ArgumentNullException (image.stringof);
		SkiaApi.sk_canvas_draw_image (cast(sk_canvas_t*)Handle, cast(sk_image_t*)image.Handle, x, y, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawImage (SKImage image, SKRect dest, SKPaint paint = null)
	{
		if (image is null)
			throw new ArgumentNullException (image.stringof);
		SkiaApi.sk_canvas_draw_image_rect (cast(sk_canvas_t*)Handle, cast(sk_image_t*)image.Handle, null, &dest, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawImage (SKImage image, SKRect source, SKRect dest, SKPaint paint = null)
	{
		if (image is null)
			throw new ArgumentNullException (image.stringof);
		SkiaApi.sk_canvas_draw_image_rect (cast(sk_canvas_t*)Handle, cast(sk_image_t*)image.Handle, &source, &dest, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	// DrawPicture

	void DrawPicture (SKPicture picture, float x, float y, SKPaint paint = null)
	{
		auto matrix = SKMatrix.CreateTranslation (x, y);
		DrawPicture (picture, matrix, paint);
	}

	void DrawPicture (SKPicture picture, SKPoint p, SKPaint paint = null)
	{
		DrawPicture (picture, p.X, p.Y, paint);
	}

	void DrawPicture (SKPicture picture, ref SKMatrix matrix, SKPaint paint = null)
	{
		if (picture is null)
			throw new ArgumentNullException (picture.stringof);
		SKMatrix* m = &matrix;
		SkiaApi.sk_canvas_draw_picture (cast(sk_canvas_t*)Handle, cast(sk_picture_t*)picture.Handle, m, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawPicture (SKPicture picture, SKPaint paint = null)
	{
		if (picture is null)
			throw new ArgumentNullException (picture.stringof);
		SkiaApi.sk_canvas_draw_picture (cast(sk_canvas_t*)Handle, cast(sk_picture_t*)picture.Handle, null, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	// DrawDrawable

	void DrawDrawable (SKDrawable drawable, ref SKMatrix matrix)
	{
		if (drawable is null)
			throw new ArgumentNullException (drawable.stringof);
		SKMatrix* m = &matrix;
		SkiaApi.sk_canvas_draw_drawable (cast(sk_canvas_t*)Handle, cast(sk_drawable_t*)drawable.Handle, m);
	}

	void DrawDrawable (SKDrawable drawable, float x, float y)
	{
		if (drawable is null)
			throw new ArgumentNullException (drawable.stringof);
		auto matrix = SKMatrix.CreateTranslation (x, y);
		DrawDrawable (drawable, matrix);
	}

	void DrawDrawable (SKDrawable drawable, SKPoint p)
	{
		if (drawable is null)
			throw new ArgumentNullException (drawable.stringof);
		auto matrix = SKMatrix.CreateTranslation (p.X, p.Y);
		DrawDrawable (drawable, matrix);
	}

	// DrawBitmap

	void DrawBitmap (SKBitmap bitmap, SKPoint p, SKPaint paint = null)
	{
		DrawBitmap (bitmap, p.X, p.Y, paint);
	}

	void DrawBitmap (SKBitmap bitmap, float x, float y, SKPaint paint = null)
	{
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		SkiaApi.sk_canvas_draw_bitmap (cast(sk_canvas_t*)Handle, cast(sk_bitmap_t*)bitmap.Handle, x, y, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawBitmap (SKBitmap bitmap, SKRect dest, SKPaint paint = null)
	{
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		SkiaApi.sk_canvas_draw_bitmap_rect (cast(sk_canvas_t*)Handle, cast(sk_bitmap_t*)bitmap.Handle, null, &dest, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawBitmap (SKBitmap bitmap, SKRect source, SKRect dest, SKPaint paint = null)
	{
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		SkiaApi.sk_canvas_draw_bitmap_rect (cast(sk_canvas_t*)Handle, cast(sk_bitmap_t*)bitmap.Handle, &source, &dest, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	// DrawSurface

	void DrawSurface (SKSurface surface, SKPoint p, SKPaint paint = null)
	{
		DrawSurface (surface, p.X, p.Y, paint);
	}

	void DrawSurface (SKSurface surface, float x, float y, SKPaint paint = null)
	{
		if (surface is null)
			throw new ArgumentNullException (surface.stringof);

		surface.Draw (this, x, y, paint);
	}

	// DrawText (SKTextBlob)

	void DrawText (SKTextBlob text, float x, float y, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		SkiaApi.sk_canvas_draw_text_blob (cast(sk_canvas_t*)Handle, cast(sk_textblob_t*)text.Handle, x, y, cast(sk_paint_t*)paint.Handle);
	}

	// DrawText

	void DrawText (string text, SKPoint p, SKPaint paint)
	{
		DrawText (text, p.X, p.Y, paint);
	}

	void DrawText (string text, float x, float y, SKPaint paint)
	{
		DrawText (text, x, y, paint.GetFont (), paint);
	}

	void DrawText (string text, float x, float y, SKFont font, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (font is null)
			throw new ArgumentNullException (font.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		if (paint.TextAlign != SKTextAlign.Left) {
			auto width = font.MeasureText (text);
			if (paint.TextAlign == SKTextAlign.Center)
				width *= 0.5f;
			x -= width;
		}

		SKTextBlob blob = SKTextBlob.Create (text, font);
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, x, y, paint);
	}

	void DrawText (byte[] text, SKPoint p, SKPaint paint)
	{
		DrawText (text, p.X, p.Y, paint);
	}

	void DrawText (byte[] text, float x, float y, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		if (paint.TextAlign != SKTextAlign.Left) {
			auto width = paint.MeasureText (text);
			if (paint.TextAlign == SKTextAlign.Center)
				width *= 0.5f;
			x -= width;
		}

		SKTextBlob blob = SKTextBlob.Create (text, paint.TextEncoding, paint.GetFont ());
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, x, y, paint);
	}

	void DrawText (void* buffer, int length, SKPoint p, SKPaint paint)
	{
		DrawText (buffer, length, p.X, p.Y, paint);
	}

	void DrawText (void* buffer, int length, float x, float y, SKPaint paint)
	{
		if (buffer is null && length != 0)
			throw new ArgumentNullException (buffer.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		if (paint.TextAlign != SKTextAlign.Left) {
			auto width = paint.MeasureText (buffer, length);
			if (paint.TextAlign == SKTextAlign.Center)
				width *= 0.5f;
			x -= width;
		}

		SKTextBlob blob = SKTextBlob.Create (buffer, cast(int)length, paint.TextEncoding, paint.GetFont ());
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, x, y, paint);
	}

	// DrawPositionedText

	void DrawPositionedText (string text, SKPoint[] points, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		if (points is null)
			throw new ArgumentNullException (points.stringof);

		SKTextBlob blob = SKTextBlob.CreatePositioned (text, paint.GetFont (), points);
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, 0, 0, paint);
	}

	void DrawPositionedText (byte[] text, SKPoint[] points, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		if (points is null)
			throw new ArgumentNullException (points.stringof);

		SKTextBlob blob = SKTextBlob.CreatePositioned (text, paint.TextEncoding, paint.GetFont (), points);
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, 0, 0, paint);
	}

	void DrawPositionedText (void* buffer, int length, SKPoint[] points, SKPaint paint)
	{
		if (buffer is null && length != 0)
			throw new ArgumentNullException (buffer.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		if (points is null)
			throw new ArgumentNullException (points.stringof);

		SKTextBlob blob = SKTextBlob.CreatePositioned (buffer, length, paint.TextEncoding, paint.GetFont (), points);
		if (blob is null)
			return;

		scope(exit) {
			blob.Dispose();
		}

		DrawText (blob, 0, 0, paint);
	}

	// DrawTextOnPath

	void DrawTextOnPath (string text, SKPath path, SKPoint offset, SKPaint paint)
	{
		DrawTextOnPath (text, path, offset, true, paint);
	}

	void DrawTextOnPath (string text, SKPath path, float hOffset, float vOffset, SKPaint paint)
	{
		DrawTextOnPath (text, path, SKPoint (hOffset, vOffset), true, paint);
	}

	void DrawTextOnPath (string text, SKPath path, SKPoint offset, bool warpGlyphs, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		DrawTextOnPath (text, path, offset, warpGlyphs, paint.GetFont (), paint);
	}

	void DrawTextOnPath (string text, SKPath path, SKPoint offset, bool warpGlyphs, SKFont font, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (path is null)
			throw new ArgumentNullException (path.stringof);
		if (font is null)
			throw new ArgumentNullException (font.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		if (warpGlyphs) {
			auto textPath =  font.GetTextPathOnPath (text, path, paint.TextAlign, offset);
			scope(exit) {
			    textPath.Dispose();
			}

			DrawPath (textPath, paint);
		} else {
			SKTextBlob blob = SKTextBlob.CreatePathPositioned (text, font, path, paint.TextAlign, offset);
			if (blob !is null) {
                scope(exit) {
                    blob.Dispose();
                }       
				DrawText (blob, 0, 0, paint);
            }
		}
	}

	void DrawTextOnPath (byte[] text, SKPath path, SKPoint offset, SKPaint paint)
	{
		DrawTextOnPath (text, path, offset.X, offset.Y, paint);
	}

	void DrawTextOnPath (byte[] text, SKPath path, float hOffset, float vOffset, SKPaint paint)
	{
		if (text is null)
			throw new ArgumentNullException (text.stringof);
		if (path is null)
			throw new ArgumentNullException (path.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		byte* t = text.ptr;
		DrawTextOnPath (cast(void*)t, cast(int)text.length, path, hOffset, vOffset, paint);
	}

	void DrawTextOnPath (void* buffer, int length, SKPath path, SKPoint offset, SKPaint paint)
	{
		DrawTextOnPath (buffer, length, path, offset.X, offset.Y, paint);
	}

	void DrawTextOnPath (void* buffer, int length, SKPath path, float hOffset, float vOffset, SKPaint paint)
	{
		if (buffer is null && length != 0)
			throw new ArgumentNullException (buffer.stringof);
		if (path is null)
			throw new ArgumentNullException (path.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		auto font = paint.GetFont ();

		auto textPath =  font.GetTextPathOnPath (buffer, length, paint.TextEncoding, path, paint.TextAlign, SKPoint (hOffset, vOffset));
		scope(exit) {
		    textPath.Dispose();
		}

		DrawPath (textPath, paint);
	}

	// Flush

	void Flush ()
	{
		SkiaApi.sk_canvas_flush (cast(sk_canvas_t*)Handle);
	}

	// Draw*Annotation

	void DrawAnnotation (SKRect rect, string key, SKData value)
	{
		// auto bytes = StringUtilities.GetEncodedText (key, SKTextEncoding.Utf8, true);
		// byte* b = bytes.ptr;
		// SkiaApi.sk_canvas_draw_annotation (cast(sk_canvas_t*)Handle, &rect, b.stringof, cast(sk_data_t*)(value is null ? null : value.Handle));
	}

	void DrawUrlAnnotation (SKRect rect, SKData value)
	{
		SkiaApi.sk_canvas_draw_url_annotation (cast(sk_canvas_t*)Handle, &rect,  cast(sk_data_t*)(value is null ? null : value.Handle));
	}

	SKData DrawUrlAnnotation (SKRect rect, string value)
	{
		auto data = SKData.FromCString (value);
		DrawUrlAnnotation (rect, data);
		return data;
	}

	void DrawNamedDestinationAnnotation (SKPoint point, SKData value)
	{
		SkiaApi.sk_canvas_draw_named_destination_annotation (cast(sk_canvas_t*)Handle, &point,  cast(sk_data_t*)(value is null ? null : value.Handle));
	}

	SKData DrawNamedDestinationAnnotation (SKPoint point, string value)
	{
		auto data = SKData.FromCString (value);
		DrawNamedDestinationAnnotation (point, data);
		return data;
	}

	void DrawLinkDestinationAnnotation (SKRect rect, SKData value)
	{
		SkiaApi.sk_canvas_draw_link_destination_annotation (cast(sk_canvas_t*)Handle, &rect,  cast(sk_data_t*)(value is null ? null : value.Handle));
	}

	SKData DrawLinkDestinationAnnotation (SKRect rect, string value)
	{
		auto data = SKData.FromCString (value);
		DrawLinkDestinationAnnotation (rect, data);
		return data;
	}

	// Draw*NinePatch

	void DrawBitmapNinePatch (SKBitmap bitmap, SKRectI center, SKRect dst, SKPaint paint = null)
	{
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		// the "center" rect must fit inside the bitmap "rect"
		if (!SKRect.Create (cast(SKSize)bitmap.Info.Size).Contains (cast(SKRect)center))
			throw new ArgumentException ("Center rectangle must be contained inside the bitmap bounds.", center.stringof);

		SkiaApi.sk_canvas_draw_bitmap_nine (cast(sk_canvas_t*)Handle, cast(sk_bitmap_t*)bitmap.Handle, &center, &dst, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawImageNinePatch (SKImage image, SKRectI center, SKRect dst, SKPaint paint = null)
	{
		if (image is null)
			throw new ArgumentNullException (image.stringof);
		// the "center" rect must fit inside the image "rect"
		if (!SKRect.Create (image.Width(), image.Height()).Contains (cast(SKRect)center))
			throw new ArgumentException ("Center rectangle must be contained inside the image bounds.", center.stringof);

		SkiaApi.sk_canvas_draw_image_nine (cast(sk_canvas_t*)Handle, cast(sk_image_t*)image.Handle, &center, &dst, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	// Draw*Lattice

	void DrawBitmapLattice (SKBitmap bitmap, int[] xDivs, int[] yDivs, SKRect dst, SKPaint paint = null)
	{
		SKLattice lattice =  SKLattice ();
		lattice.XDivs = xDivs;
		lattice.YDivs = yDivs;
		DrawBitmapLattice (bitmap, lattice, dst, paint);
	}

	void DrawImageLattice (SKImage image, int[] xDivs, int[] yDivs, SKRect dst, SKPaint paint = null)
	{
		SKLattice lattice =  SKLattice();
		lattice.XDivs = xDivs;
		lattice.YDivs = yDivs;
		DrawImageLattice (image, lattice, dst, paint);
	}

	void DrawBitmapLattice (SKBitmap bitmap, SKLattice lattice, SKRect dst, SKPaint paint = null)
	{
		if (bitmap is null)
			throw new ArgumentNullException (bitmap.stringof);
		if (lattice.XDivs is null)
			throw new ArgumentNullException (lattice.XDivs.stringof);
		if (lattice.YDivs is null)
			throw new ArgumentNullException (lattice.YDivs.stringof);

		int* x = lattice.XDivs.ptr;
		int* y = lattice.YDivs.ptr;
		SKLatticeRectType* r = lattice.RectTypes.ptr;
		SKColor* c = lattice.Colors.ptr;

        SKLatticeInternal nativeLattice =  SKLatticeInternal();
        
		nativeLattice.fBounds = null;
		nativeLattice.fRectTypes = r;
		nativeLattice.fXCount = cast(int)lattice.XDivs.length;
		nativeLattice.fXDivs = x;
		nativeLattice.fYCount = cast(int)lattice.YDivs.length;
		nativeLattice.fYDivs = y;
		nativeLattice.fColors = cast(uint*)c;

		Nullable!SKRectI nullableBounds = lattice.Bounds;
      
        if (!nullableBounds.isNull) {
            SKRectI bounds = nullableBounds.get();
            nativeLattice.fBounds = &bounds;
        }
        SkiaApi.sk_canvas_draw_bitmap_lattice (cast(sk_canvas_t*)Handle, cast(sk_bitmap_t*)bitmap.Handle, &nativeLattice, &dst, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	void DrawImageLattice (SKImage image, SKLattice lattice, SKRect dst, SKPaint paint = null)
	{
		if (image is null)
			throw new ArgumentNullException (image.stringof);
		if (lattice.XDivs is null)
			throw new ArgumentNullException (lattice.XDivs.stringof);
		if (lattice.YDivs is null)
			throw new ArgumentNullException (lattice.YDivs.stringof);

		int* x = lattice.XDivs.ptr;
		int* y = lattice.YDivs.ptr;
		SKLatticeRectType* r = lattice.RectTypes.ptr;
		SKColor* c = lattice.Colors.ptr; 

		SKLatticeInternal nativeLattice =  SKLatticeInternal();
	
		nativeLattice.fBounds = null;
		nativeLattice.fRectTypes = r;
		nativeLattice.fXCount = cast(int)lattice.XDivs.length;
		nativeLattice.fXDivs = x;
		nativeLattice.fYCount = cast(int)lattice.YDivs.length;
		nativeLattice.fYDivs = y;
		nativeLattice.fColors = cast(uint*)c;
		
		Nullable!SKRectI nullableBounds = lattice.Bounds;
      
        if (!nullableBounds.isNull) {
            SKRectI bounds = nullableBounds.get();
			nativeLattice.fBounds = &bounds;
		}
		SkiaApi.sk_canvas_draw_image_lattice (cast(sk_canvas_t*)Handle, cast(sk_image_t*)image.Handle, &nativeLattice, &dst, cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	// *Matrix

	void ResetMatrix ()
	{
		SkiaApi.sk_canvas_reset_matrix (cast(sk_canvas_t*)Handle);
	}

	void SetMatrix (SKMatrix matrix)
	{
		SkiaApi.sk_canvas_set_matrix (cast(sk_canvas_t*)Handle, &matrix);
	}

	SKMatrix TotalMatrix() {
        SKMatrix matrix;
        SkiaApi.sk_canvas_get_total_matrix (cast(sk_canvas_t*)Handle, &matrix);
        return matrix;
	}

	// SaveCount

	int SaveCount() { return SkiaApi.sk_canvas_get_save_count (cast(sk_canvas_t*)Handle); }

	// DrawVertices

	void DrawVertices (SKVertexMode vmode, SKPoint[] vertices, SKColor[] colors, SKPaint paint)
	{
		auto vert = SKVertices.CreateCopy (vmode, vertices, colors);
		DrawVertices (vert, SKBlendMode.Modulate, paint);
	}

	void DrawVertices (SKVertexMode vmode, SKPoint[] vertices, SKPoint[] texs, SKColor[] colors, SKPaint paint)
	{
		auto vert = SKVertices.CreateCopy (vmode, vertices, texs, colors);
		DrawVertices (vert, SKBlendMode.Modulate, paint);
	}

	void DrawVertices (SKVertexMode vmode, SKPoint[] vertices, SKPoint[] texs, SKColor[] colors, ushort[] indices, SKPaint paint)
	{
		auto vert = SKVertices.CreateCopy (vmode, vertices, texs, colors, indices);
		DrawVertices (vert, SKBlendMode.Modulate, paint);
	}

	void DrawVertices (SKVertexMode vmode, SKPoint[] vertices, SKPoint[] texs, SKColor[] colors, SKBlendMode mode, ushort[] indices, SKPaint paint)
	{
		auto vert = SKVertices.CreateCopy (vmode, vertices, texs, colors, indices);
		DrawVertices (vert, mode, paint);
	}

	void DrawVertices (SKVertices vertices, SKBlendMode mode, SKPaint paint)
	{
		if (vertices is null)
			throw new ArgumentNullException (vertices.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_vertices (cast(sk_canvas_t*)Handle, cast(sk_vertices_t*)vertices.Handle, mode, cast(sk_paint_t*)paint.Handle);
	}

	// DrawArc

	void DrawArc (SKRect oval, float startAngle, float sweepAngle, bool useCenter, SKPaint paint)
	{
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);
		SkiaApi.sk_canvas_draw_arc (cast(sk_canvas_t*)Handle, &oval, startAngle, sweepAngle, useCenter, cast(sk_paint_t*)paint.Handle);
	}

	// DrawRoundRectDifference

	void DrawRoundRectDifference (SKRoundRect outer, SKRoundRect inner, SKPaint paint)
	{
		if (outer is null)
			throw new ArgumentNullException (outer.stringof);
		if (inner is null)
			throw new ArgumentNullException (inner.stringof);
		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		SkiaApi.sk_canvas_draw_drrect (cast(sk_canvas_t*)Handle, cast(sk_rrect_t*)outer.Handle, cast(sk_rrect_t*)inner.Handle, cast(sk_paint_t*)paint.Handle);
	}

	// DrawAtlas

	void DrawAtlas (SKImage atlas, SKRect[] sprites, SKRotationScaleMatrix[] transforms, SKPaint paint)
	{
		return DrawAtlas (atlas, sprites, transforms, null, SKBlendMode.Dst, null, paint);
	}

	void DrawAtlas (SKImage atlas, SKRect[] sprites, SKRotationScaleMatrix[] transforms, SKColor[] colors, SKBlendMode mode, SKPaint paint)
	{
		return DrawAtlas (atlas, sprites, transforms, colors, mode, null, paint);
	}

	void DrawAtlas (SKImage atlas, SKRect[] sprites, SKRotationScaleMatrix[] transforms, SKColor[] colors, SKBlendMode mode, SKRect cullRect, SKPaint paint)
	{
		return DrawAtlas (atlas, sprites, transforms, colors, mode, &cullRect, paint);
	}

	private void DrawAtlas (SKImage atlas, SKRect[] sprites, SKRotationScaleMatrix[] transforms, SKColor[] colors, SKBlendMode mode, SKRect* cullRect, SKPaint paint)
	{
		if (atlas is null)
			throw new ArgumentNullException (atlas.stringof);
		if (sprites is null)
			throw new ArgumentNullException (sprites.stringof);
		if (transforms is null)
			throw new ArgumentNullException (transforms.stringof);

		if (transforms.length != sprites.length)
			throw new ArgumentException ("The number of transforms must match the number of sprites.", transforms.stringof);
		if (colors !is null && colors.length != sprites.length)
			throw new ArgumentException ("The number of colors must match the number of sprites.", colors.stringof);

		SKRect* s = sprites.ptr;
		SKRotationScaleMatrix* t = transforms.ptr;
		SKColor* c = colors.ptr;
		SkiaApi.sk_canvas_draw_atlas (cast(sk_canvas_t*)Handle, cast(sk_image_t*)atlas.Handle, t, s, cast(uint*)c, cast(int)transforms.length, mode,cullRect,  cast(sk_paint_t*)paint.Handle);
	}

	// DrawPatch

	void DrawPatch (SKPoint[] cubics, SKColor[] colors, SKPoint[] texCoords, SKPaint paint)
	{
		return DrawPatch (cubics, colors, texCoords, SKBlendMode.Modulate, paint);
	}

	void DrawPatch (SKPoint[] cubics, SKColor[] colors, SKPoint[] texCoords, SKBlendMode mode, SKPaint paint)
	{
		if (cubics is null)
			throw new ArgumentNullException (cubics.stringof);
		if (cubics.length != PatchCubicsCount)
			throw new ArgumentException ("Cubics must have a length of {PatchCubicsCount}."~cubics.stringof);

		if (colors !is null && colors.length != PatchCornerCount)
			throw new ArgumentException ("Colors must have a length of {PatchCornerCount}."~colors.stringof);

		if (texCoords !is null && texCoords.length != PatchCornerCount)
			throw new ArgumentException ("Texture coordinates must have a length of {PatchCornerCount}."~texCoords.stringof);

		if (paint is null)
			throw new ArgumentNullException (paint.stringof);

		SKPoint* cubes = cubics.ptr;
		SKColor* cols = colors.ptr;
		SKPoint* coords = texCoords.ptr;
		SkiaApi.sk_canvas_draw_patch (cast(sk_canvas_t*)Handle, cubes, cast(uint*)cols, coords, mode, cast(sk_paint_t*)paint.Handle);
	}

	static SKCanvas GetObject (void* handle, bool owns = true, bool unrefExisting = true)
	{
		  return GetOrAddObject!(SKCanvas)(handle, owns, unrefExisting, 
		  		(h,o) { 
			  		return new SKCanvas (h, o);
			  	});
	}
}

class SKAutoCanvasRestore : IDisposable
{
	private SKCanvas canvas;
	private int saveCount;

	this (SKCanvas canvas)
	{
    this (canvas, true);
  }

	this (SKCanvas canvas, bool doSave)
	{
		this.canvas = canvas;
		this.saveCount = 0;

		if (canvas !is null) {
			saveCount = canvas.SaveCount();
			if (doSave) {
				canvas.Save ();
			}
		}
	}

	void Dispose ()
	{
		Restore ();
	}

	/// <summary>
	/// Perform the restore now, instead of waiting for the Dispose.
	/// Will only do this once.
	/// </summary>
	void Restore ()
	{
		if (canvas !is null) {
			canvas.RestoreToCount (saveCount);
			canvas = null;
		}
	}
}
