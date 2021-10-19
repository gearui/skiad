module skia.SKColor;

import skia.SKColorF;
import skia.Exceptions;

import std.experimental.logger;

import std.conv;
import std.format;
import std.range;
import std.string;

struct SKColor {
	enum SKColor Empty = SKColor(0);

	private uint color;

	this(uint value) {
		color = value;
	}

	this(ubyte red, ubyte green, ubyte blue, ubyte alpha) {
		color = cast(uint)((alpha << 24) | (red << 16) | (green << 8) | blue);
	}

	this(ubyte red, ubyte green, ubyte blue) {
		color = (0xff000000u | cast(uint)(red << 16) | cast(uint)(green << 8) | blue);
	}

	SKColor WithRed(ubyte red) {
		return SKColor(red, Green, Blue, Alpha);
	}

	SKColor WithGreen(ubyte green) {
		return SKColor(Red, green, Blue, Alpha);
	}

	SKColor WithBlue(ubyte blue) {
		return SKColor(Red, Green, blue, Alpha);
	}

	SKColor WithAlpha(ubyte alpha) {
		return SKColor(Red, Green, Blue, alpha);
	}

	ubyte Alpha() {
		return cast(ubyte)((color >> 24) & 0xff);
	}

	ubyte Red() {
		return cast(ubyte)((color >> 16) & 0xff);
	}

	ubyte Green() {
		return cast(ubyte)((color >> 8) & 0xff);
	}

	ubyte Blue() {
		return cast(ubyte)((color) & 0xff);
	}

	float Hue() {
		float h;
		float s;
		float v;
		ToHsv(h, s, v);
		return h;
	}

	static SKColor FromHsl(float h, float s, float l, ubyte a = cast(ubyte) 255) {
		auto colorf = SKColorF.FromHsl(h, s, l);

		// RGB results from 0 to 255
		auto r = colorf.Red * 255f;
		auto g = colorf.Green * 255f;
		auto b = colorf.Blue * 255f;

		return SKColor(cast(ubyte) r, cast(ubyte) g, cast(ubyte) b, a);
	}

	static SKColor FromHsv(float h, float s, float v, ubyte a = cast(ubyte) 255) {
		auto colorf = SKColorF.FromHsv(h, s, v);

		// RGB results from 0 to 255
		auto r = colorf.Red * 255f;
		auto g = colorf.Green * 255f;
		auto b = colorf.Blue * 255f;

		return SKColor(cast(ubyte) r, cast(ubyte) g, cast(ubyte) b, a);
	}

	void ToHsl(ref float h, ref float s, ref float l) {
		// RGB from 0 to 255
		auto r = Red / 255f;
		auto g = Green / 255f;
		auto b = Blue / 255f;

		auto colorf = SKColorF(r, g, b);
		colorf.ToHsl(h, s, l);
	}

	void ToHsv(ref float h, ref float s, ref float v) {
		// RGB from 0 to 255
		auto r = Red / 255f;
		auto g = Green / 255f;
		auto b = Blue / 255f;

		auto colorf = SKColorF(r, g, b);
		colorf.ToHsv(h, s, v);
	}

	string ToString() {
		// return "#{Alpha:x2}{Red:x2}{Green:x2}{Blue:x2}";
		return format("#%02x%02x%02x%02x", Alpha, Red, Green, Blue);
	}

	// bool Equals(SKColor obj)
	// {
	// 	return obj.color == color;
	// }

	// override bool Equals(object other)
	// {
	// 	return other is SKColor f && Equals(f);
	// }

	// static bool operator == (SKColor left, SKColor right)
	// {
	// 	return left.Equals(right);
	// }

	// static bool operator != (SKColor left, SKColor right)
	// {
	// 	return !left.Equals(right);
	// }

	// override int GetHashCode()
	// {
	// 	return color.GetHashCode();
	// }

	uint opCast(T)() if (is(T == uint)) {
		return color;
	}

	static SKColor Parse(string hexString) {
		SKColor color;
		if (!TryParse(hexString, color))
			throw new ArgumentException("Invalid hexadecimal color string.", hexString.stringof);
		return color;
	}

	static bool TryParse(string hexString, ref SKColor color) {
		if (hexString.empty()) {
			// error
			color = SKColor.Empty;
			return false;
		}

		// clean up string
		hexString = hexString.strip().toUpper();
		if (hexString[0] == '#')
			hexString = hexString[1 .. $];

		size_t len = hexString.length;
		if (len == 3 || len == 4) {
			ubyte a;
			// parse [A]
			if (len == 4) {
				if (!tryParse(format("%c%c", hexString[len - 4], hexString[len - 4]), a)) {
					// error
					color = SKColor.Empty;
					return false;
				}
			} else {
				a = cast(ubyte) 255;
			}

			// parse RGB
			ubyte r, g, b;
			if (!tryParse(format("%c%c", hexString[len - 3],
					hexString[len - 3]), r) || !tryParse(format("%c%c", hexString[len - 2],
					hexString[len - 2]), g) || !tryParse(format("%c%c",
					hexString[len - 1], hexString[len - 1]), b)) {
				// error
				color = SKColor.Empty;
				return false;
			}

			// success
			color = SKColor(r, g, b, a);
			return true;
		}

		if (len == 6 || len == 8) {
			// parse [AA]RRGGBB
			uint number = 0;

			if (!tryParse(hexString, number)) {
				// error
				color = SKColor.Empty;
				return false;
			}

			// success
			color = SKColor(number);

			// alpha was not provided, so use 255
			if (len == 6) {
				color = color.WithAlpha(cast(ubyte) 255);
			}
			return true;
		}

		// error
		color = SKColor.Empty;
		return false;
	}

	// parse [AA]RRGGBB
	static bool tryParse(string hexString, out uint color) {
		try {
			color = to!uint(hexString, 16);
			return true;
		} catch (Exception ex) {
			warningf("Hex: %s, Error: %s", hexString, ex.msg);
			return false;
		}
	}

	// parse CC
	static bool tryParse(string hexString, out ubyte data) {
		try {
			data = to!ubyte(hexString, 16);
			return true;
		} catch (Exception ex) {
			warningf("Hex: %s, Error: %s", hexString, ex.msg);
			return false;
		}
	}

	SKColorF opCast(T)() if (is(T == SKColorF)) {
		SKColorF colorF;
		SkiaApi.sk_color4f_from_color(color, &colorF);
		return colorF;
	}
}
