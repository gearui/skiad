module skia.Dictionary;

import std.string;
import std.typecons;

import skia.Common;
import skia.Exceptions;

//
// Type parameters:
//   TKey:
//     The type of the keys in the dictionary.
//
//   TValue:
//     The type of the values in the dictionary.
class Dictionary(TKey, TValue) : IDictionary!(TKey, TValue)
{
	private TValue[TKey] m_dict;
	private CaseSensitive cs;

	this(CaseSensitive cs = CaseSensitive.yes)
	{
		this.cs = cs;
	}


	size_t Count() @property
	{
		return m_dict.length;
	}


	void Add(TKey key, TValue value)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}
		m_dict[key] = value;
	}


	// Summary:
	//     Gets or sets the value associated with the specified key.
	//
	// Parameters:
	//   key:
	//     The key of the value to get or set.
	//
	// Returns:
	//     The value associated with the specified key. If the specified key is not
	//     found, a get operation throws a System.Collections.Generic.KeyNotFoundException,
	//     and a set operation creates a new element with the specified key.
	//
	// Exceptions:
	//   System.ArgumentNullException:
	//     key is null.
	//
	//   System.Collections.Generic.KeyNotFoundException:
	//     The property is retrieved and key does not exist in the collection.
	TValue opIndex(TKey key)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}

		TValue *value_ptr = (key in m_dict);
		if (value_ptr !is null)
			return *value_ptr;

		throw new Exception(std.string.format("The key doesn't exist: %s", key));
	}


	TValue opIndexAssign(TValue value, TKey key)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}

		m_dict[key] = value;
		return value;
	}

	int opApply(scope int delegate(ref TKey key, TValue value) dg)
    {
		if (dg is null)
            throw new NullPointerException("");

        int result = 0;
		foreach(TKey key, TValue value; m_dict) {
			result = dg(key, value);
			if (result) break;
		}

		return result;
    }

	//
	// Summary:
	//     Gets the value associated with the specified key.
	//
	// Parameters:
	//   key:
	//     The key of the value to get.
	//
	//   value:
	//     When this method returns, contains the value associated with the specified
	//     key, if the key is found; otherwise, the default value for the type of the
	//     value parameter. This parameter is passed uninitialized.
	//
	// Returns:
	//     true if the System.Collections.Generic.Dictionary<TKey,TValue> contains an
	//     element with the specified key; otherwise, false.
	//
	// Exceptions:
	//   System.ArgumentNullException:
	//     key is null.
	bool TryGetValue(TKey key, out TValue value)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}

		TValue *value_ptr = (key in m_dict);
		if (value_ptr !is null)
		{
			value = *value_ptr;
			return true;
		}

		return false;
	}

	//
	// Summary:
	//     Removes the value with the specified key from the System.Collections.Generic.Dictionary<TKey,TValue>.
	//
	// Parameters:
	//   key:
	//     The key of the element to remove.
	//
	// Returns:
	//     true if the element is successfully found and removed; otherwise, false.
	//     This method returns false if key is not found in the System.Collections.Generic.Dictionary<TKey,TValue>.
	//
	// Exceptions:
	//   System.ArgumentNullException:
	//     key is null.
	bool Remove(TKey key)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}

		TValue *value_ptr = (key in m_dict);
		if(value_ptr !is null)
		{
			m_dict.remove(key);
			return true;
		}

		return false;
	}


	//
	// Summary:
	//     Removes all keys and values from the System.Collections.Generic.Dictionary<TKey,TValue>.
	void Clear()
	{
		// foreach(TKey key; m_dict.keys)
		// {
		// 	m_dict.remove(key);
		// }
        m_dict.clear();
	}

	//
	// Summary:
	//     Determines whether the System.Collections.Generic.Dictionary<TKey,TValue>
	//     contains the specified key.
	//
	// Parameters:
	//   key:
	//     The key to locate in the System.Collections.Generic.Dictionary<TKey,TValue>.
	//
	// Returns:
	//     true if the System.Collections.Generic.Dictionary<TKey,TValue> contains an
	//     element with the specified key; otherwise, false.
	//
	// Exceptions:
	//   System.ArgumentNullException:
	//     key is null.
	bool ContainsKey(TKey key)
	{
		static if(is(TKey == string)) {
			if (cs == CaseSensitive.no)
				key = key.toUpper;
		}

		TValue *value_ptr = (key in m_dict);
		return value_ptr !is null;
	}


	//
	// Summary:
	//     Determines whether the System.Collections.Generic.Dictionary<TKey,TValue>
	//     contains a specific value.
	//
	// Parameters:
	//   value:
	//     The value to locate in the System.Collections.Generic.Dictionary<TKey,TValue>.
	//     The value can be null for reference types.
	//
	// Returns:
	//     true if the System.Collections.Generic.Dictionary<TKey,TValue> contains an
	//     element with the specified value; otherwise, false.
	bool ContainsValue(TValue value)
	{
		foreach(TValue v; m_dict.values)
		{
			if (value == v)
				return true;
		}
		return false;
	}

	TKey[] Keys()
	{
		return m_dict.keys;
	}

	TValue[] Values() 
	{
		return m_dict.values;
	}
}