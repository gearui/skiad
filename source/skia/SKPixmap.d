module skia.SKPixmap;

import skia.SkiaApi;
import skia.SKImageInfo;
import skia.SKObject;
import skia.MathTypes;
import skia.SKColorTable;
import skia.SKColor;
import skia.SKColorF;
import skia.SKColorSpace;
import skia.Definitions;
import skia.SKStream;
import skia.SKImage;
import skia.Exceptions;
import skia.SKData;
import skia.SKBitmap;

class SKPixmap : SKObject
{
	private const string UnableToCreateInstanceMessage = "Unable to create a new SKPixmap instance.";

	// this is not meant to be anything but a GC reference to keep the actual pixel data alive
	SKObject pixelSource;

	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	this ()
	{
    this (SkiaApi.sk_pixmap_new (), true);
		if (Handle is null) {
			throw new InvalidOperationException (UnableToCreateInstanceMessage);
		}
	}

	this (SKImageInfo info, void* addr)
	{
    this (info, addr, info.RowBytes);
	}

	this (SKImageInfo info, void* addr, int rowBytes, SKColorTable ctable)
	{
    this (info, addr, info.RowBytes);
	}

	this (SKImageInfo info, void* addr, int rowBytes)
	{
    this (null, true);
		auto cinfo = SKImageInfo.FromManaged ( info);
		Handle = SkiaApi.sk_pixmap_new_with_params (&cinfo, cast(void*)addr, cast(void*)rowBytes);
		if (Handle is null) {
			throw new InvalidOperationException (UnableToCreateInstanceMessage);
		}
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
    return 	SkiaApi.sk_pixmap_destructor (cast(sk_pixmap_t*)Handle);
  }
	

	protected override void DisposeManaged ()
	{
		super.DisposeManaged ();

		pixelSource = null;
	}

	// Reset

	void Reset ()
	{
		SkiaApi.sk_pixmap_reset (cast(sk_pixmap_t*)Handle);
		pixelSource = null;
	}

	void Reset (SKImageInfo info, void* addr, int rowBytes, SKColorTable ctable)
	{
		Reset (info, addr, rowBytes);
	}

	void Reset (SKImageInfo info, void* addr, int rowBytes)
	{
		auto cinfo = SKImageInfo.FromManaged (info);
		SkiaApi.sk_pixmap_reset_with_params (cast(sk_pixmap_t*)Handle, &cinfo, cast(void*)addr, cast(void*)rowBytes);
		pixelSource = null;
	}

	// properties

	SKImageInfo Info()
	{
		SKImageInfoNative cinfo;
		SkiaApi.sk_pixmap_get_info (cast(sk_pixmap_t*)Handle, &cinfo);
		return SKImageInfo.ToManaged ( cinfo);
	}

	int Width()
  {
    return Info.Width;
  } 

	int Height()
  {
    return Info.Height;
  } 

	SKSizeI Size() 
	{
		auto info = Info;
		return SKSizeI (info.Width, info.Height);
	}

	SKRectI Rect()
  {
    return SKRectI.Create (Size);
  } 

	SKColorType ColorType()
  {
    return Info.ColorType;
  } 

	SKAlphaType AlphaType()
  {
    return Info.AlphaType;
  }

	SKColorSpace ColorSpace()
  {
    return Info.ColorSpace;
  } 

	int BytesPerPixel()
  {
    return Info.BytesPerPixel;
  } 

	int RowBytes()
  {
    return cast(int)SkiaApi.sk_pixmap_get_row_bytes (cast(sk_pixmap_t*)Handle);
  }

	int BytesSize()
  {
    return Info.BytesSize;
  }

	// pixels

	void* GetPixels ()
  {
    return cast(void*)SkiaApi.sk_pixmap_get_pixels (cast(sk_pixmap_t*)Handle);
  }
		

	void* GetPixels (int x, int y)
  {
    return cast(void*)SkiaApi.sk_pixmap_get_pixels_with_xy (cast(sk_pixmap_t*)Handle, x, y);
  }
		

	const(byte)[] GetPixelSpan ()
  {
	  const(void)* dataPtr = SkiaApi.sk_pixmap_get_pixels (cast(sk_pixmap_t*)Handle);
    return cast(const(byte)[])(dataPtr[0..BytesSize]);
  }
		

	// unsafe T[] GetPixelSpan<T> ()
	// 	where T : unmanaged
	// {
	// 	auto info = Info;
	// 	if (info.empty())
	// 		return null;

	// 	auto bpp = info.BytesPerPixel;
	// 	if (bpp <= 0)
	// 		return null;

	// 	// byte is always valid
	// 	if (typeof (T) == typeof (byte))
	// 		return new T[] (SkiaApi.sk_pixmap_get_writable_addr (Handle), info.BytesSize);

	// 	// other types need to make sure they fit
	// 	auto size = sizeof (T);
	// 	if (bpp != size)
	// 		throw new ArgumentException ("Size of T ({size}) is not the same as the size of each pixel ({bpp}).", T.stringof);

	// 	return new T[] (SkiaApi.sk_pixmap_get_writable_addr (Handle), info.Width * info.Height);
	// }

	SKColor GetPixelColor (int x, int y)
	{
		return cast(SKColor)SkiaApi.sk_pixmap_get_pixel_color (cast(sk_pixmap_t*)Handle, x, y);
	}

	// ColorTable

	SKColorTable ColorTable()
  {
    return null;
  }

	// Resize

	static bool Resize (SKPixmap dst, SKPixmap src, SKBitmapResizeMethod method)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ScalePixels (dst, method.ToFilterQuality ());
	}

	// ScalePixels

	bool ScalePixels (SKPixmap destination, SKFilterQuality quality)
	{
		if (destination is null)
			throw new ArgumentNullException (destination.stringof);

		return SkiaApi.sk_pixmap_scale_pixels (cast(sk_pixmap_t*)Handle, cast(sk_pixmap_t*)destination.Handle, quality);
	}

	// ReadPixels

	bool ReadPixels (SKImageInfo dstInfo, void* dstPixels, int dstRowBytes, int srcX, int srcY, SKTransferFunctionBehavior behavior)
  {
    return ReadPixels (dstInfo, dstPixels, dstRowBytes, srcX, srcY);
  }
		

	bool ReadPixels (SKImageInfo dstInfo, void* dstPixels, int dstRowBytes, int srcX, int srcY)
	{
		auto cinfo = SKImageInfo.FromManaged ( dstInfo);
		return SkiaApi.sk_pixmap_read_pixels (cast(sk_pixmap_t*)Handle, &cinfo, cast(void*)dstPixels, cast(void*)dstRowBytes, srcX, srcY);
	}

	bool ReadPixels (SKImageInfo dstInfo, void* dstPixels, int dstRowBytes)	
  {
		return ReadPixels (dstInfo, dstPixels, dstRowBytes, 0, 0);
	}

	bool ReadPixels (SKPixmap pixmap, int srcX, int srcY)	
  {
		return ReadPixels (pixmap.Info, pixmap.GetPixels (), pixmap.RowBytes, srcX, srcY);
	}

	bool ReadPixels (SKPixmap pixmap)	
  {
		return ReadPixels (pixmap.Info, pixmap.GetPixels (), pixmap.RowBytes, 0, 0);
	}

	// Encode

	SKData Encode (SKEncodedImageFormat encoder, int quality)
	{
		auto stream =  new SKDynamicMemoryWStream ();
		scope(exit) {
		    stream.Dispose();
		}

		auto result = Encode (stream, encoder, quality);
		return result ? stream.DetachAsData () : null;
	}

	// bool Encode (Stream dst, SKEncodedImageFormat encoder, int quality)
	// {
	// 	if (dst is null)
	// 		throw new ArgumentNullException (dst.stringof);

	// 	auto wrapped =  new SKManagedWStream (dst);
	// 	scope(exit) {
	// 	    wrapped.Dispose();
	// 	}

	// 	return Encode (wrapped, encoder, quality);
	// }

	bool Encode (SKWStream dst, SKEncodedImageFormat encoder, int quality)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		return SkiaApi.sk_pixmap_encode_image (cast(sk_wstream_t*)dst.Handle, cast(sk_pixmap_t*)Handle, encoder, quality);
	}

	static bool Encode (SKWStream dst, SKBitmap src, SKEncodedImageFormat format, int quality)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.Encode (dst, format, quality);
	}

	static bool Encode (SKWStream dst, SKPixmap src, SKEncodedImageFormat encoder, int quality)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.Encode (dst, encoder, quality);
	}

	// Encode (webp)

	SKData Encode (SKWebpEncoderOptions options)
	{
		auto stream =  new SKDynamicMemoryWStream ();
		scope(exit) {
		    stream.Dispose();
		}

		auto result = Encode (stream, options);
		return result ? stream.DetachAsData () : null;
	}

	// bool Encode (Stream dst, SKWebpEncoderOptions options)
	// {
	// 	if (dst is null)
	// 		throw new ArgumentNullException (dst.stringof);

	// 	auto wrapped =  new SKManagedWStream (dst);
	// 	scope(exit) {
	// 	    wrapped.Dispose();
	// 	}

	// 	return Encode (wrapped, options);
	// }

	bool Encode (SKWStream dst, SKWebpEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		return SkiaApi.sk_webpencoder_encode (cast(sk_wstream_t*)dst.Handle, cast(sk_pixmap_t*)Handle, &options);
	}

	static bool Encode (SKWStream dst, SKPixmap src, SKWebpEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.Encode (dst, options);
	}

	// Encode (jpeg)

	SKData Encode (SKJpegEncoderOptions options)
	{
		auto stream =  new SKDynamicMemoryWStream ();
		scope(exit) {
		    stream.Dispose();
		}

		auto result = Encode (stream, options);
		return result ? stream.DetachAsData () : null;
	}

	// bool Encode (Stream dst, SKJpegEncoderOptions options)
	// {
	// 	if (dst is null)
	// 		throw new ArgumentNullException (dst.stringof);

	// 	auto wrapped =  new SKManagedWStream (dst);
	// 	scope(exit) {
	// 	    wrapped.Dispose();
	// 	}

	// 	return Encode (wrapped, options);
	// }

	bool Encode (SKWStream dst, SKJpegEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		return SkiaApi.sk_jpegencoder_encode (cast(sk_wstream_t*)dst.Handle,cast(sk_pixmap_t*) Handle, &options);
	}

	static bool Encode (SKWStream dst, SKPixmap src, SKJpegEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.Encode (dst, options);
	}

	// Encode (png)

	SKData Encode (SKPngEncoderOptions options)
	{
		auto stream =  new SKDynamicMemoryWStream ();
		scope(exit) {
		    stream.Dispose();
		}

		auto result = Encode (stream, options);
		return result ? stream.DetachAsData () : null;
	}

	// bool Encode (Stream dst, SKPngEncoderOptions options)
	// {
	// 	if (dst is null)
	// 		throw new ArgumentNullException (dst.stringof);

	// 	auto wrapped =  new SKManagedWStream (dst);
	// 	scope(exit) {
	// 	    wrapped.Dispose();
	// 	}

	// 	return Encode (wrapped, options);
	// }

	bool Encode (SKWStream dst, SKPngEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		return SkiaApi.sk_pngencoder_encode (cast(sk_wstream_t*)dst.Handle,cast(sk_pixmap_t*)Handle, &options);
	}

	static bool Encode (SKWStream dst, SKPixmap src, SKPngEncoderOptions options)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.Encode (dst, options);
	}

	// ExtractSubset

	SKPixmap ExtractSubset (SKRectI subset)
	{
		auto result = new SKPixmap ();
		if (!ExtractSubset (result, subset)) {
			result.Dispose ();
			result = null;
		}
		return result;
	}

	bool ExtractSubset (SKPixmap result, SKRectI subset)
	{
		if (result is null)
			throw new ArgumentNullException (result.stringof);

		return SkiaApi.sk_pixmap_extract_subset (cast(sk_pixmap_t*)Handle, cast(sk_pixmap_t*)result.Handle, &subset);
	}

	// Erase

	bool Erase (SKColor color)
	{
		return Erase (color, Rect);
	}

	bool Erase (SKColor color, SKRectI subset)
	{
		return SkiaApi.sk_pixmap_erase_color (cast(sk_pixmap_t*)Handle, cast(uint)color, &subset);
	}

	bool Erase (SKColorF color)	
  {
		return Erase (color, Rect);
	}

	bool Erase (SKColorF color, SKRectI subset)	
  {
		return SkiaApi.sk_pixmap_erase_color4f (cast(sk_pixmap_t*)Handle, &color, &subset);
	}

	// With*

	SKPixmap WithColorType (SKColorType newColorType)
	{
		return new SKPixmap (Info.WithColorType (newColorType), GetPixels (), RowBytes);
	}

	SKPixmap WithColorSpace (SKColorSpace newColorSpace)
	{
		return new SKPixmap (Info.WithColorSpace (newColorSpace), GetPixels (), RowBytes);
	}

	SKPixmap WithAlphaType (SKAlphaType newAlphaType)
	{
		return new SKPixmap (Info.WithAlphaType (newAlphaType), GetPixels (), RowBytes);
	}
}
