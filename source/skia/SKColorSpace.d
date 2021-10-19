module skia.SKColorSpace;

import skia.Definitions;
import skia.Exceptions;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKColorSpaceStructs;
import skia.SKData;
import skia.SKMatrix44;

import std.concurrency : initOnce;

class SKColorSpace : SKObject, ISKNonVirtualReferenceCounted
{
	static SKColorSpace srgb() {
		__gshared SKColorSpace inst;
		return initOnce!inst(new SKColorSpaceStatic (SkiaApi.sk_colorspace_new_srgb ()));
	}

	private static SKColorSpace srgbLinear() {
		__gshared SKColorSpace inst;
		return initOnce!inst(new SKColorSpaceStatic (SkiaApi.sk_colorspace_new_srgb_linear ()));
	}


	static void EnsureStaticInstanceAreInitialized ()
	{
		// IMPORTANT: do not remove to ensure that the static instances
		//            are initialized before any access is made to them
	}

	this (void* handle, bool owns)
	{
    super(handle, owns);
	}

	void ReferenceNative ()	
  {
		return SkiaApi.sk_colorspace_ref (cast(sk_colorspace_t*)Handle);
	}

	void UnreferenceNative ()	
  {
		return SkiaApi.sk_colorspace_unref (cast(sk_colorspace_t*)Handle);
	}

  protected override void Dispose (bool disposing)	
  {
		return super.Dispose (disposing);
	}

	// properties

  bool GammaIsCloseToSrgb()
  {
    return SkiaApi.sk_colorspace_gamma_close_to_srgb (cast(sk_colorspace_t*)Handle);
  }
		

  bool GammaIsLinear()
  {
    return SkiaApi.sk_colorspace_gamma_is_linear (cast(sk_colorspace_t*)Handle);
  }
		

  bool IsSrgb()
  {
    return SkiaApi.sk_colorspace_is_srgb (cast(sk_colorspace_t*)Handle);
  }
	

  SKColorSpaceType Type()
  {
    return SKColorSpaceType.Rgb;
  } 

  SKNamedGamma NamedGamma()
  {
		SKColorSpaceTransferFn tf = GetNumericalTransferFunction ();

		if(tf == SKColorSpaceTransferFn.Empty) {
			return SKNamedGamma.NonStandard;
		} else if(tf == SKColorSpaceTransferFn.Linear) {
			return SKNamedGamma.Linear;
		} else if(tf == SKColorSpaceTransferFn.Srgb) {
			return SKNamedGamma.Srgb;
		} else if(tf == SKColorSpaceTransferFn.TwoDotTwo) {
			return SKNamedGamma.TwoDotTwoCurve;
		} else {
			return SKNamedGamma.NonStandard;
		}
		
	}

	bool IsNumericalTransferFunction()
  {
	  SKColorSpaceTransferFn fn;
    return GetNumericalTransferFunction (fn);

  }
		
	static bool Equal (SKColorSpace left, SKColorSpace right)
	{
		if (left is null)
			throw new ArgumentNullException (left.stringof);
		if (right is null)
			throw new ArgumentNullException (right.stringof);

		return SkiaApi.sk_colorspace_equals (cast(sk_colorspace_t*)left.Handle, cast(sk_colorspace_t*)right.Handle);
	}

	// CreateSrgb

	static SKColorSpace CreateSrgb () 
  {
    return srgb;
  } 

	// CreateSrgbLinear

	static SKColorSpace CreateSrgbLinear ()
  {
    return srgbLinear;
  } 

	// CreateIcc

	static SKColorSpace CreateIcc (void* input, long length)
  {
    return CreateIcc (SKColorSpaceIccProfile.Create (input, length));
  }
		

	static SKColorSpace CreateIcc (byte[] input, long length)
	{
		if (input is null)
			throw new ArgumentNullException (input.stringof);

		byte* i = input.ptr;
		return CreateIcc (SKColorSpaceIccProfile.Create (cast(void*)i, length));
	}

// 	static SKColorSpace CreateIcc (byte[] input)
//   {
//     return 	CreateIcc (input.AsSpan ());
//   }
	

	static SKColorSpace CreateIcc (byte[] input)
  {
    return CreateIcc (SKColorSpaceIccProfile.Create (input));
  }
		

	static SKColorSpace CreateIcc (SKData input)
  {
    return 	CreateIcc (SKColorSpaceIccProfile.Create (input));
  }
	

	static SKColorSpace CreateIcc (SKColorSpaceIccProfile profile)
	{
		if (profile is null)
			throw new ArgumentNullException (profile.stringof);

		return Referenced (GetObject (SkiaApi.sk_colorspace_new_icc (cast(sk_colorspace_icc_profile_t*)profile.Handle)), profile);
	}

	// CreateRgb

	static SKColorSpace CreateRgb (SKColorSpaceRenderTargetGamma gamma, SKMatrix44 toXyzD50, SKColorSpaceFlags flags)	
  {
		return CreateRgb (gamma, toXyzD50);
	}

	static SKColorSpace CreateRgb (SKColorSpaceRenderTargetGamma gamma, SKColorSpaceGamut gamut, SKColorSpaceFlags flags)	
  {
		return CreateRgb (gamma, gamut);
	}

	static SKColorSpace CreateRgb (SKColorSpaceTransferFn coeffs, SKMatrix44 toXyzD50, SKColorSpaceFlags flags)	
  {
		return CreateRgb (coeffs, toXyzD50);
	}

	static SKColorSpace CreateRgb (SKColorSpaceTransferFn coeffs, SKColorSpaceGamut gamut, SKColorSpaceFlags flags)	
  {
		return CreateRgb (coeffs, gamut);
	}

	static SKColorSpace CreateRgb (SKColorSpaceRenderTargetGamma gamma, SKMatrix44 toXyzD50)
	{
		if (toXyzD50 is null)
			throw new ArgumentNullException (toXyzD50.stringof);

		return CreateRgb (gamma.ToColorSpaceTransferFn (), toXyzD50.ToColorSpaceXyz ());
	}

	static SKColorSpace CreateRgb (SKColorSpaceRenderTargetGamma gamma, SKColorSpaceGamut gamut)
  {
    return CreateRgb (gamma.ToColorSpaceTransferFn (), gamut.ToColorSpaceXyz ());
  }
		

	static SKColorSpace CreateRgb (SKColorSpaceTransferFn coeffs, SKMatrix44 toXyzD50)
	{
		if (toXyzD50 is null)
			throw new ArgumentNullException (toXyzD50.stringof);

		return CreateRgb (coeffs, toXyzD50.ToColorSpaceXyz ());
	}

	static SKColorSpace CreateRgb (SKColorSpaceTransferFn coeffs, SKColorSpaceGamut gamut)
  {
    return CreateRgb (coeffs, gamut.ToColorSpaceXyz ());
  }
	

	static SKColorSpace CreateRgb (SKNamedGamma gamma, SKMatrix44 toXyzD50)
	{
		if (toXyzD50 is null)
			throw new ArgumentNullException (toXyzD50.stringof);

		return CreateRgb (gamma.ToColorSpaceTransferFn (), toXyzD50.ToColorSpaceXyz ());
	}

	static SKColorSpace CreateRgb (SKNamedGamma gamma, SKColorSpaceGamut gamut)
  {
    return CreateRgb (gamma.ToColorSpaceTransferFn (), gamut.ToColorSpaceXyz ());
  }
		

	// CreateRgb

	static SKColorSpace CreateRgb (SKColorSpaceTransferFn transferFn, SKColorSpaceXyz toXyzD50)
  {
    return GetObject (SkiaApi.sk_colorspace_new_rgb (&transferFn, &toXyzD50));
  }
		

	// GetNumericalTransferFunction

	SKColorSpaceTransferFn GetNumericalTransferFunction ()
  {
    SKColorSpaceTransferFn fn;
    return GetNumericalTransferFunction (fn) ? fn : SKColorSpaceTransferFn.Empty;
  }
		

	bool GetNumericalTransferFunction (ref SKColorSpaceTransferFn fn)
	{
		SKColorSpaceTransferFn* f = &fn;
		return SkiaApi.sk_colorspace_is_numerical_transfer_fn (cast(sk_colorspace_t*)Handle, f);
	}

	// ToProfile

	SKColorSpaceIccProfile ToProfile ()
	{
		auto profile = new SKColorSpaceIccProfile ();
		SkiaApi.sk_colorspace_to_profile (cast(sk_colorspace_t*)Handle, cast(sk_colorspace_icc_profile_t*)profile.Handle);
		return profile;
	}

	// ToColorSpaceXyz

	bool ToColorSpaceXyz (out SKColorSpaceXyz toXyzD50)
	{
		SKColorSpaceXyz* xyz = &toXyzD50;
		return SkiaApi.sk_colorspace_to_xyzd50 (cast(sk_colorspace_t*)Handle, xyz);
	}

	SKColorSpaceXyz ToColorSpaceXyz ()
  {
    SKColorSpaceXyz toXYZ;
    return ToColorSpaceXyz (toXYZ) ? toXYZ : SKColorSpaceXyz.Empty;
  }
		

	// To*Gamma

	SKColorSpace ToLinearGamma ()	
  {
		return GetObject (SkiaApi.sk_colorspace_make_linear_gamma (cast(sk_colorspace_t*)Handle));
	}

	SKColorSpace ToSrgbGamma ()	
  {
		return GetObject (SkiaApi.sk_colorspace_make_srgb_gamma (cast(sk_colorspace_t*)Handle));
	}

	// *XyzD50

	SKMatrix44 ToXyzD50 ()
  {
    return ToColorSpaceXyz ().ToMatrix44 ();
  }
		

	// bool ToXyzD50 (SKMatrix44 toXyzD50)
	// {
	// 	if (toXyzD50 is null)
	// 		throw new ArgumentNullException (toXyzD50.stringof);

	// 	if (ToColorSpaceXyz ( var xyz) && xyz.ToMatrix44 () is SKMatrix44 m) {
	// 		toXyzD50.SetColumnMajor (m.ToColumnMajor ());
	// 		return true;
	// 	}
	// 	return false;
	// }

	SKMatrix44 FromXyzD50 ()
  {
    return ToXyzD50 ().Invert ();
  }
		

	//

	static SKColorSpace GetObject (void* handle, bool owns = true, bool unrefExisting = true)
  {
    return 	GetOrAddObject!(SKColorSpace) (handle, owns, unrefExisting, (h, o){return new SKColorSpace (h, o);});
  }
	

	private static final class SKColorSpaceStatic : SKColorSpace
	{
		this (void* x)
		{
            super (x, true);
			IgnorePublicDispose = true;
		}
	}

}

