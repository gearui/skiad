import skia;
import std.experimental.logger;

import std.stdio;
import std.path;

/**
 * dub build -c=skia
 */
void main() {
    // crate a surface
    SKImageInfo info = SKImageInfo(256, 256);

    SKSurface surface = SKSurface.Create(info);
    scope (exit) {
        surface.Dispose();
    }

    SKTypeface tf = null;
    version(Windows) {
        string pathToFonts = `C:\Windows\Fonts`;
        string font = buildPath(pathToFonts, "simsun.ttc");
        // string font = buildPath(pathToFonts, "STHUPO.TTF");
        tf = SKTypeface.FromFile(font);
    } else version(OSX) {
        string pathToFonts = `/System/Library/Fonts`;
        string font = buildPath(pathToFonts, "Hiragino Sans GB.ttc");
        tf = SKTypeface.FromFile(font);
    }

    // the the canvas and properties
    SKCanvas canvas = surface.Canvas;

    // make sure the canvas is blank
    canvas.Clear(SKColors.White);

    // draw some text
    SKPaint paint = new SKPaint();
    paint.Typeface = tf;
    paint.Color = SKColors.Black;
    paint.IsAntialias = true;
    paint.Style = SKPaintStyle.Fill;
    paint.TextAlign = SKTextAlign.Center;
    paint.TextSize = 24;

    SKPoint coord = SKPoint(info.Width / 2, (info.Height + paint.TextSize) / 2);
    canvas.DrawText("SkiaSharp中文", coord, paint);

    // save the file
    SKImage image = surface.Snapshot();
    scope (exit) {
        image.Dispose();
    }

    SKData data = image.Encode(SKEncodedImageFormat.Png, 100);
    scope (exit) {
        data.Dispose();
    }

    File f = File("output.png", "w");
    scope (exit) {
        f.close();
    }

    data.SaveTo((const(ubyte)[] d) { f.rawWrite(d); });
}
