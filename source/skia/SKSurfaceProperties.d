module skia.SKSurfaceProperties;

import skia.Definitions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;
import skia.Util;

class SKSurfaceProperties : SKObject
{
	this (void* h, bool owns)
	{
    super (h, owns);
	}

	this (SKSurfaceProps props)
	{
    // super (props.Flags, props.PixelGeometry);
    super(cast(void*)0,false);
	}

	this (SKPixelGeometry pixelGeometry)
	{
     super(cast(void*)0,false);
	}

	this (uint flags, SKPixelGeometry pixelGeometry)
	{
    this (SkiaApi.sk_surfaceprops_new (flags, pixelGeometry), true);
	}

	this (SKSurfacePropsFlags flags, SKPixelGeometry pixelGeometry)
	{
    this (SkiaApi.sk_surfaceprops_new (cast(uint)flags, pixelGeometry), true);
	}

	protected override void Dispose (bool disposing)
  {
    return super.Dispose (disposing);
  }
		

	protected override void DisposeNative ()
  {
     SkiaApi.sk_surfaceprops_delete (cast(sk_surfaceprops_t*)Handle);
  }
		

	SKSurfacePropsFlags Flags()
  {
    return cast(SKSurfacePropsFlags)SkiaApi.sk_surfaceprops_get_flags (cast(sk_surfaceprops_t*)Handle);
  }
		

	SKPixelGeometry PixelGeometry()
  {
    return SkiaApi.sk_surfaceprops_get_pixel_geometry (cast(sk_surfaceprops_t*)Handle);
  }
		

	bool IsUseDeviceIndependentFonts()
  {
    return 	Flags.HasFlag (SKSurfacePropsFlags.UseDeviceIndependentFonts);
  }
	

	static SKSurfaceProperties GetObject (void* handle, bool owns = true)
  {
    return GetOrAddObject!(SKSurfaceProperties)(handle, delegate SKSurfaceProperties (h, o) { return new SKSurfaceProperties (h, o);});
    // return GetOrAddObject (handle, owns, (h, o){return new SKSurfaceProperties (h, o);});
  }
		
}
