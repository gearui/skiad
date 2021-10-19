module skia.SKFontStyleSet;

import skia.SKObject;
import skia.SKTypeface;
import skia.SKFontStyle;
import skia.Definitions;
import skia.SkiaApi;
import skia.SKString;
import skia.Exceptions;

// class SKFontStyleSet : SKObject, IEnumerable<SKFontStyle>, IReadOnlyCollection<SKFontStyle>, IReadOnlyList<SKFontStyle>

class SKFontStyleSet : SKObject
{
	this(void* handle, bool owns)
	{
    super (handle, owns);
	}

	this ()
	{
    this (SkiaApi.sk_fontstyleset_create_empty (), true);
	}

	protected override void Dispose (bool disposing) 
  {
    return 	super.Dispose (disposing);
  }
	

	int Count()
  {
    return SkiaApi.sk_fontstyleset_get_count (cast(sk_fontstyleset_t*)Handle);
  } 

	// SKFontStyle this[int index]()
  // {
  //   return GetStyle (index);
  // } 

	string GetStyleName (int index)
	{
		SKString str = new SKString ();
		
		
    	SkiaApi.sk_fontstyleset_get_style (cast(sk_fontstyleset_t*)Handle, index, null, cast(sk_string_t*)str.Handle);
			// GC.KeepAlive(this);
			return cast(string)str;
	}

	SKTypeface CreateTypeface (int index)
	{
		if (index < 0 || index >= Count)
			throw new ArgumentOutOfRangeException ("Index was out of range. Must be non-negative and less than the size of the set.", index.stringof);

		auto tf = SKTypeface.GetObject (SkiaApi.sk_fontstyleset_create_typeface (cast(sk_fontstyleset_t*)Handle, index));
		tf.PreventPublicDisposal ();
		// GC.KeepAlive(this);
		return tf;
	}

	SKTypeface CreateTypeface (SKFontStyle style)
	{
		if (style is null)
			throw new ArgumentNullException (style.stringof);

		auto tf = SKTypeface.GetObject (SkiaApi.sk_fontstyleset_match_style (cast(sk_fontstyleset_t*)Handle, cast(sk_fontstyle_t*)style.Handle));
		tf.PreventPublicDisposal ();
		// GC.KeepAlive(this);
		return tf;
	}

	// IEnumerator<SKFontStyle> GetEnumerator ()
  // {
  //   return GetStyles ().GetEnumerator ();
  // } 

	// IEnumerator IEnumerable.GetEnumerator ()
  // {
  //   return GetStyles ().GetEnumerator ();
  // }

	// private IEnumerable<SKFontStyle> GetStyles ()
	// {
	// 	auto count = Count;
	// 	for (var i = 0; i < count; i++) {
	// 		yield return GetStyle (i);
	// 	}
	// }

	private SKFontStyle GetStyle (int index)
	{
		auto fontStyle = new SKFontStyle ();
		SkiaApi.sk_fontstyleset_get_style (cast(sk_fontstyleset_t*)Handle, index, cast(sk_fontstyle_t*)fontStyle.Handle, null);
		return fontStyle;
	}

	static SKFontStyleSet GetObject (void* handle)
  {
    return GetOrAddObject!(SKFontStyleSet)(handle, delegate SKFontStyleSet (h, o) { return new SKFontStyleSet (h, o);});
  }
}
	
