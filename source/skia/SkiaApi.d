module skia.SkiaApi;

import skia.SKColorF;
import skia.Definitions;
import skia.EnumMappings;
import skia.GRDefinitions;
import skia.MathTypes;
import skia.SKMatrix44;
import skia.Exceptions;
import skia.SKMatrix;
import skia.SKMask;

import std.datetime;
import std.string;
import std.typecons;


alias int8_t   = byte;          ///
alias int16_t  = short;         ///
alias uint8_t  = ubyte;         ///
alias uint16_t = ushort;        ///
alias int32_t  = int;           ///
alias uint32_t = uint;          ///
alias int64_t  = long;   ///
alias uint64_t = ulong;  ///

alias sk_color_t = uint;
alias sk_pmcolor_t = uint;
alias sk_font_table_tag_t = uint;



struct gr_backendrendertarget_t;
struct gr_backendtexture_t;
struct gr_context_t;
struct gr_glinterface_t;
struct gr_vk_extensions_t;
struct gr_vk_memory_allocator_t;
struct gr_vkinterface_t;
struct sk_3dview_t;
struct sk_bitmap_t;
struct sk_canvas_t;
struct sk_codec_t;
struct sk_colorfilter_t;
struct sk_colorspace_icc_profile_t;
struct sk_colorspace_t;
struct sk_colortable_t;
struct sk_compatpaint_t;
struct sk_data_t;
struct sk_document_t;
struct sk_drawable_t;
struct sk_font_t;
struct sk_fontmgr_t;
struct sk_fontstyle_t;
struct sk_fontstyleset_t;
struct sk_image_t;
struct sk_imagefilter_croprect_t;
struct sk_imagefilter_t;
struct sk_manageddrawable_t;
struct sk_managedtracememorydump_t;
struct sk_maskfilter_t;
struct sk_matrix44_t;
struct sk_nodraw_canvas_t;
struct sk_nvrefcnt_t;
struct sk_nway_canvas_t;
struct sk_opbuilder_t;
struct sk_overdraw_canvas_t;
struct sk_paint_t;
struct sk_path_effect_t;
struct sk_path_iterator_t;
struct sk_path_rawiterator_t;
struct sk_path_t;
struct sk_pathmeasure_t;
struct sk_picture_recorder_t;
struct sk_picture_t;
struct sk_pixelref_factory_t;
struct sk_pixmap_t;
struct sk_refcnt_t;
struct sk_region_cliperator_t;
struct sk_region_iterator_t;
struct sk_region_spanerator_t;
struct sk_region_t;
struct sk_rrect_t;
struct sk_shader_t;
struct sk_stream_asset_t;
struct sk_stream_filestream_t;
struct sk_stream_managedstream_t;
struct sk_stream_memorystream_t;
struct sk_stream_streamrewindable_t;
struct sk_stream_t;
struct sk_string_t;
struct sk_surface_t;
struct sk_surfaceprops_t;
struct sk_svgcanvas_t;
struct sk_textblob_builder_t;
struct sk_textblob_t;
struct sk_tracememorydump_t;
struct sk_typeface_t;
struct sk_vertices_t;
struct sk_wstream_dynamicmemorystream_t;
struct sk_wstream_filestream_t;
struct sk_wstream_managedstream_t;
struct sk_wstream_t;
struct sk_xmlstreamwriter_t;
struct sk_xmlwriter_t;
struct vk_device_t;
struct vk_instance_t;
struct vk_physical_device_features_2_t;
struct vk_physical_device_features_t;
struct vk_physical_device_t;
struct vk_queue_t;




extern (C) @nogc nothrow {

    // gr_context.h
    void gr_backendrendertarget_delete(gr_backendrendertarget_t* rendertarget);
    gr_backend_t gr_backendrendertarget_get_backend(const(gr_backendrendertarget_t)* rendertarget);
    bool gr_backendrendertarget_get_gl_framebufferinfo(const(gr_backendrendertarget_t)* rendertarget, gr_gl_framebufferinfo_t* glInfo);
    int gr_backendrendertarget_get_height(const(gr_backendrendertarget_t)* rendertarget);
    int gr_backendrendertarget_get_samples(const(gr_backendrendertarget_t)* rendertarget);
    int gr_backendrendertarget_get_stencils(const(gr_backendrendertarget_t)* rendertarget);
    int gr_backendrendertarget_get_width(const(gr_backendrendertarget_t)* rendertarget);
    bool gr_backendrendertarget_is_valid(const(gr_backendrendertarget_t)* rendertarget);
    gr_backendrendertarget_t* gr_backendrendertarget_new_gl(int width, int height, int samples, int stencils, const(gr_gl_framebufferinfo_t)* glInfo);
    gr_backendrendertarget_t* gr_backendrendertarget_new_vulkan(int width, int height, int samples, const(gr_vk_imageinfo_t)* vkImageInfo);
    void gr_backendtexture_delete(gr_backendtexture_t* texture);
    gr_backend_t gr_backendtexture_get_backend(const(gr_backendtexture_t)* texture);
    bool gr_backendtexture_get_gl_textureinfo(const(gr_backendtexture_t)* texture, gr_gl_textureinfo_t* glInfo);
    int gr_backendtexture_get_height(const(gr_backendtexture_t)* texture);
    int gr_backendtexture_get_width(const(gr_backendtexture_t)* texture);
    bool gr_backendtexture_has_mipmaps(const(gr_backendtexture_t)* texture);
    bool gr_backendtexture_is_valid(const(gr_backendtexture_t)* texture);
    gr_backendtexture_t* gr_backendtexture_new_gl(int width, int height, bool mipmapped, const(gr_gl_textureinfo_t)* glInfo);
    gr_backendtexture_t* gr_backendtexture_new_vulkan(int width, int height, const(gr_vk_imageinfo_t)* vkInfo);
    void gr_context_abandon_context(gr_context_t* context);
    void gr_context_dump_memory_statistics(const(gr_context_t)* context, sk_tracememorydump_t* dump);
    void gr_context_flush(gr_context_t* context);
    void gr_context_free_gpu_resources(gr_context_t* context);
    gr_backend_t gr_context_get_backend(gr_context_t* context);
    int gr_context_get_max_surface_sample_count_for_color_type(gr_context_t* context, sk_colortype_t colorType);
    size_t gr_context_get_resource_cache_limit(gr_context_t* context);
    void gr_context_get_resource_cache_usage(gr_context_t* context, int* maxResources, size_t* maxResourceBytes);
    gr_context_t* gr_context_make_gl(const(gr_glinterface_t)* glInterface);
    gr_context_t* gr_context_make_vulkan(const gr_vk_backendcontext_t vkBackendContext);
    void gr_context_perform_deferred_cleanup(gr_context_t* context, long ms);
    void gr_context_purge_unlocked_resources(gr_context_t* context, bool scratchResourcesOnly);
    void gr_context_purge_unlocked_resources_bytes(gr_context_t* context, size_t bytesToPurge, bool preferScratchResources);
    void gr_context_release_resources_and_abandon_context(gr_context_t* context);
    void gr_context_reset_context(gr_context_t* context, uint32_t state);
    void gr_context_set_resource_cache_limit(gr_context_t* context, size_t maxResourceBytes);
    void gr_context_unref(gr_context_t* context);
    gr_glinterface_t* gr_glinterface_assemble_gl_interface(void* ctx, gr_gl_get_proc get);
    gr_glinterface_t* gr_glinterface_assemble_gles_interface(void* ctx, gr_gl_get_proc get);
    gr_glinterface_t* gr_glinterface_assemble_interface(void* ctx, gr_gl_get_proc get);
    gr_glinterface_t* gr_glinterface_assemble_webgl_interface(void* ctx, gr_gl_get_proc get);
    gr_glinterface_t* gr_glinterface_create_native_interface();
    bool gr_glinterface_has_extension(const(gr_glinterface_t)* glInterface, const(char)* extension);
    void gr_glinterface_unref(const(gr_glinterface_t)* glInterface);
    bool gr_glinterface_validate(const(gr_glinterface_t)* glInterface);
    void gr_vk_extensions_delete(gr_vk_extensions_t* extensions);
    bool gr_vk_extensions_has_extension(gr_vk_extensions_t* extensions, const(char)* ext, uint32_t minVersion);
    void gr_vk_extensions_init(gr_vk_extensions_t* extensions, gr_vk_get_proc getProc, void* userData, vk_instance_t* instance, vk_physical_device_t* physDev, uint32_t instanceExtensionCount, const(char)** instanceExtensions, uint32_t deviceExtensionCount, const(char)** deviceExtensions);
    gr_vk_extensions_t* gr_vk_extensions_new();

    // sk_bitmap.h
    void sk_bitmap_destructor(sk_bitmap_t* cbitmap);
    void sk_bitmap_erase(sk_bitmap_t* cbitmap, sk_color_t color);
    void sk_bitmap_erase_rect(sk_bitmap_t* cbitmap, sk_color_t color, sk_irect_t* rect);
    bool sk_bitmap_extract_alpha(sk_bitmap_t* cbitmap, sk_bitmap_t* dst, const(sk_paint_t)* paint, sk_ipoint_t* offset);
    bool sk_bitmap_extract_subset(sk_bitmap_t* cbitmap, sk_bitmap_t* dst, sk_irect_t* subset);
    void* sk_bitmap_get_addr(sk_bitmap_t* cbitmap, int x, int y);
    uint16_t* sk_bitmap_get_addr_16(sk_bitmap_t* cbitmap, int x, int y);
    uint32_t* sk_bitmap_get_addr_32(sk_bitmap_t* cbitmap, int x, int y);
    uint8_t* sk_bitmap_get_addr_8(sk_bitmap_t* cbitmap, int x, int y);
    size_t sk_bitmap_get_byte_count(sk_bitmap_t* cbitmap);
    void sk_bitmap_get_info(sk_bitmap_t* cbitmap, sk_imageinfo_t* info);
    sk_color_t sk_bitmap_get_pixel_color(sk_bitmap_t* cbitmap, int x, int y);
    void sk_bitmap_get_pixel_colors(sk_bitmap_t* cbitmap, sk_color_t* colors);
    void* sk_bitmap_get_pixels(sk_bitmap_t* cbitmap, size_t* length);
    size_t sk_bitmap_get_row_bytes(sk_bitmap_t* cbitmap);
    bool sk_bitmap_install_mask_pixels(sk_bitmap_t* cbitmap, const(sk_mask_t)* cmask);
    bool sk_bitmap_install_pixels(sk_bitmap_t* cbitmap, const(sk_imageinfo_t)* cinfo, void* pixels, size_t rowBytes, sk_bitmap_release_proc releaseProc, void* context);
    bool sk_bitmap_install_pixels_with_pixmap(sk_bitmap_t* cbitmap, const(sk_pixmap_t)* cpixmap);
    bool sk_bitmap_is_immutable(sk_bitmap_t* cbitmap);
    bool sk_bitmap_is_null(sk_bitmap_t* cbitmap);
    bool sk_bitmap_is_volatile(sk_bitmap_t* cbitmap);
    sk_shader_t* sk_bitmap_make_shader(sk_bitmap_t* cbitmap, sk_shader_tilemode_t tmx, sk_shader_tilemode_t tmy, const(sk_matrix_t)* cmatrix);
    sk_bitmap_t* sk_bitmap_new();
    void sk_bitmap_notify_pixels_changed(sk_bitmap_t* cbitmap);
    bool sk_bitmap_peek_pixels(sk_bitmap_t* cbitmap, sk_pixmap_t* cpixmap);
    bool sk_bitmap_ready_to_draw(sk_bitmap_t* cbitmap);
    void sk_bitmap_reset(sk_bitmap_t* cbitmap);
    void sk_bitmap_set_immutable(sk_bitmap_t* cbitmap);
    void sk_bitmap_set_pixels(sk_bitmap_t* cbitmap, void* pixels);
    void sk_bitmap_set_volatile(sk_bitmap_t* cbitmap, bool value);
    void sk_bitmap_swap(sk_bitmap_t* cbitmap, sk_bitmap_t* cother);
    bool sk_bitmap_try_alloc_pixels(sk_bitmap_t* cbitmap, const(sk_imageinfo_t)* requestedInfo, size_t rowBytes);
    bool sk_bitmap_try_alloc_pixels_with_flags(sk_bitmap_t* cbitmap, const(sk_imageinfo_t)* requestedInfo, uint32_t flags);

    // sk_canvas.h
    void sk_canvas_clear(sk_canvas_t*, sk_color_t);
    void sk_canvas_clip_path_with_operation(sk_canvas_t* t, const(sk_path_t)* crect, sk_clipop_t op, bool doAA);
    void sk_canvas_clip_rect_with_operation(sk_canvas_t* t, const(sk_rect_t)* crect, sk_clipop_t op, bool doAA);
    void sk_canvas_clip_region(sk_canvas_t* canvas, const(sk_region_t)* region, sk_clipop_t op);
    void sk_canvas_clip_rrect_with_operation(sk_canvas_t* t, const(sk_rrect_t)* crect, sk_clipop_t op, bool doAA);
    void sk_canvas_concat(sk_canvas_t*, const(sk_matrix_t)*);
    void sk_canvas_destroy(sk_canvas_t*);
    void sk_canvas_discard(sk_canvas_t*);
    void sk_canvas_draw_annotation(sk_canvas_t* t, const(sk_rect_t)* rect, const(char)* key, sk_data_t* value);
    void sk_canvas_draw_arc(sk_canvas_t* ccanvas, const(sk_rect_t)* oval, float startAngle, float sweepAngle, bool useCenter, const(sk_paint_t)* paint);
    void sk_canvas_draw_atlas(sk_canvas_t* ccanvas, const(sk_image_t)* atlas, const(sk_rsxform_t)* xform, const(sk_rect_t)* tex, const(sk_color_t)* colors, int count, sk_blendmode_t mode, const(sk_rect_t)* cullRect, const(sk_paint_t)* paint);
    void sk_canvas_draw_bitmap(sk_canvas_t* ccanvas, const(sk_bitmap_t)* bitmap, float left, float top, const(sk_paint_t)* paint);
    void sk_canvas_draw_bitmap_lattice(sk_canvas_t* t, const sk_bitmap_t* bitmap, const sk_lattice_t* lattice, const sk_rect_t* dst, const sk_paint_t* paint);
    void sk_canvas_draw_bitmap_nine(sk_canvas_t* t, const sk_bitmap_t* bitmap, const sk_irect_t* center, const sk_rect_t* dst, const sk_paint_t* paint);
    void sk_canvas_draw_bitmap_rect(sk_canvas_t* ccanvas, const(sk_bitmap_t)* bitmap, const(sk_rect_t)* src, const(sk_rect_t)* dst, const(sk_paint_t)* paint);
    void sk_canvas_draw_circle(sk_canvas_t*, float cx, float cy, float rad, const(sk_paint_t)*);
    void sk_canvas_draw_color(sk_canvas_t* ccanvas, sk_color_t color, sk_blendmode_t mode);
    void sk_canvas_draw_drawable(sk_canvas_t*, sk_drawable_t*, const(sk_matrix_t)*);
    void sk_canvas_draw_drrect(sk_canvas_t* ccanvas, const(sk_rrect_t)* outer, const(sk_rrect_t)* inner, const(sk_paint_t)* paint);
    void sk_canvas_draw_image(sk_canvas_t*, const(sk_image_t)*, float x, float y, const(sk_paint_t)*);
    void sk_canvas_draw_image_lattice(sk_canvas_t* t, const(sk_image_t)* image, const(sk_lattice_t)* lattice, const(sk_rect_t)* dst, const(sk_paint_t)* paint);
    void sk_canvas_draw_image_nine(sk_canvas_t* t, const(sk_image_t)* image, const(sk_irect_t)* center, const(sk_rect_t)* dst, const(sk_paint_t)* paint);
    void sk_canvas_draw_image_rect(sk_canvas_t*, const(sk_image_t)*, const(sk_rect_t)* src, const(sk_rect_t)* dst, const(sk_paint_t)*);
    void sk_canvas_draw_line(sk_canvas_t* ccanvas, float x0, float y0, float x1, float y1, sk_paint_t* cpaint);
    void sk_canvas_draw_link_destination_annotation(sk_canvas_t* t, const(sk_rect_t)* rect, sk_data_t* value);
    void sk_canvas_draw_named_destination_annotation(sk_canvas_t* t, const(sk_point_t)* point, sk_data_t* value);
    void sk_canvas_draw_oval(sk_canvas_t*, const(sk_rect_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_paint(sk_canvas_t*, const(sk_paint_t)*);
    void sk_canvas_draw_patch(sk_canvas_t* ccanvas, const(sk_point_t)* cubics, const(sk_color_t)* colors, const(sk_point_t)* texCoords, sk_blendmode_t mode, const(sk_paint_t)* paint);
    void sk_canvas_draw_path(sk_canvas_t*, const(sk_path_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_picture(sk_canvas_t*, const(sk_picture_t)*, const(sk_matrix_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_point(sk_canvas_t*, float, float, const(sk_paint_t)*);
    void sk_canvas_draw_points(sk_canvas_t*, sk_point_mode_t, size_t, const(sk_point_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_rect(sk_canvas_t*, const(sk_rect_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_region(sk_canvas_t*, const(sk_region_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_round_rect(sk_canvas_t*, const(sk_rect_t)*, float rx, float ry, const(sk_paint_t)*);
    void sk_canvas_draw_rrect(sk_canvas_t*, const(sk_rrect_t)*, const(sk_paint_t)*);
    void sk_canvas_draw_simple_text(sk_canvas_t* ccanvas, const(void)* text, size_t byte_length, sk_text_encoding_t encoding, float x, float y, const(sk_font_t)* cfont, const(sk_paint_t)* cpaint);
    void sk_canvas_draw_text_blob(sk_canvas_t*, sk_textblob_t* text, float x, float y, const(sk_paint_t)* paint);
    void sk_canvas_draw_url_annotation(sk_canvas_t* t, const(sk_rect_t)* rect, sk_data_t* value);
    void sk_canvas_draw_vertices(sk_canvas_t* ccanvas, const(sk_vertices_t)* vertices, sk_blendmode_t mode, const(sk_paint_t)* paint);
    void sk_canvas_flush(sk_canvas_t* ccanvas);
    bool sk_canvas_get_device_clip_bounds(sk_canvas_t* t, sk_irect_t* cbounds);
    bool sk_canvas_get_local_clip_bounds(sk_canvas_t* t, sk_rect_t* cbounds);
    int sk_canvas_get_save_count(sk_canvas_t*);
    void sk_canvas_get_total_matrix(sk_canvas_t* ccanvas, sk_matrix_t* matrix);
    bool sk_canvas_is_clip_empty(sk_canvas_t* ccanvas);
    bool sk_canvas_is_clip_rect(sk_canvas_t* ccanvas);
    sk_canvas_t* sk_canvas_new_from_bitmap(const(sk_bitmap_t)* bitmap);
    bool sk_canvas_quick_reject(sk_canvas_t*, const(sk_rect_t)*);
    void sk_canvas_reset_matrix(sk_canvas_t* ccanvas);
    void sk_canvas_restore(sk_canvas_t*);
    void sk_canvas_restore_to_count(sk_canvas_t*, int saveCount);
    void sk_canvas_rotate_degrees(sk_canvas_t*, float degrees);
    void sk_canvas_rotate_radians(sk_canvas_t*, float radians);
    int sk_canvas_save(sk_canvas_t*);
    int sk_canvas_save_layer(sk_canvas_t*, const(sk_rect_t)*, const(sk_paint_t)*);
    void sk_canvas_scale(sk_canvas_t*, float sx, float sy);
    void sk_canvas_set_matrix(sk_canvas_t* ccanvas, const(sk_matrix_t)* matrix);
    void sk_canvas_skew(sk_canvas_t*, float sx, float sy);
    void sk_canvas_translate(sk_canvas_t*, float dx, float dy);
    void sk_nodraw_canvas_destroy(sk_nodraw_canvas_t*);
    sk_nodraw_canvas_t* sk_nodraw_canvas_new(int width, int height);
    void sk_nway_canvas_add_canvas(sk_nway_canvas_t*, sk_canvas_t* canvas);
    void sk_nway_canvas_destroy(sk_nway_canvas_t*);
    sk_nway_canvas_t* sk_nway_canvas_new(int width, int height);
    void sk_nway_canvas_remove_all(sk_nway_canvas_t*);
    void sk_nway_canvas_remove_canvas(sk_nway_canvas_t*, sk_canvas_t* canvas);
    void sk_overdraw_canvas_destroy(sk_overdraw_canvas_t* canvas);
    sk_overdraw_canvas_t* sk_overdraw_canvas_new(sk_canvas_t* canvas);

    // sk_codec.h
    void sk_codec_destroy(sk_codec_t* codec);
    sk_encoded_image_format_t sk_codec_get_encoded_format(sk_codec_t* codec);
    int sk_codec_get_frame_count(sk_codec_t* codec);
    void sk_codec_get_frame_info(sk_codec_t* codec, sk_codec_frameinfo_t* frameInfo);
    bool sk_codec_get_frame_info_for_index(sk_codec_t* codec, int index, sk_codec_frameinfo_t* frameInfo);
    void sk_codec_get_info(sk_codec_t* codec, sk_imageinfo_t* info);
    sk_encodedorigin_t sk_codec_get_origin(sk_codec_t* codec);
    sk_codec_result_t sk_codec_get_pixels(sk_codec_t* codec, const(sk_imageinfo_t)* info, void* pixels, size_t rowBytes, const(sk_codec_options_t)* options);
    int sk_codec_get_repetition_count(sk_codec_t* codec);
    void sk_codec_get_scaled_dimensions(sk_codec_t* codec, float desiredScale, sk_isize_t* dimensions);
    sk_codec_scanline_order_t sk_codec_get_scanline_order(sk_codec_t* codec);
    int sk_codec_get_scanlines(sk_codec_t* codec, void* dst, int countLines, size_t rowBytes);
    bool sk_codec_get_valid_subset(sk_codec_t* codec, sk_irect_t* desiredSubset);
    sk_codec_result_t sk_codec_incremental_decode(sk_codec_t* codec, int* rowsDecoded);
    size_t sk_codec_min_buffered_bytes_needed();
    sk_codec_t* sk_codec_new_from_data(sk_data_t* data);
    sk_codec_t* sk_codec_new_from_stream(sk_stream_t* stream, sk_codec_result_t* result);
    int sk_codec_next_scanline(sk_codec_t* codec);
    int sk_codec_output_scanline(sk_codec_t* codec, int inputScanline);
    bool sk_codec_skip_scanlines(sk_codec_t* codec, int countLines);
    sk_codec_result_t sk_codec_start_incremental_decode(sk_codec_t* codec, const(sk_imageinfo_t)* info, void* pixels, size_t rowBytes, const(sk_codec_options_t)* options);
    sk_codec_result_t sk_codec_start_scanline_decode(sk_codec_t* codec, const(sk_imageinfo_t)* info, const(sk_codec_options_t)* options);

    // sk_colorfilter.h
    sk_colorfilter_t* sk_colorfilter_new_color_matrix(const(float)* array);
    sk_colorfilter_t* sk_colorfilter_new_compose(sk_colorfilter_t* outer, sk_colorfilter_t* inner);
    sk_colorfilter_t* sk_colorfilter_new_high_contrast(const(sk_highcontrastconfig_t)* config);
    sk_colorfilter_t* sk_colorfilter_new_lighting(sk_color_t mul, sk_color_t add);
    sk_colorfilter_t* sk_colorfilter_new_luma_color();
    sk_colorfilter_t* sk_colorfilter_new_mode(sk_color_t c, sk_blendmode_t mode);
    sk_colorfilter_t* sk_colorfilter_new_table(ubyte* table);
    sk_colorfilter_t* sk_colorfilter_new_table_argb(ubyte* tableA, ubyte* tableR, ubyte* tableG, ubyte* tableB);
    void sk_colorfilter_unref(sk_colorfilter_t* filter);

    // sk_colorspace.h
    void sk_color4f_from_color(sk_color_t color, sk_color4f_t* color4f);
    sk_color_t sk_color4f_to_color(const(sk_color4f_t)* color4f);
    bool sk_colorspace_equals(const(sk_colorspace_t)* src, const(sk_colorspace_t)* dst);
    bool sk_colorspace_gamma_close_to_srgb(const(sk_colorspace_t)* colorspace);
    bool sk_colorspace_gamma_is_linear(const(sk_colorspace_t)* colorspace);
    void sk_colorspace_icc_profile_delete(sk_colorspace_icc_profile_t* profile);
    uint8_t* sk_colorspace_icc_profile_get_buffer(sk_colorspace_icc_profile_t* profile, uint32_t* size);
    bool sk_colorspace_icc_profile_get_to_xyzd50(const(sk_colorspace_icc_profile_t)* profile, sk_colorspace_xyz_t* toXYZD50);
    sk_colorspace_icc_profile_t* sk_colorspace_icc_profile_new();
    bool sk_colorspace_icc_profile_parse(const(void)* buffer, size_t length, sk_colorspace_icc_profile_t* profile);
    bool sk_colorspace_is_numerical_transfer_fn(const(sk_colorspace_t)* colorspace, sk_colorspace_transfer_fn_t* transferFn);
    bool sk_colorspace_is_srgb(const(sk_colorspace_t)* colorspace);
    sk_colorspace_t* sk_colorspace_make_linear_gamma(const(sk_colorspace_t)* colorspace);
    sk_colorspace_t* sk_colorspace_make_srgb_gamma(const(sk_colorspace_t)* colorspace);
    sk_colorspace_t* sk_colorspace_new_icc(const(sk_colorspace_icc_profile_t)* profile);
    sk_colorspace_t* sk_colorspace_new_rgb(const(sk_colorspace_transfer_fn_t)* transferFn, const(sk_colorspace_xyz_t)* toXYZD50);
    sk_colorspace_t* sk_colorspace_new_srgb();
    sk_colorspace_t* sk_colorspace_new_srgb_linear();
    bool sk_colorspace_primaries_to_xyzd50(const(sk_colorspace_primaries_t)* primaries, sk_colorspace_xyz_t* toXYZD50);
    void sk_colorspace_ref(sk_colorspace_t* colorspace);
    void sk_colorspace_to_profile(const(sk_colorspace_t)* colorspace, sk_colorspace_icc_profile_t* profile);
    bool sk_colorspace_to_xyzd50(const(sk_colorspace_t)* colorspace, sk_colorspace_xyz_t* toXYZD50);
    float sk_colorspace_transfer_fn_eval(const(sk_colorspace_transfer_fn_t)* transferFn, float x);
    bool sk_colorspace_transfer_fn_invert(const(sk_colorspace_transfer_fn_t)* src, sk_colorspace_transfer_fn_t* dst);
    void sk_colorspace_transfer_fn_named_2dot2(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_transfer_fn_named_hlg(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_transfer_fn_named_linear(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_transfer_fn_named_pq(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_transfer_fn_named_rec2020(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_transfer_fn_named_srgb(sk_colorspace_transfer_fn_t* transferFn);
    void sk_colorspace_unref(sk_colorspace_t* colorspace);
    void sk_colorspace_xyz_concat(const(sk_colorspace_xyz_t)* a, const(sk_colorspace_xyz_t)* b, sk_colorspace_xyz_t* result);
    bool sk_colorspace_xyz_invert(const(sk_colorspace_xyz_t)* src, sk_colorspace_xyz_t* dst);
    void sk_colorspace_xyz_named_adobe_rgb(sk_colorspace_xyz_t* xyz);
    void sk_colorspace_xyz_named_dcip3(sk_colorspace_xyz_t* xyz);
    void sk_colorspace_xyz_named_rec2020(sk_colorspace_xyz_t* xyz);
    void sk_colorspace_xyz_named_srgb(sk_colorspace_xyz_t* xyz);
    void sk_colorspace_xyz_named_xyz(sk_colorspace_xyz_t* xyz);

    // sk_colortable.h
    int sk_colortable_count(const(sk_colortable_t)* ctable);
    sk_colortable_t* sk_colortable_new(const(sk_pmcolor_t)* colors, int count);
    void sk_colortable_read_colors(const(sk_colortable_t)* ctable, sk_pmcolor_t** colors);
    void sk_colortable_unref(sk_colortable_t* ctable);

    // sk_data.h
    uint8_t* sk_data_get_bytes(const(sk_data_t)*);
    void* sk_data_get_data(const(sk_data_t)*);
    size_t sk_data_get_size(const(sk_data_t)*);
    sk_data_t* sk_data_new_empty();
    sk_data_t* sk_data_new_from_file(const(char)* path);
    sk_data_t* sk_data_new_from_stream(sk_stream_t* stream, size_t length);
    sk_data_t* sk_data_new_subset(const(sk_data_t)* src, size_t offset, size_t length);
    sk_data_t* sk_data_new_uninitialized(size_t size);
    sk_data_t* sk_data_new_with_copy(const(void)* src, size_t length);
    sk_data_t* sk_data_new_with_proc(const(void)* ptr, size_t length, sk_data_release_proc proc, void* ctx);
    void sk_data_ref(const(sk_data_t)*);
    void sk_data_unref(const(sk_data_t)*);

    // sk_document.h
    void sk_document_abort(sk_document_t* document);
    sk_canvas_t* sk_document_begin_page(sk_document_t* document, float width, float height, const(sk_rect_t)* content);
    void sk_document_close(sk_document_t* document);
    sk_document_t* sk_document_create_pdf_from_stream(sk_wstream_t* stream);
    sk_document_t* sk_document_create_pdf_from_stream_with_metadata(sk_wstream_t* stream, const(sk_document_pdf_metadata_t)* metadata);
    sk_document_t* sk_document_create_xps_from_stream(sk_wstream_t* stream, float dpi);
    void sk_document_end_page(sk_document_t* document);
    void sk_document_unref(sk_document_t* document);

    // sk_drawable.h
    void sk_drawable_draw(sk_drawable_t*, sk_canvas_t*, const(sk_matrix_t)*);
    void sk_drawable_get_bounds(sk_drawable_t*, sk_rect_t*);
    uint32_t sk_drawable_get_generation_id(sk_drawable_t*);
    sk_picture_t* sk_drawable_new_picture_snapshot(sk_drawable_t*);
    void sk_drawable_notify_drawing_changed(sk_drawable_t*);
    void sk_drawable_unref(sk_drawable_t*);

    // sk_font.h
    size_t sk_font_break_text(const(sk_font_t)* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, float maxWidth, float* measuredWidth, const(sk_paint_t)* paint);
    void sk_font_delete(sk_font_t* font);
    sk_font_edging_t sk_font_get_edging(const(sk_font_t)* font);
    sk_font_hinting_t sk_font_get_hinting(const(sk_font_t)* font);
    float sk_font_get_metrics(const(sk_font_t)* font, sk_fontmetrics_t* metrics);
    bool sk_font_get_path(const(sk_font_t)* font, uint16_t glyph, sk_path_t* path);
    void sk_font_get_paths(const(sk_font_t)* font, uint16_t* glyphs, int count, const sk_glyph_path_proc glyphPathProc, void* context);
    void sk_font_get_pos(const(sk_font_t)* font, const(uint16_t)* glyphs, int count, sk_point_t* pos, sk_point_t* origin);
    float sk_font_get_scale_x(const(sk_font_t)* font);
    float sk_font_get_size(const(sk_font_t)* font);
    float sk_font_get_skew_x(const(sk_font_t)* font);
    sk_typeface_t* sk_font_get_typeface(const(sk_font_t)* font);
    void sk_font_get_widths_bounds(const(sk_font_t)* font, const(uint16_t)* glyphs, int count, float* widths, sk_rect_t* bounds, const(sk_paint_t)* paint);
    void sk_font_get_xpos(const(sk_font_t)* font, const(uint16_t)* glyphs, int count, float* xpos, float origin);
    bool sk_font_is_baseline_snap(const(sk_font_t)* font);
    bool sk_font_is_embedded_bitmaps(const(sk_font_t)* font);
    bool sk_font_is_embolden(const(sk_font_t)* font);
    bool sk_font_is_force_auto_hinting(const(sk_font_t)* font);
    bool sk_font_is_linear_metrics(const(sk_font_t)* font);
    bool sk_font_is_subpixel(const(sk_font_t)* font);
    float sk_font_measure_text(const(sk_font_t)* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, sk_rect_t* bounds, const(sk_paint_t)* paint);
    void sk_font_measure_text_no_return(const(sk_font_t)* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, sk_rect_t* bounds, const(sk_paint_t)* paint, float* measuredWidth);
    sk_font_t* sk_font_new();
    sk_font_t* sk_font_new_with_values(sk_typeface_t* typeface, float size, float scaleX, float skewX);
    void sk_font_set_baseline_snap(sk_font_t* font, bool value);
    void sk_font_set_edging(sk_font_t* font, sk_font_edging_t value);
    void sk_font_set_embedded_bitmaps(sk_font_t* font, bool value);
    void sk_font_set_embolden(sk_font_t* font, bool value);
    void sk_font_set_force_auto_hinting(sk_font_t* font, bool value);
    void sk_font_set_hinting(sk_font_t* font, sk_font_hinting_t value);
    void sk_font_set_linear_metrics(sk_font_t* font, bool value);
    void sk_font_set_scale_x(sk_font_t* font, float value);
    void sk_font_set_size(sk_font_t* font, float value);
    void sk_font_set_skew_x(sk_font_t* font, float value);
    void sk_font_set_subpixel(sk_font_t* font, bool value);
    void sk_font_set_typeface(sk_font_t* font, sk_typeface_t* value);
    int sk_font_text_to_glyphs(const(sk_font_t)* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, uint16_t* glyphs, int maxGlyphCount);
    uint16_t sk_font_unichar_to_glyph(const(sk_font_t)* font, int32_t uni);
    void sk_font_unichars_to_glyphs(const(sk_font_t)* font, const(int32_t)* uni, int count, uint16_t* glyphs);
    void sk_text_utils_get_path(const(void)* text, size_t length, sk_text_encoding_t encoding, float x, float y, const(sk_font_t)* font, sk_path_t* path);
    void sk_text_utils_get_pos_path(const(void)* text, size_t length, sk_text_encoding_t encoding, const(sk_point_t)* pos, const(sk_font_t)* font, sk_path_t* path);

    // sk_general.h
    sk_colortype_t sk_colortype_get_default_8888();
    int sk_nvrefcnt_get_ref_count(const(sk_nvrefcnt_t)* refcnt);
    void sk_nvrefcnt_safe_ref(sk_nvrefcnt_t* refcnt);
    void sk_nvrefcnt_safe_unref(sk_nvrefcnt_t* refcnt);
    bool sk_nvrefcnt_unique(const(sk_nvrefcnt_t)* refcnt);
    int sk_refcnt_get_ref_count(const(sk_refcnt_t)* refcnt);
    void sk_refcnt_safe_ref(sk_refcnt_t* refcnt);
    void sk_refcnt_safe_unref(sk_refcnt_t* refcnt);
    bool sk_refcnt_unique(const(sk_refcnt_t)* refcnt);
    int sk_version_get_increment();
    int sk_version_get_milestone();
    const(char)* sk_version_get_string();

    // sk_graphics.h
    void sk_graphics_dump_memory_statistics(sk_tracememorydump_t* dump);
    int sk_graphics_get_font_cache_count_limit();
    int sk_graphics_get_font_cache_count_used();
    size_t sk_graphics_get_font_cache_limit();
    int sk_graphics_get_font_cache_point_size_limit();
    size_t sk_graphics_get_font_cache_used();
    size_t sk_graphics_get_resource_cache_single_allocation_byte_limit();
    size_t sk_graphics_get_resource_cache_total_byte_limit();
    size_t sk_graphics_get_resource_cache_total_bytes_used();
    void sk_graphics_init();
    void sk_graphics_purge_all_caches();
    void sk_graphics_purge_font_cache();
    void sk_graphics_purge_resource_cache();
    int sk_graphics_set_font_cache_count_limit(int count);
    size_t sk_graphics_set_font_cache_limit(size_t bytes);
    int sk_graphics_set_font_cache_point_size_limit(int maxPointSize);
    size_t sk_graphics_set_resource_cache_single_allocation_byte_limit(size_t newLimit);
    size_t sk_graphics_set_resource_cache_total_byte_limit(size_t newLimit);

    // sk_image.h
    sk_data_t* sk_image_encode(const(sk_image_t)*);
    sk_data_t* sk_image_encode_specific(const(sk_image_t)* cimage, sk_encoded_image_format_t encoder, int quality);
    sk_alphatype_t sk_image_get_alpha_type(const(sk_image_t)*);
    sk_colortype_t sk_image_get_color_type(const(sk_image_t)*);
    sk_colorspace_t* sk_image_get_colorspace(const(sk_image_t)*);
    int sk_image_get_height(const(sk_image_t)*);
    uint32_t sk_image_get_unique_id(const(sk_image_t)*);
    int sk_image_get_width(const(sk_image_t)*);
    bool sk_image_is_alpha_only(const(sk_image_t)*);
    bool sk_image_is_lazy_generated(const(sk_image_t)* image);
    bool sk_image_is_texture_backed(const(sk_image_t)* image);
    bool sk_image_is_valid(const(sk_image_t)* image, gr_context_t* context);
    sk_image_t* sk_image_make_non_texture_image(const(sk_image_t)* cimage);
    sk_image_t* sk_image_make_raster_image(const(sk_image_t)* cimage);
    sk_shader_t* sk_image_make_shader(const(sk_image_t)*, sk_shader_tilemode_t tileX, sk_shader_tilemode_t tileY, const(sk_matrix_t)* localMatrix);
    sk_image_t* sk_image_make_subset(const(sk_image_t)* cimage, const(sk_irect_t)* subset);
    sk_image_t* sk_image_make_texture_image(const(sk_image_t)* cimage, gr_context_t* context, bool mipmapped);
    sk_image_t* sk_image_make_with_filter(const(sk_image_t)* cimage, const(sk_imagefilter_t)* filter, const(sk_irect_t)* subset, const(sk_irect_t)* clipBounds, sk_irect_t* outSubset, sk_ipoint_t* outOffset);
    sk_image_t* sk_image_new_from_adopted_texture(gr_context_t* context, const(gr_backendtexture_t)* texture, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_alphatype_t alpha, sk_colorspace_t* colorSpace);
    sk_image_t* sk_image_new_from_bitmap(const(sk_bitmap_t)* cbitmap);
    sk_image_t* sk_image_new_from_encoded(sk_data_t* encoded, const(sk_irect_t)* subset);
    sk_image_t* sk_image_new_from_picture(sk_picture_t* picture, const(sk_isize_t)* dimensions, const(sk_matrix_t)* matrix, const(sk_paint_t)* paint);
    sk_image_t* sk_image_new_from_texture(gr_context_t* context, const(gr_backendtexture_t)* texture, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_alphatype_t alpha, sk_colorspace_t* colorSpace, sk_image_texture_release_proc releaseProc, void* releaseContext);
    sk_image_t* sk_image_new_raster(const(sk_pixmap_t)* pixmap, sk_image_raster_release_proc releaseProc, void* context);
    sk_image_t* sk_image_new_raster_copy(const(sk_imageinfo_t)*, const(void)* pixels, size_t rowBytes);
    sk_image_t* sk_image_new_raster_copy_with_pixmap(const(sk_pixmap_t)* pixmap);
    sk_image_t* sk_image_new_raster_data(const(sk_imageinfo_t)* cinfo, sk_data_t* pixels, size_t rowBytes);
    bool sk_image_peek_pixels(const(sk_image_t)* image, sk_pixmap_t* pixmap);
    bool sk_image_read_pixels(const(sk_image_t)* image, const(sk_imageinfo_t)* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY, sk_image_caching_hint_t cachingHint);
    bool sk_image_read_pixels_into_pixmap(const(sk_image_t)* image, const(sk_pixmap_t)* dst, int srcX, int srcY, sk_image_caching_hint_t cachingHint);
    void sk_image_ref(const(sk_image_t)*);
    sk_data_t* sk_image_ref_encoded(const(sk_image_t)*);
    bool sk_image_scale_pixels(const(sk_image_t)* image, const(sk_pixmap_t)* dst, sk_filter_quality_t quality, sk_image_caching_hint_t cachingHint);
    void sk_image_unref(const(sk_image_t)*);

    // sk_imagefilter.h
    void sk_imagefilter_croprect_destructor(sk_imagefilter_croprect_t* cropRect);
    uint32_t sk_imagefilter_croprect_get_flags(sk_imagefilter_croprect_t* cropRect);
    void sk_imagefilter_croprect_get_rect(sk_imagefilter_croprect_t* cropRect, sk_rect_t* rect);
    sk_imagefilter_croprect_t* sk_imagefilter_croprect_new();
    sk_imagefilter_croprect_t* sk_imagefilter_croprect_new_with_rect(const(sk_rect_t)* rect, uint32_t flags);
    sk_imagefilter_t* sk_imagefilter_new_alpha_threshold(const(sk_region_t)* region, float innerThreshold, float outerThreshold, sk_imagefilter_t* input);
    sk_imagefilter_t* sk_imagefilter_new_arithmetic(float k1, float k2, float k3, float k4, bool enforcePMColor, sk_imagefilter_t* background, sk_imagefilter_t* foreground, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_blur(float sigmaX, float sigmaY, sk_shader_tilemode_t tileMode, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_color_filter(sk_colorfilter_t* cf, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_compose(sk_imagefilter_t* outer, sk_imagefilter_t* inner);
    sk_imagefilter_t* sk_imagefilter_new_dilate(int radiusX, int radiusY, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_displacement_map_effect(sk_color_channel_t xChannelSelector, sk_color_channel_t yChannelSelector, float scale, sk_imagefilter_t* displacement, sk_imagefilter_t* color, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_distant_lit_diffuse(const(sk_point3_t)* direction, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_distant_lit_specular(const(sk_point3_t)* direction, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_drop_shadow(float dx, float dy, float sigmaX, float sigmaY, sk_color_t color, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_drop_shadow_only(float dx, float dy, float sigmaX, float sigmaY, sk_color_t color, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_erode(int radiusX, int radiusY, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_image_source(sk_image_t* image, const(sk_rect_t)* srcRect, const(sk_rect_t)* dstRect, sk_filter_quality_t filterQuality);
    sk_imagefilter_t* sk_imagefilter_new_image_source_default(sk_image_t* image);
    sk_imagefilter_t* sk_imagefilter_new_magnifier(const(sk_rect_t)* src, float inset, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_matrix(const(sk_matrix_t)* matrix, sk_filter_quality_t quality, sk_imagefilter_t* input);
    sk_imagefilter_t* sk_imagefilter_new_matrix_convolution(const(sk_isize_t)* kernelSize, const(float)* kernel, float gain, float bias, const(sk_ipoint_t)* kernelOffset, sk_shader_tilemode_t tileMode, bool convolveAlpha, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_merge(sk_imagefilter_t** filters, int count, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_offset(float dx, float dy, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_paint(const(sk_paint_t)* paint, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_picture(sk_picture_t* picture);
    sk_imagefilter_t* sk_imagefilter_new_picture_with_croprect(sk_picture_t* picture, const(sk_rect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_point_lit_diffuse(const(sk_point3_t)* location, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_point_lit_specular(const(sk_point3_t)* location, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_spot_lit_diffuse(const(sk_point3_t)* location, const(sk_point3_t)* target, float specularExponent, float cutoffAngle, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_spot_lit_specular(const(sk_point3_t)* location, const(sk_point3_t)* target, float specularExponent, float cutoffAngle, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const(sk_imagefilter_croprect_t)* cropRect);
    sk_imagefilter_t* sk_imagefilter_new_tile(const(sk_rect_t)* src, const(sk_rect_t)* dst, sk_imagefilter_t* input);
    sk_imagefilter_t* sk_imagefilter_new_xfermode(sk_blendmode_t mode, sk_imagefilter_t* background, sk_imagefilter_t* foreground, const(sk_imagefilter_croprect_t)* cropRect);
    void sk_imagefilter_unref(sk_imagefilter_t*);

    // sk_mask.h
    uint8_t* sk_mask_alloc_image(size_t bytes);
    size_t sk_mask_compute_image_size(sk_mask_t* cmask);
    size_t sk_mask_compute_total_image_size(sk_mask_t* cmask);
    void sk_mask_free_image(void* image);
    void* sk_mask_get_addr(sk_mask_t* cmask, int x, int y);
    uint8_t* sk_mask_get_addr_1(sk_mask_t* cmask, int x, int y);
    uint32_t* sk_mask_get_addr_32(sk_mask_t* cmask, int x, int y);
    uint8_t* sk_mask_get_addr_8(SKMask* cmask, int x, int y);
    uint16_t* sk_mask_get_addr_lcd_16(sk_mask_t* cmask, int x, int y);
    bool sk_mask_is_empty(sk_mask_t* cmask);

    // sk_maskfilter.h
    sk_maskfilter_t* sk_maskfilter_new_blur(sk_blurstyle_t, float sigma);
    sk_maskfilter_t* sk_maskfilter_new_blur_with_flags(sk_blurstyle_t, float sigma, bool respectCTM);
    sk_maskfilter_t* sk_maskfilter_new_clip(uint8_t min, uint8_t max);
    sk_maskfilter_t* sk_maskfilter_new_gamma(float gamma);
    sk_maskfilter_t* sk_maskfilter_new_shader(sk_shader_t* cshader);
    sk_maskfilter_t* sk_maskfilter_new_table(ubyte* table);
    void sk_maskfilter_ref(sk_maskfilter_t*);
    void sk_maskfilter_unref(sk_maskfilter_t*);

    // sk_matrix.h
    void sk_3dview_apply_to_canvas(sk_3dview_t* cview, sk_canvas_t* ccanvas);
    void sk_3dview_destroy(sk_3dview_t* cview);
    float sk_3dview_dot_with_normal(sk_3dview_t* cview, float dx, float dy, float dz);
    void sk_3dview_get_matrix(sk_3dview_t* cview, sk_matrix_t* cmatrix);
    sk_3dview_t* sk_3dview_new();
    void sk_3dview_restore(sk_3dview_t* cview);
    void sk_3dview_rotate_x_degrees(sk_3dview_t* cview, float degrees);
    void sk_3dview_rotate_x_radians(sk_3dview_t* cview, float radians);
    void sk_3dview_rotate_y_degrees(sk_3dview_t* cview, float degrees);
    void sk_3dview_rotate_y_radians(sk_3dview_t* cview, float radians);
    void sk_3dview_rotate_z_degrees(sk_3dview_t* cview, float degrees);
    void sk_3dview_rotate_z_radians(sk_3dview_t* cview, float radians);
    void sk_3dview_save(sk_3dview_t* cview);
    void sk_3dview_translate(sk_3dview_t* cview, float x, float y, float z);
    void sk_matrix_concat(sk_matrix_t* result, sk_matrix_t* first, sk_matrix_t* second);
    void sk_matrix_map_points(sk_matrix_t* matrix, sk_point_t* dst, sk_point_t* src, int count);
    float sk_matrix_map_radius(sk_matrix_t* matrix, float radius);
    void sk_matrix_map_rect(sk_matrix_t* matrix, sk_rect_t* dest, sk_rect_t* source);
    void sk_matrix_map_vector(sk_matrix_t* matrix, float x, float y, sk_point_t* result);
    void sk_matrix_map_vectors(sk_matrix_t* matrix, sk_point_t* dst, sk_point_t* src, int count);
    void sk_matrix_map_xy(sk_matrix_t* matrix, float x, float y, sk_point_t* result);
    void sk_matrix_post_concat(sk_matrix_t* result, sk_matrix_t* matrix);
    void sk_matrix_pre_concat(sk_matrix_t* result, sk_matrix_t* matrix);
    bool sk_matrix_try_invert(sk_matrix_t* matrix, sk_matrix_t* result);
    void sk_matrix44_as_col_major(sk_matrix44_t* matrix, float* dst);
    void sk_matrix44_as_row_major(sk_matrix44_t* matrix, float* dst);
    void sk_matrix44_destroy(sk_matrix44_t* matrix);
    double sk_matrix44_determinant(sk_matrix44_t* matrix);
    bool sk_matrix44_equals(sk_matrix44_t* matrix, const(sk_matrix44_t)* other);
    float sk_matrix44_get(sk_matrix44_t* matrix, int row, int col);
    sk_matrix44_type_mask_t sk_matrix44_get_type(sk_matrix44_t* matrix);
    bool sk_matrix44_invert(sk_matrix44_t* matrix, sk_matrix44_t* inverse);
    void sk_matrix44_map_scalars(sk_matrix44_t* matrix, const(float)* src, float* dst);
    void sk_matrix44_map2(sk_matrix44_t* matrix, const(float)* src2, int count, float* dst4);
    sk_matrix44_t* sk_matrix44_new();
    sk_matrix44_t* sk_matrix44_new_concat(const(sk_matrix44_t)* a, const(sk_matrix44_t)* b);
    sk_matrix44_t* sk_matrix44_new_copy(const(sk_matrix44_t)* src);
    sk_matrix44_t* sk_matrix44_new_identity();
    sk_matrix44_t* sk_matrix44_new_matrix(const(sk_matrix_t)* src);
    void sk_matrix44_post_concat(sk_matrix44_t* matrix, const(sk_matrix44_t)* m);
    void sk_matrix44_post_scale(sk_matrix44_t* matrix, float sx, float sy, float sz);
    void sk_matrix44_post_translate(sk_matrix44_t* matrix, float dx, float dy, float dz);
    void sk_matrix44_pre_concat(sk_matrix44_t* matrix, const(sk_matrix44_t)* m);
    void sk_matrix44_pre_scale(sk_matrix44_t* matrix, float sx, float sy, float sz);
    void sk_matrix44_pre_translate(sk_matrix44_t* matrix, float dx, float dy, float dz);
    bool sk_matrix44_preserves_2d_axis_alignment(sk_matrix44_t* matrix, float epsilon);
    void sk_matrix44_set(sk_matrix44_t* matrix, int row, int col, float value);
    void sk_matrix44_set_3x3_row_major(sk_matrix44_t* matrix, float* dst);
    void sk_matrix44_set_col_major(sk_matrix44_t* matrix, float* dst);
    void sk_matrix44_set_concat(sk_matrix44_t* matrix, const(sk_matrix44_t)* a, const(sk_matrix44_t)* b);
    void sk_matrix44_set_identity(sk_matrix44_t* matrix);
    void sk_matrix44_set_rotate_about_degrees(sk_matrix44_t* matrix, float x, float y, float z, float degrees);
    void sk_matrix44_set_rotate_about_radians(sk_matrix44_t* matrix, float x, float y, float z, float radians);
    void sk_matrix44_set_rotate_about_radians_unit(sk_matrix44_t* matrix, float x, float y, float z, float radians);
    void sk_matrix44_set_row_major(sk_matrix44_t* matrix, float* dst);
    void sk_matrix44_set_scale(sk_matrix44_t* matrix, float sx, float sy, float sz);
    void sk_matrix44_set_translate(sk_matrix44_t* matrix, float dx, float dy, float dz);
    void sk_matrix44_to_matrix(sk_matrix44_t* matrix, sk_matrix_t* dst);
    void sk_matrix44_transpose(sk_matrix44_t* matrix);

    // sk_paint.h
    sk_paint_t* sk_paint_clone(sk_paint_t*);
    void sk_paint_delete(sk_paint_t*);
    sk_blendmode_t sk_paint_get_blendmode(sk_paint_t*);
    sk_color_t sk_paint_get_color(const(sk_paint_t)*);
    void sk_paint_get_color4f(const(sk_paint_t)* paint, sk_color4f_t* color);
    sk_colorfilter_t* sk_paint_get_colorfilter(sk_paint_t*);
    bool sk_paint_get_fill_path(const(sk_paint_t)*, const(sk_path_t)* src, sk_path_t* dst, const(sk_rect_t)* cullRect, float resScale);
    sk_filter_quality_t sk_paint_get_filter_quality(sk_paint_t*);
    sk_imagefilter_t* sk_paint_get_imagefilter(sk_paint_t*);
    sk_maskfilter_t* sk_paint_get_maskfilter(sk_paint_t*);
    sk_path_effect_t* sk_paint_get_path_effect(sk_paint_t* cpaint);
    sk_shader_t* sk_paint_get_shader(sk_paint_t*);
    sk_stroke_cap_t sk_paint_get_stroke_cap(const(sk_paint_t)*);
    sk_stroke_join_t sk_paint_get_stroke_join(const(sk_paint_t)*);
    float sk_paint_get_stroke_miter(const(sk_paint_t)*);
    float sk_paint_get_stroke_width(const(sk_paint_t)*);
    sk_paint_style_t sk_paint_get_style(const(sk_paint_t)*);
    bool sk_paint_is_antialias(const(sk_paint_t)*);
    bool sk_paint_is_dither(const(sk_paint_t)*);
    sk_paint_t* sk_paint_new();
    void sk_paint_reset(sk_paint_t*);
    void sk_paint_set_antialias(sk_paint_t*, bool);
    void sk_paint_set_blendmode(sk_paint_t*, sk_blendmode_t);
    void sk_paint_set_color(sk_paint_t*, sk_color_t);
    void sk_paint_set_color4f(sk_paint_t* paint, sk_color4f_t* color, sk_colorspace_t* colorspace);
    void sk_paint_set_colorfilter(sk_paint_t*, sk_colorfilter_t*);
    void sk_paint_set_dither(sk_paint_t*, bool);
    void sk_paint_set_filter_quality(sk_paint_t*, sk_filter_quality_t);
    void sk_paint_set_imagefilter(sk_paint_t*, sk_imagefilter_t*);
    void sk_paint_set_maskfilter(sk_paint_t*, sk_maskfilter_t*);
    void sk_paint_set_path_effect(sk_paint_t* cpaint, sk_path_effect_t* effect);
    void sk_paint_set_shader(sk_paint_t*, sk_shader_t*);
    void sk_paint_set_stroke_cap(sk_paint_t*, sk_stroke_cap_t);
    void sk_paint_set_stroke_join(sk_paint_t*, sk_stroke_join_t);
    void sk_paint_set_stroke_miter(sk_paint_t*, float miter);
    void sk_paint_set_stroke_width(sk_paint_t*, float width);
    void sk_paint_set_style(sk_paint_t*, sk_paint_style_t);

    // sk_path.h
    void sk_opbuilder_add(sk_opbuilder_t* builder, const(sk_path_t)* path, sk_pathop_t op);
    void sk_opbuilder_destroy(sk_opbuilder_t* builder);
    sk_opbuilder_t* sk_opbuilder_new();
    bool sk_opbuilder_resolve(sk_opbuilder_t* builder, sk_path_t* result);
    void sk_path_add_arc(sk_path_t* cpath, const(sk_rect_t)* crect, float startAngle, float sweepAngle);
    void sk_path_add_circle(sk_path_t*, float x, float y, float radius, sk_path_direction_t dir);
    void sk_path_add_oval(sk_path_t*, const(sk_rect_t)*, sk_path_direction_t);
    void sk_path_add_path(sk_path_t* cpath, sk_path_t* other, sk_path_add_mode_t add_mode);
    void sk_path_add_path_matrix(sk_path_t* cpath, sk_path_t* other, sk_matrix_t* matrix, sk_path_add_mode_t add_mode);
    void sk_path_add_path_offset(sk_path_t* cpath, sk_path_t* other, float dx, float dy, sk_path_add_mode_t add_mode);
    void sk_path_add_path_reverse(sk_path_t* cpath, sk_path_t* other);
    void sk_path_add_poly(sk_path_t* cpath, const(sk_point_t)* points, int count, bool close);
    void sk_path_add_rect(sk_path_t*, const(sk_rect_t)*, sk_path_direction_t);
    void sk_path_add_rect_start(sk_path_t* cpath, const(sk_rect_t)* crect, sk_path_direction_t cdir, uint32_t startIndex);
    void sk_path_add_rounded_rect(sk_path_t*, const(sk_rect_t)*, float, float, sk_path_direction_t);
    void sk_path_add_rrect(sk_path_t*, const(sk_rrect_t)*, sk_path_direction_t);
    void sk_path_add_rrect_start(sk_path_t*, const(sk_rrect_t)*, sk_path_direction_t, uint32_t);
    void sk_path_arc_to(sk_path_t*, float rx, float ry, float xAxisRotate, sk_path_arc_size_t largeArc, sk_path_direction_t sweep, float x, float y);
    void sk_path_arc_to_with_oval(sk_path_t*, const(sk_rect_t)* oval, float startAngle, float sweepAngle, bool forceMoveTo);
    void sk_path_arc_to_with_points(sk_path_t*, float x1, float y1, float x2, float y2, float radius);
    sk_path_t* sk_path_clone(const(sk_path_t)* cpath);
    void sk_path_close(sk_path_t*);
    void sk_path_compute_tight_bounds(const(sk_path_t)*, sk_rect_t*);
    void sk_path_conic_to(sk_path_t*, float x0, float y0, float x1, float y1, float w);
    bool sk_path_contains(const(sk_path_t)* cpath, float x, float y);
    int sk_path_convert_conic_to_quads(const(sk_point_t)* p0, const(sk_point_t)* p1, const(sk_point_t)* p2, float w, sk_point_t* pts, int pow2);
    int sk_path_count_points(const(sk_path_t)* cpath);
    int sk_path_count_verbs(const(sk_path_t)* cpath);
    sk_path_iterator_t* sk_path_create_iter(sk_path_t* cpath, int forceClose);
    sk_path_rawiterator_t* sk_path_create_rawiter(sk_path_t* cpath);
    void sk_path_cubic_to(sk_path_t*, float x0, float y0, float x1, float y1, float x2, float y2);
    void sk_path_delete(sk_path_t*);
    void sk_path_get_bounds(const(sk_path_t)*, sk_rect_t*);
    sk_path_convexity_t sk_path_get_convexity(const(sk_path_t)* cpath);
    sk_path_filltype_t sk_path_get_filltype(sk_path_t*);
    bool sk_path_get_last_point(const(sk_path_t)* cpath, sk_point_t* point);
    void sk_path_get_point(const(sk_path_t)* cpath, int index, sk_point_t* point);
    int sk_path_get_points(const(sk_path_t)* cpath, sk_point_t* points, int max);
    uint32_t sk_path_get_segment_masks(sk_path_t* cpath);
    bool sk_path_is_line(sk_path_t* cpath, sk_point_t* line);
    bool sk_path_is_oval(sk_path_t* cpath, sk_rect_t* bounds);
    bool sk_path_is_rect(sk_path_t* cpath, sk_rect_t* rect, bool* isClosed, sk_path_direction_t* direction);
    bool sk_path_is_rrect(sk_path_t* cpath, sk_rrect_t* bounds);
    float sk_path_iter_conic_weight(sk_path_iterator_t* iterator);
    void sk_path_iter_destroy(sk_path_iterator_t* iterator);
    int sk_path_iter_is_close_line(sk_path_iterator_t* iterator);
    int sk_path_iter_is_closed_contour(sk_path_iterator_t* iterator);
    sk_path_verb_t sk_path_iter_next(sk_path_iterator_t* iterator, sk_point_t* points);
    void sk_path_line_to(sk_path_t*, float x, float y);
    void sk_path_move_to(sk_path_t*, float x, float y);
    sk_path_t* sk_path_new();
    bool sk_path_parse_svg_string(sk_path_t* cpath, const(char)* str);
    void sk_path_quad_to(sk_path_t*, float x0, float y0, float x1, float y1);
    void sk_path_rarc_to(sk_path_t*, float rx, float ry, float xAxisRotate, sk_path_arc_size_t largeArc, sk_path_direction_t sweep, float x, float y);
    float sk_path_rawiter_conic_weight(sk_path_rawiterator_t* iterator);
    void sk_path_rawiter_destroy(sk_path_rawiterator_t* iterator);
    sk_path_verb_t sk_path_rawiter_next(sk_path_rawiterator_t* iterator, sk_point_t* points);
    sk_path_verb_t sk_path_rawiter_peek(sk_path_rawiterator_t* iterator);
    void sk_path_rconic_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1, float w);
    void sk_path_rcubic_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1, float dx2, float dy2);
    void sk_path_reset(sk_path_t* cpath);
    void sk_path_rewind(sk_path_t* cpath);
    void sk_path_rline_to(sk_path_t*, float dx, float yd);
    void sk_path_rmove_to(sk_path_t*, float dx, float dy);
    void sk_path_rquad_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1);
    void sk_path_set_convexity(sk_path_t* cpath, sk_path_convexity_t convexity);
    void sk_path_set_filltype(sk_path_t*, sk_path_filltype_t);
    void sk_path_to_svg_string(const(sk_path_t)* cpath, sk_string_t* str);
    void sk_path_transform(sk_path_t* cpath, const(sk_matrix_t)* cmatrix);
    void sk_path_transform_to_dest(const(sk_path_t)* cpath, const(sk_matrix_t)* cmatrix, sk_path_t* destination);
    void sk_pathmeasure_destroy(sk_pathmeasure_t* pathMeasure);
    float sk_pathmeasure_get_length(sk_pathmeasure_t* pathMeasure);
    bool sk_pathmeasure_get_matrix(sk_pathmeasure_t* pathMeasure, float distance, sk_matrix_t* matrix, sk_pathmeasure_matrixflags_t flags);
    bool sk_pathmeasure_get_pos_tan(sk_pathmeasure_t* pathMeasure, float distance, sk_point_t* position, sk_vector_t* tangent);
    bool sk_pathmeasure_get_segment(sk_pathmeasure_t* pathMeasure, float start, float stop, sk_path_t* dst, bool startWithMoveTo);
    bool sk_pathmeasure_is_closed(sk_pathmeasure_t* pathMeasure);
    sk_pathmeasure_t* sk_pathmeasure_new();
    sk_pathmeasure_t* sk_pathmeasure_new_with_path(const(sk_path_t)* path, bool forceClosed, float resScale);
    bool sk_pathmeasure_next_contour(sk_pathmeasure_t* pathMeasure);
    void sk_pathmeasure_set_path(sk_pathmeasure_t* pathMeasure, const(sk_path_t)* path, bool forceClosed);
    bool sk_pathop_as_winding(const(sk_path_t)* path, sk_path_t* result);
    bool sk_pathop_op(const(sk_path_t)* one, const(sk_path_t)* two, sk_pathop_t op, sk_path_t* result);
    bool sk_pathop_simplify(const(sk_path_t)* path, sk_path_t* result);
    bool sk_pathop_tight_bounds(const(sk_path_t)* path, sk_rect_t* result);

    // sk_patheffect.h
    sk_path_effect_t* sk_path_effect_create_1d_path(const(sk_path_t)* path, float advance, float phase, sk_path_effect_1d_style_t style);
    sk_path_effect_t* sk_path_effect_create_2d_line(float width, const(sk_matrix_t)* matrix);
    sk_path_effect_t* sk_path_effect_create_2d_path(const(sk_matrix_t)* matrix, const(sk_path_t)* path);
    sk_path_effect_t* sk_path_effect_create_compose(sk_path_effect_t* outer, sk_path_effect_t* inner);
    sk_path_effect_t* sk_path_effect_create_corner(float radius);
    sk_path_effect_t* sk_path_effect_create_dash(const(float)* intervals, int count, float phase);
    sk_path_effect_t* sk_path_effect_create_discrete(float segLength, float deviation, uint32_t seedAssist);
    sk_path_effect_t* sk_path_effect_create_sum(sk_path_effect_t* first, sk_path_effect_t* second);
    sk_path_effect_t* sk_path_effect_create_trim(float start, float stop, sk_path_effect_trim_mode_t mode);
    void sk_path_effect_unref(sk_path_effect_t* t);

    // sk_picture.h
    // sk_picture_t* sk_picture_deserialize_from_data(sk_data_t* data);
    // sk_picture_t* sk_picture_deserialize_from_memory(void* buffer, size_t length);
    // sk_picture_t* sk_picture_deserialize_from_stream(sk_stream_t* stream);
    void sk_picture_get_cull_rect(sk_picture_t*, sk_rect_t*);
    sk_canvas_t* sk_picture_get_recording_canvas(sk_picture_recorder_t* crec);
    uint32_t sk_picture_get_unique_id(sk_picture_t*);
    sk_shader_t* sk_picture_make_shader(sk_picture_t* src, sk_shader_tilemode_t tmx, sk_shader_tilemode_t tmy, const(sk_matrix_t)* localMatrix, const(sk_rect_t)* tile);
    sk_canvas_t* sk_picture_recorder_begin_recording(sk_picture_recorder_t*, const(sk_rect_t)*);
    void sk_picture_recorder_delete(sk_picture_recorder_t*);
    sk_picture_t* sk_picture_recorder_end_recording(sk_picture_recorder_t*);
    sk_drawable_t* sk_picture_recorder_end_recording_as_drawable(sk_picture_recorder_t*);
    sk_picture_recorder_t* sk_picture_recorder_new();
    void sk_picture_ref(sk_picture_t*);
    // sk_data_t* sk_picture_serialize_to_data(const(sk_picture_t)* picture);
    // void sk_picture_serialize_to_stream(const(sk_picture_t)* picture, sk_wstream_t* stream);
    void sk_picture_unref(sk_picture_t*);

    // sk_pixmap.h
    void sk_color_get_bit_shift(int* a, int* r, int* g, int* b);
    sk_pmcolor_t sk_color_premultiply(const sk_color_t color);
    void sk_color_premultiply_array(const(sk_color_t)* colors, int size, sk_pmcolor_t* pmcolors);
    sk_color_t sk_color_unpremultiply(const sk_pmcolor_t pmcolor);
    void sk_color_unpremultiply_array(const(sk_pmcolor_t)* pmcolors, int size, sk_color_t* colors);
    bool sk_jpegencoder_encode(sk_wstream_t* dst, const(sk_pixmap_t)* src, const(sk_jpegencoder_options_t)* options);
    void sk_pixmap_destructor(sk_pixmap_t* cpixmap);
    bool sk_pixmap_encode_image(sk_wstream_t* dst, const(sk_pixmap_t)* src, sk_encoded_image_format_t encoder, int quality);
    bool sk_pixmap_erase_color(const(sk_pixmap_t)* cpixmap, sk_color_t color, const(sk_irect_t)* subset);
    bool sk_pixmap_erase_color4f(const(sk_pixmap_t)* cpixmap, const(sk_color4f_t)* color, const(sk_irect_t)* subset);
    bool sk_pixmap_extract_subset(const(sk_pixmap_t)* cpixmap, sk_pixmap_t* result, const(sk_irect_t)* subset);
    void sk_pixmap_get_info(const(sk_pixmap_t)* cpixmap, sk_imageinfo_t* cinfo);
    sk_color_t sk_pixmap_get_pixel_color(const(sk_pixmap_t)* cpixmap, int x, int y);
    const(void)* sk_pixmap_get_pixels(const(sk_pixmap_t)* cpixmap);
    const(void)* sk_pixmap_get_pixels_with_xy(const(sk_pixmap_t)* cpixmap, int x, int y);
    size_t sk_pixmap_get_row_bytes(const(sk_pixmap_t)* cpixmap);
    void* sk_pixmap_get_writable_addr(const(sk_pixmap_t)* cpixmap);
    sk_pixmap_t* sk_pixmap_new();
    sk_pixmap_t* sk_pixmap_new_with_params(const(sk_imageinfo_t)* cinfo, const(void)* addr, size_t rowBytes);
    bool sk_pixmap_read_pixels(const(sk_pixmap_t)* cpixmap, const(sk_imageinfo_t)* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY);
    void sk_pixmap_reset(sk_pixmap_t* cpixmap);
    void sk_pixmap_reset_with_params(sk_pixmap_t* cpixmap, const(sk_imageinfo_t)* cinfo, const(void)* addr, size_t rowBytes);
    bool sk_pixmap_scale_pixels(const(sk_pixmap_t)* cpixmap, const(sk_pixmap_t)* dst, sk_filter_quality_t quality);
    bool sk_pngencoder_encode(sk_wstream_t* dst, const(sk_pixmap_t)* src, const(sk_pngencoder_options_t)* options);
    void sk_swizzle_swap_rb(uint32_t* dest, const(uint32_t)* src, int count);
    bool sk_webpencoder_encode(sk_wstream_t* dst, const(sk_pixmap_t)* src, const(sk_webpencoder_options_t)* options);

    // sk_region.h
    void sk_region_cliperator_delete(sk_region_cliperator_t* iter);
    bool sk_region_cliperator_done(sk_region_cliperator_t* iter);
    sk_region_cliperator_t* sk_region_cliperator_new(const(sk_region_t)* region, const(sk_irect_t)* clip);
    void sk_region_cliperator_next(sk_region_cliperator_t* iter);
    void sk_region_cliperator_rect(const(sk_region_cliperator_t)* iter, sk_irect_t* rect);
    bool sk_region_contains(const(sk_region_t)* r, const(sk_region_t)* region);
    bool sk_region_contains_point(const(sk_region_t)* r, int x, int y);
    bool sk_region_contains_rect(const(sk_region_t)* r, const(sk_irect_t)* rect);
    void sk_region_delete(sk_region_t* r);
    bool sk_region_get_boundary_path(const(sk_region_t)* r, sk_path_t* path);
    void sk_region_get_bounds(const(sk_region_t)* r, sk_irect_t* rect);
    bool sk_region_intersects(const(sk_region_t)* r, const(sk_region_t)* src);
    bool sk_region_intersects_rect(const(sk_region_t)* r, const(sk_irect_t)* rect);
    bool sk_region_is_complex(const(sk_region_t)* r);
    bool sk_region_is_empty(const(sk_region_t)* r);
    bool sk_region_is_rect(const(sk_region_t)* r);
    void sk_region_iterator_delete(sk_region_iterator_t* iter);
    bool sk_region_iterator_done(const(sk_region_iterator_t)* iter);
    sk_region_iterator_t* sk_region_iterator_new(const(sk_region_t)* region);
    void sk_region_iterator_next(sk_region_iterator_t* iter);
    void sk_region_iterator_rect(const(sk_region_iterator_t)* iter, sk_irect_t* rect);
    bool sk_region_iterator_rewind(sk_region_iterator_t* iter);
    sk_region_t* sk_region_new();
    bool sk_region_op(sk_region_t* r, const(sk_region_t)* region, sk_region_op_t op);
    bool sk_region_op_rect(sk_region_t* r, const(sk_irect_t)* rect, sk_region_op_t op);
    bool sk_region_quick_contains(const(sk_region_t)* r, const(sk_irect_t)* rect);
    bool sk_region_quick_reject(const(sk_region_t)* r, const(sk_region_t)* region);
    bool sk_region_quick_reject_rect(const(sk_region_t)* r, const(sk_irect_t)* rect);
    bool sk_region_set_empty(sk_region_t* r);
    bool sk_region_set_path(sk_region_t* r, const(sk_path_t)* t, const(sk_region_t)* clip);
    bool sk_region_set_rect(sk_region_t* r, const(sk_irect_t)* rect);
    bool sk_region_set_rects(sk_region_t* r, const(sk_irect_t)* rects, int count);
    bool sk_region_set_region(sk_region_t* r, const(sk_region_t)* region);
    void sk_region_spanerator_delete(sk_region_spanerator_t* iter);
    sk_region_spanerator_t* sk_region_spanerator_new(const(sk_region_t)* region, int y, int left, int right);
    bool sk_region_spanerator_next(sk_region_spanerator_t* iter, int* left, int* right);
    void sk_region_translate(sk_region_t* r, int x, int y);

    // sk_rrect.h
    bool sk_rrect_contains(const(sk_rrect_t)* rrect, const(sk_rect_t)* rect);
    void sk_rrect_delete(const(sk_rrect_t)* rrect);
    float sk_rrect_get_height(const(sk_rrect_t)* rrect);
    void sk_rrect_get_radii(const(sk_rrect_t)* rrect, sk_rrect_corner_t corner, sk_vector_t* radii);
    void sk_rrect_get_rect(const(sk_rrect_t)* rrect, sk_rect_t* rect);
    sk_rrect_type_t sk_rrect_get_type(const(sk_rrect_t)* rrect);
    float sk_rrect_get_width(const(sk_rrect_t)* rrect);
    void sk_rrect_inset(sk_rrect_t* rrect, float dx, float dy);
    bool sk_rrect_is_valid(const(sk_rrect_t)* rrect);
    sk_rrect_t* sk_rrect_new();
    sk_rrect_t* sk_rrect_new_copy(const(sk_rrect_t)* rrect);
    void sk_rrect_offset(sk_rrect_t* rrect, float dx, float dy);
    void sk_rrect_outset(sk_rrect_t* rrect, float dx, float dy);
    void sk_rrect_set_empty(sk_rrect_t* rrect);
    void sk_rrect_set_nine_patch(sk_rrect_t* rrect, const(sk_rect_t)* rect, float leftRad, float topRad, float rightRad, float bottomRad);
    void sk_rrect_set_oval(sk_rrect_t* rrect, const(sk_rect_t)* rect);
    void sk_rrect_set_rect(sk_rrect_t* rrect, const(sk_rect_t)* rect);
    void sk_rrect_set_rect_radii(sk_rrect_t* rrect, const(sk_rect_t)* rect, const(sk_vector_t)* radii);
    void sk_rrect_set_rect_xy(sk_rrect_t* rrect, const(sk_rect_t)* rect, float xRad, float yRad);
    bool sk_rrect_transform(sk_rrect_t* rrect, const(sk_matrix_t)* matrix, sk_rrect_t* dest);

    // sk_runtimeeffect.h
    // void sk_runtimeeffect_get_child_name(const(sk_runtimeeffect_t)* effect, int index, sk_string_t* name);
    // size_t sk_runtimeeffect_get_children_count(const(sk_runtimeeffect_t)* effect);
    // const(sk_runtimeeffect_variable_t)* sk_runtimeeffect_get_input_from_index(const(sk_runtimeeffect_t)* effect, int index);
    // const(sk_runtimeeffect_variable_t)* sk_runtimeeffect_get_input_from_name(const(sk_runtimeeffect_t)* effect, const(char)* name, size_t len);
    // void sk_runtimeeffect_get_input_name(const(sk_runtimeeffect_t)* effect, int index, sk_string_t* name);
    // size_t sk_runtimeeffect_get_input_size(const(sk_runtimeeffect_t)* effect);
    // size_t sk_runtimeeffect_get_inputs_count(const(sk_runtimeeffect_t)* effect);
    // sk_runtimeeffect_t* sk_runtimeeffect_make(sk_string_t* sksl, sk_string_t* error);
    // sk_colorfilter_t* sk_runtimeeffect_make_color_filter(sk_runtimeeffect_t* effect, sk_data_t* inputs, sk_colorfilter_t** children, size_t childCount);
    // sk_shader_t* sk_runtimeeffect_make_shader(sk_runtimeeffect_t* effect, sk_data_t* inputs, sk_shader_t** children, size_t childCount, const(sk_matrix_t)* localMatrix, bool isOpaque);
    // void sk_runtimeeffect_unref(sk_runtimeeffect_t* effect);
    // size_t sk_runtimeeffect_variable_get_offset(const(sk_runtimeeffect_variable_t)* variable);
    // size_t sk_runtimeeffect_variable_get_size_in_bytes(const(sk_runtimeeffect_variable_t)* variable);

    // sk_shader.h
    sk_shader_t* sk_shader_new_blend(sk_blendmode_t mode, const(sk_shader_t)* dst, const(sk_shader_t)* src);
    sk_shader_t* sk_shader_new_color(sk_color_t color);
    sk_shader_t* sk_shader_new_color4f(const(sk_color4f_t)* color, const(sk_colorspace_t)* colorspace);
    sk_shader_t* sk_shader_new_empty();
    sk_shader_t* sk_shader_new_lerp(float t, const(sk_shader_t)* dst, const(sk_shader_t)* src);
    sk_shader_t* sk_shader_new_linear_gradient(const(sk_point_t)* points, const(sk_color_t)* colors, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_linear_gradient_color4f(const(sk_point_t)* points, const(sk_color4f_t)* colors, const(sk_colorspace_t)* colorspace, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_perlin_noise_fractal_noise(float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, const(sk_isize_t)* tileSize);
    sk_shader_t* sk_shader_new_perlin_noise_improved_noise(float baseFrequencyX, float baseFrequencyY, int numOctaves, float z);
    sk_shader_t* sk_shader_new_perlin_noise_turbulence(float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, const(sk_isize_t)* tileSize);
    sk_shader_t* sk_shader_new_radial_gradient(const(sk_point_t)* center, float radius, const(sk_color_t)* colors, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_radial_gradient_color4f(const(sk_point_t)* center, float radius, const(sk_color4f_t)* colors, const(sk_colorspace_t)* colorspace, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_sweep_gradient(const(sk_point_t)* center, const(sk_color_t)* colors, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, float startAngle, float endAngle, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_sweep_gradient_color4f(const(sk_point_t)* center, const(sk_color4f_t)* colors, const(sk_colorspace_t)* colorspace, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, float startAngle, float endAngle, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_two_point_conical_gradient(const(sk_point_t)* start, float startRadius, const(sk_point_t)* end, float endRadius, const(sk_color_t)* colors, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    sk_shader_t* sk_shader_new_two_point_conical_gradient_color4f(const(sk_point_t)* start, float startRadius, const(sk_point_t)* end, float endRadius, const(sk_color4f_t)* colors, const(sk_colorspace_t)* colorspace, const(float)* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const(sk_matrix_t)* localMatrix);
    void sk_shader_ref(sk_shader_t* shader);
    void sk_shader_unref(sk_shader_t* shader);
    sk_shader_t* sk_shader_with_color_filter(const(sk_shader_t)* shader, const(sk_colorfilter_t)* filter);
    sk_shader_t* sk_shader_with_local_matrix(const(sk_shader_t)* shader, const(sk_matrix_t)* localMatrix);

    // sk_stream.h
    void sk_dynamicmemorywstream_copy_to(sk_wstream_dynamicmemorystream_t* cstream, void* data);
    void sk_dynamicmemorywstream_destroy(sk_wstream_dynamicmemorystream_t* cstream);
    sk_data_t* sk_dynamicmemorywstream_detach_as_data(sk_wstream_dynamicmemorystream_t* cstream);
    sk_stream_asset_t* sk_dynamicmemorywstream_detach_as_stream(sk_wstream_dynamicmemorystream_t* cstream);
    sk_wstream_dynamicmemorystream_t* sk_dynamicmemorywstream_new();
    bool sk_dynamicmemorywstream_write_to_stream(sk_wstream_dynamicmemorystream_t* cstream, sk_wstream_t* dst);
    void sk_filestream_destroy(sk_stream_filestream_t* cstream);
    bool sk_filestream_is_valid(sk_stream_filestream_t* cstream);
    sk_stream_filestream_t* sk_filestream_new(const(char)* path);
    void sk_filewstream_destroy(sk_wstream_filestream_t* cstream);
    bool sk_filewstream_is_valid(sk_wstream_filestream_t* cstream);
    sk_wstream_filestream_t* sk_filewstream_new(const(char)* path);
    void sk_memorystream_destroy(sk_stream_memorystream_t* cstream);
    sk_stream_memorystream_t* sk_memorystream_new();
    sk_stream_memorystream_t* sk_memorystream_new_with_data(const(void)* data, size_t length, bool copyData);
    sk_stream_memorystream_t* sk_memorystream_new_with_length(size_t length);
    sk_stream_memorystream_t* sk_memorystream_new_with_skdata(sk_data_t* data);
    void sk_memorystream_set_memory(sk_stream_memorystream_t* cmemorystream, const(void)* data, size_t length, bool copyData);
    void sk_stream_asset_destroy(sk_stream_asset_t* cstream);
    void sk_stream_destroy(sk_stream_t* cstream);
    sk_stream_t* sk_stream_duplicate(sk_stream_t* cstream);
    sk_stream_t* sk_stream_fork(sk_stream_t* cstream);
    size_t sk_stream_get_length(sk_stream_t* cstream);
    const(void)* sk_stream_get_memory_base(sk_stream_t* cstream);
    size_t sk_stream_get_position(sk_stream_t* cstream);
    bool sk_stream_has_length(sk_stream_t* cstream);
    bool sk_stream_has_position(sk_stream_t* cstream);
    bool sk_stream_is_at_end(sk_stream_t* cstream);
    bool sk_stream_move(sk_stream_t* cstream, int offset);
    size_t sk_stream_peek(sk_stream_t* cstream, void* buffer, size_t size);
    size_t sk_stream_read(sk_stream_t* cstream, void* buffer, size_t size);
    bool sk_stream_read_bool(sk_stream_t* cstream, bool* buffer);
    bool sk_stream_read_s16(sk_stream_t* cstream, int16_t* buffer);
    bool sk_stream_read_s32(sk_stream_t* cstream, int32_t* buffer);
    bool sk_stream_read_s8(sk_stream_t* cstream, int8_t* buffer);
    bool sk_stream_read_u16(sk_stream_t* cstream, uint16_t* buffer);
    bool sk_stream_read_u32(sk_stream_t* cstream, uint32_t* buffer);
    bool sk_stream_read_u8(sk_stream_t* cstream, ubyte* buffer);
    bool sk_stream_rewind(sk_stream_t* cstream);
    bool sk_stream_seek(sk_stream_t* cstream, size_t position);
    size_t sk_stream_skip(sk_stream_t* cstream, size_t size);
    size_t sk_wstream_bytes_written(sk_wstream_t* cstream);
    void sk_wstream_flush(sk_wstream_t* cstream);
    int sk_wstream_get_size_of_packed_uint(size_t value);
    bool sk_wstream_newline(sk_wstream_t* cstream);
    bool sk_wstream_write(sk_wstream_t* cstream, const(void)* buffer, size_t size);
    bool sk_wstream_write_16(sk_wstream_t* cstream, uint16_t value);
    bool sk_wstream_write_32(sk_wstream_t* cstream, uint32_t value);
    bool sk_wstream_write_8(sk_wstream_t* cstream, uint8_t value);
    bool sk_wstream_write_bigdec_as_text(sk_wstream_t* cstream, int64_t value, int minDigits);
    bool sk_wstream_write_bool(sk_wstream_t* cstream, bool value);
    bool sk_wstream_write_dec_as_text(sk_wstream_t* cstream, int32_t value);
    bool sk_wstream_write_hex_as_text(sk_wstream_t* cstream, uint32_t value, int minDigits);
    bool sk_wstream_write_packed_uint(sk_wstream_t* cstream, size_t value);
    bool sk_wstream_write_scalar(sk_wstream_t* cstream, float value);
    bool sk_wstream_write_scalar_as_text(sk_wstream_t* cstream, float value);
    bool sk_wstream_write_stream(sk_wstream_t* cstream, sk_stream_t* input, size_t length);
    bool sk_wstream_write_text(sk_wstream_t* cstream, const(char)* value);

    // sk_string.h
    void sk_string_destructor(const(sk_string_t)*);
    const(char)* sk_string_get_c_str(const(sk_string_t)*);
    size_t sk_string_get_size(const(sk_string_t)*);
    sk_string_t* sk_string_new_empty();
    sk_string_t* sk_string_new_with_copy(const(char)* src, size_t length);

    // sk_surface.h
    void sk_surface_draw(sk_surface_t* surface, sk_canvas_t* canvas, float x, float y, const(sk_paint_t)* paint);
    sk_canvas_t* sk_surface_get_canvas(sk_surface_t*);
    const(sk_surfaceprops_t)* sk_surface_get_props(sk_surface_t* surface);
    sk_surface_t* sk_surface_new_backend_render_target(gr_context_t* context, const(gr_backendrendertarget_t)* target, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_colorspace_t* colorspace, const(sk_surfaceprops_t)* props);
    sk_surface_t* sk_surface_new_backend_texture(gr_context_t* context, const(gr_backendtexture_t)* texture, gr_surfaceorigin_t origin, int samples, sk_colortype_t colorType, sk_colorspace_t* colorspace, const(sk_surfaceprops_t)* props);
    sk_surface_t* sk_surface_new_backend_texture_as_render_target(gr_context_t* context, const(gr_backendtexture_t)* texture, gr_surfaceorigin_t origin, int samples, sk_colortype_t colorType, sk_colorspace_t* colorspace, const(sk_surfaceprops_t)* props);
    sk_image_t* sk_surface_new_image_snapshot(sk_surface_t*);
    sk_image_t* sk_surface_new_image_snapshot_with_crop(sk_surface_t* surface, const(sk_irect_t)* bounds);
    sk_surface_t* sk_surface_new_null(int width, int height);
    sk_surface_t* sk_surface_new_raster(const(sk_imageinfo_t)*, size_t rowBytes, const(sk_surfaceprops_t)*);
    sk_surface_t* sk_surface_new_raster_direct(const(sk_imageinfo_t)*, void* pixels, size_t rowBytes, const sk_surface_raster_release_proc releaseProc, void* context, const(sk_surfaceprops_t)* props);
    sk_surface_t* sk_surface_new_render_target(gr_context_t* context, bool budgeted, const(sk_imageinfo_t)* cinfo, int sampleCount, gr_surfaceorigin_t origin, const(sk_surfaceprops_t)* props, bool shouldCreateWithMips);
    bool sk_surface_peek_pixels(sk_surface_t* surface, sk_pixmap_t* pixmap);
    bool sk_surface_read_pixels(sk_surface_t* surface, sk_imageinfo_t* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY);
    void sk_surface_unref(sk_surface_t*);
    void sk_surfaceprops_delete(sk_surfaceprops_t* props);
    uint32_t sk_surfaceprops_get_flags(sk_surfaceprops_t* props);
    sk_pixelgeometry_t sk_surfaceprops_get_pixel_geometry(sk_surfaceprops_t* props);
    sk_surfaceprops_t* sk_surfaceprops_new(uint32_t flags, sk_pixelgeometry_t geometry);

    // sk_svg.h
    sk_canvas_t* sk_svgcanvas_create_with_stream(const(sk_rect_t)* bounds, sk_wstream_t* stream);
    sk_canvas_t* sk_svgcanvas_create_with_writer(const(sk_rect_t)* bounds, sk_xmlwriter_t* writer);

    // sk_textblob.h
    void sk_textblob_builder_alloc_run(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, float x, float y, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_pos(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_pos_h(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, float y, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_rsxform(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_text(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, float x, float y, int textByteCount, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_text_pos(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, int textByteCount, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_alloc_run_text_pos_h(sk_textblob_builder_t* builder, const(sk_font_t)* font, int count, float y, int textByteCount, const(sk_rect_t)* bounds, sk_textblob_builder_runbuffer_t* runbuffer);
    void sk_textblob_builder_delete(sk_textblob_builder_t* builder);
    sk_textblob_t* sk_textblob_builder_make(sk_textblob_builder_t* builder);
    sk_textblob_builder_t* sk_textblob_builder_new();
    void sk_textblob_get_bounds(const(sk_textblob_t)* blob, sk_rect_t* bounds);
    int sk_textblob_get_intercepts(const(sk_textblob_t)* blob, const(float)* bounds, float* intervals, const(sk_paint_t)* paint);
    uint32_t sk_textblob_get_unique_id(const(sk_textblob_t)* blob);
    void sk_textblob_ref(const(sk_textblob_t)* blob);
    void sk_textblob_unref(const(sk_textblob_t)* blob);

    // sk_typeface.h
    int sk_fontmgr_count_families(sk_fontmgr_t*);
    sk_fontmgr_t* sk_fontmgr_create_default();
    sk_typeface_t* sk_fontmgr_create_from_data(sk_fontmgr_t*, sk_data_t* data, int index);
    sk_typeface_t* sk_fontmgr_create_from_file(sk_fontmgr_t*, const(char)* path, int index);
    sk_typeface_t* sk_fontmgr_create_from_stream(sk_fontmgr_t*, sk_stream_asset_t* stream, int index);
    sk_fontstyleset_t* sk_fontmgr_create_styleset(sk_fontmgr_t*, int index);
    void sk_fontmgr_get_family_name(sk_fontmgr_t*, int index, sk_string_t* familyName);
    sk_typeface_t* sk_fontmgr_match_face_style(sk_fontmgr_t*, const(sk_typeface_t)* face, sk_fontstyle_t* style);
    sk_fontstyleset_t* sk_fontmgr_match_family(sk_fontmgr_t*, const(char)* familyName);
    sk_typeface_t* sk_fontmgr_match_family_style(sk_fontmgr_t*, const(char)* familyName, sk_fontstyle_t* style);
    sk_typeface_t* sk_fontmgr_match_family_style_character(sk_fontmgr_t*, const(char)* familyName, sk_fontstyle_t* style, const(char)** bcp47, int bcp47Count, int32_t character);
    sk_fontmgr_t* sk_fontmgr_ref_default();
    void sk_fontmgr_unref(sk_fontmgr_t*);
    void sk_fontstyle_delete(sk_fontstyle_t* fs);
    sk_font_style_slant_t sk_fontstyle_get_slant(const(sk_fontstyle_t)* fs);
    int sk_fontstyle_get_weight(const(sk_fontstyle_t)* fs);
    int sk_fontstyle_get_width(const(sk_fontstyle_t)* fs);
    sk_fontstyle_t* sk_fontstyle_new(int weight, int width, sk_font_style_slant_t slant);
    sk_fontstyleset_t* sk_fontstyleset_create_empty();
    sk_typeface_t* sk_fontstyleset_create_typeface(sk_fontstyleset_t* fss, int index);
    int sk_fontstyleset_get_count(sk_fontstyleset_t* fss);
    void sk_fontstyleset_get_style(sk_fontstyleset_t* fss, int index, sk_fontstyle_t* fs, sk_string_t* style);
    sk_typeface_t* sk_fontstyleset_match_style(sk_fontstyleset_t* fss, sk_fontstyle_t* style);
    void sk_fontstyleset_unref(sk_fontstyleset_t* fss);
    sk_data_t* sk_typeface_copy_table_data(const(sk_typeface_t)* typeface, sk_font_table_tag_t tag);
    int sk_typeface_count_glyphs(const(sk_typeface_t)* typeface);
    int sk_typeface_count_tables(const(sk_typeface_t)* typeface);
    sk_typeface_t* sk_typeface_create_default();
    sk_typeface_t* sk_typeface_create_from_data(sk_data_t* data, int index);
    sk_typeface_t* sk_typeface_create_from_file(const(char)* path, int index);
    sk_typeface_t* sk_typeface_create_from_name(const(char)* familyName, const(sk_fontstyle_t)* style);
    sk_typeface_t* sk_typeface_create_from_stream(sk_stream_asset_t* stream, int index);
    sk_string_t* sk_typeface_get_family_name(const(sk_typeface_t)* typeface);
    sk_font_style_slant_t sk_typeface_get_font_slant(const(sk_typeface_t)* typeface);
    int sk_typeface_get_font_weight(const(sk_typeface_t)* typeface);
    int sk_typeface_get_font_width(const(sk_typeface_t)* typeface);
    sk_fontstyle_t* sk_typeface_get_fontstyle(const(sk_typeface_t)* typeface);
    bool sk_typeface_get_kerning_pair_adjustments(const(sk_typeface_t)* typeface, const(uint16_t)* glyphs, int count, int32_t* adjustments);
    void* sk_typeface_get_table_data(const(sk_typeface_t)* typeface, sk_font_table_tag_t tag, size_t offset, size_t length, void* data);
    size_t sk_typeface_get_table_size(const(sk_typeface_t)* typeface, sk_font_table_tag_t tag);
    int sk_typeface_get_table_tags(const(sk_typeface_t)* typeface, sk_font_table_tag_t* tags);
    int sk_typeface_get_units_per_em(const(sk_typeface_t)* typeface);
    bool sk_typeface_is_fixed_pitch(const(sk_typeface_t)* typeface);
    sk_stream_asset_t* sk_typeface_open_stream(const(sk_typeface_t)* typeface, int* ttcIndex);
    sk_typeface_t* sk_typeface_ref_default();
    uint16_t sk_typeface_unichar_to_glyph(const(sk_typeface_t)* typeface, const int32_t unichar);
    void sk_typeface_unichars_to_glyphs(const(sk_typeface_t)* typeface, const(int32_t)* unichars, int count, uint16_t* glyphs);
    void sk_typeface_unref(sk_typeface_t* typeface);

    // sk_vertices.h
    sk_vertices_t* sk_vertices_make_copy(sk_vertices_vertex_mode_t vmode, int vertexCount, const(sk_point_t)* positions, const(sk_point_t)* texs, const(sk_color_t)* colors, int indexCount, const(uint16_t)* indices);
    void sk_vertices_ref(sk_vertices_t* cvertices);
    void sk_vertices_unref(sk_vertices_t* cvertices);

    // sk_xml.h
    void sk_xmlstreamwriter_delete(sk_xmlstreamwriter_t* writer);
    sk_xmlstreamwriter_t* sk_xmlstreamwriter_new(sk_wstream_t* stream);

    // sk_compatpaint.h
    sk_compatpaint_t* sk_compatpaint_clone(const(sk_compatpaint_t)* paint);
    void sk_compatpaint_delete(sk_compatpaint_t* paint);
    sk_font_t* sk_compatpaint_get_font(sk_compatpaint_t* paint);
    sk_text_align_t sk_compatpaint_get_text_align(const(sk_compatpaint_t)* paint);
    sk_text_encoding_t sk_compatpaint_get_text_encoding(const(sk_compatpaint_t)* paint);
    sk_font_t* sk_compatpaint_make_font(sk_compatpaint_t* paint);
    sk_compatpaint_t* sk_compatpaint_new();
    sk_compatpaint_t* sk_compatpaint_new_with_font(const(sk_font_t)* font);
    void sk_compatpaint_reset(sk_compatpaint_t* paint);
    void sk_compatpaint_set_text_align(sk_compatpaint_t* paint, sk_text_align_t textAlign);
    void sk_compatpaint_set_text_encoding(sk_compatpaint_t* paint, sk_text_encoding_t encoding);

    // sk_manageddrawable.h
    sk_manageddrawable_t* sk_manageddrawable_new(void* context);
    void sk_manageddrawable_set_procs(sk_manageddrawable_procs_t procs);
    void sk_manageddrawable_unref(sk_manageddrawable_t*);

    // sk_managedstream.h
    void sk_managedstream_destroy(sk_stream_managedstream_t* s);
    sk_stream_managedstream_t* sk_managedstream_new(void* context);
    void sk_managedstream_set_procs(sk_managedstream_procs_t procs);
    void sk_managedwstream_destroy(sk_wstream_managedstream_t* s);
    sk_wstream_managedstream_t* sk_managedwstream_new(void* context);
    void sk_managedwstream_set_procs(sk_managedwstream_procs_t procs);

    // sk_managedtracememorydump.h
    void sk_managedtracememorydump_delete(sk_managedtracememorydump_t*);
    sk_managedtracememorydump_t* sk_managedtracememorydump_new(bool detailed, bool dumpWrapped, void* context);
    void sk_managedtracememorydump_set_procs(sk_managedtracememorydump_procs_t procs);
}

// Start functions

struct SkiaApi
{
    // for header: gr_context.h

    // void gr_backendrendertarget_delete(gr_backendrendertarget_t* rendertarget)
    static void gr_backendrendertarget_delete (gr_backendrendertarget_t* rendertarget)
    {
        .gr_backendrendertarget_delete (rendertarget);
    }

    // gr_backend_t gr_backendrendertarget_get_backend(const gr_backendrendertarget_t* rendertarget)
    static GRBackendNative gr_backendrendertarget_get_backend (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_get_backend (rendertarget);
    }

    // bool gr_backendrendertarget_get_gl_framebufferinfo(const gr_backendrendertarget_t* rendertarget, gr_gl_framebufferinfo_t* glInfo)
    static bool gr_backendrendertarget_get_gl_framebufferinfo (gr_backendrendertarget_t* rendertarget, GRGlFramebufferInfo* glInfo)
    {
        return .gr_backendrendertarget_get_gl_framebufferinfo (rendertarget, glInfo);
    }

    // int gr_backendrendertarget_get_height(const gr_backendrendertarget_t* rendertarget)
    static int gr_backendrendertarget_get_height (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_get_height (rendertarget);
    }

    // int gr_backendrendertarget_get_samples(const gr_backendrendertarget_t* rendertarget)
    static int gr_backendrendertarget_get_samples (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_get_samples (rendertarget);
    }

    // int gr_backendrendertarget_get_stencils(const gr_backendrendertarget_t* rendertarget)
    static int gr_backendrendertarget_get_stencils (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_get_stencils (rendertarget);
    }

    // int gr_backendrendertarget_get_width(const gr_backendrendertarget_t* rendertarget)
    static int gr_backendrendertarget_get_width (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_get_width (rendertarget);
    }

    // bool gr_backendrendertarget_is_valid(const gr_backendrendertarget_t* rendertarget)
    static bool gr_backendrendertarget_is_valid (gr_backendrendertarget_t* rendertarget)
    {
        return .gr_backendrendertarget_is_valid (rendertarget);
    }

    // gr_backendrendertarget_t* gr_backendrendertarget_new_gl(int width, int height, int samples, int stencils, const gr_gl_framebufferinfo_t* glInfo)
    static gr_backendrendertarget_t* gr_backendrendertarget_new_gl (int width, int height, int samples, int stencils, GRGlFramebufferInfo* glInfo)
    {
        return .gr_backendrendertarget_new_gl (width, height, samples, stencils, glInfo);
    }

    // gr_backendrendertarget_t* gr_backendrendertarget_new_vulkan(int width, int height, int samples, const gr_vk_imageinfo_t* vkImageInfo)
    static gr_backendrendertarget_t* gr_backendrendertarget_new_vulkan (int width, int height, int samples, GRVkImageInfo* vkImageInfo)
    {
        return .gr_backendrendertarget_new_vulkan (width, height, samples, vkImageInfo);
    }

    // void gr_backendtexture_delete(gr_backendtexture_t* texture)
    static void gr_backendtexture_delete (gr_backendtexture_t* texture)
    {
        .gr_backendtexture_delete (texture);
    }

    // gr_backend_t gr_backendtexture_get_backend(const gr_backendtexture_t* texture)
    static GRBackendNative gr_backendtexture_get_backend (gr_backendtexture_t* texture)
    {
        return .gr_backendtexture_get_backend (texture);
    }

    // bool gr_backendtexture_get_gl_textureinfo(const gr_backendtexture_t* texture, gr_gl_textureinfo_t* glInfo)
    static bool gr_backendtexture_get_gl_textureinfo (gr_backendtexture_t* texture, GRGlTextureInfo* glInfo)
    {
        return .gr_backendtexture_get_gl_textureinfo (texture, glInfo);
    }

    // int gr_backendtexture_get_height(const gr_backendtexture_t* texture)
    static int gr_backendtexture_get_height (gr_backendtexture_t* texture)
    {
        return .gr_backendtexture_get_height (texture);
    }

    // int gr_backendtexture_get_width(const gr_backendtexture_t* texture)
    static int gr_backendtexture_get_width (gr_backendtexture_t* texture)
    {
        return .gr_backendtexture_get_width (texture);
    }

    // bool gr_backendtexture_has_mipmaps(const gr_backendtexture_t* texture)
    static bool gr_backendtexture_has_mipmaps (gr_backendtexture_t* texture)
    {
        return .gr_backendtexture_has_mipmaps (texture);
    }

    // bool gr_backendtexture_is_valid(const gr_backendtexture_t* texture)
    static bool gr_backendtexture_is_valid (gr_backendtexture_t* texture)
    {
        return .gr_backendtexture_is_valid (texture);
    }

    // gr_backendtexture_t* gr_backendtexture_new_gl(int width, int height, bool mipmapped, const gr_gl_textureinfo_t* glInfo)
    static gr_backendtexture_t* gr_backendtexture_new_gl (int width, int height, bool mipmapped, GRGlTextureInfo* glInfo)
    {
        return .gr_backendtexture_new_gl (width, height, mipmapped, glInfo);
    }

    // gr_backendtexture_t* gr_backendtexture_new_vulkan(int width, int height, const gr_vk_imageinfo_t* vkInfo)
    static gr_backendtexture_t* gr_backendtexture_new_vulkan (int width, int height, GRVkImageInfo* vkInfo)
    {
        return .gr_backendtexture_new_vulkan (width, height, vkInfo);
    }

    // void gr_context_abandon_context(gr_context_t* context)
    static void gr_context_abandon_context (gr_context_t* context)
    {
        .gr_context_abandon_context (context);
    }

    // void gr_context_dump_memory_statistics(const gr_context_t* context, sk_tracememorydump_t* dump)
    static void gr_context_dump_memory_statistics (gr_context_t* context, sk_tracememorydump_t* dump)
    {
        .gr_context_dump_memory_statistics (context, dump);
    }

    // void gr_context_flush(gr_context_t* context)
    static void gr_context_flush (gr_context_t* context)
    {
        .gr_context_flush (context);
    }

    // void gr_context_free_gpu_resources(gr_context_t* context)
    static void gr_context_free_gpu_resources (gr_context_t* context)
    {
        .gr_context_free_gpu_resources (context);
    }

    // gr_backend_t gr_context_get_backend(gr_context_t* context)
    static GRBackendNative gr_context_get_backend (gr_context_t* context)
    {
        return .gr_context_get_backend (context);
    }

    // int gr_context_get_max_surface_sample_count_for_color_type(gr_context_t* context, sk_colortype_t colorType)
    static int gr_context_get_max_surface_sample_count_for_color_type (gr_context_t* context, SKColorTypeNative colorType)
    {
        return .gr_context_get_max_surface_sample_count_for_color_type (context, colorType);
    }

    // size_t gr_context_get_resource_cache_limit(gr_context_t* context)
    static size_t gr_context_get_resource_cache_limit (gr_context_t* context)
    {
        return .gr_context_get_resource_cache_limit (context);
    }

    // void gr_context_get_resource_cache_usage(gr_context_t* context, int* maxResources, size_t* maxResourceBytes)
    static void gr_context_get_resource_cache_usage (gr_context_t* context, int* maxResources, size_t* maxResourceBytes)
    {
        .gr_context_get_resource_cache_usage (context, maxResources, maxResourceBytes);
    }

    // gr_context_t* gr_context_make_gl(const gr_glinterface_t* glInterface)
    static gr_context_t* gr_context_make_gl (gr_glinterface_t* glInterface)
    {
        return .gr_context_make_gl (glInterface);
    }

    // gr_context_t* gr_context_make_vulkan(const gr_vk_backendcontext_t vkBackendContext)
    static gr_context_t* gr_context_make_vulkan (GRVkBackendContextNative vkBackendContext)
    {
        return .gr_context_make_vulkan (vkBackendContext);
    }

    // void gr_context_perform_deferred_cleanup(gr_context_t* context, long ms)
    static void gr_context_perform_deferred_cleanup (gr_context_t* context, long ms)
    {
        .gr_context_perform_deferred_cleanup (context, ms);
    }

    // void gr_context_purge_unlocked_resources(gr_context_t* context, bool scratchResourcesOnly)
    static void gr_context_purge_unlocked_resources (gr_context_t* context, bool scratchResourcesOnly)
    {
        .gr_context_purge_unlocked_resources (context, scratchResourcesOnly);
    }

    // void gr_context_purge_unlocked_resources_bytes(gr_context_t* context, size_t bytesToPurge, bool preferScratchResources)
    static void gr_context_purge_unlocked_resources_bytes (gr_context_t* context, size_t bytesToPurge, bool preferScratchResources)
    {
        .gr_context_purge_unlocked_resources_bytes (context, bytesToPurge, preferScratchResources);
    }

    // void gr_context_release_resources_and_abandon_context(gr_context_t* context)
    static void gr_context_release_resources_and_abandon_context (gr_context_t* context)
    {
        .gr_context_release_resources_and_abandon_context (context);
    }

    // void gr_context_reset_context(gr_context_t* context, uint32_t state)
    static void gr_context_reset_context (gr_context_t* context, uint state)
    {
        .gr_context_reset_context (context, state);
    }

    // void gr_context_set_resource_cache_limit(gr_context_t* context, size_t maxResourceBytes)
    static void gr_context_set_resource_cache_limit (gr_context_t* context, size_t maxResourceBytes)
    {
        .gr_context_set_resource_cache_limit (context, maxResourceBytes);
    }

    // void gr_context_unref(gr_context_t* context)
    static void gr_context_unref (gr_context_t* context)
    {
        .gr_context_unref (context);
    }

    // const gr_glinterface_t* gr_glinterface_assemble_gl_interface(void* ctx, gr_gl_get_proc get)
    static gr_glinterface_t* gr_glinterface_assemble_gl_interface (void* ctx, GRGlGetProcProxyDelegate get)
    {
        return .gr_glinterface_assemble_gl_interface (ctx, get);
    }

    // const gr_glinterface_t* gr_glinterface_assemble_gles_interface(void* ctx, gr_gl_get_proc get)
    static gr_glinterface_t* gr_glinterface_assemble_gles_interface (void* ctx, GRGlGetProcProxyDelegate get)
    {
        return .gr_glinterface_assemble_gles_interface (ctx, get);
    }

    // const gr_glinterface_t* gr_glinterface_assemble_interface(void* ctx, gr_gl_get_proc get)
    static gr_glinterface_t* gr_glinterface_assemble_interface (void* ctx, GRGlGetProcProxyDelegate get)
    {
        return .gr_glinterface_assemble_interface (ctx, get);
    }

    // const gr_glinterface_t* gr_glinterface_assemble_webgl_interface(void* ctx, gr_gl_get_proc get)
    static gr_glinterface_t* gr_glinterface_assemble_webgl_interface (void* ctx, GRGlGetProcProxyDelegate get)
    {
        return .gr_glinterface_assemble_webgl_interface (ctx, get);
    }

    // const gr_glinterface_t* gr_glinterface_create_native_interface()
    static gr_glinterface_t* gr_glinterface_create_native_interface ()
    {
        return .gr_glinterface_create_native_interface ();
    }

    // bool gr_glinterface_has_extension(const gr_glinterface_t* glInterface, const(char)* extension)
    static bool gr_glinterface_has_extension (gr_glinterface_t* glInterface, string extension)
    {
        return .gr_glinterface_has_extension (glInterface, std.string.toStringz(extension));
    }

    // void gr_glinterface_unref(const gr_glinterface_t* glInterface)
    static void gr_glinterface_unref (gr_glinterface_t* glInterface)
    {
        .gr_glinterface_unref (glInterface);
    }

    // bool gr_glinterface_validate(const gr_glinterface_t* glInterface)
    static bool gr_glinterface_validate (gr_glinterface_t* glInterface)
    {
        return .gr_glinterface_validate (glInterface);
    }

    // void gr_vk_extensions_delete(gr_vk_extensions_t* extensions)
    static void gr_vk_extensions_delete (gr_vk_extensions_t* extensions)
    {
        .gr_vk_extensions_delete (extensions);
    }

    // bool gr_vk_extensions_has_extension(gr_vk_extensions_t* extensions, const(char)* ext, uint32_t minVersion)
    static bool gr_vk_extensions_has_extension (gr_vk_extensions_t* extensions, string ext, uint minVersion)
    {
        return .gr_vk_extensions_has_extension (extensions, ext.toStringz(), minVersion);
    }

    // void gr_vk_extensions_init(gr_vk_extensions_t* extensions, gr_vk_get_proc getProc, void* userData, vk_instance_t* instance, vk_physical_device_t* physDev, uint32_t instanceExtensionCount, const(char)** instanceExtensions, uint32_t deviceExtensionCount, const(char)** deviceExtensions)
    static void gr_vk_extensions_init (gr_vk_extensions_t* extensions, GRVkGetProcProxyDelegate getProc, void* userData, vk_instance_t* instance, vk_physical_device_t* physDev, uint instanceExtensionCount, string[] instanceExtensions, uint deviceExtensionCount, string[] deviceExtensions)
    {
        const(char)*[] instanceExtens = toCStrings(instanceExtensions);
        const(char)*[] deviceExtens = toCStrings(deviceExtensions);

        .gr_vk_extensions_init (extensions, getProc, userData, instance, physDev, instanceExtensionCount, instanceExtens.ptr, deviceExtensionCount, deviceExtens.ptr);
    }

    // gr_vk_extensions_t* gr_vk_extensions_new()
    static gr_vk_extensions_t* gr_vk_extensions_new ()
    {
        return .gr_vk_extensions_new ();
    }

    // end header: gr_context.h

    // for header: sk_bitmap.h

    // void sk_bitmap_destructor(sk_bitmap_t* cbitmap)
    static void sk_bitmap_destructor (sk_bitmap_t* cbitmap)
    {
        .sk_bitmap_destructor (cbitmap);
    }

    // void sk_bitmap_erase(sk_bitmap_t* cbitmap, sk_color_t color)
    static void sk_bitmap_erase (sk_bitmap_t* cbitmap, uint color)
    {
        .sk_bitmap_erase (cbitmap, color);
    }

    // void sk_bitmap_erase_rect(sk_bitmap_t* cbitmap, sk_color_t color, sk_irect_t* rect)
    static void sk_bitmap_erase_rect (sk_bitmap_t* cbitmap, uint color, SKRectI* rect)
    {
        .sk_bitmap_erase_rect (cbitmap, color, rect);
    }

    // bool sk_bitmap_extract_alpha(sk_bitmap_t* cbitmap, sk_bitmap_t* dst, const sk_paint_t* paint, sk_ipoint_t* offset)
    static bool sk_bitmap_extract_alpha (sk_bitmap_t* cbitmap, sk_bitmap_t* dst, sk_paint_t* paint, SKPointI* offset)
    {
        return .sk_bitmap_extract_alpha (cbitmap, dst, paint, offset);
    }

    // bool sk_bitmap_extract_subset(sk_bitmap_t* cbitmap, sk_bitmap_t* dst, sk_irect_t* subset)
    static bool sk_bitmap_extract_subset (sk_bitmap_t* cbitmap, sk_bitmap_t* dst, SKRectI* subset)
    {
        return .sk_bitmap_extract_subset (cbitmap, dst, subset);
    }

    // void* sk_bitmap_get_addr(sk_bitmap_t* cbitmap, int x, int y)
    static void* sk_bitmap_get_addr (sk_bitmap_t* cbitmap, int x, int y)
    {
        return .sk_bitmap_get_addr (cbitmap, x, y);
    }

    // uint16_t* sk_bitmap_get_addr_16(sk_bitmap_t* cbitmap, int x, int y)
    static ushort* sk_bitmap_get_addr_16 (sk_bitmap_t* cbitmap, int x, int y)
    {
        return .sk_bitmap_get_addr_16 (cbitmap, x, y);
    }

    // uint32_t* sk_bitmap_get_addr_32(sk_bitmap_t* cbitmap, int x, int y)
    static uint* sk_bitmap_get_addr_32 (sk_bitmap_t* cbitmap, int x, int y)
    {
        return .sk_bitmap_get_addr_32 (cbitmap, x, y);
    }

    // uint8_t* sk_bitmap_get_addr_8(sk_bitmap_t* cbitmap, int x, int y)
    static ubyte* sk_bitmap_get_addr_8 (sk_bitmap_t* cbitmap, int x, int y)
    {
        return cast(ubyte*).sk_bitmap_get_addr_8 (cbitmap, x, y);
    }

    // size_t sk_bitmap_get_byte_count(sk_bitmap_t* cbitmap)
    static size_t sk_bitmap_get_byte_count (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_get_byte_count (cbitmap);
    }

    // void sk_bitmap_get_info(sk_bitmap_t* cbitmap, sk_imageinfo_t* info)
    static void sk_bitmap_get_info (sk_bitmap_t* cbitmap, SKImageInfoNative* info)
    {
        .sk_bitmap_get_info (cbitmap, info);
    }

    // sk_color_t sk_bitmap_get_pixel_color(sk_bitmap_t* cbitmap, int x, int y)
    static uint sk_bitmap_get_pixel_color (sk_bitmap_t* cbitmap, int x, int y)
    {
        return .sk_bitmap_get_pixel_color (cbitmap, x, y);
    }

    // void sk_bitmap_get_pixel_colors(sk_bitmap_t* cbitmap, sk_color_t* colors)
    static void sk_bitmap_get_pixel_colors (sk_bitmap_t* cbitmap, uint* colors)
    {
        .sk_bitmap_get_pixel_colors (cbitmap, colors);
    }

    // void* sk_bitmap_get_pixels(sk_bitmap_t* cbitmap, size_t* length)
    static void* sk_bitmap_get_pixels (sk_bitmap_t* cbitmap, size_t* length)
    {
        return .sk_bitmap_get_pixels (cbitmap, length);
    }

    // size_t sk_bitmap_get_row_bytes(sk_bitmap_t* cbitmap)
    static size_t sk_bitmap_get_row_bytes (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_get_row_bytes (cbitmap);
    }

    // bool sk_bitmap_install_mask_pixels(sk_bitmap_t* cbitmap, const sk_mask_t* cmask)
    static bool sk_bitmap_install_mask_pixels (sk_bitmap_t* cbitmap, SKMask* cmask)
    {
        return .sk_bitmap_install_mask_pixels (cbitmap, cmask);
    }

    // bool sk_bitmap_install_pixels(sk_bitmap_t* cbitmap, const sk_imageinfo_t* cinfo, void* pixels, size_t rowBytes, const sk_bitmap_release_proc releaseProc, void* context)
    static bool sk_bitmap_install_pixels (sk_bitmap_t* cbitmap, SKImageInfoNative* cinfo, void* pixels, size_t rowBytes, SKBitmapReleaseProxyDelegate releaseProc, void* context)
    {
        return .sk_bitmap_install_pixels (cbitmap, cinfo, pixels, rowBytes, releaseProc, context);
    }

    // bool sk_bitmap_install_pixels_with_pixmap(sk_bitmap_t* cbitmap, const sk_pixmap_t* cpixmap)
    static bool sk_bitmap_install_pixels_with_pixmap (sk_bitmap_t* cbitmap, sk_pixmap_t* cpixmap)
    {
        return .sk_bitmap_install_pixels_with_pixmap (cbitmap, cpixmap);
    }

    // bool sk_bitmap_is_immutable(sk_bitmap_t* cbitmap)
    static bool sk_bitmap_is_immutable (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_is_immutable (cbitmap);
    }

    // bool sk_bitmap_is_null(sk_bitmap_t* cbitmap)
    static bool sk_bitmap_is_null (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_is_null (cbitmap);
    }

    // bool sk_bitmap_is_volatile(sk_bitmap_t* cbitmap)
    static bool sk_bitmap_is_volatile (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_is_volatile (cbitmap);
    }

    // sk_shader_t* sk_bitmap_make_shader(sk_bitmap_t* cbitmap, sk_shader_tilemode_t tmx, sk_shader_tilemode_t tmy, const sk_matrix_t* cmatrix)
    static sk_shader_t* sk_bitmap_make_shader (sk_bitmap_t* cbitmap, SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix* cmatrix)
    {
        return .sk_bitmap_make_shader (cbitmap, tmx, tmy, cmatrix);
    }

    // sk_bitmap_t* sk_bitmap_new()
    static sk_bitmap_t* sk_bitmap_new ()
    {
        return .sk_bitmap_new ();
    }

    // void sk_bitmap_notify_pixels_changed(sk_bitmap_t* cbitmap)
    static void sk_bitmap_notify_pixels_changed (sk_bitmap_t* cbitmap)
    {
        .sk_bitmap_notify_pixels_changed (cbitmap);
    }

    // bool sk_bitmap_peek_pixels(sk_bitmap_t* cbitmap, sk_pixmap_t* cpixmap)
    static bool sk_bitmap_peek_pixels (sk_bitmap_t* cbitmap, sk_pixmap_t* cpixmap)
    {
        return .sk_bitmap_peek_pixels (cbitmap, cpixmap);
    }

    // bool sk_bitmap_ready_to_draw(sk_bitmap_t* cbitmap)
    static bool sk_bitmap_ready_to_draw (sk_bitmap_t* cbitmap)
    {
        return .sk_bitmap_ready_to_draw (cbitmap);
    }

    // void sk_bitmap_reset(sk_bitmap_t* cbitmap)
    static void sk_bitmap_reset (sk_bitmap_t* cbitmap)
    {
        .sk_bitmap_reset (cbitmap);
    }

    // void sk_bitmap_set_immutable(sk_bitmap_t* cbitmap)
    static void sk_bitmap_set_immutable (sk_bitmap_t* cbitmap)
    {
        .sk_bitmap_set_immutable (cbitmap);
    }

    // void sk_bitmap_set_pixels(sk_bitmap_t* cbitmap, void* pixels)
    static void sk_bitmap_set_pixels (sk_bitmap_t* cbitmap, void* pixels)
    {
        .sk_bitmap_set_pixels (cbitmap, pixels);
    }

    // void sk_bitmap_set_volatile(sk_bitmap_t* cbitmap, bool value)
    static void sk_bitmap_set_volatile (sk_bitmap_t* cbitmap, bool value)
    {
        .sk_bitmap_set_volatile (cbitmap, value);
    }

    // void sk_bitmap_swap(sk_bitmap_t* cbitmap, sk_bitmap_t* cother)
    static void sk_bitmap_swap (sk_bitmap_t* cbitmap, sk_bitmap_t* cother)
    {
        .sk_bitmap_swap (cbitmap, cother);
    }

    // bool sk_bitmap_try_alloc_pixels(sk_bitmap_t* cbitmap, const sk_imageinfo_t* requestedInfo, size_t rowBytes)
    static bool sk_bitmap_try_alloc_pixels (sk_bitmap_t* cbitmap, SKImageInfoNative* requestedInfo, size_t rowBytes)
    {
        return .sk_bitmap_try_alloc_pixels (cbitmap, requestedInfo, rowBytes);
    }

    // bool sk_bitmap_try_alloc_pixels_with_flags(sk_bitmap_t* cbitmap, const sk_imageinfo_t* requestedInfo, uint32_t flags)
    static bool sk_bitmap_try_alloc_pixels_with_flags (sk_bitmap_t* cbitmap, SKImageInfoNative* requestedInfo, uint flags)
    {
        return .sk_bitmap_try_alloc_pixels_with_flags (cbitmap, requestedInfo, flags);
    }

    // end header: sk_bitmap.h

    // for header: sk_canvas.h

    // void sk_canvas_clear(sk_canvas_t*, sk_color_t)
    static void sk_canvas_clear (sk_canvas_t* param0, uint param1)
    {
        .sk_canvas_clear (param0, param1);
    }

    // void sk_canvas_clip_path_with_operation(sk_canvas_t* t, const sk_path_t* crect, sk_clipop_t op, bool doAA)
    static void sk_canvas_clip_path_with_operation (sk_canvas_t* t, sk_path_t* crect, SKClipOperation op, bool doAA)
    {
        .sk_canvas_clip_path_with_operation (t, crect, op, doAA);
    }

    // void sk_canvas_clip_rect_with_operation(sk_canvas_t* t, const sk_rect_t* crect, sk_clipop_t op, bool doAA)
    static void sk_canvas_clip_rect_with_operation (sk_canvas_t* t, SKRect* crect, SKClipOperation op, bool doAA)
    {
        .sk_canvas_clip_rect_with_operation (t, crect, op, doAA);
    }

    // void sk_canvas_clip_region(sk_canvas_t* canvas, const sk_region_t* region, sk_clipop_t op)
    static void sk_canvas_clip_region (sk_canvas_t* canvas, sk_region_t* region, SKClipOperation op)
    {
        .sk_canvas_clip_region (canvas, region, op);
    }

    // void sk_canvas_clip_rrect_with_operation(sk_canvas_t* t, const sk_rrect_t* crect, sk_clipop_t op, bool doAA)
    static void sk_canvas_clip_rrect_with_operation (sk_canvas_t* t, sk_rrect_t* crect, SKClipOperation op, bool doAA)
    {
        .sk_canvas_clip_rrect_with_operation (t, crect, op, doAA);
    }

    // void sk_canvas_concat(sk_canvas_t*, const sk_matrix_t*)
    static void sk_canvas_concat (sk_canvas_t* param0, SKMatrix* param1)
    {
        .sk_canvas_concat (param0, param1);
    }

    // void sk_canvas_destroy(sk_canvas_t*)
    static void sk_canvas_destroy (sk_canvas_t* param0)
    {
        .sk_canvas_destroy (param0);
    }

    // void sk_canvas_discard(sk_canvas_t*)
    static void sk_canvas_discard (sk_canvas_t* param0)
    {
        .sk_canvas_discard (param0);
    }

    // void sk_canvas_draw_annotation(sk_canvas_t* t, const sk_rect_t* rect, const(char)* key, sk_data_t* value)
    static void sk_canvas_draw_annotation (sk_canvas_t* t, SKRect* rect,  string key, sk_data_t* value)
    {
        .sk_canvas_draw_annotation (t, rect, key.toStringz(), value);
    }

    // void sk_canvas_draw_arc(sk_canvas_t* ccanvas, const sk_rect_t* oval, float startAngle, float sweepAngle, bool useCenter, const sk_paint_t* paint)
    static void sk_canvas_draw_arc (sk_canvas_t* ccanvas, SKRect* oval, float startAngle, float sweepAngle, bool useCenter, sk_paint_t* paint)
    {
        .sk_canvas_draw_arc (ccanvas, oval, startAngle, sweepAngle, useCenter, paint);
    }

    // void sk_canvas_draw_atlas(sk_canvas_t* ccanvas, const sk_image_t* atlas, const sk_rsxform_t* xform, const sk_rect_t* tex, const sk_color_t* colors, int count, sk_blendmode_t mode, const sk_rect_t* cullRect, const sk_paint_t* paint)
    static void sk_canvas_draw_atlas (sk_canvas_t* ccanvas, sk_image_t* atlas, SKRotationScaleMatrix* xform, SKRect* tex, uint* colors, int count, SKBlendMode mode, SKRect* cullRect, sk_paint_t* paint)
    {
        .sk_canvas_draw_atlas (ccanvas, atlas, xform, tex, colors, count, mode, cullRect, paint);
    }

    // void sk_canvas_draw_bitmap(sk_canvas_t* ccanvas, const sk_bitmap_t* bitmap, float left, float top, const sk_paint_t* paint)
    static void sk_canvas_draw_bitmap (sk_canvas_t* ccanvas, sk_bitmap_t* bitmap, float left, float top, sk_paint_t* paint)
    {
        .sk_canvas_draw_bitmap (ccanvas, bitmap, left, top, paint);
    }

    // void sk_canvas_draw_bitmap_lattice(sk_canvas_t* t, const sk_bitmap_t* bitmap, const sk_lattice_t* lattice, const sk_rect_t* dst, const sk_paint_t* paint)
    static void sk_canvas_draw_bitmap_lattice (sk_canvas_t* t, sk_bitmap_t* bitmap, SKLatticeInternal* lattice, SKRect* dst, sk_paint_t* paint) {
        .sk_canvas_draw_bitmap_lattice(t, bitmap, lattice, dst, paint);
    }

    // void sk_canvas_draw_bitmap_nine(sk_canvas_t* t, const sk_bitmap_t* bitmap, const sk_irect_t* center, const sk_rect_t* dst, const sk_paint_t* paint)
    static void sk_canvas_draw_bitmap_nine (sk_canvas_t* t, sk_bitmap_t* bitmap, SKRectI* center, SKRect* dst, sk_paint_t* paint) {
        .sk_canvas_draw_bitmap_nine(t, bitmap, center, dst, paint);
    }

    // void sk_canvas_draw_bitmap_rect(sk_canvas_t* ccanvas, const sk_bitmap_t* bitmap, const sk_rect_t* src, const sk_rect_t* dst, const sk_paint_t* paint)
    static void sk_canvas_draw_bitmap_rect (sk_canvas_t* ccanvas, sk_bitmap_t* bitmap, SKRect* src, SKRect* dst, sk_paint_t* paint)
    {
        .sk_canvas_draw_bitmap_rect (ccanvas, bitmap, src, dst, paint);
    }

    // void sk_canvas_draw_circle(sk_canvas_t*, float cx, float cy, float rad, const sk_paint_t*)
    static void sk_canvas_draw_circle (sk_canvas_t* param0, float cx, float cy, float rad, sk_paint_t* param4)
    {
        .sk_canvas_draw_circle (param0, cx, cy, rad, param4);
    }

    // void sk_canvas_draw_color(sk_canvas_t* ccanvas, sk_color_t color, sk_blendmode_t mode)
    static void sk_canvas_draw_color (sk_canvas_t* ccanvas, uint color, SKBlendMode mode)
    {
        .sk_canvas_draw_color (ccanvas, color, mode);
    }

    // void sk_canvas_draw_drawable(sk_canvas_t*, sk_drawable_t*, const sk_matrix_t*)
    static void sk_canvas_draw_drawable (sk_canvas_t* param0, sk_drawable_t* param1, SKMatrix* param2)
    {
        .sk_canvas_draw_drawable (param0, param1, param2);
    }

    // void sk_canvas_draw_drrect(sk_canvas_t* ccanvas, const sk_rrect_t* outer, const sk_rrect_t* inner, const sk_paint_t* paint)
    static void sk_canvas_draw_drrect (sk_canvas_t* ccanvas, sk_rrect_t* outer, sk_rrect_t* inner, sk_paint_t* paint)
    {
        .sk_canvas_draw_drrect (ccanvas, outer, inner, paint);
    }

    // void sk_canvas_draw_image(sk_canvas_t*, const sk_image_t*, float x, float y, const sk_paint_t*)
    static void sk_canvas_draw_image (sk_canvas_t* param0, sk_image_t* param1, float x, float y, sk_paint_t* param4)
    {
        .sk_canvas_draw_image (param0, param1, x, y, param4);
    }

    // void sk_canvas_draw_image_lattice(sk_canvas_t* t, const sk_image_t* image, const sk_lattice_t* lattice, const sk_rect_t* dst, const sk_paint_t* paint)
    static void sk_canvas_draw_image_lattice (sk_canvas_t* t, sk_image_t* image, SKLatticeInternal* lattice, SKRect* dst, sk_paint_t* paint)
    {
        .sk_canvas_draw_image_lattice (t, image, lattice, dst, paint);
    }

    // void sk_canvas_draw_image_nine(sk_canvas_t* t, const sk_image_t* image, const sk_irect_t* center, const sk_rect_t* dst, const sk_paint_t* paint)
    static void sk_canvas_draw_image_nine (sk_canvas_t* t, sk_image_t* image, SKRectI* center, SKRect* dst, sk_paint_t* paint)
    {
        .sk_canvas_draw_image_nine (t, image, center, dst, paint);
    }

    // void sk_canvas_draw_image_rect(sk_canvas_t*, const sk_image_t*, const sk_rect_t* src, const sk_rect_t* dst, const sk_paint_t*)
    static void sk_canvas_draw_image_rect (sk_canvas_t* param0, sk_image_t* param1, SKRect* src, SKRect* dst, sk_paint_t* param4)
    {
        .sk_canvas_draw_image_rect (param0, param1, src, dst, param4);
    }

    // void sk_canvas_draw_line(sk_canvas_t* ccanvas, float x0, float y0, float x1, float y1, sk_paint_t* cpaint)
    static void sk_canvas_draw_line (sk_canvas_t* ccanvas, float x0, float y0, float x1, float y1, sk_paint_t* cpaint)
    {
        .sk_canvas_draw_line (ccanvas, x0, y0, x1, y1, cpaint);
    }

    // void sk_canvas_draw_link_destination_annotation(sk_canvas_t* t, const sk_rect_t* rect, sk_data_t* value)
    static void sk_canvas_draw_link_destination_annotation (sk_canvas_t* t, SKRect* rect, sk_data_t* value)
    {
        .sk_canvas_draw_link_destination_annotation (t, rect, value);
    }

    // void sk_canvas_draw_named_destination_annotation(sk_canvas_t* t, const sk_point_t* point, sk_data_t* value)
    static void sk_canvas_draw_named_destination_annotation (sk_canvas_t* t, SKPoint* point, sk_data_t* value)
    {
        .sk_canvas_draw_named_destination_annotation (t, point, value);
    }

    // void sk_canvas_draw_oval(sk_canvas_t*, const sk_rect_t*, const sk_paint_t*)
    static void sk_canvas_draw_oval (sk_canvas_t* param0, SKRect* param1, sk_paint_t* param2)
    {
        .sk_canvas_draw_oval (param0, param1, param2);
    }

    // void sk_canvas_draw_paint(sk_canvas_t*, const sk_paint_t*)
    static void sk_canvas_draw_paint (sk_canvas_t* param0, sk_paint_t* param1)
    {
        .sk_canvas_draw_paint (param0, param1);
    }

    // void sk_canvas_draw_patch(sk_canvas_t* ccanvas, const sk_point_t* cubics, const sk_color_t* colors, const sk_point_t* texCoords, sk_blendmode_t mode, const sk_paint_t* paint)
    static void sk_canvas_draw_patch (sk_canvas_t* ccanvas, SKPoint* cubics, uint* colors, SKPoint* texCoords, SKBlendMode mode, sk_paint_t* paint)
    {
        .sk_canvas_draw_patch (ccanvas, cubics, colors, texCoords, mode, paint);
    }

    // void sk_canvas_draw_path(sk_canvas_t*, const sk_path_t*, const sk_paint_t*)
    static void sk_canvas_draw_path (sk_canvas_t* param0, sk_path_t* param1, sk_paint_t* param2)
    {
        .sk_canvas_draw_path (param0, param1, param2);
    }

    // void sk_canvas_draw_picture(sk_canvas_t*, const sk_picture_t*, const sk_matrix_t*, const sk_paint_t*)
    static void sk_canvas_draw_picture (sk_canvas_t* param0, sk_picture_t* param1, SKMatrix* param2, sk_paint_t* param3)
    {
        .sk_canvas_draw_picture (param0, param1, param2, param3);
    }

    // void sk_canvas_draw_point(sk_canvas_t*, float, float, const sk_paint_t*)
    static void sk_canvas_draw_point (sk_canvas_t* param0, float param1, float param2, sk_paint_t* param3)
    {
        .sk_canvas_draw_point (param0, param1, param2, param3);
    }

    // void sk_canvas_draw_points(sk_canvas_t*, sk_point_mode_t, size_t, const sk_point_t*, const sk_paint_t*)
    static void sk_canvas_draw_points (sk_canvas_t* param0, SKPointMode param1, size_t param2, SKPoint* param3, sk_paint_t* param4)
    {
        .sk_canvas_draw_points (param0, param1, param2, param3, param4);
    }

    // void sk_canvas_draw_rect(sk_canvas_t*, const sk_rect_t*, const sk_paint_t*)
    static void sk_canvas_draw_rect (sk_canvas_t* param0, SKRect* param1, sk_paint_t* param2)
    {
        .sk_canvas_draw_rect (param0, param1, param2);
    }

    // void sk_canvas_draw_region(sk_canvas_t*, const sk_region_t*, const sk_paint_t*)
    static void sk_canvas_draw_region (sk_canvas_t* param0, sk_region_t* param1, sk_paint_t* param2)
    {
        .sk_canvas_draw_region (param0, param1, param2);
    }

    // void sk_canvas_draw_round_rect(sk_canvas_t*, const sk_rect_t*, float rx, float ry, const sk_paint_t*)
    static void sk_canvas_draw_round_rect (sk_canvas_t* param0, SKRect* param1, float rx, float ry, sk_paint_t* param4)
    {
        .sk_canvas_draw_round_rect (param0, param1, rx, ry, param4);
    }

    // void sk_canvas_draw_rrect(sk_canvas_t*, const sk_rrect_t*, const sk_paint_t*)
    static void sk_canvas_draw_rrect (sk_canvas_t* param0, sk_rrect_t* param1, sk_paint_t* param2)
    {
        .sk_canvas_draw_rrect (param0, param1, param2);
    }

    // void sk_canvas_draw_simple_text(sk_canvas_t* ccanvas, const(void)* text, size_t byte_length, sk_text_encoding_t encoding, float x, float y, const sk_font_t* cfont, const sk_paint_t* cpaint)
    static void sk_canvas_draw_simple_text (sk_canvas_t* ccanvas, void* text, size_t byte_length, SKTextEncoding encoding, float x, float y, sk_font_t* cfont, sk_paint_t* cpaint)
    {
        .sk_canvas_draw_simple_text (ccanvas, text, byte_length, encoding, x, y, cfont, cpaint);
    }

    // void sk_canvas_draw_text_blob(sk_canvas_t*, sk_textblob_t* text, float x, float y, const sk_paint_t* paint)
    static void sk_canvas_draw_text_blob (sk_canvas_t* param0, sk_textblob_t* text, float x, float y, sk_paint_t* paint)
    {
        .sk_canvas_draw_text_blob (param0, text, x, y, paint);
    }

    // void sk_canvas_draw_url_annotation(sk_canvas_t* t, const sk_rect_t* rect, sk_data_t* value)
    static void sk_canvas_draw_url_annotation (sk_canvas_t* t, SKRect* rect, sk_data_t* value)
    {
        .sk_canvas_draw_url_annotation (t, rect, value);
    }

    // void sk_canvas_draw_vertices(sk_canvas_t* ccanvas, const sk_vertices_t* vertices, sk_blendmode_t mode, const sk_paint_t* paint)
    static void sk_canvas_draw_vertices (sk_canvas_t* ccanvas, sk_vertices_t* vertices, SKBlendMode mode, sk_paint_t* paint)
    {
        .sk_canvas_draw_vertices (ccanvas, vertices, mode, paint);
    }

    // void sk_canvas_flush(sk_canvas_t* ccanvas)
    static void sk_canvas_flush (sk_canvas_t* ccanvas)
    {
        .sk_canvas_flush (ccanvas);
    }

    // bool sk_canvas_get_device_clip_bounds(sk_canvas_t* t, sk_irect_t* cbounds)
    static bool sk_canvas_get_device_clip_bounds (sk_canvas_t* t, SKRectI* cbounds)
    {
        return .sk_canvas_get_device_clip_bounds (t, cbounds);
    }

    // bool sk_canvas_get_local_clip_bounds(sk_canvas_t* t, sk_rect_t* cbounds)
    static bool sk_canvas_get_local_clip_bounds (sk_canvas_t* t, SKRect* cbounds)
    {
        return .sk_canvas_get_local_clip_bounds (t, cbounds);
    }

    // int sk_canvas_get_save_count(sk_canvas_t*)
    static int sk_canvas_get_save_count (sk_canvas_t* param0)
    {
        return .sk_canvas_get_save_count (param0);
    }

    // void sk_canvas_get_total_matrix(sk_canvas_t* ccanvas, sk_matrix_t* matrix)
    static void sk_canvas_get_total_matrix (sk_canvas_t* ccanvas, SKMatrix* matrix)
    {
        .sk_canvas_get_total_matrix (ccanvas, matrix);
    }

    // bool sk_canvas_is_clip_empty(sk_canvas_t* ccanvas)
    static bool sk_canvas_is_clip_empty (sk_canvas_t* ccanvas)
    {
        return .sk_canvas_is_clip_empty (ccanvas);
    }

    // bool sk_canvas_is_clip_rect(sk_canvas_t* ccanvas)
    static bool sk_canvas_is_clip_rect (sk_canvas_t* ccanvas)
    {
        return .sk_canvas_is_clip_rect (ccanvas);
    }

    // sk_canvas_t* sk_canvas_new_from_bitmap(const sk_bitmap_t* bitmap)
    static sk_canvas_t* sk_canvas_new_from_bitmap (sk_bitmap_t* bitmap)
    {
        return .sk_canvas_new_from_bitmap (bitmap);
    }

    // bool sk_canvas_quick_reject(sk_canvas_t*, const sk_rect_t*)
    static bool sk_canvas_quick_reject (sk_canvas_t* param0, SKRect* param1)
    {
        return .sk_canvas_quick_reject (param0, param1);
    }

    // void sk_canvas_reset_matrix(sk_canvas_t* ccanvas)
    static void sk_canvas_reset_matrix (sk_canvas_t* ccanvas)
    {
        .sk_canvas_reset_matrix (ccanvas);
    }

    // void sk_canvas_restore(sk_canvas_t*)
    static void sk_canvas_restore (sk_canvas_t* param0)
    {
        .sk_canvas_restore (param0);
    }

    // void sk_canvas_restore_to_count(sk_canvas_t*, int saveCount)
    static void sk_canvas_restore_to_count (sk_canvas_t* param0, int saveCount)
    {
        .sk_canvas_restore_to_count (param0, saveCount);
    }

    // void sk_canvas_rotate_degrees(sk_canvas_t*, float degrees)
    static void sk_canvas_rotate_degrees (sk_canvas_t* param0, float degrees)
    {
        .sk_canvas_rotate_degrees (param0, degrees);
    }

    // void sk_canvas_rotate_radians(sk_canvas_t*, float radians)
    static void sk_canvas_rotate_radians (sk_canvas_t* param0, float radians)
    {
        .sk_canvas_rotate_radians (param0, radians);
    }

    // int sk_canvas_save(sk_canvas_t*)
    static int sk_canvas_save (sk_canvas_t* param0)
    {
        return .sk_canvas_save (param0);
    }

    // int sk_canvas_save_layer(sk_canvas_t*, const sk_rect_t*, const sk_paint_t*)
    static int sk_canvas_save_layer (sk_canvas_t* param0, SKRect* param1, sk_paint_t* param2)
    {
        return .sk_canvas_save_layer (param0, param1, param2);
    }

    // void sk_canvas_scale(sk_canvas_t*, float sx, float sy)
    static void sk_canvas_scale (sk_canvas_t* param0, float sx, float sy)
    {
        .sk_canvas_scale (param0, sx, sy);
    }

    // void sk_canvas_set_matrix(sk_canvas_t* ccanvas, const sk_matrix_t* matrix)
    static void sk_canvas_set_matrix (sk_canvas_t* ccanvas, SKMatrix* matrix)
    {
        .sk_canvas_set_matrix (ccanvas, matrix);
    }

    // void sk_canvas_skew(sk_canvas_t*, float sx, float sy)
    static void sk_canvas_skew (sk_canvas_t* param0, float sx, float sy)
    {
        .sk_canvas_skew (param0, sx, sy);
    }

    // void sk_canvas_translate(sk_canvas_t*, float dx, float dy)
    static void sk_canvas_translate (sk_canvas_t* param0, float dx, float dy)
    {
        .sk_canvas_translate (param0, dx, dy);
    }

    // void sk_nodraw_canvas_destroy(sk_nodraw_canvas_t*)
    static void sk_nodraw_canvas_destroy (sk_nodraw_canvas_t* param0)
    {
        .sk_nodraw_canvas_destroy (param0);
    }

    // sk_nodraw_canvas_t* sk_nodraw_canvas_new(int width, int height)
    static sk_nodraw_canvas_t* sk_nodraw_canvas_new (int width, int height)
    {
        return .sk_nodraw_canvas_new (width, height);
    }

    // void sk_nway_canvas_add_canvas(sk_nway_canvas_t*, sk_canvas_t* canvas)
    static void sk_nway_canvas_add_canvas (sk_nway_canvas_t* param0, sk_canvas_t* canvas)
    {
        .sk_nway_canvas_add_canvas (param0, canvas);
    }

    // void sk_nway_canvas_destroy(sk_nway_canvas_t*)
    static void sk_nway_canvas_destroy (sk_nway_canvas_t* param0)
    {
        .sk_nway_canvas_destroy (param0);
    }

    // sk_nway_canvas_t* sk_nway_canvas_new(int width, int height)
    static sk_nway_canvas_t* sk_nway_canvas_new (int width, int height)
    {
        return .sk_nway_canvas_new (width, height);
    }

    // void sk_nway_canvas_remove_all(sk_nway_canvas_t*)
    static void sk_nway_canvas_remove_all (sk_nway_canvas_t* param0)
    {
        .sk_nway_canvas_remove_all (param0);
    }

    // void sk_nway_canvas_remove_canvas(sk_nway_canvas_t*, sk_canvas_t* canvas)
    static void sk_nway_canvas_remove_canvas (sk_nway_canvas_t* param0, sk_canvas_t* canvas)
    {
        .sk_nway_canvas_remove_canvas (param0, canvas);
    }

    // void sk_overdraw_canvas_destroy(sk_overdraw_canvas_t* canvas)
    static void sk_overdraw_canvas_destroy (sk_overdraw_canvas_t* canvas)
    {
        .sk_overdraw_canvas_destroy (canvas);
    }

    // sk_overdraw_canvas_t* sk_overdraw_canvas_new(sk_canvas_t* canvas)
    static sk_overdraw_canvas_t* sk_overdraw_canvas_new (sk_canvas_t* canvas)
    {
        return .sk_overdraw_canvas_new (canvas);
    }

    // end header: sk_canvas.h

    // for header: sk_codec.h

    // void sk_codec_destroy(sk_codec_t* codec)
    static void sk_codec_destroy (sk_codec_t* codec)
    {
        .sk_codec_destroy (codec);
    }

    // sk_encoded_image_format_t sk_codec_get_encoded_format(sk_codec_t* codec)
    static SKEncodedImageFormat sk_codec_get_encoded_format (sk_codec_t* codec)
    {
        return .sk_codec_get_encoded_format (codec);
    }

    // int sk_codec_get_frame_count(sk_codec_t* codec)
    static int sk_codec_get_frame_count (sk_codec_t* codec)
    {
        return .sk_codec_get_frame_count (codec);
    }

    // void sk_codec_get_frame_info(sk_codec_t* codec, sk_codec_frameinfo_t* frameInfo)
    static void sk_codec_get_frame_info (sk_codec_t* codec, SKCodecFrameInfo* frameInfo)
    {
        .sk_codec_get_frame_info (codec, frameInfo);
    }

    // bool sk_codec_get_frame_info_for_index(sk_codec_t* codec, int index, sk_codec_frameinfo_t* frameInfo)
    static bool sk_codec_get_frame_info_for_index (sk_codec_t* codec, int index, SKCodecFrameInfo* frameInfo)
    {
        return .sk_codec_get_frame_info_for_index (codec, index, frameInfo);
    }

    // void sk_codec_get_info(sk_codec_t* codec, sk_imageinfo_t* info)
    static void sk_codec_get_info (sk_codec_t* codec, SKImageInfoNative* info)
    {
        .sk_codec_get_info (codec, info);
    }

    // sk_encodedorigin_t sk_codec_get_origin(sk_codec_t* codec)
    static SKEncodedOrigin sk_codec_get_origin (sk_codec_t* codec)
    {
        return .sk_codec_get_origin (codec);
    }

    // sk_codec_result_t sk_codec_get_pixels(sk_codec_t* codec, const sk_imageinfo_t* info, void* pixels, size_t rowBytes, const sk_codec_options_t* options)
    static SKCodecResult sk_codec_get_pixels (sk_codec_t* codec, SKImageInfoNative* info, void* pixels, size_t rowBytes, SKCodecOptionsInternal* options)
    {
        return .sk_codec_get_pixels (codec, info, pixels, rowBytes, options);
    }

    // int sk_codec_get_repetition_count(sk_codec_t* codec)
    static int sk_codec_get_repetition_count (sk_codec_t* codec)
    {
        return .sk_codec_get_repetition_count (codec);
    }

    // void sk_codec_get_scaled_dimensions(sk_codec_t* codec, float desiredScale, sk_isize_t* dimensions)
    static void sk_codec_get_scaled_dimensions (sk_codec_t* codec, float desiredScale, SKSizeI* dimensions)
    {
        .sk_codec_get_scaled_dimensions (codec, desiredScale, dimensions);
    }

    // sk_codec_scanline_order_t sk_codec_get_scanline_order(sk_codec_t* codec)
    static SKCodecScanlineOrder sk_codec_get_scanline_order (sk_codec_t* codec)
    {
        return .sk_codec_get_scanline_order (codec);
    }

    // int sk_codec_get_scanlines(sk_codec_t* codec, void* dst, int countLines, size_t rowBytes)
    static int sk_codec_get_scanlines (sk_codec_t* codec, void* dst, int countLines, size_t rowBytes)
    {
        return .sk_codec_get_scanlines (codec, dst, countLines, rowBytes);
    }

    // bool sk_codec_get_valid_subset(sk_codec_t* codec, sk_irect_t* desiredSubset)
    static bool sk_codec_get_valid_subset (sk_codec_t* codec, SKRectI* desiredSubset)
    {
        return .sk_codec_get_valid_subset (codec, desiredSubset);
    }

    // sk_codec_result_t sk_codec_incremental_decode(sk_codec_t* codec, int* rowsDecoded)
    static SKCodecResult sk_codec_incremental_decode (sk_codec_t* codec, int* rowsDecoded)
    {
        return .sk_codec_incremental_decode (codec, rowsDecoded);
    }

    // size_t sk_codec_min_buffered_bytes_needed()
    static size_t sk_codec_min_buffered_bytes_needed ()
    {
        return .sk_codec_min_buffered_bytes_needed ();
    }

    // sk_codec_t* sk_codec_new_from_data(sk_data_t* data)
    static sk_codec_t* sk_codec_new_from_data (sk_data_t* data)
    {
        return .sk_codec_new_from_data (data);
    }

    // sk_codec_t* sk_codec_new_from_stream(sk_stream_t* stream, sk_codec_result_t* result)
    static sk_codec_t* sk_codec_new_from_stream (sk_stream_t* stream, SKCodecResult* result)
    {
        return .sk_codec_new_from_stream (stream, result);
    }

    // int sk_codec_next_scanline(sk_codec_t* codec)
    static int sk_codec_next_scanline (sk_codec_t* codec)
    {
        return .sk_codec_next_scanline (codec);
    }

    // int sk_codec_output_scanline(sk_codec_t* codec, int inputScanline)
    static int sk_codec_output_scanline (sk_codec_t* codec, int inputScanline)
    {
        return .sk_codec_output_scanline (codec, inputScanline);
    }

    // bool sk_codec_skip_scanlines(sk_codec_t* codec, int countLines)
    static bool sk_codec_skip_scanlines (sk_codec_t* codec, int countLines)
    {
        return .sk_codec_skip_scanlines (codec, countLines);
    }

    // sk_codec_result_t sk_codec_start_incremental_decode(sk_codec_t* codec, const sk_imageinfo_t* info, void* pixels, size_t rowBytes, const sk_codec_options_t* options)
    static SKCodecResult sk_codec_start_incremental_decode (sk_codec_t* codec, SKImageInfoNative* info, void* pixels, size_t rowBytes, SKCodecOptionsInternal* options)
    {
        return .sk_codec_start_incremental_decode (codec, info, pixels, rowBytes, options);
    }

    // sk_codec_result_t sk_codec_start_scanline_decode(sk_codec_t* codec, const sk_imageinfo_t* info, const sk_codec_options_t* options)
    static SKCodecResult sk_codec_start_scanline_decode (sk_codec_t* codec, SKImageInfoNative* info, SKCodecOptionsInternal* options)
    {
        return .sk_codec_start_scanline_decode (codec, info, options);
    }

    // end header: sk_codec.h

    // for header: sk_colorfilter.h

    // sk_colorfilter_t* sk_colorfilter_new_color_matrix(const float[20] array = 20)
    static sk_colorfilter_t* sk_colorfilter_new_color_matrix (float* array)
    {
        return .sk_colorfilter_new_color_matrix (array);
    }

    // sk_colorfilter_t* sk_colorfilter_new_compose(sk_colorfilter_t* outer, sk_colorfilter_t* inner)
    static sk_colorfilter_t* sk_colorfilter_new_compose (sk_colorfilter_t* outer, sk_colorfilter_t* inner)
    {
        return .sk_colorfilter_new_compose (outer, inner);
    }

    // sk_colorfilter_t* sk_colorfilter_new_high_contrast(const sk_highcontrastconfig_t* config)
    static sk_colorfilter_t* sk_colorfilter_new_high_contrast (SKHighContrastConfig* config)
    {
        return .sk_colorfilter_new_high_contrast (config);
    }

    // sk_colorfilter_t* sk_colorfilter_new_lighting(sk_color_t mul, sk_color_t add)
    static sk_colorfilter_t* sk_colorfilter_new_lighting (uint mul, uint add)
    {
        return .sk_colorfilter_new_lighting (mul, add);
    }

    // sk_colorfilter_t* sk_colorfilter_new_luma_color()
    static sk_colorfilter_t* sk_colorfilter_new_luma_color ()
    {
        return .sk_colorfilter_new_luma_color ();
    }

    // sk_colorfilter_t* sk_colorfilter_new_mode(sk_color_t c, sk_blendmode_t mode)
    static sk_colorfilter_t* sk_colorfilter_new_mode (uint c, SKBlendMode mode)
    {
        return .sk_colorfilter_new_mode (c, mode);
    }

    // sk_colorfilter_t* sk_colorfilter_new_table(const uint8_t[256] table = 256)
    static sk_colorfilter_t* sk_colorfilter_new_table (ubyte* table)
    {
        return .sk_colorfilter_new_table (table);
    }

    // sk_colorfilter_t* sk_colorfilter_new_table_argb(const uint8_t[256] tableA = 256, const uint8_t[256] tableR = 256, const uint8_t[256] tableG = 256, const uint8_t[256] tableB = 256)
    static sk_colorfilter_t* sk_colorfilter_new_table_argb (ubyte* tableA, ubyte* tableR, ubyte* tableG, ubyte* tableB)
    {
        return .sk_colorfilter_new_table_argb (tableA, tableR, tableG, tableB);
    }

    // void sk_colorfilter_unref(sk_colorfilter_t* filter)
    static void sk_colorfilter_unref (sk_colorfilter_t* filter)
    {
        .sk_colorfilter_unref (filter);
    }

    // end header: sk_colorfilter.h

    // for header: sk_colorspace.h

    // void sk_color4f_from_color(sk_color_t color, sk_color4f_t* color4f)
    static void sk_color4f_from_color (uint color, SKColorF* color4f)
    {
        .sk_color4f_from_color (color, color4f);
    }

    // sk_color_t sk_color4f_to_color(const sk_color4f_t* color4f)
    static uint sk_color4f_to_color (SKColorF* color4f)
    {
        return .sk_color4f_to_color (color4f);
    }

    // bool sk_colorspace_equals(const sk_colorspace_t* src, const sk_colorspace_t* dst)
    static bool sk_colorspace_equals (sk_colorspace_t* src, sk_colorspace_t* dst)
    {
        return .sk_colorspace_equals (src, dst);
    }

    // bool sk_colorspace_gamma_close_to_srgb(const sk_colorspace_t* colorspace)
    static bool sk_colorspace_gamma_close_to_srgb (sk_colorspace_t* colorspace)
    {
        return .sk_colorspace_gamma_close_to_srgb (colorspace);
    }

    // bool sk_colorspace_gamma_is_linear(const sk_colorspace_t* colorspace)
    static bool sk_colorspace_gamma_is_linear (sk_colorspace_t* colorspace)
    {
        return .sk_colorspace_gamma_is_linear (colorspace);
    }

    // void sk_colorspace_icc_profile_delete(sk_colorspace_icc_profile_t* profile)
    static void sk_colorspace_icc_profile_delete (sk_colorspace_icc_profile_t* profile)
    {
        .sk_colorspace_icc_profile_delete (profile);
    }

    // const uint8_t* sk_colorspace_icc_profile_get_buffer(const sk_colorspace_icc_profile_t* profile, uint32_t* size)
    static ubyte* sk_colorspace_icc_profile_get_buffer (sk_colorspace_icc_profile_t* profile, uint* size)
    {
        return cast(ubyte*).sk_colorspace_icc_profile_get_buffer (profile, size);
    }

    // bool sk_colorspace_icc_profile_get_to_xyzd50(const sk_colorspace_icc_profile_t* profile, sk_colorspace_xyz_t* toXYZD50)
    static bool sk_colorspace_icc_profile_get_to_xyzd50 (sk_colorspace_icc_profile_t* profile, SKColorSpaceXyz* toXYZD50)
    {
        return .sk_colorspace_icc_profile_get_to_xyzd50 (profile, toXYZD50);
    }

    // sk_colorspace_icc_profile_t* sk_colorspace_icc_profile_new()
    static sk_colorspace_icc_profile_t* sk_colorspace_icc_profile_new ()
    {
        return .sk_colorspace_icc_profile_new ();
    }

    // bool sk_colorspace_icc_profile_parse(const(void)* buffer, size_t length, sk_colorspace_icc_profile_t* profile)
    static bool sk_colorspace_icc_profile_parse (void* buffer, size_t length, sk_colorspace_icc_profile_t* profile)
    {
        return .sk_colorspace_icc_profile_parse (buffer, length, profile);
    }

    // bool sk_colorspace_is_numerical_transfer_fn(const sk_colorspace_t* colorspace, sk_colorspace_transfer_fn_t* transferFn)
    static bool sk_colorspace_is_numerical_transfer_fn (sk_colorspace_t* colorspace, SKColorSpaceTransferFn* transferFn)
    {
        return .sk_colorspace_is_numerical_transfer_fn (colorspace, transferFn);
    }

    // bool sk_colorspace_is_srgb(const sk_colorspace_t* colorspace)
    static bool sk_colorspace_is_srgb (sk_colorspace_t* colorspace)
    {
        return .sk_colorspace_is_srgb (colorspace);
    }

    // sk_colorspace_t* sk_colorspace_make_linear_gamma(const sk_colorspace_t* colorspace)
    static sk_colorspace_t* sk_colorspace_make_linear_gamma (sk_colorspace_t* colorspace)
    {
        return .sk_colorspace_make_linear_gamma (colorspace);
    }

    // sk_colorspace_t* sk_colorspace_make_srgb_gamma(const sk_colorspace_t* colorspace)
    static sk_colorspace_t* sk_colorspace_make_srgb_gamma (sk_colorspace_t* colorspace)
    {
        return .sk_colorspace_make_srgb_gamma (colorspace);
    }

    // sk_colorspace_t* sk_colorspace_new_icc(const sk_colorspace_icc_profile_t* profile)
    static sk_colorspace_t* sk_colorspace_new_icc (sk_colorspace_icc_profile_t* profile)
    {
        return .sk_colorspace_new_icc (profile);
    }

    // sk_colorspace_t* sk_colorspace_new_rgb(const sk_colorspace_transfer_fn_t* transferFn, const sk_colorspace_xyz_t* toXYZD50)
    static sk_colorspace_t* sk_colorspace_new_rgb (SKColorSpaceTransferFn* transferFn, SKColorSpaceXyz* toXYZD50)
    {
        return .sk_colorspace_new_rgb (transferFn, toXYZD50);
    }

    // sk_colorspace_t* sk_colorspace_new_srgb()
    static sk_colorspace_t* sk_colorspace_new_srgb ()
    {
        return .sk_colorspace_new_srgb ();
    }

    // sk_colorspace_t* sk_colorspace_new_srgb_linear()
    static sk_colorspace_t* sk_colorspace_new_srgb_linear ()
    {
        return .sk_colorspace_new_srgb_linear ();
    }

    // bool sk_colorspace_primaries_to_xyzd50(const sk_colorspace_primaries_t* primaries, sk_colorspace_xyz_t* toXYZD50)
    static bool sk_colorspace_primaries_to_xyzd50 (SKColorSpacePrimaries* primaries, SKColorSpaceXyz* toXYZD50)
    {
        return .sk_colorspace_primaries_to_xyzd50 (primaries, toXYZD50);
    }

    // void sk_colorspace_ref(sk_colorspace_t* colorspace)
    static void sk_colorspace_ref (sk_colorspace_t* colorspace)
    {
        .sk_colorspace_ref (colorspace);
    }

    // void sk_colorspace_to_profile(const sk_colorspace_t* colorspace, sk_colorspace_icc_profile_t* profile)
    static void sk_colorspace_to_profile (sk_colorspace_t* colorspace, sk_colorspace_icc_profile_t* profile)
    {
        .sk_colorspace_to_profile (colorspace, profile);
    }

    // bool sk_colorspace_to_xyzd50(const sk_colorspace_t* colorspace, sk_colorspace_xyz_t* toXYZD50)
    static bool sk_colorspace_to_xyzd50 (sk_colorspace_t* colorspace, SKColorSpaceXyz* toXYZD50)
    {
        return .sk_colorspace_to_xyzd50 (colorspace, toXYZD50);
    }

    // float sk_colorspace_transfer_fn_eval(const sk_colorspace_transfer_fn_t* transferFn, float x)
    static float sk_colorspace_transfer_fn_eval (SKColorSpaceTransferFn* transferFn, float x)
    {
        return .sk_colorspace_transfer_fn_eval (transferFn, x);
    }

    // bool sk_colorspace_transfer_fn_invert(const sk_colorspace_transfer_fn_t* src, sk_colorspace_transfer_fn_t* dst)
    static bool sk_colorspace_transfer_fn_invert (SKColorSpaceTransferFn* src, SKColorSpaceTransferFn* dst)
    {
        return .sk_colorspace_transfer_fn_invert (src, dst);
    }

    // void sk_colorspace_transfer_fn_named_2dot2(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_2dot2 (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_2dot2 (transferFn);
    }

    // void sk_colorspace_transfer_fn_named_hlg(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_hlg (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_hlg (transferFn);
    }

    // void sk_colorspace_transfer_fn_named_linear(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_linear (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_linear (transferFn);
    }

    // void sk_colorspace_transfer_fn_named_pq(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_pq (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_pq (transferFn);
    }

    // void sk_colorspace_transfer_fn_named_rec2020(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_rec2020 (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_rec2020 (transferFn);
    }

    // void sk_colorspace_transfer_fn_named_srgb(sk_colorspace_transfer_fn_t* transferFn)
    static void sk_colorspace_transfer_fn_named_srgb (SKColorSpaceTransferFn* transferFn)
    {
        .sk_colorspace_transfer_fn_named_srgb (transferFn);
    }

    // void sk_colorspace_unref(sk_colorspace_t* colorspace)
    static void sk_colorspace_unref (sk_colorspace_t* colorspace)
    {
        .sk_colorspace_unref (colorspace);
    }

    // void sk_colorspace_xyz_concat(const sk_colorspace_xyz_t* a, const sk_colorspace_xyz_t* b, sk_colorspace_xyz_t* result)
    static void sk_colorspace_xyz_concat (SKColorSpaceXyz* a, SKColorSpaceXyz* b, SKColorSpaceXyz* result)
    {
        .sk_colorspace_xyz_concat (a, b, result);
    }

    // bool sk_colorspace_xyz_invert(const sk_colorspace_xyz_t* src, sk_colorspace_xyz_t* dst)
    static bool sk_colorspace_xyz_invert (SKColorSpaceXyz* src, SKColorSpaceXyz* dst)
    {
        return .sk_colorspace_xyz_invert (src, dst);
    }

    // void sk_colorspace_xyz_named_adobe_rgb(sk_colorspace_xyz_t* xyz)
    static void sk_colorspace_xyz_named_adobe_rgb (SKColorSpaceXyz* xyz)
    {
        .sk_colorspace_xyz_named_adobe_rgb (xyz);
    }

    // void sk_colorspace_xyz_named_dcip3(sk_colorspace_xyz_t* xyz)
    static void sk_colorspace_xyz_named_dcip3 (SKColorSpaceXyz* xyz)
    {
        .sk_colorspace_xyz_named_dcip3 (xyz);
    }

    // void sk_colorspace_xyz_named_rec2020(sk_colorspace_xyz_t* xyz)
    static void sk_colorspace_xyz_named_rec2020 (SKColorSpaceXyz* xyz)
    {
        .sk_colorspace_xyz_named_rec2020 (xyz);
    }

    // void sk_colorspace_xyz_named_srgb(sk_colorspace_xyz_t* xyz)
    static void sk_colorspace_xyz_named_srgb (SKColorSpaceXyz* xyz)
    {
        .sk_colorspace_xyz_named_srgb (xyz);
    }

    // void sk_colorspace_xyz_named_xyz(sk_colorspace_xyz_t* xyz)
    static void sk_colorspace_xyz_named_xyz (SKColorSpaceXyz* xyz)
    {
        .sk_colorspace_xyz_named_xyz (xyz);
    }

    // end header: sk_colorspace.h

    // for header: sk_colortable.h

    // int sk_colortable_count(const sk_colortable_t* ctable)
    static int sk_colortable_count (sk_colortable_t* ctable)
    {
        return .sk_colortable_count (ctable);
    }

    // sk_colortable_t* sk_colortable_new(const sk_pmcolor_t* colors, int count)
    static sk_colortable_t* sk_colortable_new (uint* colors, int count)
    {
        return .sk_colortable_new (colors, count);
    }

    // void sk_colortable_read_colors(const sk_colortable_t* ctable, sk_pmcolor_t** colors)
    static void sk_colortable_read_colors (sk_colortable_t* ctable, uint** colors)
    {
        .sk_colortable_read_colors (ctable, colors);
    }

    // void sk_colortable_unref(sk_colortable_t* ctable)
    static void sk_colortable_unref (sk_colortable_t* ctable)
    {
        .sk_colortable_unref (ctable);
    }

    // end header: sk_colortable.h

    // for header: sk_data.h

    // const uint8_t* sk_data_get_bytes(const sk_data_t*)
    static ubyte* sk_data_get_bytes (sk_data_t* param0)
    {
        return cast(ubyte*).sk_data_get_bytes (param0);
    }

    // const(void)* sk_data_get_data(const sk_data_t*)
    static void* sk_data_get_data (sk_data_t* param0)
    {
        return .sk_data_get_data (param0);
    }

    // size_t sk_data_get_size(const sk_data_t*)
    static size_t sk_data_get_size (sk_data_t* param0)
    {
        return .sk_data_get_size (param0);
    }

    // sk_data_t* sk_data_new_empty()
    static sk_data_t* sk_data_new_empty ()
    {
        return .sk_data_new_empty ();
    }

    // sk_data_t* sk_data_new_from_file(const(char)* path)
    static sk_data_t* sk_data_new_from_file ( string path)
    {
        return .sk_data_new_from_file (path.toStringz());
    }

    // sk_data_t* sk_data_new_from_stream(sk_stream_t* stream, size_t length)
    static sk_data_t* sk_data_new_from_stream (sk_stream_t* stream, size_t length)
    {
        return .sk_data_new_from_stream (stream, length);
    }

    // sk_data_t* sk_data_new_subset(const sk_data_t* src, size_t offset, size_t length)
    static sk_data_t* sk_data_new_subset (sk_data_t* src, size_t offset, size_t length)
    {
        return .sk_data_new_subset (src, offset, length);
    }

    // sk_data_t* sk_data_new_uninitialized(size_t size)
    static sk_data_t* sk_data_new_uninitialized (size_t size)
    {
        return .sk_data_new_uninitialized (size);
    }

    // sk_data_t* sk_data_new_with_copy(const(void)* src, size_t length)
    static sk_data_t* sk_data_new_with_copy (void* src, size_t length)
    {
        return .sk_data_new_with_copy (src, length);
    }

    // sk_data_t* sk_data_new_with_proc(const(void)* ptr, size_t length, sk_data_release_proc proc, void* ctx)
    static sk_data_t* sk_data_new_with_proc (void* ptr, size_t length, SKDataReleaseProxyDelegate proc, void* ctx)
    {
        return .sk_data_new_with_proc (ptr, length, proc, ctx);
    }

    // void sk_data_ref(const sk_data_t*)
    static void sk_data_ref (sk_data_t* param0)
    {
        .sk_data_ref (param0);
    }

    // void sk_data_unref(const sk_data_t*)
    static void sk_data_unref (sk_data_t* param0)
    {
        .sk_data_unref (param0);
    }

    // end header: sk_data.h

    // for header: sk_document.h

    // void sk_document_abort(sk_document_t* document)
    static void sk_document_abort (sk_document_t* document)
    {
        .sk_document_abort (document);
    }

    // sk_canvas_t* sk_document_begin_page(sk_document_t* document, float width, float height, const sk_rect_t* content)
    static sk_canvas_t* sk_document_begin_page (sk_document_t* document, float width, float height, SKRect* content)
    {
        return .sk_document_begin_page (document, width, height, content);
    }

    // void sk_document_close(sk_document_t* document)
    static void sk_document_close (sk_document_t* document)
    {
        .sk_document_close (document);
    }

    // sk_document_t* sk_document_create_pdf_from_stream(sk_wstream_t* stream)
    static sk_document_t* sk_document_create_pdf_from_stream (sk_wstream_t* stream)
    {
        return .sk_document_create_pdf_from_stream (stream);
    }

    // sk_document_t* sk_document_create_pdf_from_stream_with_metadata(sk_wstream_t* stream, const sk_document_pdf_metadata_t* metadata)
    static sk_document_t* sk_document_create_pdf_from_stream_with_metadata (sk_wstream_t* stream, SKDocumentPdfMetadataInternal* metadata)
    {
        return .sk_document_create_pdf_from_stream_with_metadata (stream, metadata);
    }

    // sk_document_t* sk_document_create_xps_from_stream(sk_wstream_t* stream, float dpi)
    static sk_document_t* sk_document_create_xps_from_stream (sk_wstream_t* stream, float dpi)
    {
        return .sk_document_create_xps_from_stream (stream, dpi);
    }

    // void sk_document_end_page(sk_document_t* document)
    static void sk_document_end_page (sk_document_t* document)
    {
        .sk_document_end_page (document);
    }

    // void sk_document_unref(sk_document_t* document)
    static void sk_document_unref (sk_document_t* document)
    {
        .sk_document_unref (document);
    }

    // end header: sk_document.h

    // for header: sk_drawable.h

    // void sk_drawable_draw(sk_drawable_t*, sk_canvas_t*, const sk_matrix_t*)
    static void sk_drawable_draw (sk_drawable_t* param0, sk_canvas_t* param1, SKMatrix* param2)
    {
        .sk_drawable_draw (param0, param1, param2);
    }

    // void sk_drawable_get_bounds(sk_drawable_t*, sk_rect_t*)
    static void sk_drawable_get_bounds (sk_drawable_t* param0, SKRect* param1)
    {
        .sk_drawable_get_bounds (param0, param1);
    }

    // uint32_t sk_drawable_get_generation_id(sk_drawable_t*)
    static uint sk_drawable_get_generation_id (sk_drawable_t* param0)
    {
        return .sk_drawable_get_generation_id (param0);
    }

    // sk_picture_t* sk_drawable_new_picture_snapshot(sk_drawable_t*)
    static sk_picture_t* sk_drawable_new_picture_snapshot (sk_drawable_t* param0)
    {
        return .sk_drawable_new_picture_snapshot (param0);
    }

    // void sk_drawable_notify_drawing_changed(sk_drawable_t*)
    static void sk_drawable_notify_drawing_changed (sk_drawable_t* param0)
    {
        .sk_drawable_notify_drawing_changed (param0);
    }

    // void sk_drawable_unref(sk_drawable_t*)
    static void sk_drawable_unref (sk_drawable_t* param0)
    {
        .sk_drawable_unref (param0);
    }

    // end header: sk_drawable.h

    // for header: sk_font.h

    // size_t sk_font_break_text(const sk_font_t* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, float maxWidth, float* measuredWidth, const sk_paint_t* paint)
    static size_t sk_font_break_text (sk_font_t* font, void* text, size_t byteLength, SKTextEncoding encoding, float maxWidth, float* measuredWidth, sk_paint_t* paint)
    {
        return .sk_font_break_text (font, text, byteLength, encoding, maxWidth, measuredWidth, paint);
    }

    // void sk_font_delete(sk_font_t* font)
    static void sk_font_delete (sk_font_t* font)
    {
        .sk_font_delete (font);
    }

    // sk_font_edging_t sk_font_get_edging(const sk_font_t* font)
    static SKFontEdging sk_font_get_edging (sk_font_t* font)
    {
        return .sk_font_get_edging (font);
    }

    // sk_font_hinting_t sk_font_get_hinting(const sk_font_t* font)
    static SKFontHinting sk_font_get_hinting (sk_font_t* font)
    {
        return .sk_font_get_hinting (font);
    }

    // float sk_font_get_metrics(const sk_font_t* font, sk_fontmetrics_t* metrics)
    static float sk_font_get_metrics (sk_font_t* font, SKFontMetrics* metrics)
    {
        return .sk_font_get_metrics (font, metrics);
    }

    // bool sk_font_get_path(const sk_font_t* font, uint16_t glyph, sk_path_t* path)
    static bool sk_font_get_path (sk_font_t* font, ushort glyph, sk_path_t* path)
    {
        return .sk_font_get_path (font, glyph, path);
    }

    // void sk_font_get_paths(const sk_font_t* font, uint16_t* glyphs, int count, const sk_glyph_path_proc glyphPathProc, void* context)
    static void sk_font_get_paths (sk_font_t* font, ushort* glyphs, int count, SKGlyphPathProxyDelegate glyphPathProc, void* context)
    {
        .sk_font_get_paths (font, glyphs, count, glyphPathProc, context);
    }

    // void sk_font_get_pos(const sk_font_t* font, const uint16_t* glyphs, int count, sk_point_t* pos, sk_point_t* origin)
    static void sk_font_get_pos (sk_font_t* font, ushort* glyphs, int count, SKPoint* pos, SKPoint* origin)
    {
        .sk_font_get_pos (font, glyphs, count, pos, origin);
    }

    // float sk_font_get_scale_x(const sk_font_t* font)
    static float sk_font_get_scale_x (sk_font_t* font)
    {
        return .sk_font_get_scale_x (font);
    }

    // float sk_font_get_size(const sk_font_t* font)
    static float sk_font_get_size (sk_font_t* font)
    {
        return .sk_font_get_size (font);
    }

    // float sk_font_get_skew_x(const sk_font_t* font)
    static float sk_font_get_skew_x (sk_font_t* font)
    {
        return .sk_font_get_skew_x (font);
    }

    // sk_typeface_t* sk_font_get_typeface(const sk_font_t* font)
    static sk_typeface_t* sk_font_get_typeface (sk_font_t* font)
    {
        return .sk_font_get_typeface (font);
    }

    // void sk_font_get_widths_bounds(const sk_font_t* font, const uint16_t* glyphs, int count, float* widths, sk_rect_t* bounds, const sk_paint_t* paint)
    static void sk_font_get_widths_bounds (sk_font_t* font, ushort* glyphs, int count, float* widths, SKRect* bounds, sk_paint_t* paint)
    {
        .sk_font_get_widths_bounds (font, glyphs, count, widths, bounds, paint);
    }

    // void sk_font_get_xpos(const sk_font_t* font, const uint16_t* glyphs, int count, float* xpos, float origin)
    static void sk_font_get_xpos (sk_font_t* font, ushort* glyphs, int count, float* xpos, float origin)
    {
        .sk_font_get_xpos (font, glyphs, count, xpos, origin);
    }

    // bool sk_font_is_baseline_snap(const sk_font_t* font)
    static bool sk_font_is_baseline_snap (sk_font_t* font)
    {
        return .sk_font_is_baseline_snap (font);
    }

    // bool sk_font_is_embedded_bitmaps(const sk_font_t* font)
    static bool sk_font_is_embedded_bitmaps (sk_font_t* font)
    {
        return .sk_font_is_embedded_bitmaps (font);
    }

    // bool sk_font_is_embolden(const sk_font_t* font)
    static bool sk_font_is_embolden (sk_font_t* font)
    {
        return .sk_font_is_embolden (font);
    }

    // bool sk_font_is_force_auto_hinting(const sk_font_t* font)
    static bool sk_font_is_force_auto_hinting (sk_font_t* font)
    {
        return .sk_font_is_force_auto_hinting (font);
    }

    // bool sk_font_is_linear_metrics(const sk_font_t* font)
    static bool sk_font_is_linear_metrics (sk_font_t* font)
    {
        return .sk_font_is_linear_metrics (font);
    }

    // bool sk_font_is_subpixel(const sk_font_t* font)
    static bool sk_font_is_subpixel (sk_font_t* font)
    {
        return .sk_font_is_subpixel (font);
    }

    // float sk_font_measure_text(const sk_font_t* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, sk_rect_t* bounds, const sk_paint_t* paint)
    static float sk_font_measure_text (sk_font_t* font, void* text, size_t byteLength, SKTextEncoding encoding, SKRect* bounds, sk_paint_t* paint)
    {
        return .sk_font_measure_text (font, text, byteLength, encoding, bounds, paint);
    }

    // void sk_font_measure_text_no_return(const sk_font_t* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, sk_rect_t* bounds, const sk_paint_t* paint, float* measuredWidth)
    static void sk_font_measure_text_no_return (sk_font_t* font, void* text, size_t byteLength, SKTextEncoding encoding, SKRect* bounds, sk_paint_t* paint, float* measuredWidth)
    {
        .sk_font_measure_text_no_return (font, text, byteLength, encoding, bounds, paint, measuredWidth);
    }

    // sk_font_t* sk_font_new()
    static sk_font_t* sk_font_new ()
    {
        return .sk_font_new ();
    }

    // sk_font_t* sk_font_new_with_values(sk_typeface_t* typeface, float size, float scaleX, float skewX)
    static sk_font_t* sk_font_new_with_values (sk_typeface_t* typeface, float size, float scaleX, float skewX)
    {
        return .sk_font_new_with_values (typeface, size, scaleX, skewX);
    }

    // void sk_font_set_baseline_snap(sk_font_t* font, bool value)
    static void sk_font_set_baseline_snap (sk_font_t* font, bool value)
    {
        .sk_font_set_baseline_snap (font, value);
    }

    // void sk_font_set_edging(sk_font_t* font, sk_font_edging_t value)
    static void sk_font_set_edging (sk_font_t* font, SKFontEdging value)
    {
        .sk_font_set_edging (font, value);
    }

    // void sk_font_set_embedded_bitmaps(sk_font_t* font, bool value)
    static void sk_font_set_embedded_bitmaps (sk_font_t* font, bool value)
    {
        .sk_font_set_embedded_bitmaps (font, value);
    }

    // void sk_font_set_embolden(sk_font_t* font, bool value)
    static void sk_font_set_embolden (sk_font_t* font, bool value)
    {
        .sk_font_set_embolden (font, value);
    }

    // void sk_font_set_force_auto_hinting(sk_font_t* font, bool value)
    static void sk_font_set_force_auto_hinting (sk_font_t* font, bool value)
    {
        .sk_font_set_force_auto_hinting (font, value);
    }

    // void sk_font_set_hinting(sk_font_t* font, sk_font_hinting_t value)
    static void sk_font_set_hinting (sk_font_t* font, SKFontHinting value)
    {
        .sk_font_set_hinting (font, value);
    }

    // void sk_font_set_linear_metrics(sk_font_t* font, bool value)
    static void sk_font_set_linear_metrics (sk_font_t* font, bool value)
    {
        .sk_font_set_linear_metrics (font, value);
    }

    // void sk_font_set_scale_x(sk_font_t* font, float value)
    static void sk_font_set_scale_x (sk_font_t* font, float value)
    {
        .sk_font_set_scale_x (font, value);
    }

    // void sk_font_set_size(sk_font_t* font, float value)
    static void sk_font_set_size (sk_font_t* font, float value)
    {
        .sk_font_set_size (font, value);
    }

    // void sk_font_set_skew_x(sk_font_t* font, float value)
    static void sk_font_set_skew_x (sk_font_t* font, float value)
    {
        .sk_font_set_skew_x (font, value);
    }

    // void sk_font_set_subpixel(sk_font_t* font, bool value)
    static void sk_font_set_subpixel (sk_font_t* font, bool value)
    {
        .sk_font_set_subpixel (font, value);
    }

    // void sk_font_set_typeface(sk_font_t* font, sk_typeface_t* value)
    static void sk_font_set_typeface (sk_font_t* font, sk_typeface_t* value)
    {
        .sk_font_set_typeface (font, value);
    }

    // int sk_font_text_to_glyphs(const sk_font_t* font, const(void)* text, size_t byteLength, sk_text_encoding_t encoding, uint16_t* glyphs, int maxGlyphCount)
    static int sk_font_text_to_glyphs (sk_font_t* font, void* text, size_t byteLength, SKTextEncoding encoding, ushort* glyphs, int maxGlyphCount)
    {
        return .sk_font_text_to_glyphs (font, text, byteLength, encoding, glyphs, maxGlyphCount);
    }

    // uint16_t sk_font_unichar_to_glyph(const sk_font_t* font, int32_t uni)
    static ushort sk_font_unichar_to_glyph (sk_font_t* font, int uni)
    {
        return .sk_font_unichar_to_glyph (font, uni);
    }

    // void sk_font_unichars_to_glyphs(const sk_font_t* font, const int32_t* uni, int count, uint16_t* glyphs)
    static void sk_font_unichars_to_glyphs (sk_font_t* font, int* uni, int count, ushort* glyphs)
    {
        .sk_font_unichars_to_glyphs (font, uni, count, glyphs);
    }

    // void sk_text_utils_get_path(const(void)* text, size_t length, sk_text_encoding_t encoding, float x, float y, const sk_font_t* font, sk_path_t* path)
    static void sk_text_utils_get_path (void* text, size_t length, SKTextEncoding encoding, float x, float y, sk_font_t* font, sk_path_t* path)
    {
        .sk_text_utils_get_path (text, length, encoding, x, y, font, path);
    }

    // void sk_text_utils_get_pos_path(const(void)* text, size_t length, sk_text_encoding_t encoding, const sk_point_t* pos, const sk_font_t* font, sk_path_t* path)
    static void sk_text_utils_get_pos_path (void* text, size_t length, SKTextEncoding encoding, SKPoint* pos, sk_font_t* font, sk_path_t* path)
    {
        .sk_text_utils_get_pos_path (text, length, encoding, pos, font, path);
    }

    // end header: sk_font.h

    // for header: sk_general.h

    // sk_colortype_t sk_colortype_get_default_8888()
    static SKColorTypeNative sk_colortype_get_default_8888 ()
    {
        return .sk_colortype_get_default_8888 ();
    }

    // int sk_nvrefcnt_get_ref_count(const sk_nvrefcnt_t* refcnt)
    static int sk_nvrefcnt_get_ref_count (sk_nvrefcnt_t* refcnt)
    {
        return .sk_nvrefcnt_get_ref_count (refcnt);
    }

    // void sk_nvrefcnt_safe_ref(sk_nvrefcnt_t* refcnt)
    static void sk_nvrefcnt_safe_ref (sk_nvrefcnt_t* refcnt)
    {
        .sk_nvrefcnt_safe_ref (refcnt);
    }

    // void sk_nvrefcnt_safe_unref(sk_nvrefcnt_t* refcnt)
    static void sk_nvrefcnt_safe_unref (sk_nvrefcnt_t* refcnt)
    {
        .sk_nvrefcnt_safe_unref (refcnt);
    }

    // bool sk_nvrefcnt_unique(const sk_nvrefcnt_t* refcnt)
    static bool sk_nvrefcnt_unique (sk_nvrefcnt_t* refcnt)
    {
        return .sk_nvrefcnt_unique (refcnt);
    }

    // int sk_refcnt_get_ref_count(const sk_refcnt_t* refcnt)
    static int sk_refcnt_get_ref_count (sk_refcnt_t* refcnt)
    {
        return .sk_refcnt_get_ref_count (refcnt);
    }

    // void sk_refcnt_safe_ref(sk_refcnt_t* refcnt)
    static void sk_refcnt_safe_ref (sk_refcnt_t* refcnt)
    {
        .sk_refcnt_safe_ref (refcnt);
    }

    // void sk_refcnt_safe_unref(sk_refcnt_t* refcnt)
    static void sk_refcnt_safe_unref (sk_refcnt_t* refcnt)
    {
        .sk_refcnt_safe_unref (refcnt);
    }

    // bool sk_refcnt_unique(const sk_refcnt_t* refcnt)
    static bool sk_refcnt_unique (sk_refcnt_t* refcnt)
    {
        return .sk_refcnt_unique (refcnt);
    }

    // int sk_version_get_increment()
    static int sk_version_get_increment ()
    {
        return .sk_version_get_increment ();
    }

    // int sk_version_get_milestone()
    static int sk_version_get_milestone ()
    {
        return .sk_version_get_milestone ();
    }

    // const(char)* sk_version_get_string()
    static string sk_version_get_string ()
    {
        const(char)* v = .sk_version_get_string ();
        return cast(string)v.fromStringz();
    }

    // end header: sk_general.h

    // for header: sk_graphics.h

    // void sk_graphics_dump_memory_statistics(sk_tracememorydump_t* dump)
    static void sk_graphics_dump_memory_statistics (sk_tracememorydump_t* dump)
    {
        .sk_graphics_dump_memory_statistics (dump);
    }

    // int sk_graphics_get_font_cache_count_limit()
    static int sk_graphics_get_font_cache_count_limit ()
    {
        return .sk_graphics_get_font_cache_count_limit ();
    }

    // int sk_graphics_get_font_cache_count_used()
    static int sk_graphics_get_font_cache_count_used ()
    {
        return .sk_graphics_get_font_cache_count_used ();
    }

    // size_t sk_graphics_get_font_cache_limit()
    static size_t sk_graphics_get_font_cache_limit ()
    {
        return .sk_graphics_get_font_cache_limit ();
    }

    // int sk_graphics_get_font_cache_point_size_limit()
    static int sk_graphics_get_font_cache_point_size_limit ()
    {
        return .sk_graphics_get_font_cache_point_size_limit ();
    }

    // size_t sk_graphics_get_font_cache_used()
    static size_t sk_graphics_get_font_cache_used ()
    {
        return .sk_graphics_get_font_cache_used ();
    }

    // size_t sk_graphics_get_resource_cache_single_allocation_byte_limit()
    static size_t sk_graphics_get_resource_cache_single_allocation_byte_limit ()
    {
        return .sk_graphics_get_resource_cache_single_allocation_byte_limit ();
    }

    // size_t sk_graphics_get_resource_cache_total_byte_limit()
    static size_t sk_graphics_get_resource_cache_total_byte_limit ()
    {
        return .sk_graphics_get_resource_cache_total_byte_limit ();
    }

    // size_t sk_graphics_get_resource_cache_total_bytes_used()
    static size_t sk_graphics_get_resource_cache_total_bytes_used ()
    {
        return .sk_graphics_get_resource_cache_total_bytes_used ();
    }

    // void sk_graphics_init()
    static void sk_graphics_init ()
    {
        .sk_graphics_init ();
    }

    // void sk_graphics_purge_all_caches()
    static void sk_graphics_purge_all_caches ()
    {
        .sk_graphics_purge_all_caches ();
    }

    // void sk_graphics_purge_font_cache()
    static void sk_graphics_purge_font_cache ()
    {
        .sk_graphics_purge_font_cache ();
    }

    // void sk_graphics_purge_resource_cache()
    static void sk_graphics_purge_resource_cache ()
    {
        .sk_graphics_purge_resource_cache ();
    }

    // int sk_graphics_set_font_cache_count_limit(int count)
    static int sk_graphics_set_font_cache_count_limit (int count)
    {
        return .sk_graphics_set_font_cache_count_limit (count);
    }

    // size_t sk_graphics_set_font_cache_limit(size_t bytes)
    static size_t sk_graphics_set_font_cache_limit (size_t bytes)
    {
        return .sk_graphics_set_font_cache_limit (bytes);
    }

    // int sk_graphics_set_font_cache_point_size_limit(int maxPointSize)
    static int sk_graphics_set_font_cache_point_size_limit (int maxPointSize)
    {
        return .sk_graphics_set_font_cache_point_size_limit (maxPointSize);
    }

    // size_t sk_graphics_set_resource_cache_single_allocation_byte_limit(size_t newLimit)
    static size_t sk_graphics_set_resource_cache_single_allocation_byte_limit (size_t newLimit)
    {
        return .sk_graphics_set_resource_cache_single_allocation_byte_limit (newLimit);
    }

    // size_t sk_graphics_set_resource_cache_total_byte_limit(size_t newLimit)
    static size_t sk_graphics_set_resource_cache_total_byte_limit (size_t newLimit)
    {
        return .sk_graphics_set_resource_cache_total_byte_limit (newLimit);
    }

    // end header: sk_graphics.h

    // for header: sk_image.h

    // sk_data_t* sk_image_encode(const sk_image_t*)
    static sk_data_t* sk_image_encode (sk_image_t* param0)
    {
        return .sk_image_encode (param0);
    }

    // sk_data_t* sk_image_encode_specific(const sk_image_t* cimage, sk_encoded_image_format_t encoder, int quality)
    static sk_data_t* sk_image_encode_specific (sk_image_t* cimage, SKEncodedImageFormat encoder, int quality)
    {
        return .sk_image_encode_specific (cimage, encoder, quality);
    }

    // sk_alphatype_t sk_image_get_alpha_type(const sk_image_t*)
    static SKAlphaType sk_image_get_alpha_type (sk_image_t* param0)
    {
        return .sk_image_get_alpha_type (param0);
    }

    // sk_colortype_t sk_image_get_color_type(const sk_image_t*)
    static SKColorTypeNative sk_image_get_color_type (sk_image_t* param0)
    {
        return .sk_image_get_color_type (param0);
    }

    // sk_colorspace_t* sk_image_get_colorspace(const sk_image_t*)
    static sk_colorspace_t* sk_image_get_colorspace (sk_image_t* param0)
    {
        return .sk_image_get_colorspace (param0);
    }

    // int sk_image_get_height(const sk_image_t*)
    static int sk_image_get_height (sk_image_t* param0)
    {
        return .sk_image_get_height (param0);
    }

    // uint32_t sk_image_get_unique_id(const sk_image_t*)
    static uint sk_image_get_unique_id (sk_image_t* param0)
    {
        return .sk_image_get_unique_id (param0);
    }

    // int sk_image_get_width(const sk_image_t*)
    static int sk_image_get_width (sk_image_t* param0)
    {
        return .sk_image_get_width (param0);
    }

    // bool sk_image_is_alpha_only(const sk_image_t*)
    static bool sk_image_is_alpha_only (sk_image_t* param0)
    {
        return .sk_image_is_alpha_only (param0);
    }

    // bool sk_image_is_lazy_generated(const sk_image_t* image)
    static bool sk_image_is_lazy_generated (sk_image_t* image)
    {
        return .sk_image_is_lazy_generated (image);
    }

    // bool sk_image_is_texture_backed(const sk_image_t* image)
    static bool sk_image_is_texture_backed (sk_image_t* image)
    {
        return .sk_image_is_texture_backed (image);
    }

    // bool sk_image_is_valid(const sk_image_t* image, gr_context_t* context)
    static bool sk_image_is_valid (sk_image_t* image, gr_context_t* context)
    {
        return .sk_image_is_valid (image, context);
    }

    // sk_image_t* sk_image_make_non_texture_image(const sk_image_t* cimage)
    static sk_image_t* sk_image_make_non_texture_image (sk_image_t* cimage)
    {
        return .sk_image_make_non_texture_image (cimage);
    }

    // sk_image_t* sk_image_make_raster_image(const sk_image_t* cimage)
    static sk_image_t* sk_image_make_raster_image (sk_image_t* cimage)
    {
        return .sk_image_make_raster_image (cimage);
    }

    // sk_shader_t* sk_image_make_shader(const sk_image_t*, sk_shader_tilemode_t tileX, sk_shader_tilemode_t tileY, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_image_make_shader (sk_image_t* param0, SKShaderTileMode tileX, SKShaderTileMode tileY, SKMatrix* localMatrix)
    {
        return .sk_image_make_shader (param0, tileX, tileY, localMatrix);
    }

    // sk_image_t* sk_image_make_subset(const sk_image_t* cimage, const sk_irect_t* subset)
    static sk_image_t* sk_image_make_subset (sk_image_t* cimage, SKRectI* subset)
    {
        return .sk_image_make_subset (cimage, subset);
    }

    // sk_image_t* sk_image_make_texture_image(const sk_image_t* cimage, gr_context_t* context, bool mipmapped)
    static sk_image_t* sk_image_make_texture_image (sk_image_t* cimage, gr_context_t* context, bool mipmapped)
    {
        return .sk_image_make_texture_image (cimage, context, mipmapped);
    }

    // sk_image_t* sk_image_make_with_filter(const sk_image_t* cimage, const sk_imagefilter_t* filter, const sk_irect_t* subset, const sk_irect_t* clipBounds, sk_irect_t* outSubset, sk_ipoint_t* outOffset)
    static sk_image_t* sk_image_make_with_filter (sk_image_t* cimage, sk_imagefilter_t* filter, SKRectI* subset, SKRectI* clipBounds, SKRectI* outSubset, SKPointI* outOffset)
    {
        return .sk_image_make_with_filter (cimage, filter, subset, clipBounds, outSubset, outOffset);
    }

    // sk_image_t* sk_image_new_from_adopted_texture(gr_context_t* context, const gr_backendtexture_t* texture, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_alphatype_t alpha, sk_colorspace_t* colorSpace)
    static sk_image_t* sk_image_new_from_adopted_texture (gr_context_t* context, gr_backendtexture_t* texture, GRSurfaceOrigin origin, SKColorTypeNative colorType, SKAlphaType alpha, sk_colorspace_t* colorSpace)
    {
        return .sk_image_new_from_adopted_texture (context, texture, origin, colorType, alpha, colorSpace);
    }

    // sk_image_t* sk_image_new_from_bitmap(const sk_bitmap_t* cbitmap)
    static sk_image_t* sk_image_new_from_bitmap (sk_bitmap_t* cbitmap)
    {
        return .sk_image_new_from_bitmap (cbitmap);
    }

    // sk_image_t* sk_image_new_from_encoded(sk_data_t* encoded, const sk_irect_t* subset)
    static sk_image_t* sk_image_new_from_encoded (sk_data_t* encoded, SKRectI* subset)
    {
        return .sk_image_new_from_encoded (encoded, subset);
    }

    // sk_image_t* sk_image_new_from_picture(sk_picture_t* picture, const sk_isize_t* dimensions, const sk_matrix_t* matrix, const sk_paint_t* paint)
    static sk_image_t* sk_image_new_from_picture (sk_picture_t* picture, SKSizeI* dimensions, SKMatrix* matrix, sk_paint_t* paint)
    {
        return .sk_image_new_from_picture (picture, dimensions, matrix, paint);
    }

    // sk_image_t* sk_image_new_from_texture(gr_context_t* context, const gr_backendtexture_t* texture, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_alphatype_t alpha, sk_colorspace_t* colorSpace, sk_image_texture_release_proc releaseProc, void* releaseContext)
    static sk_image_t* sk_image_new_from_texture (gr_context_t* context, gr_backendtexture_t* texture, GRSurfaceOrigin origin, SKColorTypeNative colorType, SKAlphaType alpha, sk_colorspace_t* colorSpace, SKImageTextureReleaseProxyDelegate releaseProc, void* releaseContext)
    {
        return .sk_image_new_from_texture (context, texture, origin, colorType, alpha, colorSpace, releaseProc, releaseContext);
    }

    // sk_image_t* sk_image_new_raster(const sk_pixmap_t* pixmap, sk_image_raster_release_proc releaseProc, void* context)
    static sk_image_t* sk_image_new_raster (sk_pixmap_t* pixmap, SKImageRasterReleaseProxyDelegate releaseProc, void* context)
    {
        return .sk_image_new_raster (pixmap, releaseProc, context);
    }

    // sk_image_t* sk_image_new_raster_copy(const sk_imageinfo_t*, const(void)* pixels, size_t rowBytes)
    static sk_image_t* sk_image_new_raster_copy (SKImageInfoNative* param0, void* pixels, size_t rowBytes)
    {
        return .sk_image_new_raster_copy (param0, pixels, rowBytes);
    }

    // sk_image_t* sk_image_new_raster_copy_with_pixmap(const sk_pixmap_t* pixmap)
    static sk_image_t* sk_image_new_raster_copy_with_pixmap (sk_pixmap_t* pixmap)
    {
        return .sk_image_new_raster_copy_with_pixmap (pixmap);
    }

    // sk_image_t* sk_image_new_raster_data(const sk_imageinfo_t* cinfo, sk_data_t* pixels, size_t rowBytes)
    static sk_image_t* sk_image_new_raster_data (SKImageInfoNative* cinfo, sk_data_t* pixels, size_t rowBytes)
    {
        return .sk_image_new_raster_data (cinfo, pixels, rowBytes);
    }

    // bool sk_image_peek_pixels(const sk_image_t* image, sk_pixmap_t* pixmap)
    static bool sk_image_peek_pixels (sk_image_t* image, sk_pixmap_t* pixmap)
    {
        return .sk_image_peek_pixels (image, pixmap);
    }

    // bool sk_image_read_pixels(const sk_image_t* image, const sk_imageinfo_t* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY, sk_image_caching_hint_t cachingHint)
    static bool sk_image_read_pixels (sk_image_t* image, SKImageInfoNative* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY, SKImageCachingHint cachingHint)
    {
        return .sk_image_read_pixels (image, dstInfo, dstPixels, dstRowBytes, srcX, srcY, cachingHint);
    }

    // bool sk_image_read_pixels_into_pixmap(const sk_image_t* image, const sk_pixmap_t* dst, int srcX, int srcY, sk_image_caching_hint_t cachingHint)
    static bool sk_image_read_pixels_into_pixmap (sk_image_t* image, sk_pixmap_t* dst, int srcX, int srcY, SKImageCachingHint cachingHint)
    {
        return .sk_image_read_pixels_into_pixmap (image, dst, srcX, srcY, cachingHint);
    }

    // void sk_image_ref(const sk_image_t*)
    static void sk_image_ref (sk_image_t* param0)
    {
        .sk_image_ref (param0);
    }

    // sk_data_t* sk_image_ref_encoded(const sk_image_t*)
    static sk_data_t* sk_image_ref_encoded (sk_image_t* param0)
    {
        return .sk_image_ref_encoded (param0);
    }

    // bool sk_image_scale_pixels(const sk_image_t* image, const sk_pixmap_t* dst, sk_filter_quality_t quality, sk_image_caching_hint_t cachingHint)
    static bool sk_image_scale_pixels (sk_image_t* image, sk_pixmap_t* dst, SKFilterQuality quality, SKImageCachingHint cachingHint)
    {
        return .sk_image_scale_pixels (image, dst, quality, cachingHint);
    }

    // void sk_image_unref(const sk_image_t*)
    static void sk_image_unref (sk_image_t* param0)
    {
        .sk_image_unref (param0);
    }

    // end header: sk_image.h

    // for header: sk_imagefilter.h

    // void sk_imagefilter_croprect_destructor(sk_imagefilter_croprect_t* cropRect)
    static void sk_imagefilter_croprect_destructor (sk_imagefilter_croprect_t* cropRect)
    {
        .sk_imagefilter_croprect_destructor (cropRect);
    }

    // uint32_t sk_imagefilter_croprect_get_flags(sk_imagefilter_croprect_t* cropRect)
    static uint sk_imagefilter_croprect_get_flags (sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_croprect_get_flags (cropRect);
    }

    // void sk_imagefilter_croprect_get_rect(sk_imagefilter_croprect_t* cropRect, sk_rect_t* rect)
    static void sk_imagefilter_croprect_get_rect (sk_imagefilter_croprect_t* cropRect, SKRect* rect)
    {
        .sk_imagefilter_croprect_get_rect (cropRect, rect);
    }

    // sk_imagefilter_croprect_t* sk_imagefilter_croprect_new()
    static sk_imagefilter_croprect_t* sk_imagefilter_croprect_new ()
    {
        return .sk_imagefilter_croprect_new ();
    }

    // sk_imagefilter_croprect_t* sk_imagefilter_croprect_new_with_rect(const sk_rect_t* rect, uint32_t flags)
    static sk_imagefilter_croprect_t* sk_imagefilter_croprect_new_with_rect (SKRect* rect, uint flags)
    {
        return .sk_imagefilter_croprect_new_with_rect (rect, flags);
    }

    // sk_imagefilter_t* sk_imagefilter_new_alpha_threshold(const sk_region_t* region, float innerThreshold, float outerThreshold, sk_imagefilter_t* input)
    static sk_imagefilter_t* sk_imagefilter_new_alpha_threshold (sk_region_t* region, float innerThreshold, float outerThreshold, sk_imagefilter_t* input)
    {
        return .sk_imagefilter_new_alpha_threshold (region, innerThreshold, outerThreshold, input);
    }

    // sk_imagefilter_t* sk_imagefilter_new_arithmetic(float k1, float k2, float k3, float k4, bool enforcePMColor, sk_imagefilter_t* background, sk_imagefilter_t* foreground, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_arithmetic (float k1, float k2, float k3, float k4, bool enforcePMColor, sk_imagefilter_t* background, sk_imagefilter_t* foreground, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_arithmetic (k1, k2, k3, k4, enforcePMColor, background, foreground, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_blur(float sigmaX, float sigmaY, sk_shader_tilemode_t tileMode, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_blur (float sigmaX, float sigmaY, SKShaderTileMode tileMode, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_blur (sigmaX, sigmaY, tileMode, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_color_filter(sk_colorfilter_t* cf, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_color_filter (sk_colorfilter_t* cf, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_color_filter (cf, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_compose(sk_imagefilter_t* outer, sk_imagefilter_t* inner)
    static sk_imagefilter_t* sk_imagefilter_new_compose (sk_imagefilter_t* outer, sk_imagefilter_t* inner)
    {
        return .sk_imagefilter_new_compose (outer, inner);
    }

    // sk_imagefilter_t* sk_imagefilter_new_dilate(int radiusX, int radiusY, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_dilate (int radiusX, int radiusY, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_dilate (radiusX, radiusY, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_displacement_map_effect(sk_color_channel_t xChannelSelector, sk_color_channel_t yChannelSelector, float scale, sk_imagefilter_t* displacement, sk_imagefilter_t* color, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_displacement_map_effect (SKColorChannel xChannelSelector, SKColorChannel yChannelSelector, float scale, sk_imagefilter_t* displacement, sk_imagefilter_t* color, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_displacement_map_effect (xChannelSelector, yChannelSelector, scale, displacement, color, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_distant_lit_diffuse(const sk_point3_t* direction, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_distant_lit_diffuse (SKPoint3* direction, uint lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_distant_lit_diffuse (direction, lightColor, surfaceScale, kd, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_distant_lit_specular(const sk_point3_t* direction, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_distant_lit_specular (SKPoint3* direction, uint lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_distant_lit_specular (direction, lightColor, surfaceScale, ks, shininess, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_drop_shadow(float dx, float dy, float sigmaX, float sigmaY, sk_color_t color, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_drop_shadow (float dx, float dy, float sigmaX, float sigmaY, uint color, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_drop_shadow (dx, dy, sigmaX, sigmaY, color, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_drop_shadow_only(float dx, float dy, float sigmaX, float sigmaY, sk_color_t color, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_drop_shadow_only (float dx, float dy, float sigmaX, float sigmaY, uint color, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_drop_shadow_only (dx, dy, sigmaX, sigmaY, color, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_erode(int radiusX, int radiusY, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_erode (int radiusX, int radiusY, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_erode (radiusX, radiusY, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_image_source(sk_image_t* image, const sk_rect_t* srcRect, const sk_rect_t* dstRect, sk_filter_quality_t filterQuality)
    static sk_imagefilter_t* sk_imagefilter_new_image_source (sk_image_t* image, SKRect* srcRect, SKRect* dstRect, SKFilterQuality filterQuality)
    {
        return .sk_imagefilter_new_image_source (image, srcRect, dstRect, filterQuality);
    }

    // sk_imagefilter_t* sk_imagefilter_new_image_source_default(sk_image_t* image)
    static sk_imagefilter_t* sk_imagefilter_new_image_source_default (sk_image_t* image)
    {
        return .sk_imagefilter_new_image_source_default (image);
    }

    // sk_imagefilter_t* sk_imagefilter_new_magnifier(const sk_rect_t* src, float inset, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_magnifier (SKRect* src, float inset, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_magnifier (src, inset, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_matrix(const sk_matrix_t* matrix, sk_filter_quality_t quality, sk_imagefilter_t* input)
    static sk_imagefilter_t* sk_imagefilter_new_matrix (SKMatrix* matrix, SKFilterQuality quality, sk_imagefilter_t* input)
    {
        return .sk_imagefilter_new_matrix (matrix, quality, input);
    }

    // sk_imagefilter_t* sk_imagefilter_new_matrix_convolution(const sk_isize_t* kernelSize, const float* kernel, float gain, float bias, const sk_ipoint_t* kernelOffset, sk_shader_tilemode_t tileMode, bool convolveAlpha, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_matrix_convolution (SKSizeI* kernelSize, float* kernel, float gain, float bias, SKPointI* kernelOffset, SKShaderTileMode tileMode, bool convolveAlpha, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_matrix_convolution (kernelSize, kernel, gain, bias, kernelOffset, tileMode, convolveAlpha, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_merge(sk_imagefilter_t** filters, int count, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_merge (sk_imagefilter_t** filters, int count, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_merge (filters, count, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_offset(float dx, float dy, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_offset (float dx, float dy, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_offset (dx, dy, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_paint(const sk_paint_t* paint, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_paint (sk_paint_t* paint, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_paint (paint, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_picture(sk_picture_t* picture)
    static sk_imagefilter_t* sk_imagefilter_new_picture (sk_picture_t* picture)
    {
        return .sk_imagefilter_new_picture (picture);
    }

    // sk_imagefilter_t* sk_imagefilter_new_picture_with_croprect(sk_picture_t* picture, const sk_rect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_picture_with_croprect (sk_picture_t* picture, SKRect* cropRect)
    {
        return .sk_imagefilter_new_picture_with_croprect (picture, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_point_lit_diffuse(const sk_point3_t* location, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_point_lit_diffuse (SKPoint3* location, uint lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_point_lit_diffuse (location, lightColor, surfaceScale, kd, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_point_lit_specular(const sk_point3_t* location, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_point_lit_specular (SKPoint3* location, uint lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_point_lit_specular (location, lightColor, surfaceScale, ks, shininess, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_spot_lit_diffuse(const sk_point3_t* location, const sk_point3_t* target, float specularExponent, float cutoffAngle, sk_color_t lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_spot_lit_diffuse (SKPoint3* location, SKPoint3* target, float specularExponent, float cutoffAngle, uint lightColor, float surfaceScale, float kd, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_spot_lit_diffuse (location, target, specularExponent, cutoffAngle, lightColor, surfaceScale, kd, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_spot_lit_specular(const sk_point3_t* location, const sk_point3_t* target, float specularExponent, float cutoffAngle, sk_color_t lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_spot_lit_specular (SKPoint3* location, SKPoint3* target, float specularExponent, float cutoffAngle, uint lightColor, float surfaceScale, float ks, float shininess, sk_imagefilter_t* input, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_spot_lit_specular (location, target, specularExponent, cutoffAngle, lightColor, surfaceScale, ks, shininess, input, cropRect);
    }

    // sk_imagefilter_t* sk_imagefilter_new_tile(const sk_rect_t* src, const sk_rect_t* dst, sk_imagefilter_t* input)
    static sk_imagefilter_t* sk_imagefilter_new_tile (SKRect* src, SKRect* dst, sk_imagefilter_t* input)
    {
        return .sk_imagefilter_new_tile (src, dst, input);
    }

    // sk_imagefilter_t* sk_imagefilter_new_xfermode(sk_blendmode_t mode, sk_imagefilter_t* background, sk_imagefilter_t* foreground, const sk_imagefilter_croprect_t* cropRect)
    static sk_imagefilter_t* sk_imagefilter_new_xfermode (SKBlendMode mode, sk_imagefilter_t* background, sk_imagefilter_t* foreground, sk_imagefilter_croprect_t* cropRect)
    {
        return .sk_imagefilter_new_xfermode (mode, background, foreground, cropRect);
    }

    // void sk_imagefilter_unref(sk_imagefilter_t*)
    static void sk_imagefilter_unref (sk_imagefilter_t* param0)
    {
        .sk_imagefilter_unref (param0);
    }

    // end header: sk_imagefilter.h

    // for header: sk_mask.h

    // uint8_t* sk_mask_alloc_image(size_t bytes)
    static ubyte* sk_mask_alloc_image (size_t bytes)
    {
        return cast(ubyte*).sk_mask_alloc_image (bytes);
    }

    // size_t sk_mask_compute_image_size(sk_mask_t* cmask)
    static size_t sk_mask_compute_image_size (SKMask* cmask)
    {
        return .sk_mask_compute_image_size (cmask);
    }

    // size_t sk_mask_compute_total_image_size(sk_mask_t* cmask)
    static size_t sk_mask_compute_total_image_size (SKMask* cmask)
    {
        return .sk_mask_compute_total_image_size (cmask);
    }

    // void sk_mask_free_image(void* image)
    static void sk_mask_free_image (void* image)
    {
        .sk_mask_free_image (image);
    }

    // void* sk_mask_get_addr(sk_mask_t* cmask, int x, int y)
    static void* sk_mask_get_addr (SKMask* cmask, int x, int y)
    {
        return .sk_mask_get_addr (cmask, x, y);
    }

    // uint8_t* sk_mask_get_addr_1(sk_mask_t* cmask, int x, int y)
    static ubyte* sk_mask_get_addr_1 (SKMask* cmask, int x, int y)
    {
        return cast(ubyte*).sk_mask_get_addr_1 (cmask, x, y);
    }

    // uint32_t* sk_mask_get_addr_32(sk_mask_t* cmask, int x, int y)
    static uint* sk_mask_get_addr_32 (SKMask* cmask, int x, int y)
    {
        return .sk_mask_get_addr_32 (cmask, x, y);
    }

    // uint8_t* sk_mask_get_addr_8(sk_mask_t* cmask, int x, int y)
    static ubyte* sk_mask_get_addr_8 (SKMask* cmask, int x, int y)
    {
        return cast(ubyte*).sk_mask_get_addr_8 (cmask, x, y);
    }

    // uint16_t* sk_mask_get_addr_lcd_16(sk_mask_t* cmask, int x, int y)
    static ushort* sk_mask_get_addr_lcd_16 (SKMask* cmask, int x, int y)
    {
        return .sk_mask_get_addr_lcd_16 (cmask, x, y);
    }

    // bool sk_mask_is_empty(sk_mask_t* cmask)
    static bool sk_mask_is_empty (SKMask* cmask)
    {
        return .sk_mask_is_empty (cmask);
    }

    // end header: sk_mask.h

    // for header: sk_maskfilter.h

    // sk_maskfilter_t* sk_maskfilter_new_blur(sk_blurstyle_t, float sigma)
    static sk_maskfilter_t* sk_maskfilter_new_blur (SKBlurStyle param0, float sigma)
    {
        return .sk_maskfilter_new_blur (param0, sigma);
    }

    // sk_maskfilter_t* sk_maskfilter_new_blur_with_flags(sk_blurstyle_t, float sigma, bool respectCTM)
    static sk_maskfilter_t* sk_maskfilter_new_blur_with_flags (SKBlurStyle param0, float sigma, bool respectCTM)
    {
        return .sk_maskfilter_new_blur_with_flags (param0, sigma, respectCTM);
    }

    // sk_maskfilter_t* sk_maskfilter_new_clip(uint8_t min, uint8_t max)
    static sk_maskfilter_t* sk_maskfilter_new_clip (ubyte min, ubyte max)
    {
        return .sk_maskfilter_new_clip (min, max);
    }

    // sk_maskfilter_t* sk_maskfilter_new_gamma(float gamma)
    static sk_maskfilter_t* sk_maskfilter_new_gamma (float gamma)
    {
        return .sk_maskfilter_new_gamma (gamma);
    }

    // sk_maskfilter_t* sk_maskfilter_new_shader(sk_shader_t* cshader)
    static sk_maskfilter_t* sk_maskfilter_new_shader (sk_shader_t* cshader)
    {
        return .sk_maskfilter_new_shader (cshader);
    }

    // sk_maskfilter_t* sk_maskfilter_new_table(const uint8_t[256] table = 256)
    static sk_maskfilter_t* sk_maskfilter_new_table (ubyte* table)
    {
        return .sk_maskfilter_new_table (table);
    }

    // void sk_maskfilter_ref(sk_maskfilter_t*)
    static void sk_maskfilter_ref (sk_maskfilter_t* param0)
    {
        .sk_maskfilter_ref (param0);
    }

    // void sk_maskfilter_unref(sk_maskfilter_t*)
    static void sk_maskfilter_unref (sk_maskfilter_t* param0)
    {
        .sk_maskfilter_unref (param0);
    }

    // end header: sk_maskfilter.h

    // for header: sk_matrix.h

    // void sk_3dview_apply_to_canvas(sk_3dview_t* cview, sk_canvas_t* ccanvas)
    static void sk_3dview_apply_to_canvas (sk_3dview_t* cview, sk_canvas_t* ccanvas)
    {
        .sk_3dview_apply_to_canvas (cview, ccanvas);
    }

    // void sk_3dview_destroy(sk_3dview_t* cview)
    static void sk_3dview_destroy (sk_3dview_t* cview)
    {
        .sk_3dview_destroy (cview);
    }

    // float sk_3dview_dot_with_normal(sk_3dview_t* cview, float dx, float dy, float dz)
    static float sk_3dview_dot_with_normal (sk_3dview_t* cview, float dx, float dy, float dz)
    {
        return .sk_3dview_dot_with_normal (cview, dx, dy, dz);
    }

    // void sk_3dview_get_matrix(sk_3dview_t* cview, sk_matrix_t* cmatrix)
    static void sk_3dview_get_matrix (sk_3dview_t* cview, SKMatrix* cmatrix)
    {
        .sk_3dview_get_matrix (cview, cmatrix);
    }

    // sk_3dview_t* sk_3dview_new()
    static sk_3dview_t* sk_3dview_new ()
    {
        return .sk_3dview_new ();
    }

    // void sk_3dview_restore(sk_3dview_t* cview)
    static void sk_3dview_restore (sk_3dview_t* cview)
    {
        .sk_3dview_restore (cview);
    }

    // void sk_3dview_rotate_x_degrees(sk_3dview_t* cview, float degrees)
    static void sk_3dview_rotate_x_degrees (sk_3dview_t* cview, float degrees)
    {
        .sk_3dview_rotate_x_degrees (cview, degrees);
    }

    // void sk_3dview_rotate_x_radians(sk_3dview_t* cview, float radians)
    static void sk_3dview_rotate_x_radians (sk_3dview_t* cview, float radians)
    {
        .sk_3dview_rotate_x_radians (cview, radians);
    }

    // void sk_3dview_rotate_y_degrees(sk_3dview_t* cview, float degrees)
    static void sk_3dview_rotate_y_degrees (sk_3dview_t* cview, float degrees)
    {
        .sk_3dview_rotate_y_degrees (cview, degrees);
    }

    // void sk_3dview_rotate_y_radians(sk_3dview_t* cview, float radians)
    static void sk_3dview_rotate_y_radians (sk_3dview_t* cview, float radians)
    {
        .sk_3dview_rotate_y_radians (cview, radians);
    }

    // void sk_3dview_rotate_z_degrees(sk_3dview_t* cview, float degrees)
    static void sk_3dview_rotate_z_degrees (sk_3dview_t* cview, float degrees)
    {
        .sk_3dview_rotate_z_degrees (cview, degrees);
    }

    // void sk_3dview_rotate_z_radians(sk_3dview_t* cview, float radians)
    static void sk_3dview_rotate_z_radians (sk_3dview_t* cview, float radians)
    {
        .sk_3dview_rotate_z_radians (cview, radians);
    }

    // void sk_3dview_save(sk_3dview_t* cview)
    static void sk_3dview_save (sk_3dview_t* cview)
    {
        .sk_3dview_save (cview);
    }

    // void sk_3dview_translate(sk_3dview_t* cview, float x, float y, float z)
    static void sk_3dview_translate (sk_3dview_t* cview, float x, float y, float z)
    {
        .sk_3dview_translate (cview, x, y, z);
    }

    // void sk_matrix_concat(sk_matrix_t* result, sk_matrix_t* first, sk_matrix_t* second)
    static void sk_matrix_concat (SKMatrix* result, SKMatrix* first, SKMatrix* second)
    {
        .sk_matrix_concat (result, first, second);
    }

    // void sk_matrix_map_points(sk_matrix_t* matrix, sk_point_t* dst, sk_point_t* src, int count)
    static void sk_matrix_map_points (SKMatrix* matrix, SKPoint* dst, SKPoint* src, int count)
    {
        .sk_matrix_map_points (matrix, dst, src, count);
    }

    // float sk_matrix_map_radius(sk_matrix_t* matrix, float radius)
    static float sk_matrix_map_radius (SKMatrix* matrix, float radius)
    {
        return .sk_matrix_map_radius (matrix, radius);
    }

    // void sk_matrix_map_rect(sk_matrix_t* matrix, sk_rect_t* dest, sk_rect_t* source)
    static void sk_matrix_map_rect (SKMatrix* matrix, SKRect* dest, SKRect* source)
    {
        .sk_matrix_map_rect (matrix, dest, source);
    }

    // void sk_matrix_map_vector(sk_matrix_t* matrix, float x, float y, sk_point_t* result)
    static void sk_matrix_map_vector (SKMatrix* matrix, float x, float y, SKPoint* result)
    {
        .sk_matrix_map_vector (matrix, x, y, result);
    }

    // void sk_matrix_map_vectors(sk_matrix_t* matrix, sk_point_t* dst, sk_point_t* src, int count)
    static void sk_matrix_map_vectors (SKMatrix* matrix, SKPoint* dst, SKPoint* src, int count)
    {
        .sk_matrix_map_vectors (matrix, dst, src, count);
    }

    // void sk_matrix_map_xy(sk_matrix_t* matrix, float x, float y, sk_point_t* result)
    static void sk_matrix_map_xy (SKMatrix* matrix, float x, float y, SKPoint* result)
    {
        .sk_matrix_map_xy (matrix, x, y, result);
    }

    // void sk_matrix_post_concat(sk_matrix_t* result, sk_matrix_t* matrix)
    static void sk_matrix_post_concat (SKMatrix* result, SKMatrix* matrix)
    {
        .sk_matrix_post_concat (result, matrix);
    }

    // void sk_matrix_pre_concat(sk_matrix_t* result, sk_matrix_t* matrix)
    static void sk_matrix_pre_concat (SKMatrix* result, SKMatrix* matrix)
    {
        .sk_matrix_pre_concat (result, matrix);
    }

    // bool sk_matrix_try_invert(sk_matrix_t* matrix, sk_matrix_t* result)
    static bool sk_matrix_try_invert (SKMatrix* matrix, SKMatrix* result)
    {
        return .sk_matrix_try_invert (matrix, result);
    }

    // void sk_matrix44_as_col_major(sk_matrix44_t* matrix, float* dst)
    static void sk_matrix44_as_col_major (sk_matrix44_t* matrix, float* dst)
    {
        .sk_matrix44_as_col_major (matrix, dst);
    }

    // void sk_matrix44_as_row_major(sk_matrix44_t* matrix, float* dst)
    static void sk_matrix44_as_row_major (sk_matrix44_t* matrix, float* dst)
    {
        .sk_matrix44_as_row_major (matrix, dst);
    }

    // void sk_matrix44_destroy(sk_matrix44_t* matrix)
    static void sk_matrix44_destroy (sk_matrix44_t* matrix)
    {
        .sk_matrix44_destroy (matrix);
    }

    // double sk_matrix44_determinant(sk_matrix44_t* matrix)
    static double sk_matrix44_determinant (sk_matrix44_t* matrix)
    {
        return .sk_matrix44_determinant (matrix);
    }

    // bool sk_matrix44_equals(sk_matrix44_t* matrix, const sk_matrix44_t* other)
    static bool sk_matrix44_equals (sk_matrix44_t* matrix, sk_matrix44_t* other)
    {
        return .sk_matrix44_equals (matrix, other);
    }

    // float sk_matrix44_get(sk_matrix44_t* matrix, int row, int col)
    static float sk_matrix44_get (sk_matrix44_t* matrix, int row, int col)
    {
        return .sk_matrix44_get (matrix, row, col);
    }

    // sk_matrix44_type_mask_t sk_matrix44_get_type(sk_matrix44_t* matrix)
    static SKMatrix44TypeMask sk_matrix44_get_type (sk_matrix44_t* matrix)
    {
        return .sk_matrix44_get_type (matrix);
    }

    // bool sk_matrix44_invert(sk_matrix44_t* matrix, sk_matrix44_t* inverse)
    static bool sk_matrix44_invert (sk_matrix44_t* matrix, sk_matrix44_t* inverse)
    {
        return .sk_matrix44_invert (matrix, inverse);
    }

    // void sk_matrix44_map_scalars(sk_matrix44_t* matrix, const float* src, float* dst)
    static void sk_matrix44_map_scalars (sk_matrix44_t* matrix, float* src, float* dst)
    {
        .sk_matrix44_map_scalars (matrix, src, dst);
    }

    // void sk_matrix44_map2(sk_matrix44_t* matrix, const float* src2, int count, float* dst4)
    static void sk_matrix44_map2 (sk_matrix44_t* matrix, float* src2, int count, float* dst4)
    {
        .sk_matrix44_map2 (matrix, src2, count, dst4);
    }

    // sk_matrix44_t* sk_matrix44_new()
    static sk_matrix44_t* sk_matrix44_new ()
    {
        return .sk_matrix44_new ();
    }

    // sk_matrix44_t* sk_matrix44_new_concat(const sk_matrix44_t* a, const sk_matrix44_t* b)
    static sk_matrix44_t* sk_matrix44_new_concat (sk_matrix44_t* a, sk_matrix44_t* b)
    {
        return .sk_matrix44_new_concat (a, b);
    }

    // sk_matrix44_t* sk_matrix44_new_copy(const sk_matrix44_t* src)
    static sk_matrix44_t* sk_matrix44_new_copy (sk_matrix44_t* src)
    {
        return .sk_matrix44_new_copy (src);
    }

    // sk_matrix44_t* sk_matrix44_new_identity()
    static sk_matrix44_t* sk_matrix44_new_identity ()
    {
        return .sk_matrix44_new_identity ();
    }

    // sk_matrix44_t* sk_matrix44_new_matrix(const sk_matrix_t* src)
    static sk_matrix44_t* sk_matrix44_new_matrix (SKMatrix* src)
    {
        return .sk_matrix44_new_matrix (src);
    }

    // void sk_matrix44_post_concat(sk_matrix44_t* matrix, const sk_matrix44_t* m)
    static void sk_matrix44_post_concat (sk_matrix44_t* matrix, sk_matrix44_t* m)
    {
        .sk_matrix44_post_concat (matrix, m);
    }

    // void sk_matrix44_post_scale(sk_matrix44_t* matrix, float sx, float sy, float sz)
    static void sk_matrix44_post_scale (sk_matrix44_t* matrix, float sx, float sy, float sz)
    {
        .sk_matrix44_post_scale (matrix, sx, sy, sz);
    }

    // void sk_matrix44_post_translate(sk_matrix44_t* matrix, float dx, float dy, float dz)
    static void sk_matrix44_post_translate (sk_matrix44_t* matrix, float dx, float dy, float dz)
    {
        .sk_matrix44_post_translate (matrix, dx, dy, dz);
    }

    // void sk_matrix44_pre_concat(sk_matrix44_t* matrix, const sk_matrix44_t* m)
    static void sk_matrix44_pre_concat (sk_matrix44_t* matrix, sk_matrix44_t* m)
    {
        .sk_matrix44_pre_concat (matrix, m);
    }

    // void sk_matrix44_pre_scale(sk_matrix44_t* matrix, float sx, float sy, float sz)
    static void sk_matrix44_pre_scale (sk_matrix44_t* matrix, float sx, float sy, float sz)
    {
        .sk_matrix44_pre_scale (matrix, sx, sy, sz);
    }

    // void sk_matrix44_pre_translate(sk_matrix44_t* matrix, float dx, float dy, float dz)
    static void sk_matrix44_pre_translate (sk_matrix44_t* matrix, float dx, float dy, float dz)
    {
        .sk_matrix44_pre_translate (matrix, dx, dy, dz);
    }

    // bool sk_matrix44_preserves_2d_axis_alignment(sk_matrix44_t* matrix, float epsilon)
    static bool sk_matrix44_preserves_2d_axis_alignment (sk_matrix44_t* matrix, float epsilon)
    {
        return .sk_matrix44_preserves_2d_axis_alignment (matrix, epsilon);
    }

    // void sk_matrix44_set(sk_matrix44_t* matrix, int row, int col, float value)
    static void sk_matrix44_set (sk_matrix44_t* matrix, int row, int col, float value)
    {
        .sk_matrix44_set (matrix, row, col, value);
    }

    // void sk_matrix44_set_3x3_row_major(sk_matrix44_t* matrix, float* dst)
    static void sk_matrix44_set_3x3_row_major (sk_matrix44_t* matrix, float* dst)
    {
        .sk_matrix44_set_3x3_row_major (matrix, dst);
    }

    // void sk_matrix44_set_col_major(sk_matrix44_t* matrix, float* dst)
    static void sk_matrix44_set_col_major (sk_matrix44_t* matrix, float* dst)
    {
        .sk_matrix44_set_col_major (matrix, dst);
    }

    // void sk_matrix44_set_concat(sk_matrix44_t* matrix, const sk_matrix44_t* a, const sk_matrix44_t* b)
    static void sk_matrix44_set_concat (sk_matrix44_t* matrix, sk_matrix44_t* a, sk_matrix44_t* b)
    {
        .sk_matrix44_set_concat (matrix, a, b);
    }

    // void sk_matrix44_set_identity(sk_matrix44_t* matrix)
    static void sk_matrix44_set_identity (sk_matrix44_t* matrix)
    {
        .sk_matrix44_set_identity (matrix);
    }

    // void sk_matrix44_set_rotate_about_degrees(sk_matrix44_t* matrix, float x, float y, float z, float degrees)
    static void sk_matrix44_set_rotate_about_degrees (sk_matrix44_t* matrix, float x, float y, float z, float degrees)
    {
        .sk_matrix44_set_rotate_about_degrees (matrix, x, y, z, degrees);
    }

    // void sk_matrix44_set_rotate_about_radians(sk_matrix44_t* matrix, float x, float y, float z, float radians)
    static void sk_matrix44_set_rotate_about_radians (sk_matrix44_t* matrix, float x, float y, float z, float radians)
    {
        .sk_matrix44_set_rotate_about_radians (matrix, x, y, z, radians);
    }

    // void sk_matrix44_set_rotate_about_radians_unit(sk_matrix44_t* matrix, float x, float y, float z, float radians)
    static void sk_matrix44_set_rotate_about_radians_unit (sk_matrix44_t* matrix, float x, float y, float z, float radians)
    {
        .sk_matrix44_set_rotate_about_radians_unit (matrix, x, y, z, radians);
    }

    // void sk_matrix44_set_row_major(sk_matrix44_t* matrix, float* dst)
    static void sk_matrix44_set_row_major (sk_matrix44_t* matrix, float* dst)
    {
        .sk_matrix44_set_row_major (matrix, dst);
    }

    // void sk_matrix44_set_scale(sk_matrix44_t* matrix, float sx, float sy, float sz)
    static void sk_matrix44_set_scale (sk_matrix44_t* matrix, float sx, float sy, float sz)
    {
        .sk_matrix44_set_scale (matrix, sx, sy, sz);
    }

    // void sk_matrix44_set_translate(sk_matrix44_t* matrix, float dx, float dy, float dz)
    static void sk_matrix44_set_translate (sk_matrix44_t* matrix, float dx, float dy, float dz)
    {
        .sk_matrix44_set_translate (matrix, dx, dy, dz);
    }

    // void sk_matrix44_to_matrix(sk_matrix44_t* matrix, sk_matrix_t* dst)
    static void sk_matrix44_to_matrix (sk_matrix44_t* matrix, SKMatrix* dst)
    {
        .sk_matrix44_to_matrix (matrix, dst);
    }

    // void sk_matrix44_transpose(sk_matrix44_t* matrix)
    static void sk_matrix44_transpose (sk_matrix44_t* matrix)
    {
        .sk_matrix44_transpose (matrix);
    }

    // end header: sk_matrix.h

    // for header: sk_paint.h

    // sk_paint_t* sk_paint_clone(sk_paint_t*)
    static sk_paint_t* sk_paint_clone (sk_paint_t* param0)
    {
        return .sk_paint_clone (param0);
    }

    // void sk_paint_delete(sk_paint_t*)
    static void sk_paint_delete (sk_paint_t* param0)
    {
        .sk_paint_delete (param0);
    }

    // sk_blendmode_t sk_paint_get_blendmode(sk_paint_t*)
    static SKBlendMode sk_paint_get_blendmode (sk_paint_t* param0)
    {
        return .sk_paint_get_blendmode (param0);
    }

    // sk_color_t sk_paint_get_color(const sk_paint_t*)
    static uint sk_paint_get_color (sk_paint_t* param0)
    {
        return .sk_paint_get_color (param0);
    }

    // void sk_paint_get_color4f(const sk_paint_t* paint, sk_color4f_t* color)
    static void sk_paint_get_color4f (sk_paint_t* paint, SKColorF* color)
    {
        .sk_paint_get_color4f (paint, color);
    }

    // sk_colorfilter_t* sk_paint_get_colorfilter(sk_paint_t*)
    static sk_colorfilter_t* sk_paint_get_colorfilter (sk_paint_t* param0)
    {
        return .sk_paint_get_colorfilter (param0);
    }

    // bool sk_paint_get_fill_path(const sk_paint_t*, const sk_path_t* src, sk_path_t* dst, const sk_rect_t* cullRect, float resScale)
    static bool sk_paint_get_fill_path (sk_paint_t* param0, sk_path_t* src, sk_path_t* dst, SKRect* cullRect, float resScale)
    {
        return .sk_paint_get_fill_path (param0, src, dst, cullRect, resScale);
    }

    // sk_filter_quality_t sk_paint_get_filter_quality(sk_paint_t*)
    static SKFilterQuality sk_paint_get_filter_quality (sk_paint_t* param0)
    {
        return .sk_paint_get_filter_quality (param0);
    }

    // sk_imagefilter_t* sk_paint_get_imagefilter(sk_paint_t*)
    static sk_imagefilter_t* sk_paint_get_imagefilter (sk_paint_t* param0)
    {
        return .sk_paint_get_imagefilter (param0);
    }

    // sk_maskfilter_t* sk_paint_get_maskfilter(sk_paint_t*)
    static sk_maskfilter_t* sk_paint_get_maskfilter (sk_paint_t* param0)
    {
        return .sk_paint_get_maskfilter (param0);
    }

    // sk_path_effect_t* sk_paint_get_path_effect(sk_paint_t* cpaint)
    static sk_path_effect_t* sk_paint_get_path_effect (sk_paint_t* cpaint)
    {
        return .sk_paint_get_path_effect (cpaint);
    }

    // sk_shader_t* sk_paint_get_shader(sk_paint_t*)
    static sk_shader_t* sk_paint_get_shader (sk_paint_t* param0)
    {
        return .sk_paint_get_shader (param0);
    }

    // sk_stroke_cap_t sk_paint_get_stroke_cap(const sk_paint_t*)
    static SKStrokeCap sk_paint_get_stroke_cap (sk_paint_t* param0)
    {
        return .sk_paint_get_stroke_cap (param0);
    }

    // sk_stroke_join_t sk_paint_get_stroke_join(const sk_paint_t*)
    static SKStrokeJoin sk_paint_get_stroke_join (sk_paint_t* param0)
    {
        return .sk_paint_get_stroke_join (param0);
    }

    // float sk_paint_get_stroke_miter(const sk_paint_t*)
    static float sk_paint_get_stroke_miter (sk_paint_t* param0)
    {
        return .sk_paint_get_stroke_miter (param0);
    }

    // float sk_paint_get_stroke_width(const sk_paint_t*)
    static float sk_paint_get_stroke_width (sk_paint_t* param0)
    {
        return .sk_paint_get_stroke_width (param0);
    }

    // sk_paint_style_t sk_paint_get_style(const sk_paint_t*)
    static SKPaintStyle sk_paint_get_style (sk_paint_t* param0)
    {
        return .sk_paint_get_style (param0);
    }

    // bool sk_paint_is_antialias(const sk_paint_t*)
    static bool sk_paint_is_antialias (sk_paint_t* param0)
    {
        return .sk_paint_is_antialias (param0);
    }

    // bool sk_paint_is_dither(const sk_paint_t*)
    static bool sk_paint_is_dither (sk_paint_t* param0)
    {
        return .sk_paint_is_dither (param0);
    }

    // sk_paint_t* sk_paint_new()
    static sk_paint_t* sk_paint_new ()
    {
        return .sk_paint_new ();
    }

    // void sk_paint_reset(sk_paint_t*)
    static void sk_paint_reset (sk_paint_t* param0)
    {
        .sk_paint_reset (param0);
    }

    // void sk_paint_set_antialias(sk_paint_t*, bool)
    static void sk_paint_set_antialias (sk_paint_t* param0, bool param1)
    {
        .sk_paint_set_antialias (param0, param1);
    }

    // void sk_paint_set_blendmode(sk_paint_t*, sk_blendmode_t)
    static void sk_paint_set_blendmode (sk_paint_t* param0, SKBlendMode param1)
    {
        .sk_paint_set_blendmode (param0, param1);
    }

    // void sk_paint_set_color(sk_paint_t*, sk_color_t)
    static void sk_paint_set_color (sk_paint_t* param0, uint param1)
    {
        .sk_paint_set_color (param0, param1);
    }

    // void sk_paint_set_color4f(sk_paint_t* paint, sk_color4f_t* color, sk_colorspace_t* colorspace)
    static void sk_paint_set_color4f (sk_paint_t* paint, SKColorF* color, sk_colorspace_t* colorspace)
    {
        .sk_paint_set_color4f (paint, color, colorspace);
    }

    // void sk_paint_set_colorfilter(sk_paint_t*, sk_colorfilter_t*)
    static void sk_paint_set_colorfilter (sk_paint_t* param0, sk_colorfilter_t* param1)
    {
        .sk_paint_set_colorfilter (param0, param1);
    }

    // void sk_paint_set_dither(sk_paint_t*, bool)
    static void sk_paint_set_dither (sk_paint_t* param0, bool param1)
    {
        .sk_paint_set_dither (param0, param1);
    }

    // void sk_paint_set_filter_quality(sk_paint_t*, sk_filter_quality_t)
    static void sk_paint_set_filter_quality (sk_paint_t* param0, SKFilterQuality param1)
    {
        .sk_paint_set_filter_quality (param0, param1);
    }

    // void sk_paint_set_imagefilter(sk_paint_t*, sk_imagefilter_t*)
    static void sk_paint_set_imagefilter (sk_paint_t* param0, sk_imagefilter_t* param1)
    {
        .sk_paint_set_imagefilter (param0, param1);
    }

    // void sk_paint_set_maskfilter(sk_paint_t*, sk_maskfilter_t*)
    static void sk_paint_set_maskfilter (sk_paint_t* param0, sk_maskfilter_t* param1)
    {
        .sk_paint_set_maskfilter (param0, param1);
    }

    // void sk_paint_set_path_effect(sk_paint_t* cpaint, sk_path_effect_t* effect)
    static void sk_paint_set_path_effect (sk_paint_t* cpaint, sk_path_effect_t* effect)
    {
        .sk_paint_set_path_effect (cpaint, effect);
    }

    // void sk_paint_set_shader(sk_paint_t*, sk_shader_t*)
    static void sk_paint_set_shader (sk_paint_t* param0, sk_shader_t* param1)
    {
        .sk_paint_set_shader (param0, param1);
    }

    // void sk_paint_set_stroke_cap(sk_paint_t*, sk_stroke_cap_t)
    static void sk_paint_set_stroke_cap (sk_paint_t* param0, SKStrokeCap param1)
    {
        .sk_paint_set_stroke_cap (param0, param1);
    }

    // void sk_paint_set_stroke_join(sk_paint_t*, sk_stroke_join_t)
    static void sk_paint_set_stroke_join (sk_paint_t* param0, SKStrokeJoin param1)
    {
        .sk_paint_set_stroke_join (param0, param1);
    }

    // void sk_paint_set_stroke_miter(sk_paint_t*, float miter)
    static void sk_paint_set_stroke_miter (sk_paint_t* param0, float miter)
    {
        .sk_paint_set_stroke_miter (param0, miter);
    }

    // void sk_paint_set_stroke_width(sk_paint_t*, float width)
    static void sk_paint_set_stroke_width (sk_paint_t* param0, float width)
    {
        .sk_paint_set_stroke_width (param0, width);
    }

    // void sk_paint_set_style(sk_paint_t*, sk_paint_style_t)
    static void sk_paint_set_style (sk_paint_t* param0, SKPaintStyle param1)
    {
        .sk_paint_set_style (param0, param1);
    }

    // end header: sk_paint.h

    // for header: sk_path.h

    // void sk_opbuilder_add(sk_opbuilder_t* builder, const sk_path_t* path, sk_pathop_t op)
    static void sk_opbuilder_add (sk_opbuilder_t* builder, sk_path_t* path, SKPathOp op)
    {
        .sk_opbuilder_add (builder, path, op);
    }

    // void sk_opbuilder_destroy(sk_opbuilder_t* builder)
    static void sk_opbuilder_destroy (sk_opbuilder_t* builder)
    {
        .sk_opbuilder_destroy (builder);
    }

    // sk_opbuilder_t* sk_opbuilder_new()
    static sk_opbuilder_t* sk_opbuilder_new ()
    {
        return .sk_opbuilder_new ();
    }

    // bool sk_opbuilder_resolve(sk_opbuilder_t* builder, sk_path_t* result)
    static bool sk_opbuilder_resolve (sk_opbuilder_t* builder, sk_path_t* result)
    {
        return .sk_opbuilder_resolve (builder, result);
    }

    // void sk_path_add_arc(sk_path_t* cpath, const sk_rect_t* crect, float startAngle, float sweepAngle)
    static void sk_path_add_arc (sk_path_t* cpath, SKRect* crect, float startAngle, float sweepAngle)
    {
        .sk_path_add_arc (cpath, crect, startAngle, sweepAngle);
    }

    // void sk_path_add_circle(sk_path_t*, float x, float y, float radius, sk_path_direction_t dir)
    static void sk_path_add_circle (sk_path_t* param0, float x, float y, float radius, SKPathDirection dir)
    {
        .sk_path_add_circle (param0, x, y, radius, dir);
    }

    // void sk_path_add_oval(sk_path_t*, const sk_rect_t*, sk_path_direction_t)
    static void sk_path_add_oval (sk_path_t* param0, SKRect* param1, SKPathDirection param2)
    {
        .sk_path_add_oval (param0, param1, param2);
    }

    // void sk_path_add_path(sk_path_t* cpath, sk_path_t* other, sk_path_add_mode_t add_mode)
    static void sk_path_add_path (sk_path_t* cpath, sk_path_t* other, SKPathAddMode add_mode)
    {
        .sk_path_add_path (cpath, other, add_mode);
    }

    // void sk_path_add_path_matrix(sk_path_t* cpath, sk_path_t* other, sk_matrix_t* matrix, sk_path_add_mode_t add_mode)
    static void sk_path_add_path_matrix (sk_path_t* cpath, sk_path_t* other, SKMatrix* matrix, SKPathAddMode add_mode)
    {
        .sk_path_add_path_matrix (cpath, other, matrix, add_mode);
    }

    // void sk_path_add_path_offset(sk_path_t* cpath, sk_path_t* other, float dx, float dy, sk_path_add_mode_t add_mode)
    static void sk_path_add_path_offset (sk_path_t* cpath, sk_path_t* other, float dx, float dy, SKPathAddMode add_mode)
    {
        .sk_path_add_path_offset (cpath, other, dx, dy, add_mode);
    }

    // void sk_path_add_path_reverse(sk_path_t* cpath, sk_path_t* other)
    static void sk_path_add_path_reverse (sk_path_t* cpath, sk_path_t* other)
    {
        .sk_path_add_path_reverse (cpath, other);
    }

    // void sk_path_add_poly(sk_path_t* cpath, const sk_point_t* points, int count, bool close)
    static void sk_path_add_poly (sk_path_t* cpath, SKPoint* points, int count, bool close)
    {
        .sk_path_add_poly (cpath, points, count, close);
    }

    // void sk_path_add_rect(sk_path_t*, const sk_rect_t*, sk_path_direction_t)
    static void sk_path_add_rect (sk_path_t* param0, SKRect* param1, SKPathDirection param2)
    {
        .sk_path_add_rect (param0, param1, param2);
    }

    // void sk_path_add_rect_start(sk_path_t* cpath, const sk_rect_t* crect, sk_path_direction_t cdir, uint32_t startIndex)
    static void sk_path_add_rect_start (sk_path_t* cpath, SKRect* crect, SKPathDirection cdir, uint startIndex)
    {
        .sk_path_add_rect_start (cpath, crect, cdir, startIndex);
    }

    // void sk_path_add_rounded_rect(sk_path_t*, const sk_rect_t*, float, float, sk_path_direction_t)
    static void sk_path_add_rounded_rect (sk_path_t* param0, SKRect* param1, float param2, float param3, SKPathDirection param4)
    {
        .sk_path_add_rounded_rect (param0, param1, param2, param3, param4);
    }

    // void sk_path_add_rrect(sk_path_t*, const sk_rrect_t*, sk_path_direction_t)
    static void sk_path_add_rrect (sk_path_t* param0, sk_rrect_t* param1, SKPathDirection param2)
    {
        .sk_path_add_rrect (param0, param1, param2);
    }

    // void sk_path_add_rrect_start(sk_path_t*, const sk_rrect_t*, sk_path_direction_t, uint32_t)
    static void sk_path_add_rrect_start (sk_path_t* param0, sk_rrect_t* param1, SKPathDirection param2, uint param3)
    {
        .sk_path_add_rrect_start (param0, param1, param2, param3);
    }

    // void sk_path_arc_to(sk_path_t*, float rx, float ry, float xAxisRotate, sk_path_arc_size_t largeArc, sk_path_direction_t sweep, float x, float y)
    static void sk_path_arc_to (sk_path_t* param0, float rx, float ry, float xAxisRotate, SKPathArcSize largeArc, SKPathDirection sweep, float x, float y)
    {
        .sk_path_arc_to (param0, rx, ry, xAxisRotate, largeArc, sweep, x, y);
    }

    // void sk_path_arc_to_with_oval(sk_path_t*, const sk_rect_t* oval, float startAngle, float sweepAngle, bool forceMoveTo)
    static void sk_path_arc_to_with_oval (sk_path_t* param0, SKRect* oval, float startAngle, float sweepAngle, bool forceMoveTo)
    {
        .sk_path_arc_to_with_oval (param0, oval, startAngle, sweepAngle, forceMoveTo);
    }

    // void sk_path_arc_to_with_points(sk_path_t*, float x1, float y1, float x2, float y2, float radius)
    static void sk_path_arc_to_with_points (sk_path_t* param0, float x1, float y1, float x2, float y2, float radius)
    {
        .sk_path_arc_to_with_points (param0, x1, y1, x2, y2, radius);
    }

    // sk_path_t* sk_path_clone(const sk_path_t* cpath)
    static sk_path_t* sk_path_clone (sk_path_t* cpath)
    {
        return .sk_path_clone (cpath);
    }

    // void sk_path_close(sk_path_t*)
    static void sk_path_close (sk_path_t* param0)
    {
        .sk_path_close (param0);
    }

    // void sk_path_compute_tight_bounds(const sk_path_t*, sk_rect_t*)
    static void sk_path_compute_tight_bounds (sk_path_t* param0, SKRect* param1)
    {
        .sk_path_compute_tight_bounds (param0, param1);
    }

    // void sk_path_conic_to(sk_path_t*, float x0, float y0, float x1, float y1, float w)
    static void sk_path_conic_to (sk_path_t* param0, float x0, float y0, float x1, float y1, float w)
    {
        .sk_path_conic_to (param0, x0, y0, x1, y1, w);
    }

    // bool sk_path_contains(const sk_path_t* cpath, float x, float y)
    static bool sk_path_contains (sk_path_t* cpath, float x, float y)
    {
        return .sk_path_contains (cpath, x, y);
    }

    // int sk_path_convert_conic_to_quads(const sk_point_t* p0, const sk_point_t* p1, const sk_point_t* p2, float w, sk_point_t* pts, int pow2)
    static int sk_path_convert_conic_to_quads (SKPoint* p0, SKPoint* p1, SKPoint* p2, float w, SKPoint* pts, int pow2)
    {
        return .sk_path_convert_conic_to_quads (p0, p1, p2, w, pts, pow2);
    }

    // int sk_path_count_points(const sk_path_t* cpath)
    static int sk_path_count_points (sk_path_t* cpath)
    {
        return .sk_path_count_points (cpath);
    }

    // int sk_path_count_verbs(const sk_path_t* cpath)
    static int sk_path_count_verbs (sk_path_t* cpath)
    {
        return .sk_path_count_verbs (cpath);
    }

    // sk_path_iterator_t* sk_path_create_iter(sk_path_t* cpath, int forceClose)
    static sk_path_iterator_t* sk_path_create_iter (sk_path_t* cpath, int forceClose)
    {
        return .sk_path_create_iter (cpath, forceClose);
    }

    // sk_path_rawiterator_t* sk_path_create_rawiter(sk_path_t* cpath)
    static sk_path_rawiterator_t* sk_path_create_rawiter (sk_path_t* cpath)
    {
        return .sk_path_create_rawiter (cpath);
    }

    // void sk_path_cubic_to(sk_path_t*, float x0, float y0, float x1, float y1, float x2, float y2)
    static void sk_path_cubic_to (sk_path_t* param0, float x0, float y0, float x1, float y1, float x2, float y2)
    {
        .sk_path_cubic_to (param0, x0, y0, x1, y1, x2, y2);
    }

    // void sk_path_delete(sk_path_t*)
    static void sk_path_delete (sk_path_t* param0)
    {
        .sk_path_delete (param0);
    }

    // void sk_path_get_bounds(const sk_path_t*, sk_rect_t*)
    static void sk_path_get_bounds (sk_path_t* param0, SKRect* param1)
    {
        .sk_path_get_bounds (param0, param1);
    }

    // sk_path_convexity_t sk_path_get_convexity(const sk_path_t* cpath)
    static SKPathConvexity sk_path_get_convexity (sk_path_t* cpath)
    {
        return .sk_path_get_convexity (cpath);
    }

    // sk_path_filltype_t sk_path_get_filltype(sk_path_t*)
    static SKPathFillType sk_path_get_filltype (sk_path_t* param0)
    {
        return .sk_path_get_filltype (param0);
    }

    // bool sk_path_get_last_point(const sk_path_t* cpath, sk_point_t* point)
    static bool sk_path_get_last_point (sk_path_t* cpath, SKPoint* point)
    {
        return .sk_path_get_last_point (cpath, point);
    }

    // void sk_path_get_point(const sk_path_t* cpath, int index, sk_point_t* point)
    static void sk_path_get_point (sk_path_t* cpath, int index, SKPoint* point)
    {
        .sk_path_get_point (cpath, index, point);
    }

    // int sk_path_get_points(const sk_path_t* cpath, sk_point_t* points, int max)
    static int sk_path_get_points (sk_path_t* cpath, SKPoint* points, int max)
    {
        return .sk_path_get_points (cpath, points, max);
    }

    // uint32_t sk_path_get_segment_masks(sk_path_t* cpath)
    static uint sk_path_get_segment_masks (sk_path_t* cpath)
    {
        return .sk_path_get_segment_masks (cpath);
    }

    // bool sk_path_is_line(sk_path_t* cpath, sk_point_t[2] line = 2)
    static bool sk_path_is_line (sk_path_t* cpath, SKPoint* line)
    {
        return .sk_path_is_line (cpath, line);
    }

    // bool sk_path_is_oval(sk_path_t* cpath, sk_rect_t* bounds)
    static bool sk_path_is_oval (sk_path_t* cpath, SKRect* bounds)
    {
        return .sk_path_is_oval (cpath, bounds);
    }

    // bool sk_path_is_rect(sk_path_t* cpath, sk_rect_t* rect, bool* isClosed, sk_path_direction_t* direction)
    static bool sk_path_is_rect (sk_path_t* cpath, SKRect* rect, bool* isClosed, SKPathDirection* direction)
    {
        return .sk_path_is_rect (cpath, rect, isClosed , direction);
    }

    // bool sk_path_is_rrect(sk_path_t* cpath, sk_rrect_t* bounds)
    static bool sk_path_is_rrect (sk_path_t* cpath, sk_rrect_t* bounds)
    {
        return .sk_path_is_rrect (cpath, bounds);
    }

    // float sk_path_iter_conic_weight(sk_path_iterator_t* iterator)
    static float sk_path_iter_conic_weight (sk_path_iterator_t* iterator)
    {
        return .sk_path_iter_conic_weight (iterator);
    }

    // void sk_path_iter_destroy(sk_path_iterator_t* iterator)
    static void sk_path_iter_destroy (sk_path_iterator_t* iterator)
    {
        .sk_path_iter_destroy (iterator);
    }

    // int sk_path_iter_is_close_line(sk_path_iterator_t* iterator)
    static int sk_path_iter_is_close_line (sk_path_iterator_t* iterator)
    {
        return .sk_path_iter_is_close_line (iterator);
    }

    // int sk_path_iter_is_closed_contour(sk_path_iterator_t* iterator)
    static int sk_path_iter_is_closed_contour (sk_path_iterator_t* iterator)
    {
        return .sk_path_iter_is_closed_contour (iterator);
    }

    // sk_path_verb_t sk_path_iter_next(sk_path_iterator_t* iterator, sk_point_t[4] points = 4)
    static SKPathVerb sk_path_iter_next (sk_path_iterator_t* iterator, SKPoint* points)
    {
        return .sk_path_iter_next (iterator, points);
    }

    // void sk_path_line_to(sk_path_t*, float x, float y)
    static void sk_path_line_to (sk_path_t* param0, float x, float y)
    {
        .sk_path_line_to (param0, x, y);
    }

    // void sk_path_move_to(sk_path_t*, float x, float y)
    static void sk_path_move_to (sk_path_t* param0, float x, float y)
    {
        .sk_path_move_to (param0, x, y);
    }

    // sk_path_t* sk_path_new()
    static sk_path_t* sk_path_new ()
    {
        return .sk_path_new ();
    }

    // bool sk_path_parse_svg_string(sk_path_t* cpath, const(char)* str)
    static bool sk_path_parse_svg_string (sk_path_t* cpath, string str)
    {
        return .sk_path_parse_svg_string (cpath, str.toStringz());
    }

    // void sk_path_quad_to(sk_path_t*, float x0, float y0, float x1, float y1)
    static void sk_path_quad_to (sk_path_t* param0, float x0, float y0, float x1, float y1)
    {
        .sk_path_quad_to (param0, x0, y0, x1, y1);
    }

    // void sk_path_rarc_to(sk_path_t*, float rx, float ry, float xAxisRotate, sk_path_arc_size_t largeArc, sk_path_direction_t sweep, float x, float y)
    static void sk_path_rarc_to (sk_path_t* param0, float rx, float ry, float xAxisRotate, SKPathArcSize largeArc, SKPathDirection sweep, float x, float y)
    {
        .sk_path_rarc_to (param0, rx, ry, xAxisRotate, largeArc, sweep, x, y);
    }

    // float sk_path_rawiter_conic_weight(sk_path_rawiterator_t* iterator)
    static float sk_path_rawiter_conic_weight (sk_path_rawiterator_t* iterator)
    {
        return .sk_path_rawiter_conic_weight (iterator);
    }

    // void sk_path_rawiter_destroy(sk_path_rawiterator_t* iterator)
    static void sk_path_rawiter_destroy (sk_path_rawiterator_t* iterator)
    {
        .sk_path_rawiter_destroy (iterator);
    }

    // sk_path_verb_t sk_path_rawiter_next(sk_path_rawiterator_t* iterator, sk_point_t[4] points = 4)
    static SKPathVerb sk_path_rawiter_next (sk_path_rawiterator_t* iterator, SKPoint* points)
    {
        return .sk_path_rawiter_next (iterator, points);
    }

    // sk_path_verb_t sk_path_rawiter_peek(sk_path_rawiterator_t* iterator)
    static SKPathVerb sk_path_rawiter_peek (sk_path_rawiterator_t* iterator)
    {
        return .sk_path_rawiter_peek (iterator);
    }

    // void sk_path_rconic_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1, float w)
    static void sk_path_rconic_to (sk_path_t* param0, float dx0, float dy0, float dx1, float dy1, float w)
    {
        .sk_path_rconic_to (param0, dx0, dy0, dx1, dy1, w);
    }

    // void sk_path_rcubic_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1, float dx2, float dy2)
    static void sk_path_rcubic_to (sk_path_t* param0, float dx0, float dy0, float dx1, float dy1, float dx2, float dy2)
    {
        .sk_path_rcubic_to (param0, dx0, dy0, dx1, dy1, dx2, dy2);
    }

    // void sk_path_reset(sk_path_t* cpath)
    static void sk_path_reset (sk_path_t* cpath)
    {
        .sk_path_reset (cpath);
    }

    // void sk_path_rewind(sk_path_t* cpath)
    static void sk_path_rewind (sk_path_t* cpath)
    {
        .sk_path_rewind (cpath);
    }

    // void sk_path_rline_to(sk_path_t*, float dx, float yd)
    static void sk_path_rline_to (sk_path_t* param0, float dx, float yd)
    {
        .sk_path_rline_to (param0, dx, yd);
    }

    // void sk_path_rmove_to(sk_path_t*, float dx, float dy)
    static void sk_path_rmove_to (sk_path_t* param0, float dx, float dy)
    {
        .sk_path_rmove_to (param0, dx, dy);
    }

    // void sk_path_rquad_to(sk_path_t*, float dx0, float dy0, float dx1, float dy1)
    static void sk_path_rquad_to (sk_path_t* param0, float dx0, float dy0, float dx1, float dy1)
    {
        .sk_path_rquad_to (param0, dx0, dy0, dx1, dy1);
    }

    // void sk_path_set_convexity(sk_path_t* cpath, sk_path_convexity_t convexity)
    static void sk_path_set_convexity (sk_path_t* cpath, SKPathConvexity convexity)
    {
        .sk_path_set_convexity (cpath, convexity);
    }

    // void sk_path_set_filltype(sk_path_t*, sk_path_filltype_t)
    static void sk_path_set_filltype (sk_path_t* param0, SKPathFillType param1)
    {
        .sk_path_set_filltype (param0, param1);
    }

    // void sk_path_to_svg_string(const sk_path_t* cpath, sk_string_t* str)
    static void sk_path_to_svg_string (sk_path_t* cpath, sk_string_t* str)
    {
        .sk_path_to_svg_string (cpath, str);
    }

    // void sk_path_transform(sk_path_t* cpath, const sk_matrix_t* cmatrix)
    static void sk_path_transform (sk_path_t* cpath, SKMatrix* cmatrix)
    {
        .sk_path_transform (cpath, cmatrix);
    }

    // void sk_path_transform_to_dest(const sk_path_t* cpath, const sk_matrix_t* cmatrix, sk_path_t* destination)
    static void sk_path_transform_to_dest (sk_path_t* cpath, SKMatrix* cmatrix, sk_path_t* destination)
    {
        .sk_path_transform_to_dest (cpath, cmatrix, destination);
    }

    // void sk_pathmeasure_destroy(sk_pathmeasure_t* pathMeasure)
    static void sk_pathmeasure_destroy (sk_pathmeasure_t* pathMeasure)
    {
        .sk_pathmeasure_destroy (pathMeasure);
    }

    // float sk_pathmeasure_get_length(sk_pathmeasure_t* pathMeasure)
    static float sk_pathmeasure_get_length (sk_pathmeasure_t* pathMeasure)
    {
        return .sk_pathmeasure_get_length (pathMeasure);
    }

    // bool sk_pathmeasure_get_matrix(sk_pathmeasure_t* pathMeasure, float distance, sk_matrix_t* matrix, sk_pathmeasure_matrixflags_t flags)
    static bool sk_pathmeasure_get_matrix (sk_pathmeasure_t* pathMeasure, float distance, SKMatrix* matrix, SKPathMeasureMatrixFlags flags)
    {
        return .sk_pathmeasure_get_matrix (pathMeasure, distance, matrix, flags);
    }

    // bool sk_pathmeasure_get_pos_tan(sk_pathmeasure_t* pathMeasure, float distance, sk_point_t* position, sk_vector_t* tangent)
    static bool sk_pathmeasure_get_pos_tan (sk_pathmeasure_t* pathMeasure, float distance, SKPoint* position, SKPoint* tangent)
    {
        return .sk_pathmeasure_get_pos_tan (pathMeasure, distance, position, tangent);
    }

    // bool sk_pathmeasure_get_segment(sk_pathmeasure_t* pathMeasure, float start, float stop, sk_path_t* dst, bool startWithMoveTo)
    static bool sk_pathmeasure_get_segment (sk_pathmeasure_t* pathMeasure, float start, float stop, sk_path_t* dst, bool startWithMoveTo)
    {
        return .sk_pathmeasure_get_segment (pathMeasure, start, stop, dst, startWithMoveTo);
    }

    // bool sk_pathmeasure_is_closed(sk_pathmeasure_t* pathMeasure)
    static bool sk_pathmeasure_is_closed (sk_pathmeasure_t* pathMeasure)
    {
        return .sk_pathmeasure_is_closed (pathMeasure);
    }

    // sk_pathmeasure_t* sk_pathmeasure_new()
    static sk_pathmeasure_t* sk_pathmeasure_new ()
    {
        return .sk_pathmeasure_new ();
    }

    // sk_pathmeasure_t* sk_pathmeasure_new_with_path(const sk_path_t* path, bool forceClosed, float resScale)
    static sk_pathmeasure_t* sk_pathmeasure_new_with_path (sk_path_t* path, bool forceClosed, float resScale)
    {
        return .sk_pathmeasure_new_with_path (path, forceClosed, resScale);
    }

    // bool sk_pathmeasure_next_contour(sk_pathmeasure_t* pathMeasure)
    static bool sk_pathmeasure_next_contour (sk_pathmeasure_t* pathMeasure)
    {
        return .sk_pathmeasure_next_contour (pathMeasure);
    }

    // void sk_pathmeasure_set_path(sk_pathmeasure_t* pathMeasure, const sk_path_t* path, bool forceClosed)
    static void sk_pathmeasure_set_path (sk_pathmeasure_t* pathMeasure, sk_path_t* path, bool forceClosed)
    {
        .sk_pathmeasure_set_path (pathMeasure, path, forceClosed);
    }

    // bool sk_pathop_as_winding(const sk_path_t* path, sk_path_t* result)
    static bool sk_pathop_as_winding (sk_path_t* path, sk_path_t* result)
    {
        return .sk_pathop_as_winding (path, result);
    }

    // bool sk_pathop_op(const sk_path_t* one, const sk_path_t* two, sk_pathop_t op, sk_path_t* result)
    static bool sk_pathop_op (sk_path_t* one, sk_path_t* two, SKPathOp op, sk_path_t* result)
    {
        return .sk_pathop_op (one, two, op, result);
    }

    // bool sk_pathop_simplify(const sk_path_t* path, sk_path_t* result)
    static bool sk_pathop_simplify (sk_path_t* path, sk_path_t* result)
    {
        return .sk_pathop_simplify (path, result);
    }

    // bool sk_pathop_tight_bounds(const sk_path_t* path, sk_rect_t* result)
    static bool sk_pathop_tight_bounds (sk_path_t* path, SKRect* result)
    {
        return .sk_pathop_tight_bounds (path, result);
    }

    // end header: sk_path.h

    // for header: sk_patheffect.h

    // sk_path_effect_t* sk_path_effect_create_1d_path(const sk_path_t* path, float advance, float phase, sk_path_effect_1d_style_t style)
    static sk_path_effect_t* sk_path_effect_create_1d_path (sk_path_t* path, float advance, float phase, SKPath1DPathEffectStyle style)
    {
        return .sk_path_effect_create_1d_path (path, advance, phase, style);
    }

    // sk_path_effect_t* sk_path_effect_create_2d_line(float width, const sk_matrix_t* matrix)
    static sk_path_effect_t* sk_path_effect_create_2d_line (float width, SKMatrix* matrix)
    {
        return .sk_path_effect_create_2d_line (width, matrix);
    }

    // sk_path_effect_t* sk_path_effect_create_2d_path(const sk_matrix_t* matrix, const sk_path_t* path)
    static sk_path_effect_t* sk_path_effect_create_2d_path (SKMatrix* matrix, sk_path_t* path)
    {
        return .sk_path_effect_create_2d_path (matrix, path);
    }

    // sk_path_effect_t* sk_path_effect_create_compose(sk_path_effect_t* outer, sk_path_effect_t* inner)
    static sk_path_effect_t* sk_path_effect_create_compose (sk_path_effect_t* outer, sk_path_effect_t* inner)
    {
        return .sk_path_effect_create_compose (outer, inner);
    }

    // sk_path_effect_t* sk_path_effect_create_corner(float radius)
    static sk_path_effect_t* sk_path_effect_create_corner (float radius)
    {
        return .sk_path_effect_create_corner (radius);
    }

    // sk_path_effect_t* sk_path_effect_create_dash(const float* intervals, int count, float phase)
    static sk_path_effect_t* sk_path_effect_create_dash (float* intervals, int count, float phase)
    {
        return .sk_path_effect_create_dash (intervals, count, phase);
    }

    // sk_path_effect_t* sk_path_effect_create_discrete(float segLength, float deviation, uint32_t seedAssist)
    static sk_path_effect_t* sk_path_effect_create_discrete (float segLength, float deviation, uint seedAssist)
    {
        return .sk_path_effect_create_discrete (segLength, deviation, seedAssist);
    }

    // sk_path_effect_t* sk_path_effect_create_sum(sk_path_effect_t* first, sk_path_effect_t* second)
    static sk_path_effect_t* sk_path_effect_create_sum (sk_path_effect_t* first, sk_path_effect_t* second)
    {
        return .sk_path_effect_create_sum (first, second);
    }

    // sk_path_effect_t* sk_path_effect_create_trim(float start, float stop, sk_path_effect_trim_mode_t mode)
    static sk_path_effect_t* sk_path_effect_create_trim (float start, float stop, SKTrimPathEffectMode mode)
    {
        return .sk_path_effect_create_trim (start, stop, mode);
    }

    // void sk_path_effect_unref(sk_path_effect_t* t)
    static void sk_path_effect_unref (sk_path_effect_t* t)
    {
        .sk_path_effect_unref (t);
    }

    // end header: sk_patheffect.h

    // for header: sk_picture.h

    // sk_picture_t* sk_picture_deserialize_from_data(sk_data_t* data)
    // static sk_picture_t* sk_picture_deserialize_from_data (sk_data_t* data)
    // {
    //     return .sk_picture_deserialize_from_data (data);
    // }

    // // sk_picture_t* sk_picture_deserialize_from_memory(void* buffer, size_t length)
    // static sk_picture_t* sk_picture_deserialize_from_memory (void* buffer, size_t length)
    // {
    //     return .sk_picture_deserialize_from_memory (buffer, length);
    // }

    // // sk_picture_t* sk_picture_deserialize_from_stream(sk_stream_t* stream)
    // static sk_picture_t* sk_picture_deserialize_from_stream (sk_stream_t* stream)
    // {
    //     return .sk_picture_deserialize_from_stream (stream);
    // }

    // void sk_picture_get_cull_rect(sk_picture_t*, sk_rect_t*)
    static void sk_picture_get_cull_rect (sk_picture_t* param0, SKRect* param1)
    {
        .sk_picture_get_cull_rect (param0, param1);
    }

    // sk_canvas_t* sk_picture_get_recording_canvas(sk_picture_recorder_t* crec)
    static sk_canvas_t* sk_picture_get_recording_canvas (sk_picture_recorder_t* crec)
    {
        return .sk_picture_get_recording_canvas (crec);
    }

    // uint32_t sk_picture_get_unique_id(sk_picture_t*)
    static uint sk_picture_get_unique_id (sk_picture_t* param0)
    {
        return .sk_picture_get_unique_id (param0);
    }

    // sk_shader_t* sk_picture_make_shader(sk_picture_t* src, sk_shader_tilemode_t tmx, sk_shader_tilemode_t tmy, const sk_matrix_t* localMatrix, const sk_rect_t* tile)
    static sk_shader_t* sk_picture_make_shader (sk_picture_t* src, SKShaderTileMode tmx, SKShaderTileMode tmy, SKMatrix* localMatrix, SKRect* tile)
    {
        return .sk_picture_make_shader (src, tmx, tmy, localMatrix, tile);
    }

    // sk_canvas_t* sk_picture_recorder_begin_recording(sk_picture_recorder_t*, const sk_rect_t*)
    static sk_canvas_t* sk_picture_recorder_begin_recording (sk_picture_recorder_t* param0, SKRect* param1)
    {
        return .sk_picture_recorder_begin_recording (param0, param1);
    }

    // void sk_picture_recorder_delete(sk_picture_recorder_t*)
    static void sk_picture_recorder_delete (sk_picture_recorder_t* param0)
    {
        .sk_picture_recorder_delete (param0);
    }

    // sk_picture_t* sk_picture_recorder_end_recording(sk_picture_recorder_t*)
    static sk_picture_t* sk_picture_recorder_end_recording (sk_picture_recorder_t* param0)
    {
        return .sk_picture_recorder_end_recording (param0);
    }

    // sk_drawable_t* sk_picture_recorder_end_recording_as_drawable(sk_picture_recorder_t*)
    static sk_drawable_t* sk_picture_recorder_end_recording_as_drawable (sk_picture_recorder_t* param0)
    {
        return .sk_picture_recorder_end_recording_as_drawable (param0);
    }

    // sk_picture_recorder_t* sk_picture_recorder_new()
    static sk_picture_recorder_t* sk_picture_recorder_new ()
    {
        return .sk_picture_recorder_new ();
    }

    // void sk_picture_ref(sk_picture_t*)
    static void sk_picture_ref (sk_picture_t* param0)
    {
        .sk_picture_ref (param0);
    }

    // // sk_data_t* sk_picture_serialize_to_data(const sk_picture_t* picture)
    // static sk_data_t* sk_picture_serialize_to_data (sk_picture_t* picture)
    // {
    //     return .sk_picture_serialize_to_data (picture);
    // }

    // // void sk_picture_serialize_to_stream(const sk_picture_t* picture, sk_wstream_t* stream)
    // static void sk_picture_serialize_to_stream (sk_picture_t* picture, sk_wstream_t* stream)
    // {
    //     .sk_picture_serialize_to_stream (picture, stream);
    // }

    // void sk_picture_unref(sk_picture_t*)
    static void sk_picture_unref (sk_picture_t* param0)
    {
        .sk_picture_unref (param0);
    }

    // end header: sk_picture.h

    // for header: sk_pixmap.h

    // void sk_color_get_bit_shift(int* a, int* r, int* g, int* b)
    static void sk_color_get_bit_shift (int* a, int* r, int* g, int* b)
    {
        .sk_color_get_bit_shift (a, r, g, b);
    }

    // sk_pmcolor_t sk_color_premultiply(const sk_color_t color)
    static uint sk_color_premultiply (uint color)
    {
        return .sk_color_premultiply (color);
    }

    // void sk_color_premultiply_array(const sk_color_t* colors, int size, sk_pmcolor_t* pmcolors)
    static void sk_color_premultiply_array (uint* colors, int size, uint* pmcolors)
    {
        .sk_color_premultiply_array (colors, size, pmcolors);
    }

    // sk_color_t sk_color_unpremultiply(const sk_pmcolor_t pmcolor)
    static uint sk_color_unpremultiply (uint pmcolor)
    {
        return .sk_color_unpremultiply (pmcolor);
    }

    // void sk_color_unpremultiply_array(const sk_pmcolor_t* pmcolors, int size, sk_color_t* colors)
    static void sk_color_unpremultiply_array (uint* pmcolors, int size, uint* colors)
    {
        .sk_color_unpremultiply_array (pmcolors, size, colors);
    }

    // bool sk_jpegencoder_encode(sk_wstream_t* dst, const sk_pixmap_t* src, const sk_jpegencoder_options_t* options)
    static bool sk_jpegencoder_encode (sk_wstream_t* dst, sk_pixmap_t* src, SKJpegEncoderOptions* options)
    {
        return .sk_jpegencoder_encode (dst, src, options);
    }

    // void sk_pixmap_destructor(sk_pixmap_t* cpixmap)
    static void sk_pixmap_destructor (sk_pixmap_t* cpixmap)
    {
        .sk_pixmap_destructor (cpixmap);
    }

    // bool sk_pixmap_encode_image(sk_wstream_t* dst, const sk_pixmap_t* src, sk_encoded_image_format_t encoder, int quality)
    static bool sk_pixmap_encode_image (sk_wstream_t* dst, sk_pixmap_t* src, SKEncodedImageFormat encoder, int quality)
    {
        return .sk_pixmap_encode_image (dst, src, encoder, quality);
    }

    // bool sk_pixmap_erase_color(const sk_pixmap_t* cpixmap, sk_color_t color, const sk_irect_t* subset)
    static bool sk_pixmap_erase_color (sk_pixmap_t* cpixmap, uint color, SKRectI* subset)
    {
        return .sk_pixmap_erase_color (cpixmap, color, subset);
    }

    // bool sk_pixmap_erase_color4f(const sk_pixmap_t* cpixmap, const sk_color4f_t* color, const sk_irect_t* subset)
    static bool sk_pixmap_erase_color4f (sk_pixmap_t* cpixmap, SKColorF* color, SKRectI* subset)
    {
        return .sk_pixmap_erase_color4f (cpixmap, color, subset);
    }

    // bool sk_pixmap_extract_subset(const sk_pixmap_t* cpixmap, sk_pixmap_t* result, const sk_irect_t* subset)
    static bool sk_pixmap_extract_subset (sk_pixmap_t* cpixmap, sk_pixmap_t* result, SKRectI* subset)
    {
        return .sk_pixmap_extract_subset (cpixmap, result, subset);
    }

    // void sk_pixmap_get_info(const sk_pixmap_t* cpixmap, sk_imageinfo_t* cinfo)
    static void sk_pixmap_get_info (sk_pixmap_t* cpixmap, SKImageInfoNative* cinfo)
    {
        .sk_pixmap_get_info (cpixmap, cinfo);
    }

    // sk_color_t sk_pixmap_get_pixel_color(const sk_pixmap_t* cpixmap, int x, int y)
    static uint sk_pixmap_get_pixel_color (sk_pixmap_t* cpixmap, int x, int y)
    {
        return .sk_pixmap_get_pixel_color (cpixmap, x, y);
    }

    // const(void)* sk_pixmap_get_pixels(const sk_pixmap_t* cpixmap)
    static const(void)* sk_pixmap_get_pixels (sk_pixmap_t* cpixmap)
    {
        return .sk_pixmap_get_pixels (cpixmap);
    }

    // const(void)* sk_pixmap_get_pixels_with_xy(const sk_pixmap_t* cpixmap, int x, int y)
    static const(void)* sk_pixmap_get_pixels_with_xy (sk_pixmap_t* cpixmap, int x, int y)
    {
        return .sk_pixmap_get_pixels_with_xy (cpixmap, x, y);
    }

    // size_t sk_pixmap_get_row_bytes(const sk_pixmap_t* cpixmap)
    static size_t sk_pixmap_get_row_bytes (sk_pixmap_t* cpixmap)
    {
        return .sk_pixmap_get_row_bytes (cpixmap);
    }

    // void* sk_pixmap_get_writable_addr(const sk_pixmap_t* cpixmap)
    static void* sk_pixmap_get_writable_addr (sk_pixmap_t* cpixmap)
    {
        return .sk_pixmap_get_writable_addr (cpixmap);
    }

    // sk_pixmap_t* sk_pixmap_new()
    static sk_pixmap_t* sk_pixmap_new ()
    {
        return .sk_pixmap_new ();
    }

    // sk_pixmap_t* sk_pixmap_new_with_params(const sk_imageinfo_t* cinfo, const(void)* addr, size_t rowBytes)
    static sk_pixmap_t* sk_pixmap_new_with_params (SKImageInfoNative* cinfo, void* addr, size_t rowBytes)
    {
        return .sk_pixmap_new_with_params (cinfo, addr, rowBytes);
    }

    // bool sk_pixmap_read_pixels(const sk_pixmap_t* cpixmap, const sk_imageinfo_t* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY)
    static bool sk_pixmap_read_pixels (sk_pixmap_t* cpixmap, SKImageInfoNative* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY)
    {
        return .sk_pixmap_read_pixels (cpixmap, dstInfo, dstPixels, dstRowBytes, srcX, srcY);
    }

    // void sk_pixmap_reset(sk_pixmap_t* cpixmap)
    static void sk_pixmap_reset (sk_pixmap_t* cpixmap)
    {
        .sk_pixmap_reset (cpixmap);
    }

    // void sk_pixmap_reset_with_params(sk_pixmap_t* cpixmap, const sk_imageinfo_t* cinfo, const(void)* addr, size_t rowBytes)
    static void sk_pixmap_reset_with_params (sk_pixmap_t* cpixmap, SKImageInfoNative* cinfo, void* addr, size_t rowBytes)
    {
        .sk_pixmap_reset_with_params (cpixmap, cinfo, addr, rowBytes);
    }

    // bool sk_pixmap_scale_pixels(const sk_pixmap_t* cpixmap, const sk_pixmap_t* dst, sk_filter_quality_t quality)
    static bool sk_pixmap_scale_pixels (sk_pixmap_t* cpixmap, sk_pixmap_t* dst, SKFilterQuality quality)
    {
        return .sk_pixmap_scale_pixels (cpixmap, dst, quality);
    }

    // bool sk_pngencoder_encode(sk_wstream_t* dst, const sk_pixmap_t* src, const sk_pngencoder_options_t* options)
    static bool sk_pngencoder_encode (sk_wstream_t* dst, sk_pixmap_t* src, SKPngEncoderOptions* options)
    {
        return .sk_pngencoder_encode (dst, src, options);
    }

    // void sk_swizzle_swap_rb(uint32_t* dest, const uint32_t* src, int count)
    static void sk_swizzle_swap_rb (uint* dest, uint* src, int count)
    {
        .sk_swizzle_swap_rb (dest, src, count);
    }

    // bool sk_webpencoder_encode(sk_wstream_t* dst, const sk_pixmap_t* src, const sk_webpencoder_options_t* options)
    static bool sk_webpencoder_encode (sk_wstream_t* dst, sk_pixmap_t* src, SKWebpEncoderOptions* options)
    {
        return .sk_webpencoder_encode (dst, src, options);
    }

    // end header: sk_pixmap.h

    // for header: sk_region.h

    // void sk_region_cliperator_delete(sk_region_cliperator_t* iter)
    static void sk_region_cliperator_delete (sk_region_cliperator_t* iter)
    {
        .sk_region_cliperator_delete (iter);
    }

    // bool sk_region_cliperator_done(sk_region_cliperator_t* iter)
    static bool sk_region_cliperator_done (sk_region_cliperator_t* iter)
    {
        return .sk_region_cliperator_done (iter);
    }

    // sk_region_cliperator_t* sk_region_cliperator_new(const sk_region_t* region, const sk_irect_t* clip)
    static sk_region_cliperator_t* sk_region_cliperator_new (sk_region_t* region, SKRectI* clip)
    {
        return .sk_region_cliperator_new (region, clip);
    }

    // void sk_region_cliperator_next(sk_region_cliperator_t* iter)
    static void sk_region_cliperator_next (sk_region_cliperator_t* iter)
    {
        .sk_region_cliperator_next (iter);
    }

    // void sk_region_cliperator_rect(const sk_region_cliperator_t* iter, sk_irect_t* rect)
    static void sk_region_cliperator_rect (sk_region_cliperator_t* iter, SKRectI* rect)
    {
        .sk_region_cliperator_rect (iter, rect);
    }

    // bool sk_region_contains(const sk_region_t* r, const sk_region_t* region)
    static bool sk_region_contains (sk_region_t* r, sk_region_t* region)
    {
        return .sk_region_contains (r, region);
    }

    // bool sk_region_contains_point(const sk_region_t* r, int x, int y)
    static bool sk_region_contains_point (sk_region_t* r, int x, int y)
    {
        return .sk_region_contains_point (r, x, y);
    }

    // bool sk_region_contains_rect(const sk_region_t* r, const sk_irect_t* rect)
    static bool sk_region_contains_rect (sk_region_t* r, SKRectI* rect)
    {
        return .sk_region_contains_rect (r, rect);
    }

    // void sk_region_delete(sk_region_t* r)
    static void sk_region_delete (sk_region_t* r)
    {
        .sk_region_delete (r);
    }

    // bool sk_region_get_boundary_path(const sk_region_t* r, sk_path_t* path)
    static bool sk_region_get_boundary_path (sk_region_t* r, sk_path_t* path)
    {
        return .sk_region_get_boundary_path (r, path);
    }

    // void sk_region_get_bounds(const sk_region_t* r, sk_irect_t* rect)
    static void sk_region_get_bounds (sk_region_t* r, SKRectI* rect)
    {
        .sk_region_get_bounds (r, rect);
    }

    // bool sk_region_intersects(const sk_region_t* r, const sk_region_t* src)
    static bool sk_region_intersects (sk_region_t* r, sk_region_t* src)
    {
        return .sk_region_intersects (r, src);
    }

    // bool sk_region_intersects_rect(const sk_region_t* r, const sk_irect_t* rect)
    static bool sk_region_intersects_rect (sk_region_t* r, SKRectI* rect)
    {
        return .sk_region_intersects_rect (r, rect);
    }

    // bool sk_region_is_complex(const sk_region_t* r)
    static bool sk_region_is_complex (sk_region_t* r)
    {
        return .sk_region_is_complex (r);
    }

    // bool sk_region_is_empty(const sk_region_t* r)
    static bool sk_region_is_empty (sk_region_t* r)
    {
        return .sk_region_is_empty (r);
    }

    // bool sk_region_is_rect(const sk_region_t* r)
    static bool sk_region_is_rect (sk_region_t* r)
    {
        return .sk_region_is_rect (r);
    }

    // void sk_region_iterator_delete(sk_region_iterator_t* iter)
    static void sk_region_iterator_delete (sk_region_iterator_t* iter)
    {
        .sk_region_iterator_delete (iter);
    }

    // bool sk_region_iterator_done(const sk_region_iterator_t* iter)
    static bool sk_region_iterator_done (sk_region_iterator_t* iter)
    {
        return .sk_region_iterator_done (iter);
    }

    // sk_region_iterator_t* sk_region_iterator_new(const sk_region_t* region)
    static sk_region_iterator_t* sk_region_iterator_new (sk_region_t* region)
    {
        return .sk_region_iterator_new (region);
    }

    // void sk_region_iterator_next(sk_region_iterator_t* iter)
    static void sk_region_iterator_next (sk_region_iterator_t* iter)
    {
        .sk_region_iterator_next (iter);
    }

    // void sk_region_iterator_rect(const sk_region_iterator_t* iter, sk_irect_t* rect)
    static void sk_region_iterator_rect (sk_region_iterator_t* iter, SKRectI* rect)
    {
        .sk_region_iterator_rect (iter, rect);
    }

    // bool sk_region_iterator_rewind(sk_region_iterator_t* iter)
    static bool sk_region_iterator_rewind (sk_region_iterator_t* iter)
    {
        return .sk_region_iterator_rewind (iter);
    }

    // sk_region_t* sk_region_new()
    static sk_region_t* sk_region_new ()
    {
        return .sk_region_new ();
    }

    // bool sk_region_op(sk_region_t* r, const sk_region_t* region, sk_region_op_t op)
    static bool sk_region_op (sk_region_t* r, sk_region_t* region, SKRegionOperation op)
    {
        return .sk_region_op (r, region, op);
    }

    // bool sk_region_op_rect(sk_region_t* r, const sk_irect_t* rect, sk_region_op_t op)
    static bool sk_region_op_rect (sk_region_t* r, SKRectI* rect, SKRegionOperation op)
    {
        return .sk_region_op_rect (r, rect, op);
    }

    // bool sk_region_quick_contains(const sk_region_t* r, const sk_irect_t* rect)
    static bool sk_region_quick_contains (sk_region_t* r, SKRectI* rect)
    {
        return .sk_region_quick_contains (r, rect);
    }

    // bool sk_region_quick_reject(const sk_region_t* r, const sk_region_t* region)
    static bool sk_region_quick_reject (sk_region_t* r, sk_region_t* region)
    {
        return .sk_region_quick_reject (r, region);
    }

    // bool sk_region_quick_reject_rect(const sk_region_t* r, const sk_irect_t* rect)
    static bool sk_region_quick_reject_rect (sk_region_t* r, SKRectI* rect)
    {
        return .sk_region_quick_reject_rect (r, rect);
    }

    // bool sk_region_set_empty(sk_region_t* r)
    static bool sk_region_set_empty (sk_region_t* r)
    {
        return .sk_region_set_empty (r);
    }

    // bool sk_region_set_path(sk_region_t* r, const sk_path_t* t, const sk_region_t* clip)
    static bool sk_region_set_path (sk_region_t* r, sk_path_t* t, sk_region_t* clip)
    {
        return .sk_region_set_path (r, t, clip);
    }

    // bool sk_region_set_rect(sk_region_t* r, const sk_irect_t* rect)
    static bool sk_region_set_rect (sk_region_t* r, SKRectI* rect)
    {
        return .sk_region_set_rect (r, rect);
    }

    // bool sk_region_set_rects(sk_region_t* r, const sk_irect_t* rects, int count)
    static bool sk_region_set_rects (sk_region_t* r, SKRectI* rects, int count)
    {
        return .sk_region_set_rects (r, rects, count);
    }

    // bool sk_region_set_region(sk_region_t* r, const sk_region_t* region)
    static bool sk_region_set_region (sk_region_t* r, sk_region_t* region)
    {
        return .sk_region_set_region (r, region);
    }

    // void sk_region_spanerator_delete(sk_region_spanerator_t* iter)
    static void sk_region_spanerator_delete (sk_region_spanerator_t* iter)
    {
        .sk_region_spanerator_delete (iter);
    }

    // sk_region_spanerator_t* sk_region_spanerator_new(const sk_region_t* region, int y, int left, int right)
    static sk_region_spanerator_t* sk_region_spanerator_new (sk_region_t* region, int y, int left, int right)
    {
        return .sk_region_spanerator_new (region, y, left, right);
    }

    // bool sk_region_spanerator_next(sk_region_spanerator_t* iter, int* left, int* right)
    static bool sk_region_spanerator_next (sk_region_spanerator_t* iter, int* left, int* right)
    {
        return .sk_region_spanerator_next (iter, left, right);
    }

    // void sk_region_translate(sk_region_t* r, int x, int y)
    static void sk_region_translate (sk_region_t* r, int x, int y)
    {
        .sk_region_translate (r, x, y);
    }

    // end header: sk_region.h

    // for header: sk_rrect.h

    // bool sk_rrect_contains(const sk_rrect_t* rrect, const sk_rect_t* rect)
    static bool sk_rrect_contains (sk_rrect_t* rrect, SKRect* rect)
    {
        return .sk_rrect_contains (rrect, rect);
    }

    // void sk_rrect_delete(const sk_rrect_t* rrect)
    static void sk_rrect_delete (sk_rrect_t* rrect)
    {
        .sk_rrect_delete (rrect);
    }

    // float sk_rrect_get_height(const sk_rrect_t* rrect)
    static float sk_rrect_get_height (sk_rrect_t* rrect)
    {
        return .sk_rrect_get_height (rrect);
    }

    // void sk_rrect_get_radii(const sk_rrect_t* rrect, sk_rrect_corner_t corner, sk_vector_t* radii)
    static void sk_rrect_get_radii (sk_rrect_t* rrect, SKRoundRectCorner corner, SKPoint* radii)
    {
        .sk_rrect_get_radii (rrect, corner, radii);
    }

    // void sk_rrect_get_rect(const sk_rrect_t* rrect, sk_rect_t* rect)
    static void sk_rrect_get_rect (sk_rrect_t* rrect, SKRect* rect)
    {
        .sk_rrect_get_rect (rrect, rect);
    }

    // sk_rrect_type_t sk_rrect_get_type(const sk_rrect_t* rrect)
    static SKRoundRectType sk_rrect_get_type (sk_rrect_t* rrect)
    {
        return .sk_rrect_get_type (rrect);
    }

    // float sk_rrect_get_width(const sk_rrect_t* rrect)
    static float sk_rrect_get_width (sk_rrect_t* rrect)
    {
        return .sk_rrect_get_width (rrect);
    }

    // void sk_rrect_inset(sk_rrect_t* rrect, float dx, float dy)
    static void sk_rrect_inset (sk_rrect_t* rrect, float dx, float dy)
    {
        .sk_rrect_inset (rrect, dx, dy);
    }

    // bool sk_rrect_is_valid(const sk_rrect_t* rrect)
    static bool sk_rrect_is_valid (sk_rrect_t* rrect)
    {
        return .sk_rrect_is_valid (rrect);
    }

    // sk_rrect_t* sk_rrect_new()
    static sk_rrect_t* sk_rrect_new ()
    {
        return .sk_rrect_new ();
    }

    // sk_rrect_t* sk_rrect_new_copy(const sk_rrect_t* rrect)
    static sk_rrect_t* sk_rrect_new_copy (sk_rrect_t* rrect)
    {
        return .sk_rrect_new_copy (rrect);
    }

    // void sk_rrect_offset(sk_rrect_t* rrect, float dx, float dy)
    static void sk_rrect_offset (sk_rrect_t* rrect, float dx, float dy)
    {
        .sk_rrect_offset (rrect, dx, dy);
    }

    // void sk_rrect_outset(sk_rrect_t* rrect, float dx, float dy)
    static void sk_rrect_outset (sk_rrect_t* rrect, float dx, float dy)
    {
        .sk_rrect_outset (rrect, dx, dy);
    }

    // void sk_rrect_set_empty(sk_rrect_t* rrect)
    static void sk_rrect_set_empty (sk_rrect_t* rrect)
    {
        .sk_rrect_set_empty (rrect);
    }

    // void sk_rrect_set_nine_patch(sk_rrect_t* rrect, const sk_rect_t* rect, float leftRad, float topRad, float rightRad, float bottomRad)
    static void sk_rrect_set_nine_patch (sk_rrect_t* rrect, SKRect* rect, float leftRad, float topRad, float rightRad, float bottomRad)
    {
        .sk_rrect_set_nine_patch (rrect, rect, leftRad, topRad, rightRad, bottomRad);
    }

    // void sk_rrect_set_oval(sk_rrect_t* rrect, const sk_rect_t* rect)
    static void sk_rrect_set_oval (sk_rrect_t* rrect, SKRect* rect)
    {
        .sk_rrect_set_oval (rrect, rect);
    }

    // void sk_rrect_set_rect(sk_rrect_t* rrect, const sk_rect_t* rect)
    static void sk_rrect_set_rect (sk_rrect_t* rrect, SKRect* rect)
    {
        .sk_rrect_set_rect (rrect, rect);
    }

    // void sk_rrect_set_rect_radii(sk_rrect_t* rrect, const sk_rect_t* rect, const sk_vector_t* radii)
    static void sk_rrect_set_rect_radii (sk_rrect_t* rrect, SKRect* rect, SKPoint* radii)
    {
        .sk_rrect_set_rect_radii (rrect, rect, radii);
    }

    // void sk_rrect_set_rect_xy(sk_rrect_t* rrect, const sk_rect_t* rect, float xRad, float yRad)
    static void sk_rrect_set_rect_xy (sk_rrect_t* rrect, SKRect* rect, float xRad, float yRad)
    {
        .sk_rrect_set_rect_xy (rrect, rect, xRad, yRad);
    }

    // bool sk_rrect_transform(sk_rrect_t* rrect, const sk_matrix_t* matrix, sk_rrect_t* dest)
    static bool sk_rrect_transform (sk_rrect_t* rrect, SKMatrix* matrix, sk_rrect_t* dest)
    {
        return .sk_rrect_transform (rrect, matrix, dest);
    }

    // end header: sk_rrect.h

    // // for header: sk_runtimeeffect.h

    // // void sk_runtimeeffect_get_child_name(const sk_runtimeeffect_t* effect, int index, sk_string_t* name)
    // static void sk_runtimeeffect_get_child_name (sk_runtimeeffect_t effect, int index, sk_string_t* name)
    // {
    //     .sk_runtimeeffect_get_child_name (effect, index, name);
    // }

    // // size_t sk_runtimeeffect_get_children_count(const sk_runtimeeffect_t* effect)
    // static size_t sk_runtimeeffect_get_children_count (sk_runtimeeffect_t effect)
    // {
    //     return .sk_runtimeeffect_get_children_count (effect);
    // }

    // // const sk_runtimeeffect_variable_t* sk_runtimeeffect_get_input_from_index(const sk_runtimeeffect_t* effect, int index)
    // static sk_runtimeeffect_variable_t sk_runtimeeffect_get_input_from_index (sk_runtimeeffect_t effect, int index)
    // {
    //     return .sk_runtimeeffect_get_input_from_index (effect, index);
    // }

    // // const sk_runtimeeffect_variable_t* sk_runtimeeffect_get_input_from_name(const sk_runtimeeffect_t* effect, const(char)* name, size_t len)
    // static sk_runtimeeffect_variable_t sk_runtimeeffect_get_input_from_name (sk_runtimeeffect_t effect,  void* name, void* len)
    // {
    //     return .sk_runtimeeffect_get_input_from_name (effect, name, len);
    // }

    // // void sk_runtimeeffect_get_input_name(const sk_runtimeeffect_t* effect, int index, sk_string_t* name)
    // static void sk_runtimeeffect_get_input_name (sk_runtimeeffect_t effect, int index, sk_string_t* name)
    // {
    //     .sk_runtimeeffect_get_input_name (effect, index, name);
    // }

    // // size_t sk_runtimeeffect_get_input_size(const sk_runtimeeffect_t* effect)
    // static size_t sk_runtimeeffect_get_input_size (sk_runtimeeffect_t effect)
    // {
    //     return .sk_runtimeeffect_get_input_size (effect);
    // }

    // // size_t sk_runtimeeffect_get_inputs_count(const sk_runtimeeffect_t* effect)
    // static size_t sk_runtimeeffect_get_inputs_count (sk_runtimeeffect_t effect)
    // {
    //     return .sk_runtimeeffect_get_inputs_count (effect);
    // }

    // // sk_runtimeeffect_t* sk_runtimeeffect_make(sk_string_t* sksl, sk_string_t* error)
    // static sk_runtimeeffect_t sk_runtimeeffect_make (sk_string_t* sksl, sk_string_t* error)
    // {
    //     return .sk_runtimeeffect_make (sksl, error);
    // }

    // // sk_colorfilter_t* sk_runtimeeffect_make_color_filter(sk_runtimeeffect_t* effect, sk_data_t* inputs, sk_colorfilter_t** children, size_t childCount)
    // static sk_colorfilter_t* sk_runtimeeffect_make_color_filter (sk_runtimeeffect_t effect, sk_data_t* inputs, sk_colorfilter_t* children, void* childCount)
    // {
    //     return .sk_runtimeeffect_make_color_filter (effect, inputs, children, childCount);
    // }

    // // sk_shader_t* sk_runtimeeffect_make_shader(sk_runtimeeffect_t* effect, sk_data_t* inputs, sk_shader_t** children, size_t childCount, const sk_matrix_t* localMatrix, bool isOpaque)
    // static sk_shader_t* sk_runtimeeffect_make_shader (sk_runtimeeffect_t effect, sk_data_t* inputs, sk_shader_t* children, void* childCount, SKMatrix* localMatrix, bool isOpaque)
    // {
    //     return .sk_runtimeeffect_make_shader (effect, inputs, children, childCount, localMatrix, isOpaque);
    // }

    // // void sk_runtimeeffect_unref(sk_runtimeeffect_t* effect)
    // static void sk_runtimeeffect_unref (sk_runtimeeffect_t effect)
    // {
    //     .sk_runtimeeffect_unref (effect);
    // }

    // // size_t sk_runtimeeffect_variable_get_offset(const sk_runtimeeffect_variable_t* variable)
    // static size_t sk_runtimeeffect_variable_get_offset (sk_runtimeeffect_variable_t variable)
    // {
    //     return .sk_runtimeeffect_variable_get_offset (variable);
    // }

    // // size_t sk_runtimeeffect_variable_get_size_in_bytes(const sk_runtimeeffect_variable_t* variable)
    // static size_t sk_runtimeeffect_variable_get_size_in_bytes (sk_runtimeeffect_variable_t variable)
    // {
    //     return .sk_runtimeeffect_variable_get_size_in_bytes (variable);
    // }

    // // end header: sk_runtimeeffect.h

    // for header: sk_shader.h

    // sk_shader_t* sk_shader_new_blend(sk_blendmode_t mode, const sk_shader_t* dst, const sk_shader_t* src)
    static sk_shader_t* sk_shader_new_blend (SKBlendMode mode, sk_shader_t* dst, sk_shader_t* src)
    {
        return .sk_shader_new_blend (mode, dst, src);
    }

    // sk_shader_t* sk_shader_new_color(sk_color_t color)
    static sk_shader_t* sk_shader_new_color (uint color)
    {
        return .sk_shader_new_color (color);
    }

    // sk_shader_t* sk_shader_new_color4f(const sk_color4f_t* color, const sk_colorspace_t* colorspace)
    static sk_shader_t* sk_shader_new_color4f (SKColorF* color, sk_colorspace_t* colorspace)
    {
        return .sk_shader_new_color4f (color, colorspace);
    }

    // sk_shader_t* sk_shader_new_empty()
    static sk_shader_t* sk_shader_new_empty ()
    {
        return .sk_shader_new_empty ();
    }

    // sk_shader_t* sk_shader_new_lerp(float t, const sk_shader_t* dst, const sk_shader_t* src)
    static sk_shader_t* sk_shader_new_lerp (float t, sk_shader_t* dst, sk_shader_t* src)
    {
        return .sk_shader_new_lerp (t, dst, src);
    }

    // sk_shader_t* sk_shader_new_linear_gradient(const sk_point_t[2] points = 2, const sk_color_t* colors, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_linear_gradient (SKPoint* points, uint* colors, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_linear_gradient (points, colors, colorPos, colorCount, tileMode, localMatrix);
    }

    // sk_shader_t* sk_shader_new_linear_gradient_color4f(const sk_point_t[2] points = 2, const sk_color4f_t* colors, const sk_colorspace_t* colorspace, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_linear_gradient_color4f (SKPoint* points, SKColorF* colors, sk_colorspace_t* colorspace, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_linear_gradient_color4f (points, colors, colorspace, colorPos, colorCount, tileMode, localMatrix);
    }

    // sk_shader_t* sk_shader_new_perlin_noise_fractal_noise(float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, const sk_isize_t* tileSize)
    static sk_shader_t* sk_shader_new_perlin_noise_fractal_noise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKSizeI* tileSize)
    {
        return .sk_shader_new_perlin_noise_fractal_noise (baseFrequencyX, baseFrequencyY, numOctaves, seed, tileSize);
    }

    // sk_shader_t* sk_shader_new_perlin_noise_improved_noise(float baseFrequencyX, float baseFrequencyY, int numOctaves, float z)
    static sk_shader_t* sk_shader_new_perlin_noise_improved_noise (float baseFrequencyX, float baseFrequencyY, int numOctaves, float z)
    {
        return .sk_shader_new_perlin_noise_improved_noise (baseFrequencyX, baseFrequencyY, numOctaves, z);
    }

    // sk_shader_t* sk_shader_new_perlin_noise_turbulence(float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, const sk_isize_t* tileSize)
    static sk_shader_t* sk_shader_new_perlin_noise_turbulence (float baseFrequencyX, float baseFrequencyY, int numOctaves, float seed, SKSizeI* tileSize)
    {
        return .sk_shader_new_perlin_noise_turbulence (baseFrequencyX, baseFrequencyY, numOctaves, seed, tileSize);
    }

    // sk_shader_t* sk_shader_new_radial_gradient(const sk_point_t* center, float radius, const sk_color_t* colors, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_radial_gradient (SKPoint* center, float radius, uint* colors, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_radial_gradient (center, radius, colors, colorPos, colorCount, tileMode, localMatrix);
    }

    // sk_shader_t* sk_shader_new_radial_gradient_color4f(const sk_point_t* center, float radius, const sk_color4f_t* colors, const sk_colorspace_t* colorspace, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_radial_gradient_color4f (SKPoint* center, float radius, SKColorF* colors, sk_colorspace_t* colorspace, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_radial_gradient_color4f (center, radius, colors, colorspace, colorPos, colorCount, tileMode, localMatrix);
    }

    // sk_shader_t* sk_shader_new_sweep_gradient(const sk_point_t* center, const sk_color_t* colors, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, float startAngle, float endAngle, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_sweep_gradient (SKPoint* center, uint* colors, float* colorPos, int colorCount, SKShaderTileMode tileMode, float startAngle, float endAngle, SKMatrix* localMatrix)
    {
        return .sk_shader_new_sweep_gradient (center, colors, colorPos, colorCount, tileMode, startAngle, endAngle, localMatrix);
    }

    // sk_shader_t* sk_shader_new_sweep_gradient_color4f(const sk_point_t* center, const sk_color4f_t* colors, const sk_colorspace_t* colorspace, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, float startAngle, float endAngle, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_sweep_gradient_color4f (SKPoint* center, SKColorF* colors, sk_colorspace_t* colorspace, float* colorPos, int colorCount, SKShaderTileMode tileMode, float startAngle, float endAngle, SKMatrix* localMatrix)
    {
        return .sk_shader_new_sweep_gradient_color4f (center, colors, colorspace, colorPos, colorCount, tileMode, startAngle, endAngle, localMatrix);
    }

    // sk_shader_t* sk_shader_new_two_point_conical_gradient(const sk_point_t* start, float startRadius, const sk_point_t* end, float endRadius, const sk_color_t* colors, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_two_point_conical_gradient (SKPoint* start, float startRadius, SKPoint* end, float endRadius, uint* colors, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_two_point_conical_gradient (start, startRadius, end, endRadius, colors, colorPos, colorCount, tileMode, localMatrix);
    }

    // sk_shader_t* sk_shader_new_two_point_conical_gradient_color4f(const sk_point_t* start, float startRadius, const sk_point_t* end, float endRadius, const sk_color4f_t* colors, const sk_colorspace_t* colorspace, const float* colorPos, int colorCount, sk_shader_tilemode_t tileMode, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_new_two_point_conical_gradient_color4f (SKPoint* start, float startRadius, SKPoint* end, float endRadius, SKColorF* colors, sk_colorspace_t* colorspace, float* colorPos, int colorCount, SKShaderTileMode tileMode, SKMatrix* localMatrix)
    {
        return .sk_shader_new_two_point_conical_gradient_color4f (start, startRadius, end, endRadius, colors, colorspace, colorPos, colorCount, tileMode, localMatrix);
    }

    // void sk_shader_ref(sk_shader_t* shader)
    static void sk_shader_ref (sk_shader_t* shader)
    {
        .sk_shader_ref (shader);
    }

    // void sk_shader_unref(sk_shader_t* shader)
    static void sk_shader_unref (sk_shader_t* shader)
    {
        .sk_shader_unref (shader);
    }

    // sk_shader_t* sk_shader_with_color_filter(const sk_shader_t* shader, const sk_colorfilter_t* filter)
    static sk_shader_t* sk_shader_with_color_filter (sk_shader_t* shader, sk_colorfilter_t* filter)
    {
        return .sk_shader_with_color_filter (shader, filter);
    }

    // sk_shader_t* sk_shader_with_local_matrix(const sk_shader_t* shader, const sk_matrix_t* localMatrix)
    static sk_shader_t* sk_shader_with_local_matrix (sk_shader_t* shader, SKMatrix* localMatrix)
    {
        return .sk_shader_with_local_matrix (shader, localMatrix);
    }

    // end header: sk_shader.h

    // for header: sk_stream.h

    // void sk_dynamicmemorywstream_copy_to(sk_wstream_dynamicmemorystream_t* cstream, void* data)
    static void sk_dynamicmemorywstream_copy_to (sk_wstream_dynamicmemorystream_t* cstream, void* data)
    {
        .sk_dynamicmemorywstream_copy_to (cstream, data);
    }

    // void sk_dynamicmemorywstream_destroy(sk_wstream_dynamicmemorystream_t* cstream)
    static void sk_dynamicmemorywstream_destroy (sk_wstream_dynamicmemorystream_t* cstream)
    {
        .sk_dynamicmemorywstream_destroy (cstream);
    }

    // sk_data_t* sk_dynamicmemorywstream_detach_as_data(sk_wstream_dynamicmemorystream_t* cstream)
    static sk_data_t* sk_dynamicmemorywstream_detach_as_data (sk_wstream_dynamicmemorystream_t* cstream)
    {
        return .sk_dynamicmemorywstream_detach_as_data (cstream);
    }

    // sk_stream_asset_t* sk_dynamicmemorywstream_detach_as_stream(sk_wstream_dynamicmemorystream_t* cstream)
    static sk_stream_asset_t* sk_dynamicmemorywstream_detach_as_stream (sk_wstream_dynamicmemorystream_t* cstream)
    {
        return .sk_dynamicmemorywstream_detach_as_stream (cstream);
    }

    // sk_wstream_dynamicmemorystream_t* sk_dynamicmemorywstream_new()
    static sk_wstream_dynamicmemorystream_t* sk_dynamicmemorywstream_new ()
    {
        return .sk_dynamicmemorywstream_new ();
    }

    // bool sk_dynamicmemorywstream_write_to_stream(sk_wstream_dynamicmemorystream_t* cstream, sk_wstream_t* dst)
    static bool sk_dynamicmemorywstream_write_to_stream (sk_wstream_dynamicmemorystream_t* cstream, sk_wstream_t* dst)
    {
        return .sk_dynamicmemorywstream_write_to_stream (cstream, dst);
    }

    // void sk_filestream_destroy(sk_stream_filestream_t* cstream)
    static void sk_filestream_destroy (sk_stream_filestream_t* cstream)
    {
        .sk_filestream_destroy (cstream);
    }

    // bool sk_filestream_is_valid(sk_stream_filestream_t* cstream)
    static bool sk_filestream_is_valid (sk_stream_filestream_t* cstream)
    {
        return .sk_filestream_is_valid (cstream);
    }

    // sk_stream_filestream_t* sk_filestream_new(const(char)* path)
    static sk_stream_filestream_t* sk_filestream_new ( string path)
    {
        return .sk_filestream_new (path.toStringz());
    }

    // void sk_filewstream_destroy(sk_wstream_filestream_t* cstream)
    static void sk_filewstream_destroy (sk_wstream_filestream_t* cstream)
    {
        .sk_filewstream_destroy (cstream);
    }

    // bool sk_filewstream_is_valid(sk_wstream_filestream_t* cstream)
    static bool sk_filewstream_is_valid (sk_wstream_filestream_t* cstream)
    {
        return .sk_filewstream_is_valid (cstream);
    }

    // sk_wstream_filestream_t* sk_filewstream_new(const(char)* path)
    static sk_wstream_filestream_t* sk_filewstream_new ( string path)
    {
        return .sk_filewstream_new (path.toStringz());
    }

    // void sk_memorystream_destroy(sk_stream_memorystream_t* cstream)
    static void sk_memorystream_destroy (sk_stream_memorystream_t* cstream)
    {
        .sk_memorystream_destroy (cstream);
    }

    // sk_stream_memorystream_t* sk_memorystream_new()
    static sk_stream_memorystream_t* sk_memorystream_new ()
    {
        return .sk_memorystream_new ();
    }

    // sk_stream_memorystream_t* sk_memorystream_new_with_data(const(void)* data, size_t length, bool copyData)
    static sk_stream_memorystream_t* sk_memorystream_new_with_data (void* data, size_t length, bool copyData)
    {
        return .sk_memorystream_new_with_data (data, length, copyData);
    }

    // sk_stream_memorystream_t* sk_memorystream_new_with_length(size_t length)
    static sk_stream_memorystream_t* sk_memorystream_new_with_length (size_t length)
    {
        return .sk_memorystream_new_with_length (length);
    }

    // sk_stream_memorystream_t* sk_memorystream_new_with_skdata(sk_data_t* data)
    static sk_stream_memorystream_t* sk_memorystream_new_with_skdata (sk_data_t* data)
    {
        return .sk_memorystream_new_with_skdata (data);
    }

    // void sk_memorystream_set_memory(sk_stream_memorystream_t* cmemorystream, const(void)* data, size_t length, bool copyData)
    static void sk_memorystream_set_memory (sk_stream_memorystream_t* cmemorystream, void* data, size_t length, bool copyData)
    {
        .sk_memorystream_set_memory (cmemorystream, data, length, copyData);
    }

    // void sk_stream_asset_destroy(sk_stream_asset_t* cstream)
    static void sk_stream_asset_destroy (sk_stream_asset_t* cstream)
    {
        .sk_stream_asset_destroy (cstream);
    }

    // void sk_stream_destroy(sk_stream_t* cstream)
    static void sk_stream_destroy (sk_stream_t* cstream)
    {
        .sk_stream_destroy (cstream);
    }

    // sk_stream_t* sk_stream_duplicate(sk_stream_t* cstream)
    static sk_stream_t* sk_stream_duplicate (sk_stream_t* cstream)
    {
        return .sk_stream_duplicate (cstream);
    }

    // sk_stream_t* sk_stream_fork(sk_stream_t* cstream)
    static sk_stream_t* sk_stream_fork (sk_stream_t* cstream)
    {
        return .sk_stream_fork (cstream);
    }

    // size_t sk_stream_get_length(sk_stream_t* cstream)
    static size_t sk_stream_get_length (sk_stream_t* cstream)
    {
        return .sk_stream_get_length (cstream);
    }

    // const(void)* sk_stream_get_memory_base(sk_stream_t* cstream)
    static const(void)* sk_stream_get_memory_base (sk_stream_t* cstream)
    {
        return .sk_stream_get_memory_base (cstream);
    }

    // size_t sk_stream_get_position(sk_stream_t* cstream)
    static size_t sk_stream_get_position (sk_stream_t* cstream)
    {
        return .sk_stream_get_position (cstream);
    }

    // bool sk_stream_has_length(sk_stream_t* cstream)
    static bool sk_stream_has_length (sk_stream_t* cstream)
    {
        return .sk_stream_has_length (cstream);
    }

    // bool sk_stream_has_position(sk_stream_t* cstream)
    static bool sk_stream_has_position (sk_stream_t* cstream)
    {
        return .sk_stream_has_position (cstream);
    }

    // bool sk_stream_is_at_end(sk_stream_t* cstream)
    static bool sk_stream_is_at_end (sk_stream_t* cstream)
    {
        return .sk_stream_is_at_end (cstream);
    }

    // bool sk_stream_move(sk_stream_t* cstream, int offset)
    static bool sk_stream_move (sk_stream_t* cstream, int offset)
    {
        return .sk_stream_move (cstream, offset);
    }

    // size_t sk_stream_peek(sk_stream_t* cstream, void* buffer, size_t size)
    static size_t sk_stream_peek (sk_stream_t* cstream, void* buffer, size_t size)
    {
        return .sk_stream_peek (cstream, buffer, size);
    }

    // size_t sk_stream_read(sk_stream_t* cstream, void* buffer, size_t size)
    static size_t sk_stream_read (sk_stream_t* cstream, void* buffer, size_t size)
    {
        return .sk_stream_read (cstream, buffer, size);
    }

    // bool sk_stream_read_bool(sk_stream_t* cstream, bool* buffer)
    static bool sk_stream_read_bool (sk_stream_t* cstream, bool* buffer)
    {
        return .sk_stream_read_bool (cstream, buffer);
    }

    // bool sk_stream_read_s16(sk_stream_t* cstream, int16_t* buffer)
    static bool sk_stream_read_s16 (sk_stream_t* cstream, short* buffer)
    {
        return .sk_stream_read_s16 (cstream, buffer);
    }

    // bool sk_stream_read_s32(sk_stream_t* cstream, int32_t* buffer)
    static bool sk_stream_read_s32 (sk_stream_t* cstream, int* buffer)
    {
        return .sk_stream_read_s32 (cstream, buffer);
    }

    // bool sk_stream_read_s8(sk_stream_t* cstream, int8_t* buffer)
    static bool sk_stream_read_s8 (sk_stream_t* cstream, byte* buffer)
    {
        return .sk_stream_read_s8 (cstream, buffer);
    }

    // bool sk_stream_read_u16(sk_stream_t* cstream, uint16_t* buffer)
    static bool sk_stream_read_u16 (sk_stream_t* cstream, ushort* buffer)
    {
        return .sk_stream_read_u16 (cstream, buffer);
    }

    // bool sk_stream_read_u32(sk_stream_t* cstream, uint32_t* buffer)
    static bool sk_stream_read_u32 (sk_stream_t* cstream, uint* buffer)
    {
        return .sk_stream_read_u32 (cstream, buffer);
    }

    // bool sk_stream_read_u8(sk_stream_t* cstream, uint8_t* buffer)
    static bool sk_stream_read_u8 (sk_stream_t* cstream, ubyte* buffer)
    {
        return .sk_stream_read_u8 (cstream, buffer);
    }

    // bool sk_stream_rewind(sk_stream_t* cstream)
    static bool sk_stream_rewind (sk_stream_t* cstream)
    {
        return .sk_stream_rewind (cstream);
    }

    // bool sk_stream_seek(sk_stream_t* cstream, size_t position)
    static bool sk_stream_seek (sk_stream_t* cstream, size_t position)
    {
        return .sk_stream_seek (cstream, position);
    }

    // size_t sk_stream_skip(sk_stream_t* cstream, size_t size)
    static size_t sk_stream_skip (sk_stream_t* cstream, size_t size)
    {
        return .sk_stream_skip (cstream, size);
    }

    // size_t sk_wstream_bytes_written(sk_wstream_t* cstream)
    static size_t sk_wstream_bytes_written (sk_wstream_t* cstream)
    {
        return .sk_wstream_bytes_written (cstream);
    }

    // void sk_wstream_flush(sk_wstream_t* cstream)
    static void sk_wstream_flush (sk_wstream_t* cstream)
    {
        .sk_wstream_flush (cstream);
    }

    // int sk_wstream_get_size_of_packed_uint(size_t value)
    static int sk_wstream_get_size_of_packed_uint (size_t value)
    {
        return .sk_wstream_get_size_of_packed_uint (value);
    }

    // bool sk_wstream_newline(sk_wstream_t* cstream)
    static bool sk_wstream_newline (sk_wstream_t* cstream)
    {
        return .sk_wstream_newline (cstream);
    }

    // bool sk_wstream_write(sk_wstream_t* cstream, const(void)* buffer, size_t size)
    static bool sk_wstream_write (sk_wstream_t* cstream, void* buffer, size_t size)
    {
        return .sk_wstream_write (cstream, buffer, size);
    }

    // bool sk_wstream_write_16(sk_wstream_t* cstream, uint16_t value)
    static bool sk_wstream_write_16 (sk_wstream_t* cstream, ushort value)
    {
        return .sk_wstream_write_16 (cstream, value);
    }

    // bool sk_wstream_write_32(sk_wstream_t* cstream, uint32_t value)
    static bool sk_wstream_write_32 (sk_wstream_t* cstream, uint value)
    {
        return .sk_wstream_write_32 (cstream, value);
    }

    // bool sk_wstream_write_8(sk_wstream_t* cstream, uint8_t value)
    static bool sk_wstream_write_8 (sk_wstream_t* cstream, ubyte value)
    {
        return .sk_wstream_write_8 (cstream, value);
    }

    // bool sk_wstream_write_bigdec_as_text(sk_wstream_t* cstream, int64_t value, int minDigits)
    static bool sk_wstream_write_bigdec_as_text (sk_wstream_t* cstream, long value, int minDigits)
    {
        return .sk_wstream_write_bigdec_as_text (cstream, value, minDigits);
    }

    // bool sk_wstream_write_bool(sk_wstream_t* cstream, bool value)
    static bool sk_wstream_write_bool (sk_wstream_t* cstream, bool value)
    {
        return .sk_wstream_write_bool (cstream, value);
    }

    // bool sk_wstream_write_dec_as_text(sk_wstream_t* cstream, int32_t value)
    static bool sk_wstream_write_dec_as_text (sk_wstream_t* cstream, int value)
    {
        return .sk_wstream_write_dec_as_text (cstream, value);
    }

    // bool sk_wstream_write_hex_as_text(sk_wstream_t* cstream, uint32_t value, int minDigits)
    static bool sk_wstream_write_hex_as_text (sk_wstream_t* cstream, uint value, int minDigits)
    {
        return .sk_wstream_write_hex_as_text (cstream, value, minDigits);
    }

    // bool sk_wstream_write_packed_uint(sk_wstream_t* cstream, size_t value)
    static bool sk_wstream_write_packed_uint (sk_wstream_t* cstream, size_t value)
    {
        return .sk_wstream_write_packed_uint (cstream, value);
    }

    // bool sk_wstream_write_scalar(sk_wstream_t* cstream, float value)
    static bool sk_wstream_write_scalar (sk_wstream_t* cstream, float value)
    {
        return .sk_wstream_write_scalar (cstream, value);
    }

    // bool sk_wstream_write_scalar_as_text(sk_wstream_t* cstream, float value)
    static bool sk_wstream_write_scalar_as_text (sk_wstream_t* cstream, float value)
    {
        return .sk_wstream_write_scalar_as_text (cstream, value);
    }

    // bool sk_wstream_write_stream(sk_wstream_t* cstream, sk_stream_t* input, size_t length)
    static bool sk_wstream_write_stream (sk_wstream_t* cstream, sk_stream_t* input, size_t length)
    {
        return .sk_wstream_write_stream (cstream, input, length);
    }

    // bool sk_wstream_write_text(sk_wstream_t* cstream, const(char)* value)
    static bool sk_wstream_write_text (sk_wstream_t* cstream, string value)
    {
        return .sk_wstream_write_text (cstream, value.toStringz());
    }

    // end header: sk_stream.h

    // for header: sk_string.h

    // void sk_string_destructor(const sk_string_t*)
    static void sk_string_destructor (sk_string_t* param0)
    {
        .sk_string_destructor (param0);
    }

    // const(char)* sk_string_get_c_str(const sk_string_t*)
    static const(void)* sk_string_get_c_str (sk_string_t* param0)
    {
        return .sk_string_get_c_str (param0);
    }

    // size_t sk_string_get_size(const sk_string_t*)
    static size_t sk_string_get_size (sk_string_t* param0)
    {
        return .sk_string_get_size (param0);
    }

    // sk_string_t* sk_string_new_empty()
    static sk_string_t* sk_string_new_empty ()
    {
        return .sk_string_new_empty ();
    }

    // sk_string_t* sk_string_new_with_copy(const(char)* src, size_t length)
    static sk_string_t* sk_string_new_with_copy (const(char)* src, size_t length)
    {
        return .sk_string_new_with_copy (src, length);
    }

    // end header: sk_string.h

    // for header: sk_surface.h

    // void sk_surface_draw(sk_surface_t* surface, sk_canvas_t* canvas, float x, float y, const sk_paint_t* paint)
    static void sk_surface_draw (sk_surface_t* surface, sk_canvas_t* canvas, float x, float y, sk_paint_t* paint)
    {
        .sk_surface_draw (surface, canvas, x, y, paint);
    }

    // sk_canvas_t* sk_surface_get_canvas(sk_surface_t*)
    static sk_canvas_t* sk_surface_get_canvas (sk_surface_t* param0)
    {
        return .sk_surface_get_canvas (param0);
    }

    // const sk_surfaceprops_t* sk_surface_get_props(sk_surface_t* surface)
    static const(sk_surfaceprops_t)* sk_surface_get_props (sk_surface_t* surface)
    {
        return .sk_surface_get_props (surface);
    }

    // sk_surface_t* sk_surface_new_backend_render_target(gr_context_t* context, const gr_backendrendertarget_t* target, gr_surfaceorigin_t origin, sk_colortype_t colorType, sk_colorspace_t* colorspace, const sk_surfaceprops_t* props)
    static sk_surface_t* sk_surface_new_backend_render_target (gr_context_t* context, gr_backendrendertarget_t* target, GRSurfaceOrigin origin, SKColorTypeNative colorType, sk_colorspace_t* colorspace, sk_surfaceprops_t* props)
    {
        return .sk_surface_new_backend_render_target (context, target, origin, colorType, colorspace, props);
    }

    // sk_surface_t* sk_surface_new_backend_texture(gr_context_t* context, const gr_backendtexture_t* texture, gr_surfaceorigin_t origin, int samples, sk_colortype_t colorType, sk_colorspace_t* colorspace, const sk_surfaceprops_t* props)
    static sk_surface_t* sk_surface_new_backend_texture (gr_context_t* context, gr_backendtexture_t* texture, GRSurfaceOrigin origin, int samples, SKColorTypeNative colorType, sk_colorspace_t* colorspace, sk_surfaceprops_t* props)
    {
        return .sk_surface_new_backend_texture (context, texture, origin, samples, colorType, colorspace, props);
    }

    // sk_surface_t* sk_surface_new_backend_texture_as_render_target(gr_context_t* context, const gr_backendtexture_t* texture, gr_surfaceorigin_t origin, int samples, sk_colortype_t colorType, sk_colorspace_t* colorspace, const sk_surfaceprops_t* props)
    static sk_surface_t* sk_surface_new_backend_texture_as_render_target (gr_context_t* context, gr_backendtexture_t* texture, GRSurfaceOrigin origin, int samples, SKColorTypeNative colorType, sk_colorspace_t* colorspace, sk_surfaceprops_t* props)
    {
        return .sk_surface_new_backend_texture_as_render_target (context, texture, origin, samples, colorType, colorspace, props);
    }

    // sk_image_t* sk_surface_new_image_snapshot(sk_surface_t*)
    static sk_image_t* sk_surface_new_image_snapshot (sk_surface_t* param0)
    {
        return .sk_surface_new_image_snapshot (param0);
    }

    // sk_image_t* sk_surface_new_image_snapshot_with_crop(sk_surface_t* surface, const sk_irect_t* bounds)
    static sk_image_t* sk_surface_new_image_snapshot_with_crop (sk_surface_t* surface, SKRectI* bounds)
    {
        return .sk_surface_new_image_snapshot_with_crop (surface, bounds);
    }

    // sk_surface_t* sk_surface_new_null(int width, int height)
    static sk_surface_t* sk_surface_new_null (int width, int height)
    {
        return .sk_surface_new_null (width, height);
    }

    // sk_surface_t* sk_surface_new_raster(const sk_imageinfo_t*, size_t rowBytes, const sk_surfaceprops_t*)
    static sk_surface_t* sk_surface_new_raster (SKImageInfoNative* param0, size_t rowBytes, sk_surfaceprops_t* param2)
    {
        return .sk_surface_new_raster (param0, rowBytes, param2);
    }

    // sk_surface_t* sk_surface_new_raster_direct(const sk_imageinfo_t*, void* pixels, size_t rowBytes, const sk_surface_raster_release_proc releaseProc, void* context, const sk_surfaceprops_t* props)
    static sk_surface_t* sk_surface_new_raster_direct (SKImageInfoNative* param0, void* pixels, size_t rowBytes, SKSurfaceRasterReleaseProxyDelegate releaseProc, void* context, sk_surfaceprops_t* props)
    {
        return .sk_surface_new_raster_direct (param0, pixels, rowBytes, releaseProc, context, props);
    }

    // sk_surface_t* sk_surface_new_render_target(gr_context_t* context, bool budgeted, const sk_imageinfo_t* cinfo, int sampleCount, gr_surfaceorigin_t origin, const sk_surfaceprops_t* props, bool shouldCreateWithMips)
    static sk_surface_t* sk_surface_new_render_target (gr_context_t* context, bool budgeted, SKImageInfoNative* cinfo, int sampleCount, GRSurfaceOrigin origin, sk_surfaceprops_t* props, bool shouldCreateWithMips)
    {
        return .sk_surface_new_render_target (context, budgeted, cinfo, sampleCount, origin, props, shouldCreateWithMips);
    }

    // bool sk_surface_peek_pixels(sk_surface_t* surface, sk_pixmap_t* pixmap)
    static bool sk_surface_peek_pixels (sk_surface_t* surface, sk_pixmap_t* pixmap)
    {
        return .sk_surface_peek_pixels (surface, pixmap);
    }

    // bool sk_surface_read_pixels(sk_surface_t* surface, sk_imageinfo_t* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY)
    static bool sk_surface_read_pixels (sk_surface_t* surface, SKImageInfoNative* dstInfo, void* dstPixels, size_t dstRowBytes, int srcX, int srcY)
    {
        return .sk_surface_read_pixels (surface, dstInfo, dstPixels, dstRowBytes, srcX, srcY);
    }

    // void sk_surface_unref(sk_surface_t*)
    static void sk_surface_unref (sk_surface_t* param0)
    {
        .sk_surface_unref (param0);
    }

    // void sk_surfaceprops_delete(sk_surfaceprops_t* props)
    static void sk_surfaceprops_delete (sk_surfaceprops_t* props)
    {
        .sk_surfaceprops_delete (props);
    }

    // uint32_t sk_surfaceprops_get_flags(sk_surfaceprops_t* props)
    static uint sk_surfaceprops_get_flags (sk_surfaceprops_t* props)
    {
        return .sk_surfaceprops_get_flags (props);
    }

    // sk_pixelgeometry_t sk_surfaceprops_get_pixel_geometry(sk_surfaceprops_t* props)
    static SKPixelGeometry sk_surfaceprops_get_pixel_geometry (sk_surfaceprops_t* props)
    {
        return .sk_surfaceprops_get_pixel_geometry (props);
    }

    // sk_surfaceprops_t* sk_surfaceprops_new(uint32_t flags, sk_pixelgeometry_t geometry)
    static sk_surfaceprops_t* sk_surfaceprops_new (uint flags, SKPixelGeometry geometry)
    {
        return .sk_surfaceprops_new (flags, geometry);
    }

    // end header: sk_surface.h

    // for header: sk_svg.h

    // sk_canvas_t* sk_svgcanvas_create_with_stream(const sk_rect_t* bounds, sk_wstream_t* stream)
    static sk_canvas_t* sk_svgcanvas_create_with_stream (SKRect* bounds, sk_wstream_t* stream)
    {
        return .sk_svgcanvas_create_with_stream (bounds, stream);
    }

    // sk_canvas_t* sk_svgcanvas_create_with_writer(const sk_rect_t* bounds, sk_xmlwriter_t* writer)
    static sk_canvas_t* sk_svgcanvas_create_with_writer (SKRect* bounds, sk_xmlwriter_t* writer)
    {
        return .sk_svgcanvas_create_with_writer (bounds, writer);
    }

    // end header: sk_svg.h

    // for header: sk_textblob.h

    // void sk_textblob_builder_alloc_run(sk_textblob_builder_t* builder, const sk_font_t* font, int count, float x, float y, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run (sk_textblob_builder_t* builder, sk_font_t* font, int count, float x, float y, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run (builder, font, count, x, y, bounds, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_pos(sk_textblob_builder_t* builder, const sk_font_t* font, int count, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_pos (sk_textblob_builder_t* builder, sk_font_t* font, int count, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_pos (builder, font, count, bounds, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_pos_h(sk_textblob_builder_t* builder, const sk_font_t* font, int count, float y, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_pos_h (sk_textblob_builder_t* builder, sk_font_t* font, int count, float y, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_pos_h (builder, font, count, y, bounds, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_rsxform(sk_textblob_builder_t* builder, const sk_font_t* font, int count, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_rsxform (sk_textblob_builder_t* builder, sk_font_t* font, int count, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_rsxform (builder, font, count, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_text(sk_textblob_builder_t* builder, const sk_font_t* font, int count, float x, float y, int textByteCount, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_text (sk_textblob_builder_t* builder, sk_font_t* font, int count, float x, float y, int textByteCount, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_text (builder, font, count, x, y, textByteCount, bounds, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_text_pos(sk_textblob_builder_t* builder, const sk_font_t* font, int count, int textByteCount, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_text_pos (sk_textblob_builder_t* builder, sk_font_t* font, int count, int textByteCount, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_text_pos (builder, font, count, textByteCount, bounds, runbuffer);
    }

    // void sk_textblob_builder_alloc_run_text_pos_h(sk_textblob_builder_t* builder, const sk_font_t* font, int count, float y, int textByteCount, const sk_rect_t* bounds, sk_textblob_builder_runbuffer_t* runbuffer)
    static void sk_textblob_builder_alloc_run_text_pos_h (sk_textblob_builder_t* builder, sk_font_t* font, int count, float y, int textByteCount, SKRect* bounds, SKRunBufferInternal* runbuffer)
    {
        .sk_textblob_builder_alloc_run_text_pos_h (builder, font, count, y, textByteCount, bounds, runbuffer);
    }

    // void sk_textblob_builder_delete(sk_textblob_builder_t* builder)
    static void sk_textblob_builder_delete (sk_textblob_builder_t* builder)
    {
        .sk_textblob_builder_delete (builder);
    }

    // sk_textblob_t* sk_textblob_builder_make(sk_textblob_builder_t* builder)
    static sk_textblob_t* sk_textblob_builder_make (sk_textblob_builder_t* builder)
    {
        return .sk_textblob_builder_make (builder);
    }

    // sk_textblob_builder_t* sk_textblob_builder_new()
    static sk_textblob_builder_t* sk_textblob_builder_new ()
    {
        return .sk_textblob_builder_new ();
    }

    // void sk_textblob_get_bounds(const sk_textblob_t* blob, sk_rect_t* bounds)
    static void sk_textblob_get_bounds (sk_textblob_t* blob, SKRect* bounds)
    {
        .sk_textblob_get_bounds (blob, bounds);
    }

    // int sk_textblob_get_intercepts(const sk_textblob_t* blob, const float[2] bounds = 2, float* intervals, const sk_paint_t* paint)
    static int sk_textblob_get_intercepts (sk_textblob_t* blob, float* bounds, float* intervals, sk_paint_t* paint)
    {
        return .sk_textblob_get_intercepts (blob, bounds, intervals, paint);
    }

    // uint32_t sk_textblob_get_unique_id(const sk_textblob_t* blob)
    static uint sk_textblob_get_unique_id (sk_textblob_t* blob)
    {
        return .sk_textblob_get_unique_id (blob);
    }

    // void sk_textblob_ref(const sk_textblob_t* blob)
    static void sk_textblob_ref (sk_textblob_t* blob)
    {
        .sk_textblob_ref (blob);
    }

    // void sk_textblob_unref(const sk_textblob_t* blob)
    static void sk_textblob_unref (sk_textblob_t* blob)
    {
        .sk_textblob_unref (blob);
    }

    // end header: sk_textblob.h

    // for header: sk_typeface.h

    // int sk_fontmgr_count_families(sk_fontmgr_t*)
    static int sk_fontmgr_count_families (sk_fontmgr_t* param0)
    {
        return .sk_fontmgr_count_families (param0);
    }

    // sk_fontmgr_t* sk_fontmgr_create_default()
    static sk_fontmgr_t* sk_fontmgr_create_default ()
    {
        return .sk_fontmgr_create_default ();
    }

    // sk_typeface_t* sk_fontmgr_create_from_data(sk_fontmgr_t*, sk_data_t* data, int index)
    static sk_typeface_t* sk_fontmgr_create_from_data (sk_fontmgr_t* param0, sk_data_t* data, int index)
    {
        return .sk_fontmgr_create_from_data (param0, data, index);
    }

    // sk_typeface_t* sk_fontmgr_create_from_file(sk_fontmgr_t*, const(char)* path, int index)
    static sk_typeface_t* sk_fontmgr_create_from_file (sk_fontmgr_t* param0,  string path, int index)
    {
        return .sk_fontmgr_create_from_file (param0, path.toStringz(), index);
    }

    // sk_typeface_t* sk_fontmgr_create_from_stream(sk_fontmgr_t*, sk_stream_asset_t* stream, int index)
    static sk_typeface_t* sk_fontmgr_create_from_stream (sk_fontmgr_t* param0, sk_stream_asset_t* stream, int index)
    {
        return .sk_fontmgr_create_from_stream (param0, stream, index);
    }

    // sk_fontstyleset_t* sk_fontmgr_create_styleset(sk_fontmgr_t*, int index)
    static sk_fontstyleset_t* sk_fontmgr_create_styleset (sk_fontmgr_t* param0, int index)
    {
        return .sk_fontmgr_create_styleset (param0, index);
    }

    // void sk_fontmgr_get_family_name(sk_fontmgr_t*, int index, sk_string_t* familyName)
    static void sk_fontmgr_get_family_name (sk_fontmgr_t* param0, int index, sk_string_t* familyName)
    {
        .sk_fontmgr_get_family_name (param0, index, familyName);
    }

    // sk_typeface_t* sk_fontmgr_match_face_style(sk_fontmgr_t*, const sk_typeface_t* face, sk_fontstyle_t* style)
    static sk_typeface_t* sk_fontmgr_match_face_style (sk_fontmgr_t* param0, sk_typeface_t* face, sk_fontstyle_t* style)
    {
        return .sk_fontmgr_match_face_style (param0, face, style);
    }

    // sk_fontstyleset_t* sk_fontmgr_match_family(sk_fontmgr_t*, const(char)* familyName)
    static sk_fontstyleset_t* sk_fontmgr_match_family (sk_fontmgr_t* param0, string familyName)
    {
        return .sk_fontmgr_match_family (param0, familyName.toStringz());
    }

    // sk_typeface_t* sk_fontmgr_match_family_style(sk_fontmgr_t*, const(char)* familyName, sk_fontstyle_t* style)
    static sk_typeface_t* sk_fontmgr_match_family_style (sk_fontmgr_t* param0, string familyName, sk_fontstyle_t* style)
    {
        return .sk_fontmgr_match_family_style (param0, familyName.toStringz(), style);
    }

    // sk_typeface_t* sk_fontmgr_match_family_style_character(sk_fontmgr_t*, const(char)* familyName, sk_fontstyle_t* style, const(char)** bcp47, int bcp47Count, int32_t character)
    static sk_typeface_t* sk_fontmgr_match_family_style_character (sk_fontmgr_t* param0, string familyName, sk_fontstyle_t* style, string[] bcp47, int bcp47Count, int character)
    {
        const(char)*[] bcp47Ptr = toCStrings(bcp47);
        return .sk_fontmgr_match_family_style_character (param0, familyName.toStringz(), style, bcp47Ptr.ptr, bcp47Count, character);
    }

    // sk_fontmgr_t* sk_fontmgr_ref_default()
    static sk_fontmgr_t* sk_fontmgr_ref_default ()
    {
        return .sk_fontmgr_ref_default ();
    }

    // void sk_fontmgr_unref(sk_fontmgr_t*)
    static void sk_fontmgr_unref (sk_fontmgr_t* param0)
    {
        .sk_fontmgr_unref (param0);
    }

    // void sk_fontstyle_delete(sk_fontstyle_t* fs)
    static void sk_fontstyle_delete (sk_fontstyle_t* fs)
    {
        .sk_fontstyle_delete (fs);
    }

    // sk_font_style_slant_t sk_fontstyle_get_slant(const sk_fontstyle_t* fs)
    static SKFontStyleSlant sk_fontstyle_get_slant (sk_fontstyle_t* fs)
    {
        return .sk_fontstyle_get_slant (fs);
    }

    // int sk_fontstyle_get_weight(const sk_fontstyle_t* fs)
    static int sk_fontstyle_get_weight (sk_fontstyle_t* fs)
    {
        return .sk_fontstyle_get_weight (fs);
    }

    // int sk_fontstyle_get_width(const sk_fontstyle_t* fs)
    static int sk_fontstyle_get_width (sk_fontstyle_t* fs)
    {
        return .sk_fontstyle_get_width (fs);
    }

    // sk_fontstyle_t* sk_fontstyle_new(int weight, int width, sk_font_style_slant_t slant)
    static sk_fontstyle_t* sk_fontstyle_new (int weight, int width, SKFontStyleSlant slant)
    {
        return .sk_fontstyle_new (weight, width, slant);
    }

    // sk_fontstyleset_t* sk_fontstyleset_create_empty()
    static sk_fontstyleset_t* sk_fontstyleset_create_empty ()
    {
        return .sk_fontstyleset_create_empty ();
    }

    // sk_typeface_t* sk_fontstyleset_create_typeface(sk_fontstyleset_t* fss, int index)
    static sk_typeface_t* sk_fontstyleset_create_typeface (sk_fontstyleset_t* fss, int index)
    {
        return .sk_fontstyleset_create_typeface (fss, index);
    }

    // int sk_fontstyleset_get_count(sk_fontstyleset_t* fss)
    static int sk_fontstyleset_get_count (sk_fontstyleset_t* fss)
    {
        return .sk_fontstyleset_get_count (fss);
    }

    // void sk_fontstyleset_get_style(sk_fontstyleset_t* fss, int index, sk_fontstyle_t* fs, sk_string_t* style)
    static void sk_fontstyleset_get_style (sk_fontstyleset_t* fss, int index, sk_fontstyle_t* fs, sk_string_t* style)
    {
        .sk_fontstyleset_get_style (fss, index, fs, style);
    }

    // sk_typeface_t* sk_fontstyleset_match_style(sk_fontstyleset_t* fss, sk_fontstyle_t* style)
    static sk_typeface_t* sk_fontstyleset_match_style (sk_fontstyleset_t* fss, sk_fontstyle_t* style)
    {
        return .sk_fontstyleset_match_style (fss, style);
    }

    // void sk_fontstyleset_unref(sk_fontstyleset_t* fss)
    static void sk_fontstyleset_unref (sk_fontstyleset_t* fss)
    {
        .sk_fontstyleset_unref (fss);
    }

    // sk_data_t* sk_typeface_copy_table_data(const sk_typeface_t* typeface, sk_font_table_tag_t tag)
    static sk_data_t* sk_typeface_copy_table_data (sk_typeface_t* typeface, uint tag)
    {
        return .sk_typeface_copy_table_data (typeface, tag);
    }

    // int sk_typeface_count_glyphs(const sk_typeface_t* typeface)
    static int sk_typeface_count_glyphs (sk_typeface_t* typeface)
    {
        return .sk_typeface_count_glyphs (typeface);
    }

    // int sk_typeface_count_tables(const sk_typeface_t* typeface)
    static int sk_typeface_count_tables (sk_typeface_t* typeface)
    {
        return .sk_typeface_count_tables (typeface);
    }

    // sk_typeface_t* sk_typeface_create_default()
    static sk_typeface_t* sk_typeface_create_default ()
    {
        return .sk_typeface_create_default ();
    }

    // sk_typeface_t* sk_typeface_create_from_data(sk_data_t* data, int index)
    static sk_typeface_t* sk_typeface_create_from_data (sk_data_t* data, int index)
    {
        return .sk_typeface_create_from_data (data, index);
    }

    // sk_typeface_t* sk_typeface_create_from_file(const(char)* path, int index)
    static sk_typeface_t* sk_typeface_create_from_file ( string path, int index)
    {
        return .sk_typeface_create_from_file (path.toStringz(), index);
    }

    // sk_typeface_t* sk_typeface_create_from_name(const(char)* familyName, const sk_fontstyle_t* style)
    static sk_typeface_t* sk_typeface_create_from_name (string familyName, sk_fontstyle_t* style)
    {
        return .sk_typeface_create_from_name (familyName.toStringz(), style);
    }

    // sk_typeface_t* sk_typeface_create_from_stream(sk_stream_asset_t* stream, int index)
    static sk_typeface_t* sk_typeface_create_from_stream (sk_stream_asset_t* stream, int index)
    {
        return .sk_typeface_create_from_stream (stream, index);
    }

    // sk_string_t* sk_typeface_get_family_name(const sk_typeface_t* typeface)
    static sk_string_t* sk_typeface_get_family_name (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_family_name (typeface);
    }

    // sk_font_style_slant_t sk_typeface_get_font_slant(const sk_typeface_t* typeface)
    static SKFontStyleSlant sk_typeface_get_font_slant (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_font_slant (typeface);
    }

    // int sk_typeface_get_font_weight(const sk_typeface_t* typeface)
    static int sk_typeface_get_font_weight (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_font_weight (typeface);
    }

    // int sk_typeface_get_font_width(const sk_typeface_t* typeface)
    static int sk_typeface_get_font_width (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_font_width (typeface);
    }

    // sk_fontstyle_t* sk_typeface_get_fontstyle(const sk_typeface_t* typeface)
    static sk_fontstyle_t* sk_typeface_get_fontstyle (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_fontstyle (typeface);
    }

    // bool sk_typeface_get_kerning_pair_adjustments(const sk_typeface_t* typeface, const uint16_t* glyphs, int count, int32_t* adjustments)
    static bool sk_typeface_get_kerning_pair_adjustments (sk_typeface_t* typeface, ushort* glyphs, int count, int* adjustments)
    {
        return .sk_typeface_get_kerning_pair_adjustments (typeface, glyphs, count, adjustments);
    }

    // size_t sk_typeface_get_table_data(const sk_typeface_t* typeface, sk_font_table_tag_t tag, size_t offset, size_t length, void* data)
    static void* sk_typeface_get_table_data (sk_typeface_t* typeface, uint tag, size_t offset, size_t length, void* data)
    {
        return .sk_typeface_get_table_data (typeface, tag, offset, length, data);
    }

    // size_t sk_typeface_get_table_size(const sk_typeface_t* typeface, sk_font_table_tag_t tag)
    static size_t sk_typeface_get_table_size (sk_typeface_t* typeface, uint tag)
    {
        return .sk_typeface_get_table_size (typeface, tag);
    }

    // int sk_typeface_get_table_tags(const sk_typeface_t* typeface, sk_font_table_tag_t* tags)
    static int sk_typeface_get_table_tags (sk_typeface_t* typeface, uint* tags)
    {
        return .sk_typeface_get_table_tags (typeface, tags);
    }

    // int sk_typeface_get_units_per_em(const sk_typeface_t* typeface)
    static int sk_typeface_get_units_per_em (sk_typeface_t* typeface)
    {
        return .sk_typeface_get_units_per_em (typeface);
    }

    // bool sk_typeface_is_fixed_pitch(const sk_typeface_t* typeface)
    static bool sk_typeface_is_fixed_pitch (sk_typeface_t* typeface)
    {
        return .sk_typeface_is_fixed_pitch (typeface);
    }

    // sk_stream_asset_t* sk_typeface_open_stream(const sk_typeface_t* typeface, int* ttcIndex)
    static sk_stream_asset_t* sk_typeface_open_stream (sk_typeface_t* typeface, int* ttcIndex)
    {
        return .sk_typeface_open_stream (typeface, ttcIndex);
    }

    // sk_typeface_t* sk_typeface_ref_default()
    static sk_typeface_t* sk_typeface_ref_default ()
    {
        return .sk_typeface_ref_default ();
    }

    // uint16_t sk_typeface_unichar_to_glyph(const sk_typeface_t* typeface, const int32_t unichar)
    static ushort sk_typeface_unichar_to_glyph (sk_typeface_t* typeface, int unichar)
    {
        return .sk_typeface_unichar_to_glyph (typeface, unichar);
    }

    // void sk_typeface_unichars_to_glyphs(const sk_typeface_t* typeface, const int32_t* unichars, int count, uint16_t* glyphs)
    static void sk_typeface_unichars_to_glyphs (sk_typeface_t* typeface, int* unichars, int count, ushort* glyphs)
    {
        .sk_typeface_unichars_to_glyphs (typeface, unichars, count, glyphs);
    }

    // void sk_typeface_unref(sk_typeface_t* typeface)
    static void sk_typeface_unref (sk_typeface_t* typeface)
    {
        .sk_typeface_unref (typeface);
    }

    // end header: sk_typeface.h

    // for header: sk_vertices.h

    // sk_vertices_t* sk_vertices_make_copy(sk_vertices_vertex_mode_t vmode, int vertexCount, const sk_point_t* positions, const sk_point_t* texs, const sk_color_t* colors, int indexCount, const uint16_t* indices)
    static sk_vertices_t* sk_vertices_make_copy (SKVertexMode vmode, int vertexCount, SKPoint* positions, SKPoint* texs, uint* colors, int indexCount, ushort* indices)
    {
        return .sk_vertices_make_copy (vmode, vertexCount, positions, texs, colors, indexCount, indices);
    }

    // void sk_vertices_ref(sk_vertices_t* cvertices)
    static void sk_vertices_ref (sk_vertices_t* cvertices)
    {
        .sk_vertices_ref (cvertices);
    }

    // void sk_vertices_unref(sk_vertices_t* cvertices)
    static void sk_vertices_unref (sk_vertices_t* cvertices)
    {
        .sk_vertices_unref (cvertices);
    }

    // end header: sk_vertices.h

    // for header: sk_xml.h

    // void sk_xmlstreamwriter_delete(sk_xmlstreamwriter_t* writer)
    static void sk_xmlstreamwriter_delete (sk_xmlstreamwriter_t* writer)
    {
        .sk_xmlstreamwriter_delete (writer);
    }

    // sk_xmlstreamwriter_t* sk_xmlstreamwriter_new(sk_wstream_t* stream)
    static sk_xmlstreamwriter_t* sk_xmlstreamwriter_new (sk_wstream_t* stream)
    {
        return .sk_xmlstreamwriter_new (stream);
    }

    // end header: sk_xml.h

    // for header: sk_compatpaint.h

    // sk_compatpaint_t* sk_compatpaint_clone(const sk_compatpaint_t* paint)
    static sk_compatpaint_t* sk_compatpaint_clone (sk_compatpaint_t* paint)
    {
        return .sk_compatpaint_clone (paint);
    }

    // void sk_compatpaint_delete(sk_compatpaint_t* paint)
    static void sk_compatpaint_delete (sk_compatpaint_t* paint)
    {
        .sk_compatpaint_delete (paint);
    }

    // sk_font_t* sk_compatpaint_get_font(sk_compatpaint_t* paint)
    static sk_font_t* sk_compatpaint_get_font (sk_compatpaint_t* paint)
    {
        return .sk_compatpaint_get_font (paint);
    }

    // sk_text_align_t sk_compatpaint_get_text_align(const sk_compatpaint_t* paint)
    static SKTextAlign sk_compatpaint_get_text_align (sk_compatpaint_t* paint)
    {
        return .sk_compatpaint_get_text_align (paint);
    }

    // sk_text_encoding_t sk_compatpaint_get_text_encoding(const sk_compatpaint_t* paint)
    static SKTextEncoding sk_compatpaint_get_text_encoding (sk_compatpaint_t* paint)
    {
        return .sk_compatpaint_get_text_encoding (paint);
    }

    // sk_font_t* sk_compatpaint_make_font(sk_compatpaint_t* paint)
    static sk_font_t* sk_compatpaint_make_font (sk_compatpaint_t* paint)
    {
        return .sk_compatpaint_make_font (paint);
    }

    // sk_compatpaint_t* sk_compatpaint_new()
    static sk_compatpaint_t* sk_compatpaint_new ()
    {
        return .sk_compatpaint_new ();
    }

    // sk_compatpaint_t* sk_compatpaint_new_with_font(const sk_font_t* font)
    static sk_compatpaint_t* sk_compatpaint_new_with_font (sk_font_t* font)
    {
        return .sk_compatpaint_new_with_font (font);
    }

    // void sk_compatpaint_reset(sk_compatpaint_t* paint)
    static void sk_compatpaint_reset (sk_compatpaint_t* paint)
    {
        .sk_compatpaint_reset (paint);
    }

    // void sk_compatpaint_set_text_align(sk_compatpaint_t* paint, sk_text_align_t textAlign)
    static void sk_compatpaint_set_text_align (sk_compatpaint_t* paint, SKTextAlign textAlign)
    {
        .sk_compatpaint_set_text_align (paint, textAlign);
    }

    // void sk_compatpaint_set_text_encoding(sk_compatpaint_t* paint, sk_text_encoding_t encoding)
    static void sk_compatpaint_set_text_encoding (sk_compatpaint_t* paint, SKTextEncoding encoding)
    {
        .sk_compatpaint_set_text_encoding (paint, encoding);
    }

    // end header: sk_compatpaint.h

    // for header: sk_manageddrawable.h

    // sk_manageddrawable_t* sk_manageddrawable_new(void* context)
    static sk_manageddrawable_t* sk_manageddrawable_new (void* context)
    {
        return .sk_manageddrawable_new (context);
    }

    // void sk_manageddrawable_set_procs(sk_manageddrawable_procs_t procs)
    static void sk_manageddrawable_set_procs (SKManagedDrawableDelegates procs)
    {
        .sk_manageddrawable_set_procs (procs);
    }

    // void sk_manageddrawable_unref(sk_manageddrawable_t*)
    static void sk_manageddrawable_unref (sk_manageddrawable_t* param0)
    {
        .sk_manageddrawable_unref (param0);
    }

    // end header: sk_manageddrawable.h

    // for header: sk_managedstream.h

    // void sk_managedstream_destroy(sk_stream_managedstream_t* s)
    static void sk_managedstream_destroy (sk_stream_managedstream_t* s)
    {
        .sk_managedstream_destroy (s);
    }

    // sk_stream_managedstream_t* sk_managedstream_new(void* context)
    static sk_stream_managedstream_t* sk_managedstream_new (void* context)
    {
        return .sk_managedstream_new (context);
    }

    // void sk_managedstream_set_procs(sk_managedstream_procs_t procs)
    static void sk_managedstream_set_procs (SKManagedStreamDelegates procs)
    {
        .sk_managedstream_set_procs (procs);
    }

    // void sk_managedwstream_destroy(sk_wstream_managedstream_t* s)
    static void sk_managedwstream_destroy (sk_wstream_managedstream_t* s)
    {
        .sk_managedwstream_destroy (s);
    }

    // sk_wstream_managedstream_t* sk_managedwstream_new(void* context)
    static sk_wstream_managedstream_t* sk_managedwstream_new (void* context)
    {
        return .sk_managedwstream_new (context);
    }

    // void sk_managedwstream_set_procs(sk_managedwstream_procs_t procs)
    static void sk_managedwstream_set_procs (SKManagedWStreamDelegates procs)
    {
        .sk_managedwstream_set_procs (procs);
    }

    // end header: sk_managedstream.h

    // for header: sk_managedtracememorydump.h

    // void sk_managedtracememorydump_delete(sk_managedtracememorydump_t*)
    static void sk_managedtracememorydump_delete (sk_managedtracememorydump_t* param0)
    {
        .sk_managedtracememorydump_delete (param0);
    }

    // sk_managedtracememorydump_t* sk_managedtracememorydump_new(bool detailed, bool dumpWrapped, void* context)
    static sk_managedtracememorydump_t* sk_managedtracememorydump_new (bool detailed, bool dumpWrapped, void* context)
    {
        return .sk_managedtracememorydump_new (detailed, dumpWrapped, context);
    }

    // void sk_managedtracememorydump_set_procs(sk_managedtracememorydump_procs_t procs)
    static void sk_managedtracememorydump_set_procs (SKManagedTraceMemoryDumpDelegates procs)
    {
        .sk_managedtracememorydump_set_procs (procs);
    }

    // end header: sk_managedtracememorydump.h


}

// End functions



// #region Delegates

extern(C) {
    // typedef void (*)()* gr_gl_func_ptr
    alias gr_gl_func_ptr = GRGlFuncPtr;
    alias GRGlFuncPtr = void function();

    // typedef gr_gl_func_ptr (*)(void* ctx, const(char)* name)* gr_gl_get_proc
    alias gr_gl_get_proc = GRGlGetProcProxyDelegate;
    alias GRGlGetProcProxyDelegate = void* function(void* ctx, void* name);

    // typedef void (*)()* gr_vk_func_ptr
    alias gr_vk_func_ptr = GRVkFuncPtr;
    alias GRVkFuncPtr = void function();

    // typedef gr_vk_func_ptr (*)(void* ctx, const(char)* name, vk_instance_t* instance, vk_device_t* device)* gr_vk_get_proc
    alias gr_vk_get_proc = GRVkGetProcProxyDelegate;
    alias GRVkGetProcProxyDelegate = void* function(void* ctx, void* name, vk_instance_t* instance, vk_device_t* device);

    // typedef void (*)(void* addr, void* context)* sk_bitmap_release_proc
    alias sk_bitmap_release_proc = SKBitmapReleaseProxyDelegate;
    alias SKBitmapReleaseProxyDelegate = void function(void* addr, void* context);

    // typedef void (*)(const(void)* ptr, void* context)* sk_data_release_proc
    alias sk_data_release_proc = SKDataReleaseProxyDelegate;
    alias SKDataReleaseProxyDelegate = void function(void* ptr, void* context);

    // typedef void (*)(const sk_path_t* pathOrNull, const sk_matrix_t* matrix, void* context)* sk_glyph_path_proc
    alias sk_glyph_path_proc = SKGlyphPathProxyDelegate;
    alias SKGlyphPathProxyDelegate = void function(sk_path_t* pathOrNull, SKMatrix* matrix, void* context);

    // typedef void (*)(const(void)* addr, void* context)* sk_image_raster_release_proc
    alias sk_image_raster_release_proc = SKImageRasterReleaseProxyDelegate;
    alias SKImageRasterReleaseProxyDelegate = void function(void* addr, void* context);

    // typedef void (*)(void* context)* sk_image_texture_release_proc
    alias sk_image_texture_release_proc = SKImageTextureReleaseProxyDelegate;
    alias SKImageTextureReleaseProxyDelegate = void function(void* context);

    // typedef void (*)(sk_manageddrawable_t* d, void* context)* sk_manageddrawable_destroy_proc
    alias sk_manageddrawable_destroy_proc = SKManagedDrawableDestroyProxyDelegate;
    alias SKManagedDrawableDestroyProxyDelegate = void function(sk_manageddrawable_t* d, void* context);

    // typedef void (*)(sk_manageddrawable_t* d, void* context, sk_canvas_t* ccanvas)* sk_manageddrawable_draw_proc
    alias sk_manageddrawable_draw_proc = SKManagedDrawableDrawProxyDelegate;
    alias SKManagedDrawableDrawProxyDelegate = void function(sk_manageddrawable_t* d, void* context, sk_canvas_t* ccanvas);

    // typedef void (*)(sk_manageddrawable_t* d, void* context, sk_rect_t* rect)* sk_manageddrawable_getBounds_proc
    alias sk_manageddrawable_getBounds_proc = SKManagedDrawableGetBoundsProxyDelegate;
    alias SKManagedDrawableGetBoundsProxyDelegate = void function(sk_manageddrawable_t* d, void* context, SKRect* rect);

    // typedef sk_picture_t* (*)(sk_manageddrawable_t* d, void* context)* sk_manageddrawable_newPictureSnapshot_proc
    alias sk_manageddrawable_newPictureSnapshot_proc = SKManagedDrawableNewPictureSnapshotProxyDelegate;
    alias SKManagedDrawableNewPictureSnapshotProxyDelegate = void* function(void* d, void* context);

    // typedef void (*)(sk_stream_managedstream_t* s, void* context)* sk_managedstream_destroy_proc
    alias sk_managedstream_destroy_proc = SKManagedStreamDestroyProxyDelegate;
    alias SKManagedStreamDestroyProxyDelegate = void function(sk_stream_managedstream_t* s, void* context);

    // typedef sk_stream_managedstream_t* (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_duplicate_proc
    alias sk_managedstream_duplicate_proc = SKManagedStreamDuplicateProxyDelegate;
    alias SKManagedStreamDuplicateProxyDelegate = sk_stream_managedstream_t* function(sk_stream_managedstream_t* s, void* context);

    // typedef sk_stream_managedstream_t* (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_fork_proc
    alias sk_managedstream_fork_proc = SKManagedStreamForkProxyDelegate;
    alias SKManagedStreamForkProxyDelegate = sk_stream_managedstream_t* function(sk_stream_managedstream_t* s, void* context);

    // typedef size_t (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_getLength_proc
    alias sk_managedstream_getLength_proc = SKManagedStreamGetLengthProxyDelegate;
    alias SKManagedStreamGetLengthProxyDelegate = void* function(sk_stream_managedstream_t* s, void* context);

    // typedef size_t (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_getPosition_proc
    alias sk_managedstream_getPosition_proc = SKManagedStreamGetPositionProxyDelegate;
    alias SKManagedStreamGetPositionProxyDelegate = void* function(sk_stream_managedstream_t* s, void* context);

    // typedef bool (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_hasLength_proc
    alias sk_managedstream_hasLength_proc = SKManagedStreamHasLengthProxyDelegate;
    alias SKManagedStreamHasLengthProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context);

    // typedef bool (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_hasPosition_proc
    alias sk_managedstream_hasPosition_proc = SKManagedStreamHasPositionProxyDelegate;
    alias SKManagedStreamHasPositionProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context);

    // typedef bool (*)(const sk_stream_managedstream_t* s, void* context)* sk_managedstream_isAtEnd_proc
    alias sk_managedstream_isAtEnd_proc = SKManagedStreamIsAtEndProxyDelegate;
    alias SKManagedStreamIsAtEndProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context);

    // typedef bool (*)(sk_stream_managedstream_t* s, void* context, int offset)* sk_managedstream_move_proc
    alias sk_managedstream_move_proc = SKManagedStreamMoveProxyDelegate;
    alias SKManagedStreamMoveProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context, int offset);

    // typedef size_t (*)(const sk_stream_managedstream_t* s, void* context, void* buffer, size_t size)* sk_managedstream_peek_proc
    alias sk_managedstream_peek_proc = SKManagedStreamPeekProxyDelegate;
    alias SKManagedStreamPeekProxyDelegate = void* function(sk_stream_managedstream_t* s, void* context, void* buffer, size_t size);

    // typedef size_t (*)(sk_stream_managedstream_t* s, void* context, void* buffer, size_t size)* sk_managedstream_read_proc
    alias sk_managedstream_read_proc = SKManagedStreamReadProxyDelegate;
    alias SKManagedStreamReadProxyDelegate = void* function(sk_stream_managedstream_t* s, void* context, void* buffer, size_t size);

    // typedef bool (*)(sk_stream_managedstream_t* s, void* context)* sk_managedstream_rewind_proc
    alias sk_managedstream_rewind_proc = SKManagedStreamRewindProxyDelegate;
    alias SKManagedStreamRewindProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context);

    // typedef bool (*)(sk_stream_managedstream_t* s, void* context, size_t position)* sk_managedstream_seek_proc
    alias sk_managedstream_seek_proc = SKManagedStreamSeekProxyDelegate;
    alias SKManagedStreamSeekProxyDelegate = bool function(sk_stream_managedstream_t* s, void* context, size_t position);

    // typedef void (*)(sk_managedtracememorydump_t* d, void* context, const(char)* dumpName, const(char)* valueName, const(char)* units, uint64_t value)* sk_managedtraceMemoryDump_dumpNumericValue_proc
    alias sk_managedtraceMemoryDump_dumpNumericValue_proc = SKManagedTraceMemoryDumpDumpNumericValueProxyDelegate;
    alias SKManagedTraceMemoryDumpDumpNumericValueProxyDelegate = void function(sk_managedtracememorydump_t* d, void* context, void* dumpName, void* valueName, void* units, ulong value);

    // typedef void (*)(sk_managedtracememorydump_t* d, void* context, const(char)* dumpName, const(char)* valueName, const(char)* value)* sk_managedtraceMemoryDump_dumpStringValue_proc
    alias sk_managedtraceMemoryDump_dumpStringValue_proc = SKManagedTraceMemoryDumpDumpStringValueProxyDelegate;
    alias SKManagedTraceMemoryDumpDumpStringValueProxyDelegate = void function(sk_managedtracememorydump_t* d, void* context, void* dumpName, void* valueName, void* value);

    // typedef size_t (*)(const sk_wstream_managedstream_t* s, void* context)* sk_managedwstream_bytesWritten_proc
    alias sk_managedwstream_bytesWritten_proc = SKManagedWStreamBytesWrittenProxyDelegate;
    alias SKManagedWStreamBytesWrittenProxyDelegate = void* function(sk_wstream_managedstream_t* s, void* context);

    // typedef void (*)(sk_wstream_managedstream_t* s, void* context)* sk_managedwstream_destroy_proc
    alias sk_managedwstream_destroy_proc = SKManagedWStreamDestroyProxyDelegate;
    alias SKManagedWStreamDestroyProxyDelegate = void function(sk_wstream_managedstream_t* s, void* context);

    // typedef void (*)(sk_wstream_managedstream_t* s, void* context)* sk_managedwstream_flush_proc
    alias sk_managedwstream_flush_proc = SKManagedWStreamFlushProxyDelegate;
    alias SKManagedWStreamFlushProxyDelegate = void function(sk_wstream_managedstream_t* s, void* context);

    // typedef bool (*)(sk_wstream_managedstream_t* s, void* context, const(void)* buffer, size_t size)* sk_managedwstream_write_proc
    alias sk_managedwstream_write_proc = SKManagedWStreamWriteProxyDelegate;
    alias SKManagedWStreamWriteProxyDelegate = bool function(sk_wstream_managedstream_t* s, void* context, void* buffer, size_t size);

    // typedef void (*)(void* addr, void* context)* sk_surface_raster_release_proc
    alias sk_surface_raster_release_proc = SKSurfaceRasterReleaseProxyDelegate;
    alias SKSurfaceRasterReleaseProxyDelegate = void function(void* addr, void* context);

}
// #endregion




// #region Enums


alias gr_backend_t = GRBackendNative;


alias gr_surfaceorigin_t = GRSurfaceOrigin;

enum GRSurfaceOrigin {
	// TOP_LEFT_GR_SURFACE_ORIGIN = 0
	TopLeft = 0,
	// BOTTOM_LEFT_GR_SURFACE_ORIGIN = 1
	BottomLeft = 1,
}


alias sk_alphatype_t = SKAlphaType;

alias sk_bitmap_allocflags_t = SKBitmapAllocFlags;

enum SKBitmapAllocFlags {
	// NONE_SK_BITMAP_ALLOC_FLAGS = 0
	None = 0,
	// ZERO_PIXELS_SK_BITMAP_ALLOC_FLAGS = 1 << 0
	ZeroPixels = 1,
}


alias sk_blendmode_t = SKBlendMode;

enum SKBlendMode {
	// CLEAR_SK_BLENDMODE = 0
	Clear = 0,
	// SRC_SK_BLENDMODE = 1
	Src = 1,
	// DST_SK_BLENDMODE = 2
	Dst = 2,
	// SRCOVER_SK_BLENDMODE = 3
	SrcOver = 3,
	// DSTOVER_SK_BLENDMODE = 4
	DstOver = 4,
	// SRCIN_SK_BLENDMODE = 5
	SrcIn = 5,
	// DSTIN_SK_BLENDMODE = 6
	DstIn = 6,
	// SRCOUT_SK_BLENDMODE = 7
	SrcOut = 7,
	// DSTOUT_SK_BLENDMODE = 8
	DstOut = 8,
	// SRCATOP_SK_BLENDMODE = 9
	SrcATop = 9,
	// DSTATOP_SK_BLENDMODE = 10
	DstATop = 10,
	// XOR_SK_BLENDMODE = 11
	Xor = 11,
	// PLUS_SK_BLENDMODE = 12
	Plus = 12,
	// MODULATE_SK_BLENDMODE = 13
	Modulate = 13,
	// SCREEN_SK_BLENDMODE = 14
	Screen = 14,
	// OVERLAY_SK_BLENDMODE = 15
	Overlay = 15,
	// DARKEN_SK_BLENDMODE = 16
	Darken = 16,
	// LIGHTEN_SK_BLENDMODE = 17
	Lighten = 17,
	// COLORDODGE_SK_BLENDMODE = 18
	ColorDodge = 18,
	// COLORBURN_SK_BLENDMODE = 19
	ColorBurn = 19,
	// HARDLIGHT_SK_BLENDMODE = 20
	HardLight = 20,
	// SOFTLIGHT_SK_BLENDMODE = 21
	SoftLight = 21,
	// DIFFERENCE_SK_BLENDMODE = 22
	Difference = 22,
	// EXCLUSION_SK_BLENDMODE = 23
	Exclusion = 23,
	// MULTIPLY_SK_BLENDMODE = 24
	Multiply = 24,
	// HUE_SK_BLENDMODE = 25
	Hue = 25,
	// SATURATION_SK_BLENDMODE = 26
	Saturation = 26,
	// COLOR_SK_BLENDMODE = 27
	Color = 27,
	// LUMINOSITY_SK_BLENDMODE = 28
	Luminosity = 28,
}


alias sk_blurstyle_t = SKBlurStyle;

enum SKBlurStyle {
	// NORMAL_SK_BLUR_STYLE = 0
	Normal = 0,
	// SOLID_SK_BLUR_STYLE = 1
	Solid = 1,
	// OUTER_SK_BLUR_STYLE = 2
	Outer = 2,
	// INNER_SK_BLUR_STYLE = 3
	Inner = 3,
}


alias sk_clipop_t = SKClipOperation;

enum SKClipOperation {
	// DIFFERENCE_SK_CLIPOP = 0
	Difference = 0,
	// INTERSECT_SK_CLIPOP = 1
	Intersect = 1,
}


alias sk_codec_result_t = SKCodecResult;

enum SKCodecResult {
	// SUCCESS_SK_CODEC_RESULT = 0
	Success = 0,
	// INCOMPLETE_INPUT_SK_CODEC_RESULT = 1
	IncompleteInput = 1,
	// ERROR_IN_INPUT_SK_CODEC_RESULT = 2
	ErrorInInput = 2,
	// INVALID_CONVERSION_SK_CODEC_RESULT = 3
	InvalidConversion = 3,
	// INVALID_SCALE_SK_CODEC_RESULT = 4
	InvalidScale = 4,
	// INVALID_PARAMETERS_SK_CODEC_RESULT = 5
	InvalidParameters = 5,
	// INVALID_INPUT_SK_CODEC_RESULT = 6
	InvalidInput = 6,
	// COULD_NOT_REWIND_SK_CODEC_RESULT = 7
	CouldNotRewind = 7,
	// INTERNAL_ERROR_SK_CODEC_RESULT = 8
	InternalError = 8,
	// UNIMPLEMENTED_SK_CODEC_RESULT = 9
	Unimplemented = 9,
}


alias sk_codec_scanline_order_t = SKCodecScanlineOrder;

enum SKCodecScanlineOrder {
	// TOP_DOWN_SK_CODEC_SCANLINE_ORDER = 0
	TopDown = 0,
	// BOTTOM_UP_SK_CODEC_SCANLINE_ORDER = 1
	BottomUp = 1,
}


alias sk_codec_zero_initialized_t = SKZeroInitialized;


alias sk_codecanimation_disposalmethod_t = SKCodecAnimationDisposalMethod;

enum SKCodecAnimationDisposalMethod {
	// KEEP_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 1
	Keep = 1,
	// RESTORE_BG_COLOR_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 2
	RestoreBackgroundColor = 2,
	// RESTORE_PREVIOUS_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 3
	RestorePrevious = 3,
}


alias sk_color_channel_t = SKColorChannel;

enum SKColorChannel {
	// R_SK_COLOR_CHANNEL = 0
	R = 0,
	// G_SK_COLOR_CHANNEL = 1
	G = 1,
	// B_SK_COLOR_CHANNEL = 2
	B = 2,
	// A_SK_COLOR_CHANNEL = 3
	A = 3,
}


alias sk_colortype_t = SKColorTypeNative;


alias sk_crop_rect_flags_t = SKCropRectFlags;

enum SKCropRectFlags {
	// HAS_NONE_SK_CROP_RECT_FLAG = 0x00
	HasNone = 0,
	// HAS_LEFT_SK_CROP_RECT_FLAG = 0x01
	HasLeft = 1,
	// HAS_TOP_SK_CROP_RECT_FLAG = 0x02
	HasTop = 2,
	// HAS_WIDTH_SK_CROP_RECT_FLAG = 0x04
	HasWidth = 4,
	// HAS_HEIGHT_SK_CROP_RECT_FLAG = 0x08
	HasHeight = 8,
	// HAS_ALL_SK_CROP_RECT_FLAG = 0x0F
	HasAll = 15,
}


alias sk_encoded_image_format_t = SKEncodedImageFormat;

enum SKEncodedImageFormat {
	// BMP_SK_ENCODED_FORMAT = 0
	Bmp = 0,
	// GIF_SK_ENCODED_FORMAT = 1
	Gif = 1,
	// ICO_SK_ENCODED_FORMAT = 2
	Ico = 2,
	// JPEG_SK_ENCODED_FORMAT = 3
	Jpeg = 3,
	// PNG_SK_ENCODED_FORMAT = 4
	Png = 4,
	// WBMP_SK_ENCODED_FORMAT = 5
	Wbmp = 5,
	// WEBP_SK_ENCODED_FORMAT = 6
	Webp = 6,
	// PKM_SK_ENCODED_FORMAT = 7
	Pkm = 7,
	// KTX_SK_ENCODED_FORMAT = 8
	Ktx = 8,
	// ASTC_SK_ENCODED_FORMAT = 9
	Astc = 9,
	// DNG_SK_ENCODED_FORMAT = 10
	Dng = 10,
	// HEIF_SK_ENCODED_FORMAT = 11
	Heif = 11,
}


alias sk_encodedorigin_t = SKEncodedOrigin;

enum SKEncodedOrigin {
	// TOP_LEFT_SK_ENCODED_ORIGIN = 1
	TopLeft = 1,
	// TOP_RIGHT_SK_ENCODED_ORIGIN = 2
	TopRight = 2,
	// BOTTOM_RIGHT_SK_ENCODED_ORIGIN = 3
	BottomRight = 3,
	// BOTTOM_LEFT_SK_ENCODED_ORIGIN = 4
	BottomLeft = 4,
	// LEFT_TOP_SK_ENCODED_ORIGIN = 5
	LeftTop = 5,
	// RIGHT_TOP_SK_ENCODED_ORIGIN = 6
	RightTop = 6,
	// RIGHT_BOTTOM_SK_ENCODED_ORIGIN = 7
	RightBottom = 7,
	// LEFT_BOTTOM_SK_ENCODED_ORIGIN = 8
	LeftBottom = 8,
	// DEFAULT_SK_ENCODED_ORIGIN = TOP_LEFT_SK_ENCODED_ORIGIN
	Default = 1,
}


alias sk_filter_quality_t = SKFilterQuality;

enum SKFilterQuality {
	// NONE_SK_FILTER_QUALITY = 0
	None = 0,
	// LOW_SK_FILTER_QUALITY = 1
	Low = 1,
	// MEDIUM_SK_FILTER_QUALITY = 2
	Medium = 2,
	// HIGH_SK_FILTER_QUALITY = 3
	High = 3,
}


alias sk_font_edging_t = SKFontEdging;

enum SKFontEdging {
	// ALIAS_SK_FONT_EDGING = 0
	Alias = 0,
	// ANTIALIAS_SK_FONT_EDGING = 1
	Antialias = 1,
	// SUBPIXEL_ANTIALIAS_SK_FONT_EDGING = 2
	SubpixelAntialias = 2,
}


alias sk_font_hinting_t = SKFontHinting;

enum SKFontHinting {
	// NONE_SK_FONT_HINTING = 0
	None = 0,
	// SLIGHT_SK_FONT_HINTING = 1
	Slight = 1,
	// NORMAL_SK_FONT_HINTING = 2
	Normal = 2,
	// FULL_SK_FONT_HINTING = 3
	Full = 3,
}


alias sk_font_style_slant_t = SKFontStyleSlant;

enum SKFontStyleSlant {
	// UPRIGHT_SK_FONT_STYLE_SLANT = 0
	Upright = 0,
	// ITALIC_SK_FONT_STYLE_SLANT = 1
	Italic = 1,
	// OBLIQUE_SK_FONT_STYLE_SLANT = 2
	Oblique = 2,
}


alias sk_highcontrastconfig_invertstyle_t = SKHighContrastConfigInvertStyle;

enum SKHighContrastConfigInvertStyle {
	// NO_INVERT_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE = 0
	NoInvert = 0,
	// INVERT_BRIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE = 1
	InvertBrightness = 1,
	// INVERT_LIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE = 2
	InvertLightness = 2,
}


alias sk_image_caching_hint_t = SKImageCachingHint;

enum SKImageCachingHint {
	// ALLOW_SK_IMAGE_CACHING_HINT = 0
	Allow = 0,
	// DISALLOW_SK_IMAGE_CACHING_HINT = 1
	Disallow = 1,
}


alias sk_jpegencoder_alphaoption_t = SKJpegEncoderAlphaOption;

enum SKJpegEncoderAlphaOption {
	// IGNORE_SK_JPEGENCODER_ALPHA_OPTION = 0
	Ignore = 0,
	// BLEND_ON_BLACK_SK_JPEGENCODER_ALPHA_OPTION = 1
	BlendOnBlack = 1,
}


alias sk_jpegencoder_downsample_t = SKJpegEncoderDownsample;

enum SKJpegEncoderDownsample {
	// DOWNSAMPLE_420_SK_JPEGENCODER_DOWNSAMPLE = 0
	Downsample420 = 0,
	// DOWNSAMPLE_422_SK_JPEGENCODER_DOWNSAMPLE = 1
	Downsample422 = 1,
	// DOWNSAMPLE_444_SK_JPEGENCODER_DOWNSAMPLE = 2
	Downsample444 = 2,
}


alias sk_lattice_recttype_t = SKLatticeRectType;


alias sk_mask_format_t = SKMaskFormat;

enum SKMaskFormat {
	// BW_SK_MASK_FORMAT = 0
	BW = 0,
	// A8_SK_MASK_FORMAT = 1
	A8 = 1,
	// THREE_D_SK_MASK_FORMAT = 2
	ThreeD = 2,
	// ARGB32_SK_MASK_FORMAT = 3
	Argb32 = 3,
	// LCD16_SK_MASK_FORMAT = 4
	Lcd16 = 4,
	// SDF_SK_MASK_FORMAT = 5
	Sdf = 5,
}


alias sk_matrix44_type_mask_t = SKMatrix44TypeMask;

enum SKMatrix44TypeMask {
	// IDENTITY_SK_MATRIX44_TYPE_MASK = 0
	Identity = 0,
	// TRANSLATE_SK_MATRIX44_TYPE_MASK = 0x01
	Translate = 1,
	// SCALE_SK_MATRIX44_TYPE_MASK = 0x02
	Scale = 2,
	// AFFINE_SK_MATRIX44_TYPE_MASK = 0x04
	Affine = 4,
	// PERSPECTIVE_SK_MATRIX44_TYPE_MASK = 0x08
	Perspective = 8,
}


alias sk_paint_style_t = SKPaintStyle;

enum SKPaintStyle {
	// FILL_SK_PAINT_STYLE = 0
	Fill = 0,
	// STROKE_SK_PAINT_STYLE = 1
	Stroke = 1,
	// STROKE_AND_FILL_SK_PAINT_STYLE = 2
	StrokeAndFill = 2,
}


alias sk_path_add_mode_t = SKPathAddMode;

enum SKPathAddMode {
	// APPEND_SK_PATH_ADD_MODE = 0
	Append = 0,
	// EXTEND_SK_PATH_ADD_MODE = 1
	Extend = 1,
}


alias sk_path_arc_size_t = SKPathArcSize;

enum SKPathArcSize {
	// SMALL_SK_PATH_ARC_SIZE = 0
	Small = 0,
	// LARGE_SK_PATH_ARC_SIZE = 1
	Large = 1,
}


alias sk_path_convexity_t = SKPathConvexity;

enum SKPathConvexity {
	// UNKNOWN_SK_PATH_CONVEXITY = 0
	Unknown = 0,
	// CONVEX_SK_PATH_CONVEXITY = 1
	Convex = 1,
	// CONCAVE_SK_PATH_CONVEXITY = 2
	Concave = 2,
}


alias sk_path_direction_t = SKPathDirection;

enum SKPathDirection {
	// CW_SK_PATH_DIRECTION = 0
	Clockwise = 0,
	// CCW_SK_PATH_DIRECTION = 1
	CounterClockwise = 1,
}


alias sk_path_effect_1d_style_t = SKPath1DPathEffectStyle;


alias sk_path_effect_trim_mode_t = SKTrimPathEffectMode;


alias sk_path_filltype_t = SKPathFillType;

enum SKPathFillType {
	// WINDING_SK_PATH_FILLTYPE = 0
	Winding = 0,
	// EVENODD_SK_PATH_FILLTYPE = 1
	EvenOdd = 1,
	// INVERSE_WINDING_SK_PATH_FILLTYPE = 2
	InverseWinding = 2,
	// INVERSE_EVENODD_SK_PATH_FILLTYPE = 3
	InverseEvenOdd = 3,
}


alias sk_path_segment_mask_t = SKPathSegmentMask;

enum SKPathSegmentMask {
	// LINE_SK_PATH_SEGMENT_MASK = 1 << 0
	Line = 1,
	// QUAD_SK_PATH_SEGMENT_MASK = 1 << 1
	Quad = 2,
	// CONIC_SK_PATH_SEGMENT_MASK = 1 << 2
	Conic = 4,
	// CUBIC_SK_PATH_SEGMENT_MASK = 1 << 3
	Cubic = 8,
}


alias sk_path_verb_t = SKPathVerb;

enum SKPathVerb {
	// MOVE_SK_PATH_VERB = 0
	Move = 0,
	// LINE_SK_PATH_VERB = 1
	Line = 1,
	// QUAD_SK_PATH_VERB = 2
	Quad = 2,
	// CONIC_SK_PATH_VERB = 3
	Conic = 3,
	// CUBIC_SK_PATH_VERB = 4
	Cubic = 4,
	// CLOSE_SK_PATH_VERB = 5
	Close = 5,
	// DONE_SK_PATH_VERB = 6
	Done = 6,
}


alias sk_pathmeasure_matrixflags_t = SKPathMeasureMatrixFlags;

enum SKPathMeasureMatrixFlags {
	// GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS = 0x01
	GetPosition = 1,
	// GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS = 0x02
	GetTangent = 2,
	// GET_POS_AND_TAN_SK_PATHMEASURE_MATRIXFLAGS = GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS | GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS
	GetPositionAndTangent = 3,
}


alias sk_pathop_t = SKPathOp;

enum SKPathOp {
	// DIFFERENCE_SK_PATHOP = 0
	Difference = 0,
	// INTERSECT_SK_PATHOP = 1
	Intersect = 1,
	// UNION_SK_PATHOP = 2
	Union = 2,
	// XOR_SK_PATHOP = 3
	Xor = 3,
	// REVERSE_DIFFERENCE_SK_PATHOP = 4
	ReverseDifference = 4,
}


alias sk_pixelgeometry_t = SKPixelGeometry;


alias sk_pngencoder_filterflags_t = SKPngEncoderFilterFlags;

enum SKPngEncoderFilterFlags {
	// ZERO_SK_PNGENCODER_FILTER_FLAGS = 0x00
	NoFilters = 0,
	// NONE_SK_PNGENCODER_FILTER_FLAGS = 0x08
	None = 8,
	// SUB_SK_PNGENCODER_FILTER_FLAGS = 0x10
	Sub = 16,
	// UP_SK_PNGENCODER_FILTER_FLAGS = 0x20
	Up = 32,
	// AVG_SK_PNGENCODER_FILTER_FLAGS = 0x40
	Avg = 64,
	// PAETH_SK_PNGENCODER_FILTER_FLAGS = 0x80
	Paeth = 128,
	// ALL_SK_PNGENCODER_FILTER_FLAGS = NONE_SK_PNGENCODER_FILTER_FLAGS | SUB_SK_PNGENCODER_FILTER_FLAGS | UP_SK_PNGENCODER_FILTER_FLAGS | AVG_SK_PNGENCODER_FILTER_FLAGS | PAETH_SK_PNGENCODER_FILTER_FLAGS
	AllFilters = 248,
}


alias sk_point_mode_t = SKPointMode;

enum SKPointMode {
	// POINTS_SK_POINT_MODE = 0
	Points = 0,
	// LINES_SK_POINT_MODE = 1
	Lines = 1,
	// POLYGON_SK_POINT_MODE = 2
	Polygon = 2,
}


alias sk_region_op_t = SKRegionOperation;

enum SKRegionOperation {
	// DIFFERENCE_SK_REGION_OP = 0
	Difference = 0,
	// INTERSECT_SK_REGION_OP = 1
	Intersect = 1,
	// UNION_SK_REGION_OP = 2
	Union = 2,
	// XOR_SK_REGION_OP = 3
	XOR = 3,
	// REVERSE_DIFFERENCE_SK_REGION_OP = 4
	ReverseDifference = 4,
	// REPLACE_SK_REGION_OP = 5
	Replace = 5,
}


alias sk_rrect_corner_t = SKRoundRectCorner;

enum SKRoundRectCorner {
	// UPPER_LEFT_SK_RRECT_CORNER = 0
	UpperLeft = 0,
	// UPPER_RIGHT_SK_RRECT_CORNER = 1
	UpperRight = 1,
	// LOWER_RIGHT_SK_RRECT_CORNER = 2
	LowerRight = 2,
	// LOWER_LEFT_SK_RRECT_CORNER = 3
	LowerLeft = 3,
}


alias sk_rrect_type_t = SKRoundRectType;

enum SKRoundRectType {
	// EMPTY_SK_RRECT_TYPE = 0
	Empty = 0,
	// RECT_SK_RRECT_TYPE = 1
	Rect = 1,
	// OVAL_SK_RRECT_TYPE = 2
	Oval = 2,
	// SIMPLE_SK_RRECT_TYPE = 3
	Simple = 3,
	// NINE_PATCH_SK_RRECT_TYPE = 4
	NinePatch = 4,
	// COMPLEX_SK_RRECT_TYPE = 5
	Complex = 5,
}


alias sk_shader_tilemode_t = SKShaderTileMode;

enum SKShaderTileMode {
	// CLAMP_SK_SHADER_TILEMODE = 0
	Clamp = 0,
	// REPEAT_SK_SHADER_TILEMODE = 1
	Repeat = 1,
	// MIRROR_SK_SHADER_TILEMODE = 2
	Mirror = 2,
	// DECAL_SK_SHADER_TILEMODE = 3
	Decal = 3,
}


alias sk_stroke_cap_t = SKStrokeCap;

enum SKStrokeCap {
	// BUTT_SK_STROKE_CAP = 0
	Butt = 0,
	// ROUND_SK_STROKE_CAP = 1
	Round = 1,
	// SQUARE_SK_STROKE_CAP = 2
	Square = 2,
}


alias sk_stroke_join_t = SKStrokeJoin;

enum SKStrokeJoin {
	// MITER_SK_STROKE_JOIN = 0
	Miter = 0,
	// ROUND_SK_STROKE_JOIN = 1
	Round = 1,
	// BEVEL_SK_STROKE_JOIN = 2
	Bevel = 2,
}


alias sk_surfaceprops_flags_t = SKSurfacePropsFlags;


alias sk_text_align_t = SKTextAlign;

enum SKTextAlign {
	// LEFT_SK_TEXT_ALIGN = 0
	Left = 0,
	// CENTER_SK_TEXT_ALIGN = 1
	Center = 1,
	// RIGHT_SK_TEXT_ALIGN = 2
	Right = 2,
}


alias sk_text_encoding_t = SKTextEncoding;



alias sk_vertices_vertex_mode_t = SKVertexMode;

enum SKVertexMode {
	// TRIANGLES_SK_VERTICES_VERTEX_MODE = 0
	Triangles = 0,
	// TRIANGLE_STRIP_SK_VERTICES_VERTEX_MODE = 1
	TriangleStrip = 1,
	// TRIANGLE_FAN_SK_VERTICES_VERTEX_MODE = 2
	TriangleFan = 2,
}


alias sk_webpencoder_compression_t = SKWebpEncoderCompression;

enum SKWebpEncoderCompression {
	// LOSSY_SK_WEBPENCODER_COMPTRESSION = 0
	Lossy = 0,
	// LOSSLESS_SK_WEBPENCODER_COMPTRESSION = 1
	Lossless = 1,
}

// #endregion



// #region Structs


alias gr_gl_framebufferinfo_t = GRGlFramebufferInfo;

alias gr_gl_textureinfo_t = GRGlTextureInfo;

alias gr_vk_alloc_t = GRVkAlloc;

struct GRVkAlloc {
	// uint64_t fMemory
	private ulong fMemory;
	ulong Memory() {
		return fMemory;
	}

	void Memory(ulong value) {
		fMemory = value;
	}

	// uint64_t fOffset
	private ulong fOffset;
	ulong Offset() {
		return fOffset;
	}

	void Offset(ulong value) {
		fOffset = value;
	}

	// uint64_t fSize
	private ulong fSize;
	ulong Size() {
		return fSize;
	}

	void Size(ulong value) {
		fSize = value;
	}

	// uint32_t fFlags
	private uint fFlags;
	uint Flags() {
		return fFlags;
	}

	void Flags(uint value) {
		fFlags = value;
	}

	// gr_vk_backendmemory_t fBackendMemory
	private void* fBackendMemory;
	void* BackendMemory() {
		return fBackendMemory;
	}

	void BackendMemory(void* value) {
		fBackendMemory = value;
	}

	// bool private_fUsesSystemHeap
	private ubyte fUsesSystemHeap;

    // override bool opEquals(Object obj) {
    //     GRVkAlloc pp = cast(GRVkAlloc) obj;
    //     if (pp  is null)
    //         return false;
    //     return fMemory == obj.fMemory && fOffset == obj.fOffset && 
	// 			fSize == obj.fSize && fFlags == obj.fFlags && 
	// 			fBackendMemory == obj.fBackendMemory && fUsesSystemHeap == obj.fUsesSystemHeap;
    // }

    // override size_t toHash() @trusted nothrow {
    //     return hashOf(fMemory) + hashOf(fOffset) + hashOf(fSize) + hashOf(fFlags) + 
	// 		hashOf(fBackendMemory) + hashOf(fUsesSystemHeap);
    // }

}


alias gr_vk_backendcontext_t = GRVkBackendContextNative;

struct GRVkBackendContextNative {
	// vk_instance_t* fInstance
	vk_instance_t* fInstance;

	// vk_physical_device_t* fPhysicalDevice
	vk_physical_device_t* fPhysicalDevice;

	// vk_device_t* fDevice
	vk_device_t* fDevice;

	// vk_queue_t* fQueue
	vk_queue_t* fQueue;

	// uint32_t fGraphicsQueueIndex
	uint fGraphicsQueueIndex;

	// uint32_t fMinAPIVersion
	uint fMinAPIVersion;

	// uint32_t fInstanceVersion
	uint fInstanceVersion;

	// uint32_t fMaxAPIVersion
	uint fMaxAPIVersion;

	// uint32_t fExtensions
	uint fExtensions;

	// const gr_vk_extensions_t* fVkExtensions
	gr_vk_extensions_t* fVkExtensions;

	// uint32_t fFeatures
	uint fFeatures;

	// const vk_physical_device_features_t* fDeviceFeatures
	vk_physical_device_features_t* fDeviceFeatures;

	// const vk_physical_device_features_2_t* fDeviceFeatures2
	vk_physical_device_features_2_t* fDeviceFeatures2;

	// gr_vk_memory_allocator_t* fMemoryAllocator
	gr_vk_memory_allocator_t* fMemoryAllocator;

	// gr_vk_get_proc fGetProc
	GRVkGetProcProxyDelegate fGetProc;

	// void* fGetProcUserData
	void* fGetProcUserData;

	// bool fOwnsInstanceAndDevice
	ubyte fOwnsInstanceAndDevice;

	// bool fProtectedContext
	ubyte fProtectedContext;

	// const bool Equals (GRVkBackendContextNative obj) {
	// 	return fInstance == obj.fInstance && fPhysicalDevice == obj.fPhysicalDevice && fDevice == obj.fDevice && fQueue == obj.fQueue && fGraphicsQueueIndex == obj.fGraphicsQueueIndex && fMinAPIVersion == obj.fMinAPIVersion && fInstanceVersion == obj.fInstanceVersion && fMaxAPIVersion == obj.fMaxAPIVersion && fExtensions == obj.fExtensions && fVkExtensions == obj.fVkExtensions && fFeatures == obj.fFeatures && fDeviceFeatures == obj.fDeviceFeatures && fDeviceFeatures2 == obj.fDeviceFeatures2 && fMemoryAllocator == obj.fMemoryAllocator && fGetProc == obj.fGetProc && fGetProcUserData == obj.fGetProcUserData && fOwnsInstanceAndDevice == obj.fOwnsInstanceAndDevice && fProtectedContext == obj.fProtectedContext
	// }

	// const override bool Equals (object obj) {
	// 	return obj is GRVkBackendContextNative f && Equals (f)
	// }

	// static bool operator == (GRVkBackendContextNative left, GRVkBackendContextNative right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (GRVkBackendContextNative left, GRVkBackendContextNative right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fInstance);
	// 	hash.Add (fPhysicalDevice);
	// 	hash.Add (fDevice);
	// 	hash.Add (fQueue);
	// 	hash.Add (fGraphicsQueueIndex);
	// 	hash.Add (fMinAPIVersion);
	// 	hash.Add (fInstanceVersion);
	// 	hash.Add (fMaxAPIVersion);
	// 	hash.Add (fExtensions);
	// 	hash.Add (fVkExtensions);
	// 	hash.Add (fFeatures);
	// 	hash.Add (fDeviceFeatures);
	// 	hash.Add (fDeviceFeatures2);
	// 	hash.Add (fMemoryAllocator);
	// 	hash.Add (fGetProc);
	// 	hash.Add (fGetProcUserData);
	// 	hash.Add (fOwnsInstanceAndDevice);
	// 	hash.Add (fProtectedContext);
	// 	return hash.ToHashCode ();
	// }

}


alias gr_vk_imageinfo_t = GRVkImageInfo;

struct GRVkImageInfo {
	// uint64_t fImage
	private ulong fImage;
	ulong Image() {
		return fImage;
	}

	void Image(ulong value) {
		fImage = value;
	}

	// gr_vk_alloc_t fAlloc
	private GRVkAlloc fAlloc;
	GRVkAlloc Alloc() {
		return fAlloc;
	}

	void Alloc(GRVkAlloc value) {
		fAlloc = value;
	}

	// uint32_t fImageTiling
	private uint fImageTiling;
	uint ImageTiling() {
		return fImageTiling;
	}

	void ImageTiling(uint value) {
		fImageTiling = value;
	}

	// uint32_t fImageLayout
	private uint fImageLayout;
	uint ImageLayout() {
		return fImageLayout;
	}

	void ImageLayout(uint value) {
		fImageLayout = value;
	}

	// uint32_t fFormat
	private uint fFormat;
	uint Format() {
		return fFormat;
	}

	void Format(uint value) {
		fFormat = value;
	}

	// uint32_t fLevelCount
	private uint fLevelCount;
	uint LevelCount() {
		return fLevelCount;
	}

	void LevelCount(uint value) {
		fLevelCount = value;
	}

	// uint32_t fCurrentQueueFamily
	private uint fCurrentQueueFamily;
	uint CurrentQueueFamily() {
		return fCurrentQueueFamily;
	}

	void CurrentQueueFamily(uint value) {
		fCurrentQueueFamily = value;
	}

	// bool fProtected
	private ubyte fProtected;
	bool Protected() {
		return fProtected > 0;
    }
    void Protected(bool value) {
		fProtected = value ? cast(byte)1 : cast(byte)0;
	}

	// gr_vk_ycbcrconversioninfo_t fYcbcrConversionInfo
	private GrVkYcbcrConversionInfo fYcbcrConversionInfo;
	GrVkYcbcrConversionInfo YcbcrConversionInfo() {
		return fYcbcrConversionInfo;
	}

	void YcbcrConversionInfo(GrVkYcbcrConversionInfo value) {
		fYcbcrConversionInfo = value;
	}

	// const bool Equals (GRVkImageInfo obj) {
	// 	return fImage == obj.fImage && fAlloc == obj.fAlloc && fImageTiling == obj.fImageTiling && fImageLayout == obj.fImageLayout && fFormat == obj.fFormat && fLevelCount == obj.fLevelCount && fCurrentQueueFamily == obj.fCurrentQueueFamily && fProtected == obj.fProtected && fYcbcrConversionInfo == obj.fYcbcrConversionInfo
	// }

	// const override bool Equals (object obj) {
	// 	return obj is GRVkImageInfo f && Equals (f)
	// }

	// static bool operator == (GRVkImageInfo left, GRVkImageInfo right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (GRVkImageInfo left, GRVkImageInfo right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fImage);
	// 	hash.Add (fAlloc);
	// 	hash.Add (fImageTiling);
	// 	hash.Add (fImageLayout);
	// 	hash.Add (fFormat);
	// 	hash.Add (fLevelCount);
	// 	hash.Add (fCurrentQueueFamily);
	// 	hash.Add (fProtected);
	// 	hash.Add (fYcbcrConversionInfo);
	// 	return hash.ToHashCode ();
	// }

}


alias gr_vk_ycbcrconversioninfo_t = GrVkYcbcrConversionInfo;

struct GrVkYcbcrConversionInfo {
	// uint32_t fFormat
	private uint fFormat;
	uint Format() {
		return fFormat;
	}

	void Format(uint value) {
		fFormat = value;
	}

	// uint64_t fExternalFormat
	private ulong fExternalFormat;
	ulong ExternalFormat() {
		return fExternalFormat;
	}

	void ExternalFormat(ulong value) {
		fExternalFormat = value;
	}

	// uint32_t fYcbcrModel
	private uint fYcbcrModel;
	uint YcbcrModel() {
		return fYcbcrModel;
	}

	void YcbcrModel(uint value) {
		fYcbcrModel = value;
	}

	// uint32_t fYcbcrRange
	private uint fYcbcrRange;
	uint YcbcrRange() {
		return fYcbcrRange;
	}

	void YcbcrRange(uint value) {
		fYcbcrRange = value;
	}

	// uint32_t fXChromaOffset
	private uint fXChromaOffset;
	uint XChromaOffset() {
		return fXChromaOffset;
	}

	void XChromaOffset(uint value) {
		fXChromaOffset = value;
	}

	// uint32_t fYChromaOffset
	private uint fYChromaOffset;
	uint YChromaOffset() {
		return fYChromaOffset;
	}

	void YChromaOffset(uint value) {
		fYChromaOffset = value;
	}

	// uint32_t fChromaFilter
	private uint fChromaFilter;
	uint ChromaFilter() {
		return fChromaFilter;
	}

	void ChromaFilter(uint value) {
		fChromaFilter = value;
	}

	// uint32_t fForceExplicitReconstruction
	private uint fForceExplicitReconstruction;
	uint ForceExplicitReconstruction() {
		return fForceExplicitReconstruction;
	}

	void ForceExplicitReconstruction(uint value) {
		fForceExplicitReconstruction = value;
	}

	// uint32_t fFormatFeatures
	private uint fFormatFeatures;
	uint FormatFeatures() {
		return fFormatFeatures;
	}

	void FormatFeatures(uint value) {
		fFormatFeatures = value;
	}

	// const bool Equals (GrVkYcbcrConversionInfo obj) {
	// 	return fFormat == obj.fFormat && fExternalFormat == obj.fExternalFormat && fYcbcrModel == obj.fYcbcrModel && fYcbcrRange == obj.fYcbcrRange && fXChromaOffset == obj.fXChromaOffset && fYChromaOffset == obj.fYChromaOffset && fChromaFilter == obj.fChromaFilter && fForceExplicitReconstruction == obj.fForceExplicitReconstruction && fFormatFeatures == obj.fFormatFeatures
	// }

	// const override bool Equals (object obj) {
	// 	return obj is GrVkYcbcrConversionInfo f && Equals (f)
	// }

	// static bool operator == (GrVkYcbcrConversionInfo left, GrVkYcbcrConversionInfo right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (GrVkYcbcrConversionInfo left, GrVkYcbcrConversionInfo right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fFormat);
	// 	hash.Add (fExternalFormat);
	// 	hash.Add (fYcbcrModel);
	// 	hash.Add (fYcbcrRange);
	// 	hash.Add (fXChromaOffset);
	// 	hash.Add (fYChromaOffset);
	// 	hash.Add (fChromaFilter);
	// 	hash.Add (fForceExplicitReconstruction);
	// 	hash.Add (fFormatFeatures);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_codec_frameinfo_t = SKCodecFrameInfo;

struct SKCodecFrameInfo {
	// int fRequiredFrame
	private int fRequiredFrame;
	int RequiredFrame() {
		return fRequiredFrame;
	}

	void RequiredFrame(int value) {
		fRequiredFrame = value;
	}

	// int fDuration
	private int fDuration;
	int Duration() {
		return fDuration;
	}

	void Duration(int value) {
		fDuration = value;
	}

	// bool fFullyReceived
	private ubyte fFullyReceived;
	bool FullyRecieved() {
		return fFullyReceived > 0;
    }
    
	void FullyRecieved(bool value) {
		fFullyReceived = value ? cast(byte)1 : cast(byte)0;
	}

	// sk_alphatype_t fAlphaType
	private SKAlphaType fAlphaType;
	SKAlphaType AlphaType() {
		return fAlphaType;
	}

	void AlphaType(SKAlphaType value) {
		fAlphaType = value;
	}

	// sk_codecanimation_disposalmethod_t fDisposalMethod
	private SKCodecAnimationDisposalMethod fDisposalMethod;
	SKCodecAnimationDisposalMethod DisposalMethod() {
		return fDisposalMethod;
	}

	void DisposalMethod(SKCodecAnimationDisposalMethod value) {
		fDisposalMethod = value;
	}

	// const bool Equals (SKCodecFrameInfo obj) {
	// 	return fRequiredFrame == obj.fRequiredFrame && fDuration == obj.fDuration && fFullyReceived == obj.fFullyReceived && fAlphaType == obj.fAlphaType && fDisposalMethod == obj.fDisposalMethod
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKCodecFrameInfo f && Equals (f)
	// }

	// static bool operator == (SKCodecFrameInfo left, SKCodecFrameInfo right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKCodecFrameInfo left, SKCodecFrameInfo right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fRequiredFrame);
	// 	hash.Add (fDuration);
	// 	hash.Add (fFullyReceived);
	// 	hash.Add (fAlphaType);
	// 	hash.Add (fDisposalMethod);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_codec_options_t = SKCodecOptionsInternal;

struct SKCodecOptionsInternal {
	// sk_codec_zero_initialized_t fZeroInitialized
	SKZeroInitialized fZeroInitialized;

	// sk_irect_t* fSubset
	SKRectI* fSubset;

	// int fFrameIndex
	int fFrameIndex;

	// int fPriorFrame
	int fPriorFrame;

	// const bool Equals (SKCodecOptionsInternal obj) {
	// 	return fZeroInitialized == obj.fZeroInitialized && fSubset == obj.fSubset && fFrameIndex == obj.fFrameIndex && fPriorFrame == obj.fPriorFrame
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKCodecOptionsInternal f && Equals (f)
	// }

	// static bool operator == (SKCodecOptionsInternal left, SKCodecOptionsInternal right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKCodecOptionsInternal left, SKCodecOptionsInternal right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fZeroInitialized);
	// 	hash.Add (fSubset);
	// 	hash.Add (fFrameIndex);
	// 	hash.Add (fPriorFrame);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_color4f_t = SKColorF;

// struct SKColorF {
// 	// float fR
// 	private const float fR;
// 	const float Red() {
//         return fR;
//     }

// 	// float fG
// 	private const float fG;
// 	const float Green() { 
//         return fG;
//     }

// 	// float fB
// 	private const float fB;
// 	const float Blue() {
//         return fB;
//     }

// 	// float fA
// 	private const float fA;
// 	const float Alpha() {
//         return fA;
//     }

// 	// const bool Equals (SKColorF obj) {
// 	// 	return fR == obj.fR && fG == obj.fG && fB == obj.fB && fA == obj.fA
// 	// }

// 	// const override bool Equals (object obj) {
// 	// 	return obj is SKColorF f && Equals (f)
// 	// }

// 	// static bool operator == (SKColorF left, SKColorF right) {
// 	// 	return left.Equals (right)
// 	// }

// 	// static bool operator != (SKColorF left, SKColorF right) {
// 	// 	return !left.Equals (right)
// 	// }

// 	// const override int GetHashCode ()
// 	// {
// 	// 	var hash = new HashCode ();
// 	// 	hash.Add (fR);
// 	// 	hash.Add (fG);
// 	// 	hash.Add (fB);
// 	// 	hash.Add (fA);
// 	// 	return hash.ToHashCode ();
// 	// }

// }


alias sk_colorspace_primaries_t = SKColorSpacePrimaries;

struct SKColorSpacePrimaries {
	// float fRX
	private float fRX;
	float RX() {
		return fRX;
	}

	void RX(float value) {
		fRX = value;
	}

	// float fRY
	private float fRY;
	float RY() {
		return fRY;
	}

	void RY(float value) {
		fRY = value;
	}

	// float fGX
	private float fGX;
	float GX() {
		return fGX;
	}

	void GX(float value) {
		fGX = value;
	}

	// float fGY
	private float fGY;
	float GY() {
		return fGY;
	}

	void GY(float value) {
		fGY = value;
	}

	// float fBX
	private float fBX;
	float BX() {
		return fBX;
	}

	void BX(float value) {
		fBX = value;
	}

	// float fBY
	private float fBY;
	float BY() {
		return fBY;
	}

	void BY(float value) {
		fBY = value;
	}

	// float fWX
	private float fWX;
	float WX() {
		return fWX;
	}

	void WX(float value) {
		fWX = value;
	}

	// float fWY
	private float fWY;
	float WY() {
		return fWY;
	}

	void WY(float value) {
		fWY = value;
	}

	// const bool Equals (SKColorSpacePrimaries obj) {
	// 	return fRX == obj.fRX && fRY == obj.fRY && fGX == obj.fGX && fGY == obj.fGY && fBX == obj.fBX && fBY == obj.fBY && fWX == obj.fWX && fWY == obj.fWY
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKColorSpacePrimaries f && Equals (f)
	// }

	// static bool operator == (SKColorSpacePrimaries left, SKColorSpacePrimaries right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKColorSpacePrimaries left, SKColorSpacePrimaries right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fRX);
	// 	hash.Add (fRY);
	// 	hash.Add (fGX);
	// 	hash.Add (fGY);
	// 	hash.Add (fBX);
	// 	hash.Add (fBY);
	// 	hash.Add (fWX);
	// 	hash.Add (fWY);
	// 	return hash.ToHashCode ();
	// }

  static  SKColorSpacePrimaries Empty;

	this (float[] values)
	{
		if (values is null)
			throw new ArgumentNullException (values.stringof);
		if (values.length != 8)
			throw new ArgumentException ("The values must have exactly 8 items, one for each of [RX, RY, GX, GY, BX, BY, WX, WY].", values.stringof);

		fRX = values[0];
		fRY = values[1];
		fGX = values[2];
		fGY = values[3];
		fBX = values[4];
		fBY = values[5];
		fWX = values[6];
		fWY = values[7];
	}

	this (float rx, float ry, float gx, float gy, float bx, float by, float wx, float wy)
	{
		fRX = rx;
		fRY = ry;
		fGX = gx;
		fGY = gy;
		fBX = bx;
		fBY = by;
		fWX = wx;
		fWY = wy;
	}

	// const float[] Values()
  // {
  //   return new[] { fRX, fRY, fGX, fGY, fBX, fBY, fWX, fWY };
  // }

	SKMatrix44 ToXyzD50 ()
  {
    return ToMatrix44 ();
  }

	bool ToXyzD50 (SKMatrix44 toXyzD50)
	{
		if (toXyzD50 is null)
			throw new ArgumentNullException (toXyzD50.stringof);

		SKMatrix44 xyz = ToMatrix44 ();
		if (xyz !is null)
			toXyzD50.SetColumnMajor (xyz.ToColumnMajor ());
		return xyz !is null;
	}

	 SKMatrix44 ToMatrix44 ()
  {
    SKMatrix44 toXYZ;
    return ToMatrix44 ( toXYZ) ? toXYZ : null;
  }
	

	 bool ToMatrix44 (ref SKMatrix44 toXyzD50)
	{
      SKColorSpaceXyz xyz;
		if (!ToColorSpaceXyz ( xyz)) {
			toXyzD50 = null;
			return false;
		}

		toXyzD50 = xyz.ToMatrix44 ();
		return true;
	}

	const bool ToColorSpaceXyz (out SKColorSpaceXyz toXyzD50)
	{
		SKColorSpacePrimaries* t = cast(SKColorSpacePrimaries*)&this;
		SKColorSpaceXyz* xyz = &toXyzD50;
		return SkiaApi.sk_colorspace_primaries_to_xyzd50 (t, xyz);
	}

	const SKColorSpaceXyz ToColorSpaceXyz ()
  {
    SKColorSpaceXyz toXYZ;
    return 	ToColorSpaceXyz (toXYZ) ? toXYZ : SKColorSpaceXyz.Empty;
  }

}


alias sk_colorspace_transfer_fn_t = SKColorSpaceTransferFn;


struct SKColorSpaceTransferFn {
    // float fG
    private float fG;
    float G() {
        return fG;
    }

    void G(float value) {
        fG = value;
    }

    // float fA
    private float fA;
    float A() {
        return fA;
    }

    void A(float value) {
        fA = value;
    }

    // float fB
    private float fB;
    float B() {
        return fB;
    }

    void B(float value) {
        fB = value;
    }

    // float fC
    private float fC;
    float C() {
        return fC;
    }

    void C(float value) {
        fC = value;
    }

    // float fD
    private float fD;
    float D() {
        return fD;
    }

    void D(float value) {
        fD = value;
    }

    // float fE
    private float fE;
    float E() {
        return fE;
    }

    void E(float value) {
        fE = value;
    }

    // float fF
    private float fF;
    float F() {
        return fF;
    }

    void F(float value) {
        fF = value;
    }

    // const bool Equals (SKColorSpaceTransferFn obj) {
    // 	return fG == obj.fG && fA == obj.fA && fB == obj.fB && fC == obj.fC && fD == obj.fD && fE == obj.fE && fF == obj.fF
    // }

    // const override bool Equals (object obj) {
    // 	return obj is SKColorSpaceTransferFn f && Equals (f)
    // }

    // static bool operator == (SKColorSpaceTransferFn left, SKColorSpaceTransferFn right) {
    // 	return left.Equals (right)
    // }

    // static bool operator != (SKColorSpaceTransferFn left, SKColorSpaceTransferFn right) {
    // 	return !left.Equals (right)
    // }

    // const override int GetHashCode ()
    // {
    // 	var hash = new HashCode ();
    // 	hash.Add (fG);
    // 	hash.Add (fA);
    // 	hash.Add (fB);
    // 	hash.Add (fC);
    // 	hash.Add (fD);
    // 	hash.Add (fE);
    // 	hash.Add (fF);
    // 	return hash.ToHashCode ();
    // }

    static SKColorSpaceTransferFn Srgb() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_srgb(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn TwoDotTwo() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_2dot2(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn Linear() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_linear(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn Rec2020() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_rec2020(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn Pq() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_pq(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn Hlg() {
        SKColorSpaceTransferFn fn;
        SkiaApi.sk_colorspace_transfer_fn_named_hlg(&fn);
        return fn;
    }

    static SKColorSpaceTransferFn Empty;

    this(float[] values) {
        if (values is null)
            throw new ArgumentNullException(values.stringof);
        if (values.length != 7)
            throw new ArgumentException("The values must have exactly 7 items, one for each of [G, A, B, C, D, E, F].",
                    values.stringof);

        fG = values[0];
        fA = values[1];
        fB = values[2];
        fC = values[3];
        fD = values[4];
        fE = values[5];
        fF = values[6];
    }

    this(float g, float a, float b, float c, float d, float e, float f) {
        fG = g;
        fA = a;
        fB = b;
        fC = c;
        fD = d;
        fE = e;
        fF = f;
    }

    // const float[] Values()
    // {
    //   return new[] { fG, fA, fB, fC, fD, fE, fF };
    // }

    SKColorSpaceTransferFn Invert() {
        SKColorSpaceTransferFn inverted;
        SKColorSpaceTransferFn* t = &this;
        SkiaApi.sk_colorspace_transfer_fn_invert(t, &inverted);
        return inverted;
    }

    float Transform(float x) {
        SKColorSpaceTransferFn* t = &this;
        return SkiaApi.sk_colorspace_transfer_fn_eval(t, x);
    }

}

alias sk_colorspace_xyz_t = SKColorSpaceXyz;

struct SKColorSpaceXyz
{
	static SKColorSpaceXyz Srgb()
  {
			SKColorSpaceXyz xyz;
			SkiaApi.sk_colorspace_xyz_named_srgb (&xyz);
			return xyz;
	}

	static SKColorSpaceXyz AdobeRgb() 
  {
			SKColorSpaceXyz xyz;
			SkiaApi.sk_colorspace_xyz_named_adobe_rgb (&xyz);
			return xyz;
	}

	static SKColorSpaceXyz Dcip3() 
  {
			SKColorSpaceXyz xyz;
			SkiaApi.sk_colorspace_xyz_named_dcip3 (&xyz);
			return xyz;
	}

	static SKColorSpaceXyz Rec2020 ()
  {
			SKColorSpaceXyz xyz;
			SkiaApi.sk_colorspace_xyz_named_rec2020 (&xyz);
			return xyz;
	}

	static SKColorSpaceXyz Xyz ()
  {
			SKColorSpaceXyz xyz;
			SkiaApi.sk_colorspace_xyz_named_xyz (&xyz);
			return xyz;
	}

	enum SKColorSpaceXyz Empty = SKColorSpaceXyz();

	this (float value)
	{
		fM00 = value;
		fM01 = value;
		fM02 = value;

		fM10 = value;
		fM11 = value;
		fM12 = value;

		fM20 = value;
		fM21 = value;
		fM22 = value;
	}

	this (float[] values)
	{
		if (values is null)
			throw new ArgumentNullException (values.stringof);
		if (values.length != 9)
			throw new ArgumentException ("The matrix array must have a length of 9.", values.stringof);

		fM00 = values[0];
		fM01 = values[1];
		fM02 = values[2];

		fM10 = values[3];
		fM11 = values[4];
		fM12 = values[5];

		fM20 = values[6];
		fM21 = values[7];
		fM22 = values[8];
	}

	this (
		float m00, float m01, float m02,
		float m10, float m11, float m12,
		float m20, float m21, float m22)
	{
		fM00 = m00;
		fM01 = m01;
		fM02 = m02;

		fM10 = m10;
		fM11 = m11;
		fM12 = m12;

		fM20 = m20;
		fM21 = m21;
		fM22 = m22;
	}

	float[] Values() {
		 return [
			fM00, fM01, fM02,
			fM10, fM11, fM12,
			fM20, fM21, fM22,
     ];
	}

  void Values(float[] value) {
	
			if (value.length != 9)
				throw new ArgumentException ("The matrix array must have a length of 9.", value.stringof);

			fM00 = value[0];
			fM01 = value[1];
			fM02 = value[2];

			fM10 = value[3];
			fM11 = value[4];
			fM12 = value[5];

			fM20 = value[6];
			fM21 = value[7];
			fM22 = value[8];
		
	}

	// const float this[int x, int y] {
	// 		if (x < 0 || x >= 3)
	// 			throw new ArgumentOutOfRangeException (x.stringof);
	// 		if (y < 0 || y >= 3)
	// 			throw new ArgumentOutOfRangeException (y.stringof);

	// 		auto idx = x + (y * 3);
	// 		switch(idx)
	// 		{
	// 			case 0:return fM00;
	// 			case 1:return fM01;
	// 			case 2:return fM02;
	// 			case 3:return fM10;
	// 			case 4:return fM11;
	// 			case 5:return fM12;
	// 			case 6:return fM20;
	// 			case 7:return fM21;
	// 			case 8:return fM22;
	// 			default:
	// 			return throw new ArgumentOutOfRangeException ("index");
	// 		}
	// }

	const SKColorSpaceXyz Invert ()
	{
		SKColorSpaceXyz inverted;
		SKColorSpaceXyz* t = cast(SKColorSpaceXyz*)&this;
		SkiaApi.sk_colorspace_xyz_invert (t, &inverted);
		return inverted;
	}

	static SKColorSpaceXyz Concat (SKColorSpaceXyz a, SKColorSpaceXyz b)
	{
		SKColorSpaceXyz result;
		SkiaApi.sk_colorspace_xyz_concat (&a, &b, &result);
		return result;
	}

	 SKMatrix44 ToMatrix44 ()
	{
		auto matrix = new SKMatrix44 ();
		matrix.Set3x3RowMajor (Values);
		return matrix;
	}

	// float fM00
	private float fM00;

	// float fM01
	private float fM01;

	// float fM02
	private float fM02;

	// float fM10
	private float fM10;

	// float fM11
	private float fM11;

	// float fM12
	private float fM12;

	// float fM20
	private float fM20;

	// float fM21
	private float fM21;

	// float fM22
	private float fM22;

	// const bool Equals (SKColorSpaceXyz obj) {
	// 	return fM00 == obj.fM00 && fM01 == obj.fM01 && fM02 == obj.fM02 && fM10 == obj.fM10 && fM11 == obj.fM11 && fM12 == obj.fM12 && fM20 == obj.fM20 && fM21 == obj.fM21 && fM22 == obj.fM22
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKColorSpaceXyz f && Equals (f)
	// }

	// static bool operator == (SKColorSpaceXyz left, SKColorSpaceXyz right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKColorSpaceXyz left, SKColorSpaceXyz right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fM00);
	// 	hash.Add (fM01);
	// 	hash.Add (fM02);
	// 	hash.Add (fM10);
	// 	hash.Add (fM11);
	// 	hash.Add (fM12);
	// 	hash.Add (fM20);
	// 	hash.Add (fM21);
	// 	hash.Add (fM22);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_document_pdf_metadata_t = SKDocumentPdfMetadataInternal;

struct SKDocumentPdfMetadataInternal {
	// sk_string_t* fTitle
	sk_string_t* fTitle;

	// sk_string_t* fAuthor
	sk_string_t* fAuthor;

	// sk_string_t* fSubject
	sk_string_t* fSubject;

	// sk_string_t* fKeywords
	sk_string_t* fKeywords;

	// sk_string_t* fCreator
	sk_string_t* fCreator;

	// sk_string_t* fProducer
	sk_string_t* fProducer;

	// sk_time_datetime_t* fCreation
	SKTimeDateTimeInternal* fCreation;

	// sk_time_datetime_t* fModified
	SKTimeDateTimeInternal* fModified;

	// float fRasterDPI
	float fRasterDPI;

	// bool fPDFA
	ubyte fPDFA;

	// int fEncodingQuality
	int fEncodingQuality;

	// const bool Equals (SKDocumentPdfMetadataInternal obj) {
	// 	return fTitle == obj.fTitle && fAuthor == obj.fAuthor && fSubject == obj.fSubject && fKeywords == obj.fKeywords && fCreator == obj.fCreator && fProducer == obj.fProducer && fCreation == obj.fCreation && fModified == obj.fModified && fRasterDPI == obj.fRasterDPI && fPDFA == obj.fPDFA && fEncodingQuality == obj.fEncodingQuality
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKDocumentPdfMetadataInternal f && Equals (f)
	// }

	// static bool operator == (SKDocumentPdfMetadataInternal left, SKDocumentPdfMetadataInternal right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKDocumentPdfMetadataInternal left, SKDocumentPdfMetadataInternal right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fTitle);
	// 	hash.Add (fAuthor);
	// 	hash.Add (fSubject);
	// 	hash.Add (fKeywords);
	// 	hash.Add (fCreator);
	// 	hash.Add (fProducer);
	// 	hash.Add (fCreation);
	// 	hash.Add (fModified);
	// 	hash.Add (fRasterDPI);
	// 	hash.Add (fPDFA);
	// 	hash.Add (fEncodingQuality);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_fontmetrics_t = SKFontMetrics;

struct SKFontMetrics {
	// uint32_t fFlags
	private uint fFlags;

	// float fTop
	private float fTop;

	// float fAscent
	private float fAscent;

	// float fDescent
	private float fDescent;

	// float fBottom
	private float fBottom;

	// float fLeading
	private float fLeading;

	// float fAvgCharWidth
	private float fAvgCharWidth;

	// float fMaxCharWidth
	private float fMaxCharWidth;

	// float fXMin
	private float fXMin;

	// float fXMax
	private float fXMax;

	// float fXHeight
	private float fXHeight;

	// float fCapHeight
	private float fCapHeight;

	// float fUnderlineThickness
	private float fUnderlineThickness;

	// float fUnderlinePosition
	private float fUnderlinePosition;

	// float fStrikeoutThickness
	private float fStrikeoutThickness;

	// float fStrikeoutPosition
	private float fStrikeoutPosition;

	// const bool Equals (SKFontMetrics obj) {
	// 	return fFlags == obj.fFlags && fTop == obj.fTop && fAscent == obj.fAscent && fDescent == obj.fDescent && fBottom == obj.fBottom && fLeading == obj.fLeading && fAvgCharWidth == obj.fAvgCharWidth && fMaxCharWidth == obj.fMaxCharWidth && fXMin == obj.fXMin && fXMax == obj.fXMax && fXHeight == obj.fXHeight && fCapHeight == obj.fCapHeight && fUnderlineThickness == obj.fUnderlineThickness && fUnderlinePosition == obj.fUnderlinePosition && fStrikeoutThickness == obj.fStrikeoutThickness && fStrikeoutPosition == obj.fStrikeoutPosition
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKFontMetrics f && Equals (f)
	// }

	// static bool operator == (SKFontMetrics left, SKFontMetrics right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKFontMetrics left, SKFontMetrics right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fFlags);
	// 	hash.Add (fTop);
	// 	hash.Add (fAscent);
	// 	hash.Add (fDescent);
	// 	hash.Add (fBottom);
	// 	hash.Add (fLeading);
	// 	hash.Add (fAvgCharWidth);
	// 	hash.Add (fMaxCharWidth);
	// 	hash.Add (fXMin);
	// 	hash.Add (fXMax);
	// 	hash.Add (fXHeight);
	// 	hash.Add (fCapHeight);
	// 	hash.Add (fUnderlineThickness);
	// 	hash.Add (fUnderlinePosition);
	// 	hash.Add (fStrikeoutThickness);
	// 	hash.Add (fStrikeoutPosition);
	// 	return hash.ToHashCode ();
	// }

	private enum uint flagsUnderlineThicknessIsValid = (1U << 0);
	private enum uint flagsUnderlinePositionIsValid = (1U << 1);
	private enum uint flagsStrikeoutThicknessIsValid = (1U << 2);
	private enum uint flagsStrikeoutPositionIsValid = (1U << 3);

	float Top() { return fTop; }

	float Ascent() { return fAscent; }

	float Descent() { return fDescent; }

	float Bottom() { return fBottom; }

	float Leading() { return fLeading; }

	float AverageCharacterWidth() { return fAvgCharWidth; }

	float MaxCharacterWidth() { return fMaxCharWidth; }

	float XMin() { return fXMin; }

	float XMax() { return fXMax; }

	float XHeight() { return fXHeight; }

	float CapHeight() { return fCapHeight; }

	Nullable!float UnderlineThickness() { return GetIfValid (fUnderlineThickness, flagsUnderlineThicknessIsValid); }
	Nullable!float UnderlinePosition() { return GetIfValid (fUnderlinePosition, flagsUnderlinePositionIsValid); }
	Nullable!float StrikeoutThickness() { return GetIfValid (fStrikeoutThickness, flagsStrikeoutThicknessIsValid); }
	Nullable!float StrikeoutPosition() { return GetIfValid (fStrikeoutPosition, flagsStrikeoutPositionIsValid); }

	private Nullable!float GetIfValid (float value, uint flag) 
	{
		return (fFlags & flag) == flag ? NullableFloat(value) : NullableFloat.init;
	}
}


alias sk_highcontrastconfig_t = SKHighContrastConfig;

struct SKHighContrastConfig {
    enum SKHighContrastConfig Default = SKHighContrastConfig (false, SKHighContrastConfigInvertStyle.NoInvert, 0.0f);

	// bool fGrayscale
	private ubyte fGrayscale;
	bool Grayscale() {
		return fGrayscale > 0;
	}

	void Grayscale(bool value) {
        fGrayscale = value ? cast(byte)1 : cast(byte)0;
	}

	// sk_highcontrastconfig_invertstyle_t fInvertStyle
	private SKHighContrastConfigInvertStyle fInvertStyle;
	SKHighContrastConfigInvertStyle InvertStyle() {
		return fInvertStyle;
	}

	void InvertStyle(SKHighContrastConfigInvertStyle value) {
		fInvertStyle = value;
	}

	// float fContrast
	private float fContrast;
	float Contrast() {
		return fContrast;
	}

	void Contrast(float value) {
		fContrast = value;
	}

	// const bool Equals (SKHighContrastConfig obj) {
	// 	return fGrayscale == obj.fGrayscale && fInvertStyle == obj.fInvertStyle && fContrast == obj.fContrast
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKHighContrastConfig f && Equals (f)
	// }

	// static bool operator == (SKHighContrastConfig left, SKHighContrastConfig right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKHighContrastConfig left, SKHighContrastConfig right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fGrayscale);
	// 	hash.Add (fInvertStyle);
	// 	hash.Add (fContrast);
	// 	return hash.ToHashCode ();
	// }

	this (bool grayscale, SKHighContrastConfigInvertStyle invertStyle, float contrast)
	{
		fGrayscale = grayscale ? cast(byte)1 : cast(byte)0;
		fInvertStyle = invertStyle;
		fContrast = contrast;
	}

	bool IsValid()
	{
	    return cast(int)fInvertStyle >= cast(int)SKHighContrastConfigInvertStyle.NoInvert &&
            cast(int)fInvertStyle <= cast(int)SKHighContrastConfigInvertStyle.InvertLightness &&
            fContrast >= -1.0 &&
            fContrast <= 1.0;
	}
}


alias sk_imageinfo_t = SKImageInfoNative;



alias sk_ipoint_t = SKPointI;

alias sk_irect_t = SKRectI;

alias sk_isize_t = SKSizeI;

alias sk_jpegencoder_options_t = SKJpegEncoderOptions;

struct SKJpegEncoderOptions {

	this (int quality, SKJpegEncoderDownsample downsample, SKJpegEncoderAlphaOption alphaOption)
	{
		fQuality = quality;
		fDownsample = downsample;
		fAlphaOption = alphaOption;
	}

	this (int quality, SKJpegEncoderDownsample downsample, SKJpegEncoderAlphaOption alphaOption, SKTransferFunctionBehavior blendBehavior)
	{
		fQuality = quality;
		fDownsample = downsample;
		fAlphaOption = alphaOption;
	}

	SKTransferFunctionBehavior BlendBehavior() {
		return SKTransferFunctionBehavior.Respect;
	}


	// int fQuality
	private int fQuality;
	int Quality() {
		return fQuality;
	}

	void Quality(int value) {
		fQuality = value;
	}

	// sk_jpegencoder_downsample_t fDownsample
	private SKJpegEncoderDownsample fDownsample;
	SKJpegEncoderDownsample Downsample() {
		return fDownsample;
	}

	void Downsample(SKJpegEncoderDownsample value) {
		fDownsample = value;
	}

	// sk_jpegencoder_alphaoption_t fAlphaOption
	private SKJpegEncoderAlphaOption fAlphaOption;
	SKJpegEncoderAlphaOption AlphaOption() {
		return fAlphaOption;
	}

	void AlphaOption(SKJpegEncoderAlphaOption value) {
		fAlphaOption = value;
	}

	// const bool Equals (SKJpegEncoderOptions obj) {
	// 	return fQuality == obj.fQuality && fDownsample == obj.fDownsample && fAlphaOption == obj.fAlphaOption
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKJpegEncoderOptions f && Equals (f)
	// }

	// static bool operator == (SKJpegEncoderOptions left, SKJpegEncoderOptions right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKJpegEncoderOptions left, SKJpegEncoderOptions right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fQuality);
	// 	hash.Add (fDownsample);
	// 	hash.Add (fAlphaOption);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_lattice_t = SKLatticeInternal;

struct SKLatticeInternal {
    enum SKJpegEncoderOptions Default = SKJpegEncoderOptions (100, SKJpegEncoderDownsample.Downsample420, SKJpegEncoderAlphaOption.Ignore);

	// const int* fXDivs
	int* fXDivs;

	// const int* fYDivs
	int* fYDivs;

	// const sk_lattice_recttype_t* fRectTypes
	SKLatticeRectType* fRectTypes;

	// int fXCount
	int fXCount;

	// int fYCount
	int fYCount;

	// const sk_irect_t* fBounds
	SKRectI* fBounds;

	// const sk_color_t* fColors
	uint* fColors;

	// const bool Equals (SKLatticeInternal obj) {
	// 	return fXDivs == obj.fXDivs && fYDivs == obj.fYDivs && fRectTypes == obj.fRectTypes && fXCount == obj.fXCount && fYCount == obj.fYCount && fBounds == obj.fBounds && fColors == obj.fColors
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKLatticeInternal f && Equals (f)
	// }

	// static bool operator == (SKLatticeInternal left, SKLatticeInternal right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKLatticeInternal left, SKLatticeInternal right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fXDivs);
	// 	hash.Add (fYDivs);
	// 	hash.Add (fRectTypes);
	// 	hash.Add (fXCount);
	// 	hash.Add (fYCount);
	// 	hash.Add (fBounds);
	// 	hash.Add (fColors);
	// 	return hash.ToHashCode ();
	// }
}


alias sk_manageddrawable_procs_t = SKManagedDrawableDelegates;

struct SKManagedDrawableDelegates {
	// sk_manageddrawable_draw_proc fDraw
	SKManagedDrawableDrawProxyDelegate fDraw;

	// sk_manageddrawable_getBounds_proc fGetBounds
	SKManagedDrawableGetBoundsProxyDelegate fGetBounds;

	// sk_manageddrawable_newPictureSnapshot_proc fNewPictureSnapshot
	SKManagedDrawableNewPictureSnapshotProxyDelegate fNewPictureSnapshot;

	// sk_manageddrawable_destroy_proc fDestroy
	SKManagedDrawableDestroyProxyDelegate fDestroy;

	// const bool Equals (SKManagedDrawableDelegates obj) {
	// 	return fDraw == obj.fDraw && fGetBounds == obj.fGetBounds && fNewPictureSnapshot == obj.fNewPictureSnapshot && fDestroy == obj.fDestroy
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKManagedDrawableDelegates f && Equals (f)
	// }

	// static bool operator == (SKManagedDrawableDelegates left, SKManagedDrawableDelegates right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKManagedDrawableDelegates left, SKManagedDrawableDelegates right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fDraw);
	// 	hash.Add (fGetBounds);
	// 	hash.Add (fNewPictureSnapshot);
	// 	hash.Add (fDestroy);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_managedstream_procs_t = SKManagedStreamDelegates;

struct SKManagedStreamDelegates {
	// sk_managedstream_read_proc fRead
	SKManagedStreamReadProxyDelegate fRead;

	// sk_managedstream_peek_proc fPeek
	SKManagedStreamPeekProxyDelegate fPeek;

	// sk_managedstream_isAtEnd_proc fIsAtEnd
	SKManagedStreamIsAtEndProxyDelegate fIsAtEnd;

	// sk_managedstream_hasPosition_proc fHasPosition
	SKManagedStreamHasPositionProxyDelegate fHasPosition;

	// sk_managedstream_hasLength_proc fHasLength
	SKManagedStreamHasLengthProxyDelegate fHasLength;

	// sk_managedstream_rewind_proc fRewind
	SKManagedStreamRewindProxyDelegate fRewind;

	// sk_managedstream_getPosition_proc fGetPosition
	SKManagedStreamGetPositionProxyDelegate fGetPosition;

	// sk_managedstream_seek_proc fSeek
	SKManagedStreamSeekProxyDelegate fSeek;

	// sk_managedstream_move_proc fMove
	SKManagedStreamMoveProxyDelegate fMove;

	// sk_managedstream_getLength_proc fGetLength
	SKManagedStreamGetLengthProxyDelegate fGetLength;

	// sk_managedstream_duplicate_proc fDuplicate
	SKManagedStreamDuplicateProxyDelegate fDuplicate;

	// sk_managedstream_fork_proc fFork
	SKManagedStreamForkProxyDelegate fFork;

	// sk_managedstream_destroy_proc fDestroy
	SKManagedStreamDestroyProxyDelegate fDestroy;

	// const bool Equals (SKManagedStreamDelegates obj) {
	// 	return fRead == obj.fRead && fPeek == obj.fPeek && fIsAtEnd == obj.fIsAtEnd && fHasPosition == obj.fHasPosition && fHasLength == obj.fHasLength && fRewind == obj.fRewind && fGetPosition == obj.fGetPosition && fSeek == obj.fSeek && fMove == obj.fMove && fGetLength == obj.fGetLength && fDuplicate == obj.fDuplicate && fFork == obj.fFork && fDestroy == obj.fDestroy
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKManagedStreamDelegates f && Equals (f)
	// }

	// static bool operator == (SKManagedStreamDelegates left, SKManagedStreamDelegates right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKManagedStreamDelegates left, SKManagedStreamDelegates right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fRead);
	// 	hash.Add (fPeek);
	// 	hash.Add (fIsAtEnd);
	// 	hash.Add (fHasPosition);
	// 	hash.Add (fHasLength);
	// 	hash.Add (fRewind);
	// 	hash.Add (fGetPosition);
	// 	hash.Add (fSeek);
	// 	hash.Add (fMove);
	// 	hash.Add (fGetLength);
	// 	hash.Add (fDuplicate);
	// 	hash.Add (fFork);
	// 	hash.Add (fDestroy);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_managedtracememorydump_procs_t = SKManagedTraceMemoryDumpDelegates;

struct SKManagedTraceMemoryDumpDelegates {
	// sk_managedtraceMemoryDump_dumpNumericValue_proc fDumpNumericValue
	SKManagedTraceMemoryDumpDumpNumericValueProxyDelegate fDumpNumericValue;

	// sk_managedtraceMemoryDump_dumpStringValue_proc fDumpStringValue
	SKManagedTraceMemoryDumpDumpStringValueProxyDelegate fDumpStringValue;

	// const bool Equals (SKManagedTraceMemoryDumpDelegates obj) {
	// 	return fDumpNumericValue == obj.fDumpNumericValue && fDumpStringValue == obj.fDumpStringValue
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKManagedTraceMemoryDumpDelegates f && Equals (f)
	// }

	// static bool operator == (SKManagedTraceMemoryDumpDelegates left, SKManagedTraceMemoryDumpDelegates right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKManagedTraceMemoryDumpDelegates left, SKManagedTraceMemoryDumpDelegates right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fDumpNumericValue);
	// 	hash.Add (fDumpStringValue);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_managedwstream_procs_t = SKManagedWStreamDelegates;

struct SKManagedWStreamDelegates {
	// sk_managedwstream_write_proc fWrite
	SKManagedWStreamWriteProxyDelegate fWrite;

	// sk_managedwstream_flush_proc fFlush
	SKManagedWStreamFlushProxyDelegate fFlush;

	// sk_managedwstream_bytesWritten_proc fBytesWritten
	SKManagedWStreamBytesWrittenProxyDelegate fBytesWritten;

	// sk_managedwstream_destroy_proc fDestroy
	SKManagedWStreamDestroyProxyDelegate fDestroy;

	// const bool Equals (SKManagedWStreamDelegates obj) {
	// 	return fWrite == obj.fWrite && fFlush == obj.fFlush && fBytesWritten == obj.fBytesWritten && fDestroy == obj.fDestroy
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKManagedWStreamDelegates f && Equals (f)
	// }

	// static bool operator == (SKManagedWStreamDelegates left, SKManagedWStreamDelegates right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKManagedWStreamDelegates left, SKManagedWStreamDelegates right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fWrite);
	// 	hash.Add (fFlush);
	// 	hash.Add (fBytesWritten);
	// 	hash.Add (fDestroy);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_mask_t = SKMask;

// struct SKMask {
	// uint8_t* fImage
	// private ubyte* fImage;

	// // sk_irect_t fBounds
	// private SKRectI fBounds;

	// // uint32_t fRowBytes
	// private uint fRowBytes;

	// // sk_mask_format_t fFormat
	// private SKMaskFormat fFormat;

	// const bool Equals (SKMask obj) {
	// 	return fImage == obj.fImage && fBounds == obj.fBounds && fRowBytes == obj.fRowBytes && fFormat == obj.fFormat
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKMask f && Equals (f)
	// }

	// static bool operator == (SKMask left, SKMask right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKMask left, SKMask right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fImage);
	// 	hash.Add (fBounds);
	// 	hash.Add (fRowBytes);
	// 	hash.Add (fFormat);
	// 	return hash.ToHashCode ();
	// }

// }


alias sk_matrix_t = SKMatrix;



alias sk_pngencoder_options_t = SKPngEncoderOptions;

/**
 * 
 */
struct SKPngEncoderOptions {
    enum SKPngEncoderOptions Default = SKPngEncoderOptions (SKPngEncoderFilterFlags.AllFilters, 6);

	// sk_pngencoder_filterflags_t fFilterFlags
	private SKPngEncoderFilterFlags fFilterFlags;

	// int fZLibLevel
	private int fZLibLevel;

	// void* fComments
	private void* fComments;

	// const bool Equals (SKPngEncoderOptions obj) {
	// 	return fFilterFlags == obj.fFilterFlags && fZLibLevel == obj.fZLibLevel && fComments == obj.fComments
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKPngEncoderOptions f && Equals (f)
	// }

	// static bool operator == (SKPngEncoderOptions left, SKPngEncoderOptions right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKPngEncoderOptions left, SKPngEncoderOptions right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fFilterFlags);
	// 	hash.Add (fZLibLevel);
	// 	hash.Add (fComments);
	// 	return hash.ToHashCode ();
	// }


	this (SKPngEncoderFilterFlags filterFlags, int zLibLevel)
	{
		fFilterFlags = filterFlags;
		fZLibLevel = zLibLevel;
		fComments = null;
	}

	this (SKPngEncoderFilterFlags filterFlags, int zLibLevel, SKTransferFunctionBehavior unpremulBehavior)
	{
		fFilterFlags = filterFlags;
		fZLibLevel = zLibLevel;
		fComments = null;
	}

	SKPngEncoderFilterFlags FilterFlags() {
		return fFilterFlags;
    }

    void FilterFlags(SKPngEncoderFilterFlags value) {
		fFilterFlags = value;
	}
	
	int ZLibLevel() {
		return fZLibLevel;
	}

    void ZLibLevel(int value) {
        fZLibLevel = value;
    }

	SKTransferFunctionBehavior UnpremulBehavior() {
		return SKTransferFunctionBehavior.Respect;
	}
}


alias sk_point_t = SKPoint;
alias sk_vector_t = SKPoint;



alias sk_point3_t = SKPoint3;


alias sk_rect_t = SKRect;

alias sk_rsxform_t = SKRotationScaleMatrix;

struct SKRotationScaleMatrix {
	// float fSCos
	private float fSCos;
	float SCos() {
		return fSCos;
	}

	void SCos(float value) {
		fSCos = value;
	}

	// float fSSin
	private float fSSin;
	float SSin() {
		return fSSin;
	}

	void SSin(float value) {
		fSSin = value;
	}

	// float fTX
	private float fTX;
	float TX() {
		return fTX;
	}

	void TX(float value) {
		fTX = value;
	}

	// float fTY
	private float fTY;
	float TY() {
		return fTY;
	}

	void TY(float value) {
		fTY = value;
	}

	// const bool Equals (SKRotationScaleMatrix obj) {
	// 	return fSCos == obj.fSCos && fSSin == obj.fSSin && fTX == obj.fTX && fTY == obj.fTY
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKRotationScaleMatrix f && Equals (f)
	// }

	// static bool operator == (SKRotationScaleMatrix left, SKRotationScaleMatrix right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKRotationScaleMatrix left, SKRotationScaleMatrix right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fSCos);
	// 	hash.Add (fSSin);
	// 	hash.Add (fTX);
	// 	hash.Add (fTY);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_size_t = SKSize;

alias sk_textblob_builder_runbuffer_t = SKRunBufferInternal;

struct SKRunBufferInternal {
	// void* glyphs
	void* glyphs;

	// void* pos
	void* pos;

	// void* utf8text
	void* utf8text;

	// void* clusters
	void* clusters;

	// const bool Equals (SKRunBufferInternal obj) {
	// 	return glyphs == obj.glyphs && pos == obj.pos && utf8text == obj.utf8text && clusters == obj.clusters
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKRunBufferInternal f && Equals (f)
	// }

	// static bool operator == (SKRunBufferInternal left, SKRunBufferInternal right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKRunBufferInternal left, SKRunBufferInternal right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (glyphs);
	// 	hash.Add (pos);
	// 	hash.Add (utf8text);
	// 	hash.Add (clusters);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_time_datetime_t = SKTimeDateTimeInternal;

struct SKTimeDateTimeInternal {
	// int16_t fTimeZoneMinutes
	short fTimeZoneMinutes;

	// uint16_t fYear
	ushort fYear;

	// uint8_t fMonth
	ubyte fMonth;

	// uint8_t fDayOfWeek
	ubyte fDayOfWeek;

	// uint8_t fDay
	ubyte fDay;

	// uint8_t fHour
	ubyte fHour;

	// uint8_t fMinute
	ubyte fMinute;

	// uint8_t fSecond
	ubyte fSecond;

	static SKTimeDateTimeInternal Create (SysTime datetime)
	{
		long zone = datetime.utcOffset.total!("minutes");

		SKTimeDateTimeInternal internal;

		internal.fTimeZoneMinutes = cast(short)(zone);
		internal.fYear = cast(ushort)datetime.year;
		internal.fMonth = cast(ubyte)datetime.month;
		internal.fDayOfWeek = cast(ubyte)datetime.dayOfWeek;
		internal.fDay = cast(ubyte)datetime.day;
		internal.fHour = cast(ubyte)datetime.hour;
		internal.fMinute = cast(ubyte)datetime.minute;
		internal.fSecond = cast(ubyte)datetime.second;

		return internal;
	}

	// const bool Equals (SKTimeDateTimeInternal obj) {
	// 	return fTimeZoneMinutes == obj.fTimeZoneMinutes && fYear == obj.fYear && fMonth == obj.fMonth && fDayOfWeek == obj.fDayOfWeek && fDay == obj.fDay && fHour == obj.fHour && fMinute == obj.fMinute && fSecond == obj.fSecond
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKTimeDateTimeInternal f && Equals (f)
	// }

	// static bool operator == (SKTimeDateTimeInternal left, SKTimeDateTimeInternal right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKTimeDateTimeInternal left, SKTimeDateTimeInternal right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fTimeZoneMinutes);
	// 	hash.Add (fYear);
	// 	hash.Add (fMonth);
	// 	hash.Add (fDayOfWeek);
	// 	hash.Add (fDay);
	// 	hash.Add (fHour);
	// 	hash.Add (fMinute);
	// 	hash.Add (fSecond);
	// 	return hash.ToHashCode ();
	// }

}


alias sk_webpencoder_options_t = SKWebpEncoderOptions;

struct SKWebpEncoderOptions {
    enum SKWebpEncoderOptions Default = SKWebpEncoderOptions (SKWebpEncoderCompression.Lossy, 100);
	// sk_webpencoder_compression_t fCompression
	private SKWebpEncoderCompression fCompression;
	SKWebpEncoderCompression Compression() {
		return fCompression;
	}

	void Compression(SKWebpEncoderCompression value) {
		fCompression = value;
	}

	// float fQuality
	private float fQuality;
	float Quality() {
		return fQuality;
	}

	void Quality(float value) {
		fQuality = value;
	}

	// const bool Equals (SKWebpEncoderOptions obj) {
	// 	return fCompression == obj.fCompression && fQuality == obj.fQuality
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKWebpEncoderOptions f && Equals (f)
	// }

	// static bool operator == (SKWebpEncoderOptions left, SKWebpEncoderOptions right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKWebpEncoderOptions left, SKWebpEncoderOptions right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fCompression);
	// 	hash.Add (fQuality);
	// 	return hash.ToHashCode ();
	// }

	this (SKWebpEncoderCompression compression, float quality)
	{
		fCompression = compression;
		fQuality = quality;
	}

	this (SKWebpEncoderCompression compression, float quality, SKTransferFunctionBehavior unpremulBehavior)
	{
		fCompression = compression;
		fQuality = quality;
	}

	SKTransferFunctionBehavior UnpremulBehavior() {
		return SKTransferFunctionBehavior.Respect;
	}
}

// #endregion



const(char)*[] toCStrings(string[] values) {

    const(char)*[] result;
    foreach(string str; values) {
        result ~= std.string.toStringz(str);
    }

    return result;
}


sk_color_t sk_color_set_argb(ubyte a, ubyte r, ubyte g, ubyte b)
{
    return (a << 24) | (r << 16) | (g << 8) | b;
}

ubyte sk_color_get_a(sk_color_t c)
{
    return (c >> 24) & 0xFF;
}

ubyte sk_color_get_r(sk_color_t c)
{
    return (c >> 16) & 0xFF;
}

ubyte sk_color_get_g(sk_color_t c)
{
    return (c >> 8) & 0xFF;
}

ubyte sk_color_get_b(sk_color_t c)
{
    return (c >> 0) & 0xFF;
}