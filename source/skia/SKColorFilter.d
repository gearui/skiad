module skia.SKColorFilter;

import skia.Definitions;
import skia.Exceptions;
import skia.SKObject;
import skia.SKColor;
import skia.SkiaApi;
import skia.SKColorSpace;

// TODO: `FilterColor` may be useful

/**
 * 
 */
class SKColorFilter : SKObject
{
	enum ColorMatrixSize = 20;
	enum TableMaxLength = 256;

	this(void* handle, bool owns)
	{
    	super(handle, owns);
	}

	override void* Handle()
	{
		return null;
	}

	protected override void Dispose (bool disposing)
  {
      return super.Dispose (disposing);
  }
		

	static SKColorFilter CreateBlendMode(SKColor c, SKBlendMode mode)
	{
		return GetObject (SkiaApi.sk_colorfilter_new_mode(cast(uint)c, mode));
	}

	static SKColorFilter CreateLighting(SKColor mul, SKColor add)
	{
		return GetObject (SkiaApi.sk_colorfilter_new_lighting(cast(uint)mul, cast(uint)add));
	}

	static SKColorFilter CreateCompose(SKColorFilter outer, SKColorFilter inner)
	{
		if (outer is null)
			throw new ArgumentNullException("outer");
		if (inner is null)
			throw new ArgumentNullException("inner");
		return GetObject (SkiaApi.sk_colorfilter_new_compose(cast(sk_colorfilter_t*)outer.Handle, cast(sk_colorfilter_t*)inner.Handle));
	}

	static SKColorFilter CreateColorMatrix(float[] matrix)
	{
		if (matrix is null)
			throw new ArgumentNullException("matrix");
		if (matrix.length != 20)
			throw new ArgumentException("Matrix must have a length of 20.", "matrix");
		float* m = matrix.ptr;
		return GetObject (SkiaApi.sk_colorfilter_new_color_matrix (m));
	}

	static SKColorFilter CreateLumaColor()
	{
		return GetObject (SkiaApi.sk_colorfilter_new_luma_color());
	}

	static SKColorFilter CreateTable(ubyte[] table)
	{
		if (table is null)
			throw new ArgumentNullException("table");
		if (table.length != TableMaxLength)
			throw new ArgumentException("Table must have a length of {TableMaxLength}.", "table");
		ubyte* t = cast(ubyte*)table.ptr;
		return GetObject (SkiaApi.sk_colorfilter_new_table (t));
	}

	static SKColorFilter CreateTable(ubyte[] tableA, ubyte[] tableR, ubyte[] tableG, ubyte[] tableB)
	{
		if (tableA !is null &&  tableA.length != TableMaxLength)
			throw new ArgumentException("Table A must have a length of {TableMaxLength}.", "tableA");
		if (tableR !is null && tableR.length != TableMaxLength)
			throw new ArgumentException("Table R must have a length of {TableMaxLength}.", "tableR");
		if (tableG !is null && tableG.length != TableMaxLength)
			throw new ArgumentException("Table G must have a length of {TableMaxLength}.", "tableG");
		if (tableB !is null && tableB.length != TableMaxLength)
			throw new ArgumentException("Table B must have a length of {TableMaxLength}.", "tableB");

		ubyte* a = tableA.ptr;
		ubyte* r = tableR.ptr;
		ubyte* g = tableG.ptr;
		ubyte* b = tableB.ptr;
		return GetObject (SkiaApi.sk_colorfilter_new_table_argb (a, r, g, b));
	}

	static SKColorFilter CreateHighContrast(SKHighContrastConfig config)
	{
		return GetObject (SkiaApi.sk_colorfilter_new_high_contrast(&config));
	}

	static SKColorFilter CreateHighContrast(bool grayscale, SKHighContrastConfigInvertStyle invertStyle, float contrast)
	{
		return CreateHighContrast(SKHighContrastConfig(grayscale, invertStyle, contrast));
	}

	static SKColorFilter GetObject (void* handle)
	{
		return GetOrAddObject!(SKColorFilter)(handle, delegate SKColorFilter (h, o) { return new SKColorFilter (h, o);});
	}
		
}
