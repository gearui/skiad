module skia.SK3dView;

import skia.SKMatrix;
import skia.SKCanvas;
import skia.SKData;
import skia.Definitions;
import skia.SKObject;
import skia.SkiaApi;
import skia.Exceptions;

class SK3dView : SKObject, ISKSkipObjectRegistration
{
	this (void* x, bool owns)
	{
    super (x, owns);
	}

	this ()
	{
    this (SkiaApi.sk_3dview_new (), true);
		if (Handle is null) {
			throw new InvalidOperationException ("Unable to create a new SK3dView instance.");
		}
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);
  }
	

	protected override void DisposeNative ()
  {
    return 	SkiaApi.sk_3dview_destroy (cast(sk_3dview_t*)Handle);
  }
	

	// Matrix

	SKMatrix Matrix() 
  {
			auto matrix = SKMatrix.Identity;
			GetMatrix ( matrix);
			return matrix;
	}

	void GetMatrix (ref SKMatrix matrix)
	{
		SKMatrix* m = &matrix;
		SkiaApi.sk_3dview_get_matrix (cast(sk_3dview_t*)Handle, m);
	}

	// Save

	void Save ()
  {
    return SkiaApi.sk_3dview_save (cast(sk_3dview_t*)Handle);
  }
		

	// Restore

	void Restore ()
  {
    return SkiaApi.sk_3dview_restore (cast(sk_3dview_t*)Handle);
  }
		

	// Translate

	void Translate (float x, float y, float z)
  {
    return SkiaApi.sk_3dview_translate (cast(sk_3dview_t*)Handle, x, y, z);
  }
		

	void TranslateX (float x)
  {
    return 	Translate (x, 0, 0);
  }
	

	void TranslateY (float y)
  {
    return 	Translate (0, y, 0);
  }
	

	void TranslateZ (float z)
  {
    return Translate (0, 0, z);
  }
		

	// Rotate*Degrees

	void RotateXDegrees (float degrees)
  {
    return SkiaApi.sk_3dview_rotate_x_degrees (cast(sk_3dview_t*)Handle, degrees);
  }
		

	void RotateYDegrees (float degrees)
  {
    return 	SkiaApi.sk_3dview_rotate_y_degrees (cast(sk_3dview_t*)Handle, degrees);
  }
	

	void RotateZDegrees (float degrees) 
  {
    return 	SkiaApi.sk_3dview_rotate_z_degrees (cast(sk_3dview_t*)Handle, degrees);
  }
	

	// Rotate*Radians

	void RotateXRadians (float radians)
  {
     	SkiaApi.sk_3dview_rotate_x_radians (cast(sk_3dview_t*)Handle, radians);
  }
	

	void RotateYRadians (float radians)
  {
     SkiaApi.sk_3dview_rotate_y_radians (cast(sk_3dview_t*)Handle, radians);
  }
		

	void RotateZRadians (float radians)
  {
     SkiaApi.sk_3dview_rotate_z_radians (cast(sk_3dview_t*)Handle, radians);
  }
		

	// DotWithNormal

	float DotWithNormal (float dx, float dy, float dz)
  {
    return SkiaApi.sk_3dview_dot_with_normal (cast(sk_3dview_t*)Handle, dx, dy, dz);
  }
		

	// Apply

	void ApplyToCanvas (SKCanvas canvas)
	{
		if (canvas is null)
			throw new ArgumentNullException (canvas.stringof);

		SkiaApi.sk_3dview_apply_to_canvas (cast(sk_3dview_t*)Handle, cast(sk_canvas_t*)canvas.Handle);
	}
}
