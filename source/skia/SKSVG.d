module skia.SKSVG;

import skia.SKCanvas;
import skia.MathTypes;
import skia.SKStream;
import skia.SKXml;
import skia.Definitions;
import skia.Exceptions;
import skia.SKObject;
import skia.SkiaApi;

class SKSvgCanvas
{
	private this ()
	{
	}

	// Create

	// static SKCanvas Create (SKRect bounds, Stream stream)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	auto managed = new SKManagedWStream (stream);
	// 	return SKObject.Owned (Create (bounds, managed), managed);
	// }

	// static SKCanvas Create (SKRect bounds, SKWStream stream)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	return SKObject.Referenced (SKCanvas.GetObject (SkiaApi.sk_svgcanvas_create_with_stream (&bounds, cast(sk_wstream_t*)stream.Handle)), stream);
	// }

	// static SKCanvas Create (SKRect bounds, SKXmlWriter writer)
	// {
	// 	if (writer is null)
	// 		throw new ArgumentNullException (writer.stringof);

	// 	auto canvas = SKCanvas.GetObject (SkiaApi.sk_svgcanvas_create_with_writer (&bounds, cast(sk_xmlwriter_t*)writer.Handle));
	// 	writer.RevokeOwnership (canvas);
	// 	return SKObject.Referenced (canvas, writer);
	// }
}
