module skia.List;

import skia.Common;
import skia.Exceptions;

import std.range;
import std.algorithm;
import std.container.array;

/**
 * see_also:
 *  https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1?view=net-5.0
 */

class List(T) : IList!T {

    private Array!(T) _array;

    this() { }

    this(int capacity) {
        _array.reserve(capacity);
    }

    this(Array!T array) {
        this._array = array;
    }

    this(T[] list) {
        this._array = list.array;
    }

    T front() {
        return _array.front;
    }

    T moveFront() {
        // return _array.moveFront();
        // TODO: Tasks pending completion -@Administrator at 2021-04-08T10:25:50+08:00
        // 
        throw new NotImplementedException();
    }

    void popFront() { 
        _array.removeBack;
    }

    bool IsReadOnly()
    {
        return false;
    }

    int Count() {
        return cast(int)_array.length;
    }

    bool empty() {
        return _array.empty();
    }

    int opApply(scope int delegate(T) dg) {
        assert(dg !is null);

        int r = 0;
        foreach (T item; _array) {
            r = dg(item);
            if (r != 0) {
                break;
            }
        }
        return r;
    }

    int opApply(scope int delegate(size_t, T) dg) {
        assert(dg !is null);

        int r = 0;
        for (int i = 0; i < _array.length; i++) {
            r = dg(i, _array[i]);
            if (r != 0) {
                break;
            }
        }
        return r;

    }

    T opIndex(int index)
    {
        return _array[index];
    }

    T opIndexAssign(T value, int index)
    {
        _array[index] = value;
        return value;
    }

    void Add(T item) {
        _array.insertBack(item);
    }

    void Insert(int index, T item) {
        _array.insertBefore(_array[index .. index + 1], item);
    }

    void Clear() {
        _array.clear();
    }

    bool Contains(T o) {
        return _array[].canFind(o);
    }

    bool Exists(T o) {
        return _array[].canFind(o);
    }

    void CopyTo(T[] array, int arrayIndex = 0)
    {
        assert(arrayIndex >= 0 && arrayIndex <= _array.length);

        if (array.length + arrayIndex < _array.length)
        {
            // _array = _array[0..arrayIndex] ~ array ~ _array[(array.length + arrayIndex)..$];
            for(size_t i = 0; i < array.length; i++) {
                _array[arrayIndex + i + 1] = array[i];
            }
        }
        else 
        {
            // _array = _array[0..arrayIndex] ~ array;
            _array.removeBack(_array.length - arrayIndex - 1);
            _array ~= Array!T(array);
        }
    }

    int IndexOf(T o) {
        for (size_t i = 0; i < _array.length; i++) {
            static if (is(T == class)) {
                if (_array[i] is o)
                    return cast(int) i;
            } else {
                if (_array[i] == o)
                    return cast(int) i;
            }
        }

        return -1;
    }

    int LastIndexOf(T item) {
        for (size_t i = _array.length - 1; i >= 0; i--) {
            if (_array[i] == item)
                return cast(int) i;
        }

        return -1;
    }

    bool Remove(T item) {
        int index = IndexOf(item);
        if (index < 0)
            return false;
        _array.linearRemove(_array[index .. index + 1]);
        return true;
    }

    T RemoveAt(int index) {
        T oldValue = _array[index];
        _array.linearRemove(_array[index .. index + 1]);
        return oldValue;
    }

    T FirstOrDefault(scope bool delegate(T) dg) {
        if (dg is null) {
            return _array.front();
        }
        foreach (T item; _array) {
            if (dg(item)) {
                return item;
            }
        }
        return T.init;
    }

    List!T Where(scope bool delegate(T) dg) {
        assert(dg !is null);
        
        List!(T) meets = new List!(T)();
        auto subArray = _array[].filter!(dg).array;
        foreach (T item; subArray) {
            meets.Add(item);
        }
        return meets;
    }

    T[] ToList() {
        return _array.array;
    }
}

