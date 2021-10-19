module skia.SKXml;

import skia.Definitions;
import skia.MathTypes;
import skia.SKObject;
import skia.SKStream;
import skia.SkiaApi;
import skia.Exceptions;


class SKXmlWriter : SKObject {
	this(void* h, bool owns) {
		super(h, owns);
	}
}

class SKXmlStreamWriter : SKXmlWriter {
	this(void* h, bool owns) {
		super(h, owns);
	}

	this(SKWStream stream) {
		this(null, true);
		if (stream is null) {
			throw new ArgumentNullException(stream.stringof);
		}

		Handle = SkiaApi.sk_xmlstreamwriter_new(cast(sk_wstream_t*)stream.Handle);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	protected override void DisposeNative() {
		return SkiaApi.sk_xmlstreamwriter_delete(cast(sk_xmlstreamwriter_t*)Handle);
	}

}
