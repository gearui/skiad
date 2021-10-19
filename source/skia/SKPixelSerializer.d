module skia.SKPixelSerializer;

import skia.SKObject;
import skia.SkiaApi;
import skia.SKData;
import skia.SKPixmap;
import skia.Definitions;
import skia.Exceptions;


class SKPixelSerializer : SKObject, ISKSkipObjectRegistration
{
	protected this ()
	{
    	super (null, false);
	}

	bool UseEncodedData (void* data, ulong length)
	{
		// if (!PlatformConfiguration.Is64Bit && length > uint.max)
		// 	throw new ArgumentOutOfRangeException (length.stringof, "The length exceeds the size of pointers.");

		return OnUseEncodedData (data, cast(void*)length);
	}

	SKData Encode (SKPixmap pixmap)
	{
		if (pixmap is null)
			throw new ArgumentNullException (pixmap.stringof);

		return OnEncode (pixmap);
	}

	protected abstract bool OnUseEncodedData (void* data, void* length);

	protected abstract SKData OnEncode (SKPixmap pixmap);

	// static SKPixelSerializer Create (Func<SKPixmap, SKData> onEncode)
	// {
	// 	return new SKSimplePixelSerializer (null, onEncode);
	// }

	// static SKPixelSerializer Create (Func<void*, void*, bool> onUseEncodedData, Func<SKPixmap, SKData> onEncode)
	// {
	// 	return new SKSimplePixelSerializer (onUseEncodedData, onEncode);
	// }
}

class SKSimplePixelSerializer : SKPixelSerializer
{
	// private const Func<void*, void*, bool> onUseEncodedData;
	// private const Func<SKPixmap, SKData> onEncode;

	// this (Func<void*, void*, bool> onUseEncodedData, Func<SKPixmap, SKData> onEncode)
	// {
	// 	this.onUseEncodedData = onUseEncodedData;
	// 	this.onEncode = onEncode;
	// }

	// protected override SKData OnEncode (SKPixmap pixmap)
	// {
	// 	return onEncode.Invoke (pixmap) ? onEncode.Invoke (pixmap) : null;
	// }

	// protected override bool OnUseEncodedData (void* data, void* length)
	// {
	// 	return onUseEncodedData.Invoke (data, length) ? onUseEncodedData.Invoke (data, length) : false;
	// }
}

class SKManagedPixelSerializer : SKPixelSerializer
{
	this ()
	{
	}
}
