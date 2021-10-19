module skia.SKMask;

import skia.Definitions;
import skia.MathTypes;
import skia.SkiaApi;
import skia.IDisposable;
import skia.Exceptions;

import std.format;

struct SKMask {
	SKRectI fBounds;
	uint fRowBytes;
	SKMaskFormat fFormat;
	void* fImage;
	this(void* image, SKRectI bounds, uint rowBytes, SKMaskFormat format) {
		fBounds = bounds;
		fRowBytes = rowBytes;
		fFormat = format;
		fImage = cast(byte*) image;
	}

	this(SKRectI bounds, uint rowBytes, SKMaskFormat format) {
		fBounds = bounds;
		fRowBytes = rowBytes;
		fFormat = format;
		fImage = null;
	}

	// properties

	// readonly void* Image() 
	void* Image() {
		return cast(void*) fImage;
	}

	void Image(void* value) {
		fImage = cast(byte*) value;
	}

	// Span!(byte) GetImageSpan ()
	// {
	//   return new byte[] (cast(void*)Image, cast(int)ComputeTotalImageSize ());
	// }

	// readonly SKRectI Bounds() 
	SKRectI Bounds() {
		return fBounds;
	}

	void Bounds(SKRectI value) {
		fBounds = value;
	}

	uint RowBytes() {
		return fRowBytes;
	}

	// void uint RowBytes(uint value)
	// {
	//   fRowBytes = value;
	// }

	// readonly SKMaskFormat Format()
	// {
	// 	return fFormat;
	// }

	void Format(SKMaskFormat value) {
		fFormat = value;
	}

	const bool IsEmpty() {
		SKMask* t = cast(SKMask*)&this;
		return SkiaApi.sk_mask_is_empty(t);
	}

	// allocate / free

	long AllocateImage() {
		SKMask* t = &this;
		{
			auto size = SkiaApi.sk_mask_compute_total_image_size(t);
			fImage = SkiaApi.sk_mask_alloc_image(size);
			return cast(long) size;
		}
	}

	void FreeImage() {
		if (fImage !is null) {
			SKMask.FreeImage(cast(void*) fImage);
			fImage = null;
		}
	}

	// Compute*

	const long ComputeImageSize() {
		SKMask* t = cast(SKMask*)&this;
		return cast(long) SkiaApi.sk_mask_compute_image_size(t);
	}

	const long ComputeTotalImageSize() {
		SKMask* t = cast(SKMask*)&this;
		return cast(long) SkiaApi.sk_mask_compute_total_image_size(t);
	}

	// GetAddr*

	const byte GetAddr1(int x, int y) {
		SKMask* t = cast(SKMask*)&this;
		return *SkiaApi.sk_mask_get_addr_1(t, x, y);
	}

	const byte GetAddr8(int x, int y) {
		SKMask* t = cast(SKMask*)&this;
		return *SkiaApi.sk_mask_get_addr_8(t, x, y);
	}

	const ushort GetAddr16(int x, int y) {
		SKMask* t = cast(SKMask*)&this;
		return *SkiaApi.sk_mask_get_addr_lcd_16(t, x, y);
	}

	const uint GetAddr32(int x, int y) {
		SKMask* t = cast(SKMask*)&this;
		return *SkiaApi.sk_mask_get_addr_32(t, x, y);
	}

	const void* GetAddr(int x, int y) {
		SKMask* t = cast(SKMask*)&this;
		return cast(void*) SkiaApi.sk_mask_get_addr(t, x, y);
	}

	// statics

	static void* AllocateImage(long size) {
		return cast(void*) SkiaApi.sk_mask_alloc_image(cast(void*) size);
	}

	static void FreeImage(void* image) {
		return SkiaApi.sk_mask_free_image(cast(byte*) image);
	}

	static SKMask Create(byte[] image, SKRectI bounds, uint rowBytes, SKMaskFormat format) {
		return Create(cast(const(byte)[]) image, bounds, rowBytes, format);
	}

	static SKMask Create(const(byte)[] image, SKRectI bounds, uint rowBytes, SKMaskFormat format) {
		// create the mask
		auto mask = SKMask(bounds, rowBytes, format);

		// calculate the size
		auto imageSize = cast(int) mask.ComputeTotalImageSize();

		// is there the right amount of space in the mask
		if (image.length != imageSize) {
			// Note: buffer.Length must match bounds.Height * rowBytes
			auto expectedSize = bounds.Height * rowBytes;
			auto message = "Length of image ({image.Length}) does not match the computed size of the mask ({expectedSize}). Check the {bounds.stringof} and {rowBytes.stringof}.";
			throw new ArgumentException(message);
		}

		// allocate and copy the image data
		mask.AllocateImage();
		// image.CopyTo (new byte[] (cast(void*)mask.Image, imageSize));

		byte* buffer = cast(byte*)mask.Image;
		for(size_t i = 0; i<imageSize; i++) {
			buffer[i] = image[i];
		}

		// return the mask
		return mask;
	}
}

class SKAutoMaskFreeImage : IDisposable {
	private void* image;

	this(void* maskImage) {
		image = maskImage;
	}

	void Dispose() {
		if (image !is null) {
			SKMask.FreeImage(image);
			image = null;
		}
	}
}
