module skia.GRVkBackendContext;

import skia.DelegateProxies;
import skia.IDisposable;
import skia.SKObject;
import skia.SkiaApi;
import skia.GRVkExtensions;
import skia.Definitions;

// #if THROW_OBJECT_EXCEPTIONS
// using GCHandle = SkiaSharp.GCHandleProxy;
// #endif

class GCHandle
{
}

public enum GCHandleType
{
	Weak = 0,
	WeakTrackResurrection = 1,
	Normal = 2,
	Pinned = 3
}

class GRVkBackendContext : IDisposable
{
	private GRVkGetProcedureAddressDelegate getProc;
	private GRVkGetProcProxyDelegate getProcProxy;
	// private GCHandle getProcHandle;
	private void* getProcContext;

	// protected virtual void Dispose (bool disposing)
	// {
	// 	if (disposing) {
	// 		if (getProcHandle.IsAllocated) {
	// 			getProcHandle.Free ();
	// 			getProcHandle = default;
	// 		}
	// 	}
	// }

	void Dispose()
	{
		// Dispose (true);
		// GC.SuppressFinalize (this);
	}

	void* VkInstance;

	void* VkPhysicalDevice;

	void* VkDevice;

	void* VkQueue;

	uint GraphicsQueueIndex;

	uint MaxAPIVersion;

	GRVkExtensions Extensions;

	void* VkPhysicalDeviceFeatures;

	void* VkPhysicalDeviceFeatures2;

	GRVkGetProcedureAddressDelegate GetProcedureAddress()
	{
		return getProc;
	}

	void SetProcedureAddress(GRVkGetProcedureAddressDelegate value)
	{
		getProc = value;

		// if (getProcHandle.IsAllocated)
		// 	getProcHandle.Free();

		getProcProxy = null;
		// getProcHandle = default;
		getProcContext = null;

		if (value !is null)
		{

			GRVkGetProcedureAddressDelegateWrapper wrapper = GRVkGetProcedureAddressDelegateWrapper(
					value);

			void* ctx = cast(void*)&wrapper;
			GRVkGetProcProxyDelegate releaseProxy = DelegateProxies.GRVkGetProcDelegateProxy;
			getProcProxy = DelegateProxies.Create(releaseProxy, ctx);
			getProcContext = cast(void*) ctx;
		}
	}

	bool ProtectedContext;

	GRVkBackendContextNative ToNative()
	{
		GRVkBackendContextNative backendContextNative = GRVkBackendContextNative();
		backendContextNative.fInstance = cast(vk_instance_t*) VkInstance;
		backendContextNative.fDevice = cast(vk_device_t*) VkDevice;
		backendContextNative.fPhysicalDevice = cast(vk_physical_device_t*) VkPhysicalDevice;
		backendContextNative.fQueue = cast(vk_queue_t*) VkQueue;
		backendContextNative.fGraphicsQueueIndex = GraphicsQueueIndex;
		backendContextNative.fMaxAPIVersion = MaxAPIVersion;
		backendContextNative.fVkExtensions = cast(gr_vk_extensions_t*)(Extensions.Handle
				? Extensions.Handle : null);
		backendContextNative.fDeviceFeatures = cast(
				vk_physical_device_features_t*) VkPhysicalDeviceFeatures;
		backendContextNative.fDeviceFeatures2 = cast(
				vk_physical_device_features_2_t*) VkPhysicalDeviceFeatures2;
		backendContextNative.fGetProcUserData = getProcContext;
		backendContextNative.fGetProc = getProcProxy;
		backendContextNative.fProtectedContext = ProtectedContext ? cast(byte) 1 : cast(byte) 0;

		return backendContextNative;
	}

}
