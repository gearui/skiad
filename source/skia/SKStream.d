module skia.SKStream;

import skia.Definitions;
import skia.SkiaApi;
import skia.Exceptions;
import skia.SKObject;
import skia.SKData;
import skia.SKStream;

/**
 * 
 */
class SKStream : SKObject
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	bool IsAtEnd()
	{
		return SkiaApi.sk_stream_is_at_end(cast(sk_stream_t*)Handle);
	}

	byte ReadSByte()
	{
		byte buffer;
		if (ReadSByte(buffer))
			return buffer;
		return byte.init;
	}

	short ReadInt16()
	{
		short buffer;
		if (ReadInt16(buffer))
			return buffer;
		return short.init;
	}

	int ReadInt32()
	{
		int buffer;
		if (ReadInt32(buffer))
			return buffer;
		return int.init;
	}

	ubyte ReadByte()
	{
		ubyte buffer;
		if (ReadByte(buffer))
			return buffer;
		return ubyte.init;
	}

	ushort ReadUInt16()
	{
		ushort buffer;
		if (ReadUInt16(buffer))
			return buffer;
		return ushort.init;
	}

	uint ReadUInt32()
	{
		uint buffer;
		if (ReadUInt32(buffer))
			return buffer;
		return uint.init;
	}

	bool ReadBool()
	{
		bool buffer;
		if (ReadBool(buffer))
			return buffer;
		return bool.init;
	}

	bool ReadSByte(ref byte buffer)
	{
		byte* b = &buffer;
		return SkiaApi.sk_stream_read_s8(cast(sk_stream_t*)Handle, b);
	}

	bool ReadInt16(ref short buffer)
	{
		short* b = &buffer;
		return SkiaApi.sk_stream_read_s16(cast(sk_stream_t*)Handle, b);
	}

	bool ReadInt32(ref int buffer)
	{
		int* b = &buffer;
		return SkiaApi.sk_stream_read_s32(cast(sk_stream_t*)Handle, b);
	}

	bool ReadByte(ref ubyte buffer)
	{
		ubyte* b = &buffer;
		return SkiaApi.sk_stream_read_u8(cast(sk_stream_t*)Handle, b);
	}

	bool ReadUInt16(ref ushort buffer)
	{
		ushort* b = &buffer;
		return SkiaApi.sk_stream_read_u16(cast(sk_stream_t*)Handle, b);
	}

	bool ReadUInt32(ref uint buffer)
	{
		uint* b = &buffer;
		return SkiaApi.sk_stream_read_u32(cast(sk_stream_t*)Handle, b);
	}

	bool ReadBool(ref bool buffer)
	{
		bool b;
		auto result = SkiaApi.sk_stream_read_bool(cast(sk_stream_t*)Handle, &b);
		buffer = b > 0;
		return result;
	}

	int Read(byte[] buffer, int size)
	{
		byte* b = buffer.ptr;
		return Read(cast(void*) b, size);
	}

	int Read(void* buffer, int size)
	{
		return cast(int) SkiaApi.sk_stream_read(cast(sk_stream_t*)Handle, cast(void*) buffer, cast(size_t) size);
	}

	int Peek(void* buffer, int size)
	{
		return cast(int) SkiaApi.sk_stream_peek(cast(sk_stream_t*)Handle, cast(void*) buffer, cast(size_t) size);
	}

	int Skip(int size)
	{
		return cast(int) SkiaApi.sk_stream_skip(cast(sk_stream_t*)Handle, cast(size_t) size);
	}

	bool Rewind()
	{
		return SkiaApi.sk_stream_rewind(cast(sk_stream_t*)Handle);
	}

	bool Seek(int position)
	{
		return SkiaApi.sk_stream_seek(cast(sk_stream_t*)Handle, cast(size_t) position);
	}

	bool Move(long offset)
	{
		return Move(cast(int) offset);
	}

	bool Move(int offset)
	{
		return SkiaApi.sk_stream_move(cast(sk_stream_t*)Handle, offset);
	}

	void* GetMemoryBase()
	{
		return cast(void*) SkiaApi.sk_stream_get_memory_base(cast(sk_stream_t*)Handle);
	}

	SKStream Fork()
	{
		return GetObject(SkiaApi.sk_stream_fork(cast(sk_stream_t*)Handle));
	}

	SKStream Duplicate()
	{
		return GetObject(SkiaApi.sk_stream_duplicate(cast(sk_stream_t*)Handle));
	}

	bool HasPosition()
	{

		return SkiaApi.sk_stream_has_position(cast(sk_stream_t*)Handle);

	}

	int Position()
	{
		return cast(int) SkiaApi.sk_stream_get_position(cast(sk_stream_t*)Handle);
	}

	void Position(int value)
	{
		Seek(value);
	}

	bool HasLength()
	{
		return SkiaApi.sk_stream_has_length(cast(sk_stream_t*)Handle);
	}

	int Length()
	{
		return cast(int) SkiaApi.sk_stream_get_length(cast(sk_stream_t*)Handle);
	}

	static SKStream GetObject(void* handle)
	{
		return GetOrAddObject!SKStream(handle, (h, o) {
			return new SKStreamImplementation(h, o);
		});
	}

}

class SKStreamImplementation : SKStream
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

	protected override void DisposeNative()
	{
		return SkiaApi.sk_stream_destroy(cast(sk_stream_t*)Handle);
	}

}

class SKStreamRewindable : SKStream
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}
}

class SKStreamSeekable : SKStreamRewindable
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}
}

class SKStreamAsset : SKStreamSeekable
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	// static new SKStreamAsset GetObject(void* handle)
	// {
	// 	// dfmt off
	// 	return 	GetOrAddObject!SKStreamAsset(handle, (h, o) { return new SKStreamAssetImplementation (h, o); });
	// 	// dfmt on
	// }

}

class SKStreamAssetImplementation : SKStreamAsset
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

	protected override void DisposeNative()
	{
		return SkiaApi.sk_stream_asset_destroy(cast(sk_stream_asset_t*)Handle);
	}
}

class SKStreamMemory : SKStreamAsset
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}
}

class SKFileStream : SKStreamAsset
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	this(string path)
	{
		super(CreateNew(path), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKFileStream instance.");
		}
	}

	private static void* CreateNew(string path)
	{
		// auto bytes = StringUtilities.GetEncodedText (path, SKTextEncoding.Utf8, true);
		// byte* p = cast(byte*) path.ptr;
		// return SkiaApi.sk_filestream_new(p);
    return SkiaApi.sk_filestream_new(path);
	}

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

  override void Dispose()
	{
		return super.Dispose();
	}

	protected override void DisposeNative()
	{
		return SkiaApi.sk_filestream_destroy(cast(sk_stream_filestream_t*)Handle);
	}

	bool IsValid()
	{
		return SkiaApi.sk_filestream_is_valid(cast(sk_stream_filestream_t*)Handle);
	}

	static bool IsPathSupported(string path)
	{
		return true;
	}

	static SKStreamAsset OpenStream(string path)
	{
		SKFileStream stream = new SKFileStream(path);
		if (!stream.IsValid)
		{
			stream.Dispose();
			stream = null;
		}
		return stream;
	}
}

class SKMemoryStream : SKStreamMemory
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	this()
	{
		this(SkiaApi.sk_memorystream_new(), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKMemoryStream instance.");
		}
	}

	this(ulong length)
	{
		this(SkiaApi.sk_memorystream_new_with_length(cast(void*) length), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKMemoryStream instance.");
		}
	}

	this(void* data, void* length, bool copyData = false)
	{
		this(SkiaApi.sk_memorystream_new_with_data(cast(void*) data, cast(int)length, copyData), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKMemoryStream instance.");
		}
	}

	this(SKData data)
	{
		this(SkiaApi.sk_memorystream_new_with_skdata(cast(sk_data_t*)data.Handle), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKMemoryStream instance.");
		}
	}

	this(byte[] data)
	{
		this();
		SetMemory(data);
	}

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

	protected override void DisposeNative()
	{
		return SkiaApi.sk_memorystream_destroy(cast(sk_stream_memorystream_t*)Handle);
	}

	void SetMemory(void* data, void* length, bool copyData = false)
	{
		SkiaApi.sk_memorystream_set_memory(cast(sk_stream_memorystream_t*)Handle, cast(void*) data, cast(int)length, copyData);
	}

	void SetMemory(byte[] data, void* length, bool copyData = false)
	{
		byte* d = data.ptr;
		SkiaApi.sk_memorystream_set_memory(cast(sk_stream_memorystream_t*)Handle, d, cast(int)length, copyData);
	}

	void SetMemory(byte[] data)
	{
		SetMemory(data, cast(void*) data.length, true);
	}
}

class SKWStream : SKObject
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	int BytesWritten()
	{

		return cast(int) SkiaApi.sk_wstream_bytes_written(cast(sk_wstream_t*)Handle);

	}

	bool Write(byte[] buffer, int size)
	{
		byte* b = buffer.ptr;
		return SkiaApi.sk_wstream_write(cast(sk_wstream_t*)Handle, cast(void*) b, cast(size_t) size);
	}

	bool NewLine()
	{
		return SkiaApi.sk_wstream_newline(cast(sk_wstream_t*)Handle);
	}

	void Flush()
	{
		SkiaApi.sk_wstream_flush(cast(sk_wstream_t*)Handle);
	}

	bool Write8(ubyte value)
	{
		return SkiaApi.sk_wstream_write_8(cast(sk_wstream_t*)Handle, value);
	}

	bool Write16(ushort value)
	{
		return SkiaApi.sk_wstream_write_16(cast(sk_wstream_t*)Handle, value);
	}

	bool Write32(uint value)
	{
		return SkiaApi.sk_wstream_write_32(cast(sk_wstream_t*)Handle, value);
	}

	bool WriteText(string value)
	{
		return SkiaApi.sk_wstream_write_text(cast(sk_wstream_t*)Handle, value);
	}

	bool WriteDecimalAsTest(int value)
	{
		return SkiaApi.sk_wstream_write_dec_as_text(cast(sk_wstream_t*)Handle, value);
	}

	bool WriteBigDecimalAsText(long value, int digits)
	{
		return SkiaApi.sk_wstream_write_bigdec_as_text(cast(sk_wstream_t*)Handle, value, digits);
	}

	bool WriteHexAsText(uint value, int digits)
	{
		return SkiaApi.sk_wstream_write_hex_as_text(cast(sk_wstream_t*)Handle, value, digits);
	}

	bool WriteScalarAsText(float value)
	{
		return SkiaApi.sk_wstream_write_scalar_as_text(cast(sk_wstream_t*)Handle, value);
	}

	bool WriteBool(bool value)
	{
		return SkiaApi.sk_wstream_write_bool(cast(sk_wstream_t*)Handle, value);
	}

	bool WriteScalar(float value)
	{
		return SkiaApi.sk_wstream_write_scalar(cast(sk_wstream_t*)Handle, value);
	}

	bool WritePackedUInt32(uint value)
	{
		return SkiaApi.sk_wstream_write_packed_uint(cast(sk_wstream_t*)Handle, cast(size_t) value);
	}

	bool WriteStream(SKStream input, int length)
	{
		if (input is null)
		{
			throw new ArgumentNullException("input");
		}

		return SkiaApi.sk_wstream_write_stream(cast(sk_wstream_t*)Handle, cast(sk_stream_t*)input.Handle, cast(size_t) length);
	}

	static int GetSizeOfPackedUInt32(uint value)
	{
		return SkiaApi.sk_wstream_get_size_of_packed_uint(cast(size_t) value);
	}
}

class SKFileWStream : SKWStream
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	this(string path)
	{
		super(CreateNew(path), true);
		if (Handle is null)
		{
			throw new InvalidOperationException("Unable to create a new SKFileWStream instance.");
		}
	}

	private static void* CreateNew(string path)
	{
		// auto bytes = StringUtilities.GetEncodedText (path, SKTextEncoding.Utf8, true);
		// byte* p = cast(byte*) bytes.ptr;
		// return SkiaApi.sk_filewstream_new(p);
    return SkiaApi.sk_filewstream_new(path);
	}

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

  override void Dispose()
  {
    return super.Dispose();
  }
	protected override void DisposeNative()
	{
		 SkiaApi.sk_filewstream_destroy(cast(sk_wstream_filestream_t*)Handle);
	}

	bool IsValid()
	{
		return SkiaApi.sk_filewstream_is_valid(cast(sk_wstream_filestream_t*)Handle);
	}

	static bool IsPathSupported(string path)
	{
		return true;
	}

	static SKWStream OpenStream(string path)
	{
		SKFileWStream stream = new SKFileWStream(path);
		if (!stream.IsValid)
		{
			stream.Dispose();
			stream = null;
		}
		return stream;
	}
}

class SKDynamicMemoryWStream : SKWStream
{
	this(void* handle, bool owns)
	{
		super(handle, owns);
	}

	this()
	{
		super(SkiaApi.sk_dynamicmemorywstream_new(), true);
		if (Handle is null)
		{
			throw new InvalidOperationException(
					"Unable to create a new SKDynamicMemoryWStream instance.");
		}
	}

	SKData CopyToData()
	{
		auto data = SKData.Create(BytesWritten);
		CopyTo(data.Data);
		return data;
	}

	// SKStreamAsset DetachAsStream()
	// {
	// 	return SKStreamAssetImplementation.GetObject(
	// 			SkiaApi.sk_dynamicmemorywstream_detach_as_stream(cast(sk_wstream_dynamicmemorystream_t*)Handle));
	// }

	SKData DetachAsData()
	{
		return SKData.GetObject(SkiaApi.sk_dynamicmemorywstream_detach_as_data(cast(sk_wstream_dynamicmemorystream_t*)Handle));
	}

	void CopyTo(void* data)
	{
		SkiaApi.sk_dynamicmemorywstream_copy_to(cast(sk_wstream_dynamicmemorystream_t*)Handle, cast(void*) data);
	}

	void CopyTo(byte[] data)
	{
		auto size = BytesWritten;
		if (data.length < size)
			throw new Exception(
					"Not enough space to copy. Expected at least {size}, but received {data.Length}.");

		void* d = data.ptr;
		SkiaApi.sk_dynamicmemorywstream_copy_to(cast(sk_wstream_dynamicmemorystream_t*)Handle, d);
	}

	bool CopyTo(SKWStream dst)
	{
		if (dst is null)
			throw new ArgumentNullException(dst.stringof);
		return SkiaApi.sk_dynamicmemorywstream_write_to_stream(cast(sk_wstream_dynamicmemorystream_t*)Handle, cast(sk_wstream_t*)dst.Handle);
	}

	// bool CopyTo(Stream dst)
	// {
	// 	if (dst is null)
	// 		throw new ArgumentNullException(dst.stringof);

	// 	auto wrapped = new SKManagedWStream(dst);
	// 	scope (exit)
	// 	{
	// 		wrapped.Dispose();
	// 	}

	// 	return CopyTo(wrapped);
	// }

	protected override void Dispose(bool disposing)
	{
		return super.Dispose(disposing);
	}

  override void Dispose()
  {
    return super.Dispose();
  }

	protected override void DisposeNative()
	{
		SkiaApi.sk_dynamicmemorywstream_destroy(cast(sk_wstream_dynamicmemorystream_t*)Handle);
	}
}
