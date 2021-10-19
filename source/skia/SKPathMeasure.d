module skia.SKPathMeasure;

import skia.Definitions;
import skia.MathTypes;
import skia.SKMatrix;
import skia.SKObject;
import skia.SKPath;
import skia.SkiaApi;
import skia.Exceptions;

/**
 * 
 */
class SKPathMeasure : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_pathmeasure_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKPathMeasure instance.");
		}
	}

	this(SKPath path, bool forceClosed = false, float resScale = 1) {
		super(null, true);
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		Handle = SkiaApi.sk_pathmeasure_new_with_path(cast(sk_path_t*)path.Handle, forceClosed, resScale);

		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKPathMeasure instance.");
		}
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

  override void Dispose()
  {
    return super.Dispose();
  }

	protected override void DisposeNative() {
		return SkiaApi.sk_pathmeasure_destroy(cast(sk_pathmeasure_t*)Handle);
	}

	// properties

	float Length() {
		return SkiaApi.sk_pathmeasure_get_length(cast(sk_pathmeasure_t*)Handle);
	}

	bool IsClosed() {
		return SkiaApi.sk_pathmeasure_is_closed(cast(sk_pathmeasure_t*)Handle);
	}

	// SetPath

	void SetPath(SKPath path) {
		return SetPath(path, false);
	}

	void SetPath(SKPath path, bool forceClosed) {
		SkiaApi.sk_pathmeasure_set_path(cast(sk_pathmeasure_t*)Handle, 
			cast(sk_path_t*)(path is null ? null : path.Handle), forceClosed);
	}

	// GetPositionAndTangent

	bool GetPositionAndTangent(float distance, out SKPoint position, out SKPoint tangent) {
		SKPoint* p = &position;
		SKPoint* t = &tangent;
		return SkiaApi.sk_pathmeasure_get_pos_tan(cast(sk_pathmeasure_t*)Handle, distance, p, t);
	}

	// GetPosition

	SKPoint GetPosition(float distance) {
		SKPoint position;
		if (!GetPosition(distance, position))
			position = SKPoint.Empty;
		return position;
	}

	bool GetPosition(float distance, ref SKPoint position) {
		SKPoint* p = &position;
		return SkiaApi.sk_pathmeasure_get_pos_tan(cast(sk_pathmeasure_t*)Handle, distance, p, null);
	}

	// GetTangent

	SKPoint GetTangent(float distance) {
		SKPoint tangent;
		if (!GetTangent(distance, tangent))
			tangent = SKPoint.Empty;
		return tangent;
	}

	bool GetTangent(float distance, out SKPoint tangent) {
		SKPoint* t = &tangent;
		return SkiaApi.sk_pathmeasure_get_pos_tan(cast(sk_pathmeasure_t*)Handle, distance, null, t);
	}

	// GetMatrix

	SKMatrix GetMatrix(float distance, SKPathMeasureMatrixFlags flags) {
		SKMatrix matrix;
		if (!GetMatrix(distance, matrix, flags))
			matrix = SKMatrix.Empty;
		return matrix;
	}

	bool GetMatrix(float distance, out SKMatrix matrix, SKPathMeasureMatrixFlags flags) {
		SKMatrix* m = &matrix;
		return SkiaApi.sk_pathmeasure_get_matrix(cast(sk_pathmeasure_t*)Handle, distance, m, flags);
	}

	// GetSegment

	bool GetSegment(float start, float stop, SKPath dst, bool startWithMoveTo) {
		if (dst is null)
			throw new ArgumentNullException(dst.stringof);
		return SkiaApi.sk_pathmeasure_get_segment(cast(sk_pathmeasure_t*)Handle, start, stop,
				cast(sk_path_t*)dst.Handle, startWithMoveTo);
	}

	SKPath GetSegment(float start, float stop, bool startWithMoveTo) {
		auto dst = new SKPath();
		if (!GetSegment(start, stop, dst, startWithMoveTo)) {
			dst.Dispose();
			dst = null;
		}
		return dst;
	}

	// NextContour

	bool NextContour() {
		return SkiaApi.sk_pathmeasure_next_contour(cast(sk_pathmeasure_t*)Handle);
	}
}
