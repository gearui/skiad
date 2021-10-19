module skia.SKPictureRecorder;

import skia.Definitions;
import skia.MathTypes;
import skia.SKObject;
import skia.SKCanvas;
import skia.SKPicture;
import skia.SKDrawable;
import skia.SkiaApi;
import skia.Exceptions;

class SKPictureRecorder : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this() {
		this(SkiaApi.sk_picture_recorder_new(), true);
		if (Handle is null) {
			throw new InvalidOperationException(
					"Unable to create a new SKPictureRecorder instance.");
		}
	}

	// 	protected override void Dispose (bool disposing)
	//   {
	//     return super.Dispose (disposing);
	//   }

	protected override void DisposeNative() {
		return SkiaApi.sk_picture_recorder_delete(cast(sk_picture_recorder_t*)Handle);
	}

	SKCanvas BeginRecording(SKRect cullRect) {
		return OwnedBy(SKCanvas.GetObject(SkiaApi.sk_picture_recorder_begin_recording(cast(sk_picture_recorder_t*)Handle,
				&cullRect), false), this);
	}

	SKPicture EndRecording() {
		return SKPicture.GetObject(SkiaApi.sk_picture_recorder_end_recording(cast(sk_picture_recorder_t*)Handle));
	}

	SKDrawable EndRecordingAsDrawable() {
		return SKDrawable.GetObject(SkiaApi.sk_picture_recorder_end_recording_as_drawable(cast(sk_picture_recorder_t*)Handle));
	}

	SKCanvas RecordingCanvas() {
		return OwnedBy(SKCanvas.GetObject(SkiaApi.sk_picture_get_recording_canvas(cast(sk_picture_recorder_t*)Handle),
				false), this);
	}

}
