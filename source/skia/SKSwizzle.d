module skia.SKSwizzle;


import skia.Definitions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;
import skia.Exceptions;


class SKSwizzle {
	static void SwapRedBlue(void* pixels, int count) {
		return SwapRedBlue(pixels, pixels, count);
	}

	static void SwapRedBlue(void* dest, void* src, int count) {
		if (dest is null) {
			throw new ArgumentException(dest.stringof);
		}
		if (src is null) {
			throw new ArgumentException(src.stringof);
		}

		SkiaApi.sk_swizzle_swap_rb(cast(uint*) dest, cast(uint*) src, count);
	}

	static void SwapRedBlue(byte[] pixels) {
		SwapRedBlue(pixels, pixels, cast(int)pixels.length);
	}

	static void SwapRedBlue(const(byte)[] pixels, int count) {
		SwapRedBlue(pixels, pixels, count);
	}

	static void SwapRedBlue(const(byte)[] dest, const(byte)[] src, int count) {
		if (dest is null) {
			throw new ArgumentNullException(dest.stringof);
		}
		if (src is null) {
			throw new ArgumentNullException(src.stringof);
		}

		const(byte)* d = cast(const(byte)*)dest.ptr;
		const(byte)* s = cast(const(byte)*)src.ptr;
		SkiaApi.sk_swizzle_swap_rb(cast(uint*) d, cast(uint*) s, count);
	}
}
