module skia.GRVkExtensions;

import skia.DelegateProxies;
import skia.SKObject;
import skia.SkiaApi;
import skia.Definitions;

class GRVkExtensions : SKObject, ISKSkipObjectRegistration
{
	this (void* h, bool owns)
	{
    super (h, owns);
	}

	private this ()
	{
    this (SkiaApi.gr_vk_extensions_new (), true);
	}

	protected override void DisposeNative ()
  {
    return SkiaApi.gr_vk_extensions_delete (cast(gr_vk_extensions_t*)Handle);
  }
		

	void HasExtension (string extension, int minVersion)
  {
     SkiaApi.gr_vk_extensions_has_extension (cast(gr_vk_extensions_t*)Handle, extension, cast(uint)minVersion);
  }
		

	void Initialize (GRVkGetProcedureAddressDelegate getProc, void* vkInstance, void* vkPhysicalDevice)
  {
    return Initialize (getProc, vkInstance, vkPhysicalDevice, null, null);
  }
		

	void Initialize (GRVkGetProcedureAddressDelegate getProc, void* vkInstance, void* vkPhysicalDevice, string[] instanceExtensions, string[] deviceExtensions)
	{
		GRVkGetProcedureAddressDelegateWrapper wrapper = GRVkGetProcedureAddressDelegateWrapper(getProc);

		void* ctx = cast(void*)&wrapper;
		GRVkGetProcProxyDelegate getProxy = DelegateProxies.GRVkGetProcDelegateProxy;
		GRVkGetProcProxyDelegate proxy = DelegateProxies.Create (getProxy, ctx);
		
		try {
			auto ie = instanceExtensions;
			auto de = deviceExtensions;
			SkiaApi.gr_vk_extensions_init (cast(gr_vk_extensions_t*)Handle, proxy, cast(void*)ctx, cast(vk_instance_t*)vkInstance, cast(vk_physical_device_t*)vkPhysicalDevice, cast(uint)(ie.length ? ie.length : 0), ie, cast(uint)(de.length ? de.length: 0), de);
		} finally {
			// gch.Free ();
		}
	}

	static GRVkExtensions Create (GRVkGetProcedureAddressDelegate getProc, void* vkInstance, void* vkPhysicalDevice, string[] instanceExtensions, string[] deviceExtensions)
	{
		auto extensions = new GRVkExtensions ();
		extensions.Initialize (getProc, vkInstance, vkPhysicalDevice, instanceExtensions, deviceExtensions);
		return extensions;
	}

	static GRVkExtensions GetObject (void* handle)
  {
    return handle is null ? null : new GRVkExtensions (handle, true);
  }
		
}
