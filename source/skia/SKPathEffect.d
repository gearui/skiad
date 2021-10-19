module skia.SKPathEffect;

import skia.Definitions;
import skia.SKMatrix;
import skia.SKPath;
import skia.SKObject;
import skia.Exceptions;
import skia.SkiaApi;

class SKPathEffect : SKObject // 
{
	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	protected override void Dispose (bool disposing)
  {
    return super.Dispose (disposing);
  }
		

	static SKPathEffect CreateCompose(SKPathEffect outer, SKPathEffect inner)
	{
		if (outer is null)
			throw new ArgumentNullException("outer");
		if (inner is null)
			throw new ArgumentNullException("inner");
		return GetObject(SkiaApi.sk_path_effect_create_compose(cast(sk_path_effect_t*)outer.Handle, cast(sk_path_effect_t*)inner.Handle));
	}

	static SKPathEffect CreateSum(SKPathEffect first, SKPathEffect second)
	{
		if (first is null)
			throw new ArgumentNullException("first");
		if (second is null)
			throw new ArgumentNullException("second");
		return GetObject(SkiaApi.sk_path_effect_create_sum(cast(sk_path_effect_t*)first.Handle, cast(sk_path_effect_t*)second.Handle));
	}

	static SKPathEffect CreateDiscrete(float segLength, float deviation, uint seedAssist = 0)
	{
		return GetObject(SkiaApi.sk_path_effect_create_discrete(segLength, deviation, seedAssist));
	}

	static SKPathEffect CreateCorner(float radius)
	{
		return GetObject(SkiaApi.sk_path_effect_create_corner(radius));
	}

	static SKPathEffect Create1DPath(SKPath path, float advance, float phase, SKPath1DPathEffectStyle style)
	{
		if (path is null)
			throw new ArgumentNullException("path");
		return GetObject(SkiaApi.sk_path_effect_create_1d_path(cast(sk_path_t*)path.Handle, advance, phase, style));
	}

	static SKPathEffect Create2DLine(float width, SKMatrix matrix)
	{
		return GetObject(SkiaApi.sk_path_effect_create_2d_line(width, &matrix));
	}

	static SKPathEffect Create2DPath(SKMatrix matrix, SKPath path)
	{
		if (path is null)
			throw new ArgumentNullException("path");
		return GetObject(SkiaApi.sk_path_effect_create_2d_path(cast(SKMatrix*)&matrix, cast(sk_path_t*)path.Handle));
	}

	static SKPathEffect CreateDash(float[] intervals, float phase)
	{
		if (intervals is null)
			throw new ArgumentNullException("intervals");
		if (intervals.length % 2 != 0)
			throw new ArgumentException("The intervals must have an even number of entries.", "intervals");
		float* i = intervals.ptr;
		return GetObject (SkiaApi.sk_path_effect_create_dash (i, cast(int)intervals.length, phase));
	}

	static SKPathEffect CreateTrim(float start, float stop)
	{
		return CreateTrim(start, stop, SKTrimPathEffectMode.Normal);
	}

	static SKPathEffect CreateTrim(float start, float stop, SKTrimPathEffectMode mode)
	{
		return GetObject(SkiaApi.sk_path_effect_create_trim(start, stop, mode));
	}

	static SKPathEffect GetObject (void* handle)
  {
    return GetOrAddObject!(SKPathEffect) (handle, (h, o) {return new SKPathEffect (h, o);});
  }
		
}

