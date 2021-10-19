module skia.GRContext;

import skia.SKObject;
import skia.SkiaApi;
import skia.Definitions;
import skia.GRGlInterface;
import skia.GRVkBackendContext;
import skia.GRDefinitions;
import skia.EnumMappings;
import skia.Exceptions;

class GRContext : SKObject, ISKSkipObjectRegistration
{
	this (void* h, bool owns)
	{
    super(h,owns);
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);
  }
	

	// Create

	static GRContext Create (GRBackend backend)
  {
    switch (backend){
      case GRBackend.Metal:
        throw new NotSupportedException ();
      case 	GRBackend.OpenGL:
        return  CreateGl ();
      case GRBackend.Vulkan:
        throw new NotSupportedException ();
      case 	GRBackend.Dawn:
        throw new NotSupportedException ();
      default:
        throw new ArgumentOutOfRangeException (backend.stringof);
    }
  }
	

	static GRContext Create (GRBackend backend, GRGlInterface backendContext)
  {
    switch(backend){
      case GRBackend.Metal:
        throw new NotSupportedException ();
      case GRBackend.OpenGL:
        return  CreateGl (backendContext);
      case 	GRBackend.Vulkan:
        throw new NotSupportedException ();
      case GRBackend.Dawn:
        throw new NotSupportedException ();
      default:
        throw new ArgumentOutOfRangeException (backend.stringof);
    }
    
  }
	

	static GRContext Create (GRBackend backend, void* backendContext)
  {
    switch(backend){
      case GRBackend.Metal:
        throw new NotSupportedException ();
      case GRBackend.OpenGL:
        return GetObject (SkiaApi.gr_context_make_gl (cast(gr_glinterface_t*)backendContext));
      case GRBackend.Vulkan:
        throw new NotSupportedException ();
      case GRBackend.Dawn:
        throw new NotSupportedException ();
      default:
        throw new ArgumentOutOfRangeException (backend.stringof);
    }
  }
		

	// CreateGl

	static GRContext CreateGl ()
  {
    return 	CreateGl (null);
  }
	

	static GRContext CreateGl (GRGlInterface backendContext)
  {
    return GetObject (SkiaApi.gr_context_make_gl (backendContext is null ? null : cast(gr_glinterface_t*)backendContext.Handle));
  }
		
	// CreateVulkan

	static GRContext CreateVulkan (GRVkBackendContext backendContext)
	{
		if (backendContext is null)
			throw new ArgumentNullException (backendContext.stringof);

		return GetObject (SkiaApi.gr_context_make_vulkan (backendContext.ToNative ()));
	}

	//

	GRBackend Backend()
  {
    return SkiaApi.gr_context_get_backend (cast(gr_context_t*)Handle).FromNative ();
  } 

	void AbandonContext (bool releaseResources = false)
	{
		if (releaseResources)
			SkiaApi.gr_context_release_resources_and_abandon_context (cast(gr_context_t*)Handle);
		else
			SkiaApi.gr_context_abandon_context (cast(gr_context_t*)Handle);
	}

	void GetResourceCacheLimits (out int maxResources, out long maxResourceBytes)
	{
		maxResources = -1;
		maxResourceBytes = GetResourceCacheLimit ();
	}

	void SetResourceCacheLimits (int maxResources, long maxResourceBytes)	
  {
		return SetResourceCacheLimit (maxResourceBytes);
	}

	long GetResourceCacheLimit ()	
  {
		return cast(long)SkiaApi.gr_context_get_resource_cache_limit (cast(gr_context_t*)Handle);
	}

	void SetResourceCacheLimit (long maxResourceBytes)	
  {
		return SkiaApi.gr_context_set_resource_cache_limit (cast(gr_context_t*)Handle, cast(void*)maxResourceBytes);
	}

	// void GetResourceCacheUsage (out int maxResources, out long maxResourceBytes)
	// {
	// 	void* maxResBytes;
	// 	int* maxRes = &maxResources;
	// 	SkiaApi.gr_context_get_resource_cache_usage (cast(gr_context_t*)Handle, maxRes, &maxResBytes);
	// 	maxResourceBytes = cast(long)maxResBytes;
	// }

	void ResetContext (GRGlBackendState state)	
  {
		return ResetContext (cast(uint)state);
	}

	void ResetContext (GRBackendState state = GRBackendState.All)	
  {
		return ResetContext (cast(uint)state);
	}

	void ResetContext (uint state)	
  {
		return SkiaApi.gr_context_reset_context (cast(gr_context_t*)Handle, state);
	}

	void Flush ()	
  {
		return SkiaApi.gr_context_flush (cast(gr_context_t*)Handle);
	}

	int GetMaxSurfaceSampleCount (SKColorType colorType)	
  {
		return SkiaApi.gr_context_get_max_surface_sample_count_for_color_type (cast(gr_context_t*)Handle, colorType.ToNative ());
	}

	int GetRecommendedSampleCount (GRPixelConfig config, float dpi)
  {
    return 0;
  }

	// void DumpMemoryStatistics (SKTraceMemoryDump dump)	
  // {
	// 	// return SkiaApi.gr_context_dump_memory_statistics (Handle, dump?.Handle ?? throw new ArgumentNullException (dump.stringof));
  //   	return SkiaApi.gr_context_dump_memory_statistics (cast(gr_context_t*)Handle, dump.Handle);
	// }

	// void PurgeResources ()	
  // {
	// 	return SkiaApi.gr_context_free_gpu_resources (cast(gr_context_t*)Handle);
	// }

	// void PurgeUnusedResources (long milliseconds)	
  // {
	// 	return SkiaApi.gr_context_perform_deferred_cleanup (cast(gr_context_t*)Handle, milliseconds);
	// }

	// void PurgeUnlockedResources (bool scratchResourcesOnly)	
  // {
	// 	return SkiaApi.gr_context_purge_unlocked_resources (cast(gr_context_t*)Handle, scratchResourcesOnly);
	// }

	// void PurgeUnlockedResources (long bytesToPurge, bool preferScratchResources)	
  // {
	// 	return SkiaApi.gr_context_purge_unlocked_resources_bytes (cast(gr_context_t*)Handle, cast(void*)bytesToPurge, preferScratchResources);
	// }

	static GRContext GetObject (void* handle)	
  {
		return handle is null ? null : new GRContext (handle, true);
	}
}
