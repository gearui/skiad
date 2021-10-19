module skia.SKTypeface;

import skia.SKObject;
import skia.SKFont;
import skia.SkiaApi;
import skia.SKFontStyle;
import skia.Definitions;
import skia.SKStream;
import skia.SKData;
import skia.Exceptions;
import skia.SKFontManager;
import skia.SKString;
import skia.Util;

import std.concurrency : initOnce;

enum SKTypefaceStyle
{
	Normal = 0,
	Bold = 0x01,
	Italic = 0x02,
	BoldItalic = 0x03
}

class SKTypeface : SKObject
{
	// private static const SKTypeface defaultTypeface;

	private static SKTypeface defaultTypeface()
	{
		__gshared SKTypeface inst;
		return initOnce!inst(new SKTypefaceStatic (SkiaApi.sk_typeface_ref_default ()));
	}

	private SKFont font;


	static void EnsureStaticInstanceAreInitialized ()
	{
		// IMPORTANT: do not remove to ensure that the static instances
		//            are initialized before any access is made to them
	}

	this (void* handle, bool owns)
	{
    super (handle, owns);
	}

	// Default

	protected override void Dispose (bool disposing)
  {
    return super.Dispose (disposing);
  }
		

	static SKTypeface Default()
  {
    return defaultTypeface;
  }

	static SKTypeface CreateDefault ()
	{
		return GetObject (SkiaApi.sk_typeface_create_default ());
	}

	// FromFamilyName

	static SKTypeface FromFamilyName (string familyName, SKTypefaceStyle style)
	{
		// auto weight = style.HasFlag (SKTypefaceStyle.Bold) ? SKFontStyleWeight.Bold : SKFontStyleWeight.Normal;
		// auto slant = style.HasFlag (SKTypefaceStyle.Italic) ? SKFontStyleSlant.Italic : SKFontStyleSlant.Upright;

		// return FromFamilyName (familyName, weight, SKFontStyleWidth.Normal, slant);
    return null;
	}

	static SKTypeface FromFamilyName (string familyName, int weight, int width, SKFontStyleSlant slant)
	{
		return FromFamilyName (familyName, new SKFontStyle (weight, width, slant));
	}

	static SKTypeface FromFamilyName (string familyName)
	{
		return FromFamilyName (familyName, SKFontStyle.Normal);
	}

	static SKTypeface FromFamilyName (string familyName, SKFontStyle style)
	{
		if (style is null)
			throw new ArgumentNullException (style.stringof);

		auto tf = GetObject (SkiaApi.sk_typeface_create_from_name (familyName, cast(sk_fontstyle_t*)style.Handle));
		tf.PreventPublicDisposal ();
		return tf;
	}

	static SKTypeface FromFamilyName (string familyName, SKFontStyleWeight weight, SKFontStyleWidth width, SKFontStyleSlant slant)
	{
		return FromFamilyName (familyName, cast(int)weight, cast(int)width, slant);
	}

	// From*

	static SKTypeface FromTypeface (SKTypeface typeface, SKTypefaceStyle style)
	{
		if (typeface is null)
			throw new ArgumentNullException (typeface.stringof);

		auto weight = style.HasFlag (SKTypefaceStyle.Bold) ? SKFontStyleWeight.Bold : SKFontStyleWeight.Normal;
		auto width = SKFontStyleWidth.Normal;
		auto slant = style.HasFlag (SKTypefaceStyle.Italic) ? SKFontStyleSlant.Italic : SKFontStyleSlant.Upright;

		return SKFontManager.Default.MatchTypeface (typeface, new SKFontStyle (weight, width, slant));
	}

	static SKTypeface FromFile (string path, int index = 0)
	{
		if (path is null)
			throw new ArgumentNullException (path.stringof);

		// auto utf8path = StringUtilities.GetEncodedText (path, SKTextEncoding.Utf8, true);
		string u = path;
		return GetObject (SkiaApi.sk_typeface_create_from_file (u, index));
	}

	// static SKTypeface FromStream (Stream stream, int index = 0)
	// {
	// 	if (stream is null)
	// 		throw new ArgumentNullException (stream.stringof);

	// 	return FromStream (new SKManagedStream (stream, true), index);
	// }

	static SKTypeface FromStream (SKStreamAsset stream, int index = 0)
	{
		if (stream is null)
			throw new ArgumentNullException (stream.stringof);

	// 	if (stream is SKManagedStream) {
    //   // auto managed = stream;
	// 		// stream = managed.ToMemoryStream ();
	// 		// managed.Dispose ();
	// 	}

		auto typeface = GetObject (SkiaApi.sk_typeface_create_from_stream (cast(sk_stream_asset_t*)stream.Handle, index));
		stream.RevokeOwnership (typeface);
		return typeface;
	}

	static SKTypeface FromData (SKData data, int index = 0)
	{
		if (data is null)
			throw new ArgumentNullException (data.stringof);

		return GetObject (SkiaApi.sk_typeface_create_from_data (cast(sk_data_t*)data.Handle, index));
	}

	// CharsToGlyphs
	// [Obsolete ("Use GetGlyphs(string, out ushort[]) instead.")]
	int CharsToGlyphs (string chars, out ushort[] glyphs)
  {
    return GetGlyphs (chars, glyphs);
  }
	
	// [Obsolete ("Use GetGlyphs(void*, int, SKTextEncoding, out ushort[]) instead.")]
	int CharsToGlyphs (void* str, int strlen, SKEncoding encoding, out ushort[] glyphs)
  {
    return GetGlyphs (str, strlen, encoding, glyphs);
  }
		

	// Properties

	string FamilyName()
  {
    return cast(string)SKString.GetObject (SkiaApi.sk_typeface_get_family_name (cast(sk_typeface_t*)Handle));
  }

	SKFontStyle FontStyle()
  {
    return SKFontStyle.GetObject (SkiaApi.sk_typeface_get_fontstyle (cast(sk_typeface_t*)Handle));
  }

	int FontWeight()
  {
    return SkiaApi.sk_typeface_get_font_weight (cast(sk_typeface_t*)Handle);
  } 

	int FontWidth()
  {
    return SkiaApi.sk_typeface_get_font_width (cast(sk_typeface_t*)Handle);
  }

	SKFontStyleSlant FontSlant()
  {
    return SkiaApi.sk_typeface_get_font_slant (cast(sk_typeface_t*)Handle);
  }

	bool IsBold()
  {
    return FontStyle.Weight >= cast(int)SKFontStyleWeight.SemiBold;
  }

	bool IsItalic()
  {
    return FontStyle.Slant != SKFontStyleSlant.Upright;
  }

	bool IsFixedPitch()
  {
    return SkiaApi.sk_typeface_is_fixed_pitch (cast(sk_typeface_t*)Handle);
  }

	SKTypefaceStyle Style() {
	
			auto style = SKTypefaceStyle.Normal;
			if (FontWeight >= cast(int)SKFontStyleWeight.SemiBold)
				style |= SKTypefaceStyle.Bold;
			if (FontSlant != cast(int)SKFontStyleSlant.Upright)
				style |= SKTypefaceStyle.Italic;
			return style;
		
	}

	int UnitsPerEm()
  {
    return SkiaApi.sk_typeface_get_units_per_em (cast(sk_typeface_t*)Handle);
  }

	int GlyphCount()
  {
    return SkiaApi.sk_typeface_count_glyphs (cast(sk_typeface_t*)Handle);
  }

	// GetTableTags

	int TableCount()
  {
    return SkiaApi.sk_typeface_count_tables (cast(sk_typeface_t*)Handle);
  } 

	uint[] GetTableTags ()
	{
    uint[] result;
		if (!TryGetTableTags ( result)) {
			throw new Exception ("Unable to read the tables for the file.");
		}
		return result;
	}

	bool TryGetTableTags (out uint[] tags)
	{
		auto buffer = new uint[TableCount];
		uint* b = buffer.ptr; {
			if (SkiaApi.sk_typeface_get_table_tags (cast(sk_typeface_t*)Handle, b) == 0) {
				tags = null;
				return false;
			}
		}
		tags = buffer;
		return true;
	}

	// GetTableSize

	int GetTableSize (uint tag)
  {
    return cast(int)SkiaApi.sk_typeface_get_table_size (cast(sk_typeface_t*)Handle, tag);
  }
		

	// GetTableData

	byte[] GetTableData (uint tag)
	{
    byte[] result;
		if (!TryGetTableData (tag,  result)) {
			throw new Exception ("Unable to read the data table.");
		}
		return result;
	}

	bool TryGetTableData (uint tag, out byte[] tableData)
	{
		auto length = GetTableSize (tag);
		auto buffer = new byte[length];
		byte* b = buffer.ptr; {
			if (!TryGetTableData (tag, 0, length, cast(void*)b)) {
				tableData = null;
				return false;
			}
		}
		tableData = buffer;
		return true;
	}

	bool TryGetTableData (uint tag, int offset, int length, void* tableData)
	{
		auto actual = SkiaApi.sk_typeface_get_table_data (cast(sk_typeface_t*)Handle, tag, cast(void*)offset, cast(void*)length, cast(byte*)tableData);
		return actual !is null;
	}

	// CountGlyphs (string/char)

	int CountGlyphs (string str)
  {
    return GetFont ().CountGlyphs (str);
  }
		

	int CountGlyphs (string str, SKEncoding encoding)
  {
    return 	GetFont ().CountGlyphs (str);
  }
	

	int CountGlyphs (const(char)[] str)
  {
    return GetFont ().CountGlyphs (str);
  }
		

	// CountGlyphs (byte[])
	// [Obsolete ("Use CountGlyphs(byte[], SKTextEncoding) instead.")]
	int CountGlyphs (byte[] str, SKEncoding encoding)
  {
    return 	GetFont ().CountGlyphs (str, encoding.ToTextEncoding ());
  }
	

	int CountGlyphs (byte[] str, SKTextEncoding encoding)
  {
    return 	GetFont ().CountGlyphs (str, encoding);
  }
	

	int CountGlyphs (const(byte)[] str, SKEncoding encoding)	
  {
		return GetFont ().CountGlyphs (str, encoding.ToTextEncoding ());
	}

	int CountGlyphs (const(byte)[] str, SKTextEncoding encoding)	
  {
		return GetFont ().CountGlyphs (str, encoding);
	}

	// CountGlyphs (void*)

	int CountGlyphs (void* str, int strLen, SKEncoding encoding)	
  {
		return CountGlyphs (str, strLen, encoding.ToTextEncoding ());
	}

	int CountGlyphs (void* str, int strLen, SKTextEncoding encoding)	
  {
    return GetFont ().CountGlyphs (str, strLen, encoding);
		// return GetFont ().CountGlyphs (str, strLen * encoding.GetCharacterByteSize (), encoding);
	}

	// GetGlyph (int)

	ushort GetGlyph (int codepoint)	
  {
		return GetFont ().GetGlyph (codepoint);
	}

	// GetGlyphs (int)

	ushort[] GetGlyphs (const(int)[] codepoints)
  {
    return GetFont ().GetGlyphs (codepoints);
  }
		

	// GetGlyphs (string/char, out)

	int GetGlyphs (string text, out ushort[] glyphs)
	{
		glyphs = GetGlyphs (text);
		return cast(int)glyphs.length;
	}

	int GetGlyphs (string text, SKEncoding encoding, out ushort[] glyphs)
  {
    return GetGlyphs (text, glyphs);
  }
	

	// GetGlyphs (byte[], out)
	// [Obsolete ("Use GetGlyphs(byte[], SKTextEncoding) instead.")]
	int GetGlyphs (byte[] text, SKEncoding encoding, out ushort[] glyphs)
  {
    return GetGlyphs (cast(const(byte)[])text, encoding,  glyphs);
  }
		

	int GetGlyphs (const(byte)[] text, SKEncoding encoding, out ushort[] glyphs)
	{
		glyphs = GetGlyphs (text, encoding);
		return cast(int)glyphs.length;
	}

	// GetGlyphs (void*, out)

	int GetGlyphs (void* text, int length, SKEncoding encoding, out ushort[] glyphs)
	{
		glyphs = GetGlyphs (text, length, encoding);
		return cast(int)glyphs.length;
	}

	// GetGlyphs (string/char)

	ushort[] GetGlyphs (string text)
  {
    return 	GetGlyphs (cast(const(char)[])text);
  }
	

	ushort[] GetGlyphs (string text, SKEncoding encoding)
  {
    return GetGlyphs (cast(const(char)[])text);
  }
		

	ushort[] GetGlyphs (const(char)[] text)
	{
		auto font =  ToFont ();
		scope(exit) {
		    font.Dispose();
		}

		return font.GetGlyphs (text);
	}

	// GetGlyphs (byte[])

	ushort[] GetGlyphs (byte[] text, SKEncoding encoding)	
  {
		return GetGlyphs (cast(const(byte)[])text, encoding.ToTextEncoding ());
	}

	ushort[] GetGlyphs (const(byte)[] text, SKEncoding encoding)	
  {
		return GetGlyphs (text, encoding.ToTextEncoding ());
	}

	ushort[] GetGlyphs (const(byte)[] text, SKTextEncoding encoding)
	{
		auto font =  ToFont ();
		scope(exit) {
		    font.Dispose();
		}

		return font.GetGlyphs (text, encoding);
	}

	// GetGlyphs (void*)

	ushort[] GetGlyphs (void* text, int length, SKEncoding encoding)	
  {
		return GetGlyphs (text, length, encoding.ToTextEncoding ());
	}

	ushort[] GetGlyphs (void* text, int length, SKTextEncoding encoding)
	{
		auto font =  ToFont ();
		scope(exit) {
		    font.Dispose();
		}

    return font.GetGlyphs (text, length , encoding);
		// return font.GetGlyphs (text, length * encoding.GetCharacterByteSize (), encoding);
	}

	// ContainsGlyph

	bool ContainsGlyph (int codepoint)	
  {
		return GetFont ().ContainsGlyph (codepoint);
	}

	// ContainsGlyphs

	bool ContainsGlyphs (const(int)[] codepoints)	
  {
		return GetFont ().ContainsGlyphs (codepoints);
	}

	bool ContainsGlyphs (string text)	
  {
		return GetFont ().ContainsGlyphs (text);
	}

	bool ContainsGlyphs (const(char)[] text)	
  {
		return GetFont ().ContainsGlyphs (text);
	}

	bool ContainsGlyphs (const(byte)[] text, SKTextEncoding encoding)	
  {
		return ContainsGlyphs (text, encoding);
	}

	bool ContainsGlyphs (void* text, int length, SKTextEncoding encoding)	
  {
    return GetFont ().ContainsGlyphs (text, length , encoding);
		// return GetFont ().ContainsGlyphs (text, length * encoding.GetCharacterByteSize (), encoding);
	}

	// GetFont

	SKFont GetFont ()
  {
		if(font is null) {
			font = OwnedBy (new SKFont (this), this);
		}

		return font;
    // return font ? font : OwnedBy (new SKFont (this), this);
  }
		

	// ToFont

	SKFont ToFont () 
  {
    return new SKFont (this);
  }
		

	SKFont ToFont (float size, float scaleX = SKFont.DefaultScaleX, float skewX = SKFont.DefaultSkewX)
  {
    return new SKFont (this, size, scaleX, skewX);
  }
		

	// OpenStream

	SKStreamAsset OpenStream ()
  {
    // return OpenStream ( _);
    return null;
  }
		

	SKStreamAsset OpenStream (out int ttcIndex)
	{
		// int* ttc = &ttcIndex;
		// return SKStreamAsset.GetObject (SkiaApi.sk_typeface_open_stream (cast(sk_typeface_t*)Handle, ttc));
    return null;
	}

	// GetKerningPairAdjustments

	int[] GetKerningPairAdjustments (ushort[] glyphs)
	{
		auto adjustments = new int[glyphs.length];
		ushort* gp = glyphs.ptr;
		int* ap = adjustments.ptr;
		SkiaApi.sk_typeface_get_kerning_pair_adjustments (cast(sk_typeface_t*)Handle, gp, cast(int)glyphs.length, ap);
		return adjustments;
	}

	//

	static SKTypeface GetObject (void* handle)
  {
    // return GetOrAddObject (handle, (h, o){return new SKTypeface (h, o);});
    return GetOrAddObject!(SKTypeface)(handle, delegate SKTypeface (h, o) { return new SKTypeface (h, o);});
  }
		

}


	//

	class SKTypefaceStatic : SKTypeface
	{
		this (void* x)
		{
      super (x, true);
			// IgnorePublicDispose = true;
		}
	}