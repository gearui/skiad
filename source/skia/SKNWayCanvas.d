module skia.SKNWayCanvas;

import skia.Definitions;
import skia.Exceptions;
import skia.SKCanvas;
import skia.SKNoDrawCanvas;
import skia.SkiaApi;

class SKNWayCanvas : SKNoDrawCanvas {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this(int width, int height) {
		this(null, true);
		Handle = SkiaApi.sk_nway_canvas_new(width, height);
	}

	void AddCanvas(SKCanvas canvas) {
		if (canvas is null)
			throw new ArgumentNullException(canvas.stringof);

		SkiaApi.sk_nway_canvas_add_canvas(cast(sk_nway_canvas_t*)Handle, cast(sk_canvas_t*)canvas.Handle);
	}

	void RemoveCanvas(SKCanvas canvas) {
		if (canvas is null)
			throw new ArgumentNullException(canvas.stringof);

		SkiaApi.sk_nway_canvas_remove_canvas(cast(sk_nway_canvas_t*)Handle, cast(sk_canvas_t*)canvas.Handle);
	}

	void RemoveAll() {
		SkiaApi.sk_nway_canvas_remove_all(cast(sk_nway_canvas_t*)Handle);
	}
}
