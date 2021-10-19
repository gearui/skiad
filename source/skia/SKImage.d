module skia.SKImage;

// TODO: `MakeCrossContextFromEncoded`
// TODO: `MakeFromYUVTexturesCopy` and `MakeFromNV12TexturesCopy`
// TODO: `FromPicture` with bit depth and color space
// TODO: `GetTextureHandle`
// TODO: `MakeColorSpace`

import skia.Definitions;
import skia.EnumMappings;
import skia.Exceptions;
import skia.DelegateProxies;
import skia.MathTypes;
import skia.GRContext;
import skia.GRDefinitions;
import skia.GRBackendTexture;
import skia.SKObject;
import skia.SKImageInfo;
import skia.SKStream;
import skia.SKPixmap;
import skia.SKColorTable;
import skia.SKData;
import skia.SKBitmap;
import skia.SKColorSpace;
import skia.SKPicture;
import skia.SKPaint;
import skia.SKShader;
import skia.SKPixelSerializer;
import skia.SKImageFilter;
import skia.SKMatrix;
import skia.SkiaApi;

class SKImage : SKObject {
	this(void* x, bool owns) {
		super(x, owns);
	}

	// protected override void Dispose(bool disposing) {
	// 	return super.Dispose(disposing);
	// }

	// create brand new image

	// static SKImage Create(SKImageInfo info) {
	// 	auto pixels = Marshal.AllocCoTaskMem(info.BytesSize);
	// 	SKPixmap pixmap = new SKPixmap(info, pixels);

	// 	// don't use the managed version as that is just extra overhead which isn't necessary
	// 	return GetObject(SkiaApi.sk_image_new_raster(cast(sk_pixmap_t*)pixmap.Handle,
	// 			DelegateProxies.SKImageRasterReleaseDelegateProxyForCoTaskMem, null));

	// }

	// create a new image from a copy of pixel data

	static SKImage FromPixelCopy(SKImageInfo info, SKStream pixels) {
		return FromPixelCopy(info, pixels, info.RowBytes);
	}

	static SKImage FromPixelCopy(SKImageInfo info, SKStream pixels, int rowBytes) {
		if (pixels is null)
			throw new ArgumentNullException(pixels.stringof);

		SKData data = SKData.Create(pixels);
		return FromPixels(info, data, rowBytes);
	}

	// static SKImage FromPixelCopy (SKImageInfo info, Stream pixels)
	// {
	// 	return FromPixelCopy (info, pixels, info.RowBytes);
	// }

	// static SKImage FromPixelCopy (SKImageInfo info, Stream pixels, int rowBytes)
	// {
	// 	if (pixels is null)
	// 		throw new ArgumentNullException (pixels.stringof);

	//   SKData data = SKData.Create (pixels);
	//   return FromPixels (info, data, rowBytes);
	// }

	static SKImage FromPixelCopy(SKImageInfo info, byte[] pixels) {
		return FromPixelCopy(info, pixels, info.RowBytes);
	}

	// static SKImage FromPixelCopy(SKImageInfo info, byte[] pixels, int rowBytes) {
	// 	if (pixels is null)
	// 		throw new ArgumentNullException(pixels.stringof);

	// 	SKData data = SKData.CreateCopy(pixels);
	// 	return FromPixels(info, data, rowBytes);
	// }

	static SKImage FromPixelCopy(SKImageInfo info, void* pixels) {
		return FromPixelCopy(info, pixels, info.RowBytes);
	}

	static SKImage FromPixelCopy(SKImageInfo info, void* pixels, int rowBytes) {
		if (pixels is null)
			throw new ArgumentNullException(pixels.stringof);

		auto nInfo = SKImageInfo.FromManaged(info);
		return GetObject(SkiaApi.sk_image_new_raster_copy(&nInfo,
				cast(void*) pixels, cast(void*) rowBytes));
	}

	static SKImage FromPixelCopy(SKImageInfo info, void* pixels, int rowBytes, SKColorTable ctable) {
		return FromPixelCopy(info, pixels, rowBytes);
	}

	static SKImage FromPixelCopy(SKPixmap pixmap) {
		if (pixmap is null)
			throw new ArgumentNullException(pixmap.stringof);
		return GetObject(SkiaApi.sk_image_new_raster_copy_with_pixmap(cast(sk_pixmap_t*)pixmap.Handle));
	}

	static SKImage FromPixelCopy(SKImageInfo info, const(byte)[] pixels) {
		return FromPixelCopy(info, cast(void*)pixels, info.RowBytes);
	}

	static SKImage FromPixelCopy(SKImageInfo info, byte[] pixels, int rowBytes) {
		if (pixels is null)
			throw new ArgumentNullException(pixels.stringof);

		SKData data = SKData.CreateCopy(pixels);
		return FromPixels(info, data, rowBytes);
	}

	// create a new image around existing pixel data

	static SKImage FromPixelData(SKImageInfo info, SKData data, int rowBytes) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);
		auto cinfo = SKImageInfo.FromManaged(info);
		return GetObject(SkiaApi.sk_image_new_raster_data(&cinfo, cast(sk_data_t*)data.Handle,
				cast(void*) rowBytes));
	}

	static SKImage FromPixels(SKImageInfo info, SKData data) {
		return FromPixels(info, data, info.RowBytes);
	}

	static SKImage FromPixels(SKImageInfo info, SKData data, int rowBytes) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);
		auto cinfo = SKImageInfo.FromManaged(info);
		return GetObject(SkiaApi.sk_image_new_raster_data(&cinfo, cast(sk_data_t*)data.Handle,
				cast(void*) rowBytes));
	}

	static SKImage FromPixels(SKImageInfo info, void* pixels) {
		SKPixmap pixmap = new SKPixmap(info, pixels, info.RowBytes);
		return FromPixels(pixmap);
	}

	static SKImage FromPixels(SKImageInfo info, void* pixels, int rowBytes) {

		SKPixmap pixmap = new SKPixmap(info, pixels, rowBytes);
		return FromPixels(pixmap);
	}

	static SKImage FromPixels(SKPixmap pixmap) {
		return FromPixels(pixmap);
	}

	static SKImage FromPixels(SKPixmap pixmap, SKImageRasterReleaseDelegate releaseProc) {
		return FromPixels(pixmap, releaseProc);
	}

	// static SKImage FromPixels (SKPixmap pixmap, SKImageRasterReleaseDelegate releaseProc, object releaseContext)
	// {
	// 	if (pixmap is null)
	// 		throw new ArgumentNullException (pixmap.stringof);

	// 	auto del = releaseProc !is null && releaseContext !is null
	// 		? new SKImageRasterReleaseDelegate ((addr, _) {return releaseProc (addr, releaseContext);})
	// 		: releaseProc;
	// 	auto proxy = DelegateProxies.Create (del, DelegateProxies.SKImageRasterReleaseDelegateProxy,  _, out var ctx);
	// 	return GetObject (SkiaApi.sk_image_new_raster (pixmap.Handle, proxy, cast(void*)ctx));
	// }

	// create a new image from encoded data

	static SKImage FromEncodedData(SKData data, SKRectI subset) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);

		auto handle = SkiaApi.sk_image_new_from_encoded(cast(sk_data_t*)data.Handle, &subset);
		return GetObject(handle);
	}

	static SKImage FromEncodedData(SKData data) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);

		auto handle = SkiaApi.sk_image_new_from_encoded(cast(sk_data_t*)data.Handle, null);
		return GetObject(handle);
	}

	static SKImage FromEncodedData(byte[] data) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);
		if (data.length == 0)
			throw new ArgumentException("The data buffer was empty.");

		SKData skdata = SKData.CreateCopy(data);
		return FromEncodedData(skdata);
	}

	static SKImage FromEncodedData(SKStream data) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);

		SKData skdata = SKData.Create(data);
		if (skdata is null)
			return null;
		return FromEncodedData(skdata);
	}

	// static SKImage FromEncodedData (Stream data)
	// {
	// 	if (data is null)
	// 		throw new ArgumentNullException (data.stringof);

	// 	  SKData skdata = SKData.Create (data);
	// 		if (skdata is null)
	// 			return null;
	// 		return FromEncodedData (skdata);

	// }

	static SKImage FromEncodedData(string filename) {
		if (filename is null)
			throw new ArgumentNullException(filename.stringof);

		SKData skdata = SKData.Create(filename);
		if (skdata is null)
			return null;
		return FromEncodedData(skdata);
	}

	// create a new image from a bitmap

	static SKImage FromBitmap(SKBitmap bitmap) {
		if (bitmap is null)
			throw new ArgumentNullException(bitmap.stringof);

		auto image = GetObject(SkiaApi.sk_image_new_from_bitmap(cast(sk_bitmap_t*)bitmap.Handle));
		// GC.KeepAlive(bitmap);
		return image;
	}

	// create a new image from a GPU texture

	static SKImage FromTexture(GRContext context, GRBackendTextureDesc desc) {
		return FromTexture(context, desc, SKAlphaType.Premul);
	}

	static SKImage FromTexture(GRContext context, GRBackendTextureDesc desc, SKAlphaType alpha) {
		return FromTexture(context, desc, alpha);
	}

	static SKImage FromTexture(GRContext context, GRBackendTextureDesc desc,
			SKAlphaType alpha, SKImageTextureReleaseDelegate releaseProc) {
		return FromTexture(context, desc, alpha, releaseProc);
	}

	// static SKImage FromTexture (GRContext context, GRBackendTextureDesc desc, SKAlphaType alpha, SKImageTextureReleaseDelegate releaseProc, object releaseContext)
	// {
	// 	if (context is null)
	// 		throw new ArgumentNullException (context.stringof);

	// 	auto texture = new GRBackendTexture (desc);
	// 	return FromTexture (context, texture, desc.Origin, desc.Config.ToColorType (), alpha, null, releaseProc, releaseContext);
	// }

	static SKImage FromTexture(GRContext context, GRGlBackendTextureDesc desc) {
		return FromTexture(context, desc, SKAlphaType.Premul);
	}

	static SKImage FromTexture(GRContext context, GRGlBackendTextureDesc desc, SKAlphaType alpha) {
		return FromTexture(context, desc, alpha);
	}

	static SKImage FromTexture(GRContext context, GRGlBackendTextureDesc desc,
			SKAlphaType alpha, SKImageTextureReleaseDelegate releaseProc) {
		return FromTexture(context, desc, alpha, releaseProc);
	}

	// static SKImage FromTexture (GRContext context, GRGlBackendTextureDesc desc, SKAlphaType alpha, SKImageTextureReleaseDelegate releaseProc, object releaseContext)
	// {
	// 	auto texture = new GRBackendTexture (desc);
	// 	return FromTexture (context, texture, desc.Origin, desc.Config.ToColorType (), alpha, null, releaseProc, releaseContext);
	// }

	static SKImage FromTexture(GRContext context, GRBackendTexture texture, SKColorType colorType) {
		return FromTexture(context, texture, GRSurfaceOrigin.BottomLeft,
				colorType, SKAlphaType.Premul);
	}

	static SKImage FromTexture(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType) {
		return FromTexture(context, texture, origin, colorType,
				SKAlphaType.Premul);
	}

	static SKImage FromTexture(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKAlphaType alpha) {
		return FromTexture(context, texture, origin, colorType, alpha);
	}

	static SKImage FromTexture(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKAlphaType alpha,
			SKColorSpace colorspace) {
		return FromTexture(context, texture, origin, colorType, alpha, colorspace);
	}

	static SKImage FromTexture(GRContext context, GRBackendTexture texture, GRSurfaceOrigin origin, SKColorType colorType,
			SKAlphaType alpha, SKColorSpace colorspace, SKImageTextureReleaseDelegate releaseProc) {
		return FromTexture(context, texture, origin, colorType, alpha,
				colorspace, releaseProc);
	}

	// static SKImage FromTexture (GRContext context, GRBackendTexture texture, GRSurfaceOrigin origin, SKColorType colorType, SKAlphaType alpha, SKColorSpace colorspace, SKImageTextureReleaseDelegate releaseProc, object releaseContext)
	// {
	// 	if (context is null)
	// 		throw new ArgumentNullException (context.stringof);
	// 	if (texture is null)
	// 		throw new ArgumentNullException (texture.stringof);

	// 	auto cs = colorspace is null ? null : colorspace.Handle;
	// 	auto del = releaseProc !is null && releaseContext !is null
	// 		? new SKImageTextureReleaseDelegate ((_){return  releaseProc (releaseContext);})
	// 		: releaseProc;
	// 	auto proxy = DelegateProxies.Create (del, DelegateProxies.SKImageTextureReleaseDelegateProxy, _, out var ctx);
	// 	return GetObject (SkiaApi.sk_image_new_from_texture (context.Handle, texture.Handle, origin, colorType.ToNative (), alpha, cs, proxy, (void*)ctx));
	// }

	static SKImage FromAdoptedTexture(GRContext context, GRBackendTextureDesc desc) {
		return FromAdoptedTexture(context, desc, SKAlphaType.Premul);
	}

	static SKImage FromAdoptedTexture(GRContext context, GRBackendTextureDesc desc,
			SKAlphaType alpha) {
		GRBackendTexture texture = new GRBackendTexture(desc);
		return FromAdoptedTexture(context, texture, desc.Origin,
				desc.Config.ToColorType(), alpha, null);
	}

	static SKImage FromAdoptedTexture(GRContext context, GRGlBackendTextureDesc desc) {
		return FromAdoptedTexture(context, desc, SKAlphaType.Premul);
	}

	static SKImage FromAdoptedTexture(GRContext context,
			GRGlBackendTextureDesc desc, SKAlphaType alpha) {
		GRBackendTexture texture = new GRBackendTexture(desc);
		return FromAdoptedTexture(context, texture, desc.Origin,
				desc.Config.ToColorType(), alpha, null);
	}

	static SKImage FromAdoptedTexture(GRContext context,
			GRBackendTexture texture, SKColorType colorType) {
		return FromAdoptedTexture(context, texture, GRSurfaceOrigin.BottomLeft,
				colorType, SKAlphaType.Premul, null);
	}

	static SKImage FromAdoptedTexture(GRContext context,
			GRBackendTexture texture, GRSurfaceOrigin origin, SKColorType colorType) {
		return FromAdoptedTexture(context, texture, origin, colorType, SKAlphaType.Premul, null);
	}

	static SKImage FromAdoptedTexture(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKAlphaType alpha) {
		return FromAdoptedTexture(context, texture, origin, colorType, alpha, null);
	}

	static SKImage FromAdoptedTexture(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKAlphaType alpha,
			SKColorSpace colorspace) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);
		if (texture is null)
			throw new ArgumentNullException(texture.stringof);

		auto cs = colorspace is null ? null : colorspace.Handle;
		return GetObject(SkiaApi.sk_image_new_from_adopted_texture(cast(gr_context_t*)context.Handle,
				cast(gr_backendtexture_t*)texture.Handle, origin, colorType.ToNative(), alpha, cast(sk_colorspace_t*)cs));
	}

	// create a new image from a picture

	static SKImage FromPicture(SKPicture picture, SKSizeI dimensions) {
		return FromPicture(picture, dimensions, null, null);
	}

	static SKImage FromPicture(SKPicture picture, SKSizeI dimensions, SKMatrix matrix) {
		return FromPicture(picture, dimensions, &matrix, null);
	}

	static SKImage FromPicture(SKPicture picture, SKSizeI dimensions, SKPaint paint) {
		return FromPicture(picture, dimensions, null, paint);
	}

	static SKImage FromPicture(SKPicture picture, SKSizeI dimensions, SKMatrix matrix, SKPaint paint) {
		return FromPicture(picture, dimensions, &matrix, paint);
	}

	private static SKImage FromPicture(SKPicture picture, SKSizeI dimensions,
			SKMatrix* matrix, SKPaint paint) {
		if (picture is null)
			throw new ArgumentNullException(picture.stringof);

		auto p = paint.Handle ? paint.Handle : null;
		return GetObject(SkiaApi.sk_image_new_from_picture(cast(sk_picture_t*)picture.Handle, &dimensions, matrix, cast(sk_paint_t*)p));
	}

	SKData Encode() {
		return SKData.GetObject(SkiaApi.sk_image_encode(cast(sk_image_t*)Handle));
	}

	SKData Encode(SKPixelSerializer serializer) {
		if (serializer is null)
			throw new ArgumentNullException(serializer.stringof);

		// try old data
		auto encoded = EncodedData;
		if (encoded !is null) {
			if (serializer.UseEncodedData(encoded.Data, cast(ulong) encoded.Size)) {
				return encoded;
			} else {
				encoded.Dispose();
				encoded = null;
			}
		}

		// get new data (raster)
		if (!IsTextureBacked) {
			auto pixmap = PeekPixels();
			return serializer.Encode(pixmap);

		}

		// get new data (texture / gpu)
		// this involves a copy from gpu to cpu first
		if (IsTextureBacked) {
			SKImageInfo info = SKImageInfo(Width, Height, ColorType, AlphaType, ColorSpace);
			SKBitmap temp = new SKBitmap(info);
			SKPixmap pixmap = temp.PeekPixels();
			if (pixmap !is null && ReadPixels(pixmap, 0, 0)) {
				return serializer.Encode(pixmap);
			}

		}

		// some error
		return null;
	}

	SKData Encode(SKEncodedImageFormat format, int quality) {
		return SKData.GetObject(SkiaApi.sk_image_encode_specific(cast(sk_image_t*)Handle, format, quality));
	}

	int Width() {
		return SkiaApi.sk_image_get_width(cast(sk_image_t*)Handle);
	}

	int Height() {
		return SkiaApi.sk_image_get_height(cast(sk_image_t*)Handle);
	}

	uint UniqueId() {
		return SkiaApi.sk_image_get_unique_id(cast(sk_image_t*)Handle);
	}

	SKAlphaType AlphaType() {
		return SkiaApi.sk_image_get_alpha_type(cast(sk_image_t*)Handle);
	}

	SKColorType ColorType() {
		// return SkiaApi.sk_image_get_color_type(cast(sk_image_t*)Handle).FromNative();
    return SKColorType.Rgba8888;
	}

	SKColorSpace ColorSpace() {
		return SKColorSpace.GetObject(SkiaApi.sk_image_get_colorspace(cast(sk_image_t*)Handle));
	}

	bool IsAlphaOnly() {
		return SkiaApi.sk_image_is_alpha_only(cast(sk_image_t*)Handle);
	}

	SKData EncodedData() {
		return SKData.GetObject(SkiaApi.sk_image_ref_encoded(cast(sk_image_t*)Handle));
	}

	// ToShader

	SKShader ToShader() {
		return ToShader(SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);
	}

	SKShader ToShader(SKShaderTileMode tileX, SKShaderTileMode tileY) {
		return SKShader.GetObject(SkiaApi.sk_image_make_shader(cast(sk_image_t*)Handle, tileX, tileY, null));
	}

	SKShader ToShader(SKShaderTileMode tileX, SKShaderTileMode tileY, SKMatrix localMatrix) {
		return SKShader.GetObject(SkiaApi.sk_image_make_shader(cast(sk_image_t*)Handle, tileX,
				tileY, &localMatrix));
	}

	// PeekPixels

	bool PeekPixels(SKPixmap pixmap) {
		if (pixmap is null)
			throw new ArgumentNullException(pixmap.stringof);

		auto result = SkiaApi.sk_image_peek_pixels(cast(sk_image_t*)Handle, cast(sk_pixmap_t*)pixmap.Handle);
		if (result)
			pixmap.pixelSource = this;
		return result;
	}

	SKPixmap PeekPixels() {
		auto pixmap = new SKPixmap();
		if (!PeekPixels(pixmap)) {
			pixmap.Dispose();
			pixmap = null;
		}
		return pixmap;
	}

	bool IsTextureBacked() {
		return SkiaApi.sk_image_is_texture_backed(cast(sk_image_t*)Handle);
	}

	bool IsLazyGenerated() {
		return SkiaApi.sk_image_is_lazy_generated(cast(sk_image_t*)Handle);
	}

	bool IsValid(GRContext context) {
		return SkiaApi.sk_image_is_valid(cast(sk_image_t*)Handle, cast(gr_context_t*)(context.Handle ? context.Handle : null));
	}

	// ReadPixels

	bool ReadPixels(SKImageInfo dstInfo, void* dstPixels) {
		return ReadPixels(dstInfo, dstPixels, dstInfo.RowBytes, 0, 0, SKImageCachingHint.Allow);
	}

	bool ReadPixels(SKImageInfo dstInfo, void* dstPixels, int dstRowBytes) {
		return ReadPixels(dstInfo, dstPixels, dstRowBytes, 0, 0, SKImageCachingHint.Allow);
	}

	bool ReadPixels(SKImageInfo dstInfo, void* dstPixels, int dstRowBytes, int srcX, int srcY) {
		return ReadPixels(dstInfo, dstPixels, dstRowBytes, srcX, srcY, SKImageCachingHint.Allow);
	}

	bool ReadPixels(SKImageInfo dstInfo, void* dstPixels, int dstRowBytes,
			int srcX, int srcY, SKImageCachingHint cachingHint) {
		auto cinfo = SKImageInfo.FromManaged(dstInfo);
		auto result = SkiaApi.sk_image_read_pixels(cast(sk_image_t*)Handle, &cinfo,
				cast(void*) dstPixels, cast(void*) dstRowBytes, srcX, srcY, cachingHint);
		// GC.KeepAlive(this);
		return result;
	}

	bool ReadPixels(SKPixmap pixmap) {
		return ReadPixels(pixmap, 0, 0, SKImageCachingHint.Allow);
	}

	bool ReadPixels(SKPixmap pixmap, int srcX, int srcY) {
		return ReadPixels(pixmap, srcX, srcY, SKImageCachingHint.Allow);
	}

	bool ReadPixels(SKPixmap pixmap, int srcX, int srcY, SKImageCachingHint cachingHint) {
		if (pixmap is null)
			throw new ArgumentNullException(pixmap.stringof);

		auto result = SkiaApi.sk_image_read_pixels_into_pixmap(cast(sk_image_t*)Handle,
				cast(sk_pixmap_t*)pixmap.Handle, srcX, srcY, cachingHint);
		// GC.KeepAlive(this);
		return result;
	}

	// ScalePixels

	bool ScalePixels(SKPixmap dst, SKFilterQuality quality) {
		return ScalePixels(dst, quality, SKImageCachingHint.Allow);
	}

	bool ScalePixels(SKPixmap dst, SKFilterQuality quality, SKImageCachingHint cachingHint) {
		if (dst is null)
			throw new ArgumentNullException(dst.stringof);
		return SkiaApi.sk_image_scale_pixels(cast(sk_image_t*)Handle, cast(sk_pixmap_t*)dst.Handle, quality, cachingHint);
	}

	// Subset

	SKImage Subset(SKRectI subset) {
		return GetObject(SkiaApi.sk_image_make_subset(cast(sk_image_t*)Handle, &subset));
	}

	// ToRasterImage

	SKImage ToRasterImage() {
		return ToRasterImage(false);
	}

	SKImage ToRasterImage(bool ensurePixelData) {
		return ensurePixelData ? GetObject(SkiaApi.sk_image_make_raster_image(cast(sk_image_t*)Handle)) : GetObject(
				SkiaApi.sk_image_make_non_texture_image(cast(sk_image_t*)Handle));
	}

	// ToTextureImage

	SKImage ToTextureImage(GRContext context) {
		return ToTextureImage(context, false);
	}

	SKImage ToTextureImage(GRContext context, SKColorSpace colorspace) {
		return ToTextureImage(context, false);
	}

	SKImage ToTextureImage(GRContext context, bool mipmapped) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);

		return GetObject(SkiaApi.sk_image_make_texture_image(cast(sk_image_t*)Handle, cast(gr_context_t*)context.Handle, mipmapped));
	}

	// ApplyImageFilter

	SKImage ApplyImageFilter(SKImageFilter filter, SKRectI subset,
			SKRectI clipBounds, out SKRectI outSubset, out SKPoint outOffset) {
		SKPointI outOffsetActual;
		auto image = ApplyImageFilter(filter, subset, clipBounds, outSubset, outOffsetActual);
		// outOffset = outOffsetActual;
		return image;
	}

	SKImage ApplyImageFilter(SKImageFilter filter, SKRectI subset,
			SKRectI clipBounds, out SKRectI outSubset, out SKPointI outOffset) {
		if (filter is null)
			throw new ArgumentNullException(filter.stringof);

		SKRectI* os = &outSubset;
		SKPointI* oo = &outOffset;
		return GetObject(SkiaApi.sk_image_make_with_filter(cast(sk_image_t*)Handle,
				cast(sk_imagefilter_t*)filter.Handle, &subset, &clipBounds, os, oo));
	}

	static SKImage GetObject(void* handle) {
    	return GetOrAddObject!(SKImage)(handle, delegate SKImage (h, o) { return new SKImage (h, o);});
		// return GetOrAddObject(handle, (h, o) { return new SKImage(h, o); });
	}

}
