module skia.SKCodec;

import skia.Exceptions;
import skia.SkiaApi;
import skia.SKImageInfo;
import skia.SKObject;
import skia.SKColorTable;
import skia.SKColorTable;
import skia.SKStream;
import skia.SKData;
import skia.Definitions;
import skia.MathTypes;
import skia.Definitions;

// TODO: `Create(...)` should have overloads that accept a SKPngChunkReader
// TODO: missing the `QueryYuv8` and `GetYuv8Planes` members

class SKCodec : SKObject, ISKSkipObjectRegistration
{
	this (void* handle, bool owns)
	{
		super (handle, owns);
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
		return SkiaApi.sk_codec_destroy (cast(sk_codec_t*)Handle);
	}

	static int MinBufferedBytesNeeded ()
	{
		return cast(int)SkiaApi.sk_codec_min_buffered_bytes_needed ();
	}

	SKImageInfo Info() {
		SKImageInfoNative cinfo;
		SkiaApi.sk_codec_get_info (cast(sk_codec_t*)Handle, &cinfo);
		return SKImageInfo.ToManaged (cinfo);
	}

	SKCodecOrigin Origin()
	{
		return cast(SKCodecOrigin)EncodedOrigin;
	}

	SKEncodedOrigin EncodedOrigin()
	{
		return SkiaApi.sk_codec_get_origin (cast(sk_codec_t*)Handle);
	}

	SKEncodedImageFormat EncodedFormat()
	{
		return SkiaApi.sk_codec_get_encoded_format (cast(sk_codec_t*)Handle);
	}

	SKSizeI GetScaledDimensions (float desiredScale)
	{
		SKSizeI dimensions;
		SkiaApi.sk_codec_get_scaled_dimensions (cast(sk_codec_t*)Handle, desiredScale, &dimensions);
		return dimensions;
	}

	bool GetValidSubset (ref SKRectI desiredSubset)
	{
		SKRectI* ds = &desiredSubset;
		return SkiaApi.sk_codec_get_valid_subset (cast(sk_codec_t*)Handle, ds);
	}

	byte[] Pixels() {
		byte[] pixels;
		SKCodecResult result = GetPixels (pixels);
		if (result != SKCodecResult.Success && result != SKCodecResult.IncompleteInput) {
			throw new Exception (result.stringof);
		}
		return pixels;
	}

	// frames

	int RepetitionCount()
	{
		return SkiaApi.sk_codec_get_repetition_count (cast(sk_codec_t*)Handle);
	}

	int FrameCount()
	{
		return SkiaApi.sk_codec_get_frame_count (cast(sk_codec_t*)Handle);
	}

	SKCodecFrameInfo[] FrameInfo() {
		int length = SkiaApi.sk_codec_get_frame_count (cast(sk_codec_t*)Handle);
		SKCodecFrameInfo[] info = new SKCodecFrameInfo[length];
		SKCodecFrameInfo* i = info.ptr;
		SkiaApi.sk_codec_get_frame_info (cast(sk_codec_t*)Handle, i);

		return info;
	}

	bool GetFrameInfo (int index, out SKCodecFrameInfo frameInfo)
	{
		SKCodecFrameInfo* f = &frameInfo;
		return SkiaApi.sk_codec_get_frame_info_for_index (cast(sk_codec_t*)Handle, index, f);
	}

	// pixels

	SKCodecResult GetPixels (out byte[] pixels)
	{
		return GetPixels (Info,  pixels);
	}

	SKCodecResult GetPixels (SKImageInfo info, out byte[] pixels)
	{
		pixels = new byte[info.BytesSize];
		return GetPixels (info, pixels);
	}

	SKCodecResult GetPixels (SKImageInfo info, byte[] pixels)
	{
		if (pixels is null)
			throw new ArgumentNullException (pixels.stringof);

		byte* p = pixels.ptr;
		return GetPixels (info, cast(void*)p, info.RowBytes, SKCodecOptions.Default);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels)
	{
		return GetPixels (info, pixels, info.RowBytes, SKCodecOptions.Default);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, SKCodecOptions options)
	{
		return GetPixels (info, pixels, info.RowBytes, options);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options)
	{
		if (pixels is null)
			throw new ArgumentNullException (pixels.stringof);

		auto nInfo = SKImageInfo.FromManaged (info);
		SKCodecOptionsInternal nOptions = SKCodecOptionsInternal(
			options.ZeroInitialized,
			null,
			options.FrameIndex,
			options.PriorFrame,
		);

		// auto subset = default (SKRectI);
		if (options.HasSubset) {
			SKRectI subset = options.Subset.get;
			nOptions.fSubset = &subset;
		}
		return SkiaApi.sk_codec_get_pixels (cast(sk_codec_t*)Handle, &nInfo, cast(void*)pixels, cast(size_t)rowBytes, &nOptions);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options, void* colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, rowBytes, options);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, SKCodecOptions options, void* colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, info.RowBytes, options);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, void* colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, info.RowBytes, SKCodecOptions.Default);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options, SKColorTable colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, rowBytes, options);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, SKCodecOptions options, SKColorTable colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, info.RowBytes, options);
	}

	SKCodecResult GetPixels (SKImageInfo info, void* pixels, SKColorTable colorTable, ref int colorTableCount)
	{
		return GetPixels (info, pixels, info.RowBytes, SKCodecOptions.Default);
	}

	// incremental (start)

	SKCodecResult StartIncrementalDecode (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options)
	{
		if (pixels is null)
			throw new ArgumentNullException (pixels.stringof);

		auto nInfo = SKImageInfo.FromManaged (info);
		SKCodecOptionsInternal nOptions = SKCodecOptionsInternal();
     {
			nOptions.fZeroInitialized = options.ZeroInitialized;
			nOptions.fSubset = null;
			nOptions.fFrameIndex = options.FrameIndex;
			nOptions.fPriorFrame = options.PriorFrame;
		}
		// SKRectI subset = default (SKRectI);
		if (options.HasSubset) {
			SKRectI subset = (options.Subset.get);
			nOptions.fSubset = &subset;
		}

		return SkiaApi.sk_codec_start_incremental_decode (cast(sk_codec_t*)Handle, &nInfo, cast(void*)pixels, cast(void*)rowBytes, &nOptions);
	}

	SKCodecResult StartIncrementalDecode (SKImageInfo info, void* pixels, int rowBytes)
	{
		auto cinfo = SKImageInfo.FromManaged (info);
		return SkiaApi.sk_codec_start_incremental_decode (cast(sk_codec_t*)Handle, &cinfo, cast(void*)pixels, cast(void*)rowBytes, null);
	}

	SKCodecResult StartIncrementalDecode (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options, void* colorTable, ref int colorTableCount)
	{
		return StartIncrementalDecode (info, pixels, rowBytes, options);
	}

	SKCodecResult StartIncrementalDecode (SKImageInfo info, void* pixels, int rowBytes, SKCodecOptions options, SKColorTable colorTable, ref int colorTableCount)
	{
		return StartIncrementalDecode (info, pixels, rowBytes, options);
	}

	// incremental (step)

	SKCodecResult IncrementalDecode (out int rowsDecoded)
	{
		int* r = &rowsDecoded;
		return SkiaApi.sk_codec_incremental_decode (cast(sk_codec_t*)Handle, r);
	}

	SKCodecResult IncrementalDecode ()
	{
		return SkiaApi.sk_codec_incremental_decode (cast(sk_codec_t*)Handle, null);
	}

	// scanline (start)

	SKCodecResult StartScanlineDecode (SKImageInfo info, SKCodecOptions options)
	{
		auto nInfo = SKImageInfo.FromManaged (info);
		SKCodecOptionsInternal nOptions =  SKCodecOptionsInternal(); {
			nOptions.fZeroInitialized = options.ZeroInitialized;
			nOptions.fSubset = null;
			nOptions.fFrameIndex = options.FrameIndex;
			nOptions.fPriorFrame = options.PriorFrame;
		}
		// SKRectI subset = default (SKRectI);
		if (options.HasSubset) {
			SKRectI subset = options.Subset.get;
			nOptions.fSubset = &subset;
		}

		return SkiaApi.sk_codec_start_scanline_decode (cast(sk_codec_t*)Handle, &nInfo, &nOptions);
	}

	SKCodecResult StartScanlineDecode (SKImageInfo info)
	{
		auto cinfo = SKImageInfo.FromManaged (info);
		return SkiaApi.sk_codec_start_scanline_decode (cast(sk_codec_t*)Handle, &cinfo, null);
	}

	SKCodecResult StartScanlineDecode (SKImageInfo info, SKCodecOptions options, void* colorTable, ref int colorTableCount)
	{
		return StartScanlineDecode (info, options);
	}

	SKCodecResult StartScanlineDecode (SKImageInfo info, SKCodecOptions options, SKColorTable colorTable, ref int colorTableCount)
	{
		return StartScanlineDecode (info, options);
	}

	// scanline (step)

	int GetScanlines (void* dst, int countLines, int rowBytes)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);

		return SkiaApi.sk_codec_get_scanlines (cast(sk_codec_t*)Handle, cast(void*)dst, countLines, cast(size_t)rowBytes);
	}

	bool SkipScanlines (int countLines)
	{
		return SkiaApi.sk_codec_skip_scanlines (cast(sk_codec_t*)Handle, countLines);
	}

	SKCodecScanlineOrder ScanlineOrder()
	{
		return SkiaApi.sk_codec_get_scanline_order (cast(sk_codec_t*)Handle);
	}

	int NextScanline()
	{
		return SkiaApi.sk_codec_next_scanline (cast(sk_codec_t*)Handle);
	}

	int GetOutputScanline (int inputScanline)
	{
		return SkiaApi.sk_codec_output_scanline (cast(sk_codec_t*)Handle, inputScanline);
	}

	// create (streams)

	static SKCodec Create (string filename)
	{
		SKCodecResult result;
		return Create (filename, result);
	}

	static SKCodec Create (string filename, ref SKCodecResult result)
	{
		SKStreamAsset stream = SKFileStream.OpenStream (filename);
		if (stream is null) {
			result = SKCodecResult.InternalError;
			return null;
		}

		return Create (stream,  result);
	}

	// static SKCodec Create (Stream stream)
	// {
	// 	SKCodecResult result;
	// 	return Create (stream, result);
	// }

	// static SKCodec Create (Stream stream, ref SKCodecResult result)
	// {
	// 	return Create (WrapManagedStream (stream),  result);
	// }

	static SKCodec Create (SKStream stream)
	{
		SKCodecResult result;
		return Create (stream, result);
	}

	static SKCodec Create (SKStream stream, ref SKCodecResult result)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

		SKCodecResult* r = &result;
		auto codec = GetObject (SkiaApi.sk_codec_new_from_stream (cast(sk_stream_t*)stream.Handle, r));
		stream.RevokeOwnership (codec);
		return codec;
	}

	// create (data)

	static SKCodec Create (SKData data)
	{
		if (data is null)
			throw new ArgumentNullException (data.stringof);

		return GetObject (SkiaApi.sk_codec_new_from_data (cast(sk_data_t*)data.Handle));
	}

	// utils

	// static SKStream WrapManagedStream (Stream stream)
	// {
	// 	if (&stream is null) {
	// 		throw new ArgumentNullException (stream.stringof);
	// 	}

	// 	// we will need a seekable stream, so buffer it if need be
	// 	if (stream.CanSeek) {
	// 		return new SKManagedStream (stream, true);
	// 	} else {
	// 		return new SKFrontBufferedManagedStream (stream, MinBufferedBytesNeeded, true);
	// 	}
	// }

	static SKCodec GetObject (void* handle)
	{
		return handle is null ? null : new SKCodec (handle, true);
	}
}
