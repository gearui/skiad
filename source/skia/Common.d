module skia.Common;

import std.range;

alias IEnumerable(T) = InputRange!(T);

T[] ToList(T)(IEnumerable!(T) items) {
    T[] v;
// TODO: Tasks pending completion -@putao at 2021-06-09T10:07:19+08:00
// 
    return v;
}

interface ICollection(T) :  IEnumerable!T 
{
    // Number of items in the collections.        
    int Count();

    bool IsReadOnly();

    void Add(T item);

    void Clear();

    bool Contains(T item);
            
    // CopyTo copies a collection into an Array, starting at a particular
    // index into the array.
    // 
    void CopyTo(T[] array, int arrayIndex);
            
    //void CopyTo(int sourceIndex, T[] destinationArray, int destinationIndex, int count);

    bool Remove(T item);
}

interface IList(T) : ICollection!T {
    
    // The Item property provides methods to read and edit entries in the List.
    T opIndex(int index);
    T opIndexAssign(T value, int index);

    // Returns the index of a particular item, if it is in the list.
    // Returns -1 if the item isn't in the list.
    int IndexOf(T item);

    // Inserts value into the list at position index.
    // index must be non-negative and less than or equal to the 
    // number of elements in the list.  If index equals the number
    // of items in the list, then value is appended to the end.
    void Insert(int index, T item);
    
    // Removes the item at position index.
    T RemoveAt(int index);

    T[] ToList();
}
// struct KeyValuePair(TKey, TValue) {
//     private TKey key;
//     private TValue value;

//     this(TKey key, TValue value) {
//         this.key = key;
//         this.value = value;
//     }

//     TKey Key() => key;

//     TValue Value() => value;

//     string ToString() {
//         string s = "[";
//         if( Key != null) {
//             s ~= to!string(Key);
//         }
//         s ~= ", ";
//         if( Value != null) {
//             s ~= to!string(Value);
//         }
//         s ~= "]";
//         return s;
//     }
// }

interface IDictionary(TKey, TValue)
{
    // Interfaces are not serializable
    // The Item property provides methods to read and edit entries 
    // in the Dictionary.
    TValue opIndex(TKey key);
    TValue opIndexAssign(TValue value, TKey key);

    // Returns a collections of the keys in this dictionary.
    TKey[] Keys();

    // Returns a collections of the values in this dictionary.
    TValue[] Values();
    // Returns whether this dictionary contains a particular key.
    //
    bool ContainsKey(TKey key);

    // Adds a key-value pair to the dictionary.
    // 
    void Add(TKey key, TValue value);

    // Removes a particular key from the dictionary.
    //
    bool Remove(TKey key);

    bool TryGetValue(TKey key, out TValue value);
}