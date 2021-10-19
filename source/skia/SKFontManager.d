module skia.SKFontManager;

import skia.SKObject;
import skia.SkiaApi;
import skia.SKFontStyle;
import skia.SKTypeface;
import skia.SKStream;
import skia.Definitions;
import skia.SKData;
import skia.SKFontStyleSet;
import skia.SKString;
import skia.Exceptions;
import std.concurrency : initOnce;

class SKFontManager : SKObject {
	// private static const SKFontManager defaultManager;

	// static SKFontManager ()
	// {
	// 	defaultManager = new SKFontManagerStatic (SkiaApi.sk_fontmgr_ref_default ());
	// }
	static SKFontManager defaultManager() {
		__gshared SKFontManager defaultManager;
		return initOnce!defaultManager(new SKFontManagerStatic(SkiaApi.sk_fontmgr_ref_default()));
	}

	static void EnsureStaticInstanceAreInitialized() {
		// IMPORTANT: do not remove to ensure that the static instances
		//            are initialized before any access is made to them
	}

	this(void* handle, bool owns) {
		super(handle, owns);
	}

	protected override void Dispose(bool disposing) {
		return super.Dispose(disposing);
	}

	static SKFontManager Default() {
		return defaultManager;
	}

	int FontFamilyCount() {
		return SkiaApi.sk_fontmgr_count_families(cast(sk_fontmgr_t*) Handle);
	}

	// IEnumerable!(string) FontFamilies() {

	// 		auto count = FontFamilyCount;
	// 		for (var i = 0; i < count; i++) {
	// 			yield return GetFamilyName (i);
	// 		}

	// }

	string GetFamilyName(int index) {

		SKString str = new SKString();
		SkiaApi.sk_fontmgr_get_family_name(cast(sk_fontmgr_t*) Handle, index,
				cast(sk_string_t*) str.Handle);
		return cast(string) str;
	}

	// string[] GetFontFamilies ()
	// {
	//   return FontFamilies.ToArray ();
	// } 

	SKFontStyleSet GetFontStyles(int index) {
		return SKFontStyleSet.GetObject(
				SkiaApi.sk_fontmgr_create_styleset(cast(sk_fontmgr_t*) Handle, index));
	}

	SKFontStyleSet GetFontStyles(string familyName) {
		return SKFontStyleSet.GetObject(
				SkiaApi.sk_fontmgr_match_family(cast(sk_fontmgr_t*) Handle, familyName));
	}

	SKTypeface MatchFamily(string familyName) {
		return MatchFamily(familyName, SKFontStyle.Normal);
	}

	SKTypeface MatchFamily(string familyName, SKFontStyle style) {
		if (style is null)
			throw new ArgumentNullException(style.stringof);

		auto tf = SKTypeface.GetObject(SkiaApi.sk_fontmgr_match_family_style(cast(sk_fontmgr_t*) Handle,
				familyName, cast(sk_fontstyle_t*) style.Handle));
		tf.PreventPublicDisposal();
		return tf;
	}

	SKTypeface MatchTypeface(SKTypeface face, SKFontStyle style) {
		if (face is null)
			throw new ArgumentNullException(face.stringof);
		if (style is null)
			throw new ArgumentNullException(style.stringof);

		auto tf = SKTypeface.GetObject(SkiaApi.sk_fontmgr_match_face_style(cast(sk_fontmgr_t*) Handle,
				cast(sk_typeface_t*) face.Handle, cast(sk_fontstyle_t*) style.Handle));
		tf.PreventPublicDisposal();
		return tf;
	}

	SKTypeface CreateTypeface(string path, int index = 0) {
		if (path is null)
			throw new ArgumentNullException(path.stringof);

		// auto utf8path = StringUtilities.GetEncodedText (path, SKTextEncoding.Utf8, true);
		// byte* u = utf8path;
		string utf8path;
		return SKTypeface.GetObject(SkiaApi.sk_fontmgr_create_from_file(
				cast(sk_fontmgr_t*) Handle, utf8path, index));
	}

	// SKTypeface CreateTypeface(Stream stream, int index = 0) {
	// 	if (&stream is null)
	// 		throw new ArgumentNullException(stream.stringof);

	// 	// return CreateTypeface (new SKManagedStream (stream, true), index);
	// 	return null;
	// }

	SKTypeface CreateTypeface(SKStreamAsset stream, int index = 0) {
		if (&stream is null)
			throw new ArgumentNullException(stream.stringof);

		// SKManagedStream st = cast(SKManagedStream)stream;
		// if (st !is null) {
		// 	// SKManagedStream managed = stream;
		// 	// managed.ToMemoryStream ();
		// 	// managed.Dispose ();
		// }

		auto typeface = SKTypeface.GetObject(SkiaApi.sk_fontmgr_create_from_stream(
				cast(sk_fontmgr_t*) Handle, cast(sk_stream_asset_t*) stream.Handle, index));
		stream.RevokeOwnership(typeface);
		return typeface;
	}

	SKTypeface CreateTypeface(SKData data, int index = 0) {
		if (data is null)
			throw new ArgumentNullException(data.stringof);

		return SKTypeface.GetObject(SkiaApi.sk_fontmgr_create_from_data(
				cast(sk_fontmgr_t*) Handle, cast(sk_data_t*) data.Handle, index));
	}

	SKTypeface MatchCharacter(char character) {
		return MatchCharacter(null, SKFontStyle.Normal, null, character);
	}

	SKTypeface MatchCharacter(int character) {
		return MatchCharacter(null, SKFontStyle.Normal, null, character);
	}

	SKTypeface MatchCharacter(string familyName, char character) {
		return MatchCharacter(familyName, SKFontStyle.Normal, null, character);
	}

	SKTypeface MatchCharacter(string familyName, int character) {
		return MatchCharacter(familyName, SKFontStyle.Normal, null, character);
	}

	SKTypeface MatchCharacter(string familyName, string[] bcp47, char character) {
		return MatchCharacter(familyName, SKFontStyle.Normal, bcp47, character);
	}

	SKTypeface MatchCharacter(string familyName, string[] bcp47, int character) {
		return MatchCharacter(familyName, SKFontStyle.Normal, bcp47, character);
	}

	SKTypeface MatchCharacter(string familyName, SKFontStyleWeight weight,
			SKFontStyleWidth width, SKFontStyleSlant slant, string[] bcp47, char character) {
		return MatchCharacter(familyName, new SKFontStyle(weight, width, slant), bcp47, character);
	}

	SKTypeface MatchCharacter(string familyName, SKFontStyleWeight weight,
			SKFontStyleWidth width, SKFontStyleSlant slant, string[] bcp47, int character) {
		return MatchCharacter(familyName, new SKFontStyle(weight, width, slant), bcp47, character);
	}

	SKTypeface MatchCharacter(string familyName, int weight, int width,
			SKFontStyleSlant slant, string[] bcp47, int character) {
		return MatchCharacter(familyName, new SKFontStyle(weight, width, slant), bcp47, character);
	}

	SKTypeface MatchCharacter(string familyName, SKFontStyle style, string[] bcp47, int character) {
		if (style is null)
			throw new ArgumentNullException(style.stringof);

		// TODO: work around for https://bugs.chromium.org/p/skia/issues/detail?id=6196
		// if (familyName is null)
		// 	familyName = string.Empty;

		auto tf = SKTypeface.GetObject(SkiaApi.sk_fontmgr_match_family_style_character(cast(sk_fontmgr_t*) Handle,
				familyName, cast(sk_fontstyle_t*) style.Handle, bcp47,
				cast(int)(bcp47.length ? bcp47.length : 0), character));
		tf.PreventPublicDisposal();
		return tf;
	}

	static SKFontManager CreateDefault() {
		return GetObject(SkiaApi.sk_fontmgr_create_default());
	}

	//

	static SKFontManager GetObject(void* handle) {
		return GetOrAddObject!(SKFontManager)(handle, delegate SKFontManager(h, o) {
			return new SKFontManager(h, o);
		});
	}

}

//

private final class SKFontManagerStatic : SKFontManager {
	this(void* x) {
		super(x, true);
		IgnorePublicDispose = true;
	}
}
