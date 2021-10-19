module skia.GRBackendRenderTarget;

import skia.SKObject;
import skia.SkiaApi;
import skia.Definitions;
import skia.MathTypes;
import skia.EnumMappings;
import skia.GRDefinitions;
import skia.Exceptions;
import skia.GRDefinitions;


class GRBackendRenderTarget : SKObject, ISKSkipObjectRegistration
{
	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	this (GRBackend backend, GRBackendRenderTargetDesc desc)
	{
    this (null, true);
		switch (backend) {
			case GRBackend.Metal:
				throw new NotSupportedException ();
			case GRBackend.OpenGL:
			GRGlFramebufferInfo glInfo = GRGlFramebufferInfo(cast(uint)desc.RenderTargetHandle, desc.Config.ToGlSizedFormat ());
				// auto glInfo = new GRGlFramebufferInfo (cast(uint)desc.RenderTargetHandle, desc.Config.ToGlSizedFormat ());
				CreateGl (desc.Width, desc.Height, desc.SampleCount, desc.StencilBits, glInfo);
				break;
			case GRBackend.Vulkan:
				throw new NotSupportedException ();
			case GRBackend.Dawn:
				throw new NotSupportedException ();
			default:
				throw new ArgumentOutOfRangeException (backend.stringof);
		}
	}

	this (int width, int height, int sampleCount, int stencilBits, GRGlFramebufferInfo glInfo)
	{
    this (null, true);
		CreateGl (width, height, sampleCount, stencilBits, glInfo);
	}

	this (int width, int height, int sampleCount, GRVkImageInfo vkImageInfo)
	{
    this (null, true);
		CreateVulkan (width, height, sampleCount, vkImageInfo);
	}

	private void CreateGl (int width, int height, int sampleCount, int stencilBits, GRGlFramebufferInfo glInfo)
	{
		Handle = SkiaApi.gr_backendrendertarget_new_gl (width, height, sampleCount, stencilBits, &glInfo);

		if (Handle is null) {
			throw new InvalidOperationException ("Unable to create a new GRBackendRenderTarget instance.");
		}
	}

	private void CreateVulkan (int width, int height, int sampleCount, GRVkImageInfo vkImageInfo)
	{
		Handle = SkiaApi.gr_backendrendertarget_new_vulkan (width, height, sampleCount, &vkImageInfo);

		if (Handle is null) {
			throw new InvalidOperationException ("Unable to create a new GRBackendRenderTarget instance.");
		}
	}

	protected override void Dispose (bool disposing)
  {
    return super.Dispose (disposing);
  }
		

	protected override void DisposeNative ()
  {
    return SkiaApi.gr_backendrendertarget_delete (cast(gr_backendrendertarget_t*)Handle);
  }
		

	bool IsValid()
  {
    return SkiaApi.gr_backendrendertarget_is_valid (cast(gr_backendrendertarget_t*)Handle);
  }
  

	int Width()
  {
    return SkiaApi.gr_backendrendertarget_get_width (cast(gr_backendrendertarget_t*)Handle);
  }
  

	int Height()
  {
    return SkiaApi.gr_backendrendertarget_get_height (cast(gr_backendrendertarget_t*)Handle);
  }
  

	int SampleCount()
  {
    return  SkiaApi.gr_backendrendertarget_get_samples (cast(gr_backendrendertarget_t*)Handle);
  }
 

	int StencilBits()
  {
    return SkiaApi.gr_backendrendertarget_get_stencils (cast(gr_backendrendertarget_t*)Handle);
  }
  

	GRBackend Backend()
  {
    return SkiaApi.gr_backendrendertarget_get_backend (cast(gr_backendrendertarget_t*)Handle).FromNative ();
  }
   

	SKSizeI Size()
  {
    return SKSizeI (Width, Height);
  }
  

	SKRectI Rect()
  {
    return SKRectI (0, 0, Width, Height);
  }
  

	GRGlFramebufferInfo GetGlFramebufferInfo ()
  {
	  GRGlFramebufferInfo info;
    return GetGlFramebufferInfo (info) ? info : GRGlFramebufferInfo(0);
  }
		

	bool GetGlFramebufferInfo (ref GRGlFramebufferInfo glInfo)
	{
		GRGlFramebufferInfo* g = &glInfo;
		return SkiaApi.gr_backendrendertarget_get_gl_framebufferinfo (cast(gr_backendrendertarget_t*)Handle, g);
	}
}
