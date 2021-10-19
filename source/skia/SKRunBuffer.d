module skia.SKRunBuffer;

import skia.MathTypes;
import skia.Definitions;
import skia.SkiaApi;

import std.experimental.logger;

class SKRunBuffer {
	SKRunBufferInternal internalBuffer;

	this(SKRunBufferInternal buffer, int size) {
		internalBuffer = buffer;
		Size = size;

	}

	void check() {

		int size = Size;
		byte* data = cast(byte*)internalBuffer.glyphs;
		infof("size: %d, glyphs: %(%02X %)", size, data[0 .. size*2]);
		
		data = cast(byte*)internalBuffer.pos;
		infof("size: %d, pos: %(%02X %)", size, data[0 .. size*2*4]);

		data = cast(byte*)internalBuffer.utf8text;
		infof("size: %d, textSize: %d, utf8text: %(%02X %)", size, TextSize, data[0 .. TextSize]);
	}

	this(SKRunBufferInternal buffer, int size, int textSize) {
		internalBuffer = buffer;
		Size = size;
		TextSize = textSize;
	}

	int Size; // { get; }

	int TextSize; // { get; }

	ushort[] GetGlyphSpan() {
		void* glyphs = internalBuffer.glyphs;
		if (glyphs is null) {
			return [];
		} else {
			ushort* dataPtr = cast(ushort*)glyphs;
			ushort[] data = dataPtr[0 .. Size];
			return data;
		}
		// return new ushort[] (cast(int)(internalBuffer.glyphs), cast(int)(internalBuffer.glyphs is null ? 0 : Size));
	}

	byte[] GetTextSpan () {
		void* utf8text = internalBuffer.utf8text;
		if (utf8text is null) {
			return [];
		} else {
			byte* dataPtr = cast(byte*)utf8text;
			byte[] data = dataPtr[0 .. TextSize];
			return data;
		}
		// return new byte[] (internalBuffer.utf8text, internalBuffer.utf8text is null ? 0 : TextSize);
	}

	uint[] GetClusterSpan () {
		void* clusters = internalBuffer.clusters;
		if (clusters is null) {
			return [];
		} else {
			uint* dataPtr = cast(uint*)clusters;
			uint[] data = dataPtr[0 .. Size];
			return data;
		}
		// return new uint[] (internalBuffer.clusters, internalBuffer.clusters is null ? 0 : Size);
	}

	void SetGlyphs(const(ushort)[] glyphs) {
		//  glyphs.CopyTo (GetGlyphSpan ());
		size_t len = glyphs.length;
		ushort[] dest = GetGlyphSpan();
		if (len > dest.length) {
			warning("out of range ");
		} else {
			dest[0 .. len] = glyphs[0 .. len];
		}
	}

	void SetText(const(byte)[] text) {
		//  text.CopyTo (GetTextSpan ());
		byte[] buffer = GetTextSpan ();
		buffer[0 .. text.length] = text[0 .. $];
	}

	void SetClusters(const(uint)[] clusters) {
		//  clusters.CopyTo (GetClusterSpan ());
		uint[] buffer = GetClusterSpan ();
		buffer[0 .. clusters.length] = clusters[0 .. $];
	}
}

class SKHorizontalRunBuffer : SKRunBuffer {
	this(SKRunBufferInternal buffer, int count) {
		super(buffer, count);
	}

	this(SKRunBufferInternal buffer, int count, int textSize) {
		super(buffer, count, textSize);
	}

	// Span!(float) GetPositionSpan ()	
	// {
	// 	return new float[] (internalBuffer.pos, internalBuffer.pos is null ? 0 : Size);
	// }

	void SetPositions(const(float)[] positions) {
		// return positions.CopyTo (GetPositionSpan ());
	}
}

class SKPositionedRunBuffer : SKRunBuffer {
	this(SKRunBufferInternal buffer, int count) {
		super(buffer, count);
	}

	this(SKRunBufferInternal buffer, int count, int textSize) {
		super(buffer, count, textSize);
	}

	SKPoint[] GetPositionSpan() {
		if(internalBuffer.pos is null)
			return null;

		SKPoint* pointPtr = cast(SKPoint*)internalBuffer.pos;
		return pointPtr[0..Size];
		// return SKPoint[] (internalBuffer.pos, internalBuffer.pos is null ? 0 : Size);

	}

	// Span!(SKPoint) GetPositionSpan ()
	// {
	//   return SKPoint[] (internalBuffer.pos, internalBuffer.pos is null ? 0 : Size);
	// }

	void SetPositions(const(SKPoint)[] positions) {
		warning("1111");
		// return positions.CopyTo (GetPositionSpan ());
	}

}

class SKRotationScaleRunBuffer : SKRunBuffer {
	this(SKRunBufferInternal buffer, int count) {
		super(buffer, count);
	}

	this(SKRunBufferInternal buffer, int count, int textSize) {
		super(buffer, count, textSize);
	}

	// Span!(SKRotationScaleMatrix) GetRotationScaleSpan ()
	// {
	//   return 	new SKRotationScaleMatrix[] (internalBuffer.pos, Size);
	// }

	void SetRotationScale(const(SKRotationScaleMatrix)[] positions) {
		// return positions.CopyTo (GetRotationScaleSpan ());
	}

}
