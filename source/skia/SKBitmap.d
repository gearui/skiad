module skia.SKBitmap;

import skia.Exceptions;
import skia.SkiaApi;
import skia.SKCodec;
import skia.SKImageInfo;
import skia.SKObject;
import skia.MathTypes;
import skia.SKColorTable;
import skia.SKColor;
import skia.SKPMColor;
import skia.SKColorSpace;
import skia.SKPaint;
import skia.Definitions;
import skia.SKStream;
import skia.SKData;
import skia.SKPixmap;
import skia.SkiaApi;
import skia.SKImageInfo;
import skia.SKObject;
import skia.SKImage;
import skia.SKShader;
import skia.SKMatrix;
import skia.SKCanvas;
import skia.DelegateProxies;
import skia.SKMask;


import std.format;

enum SKBitmapResizeMethod
{
	Box,
	Triangle,
	Lanczos3,
	Hamming,
	Mitchell
}

SKFilterQuality ToFilterQuality (SKBitmapResizeMethod method)
{
	switch (method) {
		case SKBitmapResizeMethod.Box:
		case SKBitmapResizeMethod.Triangle:
			return SKFilterQuality.Low;
		case SKBitmapResizeMethod.Lanczos3:
			return SKFilterQuality.Medium;
		case SKBitmapResizeMethod.Hamming:
		case SKBitmapResizeMethod.Mitchell:
			return SKFilterQuality.High;
		default:
			return SKFilterQuality.Medium;
	}
}
	

// TODO: keep in mind SKBitmap may be going away (according to Google)
// TODO: `ComputeIsOpaque` may be useful
// TODO: `GenerationID` may be useful
// TODO: `GetAddr` and `GetPixel` are confusing

class SKBitmap : SKObject, ISKSkipObjectRegistration
{
	private enum string UnsupportedColorTypeMessage = "Setting the ColorTable is only supported for bitmaps with ColorTypes of Index8.";
	private enum string UnableToAllocatePixelsMessage = "Unable to allocate pixels for the bitmap.";

	this (void* handle, bool owns)
	{
		super (handle, owns);
	}

	this () {
		this (SkiaApi.sk_bitmap_new (), true);
		if (Handle is null) {
			throw new InvalidOperationException ("Unable to create a new SKBitmap instance.");
		}
	}

	this (int width, int height, bool isOpaque = false) {
		this (width, height, SKImageInfo.PlatformColorType, isOpaque ? SKAlphaType.Opaque : SKAlphaType.Premul);
	}

	this (int width, int height, SKColorType colorType, SKAlphaType alphaType) {
		this ( SKImageInfo (width, height, colorType, alphaType));
	}

	this (int width, int height, SKColorType colorType, SKAlphaType alphaType, SKColorSpace colorspace) {
		this ( SKImageInfo (width, height, colorType, alphaType, colorspace));
	}

	this (SKImageInfo info) {
		this (info, info.RowBytes);
	}

	this (SKImageInfo info, int rowBytes) {
		this ();
		if (!TryAllocPixels (info, rowBytes)) {
			throw new Exception (UnableToAllocatePixelsMessage);
		}
	}

	this (SKImageInfo info, SKColorTable ctable, SKBitmapAllocFlags flags) {
		this (info, SKBitmapAllocFlags.None);
	}

	this (SKImageInfo info, SKBitmapAllocFlags flags) {
		this ();
		if (!TryAllocPixels (info, flags)) {
			throw new Exception (UnableToAllocatePixelsMessage);
		}
	}

	this (SKImageInfo info, SKColorTable ctable) {
		this (info, SKBitmapAllocFlags.None);
	}

	protected override void Dispose (bool disposing) 
	{
		return super.Dispose (disposing);
	}

  override void Dispose()
  {
    return super.Dispose();
  }

	protected override void DisposeNative () 
	{
		return SkiaApi.sk_bitmap_destructor (cast(sk_bitmap_t*)Handle);
	}

	// TryAllocPixels

	bool TryAllocPixels (SKImageInfo info)
	{
		return TryAllocPixels (info, info.RowBytes);
	}

	bool TryAllocPixels (SKImageInfo info, int rowBytes)
	{
		auto cinfo = SKImageInfo.FromManaged (info);
		return SkiaApi.sk_bitmap_try_alloc_pixels (cast(sk_bitmap_t*)Handle, &cinfo, rowBytes);
	}

	bool TryAllocPixels (SKImageInfo info, SKBitmapAllocFlags flags)
	{
		auto cinfo = SKImageInfo.FromManaged (info);
		return SkiaApi.sk_bitmap_try_alloc_pixels_with_flags (cast(sk_bitmap_t*)Handle, &cinfo, cast(uint)flags);
	}

	// Reset

	void Reset ()
	{
		SkiaApi.sk_bitmap_reset (cast(sk_bitmap_t*)Handle);
	}

	// SetImmutable

	void SetImmutable ()
	{
		SkiaApi.sk_bitmap_set_immutable (cast(sk_bitmap_t*)Handle);
	}

	// Erase

	void Erase (SKColor color)
	{
		SkiaApi.sk_bitmap_erase (cast(sk_bitmap_t*)Handle, cast(uint)color);
	}

	void Erase (SKColor color, SKRectI rect)
	{
		SkiaApi.sk_bitmap_erase_rect (cast(sk_bitmap_t*)Handle, cast(uint)color, &rect);
	}

	// GetAddr*

	byte GetAddr8 (int x, int y) { return *SkiaApi.sk_bitmap_get_addr_8 (cast(sk_bitmap_t*)Handle, x, y); }

	ushort GetAddr16 (int x, int y) { return *SkiaApi.sk_bitmap_get_addr_16 (cast(sk_bitmap_t*)Handle, x, y); }

	uint GetAddr32 (int x, int y) { return *SkiaApi.sk_bitmap_get_addr_32 (cast(sk_bitmap_t*)Handle, x, y); }

	void* GetAddr (int x, int y) { return GetAddress (x, y); }

	// GetAddress

	void* GetAddress (int x, int y)
	{
		return cast(void*)SkiaApi.sk_bitmap_get_addr (cast(sk_bitmap_t*)Handle, x, y);
	}

	// Pixels (color)

	// SKPMColor GetIndex8Color (int x, int y)
	// {
	// 	return GetPixel (x, y);
	// }

	SKColor GetPixel (int x, int y)
	{
		return cast(SKColor)SkiaApi.sk_bitmap_get_pixel_color (cast(sk_bitmap_t*)Handle, x, y);
	}

	void SetPixel (int x, int y, SKColor color)
	{
		SKImageInfo info = Info();
		if (x < 0 || x >= info.Width)
			throw new ArgumentOutOfRangeException (x.stringof);
		if (y < 0 || y >= info.Height)
			throw new ArgumentOutOfRangeException (y.stringof);

		SKCanvas canvas = new SKCanvas (this);
		scope(exit) {
			canvas.Dispose();
		}
		canvas.DrawPoint (x, y, color);
	}

	// Copy

	bool CanCopyTo (SKColorType colorType)
	{
		// TODO: optimize as this does more work that we really want

		if (colorType == SKColorType.Unknown)
			return false;

		SKBitmap bmp = new SKBitmap();
		scope(exit) {
		    bmp.Dispose();
		}

		auto info = Info
			.WithColorType (colorType)
			.WithSize (1, 1);
		return bmp.TryAllocPixels (info);
	}

	SKBitmap Copy ()
	{
		return Copy (ColorType);
	}

	SKBitmap Copy (SKColorType colorType)
	{
		auto destination = new SKBitmap ();
		if (!CopyTo (destination, colorType)) {
			destination.Dispose ();
			destination = null;
		}
		return destination;
	}

	bool CopyTo (SKBitmap destination)
	{
		if (destination is null) {
			throw new ArgumentNullException (destination.stringof);
		}
		return CopyTo (destination, ColorType);
	}

	bool CopyTo (SKBitmap destination, SKColorType colorType)
	{
		if (destination is null)
			throw new ArgumentNullException (destination.stringof);

		if (colorType == SKColorType.Unknown)
			return false;

		auto srcPixmap = PeekPixels();
		scope(exit) {
		    srcPixmap.Dispose();
		}
		if (srcPixmap is null)
			return false;

		SKBitmap temp = new SKBitmap();
		scope(exit) {
		    temp.Dispose();
		}

		auto dstInfo = srcPixmap.Info.WithColorType (colorType);
		if (!temp.TryAllocPixels (dstInfo))
			return false;

		SKCanvas canvas = new SKCanvas(temp);
		scope(exit) {
		    canvas.Dispose();
		}

		SKPaint paint = new SKPaint();
		scope(exit) {
			paint.Dispose();
		}

		paint.Shader = ToShader (),
		paint.BlendMode = SKBlendMode.Src;

		canvas.DrawPaint (paint);

		destination.Swap (temp);
		return true;
	}

	// ExtractSubset

	bool ExtractSubset (SKBitmap destination, SKRectI subset)
	{
		if (destination is null) {
			throw new ArgumentNullException (destination.stringof);
		}
		return SkiaApi.sk_bitmap_extract_subset (cast(sk_bitmap_t*)Handle, cast(sk_bitmap_t*)destination.Handle, &subset);
	}

	// ExtractAlpha

	bool ExtractAlpha (SKBitmap destination)
	{
		SKPointI offset;
		return ExtractAlpha (destination, null, offset);
	}

	bool ExtractAlpha (SKBitmap destination, ref SKPointI offset)
	{
		return ExtractAlpha (destination, null, offset);
	}

	bool ExtractAlpha (SKBitmap destination, SKPaint paint)
	{
		SKPointI offset;
		return ExtractAlpha (destination, paint, offset);
	}

	bool ExtractAlpha (SKBitmap destination, SKPaint paint, ref SKPointI offset)
	{
		if (destination is null) {
			throw new ArgumentNullException (destination.stringof);
		}
		SKPointI* o = &offset;
		return SkiaApi.sk_bitmap_extract_alpha (cast(sk_bitmap_t*)Handle, cast(sk_bitmap_t*)destination.Handle, cast(sk_paint_t*)(paint is null ? null : paint.Handle), o);
	}

	// properties

	bool ReadyToDraw()
	{
		return SkiaApi.sk_bitmap_ready_to_draw (cast(sk_bitmap_t*)Handle);
	}

	SKImageInfo Info() {
		SKImageInfoNative cinfo;
		SkiaApi.sk_bitmap_get_info (cast(sk_bitmap_t*)Handle, &cinfo);
		return SKImageInfo.ToManaged (cinfo);
	}

	int Width() {
		return Info.Width;
	}

	int Height() {
		return Info.Height;
	}

	SKColorType ColorType() {
		return Info.ColorType;
	}

	SKAlphaType AlphaType() {
		return Info.AlphaType;
	}

	SKColorSpace ColorSpace() {
		return Info.ColorSpace;
	}

	int BytesPerPixel() {
		return Info.BytesPerPixel;
	}

	int RowBytes() {
		return cast(int)SkiaApi.sk_bitmap_get_row_bytes (cast(sk_bitmap_t*)Handle);
	}

	int ByteCount() {
		return cast(int)SkiaApi.sk_bitmap_get_byte_count (cast(sk_bitmap_t*)Handle);
	}

	// *Pixels*

	void* GetPixels ()
	{
		size_t length;
		return GetPixels (length);
	}

	// ReadOnlySpan!byte GetPixelSpan ()
	// {
	// 	size_t length;
	// 	return new ReadOnlySpan!byte (GetPixels (length), cast(int)length);
	// }

	void* GetPixels (ref size_t length)
	{
		size_t* l = &length;

		return cast(void*)SkiaApi.sk_bitmap_get_pixels (cast(sk_bitmap_t*)Handle, l);
	}

	void SetPixels (void* pixels)
	{
		SkiaApi.sk_bitmap_set_pixels (cast(sk_bitmap_t*)Handle, cast(void*)pixels);
	}

	void SetPixels (void* pixels, SKColorTable ct)
	{
		SetPixels (pixels);
	}

	// SetColorTable

	void SetColorTable (SKColorTable ct)
	{
		// no-op due to unsupperted action
	}

	// more properties

	// byte[] Bytes() {
	// 	byte[] array = GetPixelSpan ().ToArray ();
	// 	// GC.KeepAlive (this);
	// 	return array;
	// }

	SKColor[] Pixels() {
		auto info = Info;
		SKColor[] pixels = new SKColor[info.Width * info.Height];
		SKColor* p = pixels.ptr;
		SkiaApi.sk_bitmap_get_pixel_colors (cast(sk_bitmap_t*)Handle, cast(uint*)p);

		return pixels;
	}
	
	void Pixels(SKColor[] value) {
		if (value is null)
			throw new ArgumentNullException (value.stringof);

		SKImageInfo info = Info();
		if (info.Width * info.Height != value.length) {
			string str = format("The number of pixels must equal Width x Height, or {%d * %d}.", info.Width, info.Height);
			throw new ArgumentException (str ~ " Argument: " ~ value.stringof);
		}

		SKColor* v = value.ptr;
		SKImageInfo tempInfo =  SKImageInfo (info.Width, info.Height, SKColorType.Bgra8888, SKAlphaType.Unpremul);
		SKBitmap temp = new SKBitmap();
		scope(exit) {
			temp.Dispose();
		}
		temp.InstallPixels (tempInfo, cast(void*)v);

		auto shader = temp.ToShader ();
		scope(exit) {
			shader.Dispose();
		}

		SKCanvas canvas = new SKCanvas(this);
		scope(exit) {
			canvas.Dispose();
		}

		SKPaint paint = new SKPaint();
		scope(exit) {
			paint.Dispose();
		}
		
		paint.Shader = shader;
		paint.BlendMode = SKBlendMode.Src;
		
		canvas.DrawPaint (paint);
	}

	bool IsEmpty() {
		return Info.IsEmpty;
	}

	bool IsNull() {
		return SkiaApi.sk_bitmap_is_null (cast(sk_bitmap_t*)Handle);
	}

	bool DrawsNothing() {
		return IsEmpty || IsNull;
	}

	bool IsImmutable() {
		return SkiaApi.sk_bitmap_is_immutable (cast(sk_bitmap_t*)Handle);
	}

	bool IsVolatile() {
		return SkiaApi.sk_bitmap_is_volatile (cast(sk_bitmap_t*)Handle);
	}

	void IsVolatile(bool value) {
		SkiaApi.sk_bitmap_set_volatile (cast(sk_bitmap_t*)Handle, value); 
	}

	SKColorTable ColorTable = null;

	// DecodeBounds

	// static SKImageInfo DecodeBounds (Stream stream)
	// {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (stream);
	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}

	// 	if(codec !is null) {
	// 		SKImageInfo imageInfo = codec.Info();
	// 		if(imageInfo !is null) return imageInfo;
	// 	}

	// 	return SKImageInfo.Empty;
	// }

	static SKImageInfo DecodeBounds (SKStream stream)
	{
		if (stream is null) {
			throw new ArgumentNullException (stream.stringof);
		}
		SKCodec codec = SKCodec.Create (stream);
		scope(exit) {
			codec.Dispose();
		}

		if(codec !is null) {
			SKImageInfo imageInfo = codec.Info();
			if(&imageInfo !is null) return imageInfo;
		}

		return SKImageInfo.Empty;
	}

	static SKImageInfo DecodeBounds (SKData data)
	{
		if (data is null) {
			throw new ArgumentNullException (data.stringof);
		}

		SKCodec codec = SKCodec.Create (data);
		scope(exit) {
			codec.Dispose();
		}

		if(codec !is null) {
			SKImageInfo imageInfo = codec.Info();
			if(&imageInfo !is null) return imageInfo;
		}

		return SKImageInfo.Empty;
	}

	static SKImageInfo DecodeBounds (string filename)
	{
		if (filename is null) {
			throw new ArgumentNullException (filename.stringof);
		}

		SKCodec codec = SKCodec.Create (filename);
		scope(exit) {
			codec.Dispose();
		}

		if(codec !is null) {
			SKImageInfo imageInfo = codec.Info();
			if(&imageInfo !is null) return imageInfo;
		}

		return SKImageInfo.Empty;
	}

	// static SKImageInfo DecodeBounds (byte[] buffer)
	// {
	// 	// return DecodeBounds (buffer.AsSpan ());
	// 	byte* b = buffer.ptr;

	// 	// using var skdata = SKData.Create (cast(void*)b, buffer.Length);
	// 	using var codec = SKCodec.Create (skdata);
	// 	return codec?.Info ?? SKImageInfo.Empty;
	// }

	// static SKImageInfo DecodeBounds (ReadOnlySpan!byte buffer)
	// {
	// 	byte* b = buffer; {
	// 		using var skdata = SKData.Create ((void*)b, buffer.Length);
	// 		using var codec = SKCodec.Create (skdata);
	// 		return codec?.Info ?? SKImageInfo.Empty;
	// 	}
	// }

	// Decode

	static SKBitmap Decode (SKCodec codec)
	{
		if (codec is null) {
			throw new ArgumentNullException (codec.stringof);
		}

		SKImageInfo info = codec.Info;
		if (info.AlphaType == SKAlphaType.Unpremul) {
			info.AlphaType = SKAlphaType.Premul;
		}
		// for backwards compatibility, remove the colorspace
		info.ColorSpace = null;
		return Decode (codec, info);
	}

	static SKBitmap Decode (SKCodec codec, SKImageInfo bitmapInfo)
	{
		if (codec is null) {
			throw new ArgumentNullException (codec.stringof);
		}

		SKBitmap bitmap = new SKBitmap (bitmapInfo);
		size_t length;
		auto result = codec.GetPixels (bitmapInfo, bitmap.GetPixels (length));
		if (result != SKCodecResult.Success && result != SKCodecResult.IncompleteInput) {
			bitmap.Dispose ();
			bitmap = null;
		}
		return bitmap;
	}

	// static SKBitmap Decode (Stream stream)
	// {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (stream);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}
	// 	return Decode (codec);
	// }

	// static SKBitmap Decode (Stream stream, SKImageInfo bitmapInfo)
	// {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (stream);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}
	// 	return Decode (codec, bitmapInfo);
	// }

	// static SKBitmap Decode (SKStream stream)
	// {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (stream);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}        
				
	// 	return Decode (codec);
	// }

	// static SKBitmap Decode (SKStream stream, SKImageInfo bitmapInfo)
	// {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}
		
	// 	SKCodec codec = SKCodec.Create (stream);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}
		
	// 	return Decode (codec, bitmapInfo);
	// }

	// static SKBitmap Decode (SKData data)
	// {
	// 	if (data is null) {
	// 		throw new ArgumentNullException (data.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (data);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}

	// 	return Decode (codec);
	// }

	// static SKBitmap Decode (SKData data, SKImageInfo bitmapInfo)
	// {
	// 	if (data is null) {
	// 		throw new ArgumentNullException (data.stringof);
	// 	}

	// 	SKCodec codec = SKCodec.Create (data);
	// 	if (codec is null) {
	// 		return null;
	// 	}

	// 	scope(exit) {
	// 		codec.Dispose();
	// 	}

	// 	return Decode (codec, bitmapInfo);
	// }

	static SKBitmap Decode (string filename)
	{
		if (filename is null) {
			throw new ArgumentNullException (filename.stringof);
		}

		SKCodec codec = SKCodec.Create (filename);
		if (codec is null) {
			return null;
		}

		scope(exit) {
			codec.Dispose();
		}
		
		return Decode (codec);
	}

	static SKBitmap Decode (string filename, SKImageInfo bitmapInfo)
	{
		if (filename is null) {
			throw new ArgumentNullException (filename.stringof);
		}

		SKCodec codec = SKCodec.Create (filename);
		if (codec is null) {
			return null;
		}

		scope(exit) {
			codec.Dispose();
		}

		return Decode (codec, bitmapInfo);
	}

	static SKBitmap Decode (byte[] buffer)
	{
		// return Decode (buffer.AsSpan ());


		// byte* b = buffer.ptr;
		// auto skdata =  SKData.Create (cast(void*)b, buffer.length);
		// scope(exit) {
		//     skdata.Dispose();
		// }

		// auto codec =  SKCodec.Create (skdata);
		// scope(exit) {
		//     codec.Dispose();
		// }

		// return Decode (codec);				

    return null;
	}

	static SKBitmap Decode (byte[] buffer, SKImageInfo bitmapInfo)
	{
		// return Decode (buffer.AsSpan (), bitmapInfo);
		byte* b = buffer.ptr;
		auto skdata =  SKData.Create (cast(void*)b, buffer.length);
		scope(exit) {
		    skdata.Dispose();
		}

		auto codec =  SKCodec.Create (skdata);
		scope(exit) {
		    codec.Dispose();
		}

		return Decode (codec, bitmapInfo);
	}

	// static SKBitmap Decode (ReadOnlySpan!byte buffer)
	// {
	// 	byte* b = buffer;
	// 	using var skdata = SKData.Create (cast(void*)b, buffer.Length);
	// 	using var codec = SKCodec.Create (skdata);
	// 	return Decode (codec);
	// }

	// static SKBitmap Decode (ReadOnlySpan!byte buffer, SKImageInfo bitmapInfo)
	// {
	// 	byte* b = buffer; {
	// 		using var skdata = SKData.Create ((void*)b, buffer.Length);
	// 		using var codec = SKCodec.Create (skdata);
	// 		return Decode (codec, bitmapInfo);
	// 	}
	// }

	// InstallPixels

	bool InstallPixels (SKImageInfo info, void* pixels)
	{
		return InstallPixels (info, pixels, info.RowBytes, null, null);
	}

	bool InstallPixels (SKImageInfo info, void* pixels, int rowBytes)
	{
		return InstallPixels (info, pixels, rowBytes, null, null);
	}

	bool InstallPixels (SKImageInfo info, void* pixels, int rowBytes, SKColorTable ctable)
	{
		return InstallPixels (info, pixels, rowBytes, null, null);
	}

	bool InstallPixels (SKImageInfo info, void* pixels, int rowBytes, SKColorTable ctable, SKBitmapReleaseDelegate releaseProc, void* context)
	{
		return InstallPixels (info, pixels, rowBytes, releaseProc, context);
	}

	bool InstallPixels (SKImageInfo info, void* pixels, int rowBytes, SKBitmapReleaseDelegate releaseProc)
	{
		// return InstallPixels (info, pixels, rowBytes, releaseProc, null);
    return true;
	}

	bool InstallPixels (SKImageInfo info, void* pixels, int rowBytes, SKBitmapReleaseDelegate releaseProc, void* context)
	{
		// var cinfo = SKImageInfo.FromManaged (ref info);
		// var del = releaseProc !is null && context !is null
		// 	? new SKBitmapReleaseDelegate ((addr, _) => releaseProc (addr, context))
		// 	: releaseProc;
		// var proxy = DelegateProxies.Create (del, DelegateProxies.SKBitmapReleaseDelegateProxy, out _, out var ctx);
		// return SkiaApi.sk_bitmap_install_pixels (Handle, &cinfo, (void*)pixels, cast(void*)rowBytes, proxy, (void*)ctx);

    return true;
	}

	bool InstallPixels (SKPixmap pixmap)
	{
		return SkiaApi.sk_bitmap_install_pixels_with_pixmap (cast(sk_bitmap_t*)Handle, cast(sk_pixmap_t*)pixmap.Handle);
	}

	// InstallMaskPixels

	bool InstallMaskPixels (SKMask mask)
	{
		return SkiaApi.sk_bitmap_install_mask_pixels (cast(sk_bitmap_t*)Handle, &mask);
	}

	// NotifyPixelsChanged

	void NotifyPixelsChanged ()
	{
		SkiaApi.sk_bitmap_notify_pixels_changed (cast(sk_bitmap_t*)Handle);
	}

	// PeekPixels

	SKPixmap PeekPixels ()
	{
		SKPixmap pixmap = new SKPixmap ();
		auto result = PeekPixels (pixmap);
		if (result) {
			return pixmap;
		} else {
			pixmap.Dispose ();
			return null;
		}
	}

	bool PeekPixels (SKPixmap pixmap)
	{
		if (pixmap is null) {
			throw new ArgumentNullException (pixmap.stringof);
		}
		auto result = SkiaApi.sk_bitmap_peek_pixels (cast(sk_bitmap_t*)Handle, cast(sk_pixmap_t*)pixmap.Handle);
		if (result)
			pixmap.pixelSource = this;
		return result;
	}

	// Resize

	SKBitmap Resize (SKImageInfo info, SKBitmapResizeMethod method)
	{
		return Resize (info, method.ToFilterQuality ());
	}

	bool Resize (SKBitmap dst, SKBitmapResizeMethod method)
	{
		return ScalePixels (dst, method.ToFilterQuality ());
	}

	static bool Resize (SKBitmap dst, SKBitmap src, SKBitmapResizeMethod method)
	{
		return src.ScalePixels (dst, method.ToFilterQuality ());
	}

	SKBitmap Resize (SKImageInfo info, SKFilterQuality quality)
	{
		auto dst = new SKBitmap (info);
		if (ScalePixels (dst, quality)) {
			return dst;
		} else {
			dst.Dispose ();
			return null;
		}
	}

	SKBitmap Resize (SKSizeI size, SKFilterQuality quality)
	{
		return Resize (Info.WithSize (size), quality);
	}

	// ScalePixels

	bool ScalePixels (SKBitmap destination, SKFilterQuality quality)
	{
		if (destination is null) {
			throw new ArgumentNullException (destination.stringof);
		}

		SKPixmap dstPix = destination.PeekPixels ();
		scope(exit) {
			dstPix.Dispose();
		}

		return ScalePixels (dstPix, quality);
	}

	bool ScalePixels (SKPixmap destination, SKFilterQuality quality)
	{
		if (destination is null) {
			throw new ArgumentNullException (destination.stringof);
		}

		SKPixmap srcPix = PeekPixels ();
		scope(exit) {
			srcPix.Dispose();
		}
		return srcPix.ScalePixels (destination, quality);
	}

	// From/ToImage

	static SKBitmap FromImage (SKImage image)
	{
		if (image is null) {
			throw new ArgumentNullException (image.stringof);
		}

		SKImageInfo info =  SKImageInfo (image.Width(),image.Height(), SKImageInfo.PlatformColorType, image.AlphaType);
		SKBitmap bmp = new SKBitmap (info);
		if (!image.ReadPixels (info, cast(void*)bmp.GetPixels (), info.RowBytes, 0, 0)) {
			bmp.Dispose ();
			bmp = null;
		}
		return bmp;
	}

	// Encode

	SKData Encode (SKEncodedImageFormat format, int quality)
	{
		auto pixmap = PeekPixels();
		scope(exit) {
		    pixmap.Dispose();
		}
		return pixmap.Encode (format, quality);
	}

	// bool Encode (Stream dst, SKEncodedImageFormat format, int quality)
	// {
	// 	SKManagedWStream wrapped = new SKManagedWStream(dst);
	// 	scope(exit) {
	// 	    wrapped.Dispose();
	// 	}
	// 	return Encode (wrapped, format, quality);
	// }

	bool Encode (SKWStream dst, SKEncodedImageFormat format, int quality)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		auto pixmap = PeekPixels();
		scope(exit) {
		    pixmap.Dispose();
		}

		if(pixmap !is null) {
			return pixmap.Encode (dst, format, quality);
		}
		
		return false;
	}

	// Swap

	private void Swap (SKBitmap other)
	{
		SkiaApi.sk_bitmap_swap (cast(sk_bitmap_t*)Handle, cast(sk_bitmap_t*)other.Handle);
	}

	// ToShader

	SKShader ToShader ()
	{
		return ToShader (SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);
	}

	SKShader ToShader (SKShaderTileMode tmx, SKShaderTileMode tmy)
	{
		return SKShader.GetObject (SkiaApi.sk_bitmap_make_shader (cast(sk_bitmap_t*)Handle, tmx, tmy, null));
	}

	SKShader ToShader (SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix localMatrix)
	{
		return SKShader.GetObject (SkiaApi.sk_bitmap_make_shader (cast(sk_bitmap_t*)Handle, tmx, tmy, &localMatrix));
	}
}
