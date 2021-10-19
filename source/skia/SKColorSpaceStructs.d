module skia.SKColorSpaceStructs;

import skia.Definitions;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKData;
import skia.SKMatrix44;
import skia.Exceptions;

import std.range;

enum SKColorSpaceRenderTargetGamma
{
	Linear = 0,
	Srgb = 1,
}
alias ToColorSpaceTransferFn = SkiaExtensions.ToColorSpaceTransferFn;


enum SKColorSpaceGamut
{
	AdobeRgb = 1,
	Dcip3D65 = 2,
	Rec2020 = 3,
	Srgb = 0,
}


alias ToColorSpaceXyz = SkiaExtensions.ToColorSpaceXyz;



enum SKColorSpaceType
{
	Cmyk = 1,
	Gray = 2,
	Rgb = 0,
}

enum SKNamedGamma
{
	Linear = 0,
	Srgb = 1,
	TwoDotTwoCurve = 2,
	NonStandard = 3,
}

class SkiaExtensions
{

	// static SKColorSpaceTransferFn ToColorSpaceTransferFn (this SKColorSpaceRenderTargetGamma gamma)
  static SKColorSpaceTransferFn ToColorSpaceTransferFn (SKColorSpaceRenderTargetGamma gamma)
  {
    switch(gamma)
		{
			case SKColorSpaceRenderTargetGamma.Linear:
			  return SKColorSpaceTransferFn.Linear;
			case SKColorSpaceRenderTargetGamma.Srgb:
			  return SKColorSpaceTransferFn.Srgb;
			default:
			  throw new ArgumentOutOfRangeException (gamma.stringof);
		}
  }
	

	// static SKColorSpaceTransferFn ToColorSpaceTransferFn (this SKNamedGamma gamma)
  static SKColorSpaceTransferFn ToColorSpaceTransferFn (SKNamedGamma gamma)
  {
    switch(gamma)
		{
			case SKNamedGamma.Linear:
		    return SKColorSpaceTransferFn.Linear;
			case SKNamedGamma.Srgb:
			  return SKColorSpaceTransferFn.Srgb;
			case SKNamedGamma.TwoDotTwoCurve:
			  return SKColorSpaceTransferFn.TwoDotTwo;
			case SKNamedGamma.NonStandard:
			  return SKColorSpaceTransferFn.Empty;
			default:
			  throw new ArgumentOutOfRangeException (gamma.stringof);
		}
  }
	

	// static SKColorSpaceXyz ToColorSpaceXyz (this SKColorSpaceGamut gamut)
  static SKColorSpaceXyz ToColorSpaceXyz (SKColorSpaceGamut gamut)
  {
    switch(gamut)
		{
			case SKColorSpaceGamut.AdobeRgb:
			  return SKColorSpaceXyz.AdobeRgb;
			case SKColorSpaceGamut.Dcip3D65:
			  return SKColorSpaceXyz.Dcip3;
			case SKColorSpaceGamut.Rec2020:
			  return SKColorSpaceXyz.Rec2020;
			case SKColorSpaceGamut.Srgb:
			  return SKColorSpaceXyz.Srgb;
			default:
			  throw new ArgumentOutOfRangeException (gamut.stringof);
		}
  }
	

	// static SKColorSpaceXyz ToColorSpaceXyz (this SKMatrix44 matrix)
  static SKColorSpaceXyz ToColorSpaceXyz (SKMatrix44 matrix)
	{
		if (matrix is null)
			throw new ArgumentNullException (matrix.stringof);

		auto values = matrix.ToRowMajor ();
		return SKColorSpaceXyz (
			values[0], values[1], values[2],
			values[4], values[5], values[6],
			values[8], values[9], values[10]);
	}
}

// struct SKColorSpacePrimaries
// {
	
	
// }

// struct SKColorSpaceTransferFn
// {
// 	static SKColorSpaceTransferFn Srgb() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_srgb (&fn);
// 			return fn;
// 	}

// 	static SKColorSpaceTransferFn TwoDotTwo() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_2dot2 (&fn);
// 			return fn;
// 	}

// 	static SKColorSpaceTransferFn Linear() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_linear (&fn);
// 			return fn;
// 	}

// 	static SKColorSpaceTransferFn Rec2020() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_rec2020 (&fn);
// 			return fn;
// 	}

// 	static SKColorSpaceTransferFn Pq() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_pq (&fn);
// 			return fn;
// 	}

// 	static SKColorSpaceTransferFn Hlg() 
//   {
// 			SKColorSpaceTransferFn fn;
// 			SkiaApi.sk_colorspace_transfer_fn_named_hlg (&fn);
// 			return fn;
// 	}

// 	static  SKColorSpaceTransferFn Empty;

// 	this (float[] values)
// 	{
// 		if (values is null)
// 			throw new ArgumentNullException (values.stringof);
// 		if (values.Length != 7)
// 			throw new ArgumentException ("The values must have exactly 7 items, one for each of [G, A, B, C, D, E, F].", values.stringof);

// 		fG = values[0];
// 		fA = values[1];
// 		fB = values[2];
// 		fC = values[3];
// 		fD = values[4];
// 		fE = values[5];
// 		fF = values[6];
// 	}

// 	this (float g, float a, float b, float c, float d, float e, float f)
// 	{
// 		fG = g;
// 		fA = a;
// 		fB = b;
// 		fC = c;
// 		fD = d;
// 		fE = e;
// 		fF = f;
// 	}

// 	// const float[] Values()
//   // {
//   //   return new[] { fG, fA, fB, fC, fD, fE, fF };
//   // }
	

// 	const SKColorSpaceTransferFn Invert ()
// 	{
// 		SKColorSpaceTransferFn inverted;
// 		SKColorSpaceTransferFn* t = &this;
// 		SkiaApi.sk_colorspace_transfer_fn_invert (t, &inverted);
// 		return inverted;
// 	}

// 	const float Transform (float x)
// 	{
// 		SKColorSpaceTransferFn* t = &this;
// 		return SkiaApi.sk_colorspace_transfer_fn_eval (t, x);
// 	}
// }

// struct SKColorSpaceXyz
// {
// 	static SKColorSpaceXyz Srgb()
//   {
// 			SKColorSpaceXyz xyz;
// 			SkiaApi.sk_colorspace_xyz_named_srgb (&xyz);
// 			return xyz;
// 	}

// 	static SKColorSpaceXyz AdobeRgb() 
//   {
// 			SKColorSpaceXyz xyz;
// 			SkiaApi.sk_colorspace_xyz_named_adobe_rgb (&xyz);
// 			return xyz;
// 	}

// 	static SKColorSpaceXyz Dcip3() 
//   {
// 			SKColorSpaceXyz xyz;
// 			SkiaApi.sk_colorspace_xyz_named_dcip3 (&xyz);
// 			return xyz;
// 	}

// 	static SKColorSpaceXyz Rec2020 ()
//   {
// 			SKColorSpaceXyz xyz;
// 			SkiaApi.sk_colorspace_xyz_named_rec2020 (&xyz);
// 			return xyz;
// 	}

// 	static SKColorSpaceXyz Xyz ()
//   {
// 			SKColorSpaceXyz xyz;
// 			SkiaApi.sk_colorspace_xyz_named_xyz (&xyz);
// 			return xyz;
// 	}

// 	// static readonly SKColorSpaceXyz Empty;

// 	this (float value)
// 	{
// 		fM00 = value;
// 		fM01 = value;
// 		fM02 = value;

// 		fM10 = value;
// 		fM11 = value;
// 		fM12 = value;

// 		fM20 = value;
// 		fM21 = value;
// 		fM22 = value;
// 	}

// 	this (float[] values)
// 	{
// 		if (values is null)
// 			throw new ArgumentNullException (values.stringof);
// 		if (values.Length != 9)
// 			throw new ArgumentException ("The matrix array must have a length of 9.", values.stringof);

// 		fM00 = values[0];
// 		fM01 = values[1];
// 		fM02 = values[2];

// 		fM10 = values[3];
// 		fM11 = values[4];
// 		fM12 = values[5];

// 		fM20 = values[6];
// 		fM21 = values[7];
// 		fM22 = values[8];
// 	}

// 	this (
// 		float m00, float m01, float m02,
// 		float m10, float m11, float m12,
// 		float m20, float m21, float m22)
// 	{
// 		fM00 = m00;
// 		fM01 = m01;
// 		fM02 = m02;

// 		fM10 = m10;
// 		fM11 = m11;
// 		fM12 = m12;

// 		fM20 = m20;
// 		fM21 = m21;
// 		fM22 = m22;
// 	}

// 	// float[] Values() {
// 	// 	 return new float[9] {
// 	// 		fM00, fM01, fM02,
// 	// 		fM10, fM11, fM12,
// 	// 		fM20, fM21, fM22,
// 	// 	};
// 	// }

//   void Values(float[] value) {
	
// 			if (value.Length != 9)
// 				throw new ArgumentException ("The matrix array must have a length of 9.", value.stringof);

// 			fM00 = value[0];
// 			fM01 = value[1];
// 			fM02 = value[2];

// 			fM10 = value[3];
// 			fM11 = value[4];
// 			fM12 = value[5];

// 			fM20 = value[6];
// 			fM21 = value[7];
// 			fM22 = value[8];
		
// 	}

// 	// const float this[int x, int y] {
// 	// 		if (x < 0 || x >= 3)
// 	// 			throw new ArgumentOutOfRangeException (x.stringof);
// 	// 		if (y < 0 || y >= 3)
// 	// 			throw new ArgumentOutOfRangeException (y.stringof);

// 	// 		auto idx = x + (y * 3);
// 	// 		switch(idx)
// 	// 		{
// 	// 			case 0:return fM00;
// 	// 			case 1:return fM01;
// 	// 			case 2:return fM02;
// 	// 			case 3:return fM10;
// 	// 			case 4:return fM11;
// 	// 			case 5:return fM12;
// 	// 			case 6:return fM20;
// 	// 			case 7:return fM21;
// 	// 			case 8:return fM22;
// 	// 			default:
// 	// 			return throw new ArgumentOutOfRangeException ("index");
// 	// 		}
// 	// }

// 	const SKColorSpaceXyz Invert ()
// 	{
// 		SKColorSpaceXyz inverted;
// 		SKColorSpaceXyz* t = &this;
// 		SkiaApi.sk_colorspace_xyz_invert (t, &inverted);
// 		return inverted;
// 	}

// 	static SKColorSpaceXyz Concat (SKColorSpaceXyz a, SKColorSpaceXyz b)
// 	{
// 		SKColorSpaceXyz result;
// 		SkiaApi.sk_colorspace_xyz_concat (&a, &b, &result);
// 		return result;
// 	}

// 	 SKMatrix44 ToMatrix44 ()
// 	{
// 		auto matrix = new SKMatrix44 ();
// 		matrix.Set3x3RowMajor (Values);
// 		return matrix;
// 	}
// }

class SKColorSpaceIccProfile : SKObject
{
	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	this ()
	{
    this (SkiaApi.sk_colorspace_icc_profile_new (), true);
		if (Handle is null)
			throw new InvalidOperationException ("Unable to create a new SK3dView instance.");
	}

	protected override void DisposeNative ()
  {
    SkiaApi.sk_colorspace_icc_profile_delete (cast(sk_colorspace_icc_profile_t*)Handle);
  }
		

	// properties

	long Size() {
		
			uint size;
			SkiaApi.sk_colorspace_icc_profile_get_buffer (cast(sk_colorspace_icc_profile_t*)Handle, &size);
			return size;
		
	}

	void* Buffer()
  {
    return 	cast(void*)SkiaApi.sk_colorspace_icc_profile_get_buffer (cast(sk_colorspace_icc_profile_t*)Handle, null);
  }
	

	// ToColorSpaceXyz

	bool ToColorSpaceXyz (out SKColorSpaceXyz toXyzD50)
	{
		SKColorSpaceXyz* xyz = &toXyzD50;
		return SkiaApi.sk_colorspace_icc_profile_get_to_xyzd50 (cast(sk_colorspace_icc_profile_t*)Handle, xyz);
	}

	SKColorSpaceXyz ToColorSpaceXyz ()
  {
    SKColorSpaceXyz toXYZ;
    return 	ToColorSpaceXyz (toXYZ) ? toXYZ : SKColorSpaceXyz.Empty;
  }
	

	// Create

	// static SKColorSpaceIccProfile Create (byte[] data)
  // {
  //   return Create (data);
  // }
		

	static SKColorSpaceIccProfile Create (byte[] data)
	{
		if (data.empty)
			return null;

		SKData skData = SKData.CreateCopy (data);
		auto icc = Create (skData);
		if (icc is null)
			skData.Dispose ();
		return icc;
	}

	static SKColorSpaceIccProfile Create (SKData data)
	{
		if (data is null)
			throw new ArgumentNullException (data.stringof);

		if (data.IsEmpty)
			return null;

		return Referenced (Create (data.Data, data.Size), data);
	}

	static SKColorSpaceIccProfile Create (void* data, long length)
	{
		if (data is null)
			throw new ArgumentNullException (data.stringof);

		if (length <= 0)
			return null;

		auto icc = new SKColorSpaceIccProfile ();
		if (!SkiaApi.sk_colorspace_icc_profile_parse (cast(void*)data, cast(size_t)length, cast(sk_colorspace_icc_profile_t*)icc.Handle)) {
			icc.Dispose ();
			icc = null;
		}
		return icc;
	}
}
