module skia.SKDrawable;

import skia.Definitions;
import skia.Exceptions;
import skia.GRDefinitions;
import skia.MathTypes;
import skia.SKCanvas;
import skia.SKPictureRecorder;
import skia.SKObject;
import skia.SKMatrix;
import skia.SKPicture;
import skia.SkiaApi;

import core.atomic;

class SKDrawable : SKObject {
	private __gshared SKManagedDrawableDelegates delegates;

	private shared int fromNative;

	shared static this ()
	{
		delegates.fDraw = &DrawInternal;
		delegates.fGetBounds = &GetBoundsInternal;
		delegates.fNewPictureSnapshot = &NewPictureSnapshotInternal;
		delegates.fDestroy = &DestroyInternal;

		SkiaApi.sk_manageddrawable_set_procs (delegates);
	}

	this() {
		this(true);
	}

	protected this(bool owns) {
		super(null, owns);
		// auto ctx = DelegateProxies.CreateUserData(this, true);
		void* ctx = cast(void*) this;
		Handle = SkiaApi.sk_manageddrawable_new(ctx);

		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new SKDrawable instance.");
		}
	}

	this(void* x, bool owns) {
		super(x, owns);
	}

	// protected override void Dispose(bool disposing) {
	// 	return super.Dispose(disposing);
	// }

	protected override void DisposeNative() {
		// if (Interlocked.CompareExchange(fromNative, 0, 0) == 0)
		int v = cas(&fromNative, 0, 0);
		if (v == 0)
			SkiaApi.sk_drawable_unref(cast(sk_drawable_t*) Handle);
	}

	uint GenerationId() {
		return SkiaApi.sk_drawable_get_generation_id(cast(sk_drawable_t*) Handle);
	}

	SKRect Bounds() {
		SKRect bounds;
		SkiaApi.sk_drawable_get_bounds(cast(sk_drawable_t*) Handle, &bounds);
		return bounds;
	}

	void Draw(SKCanvas canvas, ref SKMatrix matrix) {
		SKMatrix* m = &matrix;
		SkiaApi.sk_drawable_draw(cast(sk_drawable_t*) Handle, cast(sk_canvas_t*) canvas.Handle, m);
	}

	void Draw(SKCanvas canvas, float x, float y) {
		auto matrix = SKMatrix.CreateTranslation(x, y);
		Draw(canvas, matrix);
	}

	// do not unref as this is a plain pointer return, not a reference counted pointer
	SKPicture Snapshot ()
	{
	  return 	SKPicture.GetObject (SkiaApi.sk_drawable_new_picture_snapshot (cast(sk_drawable_t*)Handle), true, false);
	}

	void NotifyDrawingChanged() {
		return SkiaApi.sk_drawable_notify_drawing_changed(cast(sk_drawable_t*) Handle);
	}

	protected void OnDraw(SKCanvas canvas) {
	}

	protected SKRect OnGetBounds() {
		return SKRect.Empty;
	}

	protected SKPicture OnSnapshot() {
		SKPictureRecorder recorder = new SKPictureRecorder();
		scope (exit) {
			recorder.Dispose();
		}

		auto canvas = recorder.BeginRecording(Bounds);
		Draw(canvas, 0, 0);
		return recorder.EndRecording();
	}

extern (C) {
	private static void DrawInternal(void* d, void* context, void* canvas) {
		// auto drawable = DelegateProxies.GetUserData!(SKDrawable)(cast(void*) context, _);
		SKDrawable drawable = cast(SKDrawable) context;
		drawable.OnDraw(SKCanvas.GetObject(canvas, false));
	}

	private static void GetBoundsInternal(void* d, void* context, SKRect* rect) {
		// auto drawable = DelegateProxies.GetUserData!(SKDrawable)(cast(void*) context, _);
		SKDrawable drawable = cast(SKDrawable) context;
		auto bounds = drawable.OnGetBounds();
		*rect = bounds;
	}

	private static void* NewPictureSnapshotInternal(void* d, void* context) {
		// auto drawable = DelegateProxies.GetUserData!(SKDrawable)(cast(void*) context, _);
		SKDrawable drawable = cast(SKDrawable) context;
		return drawable.OnSnapshot().Handle ? drawable.OnSnapshot().Handle : null;
	}

	private static void DestroyInternal (void* d, void* context)
	{
		// auto drawable = DelegateProxies.GetUserData<SKDrawable> (cast(void*)context,  var gch);
		SKDrawable drawable = cast(SKDrawable) context;
		if (drawable !is null) {
			// Interlocked.Exchange ( drawable.fromNative, 1);
			atomicStore(drawable.fromNative, 1);
			drawable.Dispose ();
		}
	}
}

	static SKDrawable GetObject(void* handle) {
		return GetOrAddObject!(SKDrawable)(handle, delegate SKDrawable(h, o) {
			return new SKDrawable(h, o);
		});
		// return GetOrAddObject!(SKDrawable) (handle, (h, o){return new SKDrawable (h, o);});
	}

}
