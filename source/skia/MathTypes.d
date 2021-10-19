module skia.MathTypes;

import skia.Definitions;

import std.algorithm;
import std.format;
import std.math;

struct SKPoint {
	enum SKPoint Empty = SKPoint(0,0);

	// float x
	private float x;
	float X() {
		return x;
	}

	void X(float value) {
		x = value;
	}

	// float y
	private float y;
	float Y() {
		return y;
	}

	void Y(float value) {
		y = value;
	}

	// bool Equals (SKPoint obj) {
	// 	return x == obj.x && y == obj.y
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKPoint f && Equals (f)
	// }

	// static bool operator == (SKPoint left, SKPoint right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKPoint left, SKPoint right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (x);
	// 	hash.Add (y);
	// 	return hash.ToHashCode ();
	// }

	this(float x, float y) {
		this.x = x;
		this.y = y;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	float Length() {
		return cast(float) sqrt(x * x + y * y);
	}

	float LengthSquared() {
		return x * x + y * y;
	}

	void Offset(SKPoint p) {
		x += p.x;
		y += p.y;
	}

	void Offset(float dx, float dy) {
		x += dx;
		y += dy;
	}

	string ToString() {
		return format("{{X=%s, Y=%s}}", x, y);
	}

	static SKPoint Normalize(SKPoint point) {
		auto ls = point.x * point.x + point.y * point.y;
		auto invNorm = 1.0 / sqrt(ls);
		return SKPoint(cast(float)(point.x * invNorm), cast(float)(point.y * invNorm));
	}

	static float Distance(SKPoint point, SKPoint other) {
		auto dx = point.x - other.x;
		auto dy = point.y - other.y;
		auto ls = dx * dx + dy * dy;
		return cast(float) sqrt(ls);
	}

	static float DistanceSquared(SKPoint point, SKPoint other) {
		auto dx = point.x - other.x;
		auto dy = point.y - other.y;
		return dx * dx + dy * dy;
	}

	static SKPoint Reflect(SKPoint point, SKPoint normal) {
		auto dot = point.x * point.x + point.y * point.y;
		return SKPoint(point.x - 2.0f * dot * normal.x, point.y - 2.0f * dot * normal.y);
	}

	static SKPoint Add(SKPoint pt, SKSizeI sz) {
		return pt + sz;
	}

	static SKPoint Add(SKPoint pt, SKSize sz) {
		return pt + sz;
	}

	static SKPoint Add(SKPoint pt, SKPointI sz) {
		return pt + sz;
	}

	static SKPoint Add(SKPoint pt, SKPoint sz) {
		return pt + sz;
	}

	static SKPoint Subtract(SKPoint pt, SKSizeI sz) {
		return pt - sz;
	}

	static SKPoint Subtract(SKPoint pt, SKSize sz) {
		return pt - sz;
	}

	static SKPoint Subtract(SKPoint pt, SKPointI sz) {
		return pt - sz;
	}

	static SKPoint Subtract(SKPoint pt, SKPoint sz) {
		return pt - sz;
	}

	SKPoint opBinary(string op, T)(T sz) if (is(T == SKSizeI) || is(T == SKSize)) {
		static if (op == "+") {
			return SKPoint(this.X + sz.Width, this.Y + sz.Height);
		} else static if (op == "-") {
			return SKPoint(this.X - sz.Width, this.Y - sz.Height);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	SKPoint opBinary(string op, T)(T sz) if (is(T == SKPointI) || is(T == SKPoint)) {
		static if (op == "+") {
			return SKPoint(this.X + sz.X, this.Y + sz.Y);
		} else static if (op == "-") {
			return SKPoint(this.X - sz.X, this.Y - sz.Y);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	// static SKPoint operator + (SKPoint pt, SKSizeI sz)
	// {
	//   return SKPoint (pt.x + sz.Width, pt.y + sz.Height);
	// }

	// static SKPoint operator + (SKPoint pt, SKSize sz)
	// {
	//   return 	SKPoint (pt.x + sz.Width, pt.y + sz.Height);
	// }

	// static SKPoint operator + (SKPoint pt, SKPointI sz)
	// {
	//   return 	SKPoint (pt.x + sz.X, pt.y + sz.Y);
	// }

	// static SKPoint operator + (SKPoint pt, SKPoint sz)
	// {
	//   return SKPoint (pt.x + sz.X, pt.y + sz.Y);
	// }

	// static SKPoint operator - (SKPoint pt, SKSizeI sz)
	// {
	//   return SKPoint (pt.X - sz.Width, pt.Y - sz.Height);
	// }

	// static SKPoint operator - (SKPoint pt, SKSize sz)
	// {
	//   return SKPoint (pt.X - sz.Width, pt.Y - sz.Height);
	// }

	// static SKPoint operator - (SKPoint pt, SKPointI sz)
	// {
	//   return SKPoint (pt.X - sz.X, pt.Y - sz.Y);
	// }

	// static SKPoint operator - (SKPoint pt, SKPoint sz)
	// {
	//   return 	SKPoint (pt.X - sz.X, pt.Y - sz.Y);
	// }

}

struct SKPointI {
	enum SKPointI Empty = SKPointI();

	// int32_t x
	private int x;
	int X() {
		return x;
	}

	void X(int value) {
		x = value;
	}

	// int32_t y
	private int y;
	int Y() {
		return y;
	}

	void Y(int value) {
		y = value;
	}

	// bool Equals (SKPointI obj) {
	// 	return x == obj.x && y == obj.y
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKPointI f && Equals (f)
	// }

	// static bool operator == (SKPointI left, SKPointI right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKPointI left, SKPointI right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (x);
	// 	hash.Add (y);
	// 	return hash.ToHashCode ();
	// }

	this(SKSizeI sz) {
		x = sz.Width;
		y = sz.Height;
	}

	this(int x, int y) {
		this.x = x;
		this.y = y;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	int Length() {
		return cast(int) sqrt(cast(float) x * x + y * y);
	}

	int LengthSquared() {
		return x * x + y * y;
	}

	void Offset(SKPointI p) {
		x += p.X;
		y += p.Y;
	}

	void Offset(int dx, int dy) {
		x += dx;
		y += dy;
	}

	string ToString() {
		return "{{X={x},Y={y}}}";
	}

	static SKPointI Normalize(SKPointI point) {
		auto ls = point.x * point.x + point.y * point.y;
		auto invNorm = 1.0 / sqrt(cast(float) ls);
		return SKPointI(cast(int)(point.x * invNorm), cast(int)(point.y * invNorm));
	}

	static float Distance(SKPointI point, SKPointI other) {
		auto dx = point.x - other.x;
		auto dy = point.y - other.y;
		auto ls = dx * dx + dy * dy;
		return cast(float) sqrt(cast(float) ls);
	}

	static float DistanceSquared(SKPointI point, SKPointI other) {
		auto dx = point.x - other.x;
		auto dy = point.y - other.y;
		return dx * dx + dy * dy;
	}

	static SKPointI Reflect(SKPointI point, SKPointI normal) {
		auto dot = point.x * point.x + point.y * point.y;
		return SKPointI(cast(int)(point.x - 2.0f * dot * normal.x),
				cast(int)(point.y - 2.0f * dot * normal.y));
	}

	static SKPointI Ceiling(SKPoint value) {
		int x, y;
		// checked {
		x = cast(int) ceil(value.X);
		y = cast(int) ceil(value.Y);
		// }

		return SKPointI(x, y);
	}

	static SKPointI Round(SKPoint value) {
		int x, y;
		// checked {
		x = cast(int) round(value.X);
		y = cast(int) round(value.Y);
		// }

		return SKPointI(x, y);
	}

	static SKPointI Truncate(SKPoint value) {
		int x, y;
		// checked {
		x = cast(int) value.X;
		y = cast(int) value.Y;
		// }

		return SKPointI(x, y);
	}

	static SKPointI Add(SKPointI pt, SKSizeI sz) {
		return pt + sz;
	}

	static SKPointI Add(SKPointI pt, SKPointI sz) {
		return pt + sz;
	}

	static SKPointI Subtract(SKPointI pt, SKSizeI sz) {
		return pt - sz;
	}

	static SKPointI Subtract(SKPointI pt, SKPointI sz) {
		return pt - sz;
	}

	SKPointI opBinary(string op, T)(T sz) if (is(T == SKSizeI)) {
		static if (op == "+") {
			return SKPointI(this.X + sz.Width, this.Y + sz.Height);
		} else static if (op == "-") {
			return SKPointI(this.X - sz.Width, this.Y - sz.Height);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	SKPointI opBinary(string op, T)(T sz) if (is(T == SKPointI)) {
		static if (op == "+") {
			return SKPointI(this.X + sz.X, this.Y + sz.Y);
		} else static if (op == "-") {
			return SKPointI(this.X - sz.X, this.Y - sz.Y);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	// static SKPointI operator + (SKPointI pt, SKSizeI sz)
	// {
	//   return SKPointI (pt.X + sz.Width, pt.Y + sz.Height);
	// }

	// static SKPointI operator + (SKPointI pt, SKPointI sz)
	// {
	//   return SKPointI (pt.X + sz.X, pt.Y + sz.Y);
	// }

	// static SKPointI operator - (SKPointI pt, SKSizeI sz)
	// {
	//   return SKPointI (pt.X - sz.Width, pt.Y - sz.Height);
	// }

	// static SKPointI operator - (SKPointI pt, SKPointI sz)
	// {
	//   return SKPointI (pt.X - sz.X, pt.Y - sz.Y);
	// }

	// static explicit operator SKSizeI (SKPointI p)
	// {
	//   return 	SKSizeI (p.X, p.Y);
	// }

	// static implicit operator SKPoint (SKPointI p)
	// {
	//   return SKPoint (p.X, p.Y);
	// }

}

struct SKPoint3 {
	enum SKPoint3 Empty = SKPoint3(0, 0, 0);

	// float x

	// bool Equals (SKPoint3 obj) {
	// 	return x == obj.x && y == obj.y && z == obj.z
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKPoint3 f && Equals (f)
	// }

	// static bool operator == (SKPoint3 left, SKPoint3 right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKPoint3 left, SKPoint3 right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (x);
	// 	hash.Add (y);
	// 	hash.Add (z);
	// 	return hash.ToHashCode ();
	// }

	this(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	string ToString() {
		return format("{{X=%s, Y=%s, Z=%s}}", x, y, z);
	}

	static SKPoint3 Add(SKPoint3 pt, SKPoint3 sz) {
		return pt + sz;
	}

	static SKPoint3 Subtract(SKPoint3 pt, SKPoint3 sz) {
		return pt - sz;
	}

	SKPoint3 opBinary(string op)(SKPoint3 sz) {
		static if (op == "+") {
			return SKPoint3(this.X + sz.X, this.Y + sz.Y, this.Z + sz.Z);
		} else static if (op == "-") {
			return SKPoint3(this.X - sz.X, this.Y - sz.Y, this.Z - sz.Z);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	// static SKPoint3 operator + (SKPoint3 pt, SKPoint3 sz)
	// {
	//   return 	new SKPoint3 (pt.X + sz.X, pt.Y + sz.Y, pt.Z + sz.Z);
	// }

	// static SKPoint3 operator - (SKPoint3 pt, SKPoint3 sz)
	// {
	//   return new SKPoint3 (pt.X - sz.X, pt.Y - sz.Y, pt.Z - sz.Z);
	// }

	private float x;
	float X() {
		return x;
	}

	void X(float value) {
		x = value;
	}

	// float y
	private float y;
	float Y() {
		return y;
	}

	void Y(float value) {
		y = value;
	}

	// float z
	private float z;
	float Z() {
		return z;
	}

	void Z(float value) {
		z = value;
	}

}

struct SKSize {
	enum SKSize Empty = SKSize(0, 0);

	// float w
	private float w;
	float Width() {
		return w;
	}

	void Width(float value) {
		w = value;
	}

	// float h
	private float h;
	float Height() {
		return h;
	}

	void Height(float value) {
		h = value;
	}

	// bool Equals (SKSize obj) {
	// 	return w == obj.w && h == obj.h
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKSize f && Equals (f)
	// }

	// static bool operator == (SKSize left, SKSize right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKSize left, SKSize right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (w);
	// 	hash.Add (h);
	// 	return hash.ToHashCode ();
	// }

	this(float width, float height) {
		w = width;
		h = height;
	}

	this(SKPoint pt) {
		w = pt.X;
		h = pt.Y;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	SKPoint ToPoint() {
		return SKPoint(w, h);
	}

	SKSizeI ToSizeI() {
		int w, h;
		// checked {
		w = cast(int) this.w;
		h = cast(int) this.h;
		// }

		return SKSizeI(w, h);
	}

	string ToString() {
		return "{{Width={w}, Height={h}}}";
	}

	static SKSize Add(SKSize sz1, SKSize sz2) {
		return sz1 + sz2;
	}

	static SKSize Subtract(SKSize sz1, SKSize sz2) {
		return sz1 - sz2;
	}

	SKSize opBinary(string op)(SKSize sz) {
		static if (op == "+") {
			return SKSize(this.Width + sz.Width, this.Height + sz.Height);
		} else static if (op == "-") {
			return SKSize(this.Width - sz.Width, this.Height - sz.Height);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	SKPoint opCast(SKPoint)() {
		return SKPoint(this.Width, this.Height);
	}

	SKSize opCast(SKSize)() {
		return SKSize(this.Width, this.Height);
	}

	// static SKSize operator + (SKSize sz1, SKSize sz2)
	// {
	//   return SKSize (sz1.Width + sz2.Width, sz1.Height + sz2.Height);
	// }

	// static SKSize operator - (SKSize sz1, SKSize sz2)
	// {
	//   return 	SKSize (sz1.Width - sz2.Width, sz1.Height - sz2.Height);

	// }

	// static explicit operator SKPoint (SKSize size)
	// {
	//   return SKPoint (size.Width, size.Height);
	// }

	// static implicit operator SKSize (SKSizeI size)
	// {
	//   return SKSize (size.Width, size.Height);
	// }

}

struct SKSizeI {
	enum SKSizeI Empty = SKSizeI(0, 0);

	// int32_t w
	private int w;
	int Width() {
		return w;
	}

	void Width(int value) {
		w = value;
	}

	// int32_t h
	private int h;
	int Height() {
		return h;
	}

	void Height(int value) {
		h = value;
	}

	// bool Equals (SKSizeI obj) {
	// 	return w == obj.w && h == obj.h
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKSizeI f && Equals (f)
	// }

	// static bool operator == (SKSizeI left, SKSizeI right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKSizeI left, SKSizeI right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (w);
	// 	hash.Add (h);
	// 	return hash.ToHashCode ();
	// }

	this(int width, int height) {
		w = width;
		h = height;
	}

	this(SKPointI pt) {
		w = pt.X;
		h = pt.Y;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	SKPointI ToPointI() {
		return SKPointI(w, h);
	}

	string ToString() {
		return "{{Width={w}, Height={h}}}";
	}

	static SKSizeI Add(SKSizeI sz1, SKSizeI sz2) {
		return sz1 + sz2;
	}

	static SKSizeI Subtract(SKSizeI sz1, SKSizeI sz2) {
		return sz1 - sz2;
	}

	SKSizeI opBinary(string op)(SKSizeI sz) {
		static if (op == "+") {
			return SKSizeI(this.Width + sz.Width, this.Height + sz.Height);
		} else static if (op == "-") {
			return SKSizeI(this.Width - sz.Width, this.Height - sz.Height);
		} else {
			static assert(false, op ~ " is not suuuported");
		}
	}

	// static SKSizeI operator + (SKSizeI sz1, SKSizeI sz2)
	// {
	//   return SKSizeI (sz1.Width + sz2.Width, sz1.Height + sz2.Height);
	// }

	// static SKSizeI operator - (SKSizeI sz1, SKSizeI sz2)
	// {
	//   return SKSizeI (sz1.Width - sz2.Width, sz1.Height - sz2.Height);
	// }

	// static explicit operator SKPointI (SKSizeI size)
	// {
	//   return 	SKPointI (size.Width, size.Height);
	// }

}

struct SKRect {
	enum SKRect Empty = SKRect(0, 0, 0, 0);

	// float left
	private float left;
	float Left() {
		return left;
	}

	void Left(float value) {
		left = value;
	}

	// float top
	private float top;
	float Top() {
		return top;
	}

	void Top(float value) {
		top = value;
	}

	// float right
	private float right;
	float Right() {
		return right;
	}

	void Right(float value) {
		right = value;
	}

	// float bottom
	private float bottom;
	float Bottom() {
		return bottom;
	}

	void Bottom(float value) {
		bottom = value;
	}

	// bool Equals (SKRect obj) {
	// 	return left == obj.left && top == obj.top && right == obj.right && bottom == obj.bottom
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKRect f && Equals (f)
	// }

	// static bool operator == (SKRect left, SKRect right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKRect left, SKRect right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (left);
	// 	hash.Add (top);
	// 	hash.Add (right);
	// 	hash.Add (bottom);
	// 	return hash.ToHashCode ();
	// }

	this(float left, float top, float right, float bottom) {
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
	}

	float MidX() {
		return left + (Width / 2f);
	}

	float MidY() {
		return top + (Height / 2f);
	}

	float Width() {
		return right - left;
	}

	float Height() {
		return bottom - top;
	}

	bool IsEmpty() {
		return this == Empty;
	}

	SKSize Size() {
		return SKSize(Width, Height);
	}

	void Size(SKSize value) {
		right = left + value.Width;
		bottom = top + value.Height;
	}

	SKPoint Location() {
		return SKPoint(left, top);
	}

	void Location(SKPoint value) {
		this = SKRect.Create(value, Size);
	}

	SKRect Standardized() {

		if (left > right) {
			if (top > bottom) {
				return SKRect(right, bottom, left, top);
			} else {
				return SKRect(right, top, left, bottom);
			}
		} else {
			if (top > bottom) {
				return SKRect(left, bottom, right, top);
			} else {
				return SKRect(left, top, right, bottom);
			}
		}

	}

	SKRect AspectFit(SKSize size) {
		return AspectResize(size, true);
	}

	SKRect AspectFill(SKSize size) {
		return AspectResize(size, false);
	}

	private SKRect AspectResize(SKSize size, bool fit) {
		if (size.Width == 0 || size.Height == 0 || Width == 0 || Height == 0)
			return Create(MidX, MidY, 0, 0);

		auto aspectWidth = size.Width;
		auto aspectHeight = size.Height;
		auto imgAspect = aspectWidth / aspectHeight;
		auto fullRectAspect = Width / Height;

		auto compare = fit ? (fullRectAspect > imgAspect) : (fullRectAspect < imgAspect);
		if (compare) {
			aspectHeight = Height;
			aspectWidth = aspectHeight * imgAspect;
		} else {
			aspectWidth = Width;
			aspectHeight = aspectWidth / imgAspect;
		}
		auto aspectLeft = MidX - (aspectWidth / 2f);
		auto aspectTop = MidY - (aspectHeight / 2f);

		return Create(aspectLeft, aspectTop, aspectWidth, aspectHeight);
	}

	static SKRect Inflate(SKRect rect, float x, float y) {
		auto r = SKRect(rect.left, rect.top, rect.right, rect.bottom);
		r.Inflate(x, y);
		return r;
	}

	void Inflate(SKSize size) {
		Inflate(size.Width, size.Height);
	}

	void Inflate(float x, float y) {
		left -= x;
		top -= y;
		right += x;
		bottom += y;
	}

	static SKRect Intersect(SKRect a, SKRect b) {
		if (!a.IntersectsWithInclusive(b)) {
			return Empty;
		}
		return SKRect(max(a.left, b.left), max(a.top, b.top), min(a.right,
				b.right), min(a.bottom, b.bottom));
	}

	void Intersect(SKRect rect) {
		SKRect.Intersect(this, rect);
	}

	static SKRect Union(SKRect a, SKRect b) {
		return SKRect(min(a.left, b.left), min(a.top, b.top), max(a.right,
				b.right), max(a.bottom, b.bottom));
	}

	void Union(SKRect rect) {
		Union(this, rect);
	}

	SKRect opCast(SKRect)() {
		return SKRect(this.Left, this.Top, this.Right, this.Bottom);
	}

	// static implicit operator SKRect (SKRectI r)
	// {
	//   return 	SKRect (r.Left, r.Top, r.Right, r.Bottom);
	// }

	bool Contains(float x, float y) {
		return (x >= left) && (x < right) && (y >= top) && (y < bottom);
	}

	bool Contains(SKPoint pt) {
		return Contains(pt.X, pt.Y);
	}

	bool Contains(SKRect rect) {
		return (left <= rect.left) && (right >= rect.right) && (top <= rect.top)
			&& (bottom >= rect.bottom);
	}

	bool IntersectsWith(SKRect rect) {
		return (left < rect.right) && (right > rect.left) && (top < rect.bottom)
			&& (bottom > rect.top);
	}

	bool IntersectsWithInclusive(SKRect rect) {
		return (left <= rect.right) && (right >= rect.left)
			&& (top <= rect.bottom) && (bottom >= rect.top);
	}

	void Offset(float x, float y) {
		left += x;
		top += y;
		right += x;
		bottom += y;
	}

	void Offset(SKPoint pos) {
		return Offset(pos.X, pos.Y);
	}

	string ToString() {
		return format("{{Left=%s,Top=%s,Width=%s,Height=%s}}", Left, Top, Width, Height);
	}

	static SKRect Create(int width, int height) {
		return SKRect(SKPoint.Empty.X, SKPoint.Empty.Y, width, height);
	}

	static SKRect Create(SKPoint location, SKSize size) {
		return Create(location.X, location.Y, size.Width, size.Height);
	}

	static SKRect Create(SKSize size) {
		return Create(SKPoint.Empty, size);
	}

	static SKRect Create(float width, float height) {
		return SKRect(SKPoint.Empty.X, SKPoint.Empty.Y, width, height);
	}

	static SKRect Create(float x, float y, float width, float height) {
		return SKRect(x, y, x + width, y + height);
	}

}

struct SKRectI {
	static SKRectI Empty;

	// int32_t left
	private int left;
	int Left() {
		return left;
	}

	void Left(int value) {
		left = value;
	}

	// int32_t top
	private int top;
	int Top() {
		return top;
	}

	void Top(int value) {
		top = value;
	}

	// int32_t right
	private int right;
	int Right() {
		return right;
	}

	void Right(int value) {
		right = value;
	}

	// int32_t bottom
	private int bottom;
	int Bottom() {
		return bottom;
	}

	void Bottom(int value) {
		bottom = value;
	}

	// bool Equals (SKRectI obj) {
	// 	return left == obj.left && top == obj.top && right == obj.right && bottom == obj.bottom
	// }

	// override bool Equals (object obj) {
	// 	return obj is SKRectI f && Equals (f)
	// }

	// static bool operator == (SKRectI left, SKRectI right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKRectI left, SKRectI right) {
	// 	return !left.Equals (right)
	// }

	// override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (left);
	// 	hash.Add (top);
	// 	hash.Add (right);
	// 	hash.Add (bottom);
	// 	return hash.ToHashCode ();
	// }

	this(int left, int top, int right, int bottom) {
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
	}

	int MidX() {
		return left + (Width / 2);
	}

	int MidY() {
		return top + (Height / 2);
	}

	int Width() {
		return right - left;
	}

	int Height() {
		return bottom - top;

	}

	bool IsEmpty() {
		return this == Empty;
	}

	SKSizeI Size() {
		return SKSizeI(Width, Height);
	}

	void Size(SKSizeI value) {
		right = left + value.Width;
		bottom = top + value.Height;
	}

	SKPointI Location() {
		return SKPointI(left, top);
	}

	void Location(SKPointI value) {

		this = SKRectI.Create(value, Size);
	}

	SKRectI Standardized() {

		if (left > right) {
			if (top > bottom) {
				return SKRectI(right, bottom, left, top);
			} else {
				return SKRectI(right, top, left, bottom);
			}
		} else {
			if (top > bottom) {
				return SKRectI(left, bottom, right, top);
			} else {
				return SKRectI(left, top, right, bottom);
			}
		}

	}

	SKRectI AspectFit(SKSizeI size) {
		return Truncate((cast(SKRect) this).AspectFit(cast(SKSize) size));
	}

	SKRectI AspectFill(SKSizeI size) {
		return Truncate((cast(SKRect) this).AspectFill(cast(SKSize) size));
	}

	static SKRectI Ceiling(SKRect value) {
		return Ceiling(value, false);
	}

	static SKRectI Ceiling(SKRect value, bool outwards) {
		int x, y, r, b;
		// checked {
		x = cast(int)(outwards && value.Width > 0 ? floor(value.Left) : ceil(value.Left));
		y = cast(int)(outwards && value.Height > 0 ? floor(value.Top) : ceil(value.Top));
		r = cast(int)(outwards && value.Width < 0 ? floor(value.Right) : ceil(value.Right));
		b = cast(int)(outwards && value.Height < 0 ? floor(value.Bottom) : ceil(value.Bottom));
		// }

		return SKRectI(x, y, r, b);
	}

	static SKRectI Inflate(SKRectI rect, int x, int y) {
		auto r = SKRectI(rect.left, rect.top, rect.right, rect.bottom);
		r.Inflate(x, y);
		return r;
	}

	void Inflate(SKSizeI size) {
		return Inflate(size.Width, size.Height);
	}

	void Inflate(int width, int height) {
		left -= width;
		top -= height;
		right += width;
		bottom += height;
	}

	static SKRectI Intersect(SKRectI a, SKRectI b) {
		if (!a.IntersectsWithInclusive(b))
			return Empty;

		return SKRectI(max(a.left, b.left), max(a.top, b.top), min(a.right,
				b.right), min(a.bottom, b.bottom));
	}

	// 	void Intersect (SKRectI rect)
	//   {
	//     return this = Intersect (this, rect);
	//   }

	static SKRectI Round(SKRect value) {
		int x, y, r, b;
		// checked {
		x = cast(int) round(value.Left);
		y = cast(int) round(value.Top);
		r = cast(int) round(value.Right);
		b = cast(int) round(value.Bottom);
		// }

		return SKRectI(x, y, r, b);
	}

	static SKRectI Floor(SKRect value) {
		return Floor(value, false);
	}

	static SKRectI Floor(SKRect value, bool inwards) {
		int x, y, r, b;
		// checked {
		x = cast(int)(inwards && value.Width > 0 ? ceil(value.Left) : floor(value.Left));
		y = cast(int)(inwards && value.Height > 0 ? ceil(value.Top) : floor(value.Top));
		r = cast(int)(inwards && value.Width < 0 ? ceil(value.Right) : floor(value.Right));
		b = cast(int)(inwards && value.Height < 0 ? ceil(value.Bottom) : floor(value.Bottom));
		// }

		return SKRectI(x, y, r, b);
	}

	static SKRectI Truncate(SKRect value) {
		int x, y, r, b;
		// checked {
		x = cast(int) value.Left;
		y = cast(int) value.Top;
		r = cast(int) value.Right;
		b = cast(int) value.Bottom;
		// }

		return SKRectI(x, y, r, b);
	}

	static SKRectI Union(SKRectI a, SKRectI b) {
		return SKRectI(min(a.Left, b.Left), min(a.Top, b.Top), max(a.Right,
				b.Right), max(a.Bottom, b.Bottom));
	}

	void Union(SKRectI rect) {
		Union(this, rect);
	}

	bool Contains(int x, int y) {
		return (x >= left) && (x < right) && (y >= top) && (y < bottom);
	}

	bool Contains(SKPointI pt) {
		return Contains(pt.X, pt.Y);
	}

	bool Contains(SKRectI rect) {
		return (left <= rect.left) && (right >= rect.right) && (top <= rect.top)
			&& (bottom >= rect.bottom);

	}

	bool IntersectsWith(SKRectI rect) {
		return (left < rect.right) && (right > rect.left) && (top < rect.bottom)
			&& (bottom > rect.top);
	}

	bool IntersectsWithInclusive(SKRectI rect) {
		return (left <= rect.right) && (right >= rect.left)
			&& (top <= rect.bottom) && (bottom >= rect.top);
	}

	void Offset(int x, int y) {
		left += x;
		top += y;
		right += x;
		bottom += y;
	}

	void Offset(SKPointI pos) {
		return Offset(pos.X, pos.Y);
	}

	string ToString() {
		return "{{Left={Left},Top={Top},Width={Width},Height={Height}}}";
	}

	static SKRectI Create(SKSizeI size) {
		return Create(SKPointI.Empty.X, SKPointI.Empty.Y, size.Width, size.Height);
	}

	static SKRectI Create(SKPointI location, SKSizeI size) {
		return Create(location.X, location.Y, size.Width, size.Height);
	}

	static SKRectI Create(int width, int height) {
		return SKRectI(SKPointI.Empty.X, SKPointI.Empty.X, width, height);

	}

	static SKRectI Create(int x, int y, int width, int height) {
		return SKRectI(x, y, x + width, y + height);
	}

}
