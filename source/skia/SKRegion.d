module skia.SKRegion;

import skia.Definitions;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKPath;
import skia.MathTypes;
import skia.Exceptions;

class SKRegion : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_region_new(), true);
	}

	this(SKRegion region) {
		this();
		SetRegion(region);
	}

	this(SKRectI rect) {
		this();
		SetRect(rect);
	}

	this(SKPath path) {
		this();
		SetPath(path);
	}

	// 	protected override void Dispose (bool disposing)	
	//   {
	// 		return super.Dispose (disposing);
	// 	}

	protected override void DisposeNative() {
		return SkiaApi.sk_region_delete(cast(sk_region_t*) Handle);
	}

	// properties

	bool IsEmpty() {
		return SkiaApi.sk_region_is_empty(cast(sk_region_t*) Handle);
	}

	bool IsRect() {
		return SkiaApi.sk_region_is_rect(cast(sk_region_t*) Handle);
	}

	bool IsComplex() {
		return SkiaApi.sk_region_is_complex(cast(sk_region_t*) Handle);
	}

	SKRectI Bounds() {

		SKRectI rect;
		SkiaApi.sk_region_get_bounds(cast(sk_region_t*) Handle, &rect);
		return rect;

	}

	// GetBoundaryPath

	SKPath GetBoundaryPath() {
		auto path = new SKPath();
		if (!SkiaApi.sk_region_get_boundary_path(cast(sk_region_t*) Handle,
				cast(sk_path_t*) path.Handle)) {
			path.Dispose();
			path = null;
		}
		return path;
	}

	// Contains

	bool Contains(SKPath path) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		auto pathRegion = new SKRegion(path);
		scope (exit) {
			pathRegion.Dispose();
		}

		return Contains(pathRegion);
	}

	bool Contains(SKRegion src) {
		if (src is null)
			throw new ArgumentNullException(src.stringof);

		return SkiaApi.sk_region_contains(cast(sk_region_t*) Handle, cast(sk_region_t*) src.Handle);
	}

	bool Contains(SKPointI xy) {
		return SkiaApi.sk_region_contains_point(cast(sk_region_t*) Handle, xy.X, xy.Y);
	}

	bool Contains(int x, int y) {
		return SkiaApi.sk_region_contains_point(cast(sk_region_t*) Handle, x, y);
	}

	bool Contains(SKRectI rect) {
		return SkiaApi.sk_region_contains_rect(cast(sk_region_t*) Handle, &rect);
	}

	// QuickContains

	bool QuickContains(SKRectI rect) {
		return SkiaApi.sk_region_quick_contains(cast(sk_region_t*) Handle, &rect);
	}

	// QuickReject

	bool QuickReject(SKRectI rect) {
		return SkiaApi.sk_region_quick_reject_rect(cast(sk_region_t*) Handle, &rect);
	}

	bool QuickReject(SKRegion region) {
		if (region is null)
			throw new ArgumentNullException(region.stringof);

		return SkiaApi.sk_region_quick_reject(cast(sk_region_t*) Handle,
				cast(sk_region_t*) region.Handle);
	}

	bool QuickReject(SKPath path) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		auto pathRegion = new SKRegion(path);
		scope (exit) {
			pathRegion.Dispose();
		}

		return QuickReject(pathRegion);
	}

	// Intersects

	bool Intersects(SKPath path) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		auto pathRegion = new SKRegion(path);
		scope (exit) {
			pathRegion.Dispose();
		}

		return Intersects(pathRegion);
	}

	bool Intersects(SKRegion region) {
		if (region is null)
			throw new ArgumentNullException(region.stringof);

		return SkiaApi.sk_region_intersects(cast(sk_region_t*) Handle,
				cast(sk_region_t*) region.Handle);
	}

	bool Intersects(SKRectI rect) {
		return SkiaApi.sk_region_intersects_rect(cast(sk_region_t*) Handle, &rect);
	}

	// Set*

	void SetEmpty() {
		SkiaApi.sk_region_set_empty(cast(sk_region_t*) Handle);
	}

	bool SetRegion(SKRegion region) {
		if (region is null)
			throw new ArgumentNullException(region.stringof);

		return SkiaApi.sk_region_set_region(cast(sk_region_t*) Handle,
				cast(sk_region_t*) region.Handle);
	}

	bool SetRect(SKRectI rect) {
		return SkiaApi.sk_region_set_rect(cast(sk_region_t*) Handle, &rect);
	}

	bool SetRects(SKRectI[] rects) {
		if (rects is null)
			throw new ArgumentNullException(rects.stringof);

		SKRectI* r = rects.ptr;
		return SkiaApi.sk_region_set_rects(cast(sk_region_t*) Handle, r, cast(int) rects.length);
	}

	bool SetPath(SKPath path, SKRegion clip) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);
		if (clip is null)
			throw new ArgumentNullException(clip.stringof);

		return SkiaApi.sk_region_set_path(cast(sk_region_t*) Handle,
				cast(sk_path_t*) path.Handle, cast(sk_region_t*) clip.Handle);
	}

	bool SetPath(SKPath path) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		auto clip = new SKRegion();
		scope (exit) {
			clip.Dispose();
		}

		auto rect = SKRectI.Ceiling(path.Bounds);
		if (!rect.IsEmpty)
			clip.SetRect(rect);

		return SkiaApi.sk_region_set_path(cast(sk_region_t*) Handle,
				cast(sk_path_t*) path.Handle, cast(sk_region_t*) clip.Handle);
	}

	// Translate

	void Translate(int x, int y) {
		return SkiaApi.sk_region_translate(cast(sk_region_t*) Handle, x, y);
	}

	// Op

	bool Op(SKRectI rect, SKRegionOperation op) {
		return SkiaApi.sk_region_op_rect(cast(sk_region_t*) Handle, &rect, op);
	}

	bool Op(int left, int top, int right, int bottom, SKRegionOperation op) {
		return Op(SKRectI(left, top, right, bottom), op);
	}

	bool Op(SKRegion region, SKRegionOperation op) {
		return SkiaApi.sk_region_op(cast(sk_region_t*) Handle,
				cast(sk_region_t*) region.Handle, op);
	}

	bool Op(SKPath path, SKRegionOperation op) {
		auto pathRegion = new SKRegion(path);
		scope (exit) {
			pathRegion.Dispose();
		}

		return Op(pathRegion, op);
	}

	// Iterators

	RectIterator CreateRectIterator() {
		return new RectIterator(this);
	}

	ClipIterator CreateClipIterator(SKRectI clip) {
		return new ClipIterator(this, clip);
	}

	SpanIterator CreateSpanIterator(int y, int left, int right) {
		return new SpanIterator(this, y, left, right);
	}

	// classes

	class RectIterator : SKObject, ISKSkipObjectRegistration {
		private const SKRegion region;

		this(SKRegion region) {
			super(SkiaApi.sk_region_iterator_new(cast(sk_region_t*) region.Handle), true);
			this.region = region;
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_region_iterator_delete(cast(sk_region_iterator_t*) Handle);
		}

		bool Next(out SKRectI rect) {
			if (SkiaApi.sk_region_iterator_done(cast(sk_region_iterator_t*) Handle)) {
				rect = SKRectI.Empty;
				return false;
			}

			SKRectI* r = &rect;
			SkiaApi.sk_region_iterator_rect(cast(sk_region_iterator_t*) Handle, r);

			SkiaApi.sk_region_iterator_next(cast(sk_region_iterator_t*) Handle);

			return true;
		}
	}

	class ClipIterator : SKObject, ISKSkipObjectRegistration {
		private const SKRegion region;
		private const SKRectI clip;

		this(SKRegion region, SKRectI clip) {
			super(SkiaApi.sk_region_cliperator_new(cast(sk_region_t*) region.Handle, &clip), true);
			this.region = region;
			this.clip = clip;
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_region_cliperator_delete(cast(sk_region_cliperator_t*) Handle);
		}

		bool Next(out SKRectI rect) {
			if (SkiaApi.sk_region_cliperator_done(cast(sk_region_cliperator_t*) Handle)) {
				rect = SKRectI.Empty;
				return false;
			}

			SKRectI* r = &rect;
			SkiaApi.sk_region_iterator_rect(cast(sk_region_iterator_t*) Handle, r);

			SkiaApi.sk_region_cliperator_next(cast(sk_region_cliperator_t*) Handle);

			return true;
		}
	}

	class SpanIterator : SKObject, ISKSkipObjectRegistration {
		this(SKRegion region, int y, int left, int right) {
			super(SkiaApi.sk_region_spanerator_new(cast(sk_region_t*) region.Handle,
					y, left, right), true);
		}

		protected override void DisposeNative() {
			return SkiaApi.sk_region_spanerator_delete(cast(sk_region_spanerator_t*) Handle);
		}

		bool Next(out int left, out int right) {
			int l;
			int r;
			if (SkiaApi.sk_region_spanerator_next(cast(sk_region_spanerator_t*) Handle, &l, &r)) {
				left = l;
				right = r;
				return true;
			}

			left = 0;
			right = 0;
			return false;
		}
	}
}
