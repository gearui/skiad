module skia.SKPath;

import skia.Definitions;
import skia.Exceptions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKRoundRect;
import skia.SKMatrix;
import skia.SKString;

import std.experimental.logger;

class SKPath : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_path_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKPath instance.");
		}
	}

	this(SKPath path) {
		this(SkiaApi.sk_path_clone(cast(sk_path_t*) path.Handle), true);
		if (Handle is null) {
			throw new InvalidOperationException("Unable to copy the SKPath instance.");
		}
	}

	// 	protected override void Dispose (bool disposing)
	//   {
	//     return super.Dispose (disposing);
	//   }

	//   override void Dispose()
	//   {
	//     return super.Dispose();
	//   }

	protected override void DisposeNative() {
		return SkiaApi.sk_path_delete(cast(sk_path_t*) Handle);
	}

	SKPathFillType FillType() {
		return SkiaApi.sk_path_get_filltype(cast(sk_path_t*) Handle);
	}

	void FillType(SKPathFillType value) {
		SkiaApi.sk_path_set_filltype(cast(sk_path_t*) Handle, value);
	}

	SKPathConvexity Convexity() {
		return SkiaApi.sk_path_get_convexity(cast(sk_path_t*) Handle);
	}

	void Convexity(SKPathConvexity value) {
		SkiaApi.sk_path_set_convexity(cast(sk_path_t*) Handle, value);
	}

	bool IsConcave() {
		return Convexity == SKPathConvexity.Concave;
	}

	bool IsEmpty() {
		return VerbCount == 0;
	}

	bool IsOval() {
		return SkiaApi.sk_path_is_oval(cast(sk_path_t*) Handle, null);
	}

	bool IsRoundRect() {
		return SkiaApi.sk_path_is_rrect(cast(sk_path_t*) Handle, null);
	}

	bool IsLine() {
		return SkiaApi.sk_path_is_line(cast(sk_path_t*) Handle, null);
	}

	bool IsRect() {
		return SkiaApi.sk_path_is_rect(cast(sk_path_t*) Handle, null, null, null);
	}

	SKPathSegmentMask SegmentMasks() {
		return cast(SKPathSegmentMask) SkiaApi.sk_path_get_segment_masks(cast(sk_path_t*) Handle);
	}

	int VerbCount() {
		return SkiaApi.sk_path_count_verbs(cast(sk_path_t*) Handle);
	}

	int PointCount() {
		return SkiaApi.sk_path_count_points(cast(sk_path_t*) Handle);
	}

	// SKPoint this[int index]()
	// {
	//   return  GetPoint (index);
	// }

	SKPoint[] Points() {
		return GetPoints(PointCount);
	}

	SKPoint LastPoint() {
		SKPoint point;
		SkiaApi.sk_path_get_last_point(cast(sk_path_t*) Handle, &point);
		return point;
	}

	SKRect Bounds() {
		SKRect rect;
		SkiaApi.sk_path_get_bounds(cast(sk_path_t*) Handle, &rect);
		return rect;
	}

	SKRect TightBounds() {
		SKRect rect;
		if (GetTightBounds(rect)) {
			return rect;
		} else {
			return SKRect.Empty;
		}

	}

	SKRect GetOvalBounds() {
		SKRect bounds;
		if (SkiaApi.sk_path_is_oval(cast(sk_path_t*) Handle, &bounds)) {
			return bounds;
		} else {
			return SKRect.Empty;
		}
	}

	SKRoundRect GetRoundRect() {
		auto rrect = new SKRoundRect();
		auto result = SkiaApi.sk_path_is_rrect(cast(sk_path_t*) Handle,
				cast(sk_rrect_t*) rrect.Handle);
		if (result) {
			return rrect;
		} else {
			rrect.Dispose();
			return null;
		}
	}

	SKPoint[] GetLine() {
		auto temp = new SKPoint[2];
		SKPoint* t = temp.ptr;
		{
			auto result = SkiaApi.sk_path_is_line(cast(sk_path_t*) Handle, t);
			if (result) {
				return temp;
			} else {
				return null;
			}
		}
	}

	SKRect GetRect() {
		bool isClosed;
		SKPathDirection direction;
		return GetRect(isClosed, direction);
	}

	SKRect GetRect(out bool isClosed, out SKPathDirection direction) {
		byte c;
		SKPathDirection* d = &direction;
		{
			SKRect rect;
			auto result = SkiaApi.sk_path_is_rect(cast(sk_path_t*) Handle,
					&rect, cast(bool*)&c, d);
			isClosed = c > 0;
			if (result) {
				return rect;
			} else {
				return SKRect.Empty;
			}
		}
	}

	SKPoint GetPoint(int index) {
		if (index < 0 || index >= PointCount)
			throw new ArgumentOutOfRangeException(index.stringof);

		SKPoint point;
		SkiaApi.sk_path_get_point(cast(sk_path_t*) Handle, index, &point);
		return point;
	}

	SKPoint[] GetPoints(int max) {
		auto points = new SKPoint[max];
		GetPoints(points, max);
		return points;
	}

	int GetPoints(SKPoint[] points, int max) {
		SKPoint* p = points.ptr;
		return SkiaApi.sk_path_get_points(cast(sk_path_t*) Handle, p, max);
	}

	bool Contains(float x, float y) {
		return SkiaApi.sk_path_contains(cast(sk_path_t*) Handle, x, y);
	}

	void Offset(SKPoint offset) {
		return Offset(offset.X, offset.Y);
	}

	void Offset(float dx, float dy) {
		return Transform(SKMatrix.CreateTranslation(dx, dy));
	}

	void MoveTo(SKPoint point) {
		return SkiaApi.sk_path_move_to(cast(sk_path_t*) Handle, point.X, point.Y);
	}

	void MoveTo(float x, float y) {
		return SkiaApi.sk_path_move_to(cast(sk_path_t*) Handle, x, y);
	}

	void RMoveTo(SKPoint point) {
		return SkiaApi.sk_path_rmove_to(cast(sk_path_t*) Handle, point.X, point.Y);
	}

	void RMoveTo(float dx, float dy) {
		return SkiaApi.sk_path_rmove_to(cast(sk_path_t*) Handle, dx, dy);
	}

	void LineTo(SKPoint point) {
		return SkiaApi.sk_path_line_to(cast(sk_path_t*) Handle, point.X, point.Y);
	}

	void LineTo(float x, float y) {
		return SkiaApi.sk_path_line_to(cast(sk_path_t*) Handle, x, y);
	}

	void RLineTo(SKPoint point) {
		return SkiaApi.sk_path_rline_to(cast(sk_path_t*) Handle, point.X, point.Y);
	}

	void RLineTo(float dx, float dy) {
		return SkiaApi.sk_path_rline_to(cast(sk_path_t*) Handle, dx, dy);
	}

	void QuadTo(SKPoint point0, SKPoint point1) {
		return SkiaApi.sk_path_quad_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y);
	}

	void QuadTo(float x0, float y0, float x1, float y1) {
		return SkiaApi.sk_path_quad_to(cast(sk_path_t*) Handle, x0, y0, x1, y1);
	}

	void RQuadTo(SKPoint point0, SKPoint point1) {
		return SkiaApi.sk_path_rquad_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y);
	}

	void RQuadTo(float dx0, float dy0, float dx1, float dy1) {
		return SkiaApi.sk_path_rquad_to(cast(sk_path_t*) Handle, dx0, dy0, dx1, dy1);
	}

	void ConicTo(SKPoint point0, SKPoint point1, float w) {
		return SkiaApi.sk_path_conic_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y, w);
	}

	void ConicTo(float x0, float y0, float x1, float y1, float w) {
		return SkiaApi.sk_path_conic_to(cast(sk_path_t*) Handle, x0, y0, x1, y1, w);
	}

	void RConicTo(SKPoint point0, SKPoint point1, float w) {
		return SkiaApi.sk_path_rconic_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y, w);
	}

	void RConicTo(float dx0, float dy0, float dx1, float dy1, float w) {
		return SkiaApi.sk_path_rconic_to(cast(sk_path_t*) Handle, dx0, dy0, dx1, dy1, w);
	}

	void CubicTo(SKPoint point0, SKPoint point1, SKPoint point2) {
		return SkiaApi.sk_path_cubic_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y, point2.X, point2.Y);
	}

	void CubicTo(float x0, float y0, float x1, float y1, float x2, float y2) {
		return SkiaApi.sk_path_cubic_to(cast(sk_path_t*) Handle, x0, y0, x1, y1, x2, y2);
	}

	void RCubicTo(SKPoint point0, SKPoint point1, SKPoint point2) {
		return SkiaApi.sk_path_rcubic_to(cast(sk_path_t*) Handle, point0.X,
				point0.Y, point1.X, point1.Y, point2.X, point2.Y);
	}

	void RCubicTo(float dx0, float dy0, float dx1, float dy1, float dx2, float dy2) {
		return SkiaApi.sk_path_rcubic_to(cast(sk_path_t*) Handle, dx0, dy0, dx1, dy1, dx2, dy2);
	}

	void ArcTo(SKPoint r, float xAxisRotate, SKPathArcSize largeArc,
			SKPathDirection sweep, SKPoint xy) {
		return SkiaApi.sk_path_arc_to(cast(sk_path_t*) Handle, r.X, r.Y,
				xAxisRotate, largeArc, sweep, xy.X, xy.Y);
	}

	void ArcTo(float rx, float ry, float xAxisRotate, SKPathArcSize largeArc,
			SKPathDirection sweep, float x, float y) {
		return SkiaApi.sk_path_arc_to(cast(sk_path_t*) Handle, rx, ry,
				xAxisRotate, largeArc, sweep, x, y);
	}

	void ArcTo(SKRect oval, float startAngle, float sweepAngle, bool forceMoveTo) {
		return SkiaApi.sk_path_arc_to_with_oval(cast(sk_path_t*) Handle,
				&oval, startAngle, sweepAngle, forceMoveTo);
	}

	void ArcTo(SKPoint point1, SKPoint point2, float radius) {
		return SkiaApi.sk_path_arc_to_with_points(cast(sk_path_t*) Handle,
				point1.X, point1.Y, point2.X, point2.Y, radius);
	}

	void ArcTo(float x1, float y1, float x2, float y2, float radius) {
		return SkiaApi.sk_path_arc_to_with_points(cast(sk_path_t*) Handle, x1, y1, x2, y2, radius);
	}

	void RArcTo(SKPoint r, float xAxisRotate, SKPathArcSize largeArc,
			SKPathDirection sweep, SKPoint xy) {
		return SkiaApi.sk_path_rarc_to(cast(sk_path_t*) Handle, r.X, r.Y,
				xAxisRotate, largeArc, sweep, xy.X, xy.Y);
	}

	void RArcTo(float rx, float ry, float xAxisRotate, SKPathArcSize largeArc,
			SKPathDirection sweep, float x, float y) {
		return SkiaApi.sk_path_rarc_to(cast(sk_path_t*) Handle, rx, ry,
				xAxisRotate, largeArc, sweep, x, y);
	}

	void Close() {
		return SkiaApi.sk_path_close(cast(sk_path_t*) Handle);
	}

	void Rewind() {
		return SkiaApi.sk_path_rewind(cast(sk_path_t*) Handle);
	}

	void Reset() {
		return SkiaApi.sk_path_reset(cast(sk_path_t*) Handle);
	}

	void AddRect(SKRect rect, SKPathDirection direction = SKPathDirection.Clockwise) {
		return SkiaApi.sk_path_add_rect(cast(sk_path_t*) Handle, &rect, direction);
	}

	void AddRect(SKRect rect, SKPathDirection direction, uint startIndex) {
		if (startIndex > 3)
			throw new ArgumentOutOfRangeException(startIndex.stringof,
					"Starting index must be in the range of 0..3 (inclusive).");

		SkiaApi.sk_path_add_rect_start(cast(sk_path_t*) Handle, &rect, direction, startIndex);
	}

	void AddRoundRect(SKRoundRect rect, SKPathDirection direction = SKPathDirection.Clockwise) {
		if (rect is null)
			throw new ArgumentNullException(rect.stringof);
		SkiaApi.sk_path_add_rrect(cast(sk_path_t*) Handle,
				cast(sk_rrect_t*) rect.Handle, direction);
	}

	void AddRoundRect(SKRoundRect rect, SKPathDirection direction, uint startIndex) {
		if (rect is null)
			throw new ArgumentNullException(rect.stringof);
		SkiaApi.sk_path_add_rrect_start(cast(sk_path_t*) Handle,
				cast(sk_rrect_t*) rect.Handle, direction, startIndex);
	}

	void AddOval(SKRect rect, SKPathDirection direction = SKPathDirection.Clockwise) {
		return SkiaApi.sk_path_add_oval(cast(sk_path_t*) Handle, &rect, direction);
	}

	void AddArc(SKRect oval, float startAngle, float sweepAngle) {
		return SkiaApi.sk_path_add_arc(cast(sk_path_t*) Handle, &oval, startAngle, sweepAngle);
	}

	bool GetBounds(out SKRect rect) {
		auto isEmpty = IsEmpty;
		if (isEmpty) {
			rect = SKRect.Empty;
		} else {
			SKRect* r = &rect;
			SkiaApi.sk_path_get_bounds(cast(sk_path_t*) Handle, r);
		}
		return !isEmpty;
	}

	SKRect ComputeTightBounds() {
		SKRect rect;
		SkiaApi.sk_path_compute_tight_bounds(cast(sk_path_t*) Handle, &rect);
		return rect;
	}

	void Transform(SKMatrix matrix) {
		return SkiaApi.sk_path_transform(cast(sk_path_t*) Handle, &matrix);
	}

	void Transform(SKMatrix matrix, SKPath destination) {
		if (destination is null)
			throw new ArgumentNullException(destination.stringof);

		SkiaApi.sk_path_transform_to_dest(cast(sk_path_t*) Handle, &matrix,
				cast(sk_path_t*) destination.Handle);
	}

	void AddPath(SKPath other, float dx, float dy, SKPathAddMode mode = SKPathAddMode.Append) {
		if (other is null)
			throw new ArgumentNullException(other.stringof);

		SkiaApi.sk_path_add_path_offset(cast(sk_path_t*) Handle,
				cast(sk_path_t*) other.Handle, dx, dy, mode);
	}

	void AddPath(SKPath other, ref SKMatrix matrix, SKPathAddMode mode = SKPathAddMode.Append) {
		if (other is null)
			throw new ArgumentNullException(other.stringof);

		SKMatrix* m = &matrix;
		SkiaApi.sk_path_add_path_matrix(cast(sk_path_t*) Handle,
				cast(sk_path_t*) other.Handle, m, mode);
	}

	void AddPath(SKPath other, SKPathAddMode mode = SKPathAddMode.Append) {
		if (other is null)
			throw new ArgumentNullException(other.stringof);

		SkiaApi.sk_path_add_path(cast(sk_path_t*) Handle, cast(sk_path_t*) other.Handle, mode);
	}

	void AddPathReverse(SKPath other) {
		if (other is null)
			throw new ArgumentNullException(other.stringof);

		SkiaApi.sk_path_add_path_reverse(cast(sk_path_t*) Handle, cast(sk_path_t*) other.Handle);
	}

	void AddRoundRect(SKRect rect, float rx, float ry,
			SKPathDirection dir = SKPathDirection.Clockwise) {
		return SkiaApi.sk_path_add_rounded_rect(cast(sk_path_t*) Handle, &rect, rx, ry, dir);
	}

	void AddRoundedRect(SKRect rect, float rx, float ry,
			SKPathDirection dir = SKPathDirection.Clockwise) {
		return AddRoundRect(rect, rx, ry, dir);
	}

	void AddCircle(float x, float y, float radius, SKPathDirection dir = SKPathDirection.Clockwise) {
		return SkiaApi.sk_path_add_circle(cast(sk_path_t*) Handle, x, y, radius, dir);
	}

	void AddPoly(SKPoint[] points, bool close = true) {
		if (points is null)
			throw new ArgumentNullException(points.stringof);
		SKPoint* p = points.ptr;
		SkiaApi.sk_path_add_poly(cast(sk_path_t*) Handle, p, cast(int) points.length, close);
	}

	Iterator CreateIterator(bool forceClose) {
		return new Iterator(this, forceClose);
	}

	RawIterator CreateRawIterator() {
		return new RawIterator(this);
	}

	bool Op(SKPath other, SKPathOp op, SKPath result) {
		if (other is null)
			throw new ArgumentNullException(other.stringof);
		if (result is null)
			throw new ArgumentNullException(result.stringof);

		return SkiaApi.sk_pathop_op(cast(sk_path_t*) Handle,
				cast(sk_path_t*) other.Handle, op, cast(sk_path_t*) result.Handle);
	}

	SKPath Op(SKPath other, SKPathOp op) {
		auto result = new SKPath();
		if (Op(other, op, result)) {
			return result;
		} else {
			result.Dispose();
			return null;
		}
	}

	bool Simplify(SKPath result) {
		if (result is null)
			throw new ArgumentNullException(result.stringof);

		return SkiaApi.sk_pathop_simplify(cast(sk_path_t*) Handle, cast(sk_path_t*) result.Handle);
	}

	SKPath Simplify() {
		auto result = new SKPath();
		if (Simplify(result)) {
			return result;
		} else {
			result.Dispose();
			return null;
		}
	}

	bool GetTightBounds(out SKRect result) {
		SKRect* r = &result;
		return SkiaApi.sk_pathop_tight_bounds(cast(sk_path_t*) Handle, r);
	}

	bool ToWinding(SKPath result) {
		if (result is null)
			throw new ArgumentNullException(result.stringof);

		return SkiaApi.sk_pathop_as_winding(cast(sk_path_t*) Handle,
				cast(sk_path_t*) result.Handle);
	}

	SKPath ToWinding() {
		SKPath result = new SKPath();
		if (ToWinding(result)) {
			return result;
		} else {
			result.Dispose();
			return null;
		}
	}

	string ToSvgPathData() {
		SKString str = new SKString();
		SkiaApi.sk_path_to_svg_string(cast(sk_path_t*) Handle, cast(sk_string_t*) str.Handle);
		return cast(string) str;
	}

	static SKPath ParseSvgPathData(string svgPath) {
		auto path = new SKPath();
		auto success = SkiaApi.sk_path_parse_svg_string(cast(sk_path_t*) path.Handle, svgPath);
		if (!success) {
			path.Dispose();
			path = null;
		}
		return path;
	}

	static SKPoint[] ConvertConicToQuads(SKPoint p0, SKPoint p1, SKPoint p2, float w, int pow2) {
		SKPoint[] pts;
		ConvertConicToQuads(p0, p1, p2, w, pts, pow2);
		return pts;
	}

	static int ConvertConicToQuads(SKPoint p0, SKPoint p1, SKPoint p2, float w,
			out SKPoint[] pts, int pow2) {
		auto quadCount = 1 << pow2;
		auto ptCount = 2 * quadCount + 1;
		pts = new SKPoint[ptCount];
		return ConvertConicToQuads(p0, p1, p2, w, pts, pow2);
	}

	static int ConvertConicToQuads(SKPoint p0, SKPoint p1, SKPoint p2, float w,
			SKPoint[] pts, int pow2) {
		if (pts is null)
			throw new ArgumentNullException(pts.stringof);
		SKPoint* ptsptr = pts.ptr;
		return SkiaApi.sk_path_convert_conic_to_quads(&p0, &p1, &p2, w, ptsptr, pow2);
	}

	//

	static SKPath GetObject(void* handle, bool owns = true) {
		return handle is null ? null : new SKPath(handle, owns);
	}

	//

	class Iterator : SKObject, ISKSkipObjectRegistration {
		private const SKPath path;

		this(SKPath path, bool forceClose) {
			super(SkiaApi.sk_path_create_iter(cast(sk_path_t*) path.Handle, forceClose ? 1 : 0),
					true);
			this.path = path;
		}

		protected override void Dispose(bool disposing) {
			return super.Dispose(disposing);
		}

		override void Dispose() {
			return super.Dispose();
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_path_iter_destroy(cast(sk_path_iterator_t*) Handle);
		}

		// [Obsolete ("Use Next(SKPoint[]) instead.")]
		SKPathVerb Next(SKPoint[] points, bool doConsumeDegenerates, bool exact) {
			return Next(points);
		}

		SKPathVerb Next(SKPoint[] points) {
			if (points is null)
				throw new ArgumentNullException(points.stringof);
			if (points.length != 4)
				throw new ArgumentException("Must be an array of four elements.", points.stringof);

			SKPoint* p = points.ptr;
			return SkiaApi.sk_path_iter_next(cast(sk_path_iterator_t*) Handle, p);
		}

		float ConicWeight() {
			return SkiaApi.sk_path_iter_conic_weight(cast(sk_path_iterator_t*) Handle);
		}

		bool IsCloseLine() {
			return SkiaApi.sk_path_iter_is_close_line(cast(sk_path_iterator_t*) Handle) != 0;
		}

		bool IsCloseContour() {
			return SkiaApi.sk_path_iter_is_closed_contour(cast(sk_path_iterator_t*) Handle) != 0;
		}

	}

	class RawIterator : SKObject, ISKSkipObjectRegistration {
		private const SKPath path;

		this(SKPath path) {
			super(SkiaApi.sk_path_create_rawiter(cast(sk_path_t*) path.Handle), true);
			this.path = path;
		}

		protected override void Dispose(bool disposing) {
			return super.Dispose(disposing);
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_path_rawiter_destroy(cast(sk_path_rawiterator_t*) Handle);
		}

		SKPathVerb Next(SKPoint[] points) {
			if (points is null)
				throw new ArgumentNullException(points.stringof);
			if (points.length != 4)
				throw new ArgumentException("Must be an array of four elements.", points.stringof);
			SKPoint* p = points.ptr;
			return SkiaApi.sk_path_rawiter_next(cast(sk_path_rawiterator_t*) Handle, p);
		}

		float ConicWeight() {
			return SkiaApi.sk_path_rawiter_conic_weight(cast(sk_path_rawiterator_t*) Handle);
		}

		SKPathVerb Peek() {
			return SkiaApi.sk_path_rawiter_peek(cast(sk_path_rawiterator_t*) Handle);
		}

	}

	class OpBuilder : SKObject, ISKSkipObjectRegistration {
		this() {
			super(SkiaApi.sk_opbuilder_new(), true);
		}

		void Add(SKPath path, SKPathOp op) {
			return SkiaApi.sk_opbuilder_add(cast(sk_opbuilder_t*) Handle,
					cast(sk_path_t*) path.Handle, op);
		}

		bool Resolve(SKPath result) {
			if (result is null)
				throw new ArgumentNullException(result.stringof);

			return SkiaApi.sk_opbuilder_resolve(cast(sk_opbuilder_t*) Handle,
					cast(sk_path_t*) result.Handle);
		}

		protected override void Dispose(bool disposing) {
			return super.Dispose(disposing);
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_opbuilder_destroy(cast(sk_opbuilder_t*) Handle);
		}

	}
}
