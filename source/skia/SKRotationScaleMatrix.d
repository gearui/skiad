module skia.SKRotationScaleMatrix;

import skia.SKMatrix;
import std.math;

struct SKRotationScaleMatrix
{
	// static readonly SKRotationScaleMatrix Empty;

	// static readonly SKRotationScaleMatrix Identity = new SKRotationScaleMatrix (1, 0, 0, 0);

 float fSCos;
 float fSSin;
 float fTX;
 float fTY;
	this (float scos, float ssin, float tx, float ty)
	{
		fSCos = scos;
		fSSin = ssin;
		fTX = tx;
		fTY = ty;
	}

	const SKMatrix ToMatrix ()
  {
    return SKMatrix (fSCos, -fSSin, fTX, fSSin, fSCos, fTY, 0, 0, 1);
  }
		

	static SKRotationScaleMatrix CreateDegrees (float scale, float degrees, float tx, float ty, float anchorX, float anchorY)
  {
    return Create (scale, degrees * SKMatrix.DegreesToRadians, tx, ty, anchorX, anchorY);
  }
		

	static SKRotationScaleMatrix Create (float scale, float radians, float tx, float ty, float anchorX, float anchorY)
	{
		auto s = cast(float)sin (radians) * scale;
		auto c = cast(float)cos (radians) * scale;
		auto x = tx + -c * anchorX + s * anchorY;
		auto y = ty + -s * anchorX - c * anchorY;

		return SKRotationScaleMatrix (c, s, x, y);
	}

	static SKRotationScaleMatrix CreateIdentity ()
  {
    return SKRotationScaleMatrix (1, 0, 0, 0);
  }
		

	static SKRotationScaleMatrix CreateTranslation (float x, float y)	
  {
		return SKRotationScaleMatrix (1, 0, x, y);
	}

	static SKRotationScaleMatrix CreateScale (float s)	
  {
		return SKRotationScaleMatrix (s, 0, 0, 0);
	}

	static SKRotationScaleMatrix CreateRotation (float radians, float anchorX, float anchorY)	
  {
		return Create (1, radians, 0, 0, anchorX, anchorY);
	}

	static SKRotationScaleMatrix CreateRotationDegrees (float degrees, float anchorX, float anchorY)	
  {
		return CreateDegrees (1, degrees, 0, 0, anchorX, anchorY);
	}
}
