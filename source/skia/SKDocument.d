module skia.SKDocument;

import skia.Definitions;
import skia.SKObject;
import skia.SkiaApi;
import skia.SKStream;
import skia.SKCanvas;
import skia.MathTypes;
import skia.Exceptions;
import skia.Definitions;
import skia.SKString;

import std.datetime;
import std.typecons;

class SKDocument : SKObject, ISKSkipObjectRegistration {
	enum float DefaultRasterDpi = 72.0f;

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	void Abort() {
		SkiaApi.sk_document_abort(cast(sk_document_t*)Handle);
	}

	SKCanvas BeginPage(float width, float height) {
		return OwnedBy(SKCanvas.GetObject(SkiaApi.sk_document_begin_page(cast(sk_document_t*)Handle,
				width, height, null), false), this);
	}

	SKCanvas BeginPage(float width, float height, SKRect content) {
		return OwnedBy(SKCanvas.GetObject(SkiaApi.sk_document_begin_page(cast(sk_document_t*)Handle,
				width, height, &content), false), this);
	}

	void EndPage() {
		return SkiaApi.sk_document_end_page(cast(sk_document_t*)Handle);
	}

	void Close() {
		return SkiaApi.sk_document_close(cast(sk_document_t*)Handle);
	}

	// CreateXps

	static SKDocument CreateXps(string path) {
		return CreateXps(path, DefaultRasterDpi);
	}

	// static SKDocument CreateXps(Stream stream) {
	// 	return CreateXps(stream, DefaultRasterDpi);
	// }

	static SKDocument CreateXps(SKWStream stream) {
		return CreateXps(stream, DefaultRasterDpi);
	}

	static SKDocument CreateXps(string path, float dpi) {
		if (path is null) {
			throw new ArgumentNullException(path.stringof);
		}

		auto stream = SKFileWStream.OpenStream(path);
		return Owned(CreateXps(stream, dpi), stream);
	}

	// static SKDocument CreateXps(Stream stream, float dpi) {
	// 	if (&stream is null) {
	// 		throw new ArgumentNullException(stream.stringof);
	// 	}

	// 	auto managed = new SKManagedWStream(stream);
	// 	return Owned(CreateXps(managed, dpi), managed);
	// }

	static SKDocument CreateXps(SKWStream stream, float dpi) {
		if (stream is null) {
			throw new ArgumentNullException(stream.stringof);
		}

		return Referenced(GetObject(SkiaApi.sk_document_create_xps_from_stream(cast(sk_wstream_t*)stream.Handle,
				dpi)), stream);
	}

	// CreatePdf

	static SKDocument CreatePdf(SKWStream stream, SKDocumentPdfMetadata metadata, float dpi) {
		metadata.RasterDpi = dpi;
		return CreatePdf(stream, metadata);
	}

	static SKDocument CreatePdf(string path) {
		if (path is null) {
			throw new ArgumentNullException(path.stringof);
		}

		auto stream = SKFileWStream.OpenStream(path);
		return Owned(CreatePdf(stream), stream);
	}

	// static SKDocument CreatePdf(Stream stream) {
	// 	if (stream is null) {
	// 		throw new ArgumentNullException(stream.stringof);
	// 	}

	// 	auto managed = new SKManagedWStream(stream);
	// 	return Owned(CreatePdf(managed), managed);
	// }

	static SKDocument CreatePdf(SKWStream stream) {
		if (stream is null) {
			throw new ArgumentNullException(stream.stringof);
		}

		return Referenced(GetObject(SkiaApi.sk_document_create_pdf_from_stream(cast(sk_wstream_t*)stream.Handle)),
				stream);
	}

	static SKDocument CreatePdf(string path, float dpi) {
		return CreatePdf(path, SKDocumentPdfMetadata(dpi));
	}

	// static SKDocument CreatePdf(Stream stream, float dpi) {
	// 	return CreatePdf(stream, new SKDocumentPdfMetadata(dpi));
	// }

	static SKDocument CreatePdf(SKWStream stream, float dpi) {
		return CreatePdf(stream, SKDocumentPdfMetadata(dpi));
	}

	static SKDocument CreatePdf(string path, SKDocumentPdfMetadata metadata) {
		if (path is null) {
			throw new ArgumentNullException(path.stringof);
		}

		auto stream = SKFileWStream.OpenStream(path);
		return Owned(CreatePdf(stream, metadata), stream);
	}

	// static SKDocument CreatePdf(Stream stream, SKDocumentPdfMetadata metadata) {
	// 	if (&stream is null) {
	// 		throw new ArgumentNullException(stream.stringof);
	// 	}

	// 	auto managed = new SKManagedWStream(stream);
	// 	return Owned(CreatePdf(managed, metadata), managed);
	// }

	static SKDocument CreatePdf(SKWStream stream, SKDocumentPdfMetadata metadata) {
		if (&stream is null) {
			throw new ArgumentNullException(stream.stringof);
		}

		auto title = SKString.Create(metadata.Title);
		auto author = SKString.Create(metadata.Author);
		auto subject = SKString.Create(metadata.Subject);
		auto keywords = SKString.Create(metadata.Keywords);
		auto creator = SKString.Create(metadata.Creator);
		auto producer = SKString.Create(metadata.Producer);

		SKDocumentPdfMetadataInternal cmetadata =  SKDocumentPdfMetadataInternal();
		cmetadata.fTitle = cast(sk_string_t*)(title.Handle ? title.Handle : null);
		cmetadata.fAuthor = cast(sk_string_t*)(author.Handle ? author.Handle : null);
		cmetadata.fSubject = cast(sk_string_t*)(subject.Handle ? subject.Handle : null);
		cmetadata.fKeywords = cast(sk_string_t*)(keywords.Handle ? keywords.Handle : null);
		cmetadata.fCreator = cast(sk_string_t*)(creator.Handle ? creator.Handle : null);
		cmetadata.fProducer = cast(sk_string_t*)(producer.Handle ? producer.Handle : null);
		cmetadata.fRasterDPI = metadata.RasterDpi;
		cmetadata.fPDFA = metadata.PdfA ? cast(byte) 1 : cast(byte) 0;
		cmetadata.fEncodingQuality = metadata.EncodingQuality;


		Nullable!SysTime nullableCreation = metadata.Creation;

		SKTimeDateTimeInternal creation;
		if (!nullableCreation.isNull) {
			creation = SKTimeDateTimeInternal.Create(nullableCreation.get());
			cmetadata.fCreation = &creation;
		}

		Nullable!SysTime nullableModified = metadata.Modified;

		SKTimeDateTimeInternal modified;
		if (!nullableModified.isNull) {
			modified = SKTimeDateTimeInternal.Create(nullableModified.get());
			cmetadata.fModified = &modified;
		}

		return Referenced(GetObject(SkiaApi.sk_document_create_pdf_from_stream_with_metadata(cast(sk_wstream_t*)stream.Handle,
				&cmetadata)), stream);

	}

	static SKDocument GetObject(void* handle) {
		return handle is null ? null : new SKDocument(handle, true);
	}

}
