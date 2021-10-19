module skia.SKNoDrawCanvas;

import skia.Definitions;
import skia.SKCanvas;
import skia.SkiaApi;
import skia.Exceptions;

class SKNoDrawCanvas : SKCanvas
{
	this (void* handle, bool owns)
	{
    	super(handle, owns);
	}

	this (int width, int height)
	{
    	this (null, true);
		Handle = SkiaApi.sk_nodraw_canvas_new (width, height);
	}
}
