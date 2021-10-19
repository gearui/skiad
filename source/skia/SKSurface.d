module skia.SKSurface;

import skia.Definitions;
import skia.MathTypes;
import skia.SKImageInfo;
import skia.SKPixmap;
import skia.GRContext;
import skia.GRDefinitions;
import skia.DelegateProxies;
import skia.GRBackendRenderTarget;
import skia.SkiaApi;
import skia.GRBackendTexture;
import skia.SKColorSpace;
import skia.SKSurfaceProperties;
import skia.SKImage;
import skia.SKCanvas;
import skia.SKPaint;
import skia.SKVertices;
import skia.SKObject;
import skia.Exceptions;
import skia.EnumMappings;

import std.experimental.logger;

class SKSurface : SKObject, ISKSkipObjectRegistration {

	static SKSurface Create(int width, int height, SKColorType colorType, SKAlphaType alphaType) {
		return Create(SKImageInfo(width, height, colorType, alphaType));
	}

	static SKSurface Create(int width, int height, SKColorType colorType,
			SKAlphaType alphaType, SKSurfaceProps props) {
		return Create(SKImageInfo(width, height, colorType, alphaType), props);
	}

	static SKSurface Create(int width, int height, SKColorType colorType,
			SKAlphaType alphaType, void* pixels, int rowBytes) {
		return Create(SKImageInfo(width, height, colorType, alphaType), pixels, rowBytes);
	}

	static SKSurface Create(int width, int height, SKColorType colorType,
			SKAlphaType alphaType, void* pixels, int rowBytes, SKSurfaceProps props) {
		return Create(SKImageInfo(width, height, colorType, alphaType), pixels, rowBytes, props);
	}

	this(void* h, bool owns) {
		super(h, owns);
	}

	// 	protected override void Dispose (bool disposing)
	//   {
	//     return super.Dispose (disposing);
	//   }

	// RASTER surface

	static SKSurface Create(SKImageInfo info, SKSurfaceProps props) {
		return Create(info, 0, new SKSurfaceProperties(props));
	}

	static SKSurface Create(SKImageInfo info) {
		return Create(info, 0, null);
	}

	static SKSurface Create(SKImageInfo info, int rowBytes) {
		return Create(info, rowBytes, null);
	}

	static SKSurface Create(SKImageInfo info, SKSurfaceProperties props) {
		return Create(info, 0, props);
	}

	static SKSurface Create(SKImageInfo info, int rowBytes, SKSurfaceProperties props) {
		auto cinfo = SKImageInfo.FromManaged(info);
		void* handle = null;
		if(props !is null && props.Handle !is null) {
			handle = props.Handle;
		}
		return GetObject(SkiaApi.sk_surface_new_raster(&cinfo, cast(void*) rowBytes,
				cast(sk_surfaceprops_t*)handle));
	}

	// convenience RASTER DIRECT to use a SKPixmap instead of SKImageInfo and void*

	static SKSurface Create(SKPixmap pixmap, SKSurfaceProps props) {
		return Create(pixmap, new SKSurfaceProperties(props));
	}

	static SKSurface Create(SKPixmap pixmap) {
		return Create(pixmap, null);
	}

	static SKSurface Create(SKPixmap pixmap, SKSurfaceProperties props) {
		if (pixmap is null) {
			throw new ArgumentNullException(pixmap.stringof);
		}
		return Create(pixmap.Info, pixmap.GetPixels(), pixmap.RowBytes, props);
	}

	// RASTER DIRECT surface

	static SKSurface Create(SKImageInfo info, void* pixels, int rowBytes, SKSurfaceProps props) {
		return Create(info, pixels, rowBytes, new SKSurfaceProperties(props));
	}

	static SKSurface Create(SKImageInfo info, void* pixels) {
		return Create(info, pixels, info.RowBytes);
	}

	static SKSurface Create(SKImageInfo info, void* pixels, int rowBytes) {
		return Create(info, pixels, rowBytes);
	}

	// static SKSurface Create (SKImageInfo info, void* pixels, int rowBytes, SKSurfaceReleaseDelegate releaseProc, object context)	
	// {
	// 	return Create (info, pixels, rowBytes, releaseProc, context, null);
	// }

	static SKSurface Create(SKImageInfo info, void* pixels, SKSurfaceProperties props) {
		return Create(info, pixels, info.RowBytes, props);
	}

	static SKSurface Create(SKImageInfo info, void* pixels, int rowBytes,
			SKSurfaceProperties props) {
		return Create(info, pixels, rowBytes, props);
	}

	// static SKSurface Create (SKImageInfo info, void* pixels, int rowBytes, SKSurfaceReleaseDelegate releaseProc, object context, SKSurfaceProperties props)
	// {
	// 	auto cinfo = SKImageInfo.FromManaged (ref info);
	// 	auto del = releaseProc !is null && context !is null
	// 		? new SKSurfaceReleaseDelegate ((addr, _) {return releaseProc (addr, context);})
	// 		: releaseProc;
	// 	auto proxy = DelegateProxies.Create (del, DelegateProxies.SKSurfaceReleaseDelegateProxy,  _, out var ctx);
	// 	return GetObject (SkiaApi.sk_surface_new_raster_direct (&cinfo, cast(void*)pixels, cast(void*)rowBytes, proxy, cast(void*)ctx, props.Handle ? props.Handle : null));
	// }

	// GPU BACKEND RENDER TARGET surface

	static SKSurface Create(GRContext context, GRBackendRenderTargetDesc desc) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);

		auto renderTarget = new GRBackendRenderTarget(context.Backend, desc);
		return Create(context, renderTarget, desc.Origin, desc.Config.ToColorType(), null, null);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTargetDesc desc, SKSurfaceProps props) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);

		auto renderTarget = new GRBackendRenderTarget(context.Backend, desc);
		return Create(context, renderTarget, desc.Origin,
				desc.Config.ToColorType(), null, new SKSurfaceProperties(props));
	}

	static SKSurface Create(GRContext context,
			GRBackendRenderTarget renderTarget, SKColorType colorType) {
		return Create(context, renderTarget, GRSurfaceOrigin.BottomLeft, colorType, null, null);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTarget renderTarget,
			GRSurfaceOrigin origin, SKColorType colorType) {
		return Create(context, renderTarget, origin, colorType, null, null);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTarget renderTarget,
			GRSurfaceOrigin origin, SKColorType colorType, SKColorSpace colorspace) {
		return Create(context, renderTarget, origin, colorType, colorspace, null);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTarget renderTarget,
			SKColorType colorType, SKSurfaceProperties props) {
		return Create(context, renderTarget, GRSurfaceOrigin.BottomLeft, colorType, null, props);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTarget renderTarget,
			GRSurfaceOrigin origin, SKColorType colorType, SKSurfaceProperties props) {
		return Create(context, renderTarget, origin, colorType, null, props);
	}

	static SKSurface Create(GRContext context, GRBackendRenderTarget renderTarget,
			GRSurfaceOrigin origin, SKColorType colorType,
			SKColorSpace colorspace, SKSurfaceProperties props) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);
		if (renderTarget is null)
			throw new ArgumentNullException(renderTarget.stringof);

		return GetObject(SkiaApi.sk_surface_new_backend_render_target(cast(gr_context_t*) context.Handle,
				cast(gr_backendrendertarget_t*) renderTarget.Handle, origin, ToNative(colorType),
				cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null),
				cast(sk_surfaceprops_t*)(props.Handle ? props.Handle : null)));
	}

	// GPU BACKEND TEXTURE surface

	static SKSurface Create(GRContext context, GRGlBackendTextureDesc desc) {
		return Create(context, new GRBackendTexture(desc), desc.Origin,
				desc.SampleCount, desc.Config.ToColorType(), null, null);
	}

	static SKSurface Create(GRContext context, GRBackendTextureDesc desc) {
		return Create(context, new GRBackendTexture(desc), desc.Origin,
				desc.SampleCount, desc.Config.ToColorType(), null, null);
	}

	static SKSurface Create(GRContext context, GRGlBackendTextureDesc desc, SKSurfaceProps props) {
		return Create(context, new GRBackendTexture(desc), desc.Origin, desc.SampleCount,
				desc.Config.ToColorType(), null, new SKSurfaceProperties(props));
	}

	static SKSurface Create(GRContext context, GRBackendTextureDesc desc, SKSurfaceProps props) {
		return Create(context, new GRBackendTexture(desc), desc.Origin, desc.SampleCount,
				desc.Config.ToColorType(), null, new SKSurfaceProperties(props));
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture, SKColorType colorType) {
		return Create(context, texture, GRSurfaceOrigin.BottomLeft, 0, colorType, null, null);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType) {
		return Create(context, texture, origin, 0, colorType, null, null);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType) {
		return Create(context, texture, origin, sampleCount, colorType, null, null);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType, SKColorSpace colorspace) {
		return Create(context, texture, origin, sampleCount, colorType, colorspace, null);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			SKColorType colorType, SKSurfaceProperties props) {
		return Create(context, texture, GRSurfaceOrigin.BottomLeft, 0, colorType, null, props);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKSurfaceProperties props) {
		return Create(context, texture, origin, 0, colorType, null, props);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType,
			SKSurfaceProperties props) {
		return Create(context, texture, origin, sampleCount, colorType, null, props);
	}

	static SKSurface Create(GRContext context, GRBackendTexture texture, GRSurfaceOrigin origin,
			int sampleCount, SKColorType colorType, SKColorSpace colorspace,
			SKSurfaceProperties props) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);
		if (texture is null)
			throw new ArgumentNullException(texture.stringof);

		return GetObject(SkiaApi.sk_surface_new_backend_texture(cast(gr_context_t*) context.Handle,
				cast(gr_backendtexture_t*) texture.Handle, origin, sampleCount, ToNative(colorType),
				cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null),
				cast(sk_surfaceprops_t*)(props.Handle ? props.Handle : null)));
	}

	// GPU BACKEND TEXTURE AS RENDER TARGET surface

	static SKSurface CreateAsRenderTarget(GRContext context, GRGlBackendTextureDesc desc) {
		return CreateAsRenderTarget(context, new GRBackendTexture(desc),
				desc.Origin, desc.SampleCount, desc.Config.ToColorType(), null, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTextureDesc desc) {
		return CreateAsRenderTarget(context, new GRBackendTexture(desc),
				desc.Origin, desc.SampleCount, desc.Config.ToColorType(), null, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context,
			GRGlBackendTextureDesc desc, SKSurfaceProps props) {
		return CreateAsRenderTarget(context, new GRBackendTexture(desc), desc.Origin,
				desc.SampleCount, desc.Config.ToColorType(), null, new SKSurfaceProperties(props));
	}

	static SKSurface CreateAsRenderTarget(GRContext context,
			GRBackendTextureDesc desc, SKSurfaceProps props) {
		return CreateAsRenderTarget(context, new GRBackendTexture(desc), desc.Origin,
				desc.SampleCount, desc.Config.ToColorType(), null, new SKSurfaceProperties(props));
	}

	static SKSurface CreateAsRenderTarget(GRContext context,
			GRBackendTexture texture, SKColorType colorType) {
		return CreateAsRenderTarget(context, texture,
				GRSurfaceOrigin.BottomLeft, 0, colorType, null, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context,
			GRBackendTexture texture, GRSurfaceOrigin origin, SKColorType colorType) {
		return CreateAsRenderTarget(context, texture, origin, 0, colorType, null, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType) {
		return CreateAsRenderTarget(context, texture, origin, sampleCount, colorType, null, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType, SKColorSpace colorspace) {
		return CreateAsRenderTarget(context, texture, origin, sampleCount,
				colorType, colorspace, null);
	}

	static SKSurface CreateAsRenderTarget(GRContext context,
			GRBackendTexture texture, SKColorType colorType, SKSurfaceProperties props) {
		return CreateAsRenderTarget(context, texture,
				GRSurfaceOrigin.BottomLeft, 0, colorType, null, props);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, SKColorType colorType, SKSurfaceProperties props) {
		return CreateAsRenderTarget(context, texture, origin, 0, colorType, null, props);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTexture texture,
			GRSurfaceOrigin origin, int sampleCount, SKColorType colorType,
			SKSurfaceProperties props) {
		return CreateAsRenderTarget(context, texture, origin, sampleCount, colorType, null, props);
	}

	static SKSurface CreateAsRenderTarget(GRContext context, GRBackendTexture texture, GRSurfaceOrigin origin,
			int sampleCount, SKColorType colorType, SKColorSpace colorspace,
			SKSurfaceProperties props) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);
		if (texture is null)
			throw new ArgumentNullException(texture.stringof);

		return GetObject(SkiaApi.sk_surface_new_backend_texture_as_render_target(cast(gr_context_t*) context.Handle,
				cast(gr_backendtexture_t*) texture.Handle, origin, sampleCount, ToNative(colorType),
				cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null),
				cast(sk_surfaceprops_t*)(props.Handle ? props.Handle : null)));
	}

	// GPU NEW surface

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info,
			int sampleCount, SKSurfaceProps props) {
		return Create(context, budgeted, info, sampleCount,
				GRSurfaceOrigin.BottomLeft, new SKSurfaceProperties(props), false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info) {
		return Create(context, budgeted, info, 0, GRSurfaceOrigin.BottomLeft, null, false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info, int sampleCount) {
		return Create(context, budgeted, info, sampleCount,
				GRSurfaceOrigin.BottomLeft, null, false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info,
			int sampleCount, GRSurfaceOrigin origin) {
		return Create(context, budgeted, info, sampleCount, origin, null, false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info,
			SKSurfaceProperties props) {
		return Create(context, budgeted, info, 0, GRSurfaceOrigin.BottomLeft, props, false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info,
			int sampleCount, SKSurfaceProperties props) {
		return Create(context, budgeted, info, sampleCount,
				GRSurfaceOrigin.BottomLeft, props, false);
	}

	static SKSurface Create(GRContext context, bool budgeted, SKImageInfo info, int sampleCount,
			GRSurfaceOrigin origin, SKSurfaceProperties props, bool shouldCreateWithMips) {
		if (context is null)
			throw new ArgumentNullException(context.stringof);

		auto cinfo = SKImageInfo.FromManaged(info);
		return GetObject(SkiaApi.sk_surface_new_render_target(cast(gr_context_t*) context.Handle, budgeted,
				&cinfo, sampleCount, origin, cast(sk_surfaceprops_t*)(props.Handle
				? props.Handle : null), shouldCreateWithMips));
	}

	// NULL surface

	static SKSurface CreateNull(int width, int height) {
		return GetObject(SkiaApi.sk_surface_new_null(width, height));
	}

	//

	SKCanvas Canvas() {
		return OwnedBy(SKCanvas.GetObject(SkiaApi.sk_surface_get_canvas(cast(sk_surface_t*) Handle),
				false, false), this);
	}

	SKSurfaceProps SurfaceProps() {
		auto props = SurfaceProperties;
		SKSurfaceProps surfaceProps = SKSurfaceProps();
		surfaceProps.Flags = props.Flags;
		surfaceProps.PixelGeometry = props.PixelGeometry;
		return surfaceProps;
	}

	SKSurfaceProperties SurfaceProperties() {
		return OwnedBy(SKSurfaceProperties.GetObject(cast(
				void*) SkiaApi.sk_surface_get_props(cast(sk_surface_t*) Handle), false), this);
	}

	SKImage Snapshot() {
		return SKImage.GetObject(SkiaApi.sk_surface_new_image_snapshot(cast(sk_surface_t*) Handle));
	}

	SKImage Snapshot(SKRectI bounds) {
		return SKImage.GetObject(SkiaApi.sk_surface_new_image_snapshot_with_crop(
				cast(sk_surface_t*) Handle, &bounds));
	}

	void Draw(SKCanvas canvas, float x, float y, SKPaint paint) {
		if (canvas is null)
			throw new ArgumentNullException(canvas.stringof);

		SkiaApi.sk_surface_draw(cast(sk_surface_t*) Handle,
				cast(sk_canvas_t*) canvas.Handle, x, y,
				cast(sk_paint_t*)(paint is null ? null : paint.Handle));
	}

	SKPixmap PeekPixels() {
		auto pixmap = new SKPixmap();
		auto result = PeekPixels(pixmap);
		if (result) {
			return pixmap;
		} else {
			pixmap.Dispose();
			return null;
		}
	}

	bool PeekPixels(SKPixmap pixmap) {
		if (pixmap is null)
			throw new ArgumentNullException(pixmap.stringof);

		auto result = SkiaApi.sk_surface_peek_pixels(cast(sk_surface_t*) Handle,
				cast(sk_pixmap_t*) pixmap.Handle);
		if (result)
			pixmap.pixelSource = this;
		return result;
	}

	bool ReadPixels(SKImageInfo dstInfo, void* dstPixels, int dstRowBytes, int srcX, int srcY) {
		auto cinfo = SKImageInfo.FromManaged(dstInfo);
		auto result = SkiaApi.sk_surface_read_pixels(cast(sk_surface_t*) Handle,
				&cinfo, cast(void*) dstPixels, cast(void*) dstRowBytes, srcX, srcY);
		// GC.KeepAlive (this);
		return result;
	}

	static SKSurface GetObject(void* handle) {
		return handle is null ? null : new SKSurface(handle, true);
	}

}
