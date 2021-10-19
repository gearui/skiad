module skia.SKColorF;

import skia.Definitions;
import skia.SkiaApi;
import skia.SKColor;

import std.algorithm;
import std.math;

struct SKColorF
{
	enum float EPSILON = 0.001f;

	enum SKColorF Empty = SKColorF(0, 0, 0, 0);

	this(float red, float green, float blue)
	{
		fR = red;
		fG = green;
		fB = blue;
		fA = 1f;
	}

	this(float red, float green, float blue, float alpha)
	{
		fR = red;
		fG = green;
		fB = blue;
		fA = alpha;
	}

	// float fR
	private const float fR;
	const float Red() {
        return fR;
    }

	// float fG
	private const float fG;
	const float Green() { 
        return fG;
    }

	// float fB
	private const float fB;
	const float Blue() {
        return fB;
    }

	// float fA
	private const float fA;
	const float Alpha() {
        return fA;
    }

	// const bool Equals (SKColorF obj) {
	// 	return fR == obj.fR && fG == obj.fG && fB == obj.fB && fA == obj.fA
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKColorF f && Equals (f)
	// }

	// static bool operator == (SKColorF left, SKColorF right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKColorF left, SKColorF right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (fR);
	// 	hash.Add (fG);
	// 	hash.Add (fB);
	// 	hash.Add (fA);
	// 	return hash.ToHashCode ();
	// }

	SKColorF WithRed(float red)
	{
		return SKColorF(red, fG, fB, fA);
	}

	SKColorF WithGreen(float green)
	{
		return SKColorF(fR, green, fB, fA);
	}

	SKColorF WithBlue(float blue)
	{
		return SKColorF(fR, fG, blue, fA);
	}

	SKColorF WithAlpha(float alpha)
	{
		return SKColorF(fR, fG, fB, alpha);
	}

	float Hue()
	{
		float h;
		float s;
		float v;
		ToHsv(h, s, v);
		return h;
	}

	SKColorF Clamp()
	{
		return SKColorF(Clamp(fR), Clamp(fG), Clamp(fB), Clamp(fA));


	}

	private static float Clamp(float v)
	{
		if (v > 1f)
			return 1f;
		if (v < 0f)
			return 0f;
		return v;
	}	

	static SKColorF FromHsl(float h, float s, float l, float a = 1f)
	{
		// convert from percentages
		h = h / 360f;
		s = s / 100f;
		l = l / 100f;

		// RGB results from 0 to 1
		auto r = l;
		auto g = l;
		auto b = l;

		// HSL from 0 to 1
		if (abs(s) > EPSILON)
		{
			float v2;
			if (l < 0.5f)
				v2 = l * (1f + s);
			else
				v2 = (l + s) - (s * l);

			auto v1 = 2f * l - v2;

			r = HueToRgb(v1, v2, h + (1f / 3f));
			g = HueToRgb(v1, v2, h);
			b = HueToRgb(v1, v2, h - (1f / 3f));
		}

		return SKColorF(r, g, b, a);
	}

	private static float HueToRgb(float v1, float v2, float vH)
	{
		if (vH < 0f)
			vH += 1f;
		if (vH > 1f)
			vH -= 1f;

		if ((6f * vH) < 1f)
			return (v1 + (v2 - v1) * 6f * vH);
		if ((2f * vH) < 1f)
			return (v2);
		if ((3f * vH) < 2f)
			return (v1 + (v2 - v1) * ((2f / 3f) - vH) * 6f);
		return (v1);
	}

	static SKColorF FromHsv(float h, float s, float v, float a = 1f)
	{
		// convert from percentages
		h = h / 360f;
		s = s / 100f;
		v = v / 100f;

		// RGB results from 0 to 1
		auto r = v;
		auto g = v;
		auto b = v;

		// HSL from 0 to 1
		if (abs(s) > EPSILON)
		{
			h = h * 6f;
			if (abs(h - 6f) < EPSILON)
				h = 0f; // H must be < 1

			int hInt = cast(int) h;
			auto v1 = v * (1f - s);
			auto v2 = v * (1f - s * (h - hInt));
			auto v3 = v * (1f - s * (1f - (h - hInt)));

			if (hInt == 0)
			{
				r = v;
				g = v3;
				b = v1;
			}
			else if (hInt == 1)
			{
				r = v2;
				g = v;
				b = v1;
			}
			else if (hInt == 2)
			{
				r = v1;
				g = v;
				b = v3;
			}
			else if (hInt == 3)
			{
				r = v1;
				g = v2;
				b = v;
			}
			else if (hInt == 4)
			{
				r = v3;
				g = v1;
				b = v;
			}
			else
			{
				r = v;
				g = v1;
				b = v2;
			}
		}

		return SKColorF(r, g, b, a);
	}

	void ToHsl(ref float h, ref float s, ref float l)
	{
		// RGB from 0 to 1
		auto r = fR;
		auto g = fG;
		auto b = fB;

		auto min = std.algorithm.min(std.algorithm.min(r, g), b); // min value of RGB
		auto max = std.algorithm.max(std.algorithm.max(r, g), b); // max value of RGB
		auto delta = max - min; // delta RGB value

		// default to a gray, no chroma...
		h = 0f;
		s = 0f;
		l = (max + min) / 2f;

		// chromatic data...
		if (abs(delta) > EPSILON)
		{
			if (l < 0.5f)
				s = delta / (max + min);
			else
				s = delta / (2f - max - min);

			auto deltaR = (((max - r) / 6f) + (delta / 2f)) / delta;
			auto deltaG = (((max - g) / 6f) + (delta / 2f)) / delta;
			auto deltaB = (((max - b) / 6f) + (delta / 2f)) / delta;

			if (abs(r - max) < EPSILON) // r == max
				h = deltaB - deltaG;
			else if (abs(g - max) < EPSILON) // g == max
				h = (1f / 3f) + deltaR - deltaB;
			else // b == max
				h = (2f / 3f) + deltaG - deltaR;

			if (h < 0f)
				h += 1f;
			if (h > 1f)
				h -= 1f;
		}

		// convert to percentages
		h = h * 360f;
		s = s * 100f;
		l = l * 100f;
	}

	void ToHsv(ref float h, ref float s, ref float v)
	{
		// RGB from 0 to 1
		auto r = fR;
		auto g = fG;
		auto b = fB;

		auto min = std.algorithm.min(std.algorithm.min(r, g), b); // min value of RGB
		auto max = std.algorithm.max(std.algorithm.max(r, g), b); // max value of RGB
		auto delta = max - min; // delta RGB value 

		// default to a gray, no chroma...
		h = 0;
		s = 0;
		v = max;

		// chromatic data...
		if (abs(delta) > EPSILON)
		{
			s = delta / max;

			auto deltaR = (((max - r) / 6f) + (delta / 2f)) / delta;
			auto deltaG = (((max - g) / 6f) + (delta / 2f)) / delta;
			auto deltaB = (((max - b) / 6f) + (delta / 2f)) / delta;

			if (abs(r - max) < EPSILON) // r == max
				h = deltaB - deltaG;
			else if (abs(g - max) < EPSILON) // g == max
				h = (1f / 3f) + deltaR - deltaB;
			else // b == max
				h = (2f / 3f) + deltaG - deltaR;

			if (h < 0f)
				h += 1f;
			if (h > 1f)
				h -= 1f;
		}

		// convert to percentages
		h = h * 360f;
		s = s * 100f;
		v = v * 100f;
	}

	string ToString()
	{
		return (cast(SKColor) this).ToString();
	}

	SKColor opCast(T)() if (is(T == SKColor))
	{
		return SKColor(SkiaApi.sk_color4f_to_color(&this));
	}

}
