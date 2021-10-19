import core.stdc.stdio;
import core.stdc.stdlib;

import skia.Definitions;
import skia.SkiaApi;
import std.experimental.logger;

/**
 * dub build -c=binding
 */

void main()
{
	sk_surface_t* surface = make_surface(640, 480);
    sk_canvas_t* canvas = sk_surface_get_canvas(surface);
    draw(canvas);
    emit_png("binding-example.png", surface);
    sk_surface_unref(surface);

    info("Done. Check the binding-example.png, please!");
}


//
// See_also:
//  https://github.com/mono/skia/blob/master/experimental/c-api-example/c.md
// 
sk_surface_t* make_surface(int32_t w, int32_t h) {
    sk_imageinfo_t info;
    info.width = w;
    info.height = h;
    info.colorType = sk_colortype_get_default_8888();
    info.alphaType = SKAlphaType.Opaque;
    return sk_surface_new_raster(&info, 0, cast(sk_surfaceprops_t*)null);
}

void emit_png(const char* path, sk_surface_t* surface) {
    sk_image_t* image = sk_surface_new_image_snapshot(surface);
    sk_data_t* data = sk_image_encode(image);
    sk_image_unref(image);
    FILE* f = fopen(path, "wb");
    fwrite(sk_data_get_data(data), sk_data_get_size(data), 1, f);
    fclose(f);
    sk_data_unref(data);
}

void draw(sk_canvas_t* canvas) {
    sk_paint_t* fill = sk_paint_new();
    sk_paint_set_color(fill, sk_color_set_argb(0xFF, 0x00, 0x00, 0xFF));
    sk_canvas_draw_paint(canvas, fill);

    sk_paint_set_color(fill, sk_color_set_argb(0xFF, 0x00, 0xFF, 0xFF));
    sk_rect_t rect;
    rect.Left = 100.0f;
    rect.Top = 100.0f;
    rect.Right = 540.0f;
    rect.Bottom = 380.0f;
    sk_canvas_draw_rect(canvas, &rect, fill);

    sk_paint_t* stroke = sk_paint_new();
    sk_paint_set_color(stroke, sk_color_set_argb(0xFF, 0xFF, 0x00, 0x00));
    sk_paint_set_antialias(stroke, true);
    //sk_paint_set_stroke(stroke, true);
    sk_paint_set_stroke_width(stroke, 5.0f);
    sk_path_t* path = sk_path_new();

    sk_path_move_to(path, 50.0f, 50.0f);
    sk_path_line_to(path, 590.0f, 50.0f);
    sk_path_cubic_to(path, -490.0f, 50.0f, 1130.0f, 430.0f, 50.0f, 430.0f);
    sk_path_line_to(path, 590.0f, 430.0f);
    sk_canvas_draw_path(canvas, path, stroke);

    sk_paint_set_color(fill, sk_color_set_argb(0x80, 0x00, 0xFF, 0x00));
    sk_rect_t rect2;
    rect2.Left = 120.0f;
    rect2.Top = 120.0f;
    rect2.Right = 520.0f;
    rect2.Bottom = 360.0f;
    sk_canvas_draw_oval(canvas, &rect2, fill);

    sk_path_delete(path);
    sk_paint_delete(stroke);
    sk_paint_delete(fill);
}