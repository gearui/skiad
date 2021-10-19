module skia.SKMatrix;

import skia.Definitions;
import skia.Exceptions;
import skia.MathTypes;
import skia.SkiaApi;
// import skia.SKPoint;

import std.math;

struct SKMatrix
{
	enum float DegreesToRadians = cast(float)PI / 180.0f;

	enum SKMatrix Empty = SKMatrix();

	// float scaleX
	private float scaleX;
	float ScaleX() {
		return scaleX;
	}

	void ScaleX(float value) {
		scaleX = value;
	}

	// float skewX
	private float skewX;
	float SkewX() {
		return skewX;
	}

	void SkewX(float value) {
		skewX = value;
	}

	// float transX
	private float transX;
	float TransX() {
		return transX;
	}

	void TransX(float value) {
		transX = value;
	}

	// float skewY
	private float skewY;
	float SkewY() {
		return skewY;
	}

	void SkewY(float value) {
		skewY = value;
	}

	// float scaleY
	private float scaleY;
	float ScaleY() {
		return scaleY;
	}

	void ScaleY(float value) {
		scaleY = value;
	}

	// float transY
	private float transY;
	float TransY() {
		return transY;
	}

	void TransY(float value) {
		transY = value;
	}

	// float persp0
	private float persp0;
	float Persp0() {
		return persp0;
	}

	void Persp0(float value) {
		persp0 = value;
	}

	// float persp1
	private float persp1;
	float Persp1() {
		return persp1;
	}

	void Persp1(float value) {
		persp1 = value;
	}

	// float persp2
	private float persp2;
	float Persp2() {
		return persp2;
	}

	void Persp2(float value) {
		persp2 = value;
	}

	// const bool Equals (SKMatrix obj) {
	// 	return scaleX == obj.scaleX && skewX == obj.skewX && transX == obj.transX && skewY == obj.skewY && scaleY == obj.scaleY && transY == obj.transY && persp0 == obj.persp0 && persp1 == obj.persp1 && persp2 == obj.persp2
	// }

	// const override bool Equals (object obj) {
	// 	return obj is SKMatrix f && Equals (f)
	// }

	// static bool operator == (SKMatrix left, SKMatrix right) {
	// 	return left.Equals (right)
	// }

	// static bool operator != (SKMatrix left, SKMatrix right) {
	// 	return !left.Equals (right)
	// }

	// const override int GetHashCode ()
	// {
	// 	var hash = new HashCode ();
	// 	hash.Add (scaleX);
	// 	hash.Add (skewX);
	// 	hash.Add (transX);
	// 	hash.Add (skewY);
	// 	hash.Add (scaleY);
	// 	hash.Add (transY);
	// 	hash.Add (persp0);
	// 	hash.Add (persp1);
	// 	hash.Add (persp2);
	// 	return hash.ToHashCode ();
	// }

static SKMatrix Identity()
  {
    SKMatrix matrix;
    matrix.scaleX = 1; 
    matrix.scaleY = 1;
    matrix.persp2 = 1;
    return matrix;
  } 

	private static struct Indices
	{
		enum ScaleX = 0;
		enum SkewX = 1;
		enum TransX = 2;
		enum SkewY = 3;
		enum ScaleY = 4;
		enum TransY = 5;
		enum Persp0 = 6;
		enum Persp1 = 7;
		enum Persp2 = 8;

		enum Count = 9;
	}

	this (float[] values)
	{
		if (values is null)
			throw new ArgumentNullException (values.stringof);
		if (values.length != Indices.Count)
			throw new ArgumentException ("The matrix array must have a length of {Indices.Count}.", values.stringof);

		scaleX = values[Indices.ScaleX];
		skewX = values[Indices.SkewX];
		transX = values[Indices.TransX];

		skewY = values[Indices.SkewY];
		scaleY = values[Indices.ScaleY];
		transY = values[Indices.TransY];

		persp0 = values[Indices.Persp0];
		persp1 = values[Indices.Persp1];
		persp2 = values[Indices.Persp2];
	}

	this (
		float scaleX, float skewX, float transX,
		float skewY, float scaleY, float transY,
		float persp0, float persp1, float persp2)
	{
		this.scaleX = scaleX;
		this.skewX = skewX;
		this.transX = transX;
		this.skewY = skewY;
		this.scaleY = scaleY;
		this.transY = transY;
		this.persp0 = persp0;
		this.persp1 = persp1;
		this.persp2 = persp2;
	}

	const bool IsIdentity()
	{
		return this == (Identity);
	} 

	// Values

	float[] Values() {
		return
			[
				scaleX, skewX, transX,
				skewY, scaleY, transY,
				persp0, persp1, persp2
      ];
		
	}
   void Values(float[] value) {
	
			if (value is null)
				throw new ArgumentNullException (Values.stringof);
			if (value.length != Indices.Count)
				throw new ArgumentException ("The matrix array must have a length of {Indices.Count}.", Values.stringof);

			scaleX = value[Indices.ScaleX];
			skewX = value[Indices.SkewX];
			transX = value[Indices.TransX];

			skewY = value[Indices.SkewY];
			scaleY = value[Indices.ScaleY];
			transY = value[Indices.TransY];

			persp0 = value[Indices.Persp0];
			persp1 = value[Indices.Persp1];
			persp2 = value[Indices.Persp2];
		
	}

	const void GetValues (float[] values)
	{
		if (values is null)
			throw new ArgumentNullException (values.stringof);
		if (values.length != Indices.Count)
			throw new ArgumentException ("The matrix array must have a length of {Indices.Count}.", values.stringof);

		values[Indices.ScaleX] = scaleX;
		values[Indices.SkewX] = skewX;
		values[Indices.TransX] = transX;

		values[Indices.SkewY] = skewY;
		values[Indices.ScaleY] = scaleY;
		values[Indices.TransY] = transY;

		values[Indices.Persp0] = persp0;
		values[Indices.Persp1] = persp1;
		values[Indices.Persp2] = persp2;
	}

	// Create*

	static SKMatrix CreateIdentity ()
    {
      SKMatrix matrix = SKMatrix();
      matrix.scaleX = 1;
      matrix.scaleY = 1; 
      matrix.persp2 = 1;
      
      return matrix;
    }
		
	static SKMatrix CreateTranslation (float x, float y)
	{
		if (x == 0 && y == 0)
			return Identity;

    SKMatrix matrix =  SKMatrix();
		matrix.scaleX = 1;
		matrix.scaleY = 1;
		matrix.transX = x;
		matrix.transY = y;
		matrix.persp2 = 1;
		return matrix;
	}

	static SKMatrix CreateScale (float x, float y)
	{
		if (x == 1 && y == 1)
			return Identity;

    SKMatrix matrix =  SKMatrix();
		matrix.scaleX = x;
		matrix.scaleY = y;
		matrix.persp2 = 1;
    return matrix;
	}

	static SKMatrix CreateScale (float x, float y, float pivotX, float pivotY)
	{
		if (x == 1 && y == 1)
			return Identity;

		auto tx = pivotX - x * pivotX;
		auto ty = pivotY - y * pivotY;

    SKMatrix matrix =  SKMatrix();
		matrix.scaleX = x;
		matrix.scaleY = y;
		matrix.transX = tx;
		matrix.transY = ty;
		matrix.persp2 = 1;
    return matrix;
	}

	static SKMatrix CreateRotation (float radians)
	{
		if (radians == 0)
			return Identity;

		auto sin = cast(float)sin (radians);
		auto cos = cast(float)cos (radians);

		auto matrix = Identity;
		SetSinCos ( matrix, sin, cos);
		return matrix;
	}

	static SKMatrix CreateRotation (float radians, float pivotX, float pivotY)
	{
		if (radians == 0)
			return Identity;

		auto sin = cast(float)sin (radians);
		auto cos = cast(float)cos (radians);

		auto matrix = Identity;
		SetSinCos (matrix, sin, cos, pivotX, pivotY);
		return matrix;
	}

	static SKMatrix CreateRotationDegrees (float degrees)
	{
		if (degrees == 0)
			return Identity;

		return CreateRotation (degrees * DegreesToRadians);
	}

	static SKMatrix CreateRotationDegrees (float degrees, float pivotX, float pivotY)
	{
		if (degrees == 0)
			return Identity;

		return CreateRotation (degrees * DegreesToRadians, pivotX, pivotY);
	}

	static SKMatrix CreateSkew (float x, float y)
	{
		if (x == 0 && y == 0)
			return Identity;

    SKMatrix matrix =  SKMatrix();

		matrix.scaleX = 1;
		matrix.skewX = x;
		matrix.skewY = y;
		matrix.scaleY = 1;
		matrix.persp2 = 1;
    
    return matrix;
	}

	static SKMatrix CreateScaleTranslation (float sx, float sy, float tx, float ty)
	{
		if (sx == 0 && sy == 0 && tx == 0 && ty == 0)
			return Identity;

    SKMatrix matrix =  SKMatrix();

		matrix.scaleX = sx;
		matrix.skewX = 0;
		matrix.transX = tx;

		matrix.skewY = 0;
		matrix.scaleY = sy;
		matrix.transY = ty;

		matrix.persp0 = 0;
		matrix.persp1 = 0;
		matrix.persp2 = 1;
    
    return matrix;
	}

	// Make*

	static SKMatrix MakeIdentity ()	
  {
		return CreateIdentity ();
	}

	static SKMatrix MakeScale (float sx, float sy)	
  {
		return CreateScale (sx, sy);
	}

	static SKMatrix MakeScale (float sx, float sy, float pivotX, float pivotY)	
  {
		return CreateScale (sx, sy, pivotX, pivotY);
	}

	static SKMatrix MakeTranslation (float dx, float dy)	
  {
		return CreateTranslation (dx, dy);
	}

	static SKMatrix MakeRotation (float radians)	
  {
		return CreateRotation (radians);
	}

	static SKMatrix MakeRotation (float radians, float pivotx, float pivoty)	
  {
		return CreateRotation (radians, pivotx, pivoty);
	}

	static SKMatrix MakeRotationDegrees (float degrees)	
  {
		return CreateRotationDegrees (degrees);
	}

	static SKMatrix MakeRotationDegrees (float degrees, float pivotx, float pivoty)	
  {
		return CreateRotationDegrees (degrees, pivotx, pivoty);
	}

	static SKMatrix MakeSkew (float sx, float sy)	
  {
		return CreateSkew (sx, sy);
	}

	// Set*

	void SetScaleTranslate (float sx, float sy, float tx, float ty)
	{
		scaleX = sx;
		skewX = 0;
		transX = tx;

		skewY = 0;
		scaleY = sy;
		transY = ty;

		persp0 = 0;
		persp1 = 0;
		persp2 = 1;
	}

	// Rotate

	static void Rotate (ref SKMatrix matrix, float radians, float pivotx, float pivoty)
	{
		auto sin = cast(float)sin (radians);
		auto cos = cast(float)cos (radians);
		SetSinCos ( matrix, sin, cos, pivotx, pivoty);
	}

	static void RotateDegrees (ref SKMatrix matrix, float degrees, float pivotx, float pivoty)
	{
		auto sin = cast(float)sin (degrees * DegreesToRadians);
		auto cos = cast(float)cos (degrees * DegreesToRadians);
		SetSinCos ( matrix, sin, cos, pivotx, pivoty);
	}

	static void Rotate (ref SKMatrix matrix, float radians)
	{
		auto sin = cast(float)sin (radians);
		auto cos = cast(float)cos (radians);
		SetSinCos ( matrix, sin, cos);
	}

	static void RotateDegrees (ref SKMatrix matrix, float degrees)
	{
		auto sin = cast(float)sin (degrees * DegreesToRadians);
		auto cos = cast(float)cos (degrees * DegreesToRadians);
		SetSinCos ( matrix, sin, cos);
	}

	// Invert

	const bool IsInvertible() {
		
		SKMatrix* t = cast(SKMatrix*)&this;
		return SkiaApi.sk_matrix_try_invert (t, null);
	}

	const bool TryInvert (out SKMatrix inverse)
	{
		SKMatrix* i = &inverse;
		SKMatrix* t = cast(SKMatrix*)&this;
		return SkiaApi.sk_matrix_try_invert (t, i);
	}

	SKMatrix Invert ()
	{
     SKMatrix matrix;
		if (TryInvert ( matrix))
			return matrix;

		return Empty;
	}

	// *Concat

	static SKMatrix Concat (SKMatrix first, SKMatrix second)
	{
		SKMatrix target;
		SkiaApi.sk_matrix_concat (&target, &first, &second);
		return target;
	}

	SKMatrix PreConcat (SKMatrix matrix)
	{
		auto target = this;
		SkiaApi.sk_matrix_pre_concat (&target, &matrix);
		return target;
	}

	SKMatrix PostConcat (SKMatrix matrix)
	{
		auto target = this;
		SkiaApi.sk_matrix_post_concat (&target, &matrix);
		return target;
	}

	static void Concat (ref SKMatrix target, SKMatrix first, SKMatrix second)
	{
		SKMatrix* t = &target;
		SkiaApi.sk_matrix_concat (t, &first, &second);
	}

	static void Concat (ref SKMatrix target, ref SKMatrix first, ref SKMatrix second)
	{
		SKMatrix* t = &target;
		SKMatrix* f = &first;
		SKMatrix* s = &second;
		SkiaApi.sk_matrix_concat (t, f, s);
	}

	static void PreConcat (ref SKMatrix target, SKMatrix matrix)
	{
		SKMatrix* t = &target;
		SkiaApi.sk_matrix_pre_concat (t, &matrix);
	}

	static void PreConcat (ref SKMatrix target, ref SKMatrix matrix)
	{
		SKMatrix* t = &target;
		SKMatrix* m = &matrix;
		SkiaApi.sk_matrix_pre_concat (t, m);
	}

	static void PostConcat (ref SKMatrix target, SKMatrix matrix)
	{
		SKMatrix* t = &target;
		SkiaApi.sk_matrix_post_concat (t, &matrix);
	}

	static void PostConcat (ref SKMatrix target, ref SKMatrix matrix)
	{
		SKMatrix* t = &target;
		SKMatrix* m = &matrix;
		SkiaApi.sk_matrix_post_concat (t, m);
	}

	// MapRect

	const SKRect MapRect (SKRect source)
	{
		SKRect dest;
		SKMatrix* m = cast(SKMatrix*)&this;
		SkiaApi.sk_matrix_map_rect (m, &dest, &source);
		return dest;
	}

	static void MapRect (ref SKMatrix matrix, out SKRect dest, ref SKRect source)
	{
		SKMatrix* m = &matrix;
		SKRect* d = &dest;
		SKRect* s = &source;
		SkiaApi.sk_matrix_map_rect (m, d, s);
	}

	// MapPoints

	const SKPoint MapPoint (SKPoint point)
	{
    	return MapPoint (point.X, point.Y);
  	}
	

	const SKPoint MapPoint (float x, float y)
	{
		SKPoint result;
		SKMatrix* t = cast(SKMatrix*)&this;
		SkiaApi.sk_matrix_map_xy (t, x, y, &result);
		return result;
	}

	const void MapPoints (SKPoint[] result, SKPoint[] points)
	{
		if (result is null)
			throw new ArgumentNullException (result.stringof);
		if (points is null)
			throw new ArgumentNullException (points.stringof);
		if (result.length != points.length)
			throw new ArgumentException ("Buffers must be the same size.");

		SKMatrix* t = cast(SKMatrix*)&this;
		SKPoint* rp = result.ptr;
		SKPoint* pp = points.ptr;
		SkiaApi.sk_matrix_map_points (t, rp, pp, cast(int)result.length);
	}

	const SKPoint[] MapPoints (SKPoint[] points)
	{
		if (points is null)
			throw new ArgumentNullException (points.stringof);

		auto res = new SKPoint[points.length];
		MapPoints (res, points);
		return res;
	}

	// MapVectors

	const SKPoint MapVector (SKPoint vector)
  {
    return MapVector (vector.X, vector.Y);
  }
	

	const SKPoint MapVector (float x, float y)
	{
		SKPoint result;
		SKMatrix* t = cast(SKMatrix*)&this;
		SkiaApi.sk_matrix_map_vector (t, x, y, &result);
		return result;
	}

	const void MapVectors (SKPoint[] result, SKPoint[] vectors)
	{
		if (result is null)
			throw new ArgumentNullException (result.stringof);
		if (vectors is null)
			throw new ArgumentNullException (vectors.stringof);
		if (result.length != vectors.length)
			throw new ArgumentException ("Buffers must be the same size.");

		SKMatrix* t = cast(SKMatrix*)&this;
		SKPoint* rp = result.ptr;
		SKPoint* pp = vectors.ptr;
		SkiaApi.sk_matrix_map_vectors (t, rp, pp, cast(int)result.length);
	}

	const SKPoint[] MapVectors (SKPoint[] vectors)
	{
		if (vectors is null)
			throw new ArgumentNullException (vectors.stringof);

		auto res = new SKPoint[vectors.length];
		MapVectors (res, vectors);
		return res;
	}

	// MapRadius

	const float MapRadius (float radius)
	{
		SKMatrix* t = cast(SKMatrix*)&this;
		return SkiaApi.sk_matrix_map_radius (t, radius);
	}

	// private

	private static void SetSinCos (ref SKMatrix matrix, float sin, float cos)
	{
		matrix.scaleX = cos;
		matrix.skewX = -sin;
		matrix.transX = 0;
		matrix.skewY = sin;
		matrix.scaleY = cos;
		matrix.transY = 0;
		matrix.persp0 = 0;
		matrix.persp1 = 0;
		matrix.persp2 = 1;
	}

	private static void SetSinCos (ref SKMatrix matrix, float sin, float cos, float pivotx, float pivoty)
	{
		float oneMinusCos = 1 - cos;

		matrix.scaleX = cos;
		matrix.skewX = -sin;
		matrix.transX = Dot (sin, pivoty, oneMinusCos, pivotx);
		matrix.skewY = sin;
		matrix.scaleY = cos;
		matrix.transY = Dot (-sin, pivotx, oneMinusCos, pivoty);
		matrix.persp0 = 0;
		matrix.persp1 = 0;
		matrix.persp2 = 1;
	}

	private static float Dot (float a, float b, float c, float d)
  {
    return a * b + c * d;
  }
		

	private static float Cross (float a, float b, float c, float d)
  {
    return a * b - c * d;
  }
		
}
