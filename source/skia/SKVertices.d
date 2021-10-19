module skia.SKVertices;

import skia.Definitions;
import skia.Exceptions;
import skia.MathTypes;
import skia.SkiaApi;
import skia.SKColor;
import skia.SKObject;


class SKVertices : SKObject, ISKNonVirtualReferenceCounted, ISKSkipObjectRegistration
{
	this (void* x, bool owns)
	{
    super (x, owns);
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);
  }
	

	void ReferenceNative ()
  {
    return SkiaApi.sk_vertices_ref (cast(sk_vertices_t*)Handle);
  } 

	void UnreferenceNative ()
  {
    return SkiaApi.sk_vertices_unref (cast(sk_vertices_t*)Handle);
  } 

	static SKVertices CreateCopy (SKVertexMode vmode, SKPoint[] positions, SKColor[] colors)
	{
		return CreateCopy (vmode, positions, null, colors, null);
	}

	static SKVertices CreateCopy (SKVertexMode vmode, SKPoint[] positions, SKPoint[] texs, SKColor[] colors)
	{
		return CreateCopy (vmode, positions, texs, colors, null);
	}

	static SKVertices CreateCopy (SKVertexMode vmode, SKPoint[] positions, SKPoint[] texs, SKColor[] colors, ushort[] indices)
	{
		if (positions is null)
			throw new ArgumentNullException (positions.stringof);

		if (texs !is null && positions.length != texs.length)
			throw new ArgumentException ("The number of texture coordinates must match the number of vertices.", texs.stringof);
		if (colors !is null && positions.length != colors.length)
			throw new ArgumentException ("The number of colors must match the number of vertices.", colors.stringof);

		auto vertexCount = positions.length;
		auto indexCount = indices.length ? indices.length : 0;

		SKPoint* p = positions.ptr;
		SKPoint* t = texs.ptr;
		SKColor* c = colors.ptr;
		ushort* i = indices.ptr;
		return GetObject (SkiaApi.sk_vertices_make_copy (vmode, cast(int)vertexCount, p, t, cast(uint*)c, cast(int)indexCount, i));
	}

	static SKVertices GetObject (void* handle)
  {
    return handle is null ? null : new SKVertices (handle, true);
  }

}
