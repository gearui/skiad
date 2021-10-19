module skia.SKShader;

import skia.SKObject;
import skia.SkiaApi;
import skia.SKColorFilter;
import skia.SKColor;
import skia.SKColorSpace;
import skia.SKBitmap;
import skia.SKColorF;
import skia.SKImage;
import skia.SKPicture;
import skia.SKMatrix;
import skia.Definitions;
import skia.MathTypes;
import skia.Exceptions;


class SKShader : SKObject
{
	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);
  }

  override void Dispose()
  {
    return super.Dispose();
  }
	

	// WithColorFilter

	SKShader WithColorFilter (SKColorFilter filter)
	{
		if (filter is null)
			throw new ArgumentNullException (filter.stringof);

		return GetObject (SkiaApi.sk_shader_with_color_filter (cast(sk_shader_t*)Handle, cast(sk_colorfilter_t*)filter.Handle));
	}

	// WithLocalMatrix

	SKShader WithLocalMatrix (SKMatrix localMatrix)
  {
    return 	GetObject (SkiaApi.sk_shader_with_local_matrix (cast(sk_shader_t*)Handle, &localMatrix));
  }
	

	// CreateEmpty

	static SKShader CreateEmpty ()
  {
    return 	GetObject (SkiaApi.sk_shader_new_empty ());
  }
	

	// CreateColor

	static SKShader CreateColor (SKColor color)
  {
    return 	GetObject (SkiaApi.sk_shader_new_color (cast(uint)color));

  }
	
	static SKShader CreateColor (SKColorF color, SKColorSpace colorspace)
	{
		if (colorspace is null)
			throw new ArgumentNullException (colorspace.stringof);

		return GetObject (SkiaApi.sk_shader_new_color4f (&color, cast(sk_colorspace_t*)colorspace.Handle));
	}

	// CreateBitmap

	static SKShader CreateBitmap (SKBitmap src)
  {
    return CreateBitmap (src, SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);
  }
		

	static SKShader CreateBitmap (SKBitmap src, SKShaderTileMode tmx, SKShaderTileMode tmy)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy);
	}

	static SKShader CreateBitmap (SKBitmap src, SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix localMatrix)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy, localMatrix);
	}

	// CreateImage

	static SKShader CreateImage (SKImage src)
  {
    return 	CreateImage (src, SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);
  }
	

	static SKShader CreateImage (SKImage src, SKShaderTileMode tmx, SKShaderTileMode tmy)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy);
	}

	static SKShader CreateImage (SKImage src, SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix localMatrix)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy, localMatrix);
	}

	// CreatePicture

	static SKShader CreatePicture (SKPicture src)
  {
    return CreatePicture (src, SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);

  }
		
	static SKShader CreatePicture (SKPicture src, SKShaderTileMode tmx, SKShaderTileMode tmy)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy);
	}

	static SKShader CreatePicture (SKPicture src, SKShaderTileMode tmx, SKShaderTileMode tmy, SKRect tile)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy, tile);
	}

	static SKShader CreatePicture (SKPicture src, SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix localMatrix, SKRect tile)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return src.ToShader (tmx, tmy, localMatrix, tile);
	}

	// CreateLinearGradient

	static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColor[] colors, SKShaderTileMode mode)
  {
    return CreateLinearGradient (start, end, colors, null, mode);
  }
		
  static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColor[] colors, float[] colorPos, SKShaderTileMode mode)
  {
    return null;
    // auto points =  new SKPoint[1];
    // SKColor* c = colors.ptr;
		// float* cp = colorPos.ptr;
    // return GetObject (SkiaApi.sk_shader_new_linear_gradient (points, cast(uint*)c, cp, cast(int)colors.length, mode, null));
  }

	// static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColor[] colors, float[] colorPos, SKShaderTileMode mode)
	// {
	// 	if (colors is null)
	// 		throw new ArgumentNullException (colors.stringof);
	// 	if (colorPos !is null && colors.length != colorPos.length)
	// 		throw new ArgumentException ("The number of colors must match the number of color positions.");

	// 	auto points = stackalloc SKPoint[] { start, end };
	// 	SKColor* c = colors;
	// 	float* cp = colorPos;
	// 	return GetObject (SkiaApi.sk_shader_new_linear_gradient (points, cast(uint*)c, cp, colors.length, mode, null));
	// }

	// static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColor[] colors, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	// {
	// 	if (colors is null)
	// 		throw new ArgumentNullException (colors.stringof);
	// 	if (colorPos !is null && colors.length != colorPos.length)
	// 		throw new ArgumentException ("The number of colors must match the number of color positions.");

	// 	auto points = stackalloc SKPoint[] { start, end };
	// 	SKColor* c = colors;
	// 	float* cp = colorPos;
	// 	return GetObject (SkiaApi.sk_shader_new_linear_gradient (points, cast(uint*)c, cp, colors.length, mode, &localMatrix));
	// }

	static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColorF[] colors, SKColorSpace colorspace, SKShaderTileMode mode)
  {
    return 	CreateLinearGradient (start, end, colors, colorspace, null, mode);
  }
	

   static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode)
   {
     return null;
   }
	// static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode)
	// {
	// 	if (colors is null)
	// 		throw new ArgumentNullException (colors.stringof);
	// 	if (colorPos !is null && colors.length != colorPos.length)
	// 		throw new ArgumentException ("The number of colors must match the number of color positions.");

	// 	auto points = stackalloc SKPoint[] { start, end };
	// 	SKColorF* c = colors;
	// 	float* cp = colorPos;
	// 	return GetObject (SkiaApi.sk_shader_new_linear_gradient_color4f (points, c, colorspace?.Handle ?? null, cp, colors.length, mode, null));
	// }

	// static SKShader CreateLinearGradient (SKPoint start, SKPoint end, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	// {
	// 	if (colors is null)
	// 		throw new ArgumentNullException (colors.stringof);
	// 	if (colorPos !is null && colors.length != colorPos.length)
	// 		throw new ArgumentException ("The number of colors must match the number of color positions.");

	// 	auto points = stackalloc SKPoint[] { start, end };
	// 	SKColorF* c = colors;
	// 	float* cp = colorPos;
	// 	return GetObject (SkiaApi.sk_shader_new_linear_gradient_color4f (points, c, colorspace?.Handle ?? null, cp, colors.length, mode, &localMatrix));
	// }

	// CreateRadialGradient

	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColor[] colors, SKShaderTileMode mode)
  {
    return CreateRadialGradient (center, radius, colors, null, mode);
  }
		
	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColor[] colors, float[] colorPos, SKShaderTileMode mode)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_radial_gradient (&center, radius, cast(uint*)c, cp, cast(int)colors.length, mode, null));
	}

	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColor[] colors, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_radial_gradient (&center, radius, cast(uint*)c, cp, cast(int)colors.length, mode, &localMatrix));
	}

	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColorF[] colors, SKColorSpace colorspace, SKShaderTileMode mode)
	{
		return CreateRadialGradient (center, radius, colors, colorspace, null, mode);
	}
		

	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_radial_gradient_color4f (&center, radius, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, mode, null));
	}

	static SKShader CreateRadialGradient (SKPoint center, float radius, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_radial_gradient_color4f (&center, radius, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, mode, &localMatrix));
	}

	// CreateSweepGradient

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors)	
  {
		return CreateSweepGradient (center, colors, null, SKShaderTileMode.Clamp, 0, 360);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors, float[] colorPos)	
  {
		return CreateSweepGradient (center, colors, colorPos, SKShaderTileMode.Clamp, 0, 360);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors, float[] colorPos, SKMatrix localMatrix)	
  {
		return CreateSweepGradient (center, colors, colorPos, SKShaderTileMode.Clamp, 0, 360, localMatrix);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors, SKShaderTileMode tileMode, float startAngle, float endAngle)	
  {
		return CreateSweepGradient (center, colors, null, tileMode, startAngle, endAngle);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors, float[] colorPos, SKShaderTileMode tileMode, float startAngle, float endAngle)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_sweep_gradient (&center, cast(uint*)c, cp, cast(int)colors.length, tileMode, startAngle, endAngle, null));
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColor[] colors, float[] colorPos, SKShaderTileMode tileMode, float startAngle, float endAngle, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_sweep_gradient (&center, cast(uint*)c, cp, cast(int)colors.length, tileMode, startAngle, endAngle, &localMatrix));
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace)	
  {
		return CreateSweepGradient (center, colors, colorspace, null, SKShaderTileMode.Clamp, 0, 360);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos)	
  {
		return CreateSweepGradient (center, colors, colorspace, colorPos, SKShaderTileMode.Clamp, 0, 360);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKMatrix localMatrix)	
  {
		return CreateSweepGradient (center, colors, colorspace, colorPos, SKShaderTileMode.Clamp, 0, 360, localMatrix);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace, SKShaderTileMode tileMode, float startAngle, float endAngle)	
  {
		return CreateSweepGradient (center, colors, colorspace, null, tileMode, startAngle, endAngle);
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode tileMode, float startAngle, float endAngle)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_sweep_gradient_color4f (&center, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, tileMode, startAngle, endAngle, null));
	}

	static SKShader CreateSweepGradient (SKPoint center, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode tileMode, float startAngle, float endAngle, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_sweep_gradient_color4f (&center, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, tileMode, startAngle, endAngle, &localMatrix));
	}

	// CreateTwoPointConicalGradient

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColor[] colors, SKShaderTileMode mode)
  {
    return CreateTwoPointConicalGradient (start, startRadius, end, endRadius, colors, null, mode);
  }
		

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColor[] colors, float[] colorPos, SKShaderTileMode mode)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_two_point_conical_gradient (&start, startRadius, &end, endRadius, cast(uint*)c, cp, cast(int)colors.length, mode, null));
	}

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColor[] colors, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColor* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_two_point_conical_gradient (&start, startRadius, &end, endRadius, cast(uint*)c, cp, cast(int)colors.length, mode, &localMatrix));
	}

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColorF[] colors, SKColorSpace colorspace, SKShaderTileMode mode)
  {
    return CreateTwoPointConicalGradient (start, startRadius, end, endRadius, colors, colorspace, null, mode);
  }
	

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_two_point_conical_gradient_color4f (&start, startRadius, &end, endRadius, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, mode, null));
	}

	static SKShader CreateTwoPointConicalGradient (SKPoint start, float startRadius, SKPoint end, float endRadius, SKColorF[] colors, SKColorSpace colorspace, float[] colorPos, SKShaderTileMode mode, SKMatrix localMatrix)
	{
		if (colors is null)
			throw new ArgumentNullException (colors.stringof);
		if (colorPos !is null && colors.length != colorPos.length)
			throw new ArgumentException ("The number of colors must match the number of color positions.");

		SKColorF* c = colors.ptr;
		float* cp = colorPos.ptr;
		return GetObject (SkiaApi.sk_shader_new_two_point_conical_gradient_color4f (&start, startRadius, &end, endRadius, c, cast(sk_colorspace_t*)(colorspace.Handle ? colorspace.Handle : null), cp, cast(int)colors.length, mode, &localMatrix));
	}

	// CreatePerlinNoiseFractalNoise

	static SKShader CreatePerlinNoiseFractalNoise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed)	
  {
		return GetObject (SkiaApi.sk_shader_new_perlin_noise_fractal_noise (baseFrequencyX, baseFrequencyY, numOctaves, seed, null));
	}

	static SKShader CreatePerlinNoiseFractalNoise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKPointI tileSize)	
  {
		return CreatePerlinNoiseFractalNoise (baseFrequencyX, baseFrequencyY, numOctaves, seed, cast(SKSizeI)tileSize);
	}

	static SKShader CreatePerlinNoiseFractalNoise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKSizeI tileSize)	
  {
		return GetObject (SkiaApi.sk_shader_new_perlin_noise_fractal_noise (baseFrequencyX, baseFrequencyY, numOctaves, seed, &tileSize));
	}

	// CreatePerlinNoiseImprovedNoise

	static SKShader CreatePerlinNoiseImprovedNoise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float z)
  {
    return GetObject (SkiaApi.sk_shader_new_perlin_noise_improved_noise (baseFrequencyX, baseFrequencyY, numOctaves, z));
  }
		

	// CreatePerlinNoiseTurbulence

	static SKShader CreatePerlinNoiseTurbulence (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed)	
  {
		return GetObject (SkiaApi.sk_shader_new_perlin_noise_turbulence (baseFrequencyX, baseFrequencyY, numOctaves, seed, null));
	}

	static SKShader CreatePerlinNoiseTurbulence (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKPointI tileSize)	
  {
		return CreatePerlinNoiseTurbulence (baseFrequencyX, baseFrequencyY, numOctaves, seed, cast(SKSizeI)tileSize);
	}

	static SKShader CreatePerlinNoiseTurbulence (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKSizeI tileSize)	
  {
		return GetObject (SkiaApi.sk_shader_new_perlin_noise_turbulence (baseFrequencyX, baseFrequencyY, numOctaves, seed, &tileSize));
	}

	// CreateCompose

	static SKShader CreateCompose (SKShader shaderA, SKShader shaderB)
  {
    return CreateCompose (shaderA, shaderB, SKBlendMode.SrcOver);
  }
		

	static SKShader CreateCompose (SKShader shaderA, SKShader shaderB, SKBlendMode mode)
	{
		if (shaderA is null)
			throw new ArgumentNullException (shaderA.stringof);
		if (shaderB is null)
			throw new ArgumentNullException (shaderB.stringof);

		return GetObject (SkiaApi.sk_shader_new_blend (mode,cast(sk_shader_t*)shaderA.Handle, cast(sk_shader_t*)shaderB.Handle));
	}

	// CreateLerp

	static SKShader CreateLerp (float weight, SKShader dst, SKShader src)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		return GetObject (SkiaApi.sk_shader_new_lerp (weight, cast(sk_shader_t*)dst.Handle, cast(sk_shader_t*)src.Handle));
	}

	// CreateColorFilter

	static SKShader CreateColorFilter (SKShader shader, SKColorFilter filter)
	{
		if (shader is null)
			throw new ArgumentNullException (shader.stringof);
		if (filter is null)
			throw new ArgumentNullException (filter.stringof);

		return shader.WithColorFilter (filter);
	}

	// CreateLocalMatrix

	static SKShader CreateLocalMatrix (SKShader shader, SKMatrix localMatrix)
	{
		if (shader is null)
			throw new ArgumentNullException (shader.stringof);

		return shader.WithLocalMatrix (localMatrix);
	}

	static SKShader GetObject (void* handle)
  {
    // return GetOrAddObject (handle, (h, o){return new SKShader (h, o);});
    return GetOrAddObject!(SKShader)(handle, delegate SKShader (h, o) { return new SKShader (h, o);});
  }
		
}
