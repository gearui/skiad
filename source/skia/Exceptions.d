module skia.Exceptions;

private mixin template BasicExceptionCtors() {
    
    this(size_t line = __LINE__, string file = __FILE__) @nogc @safe pure nothrow {
        super("", file, line, null);
    }

    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable next = null) @nogc @safe pure nothrow {
        super(msg, file, line, next);
    }

    this(string msg, Throwable next, string file = __FILE__, size_t line = __LINE__) @nogc @safe pure nothrow {
        super(msg, file, line, next);
    }

    this(Throwable next, string file = __FILE__, size_t line = __LINE__) @nogc @safe pure nothrow {
        assert(next !is null);
        super(next.msg, file, line, next);
    }
}

class ArgumentException : Exception {
    mixin BasicExceptionCtors;
}

class ArgumentNullException : Exception {
    mixin BasicExceptionCtors;
}

class ArgumentOutOfRangeException : Exception {

    this(string msg, size_t line = __LINE__, string file = __FILE__, Throwable next = null) @nogc @safe pure nothrow {
        super(msg, file, line, next);
    }

    this(string paramName, string message, string file = __FILE__, size_t line = __LINE__, Throwable next = null) @safe pure nothrow {
        super("Parameter name: " ~ paramName ~ ", message: " ~ message, file, line, next);
    }
}

class InvalidOperationException: Exception {
    mixin BasicExceptionCtors;
}

class NotSupportedException: Exception{
  mixin BasicExceptionCtors;
}

class ObjectDisposedException: Exception {
     mixin BasicExceptionCtors;
}

class NotImplementedException: Exception {
  mixin BasicExceptionCtors;
}

class TypeLoadException: Exception {
  mixin BasicExceptionCtors;
}

class NullPointerException: Exception {
    mixin BasicExceptionCtors;
}

