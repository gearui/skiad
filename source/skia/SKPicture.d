module skia.SKPicture;

import skia.SKObject;
import skia.SkiaApi;
import skia.Definitions;
import skia.SKData;
import skia.SKShader;
import skia.SKStream;
import skia.MathTypes;
import skia.MathTypes;
import skia.SKMatrix;
import skia.Exceptions;

class SKPicture : SKObject {
	this(void* h, bool owns) {
		super(h, owns);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	uint UniqueId() {
		return SkiaApi.sk_picture_get_unique_id(cast(sk_picture_t*) Handle);
	}

	SKRect CullRect() {
		SKRect rect;
		SkiaApi.sk_picture_get_cull_rect(cast(sk_picture_t*) Handle, &rect);
		return rect;
	}

	// Serialize

	// SKData Serialize() {
	// 	return SKData.GetObject(SkiaApi.sk_picture_serialize_to_data(cast(sk_picture_t*) Handle));
	// }

	// void Serialize (Stream stream)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	auto managed =  new SKManagedWStream (stream);
	// 	scope(exit) {
	// 	    managed.Dispose();
	// 	}

	// 	Serialize (managed);
	// }

	// void Serialize(SKWStream stream) {
	// 	if (stream is null)
	// 		throw new ArgumentNullException(stream.stringof);

	// 	SkiaApi.sk_picture_serialize_to_stream(cast(sk_picture_t*) Handle,
	// 			cast(sk_wstream_t*) stream.Handle);
	// }

	// ToShader

	SKShader ToShader() {
		return ToShader(SKShaderTileMode.Clamp, SKShaderTileMode.Clamp);
	}

	SKShader ToShader(SKShaderTileMode tmx, SKShaderTileMode tmy) {
		return SKShader.GetObject(SkiaApi.sk_picture_make_shader(cast(sk_picture_t*) Handle,
				tmx, tmy, null, null));
	}

	SKShader ToShader(SKShaderTileMode tmx, SKShaderTileMode tmy, SKRect tile) {
		return SKShader.GetObject(SkiaApi.sk_picture_make_shader(cast(sk_picture_t*) Handle,
				tmx, tmy, null, &tile));
	}

	SKShader ToShader(SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix localMatrix, SKRect tile) {
		return SKShader.GetObject(SkiaApi.sk_picture_make_shader(cast(sk_picture_t*) Handle,
				tmx, tmy, &localMatrix, &tile));
	}

	// Deserialize

	// static SKPicture Deserialize(void* data, int length) {
	// 	if (data is null)
	// 		throw new ArgumentNullException(data.stringof);

	// 	if (length == 0)
	// 		return null;

	// 	return GetObject(SkiaApi.sk_picture_deserialize_from_memory(cast(void*) data,
	// 			cast(void*) length));
	// }

	// static SKPicture Deserialize(const(byte)[] data) {
	// 	if (data.length == 0)
	// 		return null;

	// 	void* ptr = cast(void*) data;
	// 	return GetObject(SkiaApi.sk_picture_deserialize_from_memory(ptr, cast(int) data.length));
	// }

	// static SKPicture Deserialize(SKData data) {
	// 	if (data is null)
	// 		throw new ArgumentNullException(data.stringof);

	// 	return GetObject(SkiaApi.sk_picture_deserialize_from_data(cast(sk_data_t*) data.Handle));
	// }

	// static SKPicture Deserialize (Stream stream)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	auto managed =  new SKManagedStream (stream);
	// 	scope(exit) {
	// 	    managed.Dispose();
	// 	}

	// 	return Deserialize (managed);
	// }

	// static SKPicture Deserialize(SKStream stream) {
	// 	if (stream is null)
	// 		throw new ArgumentNullException(stream.stringof);

	// 	return GetObject(SkiaApi.sk_picture_deserialize_from_stream(
	// 			cast(sk_stream_t*) stream.Handle));
	// }

	//

	static SKPicture GetObject(void* handle, bool owns = true, bool unrefExisting = true) {
		return GetOrAddObject!(SKPicture)(handle, delegate SKPicture(h, o) {
			return new SKPicture(h, o);
		});
	}

}
