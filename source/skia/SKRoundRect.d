module skia.SKRoundRect;

import skia.Definitions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKMatrix;
import skia.Exceptions;
import skia.Util;

class SKRoundRect : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_rrect_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKRoundRect instance.");
		}
		SetEmpty();
	}

	this(SKRect rect) {
		this(SkiaApi.sk_rrect_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKRoundRect instance.");
		}
		SetRect(rect);
	}

	this(SKRect rect, float radius) {
		this(rect, radius, radius);
	}

	this(SKRect rect, float xRadius, float yRadius) {
		this(SkiaApi.sk_rrect_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKRoundRect instance.");
		}
		SetRect(rect, xRadius, yRadius);
	}

	this(SKRoundRect rrect) {
		this(SkiaApi.sk_rrect_new_copy(cast(sk_rrect_t*) rrect.Handle), true);
	}

	// 	protected override void Dispose (bool disposing)
	//   {
	//     return super.Dispose (disposing);
	//   }

	protected override void DisposeNative() {
		return SkiaApi.sk_rrect_delete(cast(sk_rrect_t*) Handle);
	}

	SKRect Rect() {

		SKRect rect;
		SkiaApi.sk_rrect_get_rect(cast(sk_rrect_t*) Handle, &rect);
		return rect;
	}

	// SKPoint[] Radii()
	// {
	//   return new[] {
	// 	GetRadii(SKRoundRectCorner.UpperLeft),
	// 	GetRadii(SKRoundRectCorner.UpperRight),
	// 	GetRadii(SKRoundRectCorner.LowerRight),
	// 	GetRadii(SKRoundRectCorner.LowerLeft),
	// };
	// } 

	SKRoundRectType Type() {
		return SkiaApi.sk_rrect_get_type(cast(sk_rrect_t*) Handle);
	}

	float Width() {
		return SkiaApi.sk_rrect_get_width(cast(sk_rrect_t*) Handle);
	}

	float Height() {
		return SkiaApi.sk_rrect_get_height(cast(sk_rrect_t*) Handle);
	}

	bool IsValid() {
		return SkiaApi.sk_rrect_is_valid(cast(sk_rrect_t*) Handle);
	}

	bool AllCornersCircular() {
		return CheckAllCornersCircular(Utils.NearlyZero);
	}

	bool CheckAllCornersCircular(float tolerance) {
		auto ul = GetRadii(SKRoundRectCorner.UpperLeft);
		auto ur = GetRadii(SKRoundRectCorner.UpperRight);
		auto lr = GetRadii(SKRoundRectCorner.LowerRight);
		auto ll = GetRadii(SKRoundRectCorner.LowerLeft);

		return Utils.NearlyEqual(ul.X, ul.Y, tolerance)
			&& Utils.NearlyEqual(ur.X, ur.Y, tolerance)
			&& Utils.NearlyEqual(lr.X, lr.Y, tolerance) && Utils.NearlyEqual(ll.X, ll.Y, tolerance);
	}

	void SetEmpty() {
		SkiaApi.sk_rrect_set_empty(cast(sk_rrect_t*) Handle);
	}

	void SetRect(SKRect rect) {
		SkiaApi.sk_rrect_set_rect(cast(sk_rrect_t*) Handle, &rect);
	}

	void SetRect(SKRect rect, float xRadius, float yRadius) {
		SkiaApi.sk_rrect_set_rect_xy(cast(sk_rrect_t*) Handle, &rect, xRadius, yRadius);
	}

	void SetOval(SKRect rect) {
		SkiaApi.sk_rrect_set_oval(cast(sk_rrect_t*) Handle, &rect);
	}

	void SetNinePatch(SKRect rect, float leftRadius, float topRadius,
			float rightRadius, float bottomRadius) {
		SkiaApi.sk_rrect_set_nine_patch(cast(sk_rrect_t*) Handle, &rect,
				leftRadius, topRadius, rightRadius, bottomRadius);
	}

	void SetRectRadii(SKRect rect, SKPoint[] radii) {
		if (radii is null)
			throw new ArgumentNullException(radii.stringof);
		if (radii.length != 4)
			throw new ArgumentException("Radii must have a length of 4.", radii.stringof);

		SKPoint* r = radii.ptr;
		SkiaApi.sk_rrect_set_rect_radii(cast(sk_rrect_t*) Handle, &rect, r);
	}

	bool Contains(SKRect rect) {
		return SkiaApi.sk_rrect_contains(cast(sk_rrect_t*) Handle, &rect);
	}

	SKPoint GetRadii(SKRoundRectCorner corner) {
		SKPoint radii;
		SkiaApi.sk_rrect_get_radii(cast(sk_rrect_t*) Handle, corner, &radii);
		return radii;
	}

	void Deflate(SKSize size) {
		Deflate(size.Width, size.Height);
	}

	void Deflate(float dx, float dy) {
		SkiaApi.sk_rrect_inset(cast(sk_rrect_t*) Handle, dx, dy);
	}

	void Inflate(SKSize size) {
		Inflate(size.Width, size.Height);
	}

	void Inflate(float dx, float dy) {
		SkiaApi.sk_rrect_outset(cast(sk_rrect_t*) Handle, dx, dy);
	}

	void Offset(SKPoint pos) {
		Offset(pos.X, pos.Y);
	}

	void Offset(float dx, float dy) {
		SkiaApi.sk_rrect_offset(cast(sk_rrect_t*) Handle, dx, dy);
	}

	bool TryTransform(SKMatrix matrix, out SKRoundRect transformed) {
		auto destHandle = SkiaApi.sk_rrect_new();
		if (SkiaApi.sk_rrect_transform(cast(sk_rrect_t*) Handle, &matrix, destHandle)) {
			transformed = new SKRoundRect(destHandle, true);
			return true;
		}
		SkiaApi.sk_rrect_delete(destHandle);
		transformed = null;
		return false;
	}

	SKRoundRect Transform(SKMatrix matrix) {
		SKRoundRect transformed;
		if (TryTransform(matrix, transformed)) {
			return transformed;
		}
		return null;
	}
}
