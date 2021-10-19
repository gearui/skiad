module skia.SKColorTable;

import skia.Definitions;
import skia.SkiaApi;
import skia.SKObject;
import skia.SKColor;
import skia.SKPMColor;
import skia.Exceptions;

class SKColorTable : SKObject, ISKSkipObjectRegistration
{
	const int MaxLength = 256;

	this (void* x, bool owns)
	{
    	super(x, owns);
	}

	this ()
	{
    	this (new SKPMColor[MaxLength]);
	}

	this (int count)
	{
    	this (new SKPMColor[count]);
	}

	this (SKColor[] colors)
	{
    	this (colors, cast(int)colors.length);
	}

	this (SKColor[] colors, int count)
	{
    	this (SKPMColor.PreMultiply (colors), count);
	}

	this (SKPMColor[] colors)
	{
    	this (colors, cast(int)colors.length);
	}

	this (SKPMColor[] colors, int count)
	{
   	 	this (CreateNew (colors, count), true);
		if (Handle is null) {
			throw new InvalidOperationException ("Unable to create a new SKColorTable instance.");
		}
	}

	public override void* Handle()
	{
		return null;
	}
	private static void* CreateNew (SKPMColor[] colors, int count)
	{
		SKPMColor* c = colors.ptr;
		return SkiaApi.sk_colortable_new (cast(uint*)c, count);
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);
  }
	

	int Count()
  {
    return SkiaApi.sk_colortable_count (cast(sk_colortable_t*)Handle);
  } 

	SKPMColor[] Colors()
  {
			auto count = Count;
			auto pointer = ReadColors ();

			if (count == 0 || pointer is null) {
				return new SKPMColor[0];
			}

			return PtrToStructureArray!(SKPMColor) (pointer, count);
	}

	SKColor[] UnPreMultipledColors()
  {
    return SKPMColor.UnPreMultiply (Colors);
  }

	// SKPMColor this[int index] 
	// {
	// 		auto count = Count;
	// 		auto pointer = ReadColors ();

	// 		if (index < 0 || index >= count || pointer is null) {
	// 			throw new ArgumentOutOfRangeException (index.stringof);
	// 		}

	// 		return PtrToStructure<SKPMColor> (pointer, index);
	// }

	// SKColor GetUnPreMultipliedColor (int index)
  // {
  //   return SKPMColor.UnPreMultiply (this[index]);
  // } 

	void* ReadColors ()
	{
		uint* colors;
		SkiaApi.sk_colortable_read_colors (cast(sk_colortable_t*)Handle, &colors);
		return cast(void*)colors;
	}
}

