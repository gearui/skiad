module test.SKFontTest;

import std.experimental.logger;
import hunt.UnitTest;

import skia;

class SKFontTest {

    @Test void PlainGlyphsReturnsTheCorrectNumberOfCharacters() {
        // enum string text = "Hello World!";
        enum string text = "He";

        SKFont font = new SKFont();

        assert(text.length == font.CountGlyphs(text));
        assert(text.length == font.GetGlyphs(text).length);

    }

    @Test void TextInterceptsAreFoundCorrectly() {
        string text = "123";
        // string text = "|";

        SKFont font = new SKFont();
        font.Size = 100;

        SKTextBlob blob = SKTextBlob.Create(text, font, SKPoint(50, 100));

        float[] widths = blob.GetIntercepts(0, 100);
        tracef("widths: %s", widths);
        //Assert.Equal(6, widths.Length);

        float diff = widths[1] - widths[0];

        SKPath textPath = font.GetTextPath(text, SKPoint.Empty);
        float pathWidth = textPath.TightBounds.Width;
        tracef("pathWidth: %s", pathWidth);
        SKRect rect = textPath.Bounds();
        info(rect.ToString());

        //Assert.Equal(pathWidth, diff, 2);
    }

}
