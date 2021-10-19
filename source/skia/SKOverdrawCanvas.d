module skia.SKOverdrawCanvas;

import skia.Definitions;
import skia.SKCanvas;
import skia.SKNoDrawCanvas;
import skia.SKNWayCanvas;
import skia.Exceptions;
import skia.SkiaApi;

class SKOverdrawCanvas : SKNWayCanvas
{
	this (void* handle, bool owns)
	{
    	super (handle, owns);
	}

	this (SKCanvas canvas)
	{
    	this (null, true);
		if (canvas is null)
			throw new ArgumentNullException (canvas.stringof);

		Handle = SkiaApi.sk_overdraw_canvas_new (cast(sk_canvas_t*)canvas.Handle);
	}
}
