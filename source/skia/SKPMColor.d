module skia.SKPMColor;

import skia.SKColor;
import skia.SkiaApi;
import skia.SKImageInfo;

// struct SKPMColor : IEquatable<SKPMColor>
struct SKPMColor
{
	private const uint color;

	this (uint value)
	{
		color = value;
	}

	const byte Alpha()
  {
    return cast(byte)((color >> SKImageInfo.PlatformColorAlphaShift) & 0xff);
  } 
	const byte Red()
  {
    return cast(byte)((color >> SKImageInfo.PlatformColorRedShift) & 0xff);
  } 
	const byte Green()
  {
    return cast(byte)((color >> SKImageInfo.PlatformColorGreenShift) & 0xff);
  }
	const byte Blue()
  {
    return cast(byte)((color >> SKImageInfo.PlatformColorBlueShift) & 0xff);
  } 

	// PreMultiply

	static SKPMColor PreMultiply (SKColor color)
  {
    return SKPMColor(SkiaApi.sk_color_premultiply (cast(uint)color));
  }
		

	static SKPMColor[] PreMultiply (SKColor[] colors)
	{
		auto pmcolors = new SKPMColor[colors.length];
		SKColor* c = colors.ptr;
		SKPMColor* pm = pmcolors.ptr;
		SkiaApi.sk_color_premultiply_array (cast(uint*)c, cast(int)colors.length, cast(uint*)pm);
		return pmcolors;
	}

	// UnPreMultiply

	static SKColor UnPreMultiply (SKPMColor pmcolor)
  {
    return SKColor(SkiaApi.sk_color_unpremultiply (pmcolor.color));
  }
		

	static SKColor[] UnPreMultiply (SKPMColor[] pmcolors)
	{
		auto colors = new SKColor[pmcolors.length];
		SKColor* c = colors.ptr;
		SKPMColor* pm = pmcolors.ptr;
		SkiaApi.sk_color_unpremultiply_array (cast(uint*)pm, cast(int)pmcolors.length, cast(uint*)c);
		return colors;
	}

	// static explicit operator SKPMColor (SKColor color)
  // {
  //   return SKPMColor.PreMultiply (color);
  // }
		

	// static explicit operator SKColor (SKPMColor color)
  // {
  //   return SKPMColor.UnPreMultiply (color);
  // }
		

	const  string ToString ()
  {
    return "#{Alpha:x2}{Red:x2}{Green:x2}{Blue:x2}";
  }
		

	const bool Equals (SKPMColor obj)
  {
    return obj.color == color;
  }
		

	// const override bool Equals (object other)
  // {
  //   return 	other is SKPMColor f && Equals (f);
  // }
	

	// static bool operator == (SKPMColor left, SKPMColor right)
  // {
  //   return left.Equals (right);
  // }
		

	// static bool operator != (SKPMColor left, SKPMColor right)
  // {
  //   return 	!left.Equals (right);
  // }
	

	// const  int GetHashCode ()	
  // {
	// 	return color.GetHashCode ();
	// }

	// static implicit operator SKPMColor (uint color)	
  // {
	// 	return new SKPMColor (color);
	// }

	// static explicit operator uint (SKPMColor color)	
  // {
	// 	return color.color;
	// }
}
