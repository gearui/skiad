module skia.SKImageFilter;

// TODO: `asAColorFilter`
// TODO: `countInputs`, `getInput`
// TODO: `cropRectIsSet`, `getCropRect`
// TODO: `computeFastBounds`, `canComputeFastBounds`

import skia.SKObject;
import skia.SKMatrix;
import skia.SkiaApi;
import skia.SKRegion;
import skia.SKColorFilter;
import skia.SKColor;
import skia.SKPicture;
import skia.SKImage;
import skia.SKPaint;
import skia.MathTypes;
import skia.Definitions;
import skia.Exceptions;

enum SKDisplacementMapEffectChannelSelectorType
{
	Unknown = 0,
	R = 1,
	G = 2,
	B = 3,
	A = 4,
}

enum SKDropShadowImageFilterShadowMode
{
	DrawShadowAndForeground = 0,
	DrawShadowOnly = 1,
}

enum SKMatrixConvolutionTileMode
{
	Clamp = 0,
	Repeat = 1,
	ClampToBlack = 2,

}

alias ToColorChannel = SkiaExtensions.ToColorChannel;
alias ToShaderTileMode = SkiaExtensions.ToShaderTileMode;

struct SkiaExtensions
{

	// static SKColorChannel ToColorChannel (this SKDisplacementMapEffectChannelSelectorType channelSelectorType)
  static SKColorChannel ToColorChannel (SKDisplacementMapEffectChannelSelectorType channelSelectorType)
  {
    switch(channelSelectorType)
		{
			case SKDisplacementMapEffectChannelSelectorType.R:
				return SKColorChannel.R;
			case SKDisplacementMapEffectChannelSelectorType.G:
			  return SKColorChannel.G;
			case SKDisplacementMapEffectChannelSelectorType.B:
			  return SKColorChannel.B;
			case SKDisplacementMapEffectChannelSelectorType.A:
			  return SKColorChannel.A;
			default:
			  return SKColorChannel.B;
		}
  }
	

	// static SKShaderTileMode ToShaderTileMode (this SKMatrixConvolutionTileMode tileMode)
  static SKShaderTileMode ToShaderTileMode (SKMatrixConvolutionTileMode tileMode)
  {
    switch(tileMode)
		{
			case SKMatrixConvolutionTileMode.Clamp:
				return SKShaderTileMode.Clamp;
			case SKMatrixConvolutionTileMode.Repeat:
			  return SKShaderTileMode.Repeat;
			default:
			  return SKShaderTileMode.Decal;
		}
  }
}

class SKImageFilter : SKObject
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	protected override void Dispose (bool disposing)
  {
    return super.Dispose (disposing);
  }
		

	// CreateMatrix

	static SKImageFilter CreateMatrix(SKMatrix matrix, SKFilterQuality quality, SKImageFilter input = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_matrix(&matrix, quality, cast(sk_imagefilter_t*)(input is null ? null : input.Handle)));
	}

	// CreateAlphaThreshold

	static SKImageFilter CreateAlphaThreshold(SKRectI region, float innerThreshold, float outerThreshold, SKImageFilter input = null)
	{
		auto reg = new SKRegion ();
		reg.SetRect (region);
		return CreateAlphaThreshold (reg, innerThreshold, outerThreshold, input);

	}

	static SKImageFilter CreateAlphaThreshold(SKRegion region, float innerThreshold, float outerThreshold, SKImageFilter input = null)
	{
		if (region is null)
			throw new ArgumentNullException (region.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_alpha_threshold(cast(sk_region_t*)region.Handle, innerThreshold, outerThreshold, cast(sk_imagefilter_t*)(input is null ? null : input.Handle)));
	}

	// CreateBlur

	static SKImageFilter CreateBlur (float sigmaX, float sigmaY, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return 	CreateBlur (sigmaX, sigmaY, SKShaderTileMode.Decal, input, cropRect);
  }
	

	static SKImageFilter CreateBlur (float sigmaX, float sigmaY, SKShaderTileMode tileMode, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return GetObject (SkiaApi.sk_imagefilter_new_blur (sigmaX, sigmaY, tileMode, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
  }
		

	// CreateColorFilter

	static SKImageFilter CreateColorFilter(SKColorFilter cf, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		if (cf is null)
			throw new ArgumentNullException(cf.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_color_filter(cast(sk_colorfilter_t*)cf.Handle, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateCompose

	static SKImageFilter CreateCompose(SKImageFilter outer, SKImageFilter inner)
	{
		if (outer is null)
			throw new ArgumentNullException(outer.stringof);
		if (inner is null)
			throw new ArgumentNullException(inner.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_compose(cast(sk_imagefilter_t*)outer.Handle, cast(sk_imagefilter_t*)inner.Handle));
	}

	// CreateDisplacementMapEffect

	static SKImageFilter CreateDisplacementMapEffect (SKDisplacementMapEffectChannelSelectorType xChannelSelector, SKDisplacementMapEffectChannelSelectorType yChannelSelector, float scale, SKImageFilter displacement, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return 	CreateDisplacementMapEffect (xChannelSelector.ToColorChannel (), yChannelSelector.ToColorChannel (), scale, displacement, input, cropRect);
  }
	

	static SKImageFilter CreateDisplacementMapEffect (SKColorChannel xChannelSelector, SKColorChannel yChannelSelector, float scale, SKImageFilter displacement, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		if (displacement is null)
			throw new ArgumentNullException (displacement.stringof);
		return GetObject (SkiaApi.sk_imagefilter_new_displacement_map_effect (xChannelSelector, yChannelSelector, scale, cast(sk_imagefilter_t*)displacement.Handle, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateDropShadow

	static SKImageFilter CreateDropShadow (float dx, float dy, float sigmaX, float sigmaY, SKColor color, SKDropShadowImageFilterShadowMode shadowMode, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return 	shadowMode == SKDropShadowImageFilterShadowMode.DrawShadowOnly
			? CreateDropShadowOnly (dx, dy, sigmaX, sigmaY, color, input, cropRect)
			: CreateDropShadow (dx, dy, sigmaX, sigmaY, color, input, cropRect);
  }
	

	static SKImageFilter CreateDropShadow (float dx, float dy, float sigmaX, float sigmaY, SKColor color, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return 	GetObject (SkiaApi.sk_imagefilter_new_drop_shadow (dx, dy, sigmaX, sigmaY, cast(uint)color, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
  }
	

	static SKImageFilter CreateDropShadowOnly (float dx, float dy, float sigmaX, float sigmaY, SKColor color, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return GetObject (SkiaApi.sk_imagefilter_new_drop_shadow_only (dx, dy, sigmaX, sigmaY, cast(uint)color, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
  }
		

	// Create*LitDiffuse

	static SKImageFilter CreateDistantLitDiffuse(SKPoint3 direction, SKColor lightColor, float surfaceScale, float kd, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_distant_lit_diffuse(&direction, cast(uint)lightColor, surfaceScale, kd, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	static SKImageFilter CreatePointLitDiffuse(SKPoint3 location, SKColor lightColor, float surfaceScale, float kd, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_point_lit_diffuse(&location, cast(uint)lightColor, surfaceScale, kd, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	static SKImageFilter CreateSpotLitDiffuse(SKPoint3 location, SKPoint3 target, float specularExponent, float cutoffAngle, SKColor lightColor, float surfaceScale, float kd, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_spot_lit_diffuse(&location, &target, specularExponent, cutoffAngle, cast(uint)lightColor, surfaceScale, kd, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// Create*LitSpecular

	static SKImageFilter CreateDistantLitSpecular(SKPoint3 direction, SKColor lightColor, float surfaceScale, float ks, float shininess, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_distant_lit_specular(&direction, cast(uint)lightColor, surfaceScale, ks, shininess, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	static SKImageFilter CreatePointLitSpecular(SKPoint3 location, SKColor lightColor, float surfaceScale, float ks, float shininess, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_point_lit_specular(&location, cast(uint)lightColor, surfaceScale, ks, shininess, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	static SKImageFilter CreateSpotLitSpecular(SKPoint3 location, SKPoint3 target, float specularExponent, float cutoffAngle, SKColor lightColor, float surfaceScale, float ks, float shininess, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_spot_lit_specular(&location, &target, specularExponent, cutoffAngle, cast(uint)lightColor, surfaceScale, ks, shininess, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateMagnifier

	static SKImageFilter CreateMagnifier(SKRect src, float inset, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_magnifier(&src, inset, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateMatrixConvolution
	// [Obsolete ("Use CreateMatrixConvolution(SKSizeI, float[], float, float, SKPointI, SKShaderTileMode, bool, SKImageFilter, SKImageFilter.CropRect) instead.")]
	static SKImageFilter CreateMatrixConvolution (SKSizeI kernelSize, float[] kernel, float gain, float bias, SKPointI kernelOffset, SKMatrixConvolutionTileMode tileMode, bool convolveAlpha, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
  {
    return 	CreateMatrixConvolution (kernelSize, kernel, gain, bias, kernelOffset, tileMode.ToShaderTileMode (), convolveAlpha, input, cropRect);
  }
	

	static SKImageFilter CreateMatrixConvolution (SKSizeI kernelSize, float[] kernel, float gain, float bias, SKPointI kernelOffset, SKShaderTileMode tileMode, bool convolveAlpha, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		if (kernel is null)
			throw new ArgumentNullException (kernel.stringof);
		if (kernel.length != kernelSize.Width * kernelSize.Height)
			throw new ArgumentException ("Kernel length must match the dimensions of the kernel size (Width * Height).", kernel.stringof);
		float* k = kernel.ptr;
		return GetObject (SkiaApi.sk_imagefilter_new_matrix_convolution (&kernelSize, k, gain, bias, &kernelOffset, tileMode, convolveAlpha, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateMerge

	// static SKImageFilter CreateMerge(SKImageFilter first, SKImageFilter second, SKBlendMode mode, SKImageFilter.CropRect cropRect = null)
	// {
	// 	return CreateMerge(new [] { first, second }, cropRect);
	// }

	// static SKImageFilter CreateMerge(SKImageFilter first, SKImageFilter second, SKImageFilter.CropRect cropRect = null)
	// {
	// 	return CreateMerge(new [] { first, second }, cropRect);
	// }
	// [Obsolete("Use CreateMerge(SKImageFilter[], SKImageFilter.CropRect) instead.")]
	static SKImageFilter CreateMerge(SKImageFilter[] filters, SKBlendMode[] modes, SKImageFilter.CropRect cropRect = null)
	{
		return CreateMerge (filters, cropRect);
	}

	static SKImageFilter CreateMerge(SKImageFilter[] filters, SKImageFilter.CropRect cropRect = null)
	{
		if (filters is null)
			throw new ArgumentNullException(filters.stringof);
		auto handles = new void*[filters.length];
		for (int i = 0; i < filters.length; i++)
		{
			handles[i] = filters[i].Handle ? filters[i].Handle : null;
		}
		void** h = handles.ptr;
		return GetObject (SkiaApi.sk_imagefilter_new_merge (cast(sk_imagefilter_t**)h, cast(int)filters.length, cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateDilate

	static SKImageFilter CreateDilate(int radiusX, int radiusY, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_dilate(radiusX, radiusY, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateErode

	static SKImageFilter CreateErode(int radiusX, int radiusY, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_erode(radiusX, radiusY, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateOffset

	static SKImageFilter CreateOffset(float dx, float dy, SKImageFilter input = null, SKImageFilter.CropRect cropRect = null)
	{
		return GetObject(SkiaApi.sk_imagefilter_new_offset(dx, dy, cast(sk_imagefilter_t*)(input is null ? null : input.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreatePicture

	static SKImageFilter CreatePicture(SKPicture picture)
	{
		if (picture is null)
			throw new ArgumentNullException(picture.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_picture(cast(sk_picture_t*)picture.Handle));
	}

	static SKImageFilter CreatePicture(SKPicture picture, SKRect cropRect)
	{
		if (picture is null)
			throw new ArgumentNullException(picture.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_picture_with_croprect(cast(sk_picture_t*)picture.Handle, &cropRect));
	}

	// CreateTile

	static SKImageFilter CreateTile(SKRect src, SKRect dst, SKImageFilter input)
	{
		if (input is null)
			throw new ArgumentNullException(input.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_tile(&src, &dst, cast(sk_imagefilter_t*)input.Handle));
	}

	// CreateBlendMode

	static SKImageFilter CreateBlendMode(SKBlendMode mode, SKImageFilter background, SKImageFilter foreground = null, SKImageFilter.CropRect cropRect = null)
	{
		if (background is null)
			throw new ArgumentNullException(background.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_xfermode(mode, cast(sk_imagefilter_t*)background.Handle, cast(sk_imagefilter_t*)(foreground is null ? null : foreground.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateArithmetic

	static SKImageFilter CreateArithmetic(float k1, float k2, float k3, float k4, bool enforcePMColor, SKImageFilter background, SKImageFilter foreground = null, SKImageFilter.CropRect cropRect = null)
	{
		if (background is null)
			throw new ArgumentNullException(background.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_arithmetic(k1, k2, k3, k4, enforcePMColor, cast(sk_imagefilter_t*)background.Handle, cast(sk_imagefilter_t*)(foreground is null ? null : foreground.Handle), cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	// CreateImage

	static SKImageFilter CreateImage(SKImage image)
	{
		if (image is null)
			throw new ArgumentNullException(image.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_image_source_default(cast(sk_image_t*)image.Handle));
	}

	static SKImageFilter CreateImage(SKImage image, SKRect src, SKRect dst, SKFilterQuality filterQuality)
	{
		if (image is null)
			throw new ArgumentNullException(image.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_image_source(cast(sk_image_t*)image.Handle, &src, &dst, filterQuality));
	}

	// CreatePaint

	static SKImageFilter CreatePaint(SKPaint paint, SKImageFilter.CropRect cropRect = null)
	{
		if (paint is null)
			throw new ArgumentNullException(paint.stringof);
		return GetObject(SkiaApi.sk_imagefilter_new_paint(cast(sk_paint_t*)paint.Handle, cast(sk_imagefilter_croprect_t*)(cropRect is null ? null : cropRect.Handle)));
	}

	static SKImageFilter GetObject (void* handle)
  {
    return GetOrAddObject!(SKImageFilter)(handle, delegate SKImageFilter (h, o) { return new SKImageFilter (h, o);});
    // return GetOrAddObject (handle, (h, o){return new SKImageFilter (h, o);});
  }
		

	//

	class CropRect : SKObject
	{
		this(void* handle, bool owns)
		{
			super(handle, owns);
		}

		this()
		{
			this(SkiaApi.sk_imagefilter_croprect_new(), true);
		}

		this(SKRect rect, SKCropRectFlags flags = SKCropRectFlags.HasAll)
		{
			this(SkiaApi.sk_imagefilter_croprect_new_with_rect(&rect, cast(uint)flags), true);
		}

		protected override void Dispose (bool disposing)
    {
      return 	super.Dispose (disposing);
    }
		

		protected override void DisposeNative ()
    {
      return SkiaApi.sk_imagefilter_croprect_destructor (cast(sk_imagefilter_croprect_t*)Handle);
    }
			

		SKRect Rect()
		{
			SKRect rect;
			SkiaApi.sk_imagefilter_croprect_get_rect (cast(sk_imagefilter_croprect_t*)Handle, &rect);
			return rect;
		}

		SKCropRectFlags Flags()
    {
      return 	cast(SKCropRectFlags)SkiaApi.sk_imagefilter_croprect_get_flags (cast(sk_imagefilter_croprect_t*)Handle);
    }
		
	}
}
