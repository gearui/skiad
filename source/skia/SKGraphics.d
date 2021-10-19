module skia.SKGraphics;

import skia.SkiaApi;
import skia.Definitions;

struct SKGraphics {
	static void Init() {
		return SkiaApi.sk_graphics_init();
	}

	// purge

	static void PurgeFontCache() {
		return SkiaApi.sk_graphics_purge_font_cache();
	}

	static void PurgeResourceCache() {
		return SkiaApi.sk_graphics_purge_resource_cache();
	}

	static void PurgeAllCaches() {
		return SkiaApi.sk_graphics_purge_all_caches();
	}

	// font cache

	static long GetFontCacheUsed() {
		return cast(long) SkiaApi.sk_graphics_get_font_cache_used();
	}

	static long GetFontCacheLimit() {
		return cast(long) SkiaApi.sk_graphics_get_font_cache_limit();
	}

	static long SetFontCacheLimit(long bytes) {
		return cast(long) SkiaApi.sk_graphics_set_font_cache_limit(cast(void*) bytes);
	}

	static int GetFontCacheCountUsed() {
		return SkiaApi.sk_graphics_get_font_cache_count_used();
	}

	static int GetFontCacheCountLimit() {
		return SkiaApi.sk_graphics_get_font_cache_count_limit();
	}

	static int SetFontCacheCountLimit(int count) {
		return SkiaApi.sk_graphics_set_font_cache_count_limit(count);
	}

	static int GetFontCachePointSizeLimit() {
		return SkiaApi.sk_graphics_get_font_cache_point_size_limit();
	}

	static int SetFontCachePointSizeLimit(int count) {
		return SkiaApi.sk_graphics_set_font_cache_point_size_limit(count);
	}

	// resource cache

	static long GetResourceCacheTotalBytesUsed() {
		return cast(long) SkiaApi.sk_graphics_get_resource_cache_total_bytes_used();
	}

	static long GetResourceCacheTotalByteLimit() {
		return cast(long) SkiaApi.sk_graphics_get_resource_cache_total_byte_limit();
	}

	static long SetResourceCacheTotalByteLimit(long bytes) {
		return cast(long) SkiaApi.sk_graphics_set_resource_cache_total_byte_limit(
				cast(void*) bytes);
	}

	static long GetResourceCacheSingleAllocationByteLimit() {
		return cast(long) SkiaApi.sk_graphics_get_resource_cache_single_allocation_byte_limit();
	}

	static long SetResourceCacheSingleAllocationByteLimit(long bytes) {
		return cast(long) SkiaApi.sk_graphics_set_resource_cache_single_allocation_byte_limit(
				cast(void*) bytes);
	}

	// dump

	// static void DumpMemoryStatistics (SKTraceMemoryDump dump)
	// {
	//   return SkiaApi.sk_graphics_dump_memory_statistics (dump.Handle ? dump.Handle : throw new ArgumentNullException (dump.stringof));
	// }

}
