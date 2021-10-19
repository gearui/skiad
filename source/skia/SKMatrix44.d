module skia.SKMatrix44;

import skia.Definitions;
import skia.MathTypes;
import skia.SkiaApi;
import skia.SKObject;
import skia.Exceptions;
import skia.SKMatrix;

class SKMatrix44 : SKObject
{
	this (void* x, bool owns)
	{
    super(x, owns);
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
    return SkiaApi.sk_matrix44_destroy (cast(sk_matrix44_t*)Handle);
  }
	

	this ()
	{
    super (SkiaApi.sk_matrix44_new (), true);
		if (Handle is null)
			throw new InvalidOperationException ("Unable to create a new SKMatrix44 instance.");
	}

	this (SKMatrix44 src)
	{
    this (null, true);
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		Handle = SkiaApi.sk_matrix44_new_copy (cast(sk_matrix44_t*)src.Handle);

		if (Handle is null)
			throw new InvalidOperationException ("Unable to create a new SKMatrix44 instance.");
	}

	this (SKMatrix44 a, SKMatrix44 b)
	{
    this (null, true);
		if (a is null)
			throw new ArgumentNullException (a.stringof);
		if (b is null)
			throw new ArgumentNullException (b.stringof);

		Handle = SkiaApi.sk_matrix44_new_concat (cast(sk_matrix44_t*)a.Handle, cast(sk_matrix44_t*)b.Handle);

		if (Handle is null)
			throw new InvalidOperationException ("Unable to create a new SKMatrix44 instance.");
	}

	this (SKMatrix src)
	{
		this (SkiaApi.sk_matrix44_new_matrix (&src), true);
		if (Handle is null)
			throw new InvalidOperationException ("Unable to create a new SKMatrix44 instance.");
	}

	// properties

	SKMatrix Matrix() {
		SKMatrix matrix;
		SkiaApi.sk_matrix44_to_matrix (cast(sk_matrix44_t*)Handle, &matrix);
		return matrix;
	}

	SKMatrix44TypeMask Type()
  {
    return SkiaApi.sk_matrix44_get_type (cast(sk_matrix44_t*)Handle);
  }
		

	// float this[int row, int column] {
	// 	get => SkiaApi.sk_matrix44_get (cast(sk_matrix44_t*)Handle, row, column);
	// 	set => SkiaApi.sk_matrix44_set (cast(sk_matrix44_t*)Handle, row, column, value);
	// }

	// Create*

	static SKMatrix44 CreateIdentity ()
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetIdentity ();
		return matrix;
	}
	static SKMatrix44 CreateTranslate (float x, float y, float z)
  {
    return 	CreateTranslation (x, y, z);
  }
	

	static SKMatrix44 CreateTranslation (float x, float y, float z)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetTranslate (x, y, z);
		return matrix;
	}

	static SKMatrix44 CreateScale (float x, float y, float z)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetScale (x, y, z);
		return matrix;
	}

	static SKMatrix44 CreateRotation (float x, float y, float z, float radians)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetRotationAbout (x, y, z, radians);
		return matrix;
	}

	static SKMatrix44 CreateRotationDegrees (float x, float y, float z, float degrees)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetRotationAboutDegrees (x, y, z, degrees);
		return matrix;
	}

	// From

	static SKMatrix44 FromRowMajor (float[] src)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetRowMajor (src);
		return matrix;
	}

	static SKMatrix44 FromColumnMajor (float[] src)
	{
		auto matrix = new SKMatrix44 ();
		matrix.SetColumnMajor (src);
		return matrix;
	}

	// To*

	float[] ToColumnMajor ()
	{
		auto dst = new float[16];
		ToColumnMajor (dst);
		return dst;
	}

	void ToColumnMajor (float[] dst)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (dst.length != 16)
			throw new ArgumentException ("The destination array must be 16 entries.", dst.stringof);

		float* d = dst.ptr;
		SkiaApi.sk_matrix44_as_col_major (cast(sk_matrix44_t*)Handle, d);
	}

	float[] ToRowMajor ()
	{
		auto dst = new float[16];
		ToRowMajor (dst);
		return dst;
	}

	void ToRowMajor (float[] dst)
	{
		if (dst is null)
			throw new ArgumentNullException (dst.stringof);
		if (dst.length != 16)
			throw new ArgumentException ("The destination array must be 16 entries.", dst.stringof);

		float* d = dst.ptr;
		SkiaApi.sk_matrix44_as_row_major (cast(sk_matrix44_t*)Handle, d);
	}

	// Equal

	static bool Equal (SKMatrix44 left, SKMatrix44 right)
	{
		if (left is null)
			throw new ArgumentNullException (left.stringof);
		if (right is null)
			throw new ArgumentNullException (right.stringof);

		return SkiaApi.sk_matrix44_equals (cast(sk_matrix44_t*)left.Handle, cast(sk_matrix44_t*)right.Handle);
	}

	// Set*

	void SetIdentity ()
  {
    return 	SkiaApi.sk_matrix44_set_identity (cast(sk_matrix44_t*)Handle);
  }
	

	void SetColumnMajor (float[] src)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);
		if (src.length != 16)
			throw new ArgumentException ("The source array must be 16 entries.", src.stringof);

		float* s = src.ptr;
		SkiaApi.sk_matrix44_set_col_major (cast(sk_matrix44_t*)Handle, s);
	}

	void SetRowMajor (float[] src)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);
		if (src.length != 16)
			throw new ArgumentException ("The source array must be 16 entries.", src.stringof);

		float* s = src.ptr;
		SkiaApi.sk_matrix44_set_row_major (cast(sk_matrix44_t*)Handle, s);
	}

	// void Set3x3ColumnMajor (float[] src)
	// {
	// 	if (src.length != 9)
	// 		throw new ArgumentException ("The source array must be 9 entries.", src.stringof);

	// 	auto row = stackalloc float[9] { src[0], src[3], src[6], src[1], src[4], src[7], src[2], src[5], src[8] };
	// 	SkiaApi.sk_matrix44_set_3x3_row_major (cast(sk_matrix44_t*)Handle, row);
	// }

	void Set3x3RowMajor (float[] src)
	{
		if (src.length != 9)
			throw new ArgumentException ("The source array must be 9 entries.", src.stringof);

		float* s = src.ptr;
		SkiaApi.sk_matrix44_set_3x3_row_major (cast(sk_matrix44_t*)Handle, s);
	}

	void SetTranslate (float dx, float dy, float dz)	
  {
		return SkiaApi.sk_matrix44_set_translate (cast(sk_matrix44_t*)Handle, dx, dy, dz);
	}

	void SetScale (float sx, float sy, float sz)	
  {
		return SkiaApi.sk_matrix44_set_scale (cast(sk_matrix44_t*)Handle, sx, sy, sz);
	}

	void SetRotationAboutDegrees (float x, float y, float z, float degrees)	
  {
		return SkiaApi.sk_matrix44_set_rotate_about_degrees (cast(sk_matrix44_t*)Handle, x, y, z, degrees);
	}

	void SetRotationAbout (float x, float y, float z, float radians)	
  {
		return SkiaApi.sk_matrix44_set_rotate_about_radians (cast(sk_matrix44_t*)Handle, x, y, z, radians);
	}

	void SetRotationAboutUnit (float x, float y, float z, float radians)	
  {
		return SkiaApi.sk_matrix44_set_rotate_about_radians_unit (cast(sk_matrix44_t*)Handle, x, y, z, radians);
	}

	void SetConcat (SKMatrix44 a, SKMatrix44 b)
	{
		if (a is null)
			throw new ArgumentNullException (a.stringof);
		if (b is null)
			throw new ArgumentNullException (b.stringof);

		SkiaApi.sk_matrix44_set_concat (cast(sk_matrix44_t*)Handle, cast(sk_matrix44_t*)a.Handle, cast(sk_matrix44_t*)b.Handle);
	}

	// Pre* / Post*

	void PreTranslate (float dx, float dy, float dz)	
  {
		return SkiaApi.sk_matrix44_pre_translate (cast(sk_matrix44_t*)Handle, dx, dy, dz);
	}

	void PostTranslate (float dx, float dy, float dz)	
  {
		return SkiaApi.sk_matrix44_post_translate (cast(sk_matrix44_t*)Handle, dx, dy, dz);
	}

	void PreScale (float sx, float sy, float sz)	
  {
		return SkiaApi.sk_matrix44_pre_scale (cast(sk_matrix44_t*)Handle, sx, sy, sz);
	}

	void PostScale (float sx, float sy, float sz)	
  {
		return SkiaApi.sk_matrix44_post_scale (cast(sk_matrix44_t*)Handle, sx, sy, sz);
	}

	void PreConcat (SKMatrix44 m)
	{
		if (m is null)
			throw new ArgumentNullException (m.stringof);

		SkiaApi.sk_matrix44_pre_concat (cast(sk_matrix44_t*)Handle, cast(sk_matrix44_t*)m.Handle);
	}

	void PostConcat (SKMatrix44 m)
	{
		if (m is null)
			throw new ArgumentNullException (m.stringof);

		SkiaApi.sk_matrix44_post_concat (cast(sk_matrix44_t*)Handle, cast(sk_matrix44_t*)m.Handle);
	}

	// Invert

	bool IsInvertible()
  {
    return SkiaApi.sk_matrix44_invert (cast(sk_matrix44_t*)Handle, null);
  }
	

	SKMatrix44 Invert ()
	{
		SKMatrix44 inverse = new SKMatrix44 ();
		if (!Invert (inverse)) {
			inverse.Dispose ();
			inverse = null;
		}
		return inverse;
	}

	bool Invert (SKMatrix44 inverse)
	{
		if (inverse is null)
			throw new ArgumentNullException (inverse.stringof);

		return SkiaApi.sk_matrix44_invert (cast(sk_matrix44_t*)Handle, cast(sk_matrix44_t*)inverse.Handle);
	}

	// Transpose

	void Transpose ()
  {
    return SkiaApi.sk_matrix44_transpose (cast(sk_matrix44_t*)Handle);
  }
	

	// MapScalars

	// float[] MapScalars (float x, float y, float z, float w)
	// {
	// 	auto srcVector4 = new float[4] { x, y, z, w };
	// 	auto dstVector4 = new float[4];
	// 	MapScalars (srcVector4, dstVector4);
	// 	return dstVector4;
	// }

	float[] MapScalars (float[] srcVector4)
	{
		auto dstVector4 = new float[4];
		MapScalars (srcVector4, dstVector4);
		return dstVector4;
	}

	void MapScalars (float[] srcVector4, float[] dstVector4)
	{
		if (srcVector4 is null)
			throw new ArgumentNullException (srcVector4.stringof);
		if (srcVector4.length != 4)
			throw new ArgumentException ("The source vector array must be 4 entries.", srcVector4.stringof);
		if (dstVector4 is null)
			throw new ArgumentNullException (dstVector4.stringof);
		if (dstVector4.length != 4)
			throw new ArgumentException ("The destination vector array must be 4 entries.", dstVector4.stringof);

		float* s = srcVector4.ptr;
		float* d = dstVector4.ptr;
		SkiaApi.sk_matrix44_map_scalars (cast(sk_matrix44_t*)Handle, s, d);
	}

	// MapPoints

	// SKPoint MapPoint (SKPoint src)
  // {
  //   return MapPoints (new[] { src })[0];
  // }
	

	SKPoint[] MapPoints (SKPoint[] src)
	{
		if (src is null)
			throw new ArgumentNullException (src.stringof);

		auto count = src.length;
		auto src2Length = count * 2;
		//var src4Length = count * 4;

		auto src2 = new float[src2Length];
		for (int i = 0, i2 = 0; i < count; i++, i2 += 2) {
			src2[i2] = src[i].X;
			src2[i2 + 1] = src[i].Y;
		}

		auto dst4 = MapVector2 (src2);

		auto dst = new SKPoint[count];
		for (int i = 0, i4 = 0; i < count; i++, i4 += 4) {
			dst[i].X = dst4[i4];
			dst[i].Y = dst4[i4 + 1];
		}

		return dst;
	}

	// MapVector2

	float[] MapVector2 (float[] src2)
	{
		if (src2 is null)
			throw new ArgumentNullException (src2.stringof);
		if (src2.length % 2 != 0)
			throw new ArgumentException ("The source vector array must be a set of pairs.", src2.stringof);

		auto dst4 = new float[src2.length * 2];
		MapVector2 (src2, dst4);
		return dst4;
	}

	void MapVector2 (float[] src2, float[] dst4)
	{
		if (src2 is null)
			throw new ArgumentNullException (src2.stringof);
		if (src2.length % 2 != 0)
			throw new ArgumentException ("The source vector array must be a set of pairs.", src2.stringof);
		if (dst4 is null)
			throw new ArgumentNullException (dst4.stringof);
		if (dst4.length % 4 != 0)
			throw new ArgumentException ("The destination vector array must be a set quads.", dst4.stringof);
		if (src2.length / 2 != dst4.length / 4)
			throw new ArgumentException ("The source vector array must have the same number of pairs as the destination vector array has quads.", dst4.stringof);

		float* s = src2.ptr;
		float* d = dst4.ptr;
		SkiaApi.sk_matrix44_map2 (cast(sk_matrix44_t*)Handle, s, cast(int)(src2.length / 2), d);
	}

	// Preserves2DAxisAlignment

	bool Preserves2DAxisAlignment (float epsilon)
  {
    return SkiaApi.sk_matrix44_preserves_2d_axis_alignment (cast(sk_matrix44_t*)Handle, epsilon);
  }
	

	// Determinant

	double Determinant ()
  {
    return SkiaApi.sk_matrix44_determinant (cast(sk_matrix44_t*)Handle);
  }
		

	// operators

	// static implicit operator SKMatrix44 (SKMatrix matrix)
  // {
  //   return new SKMatrix44 (matrix);
  // }
		

	static SKMatrix44 GetObject (void* handle, bool owns = true)
  {
    
    return GetOrAddObject!(SKMatrix44)(handle, owns, delegate SKMatrix44 (h, o) { return new SKMatrix44 (h, o);});
    // return GetOrAddObject (handle, owns, (h, o) {return new SKMatrix44 (h, o);});
  }
		
}
