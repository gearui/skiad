module skia.GRBackendTexture;

import skia.Definitions;
import skia.GRDefinitions;
import skia.EnumMappings;
import skia.Exceptions;
import skia.MathTypes;
import skia.SKObject;
import skia.SkiaApi;
import skia.Exceptions;

class GRBackendTexture : SKObject, ISKSkipObjectRegistration {
	this(void* handle, bool owns) {
		super(handle, owns);
	}

	this(GRGlBackendTextureDesc desc) {
		this(null, true);
		auto handle = desc.TextureHandle;
		if (handle.Format == 0) {
			handle.Format = desc.Config.ToGlSizedFormat();
		}
		CreateGl(desc.Width, desc.Height, false, handle);
	}

	this (GRBackendTextureDesc desc)
	{
		this (null, true);
	// 	GRBackendObject handlePtr = desc.TextureHandle;
	// 	// auto oldHandle = Marshal.PtrToStructure<GRTextureInfoObsolete> (handlePtr);
	// 	GRTextureInfoObsolete oldHandle = cast(GRTextureInfoObsolete)(handlePtr);

	// 	auto handle = new GRGlTextureInfo (oldHandle.fTarget, oldHandle.fID, desc.Config.ToGlSizedFormat ());
	// 	CreateGl (desc.Width, desc.Height, false, handle);
	}

	this(int width, int height, bool mipmapped, GRGlTextureInfo glInfo) {
		this(null, true);
		CreateGl(width, height, mipmapped, glInfo);
	}

	this(int width, int height, GRVkImageInfo vkInfo) {
		this(null, true);
		CreateVulkan(width, height, vkInfo);
	}

	private void CreateGl(int width, int height, bool mipmapped, GRGlTextureInfo glInfo) {
		Handle = SkiaApi.gr_backendtexture_new_gl(width, height, mipmapped, &glInfo);

		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new GRBackendTexture instance.");
		}
	}

	private void CreateVulkan(int width, int height, GRVkImageInfo vkInfo) {
		Handle = SkiaApi.gr_backendtexture_new_vulkan(width, height, &vkInfo);

		if (Handle is null) {
			throw new InvalidOperationException("Unable to create a new GRBackendTexture instance.");
		}
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	protected override void DisposeNative() {
		return SkiaApi.gr_backendtexture_delete(cast(gr_backendtexture_t*)Handle);
	}

	bool IsValid() {
		return SkiaApi.gr_backendtexture_is_valid(cast(gr_backendtexture_t*)Handle);
	}

	int Width() {
		return SkiaApi.gr_backendtexture_get_width(cast(gr_backendtexture_t*)Handle);
	}

	int Height() {
		return SkiaApi.gr_backendtexture_get_height(cast(gr_backendtexture_t*)Handle);
	}

	bool HasMipMaps() {
		return SkiaApi.gr_backendtexture_has_mipmaps(cast(gr_backendtexture_t*)Handle);
	}

	GRBackend Backend() {
		return SkiaApi.gr_backendtexture_get_backend(cast(gr_backendtexture_t*)Handle).FromNative();
	}

	SKSizeI Size() {
		return SKSizeI(Width, Height);
	}

	SKRectI Rect() {
		return SKRectI(0, 0, Width, Height);
	}

	//   GRGlTextureInfo GetGlTextureInfo ()
	//   {
	//     var info;
	//     return 	GetGlTextureInfo ( info) ? info : default;
	//   }

	bool GetGlTextureInfo(out GRGlTextureInfo glInfo) {
		GRGlTextureInfo* g = &glInfo;
		return SkiaApi.gr_backendtexture_get_gl_textureinfo(cast(gr_backendtexture_t*)Handle, g);
	}

	struct GRTextureInfoObsolete {
		uint fTarget;
		uint fID;
	}
}
