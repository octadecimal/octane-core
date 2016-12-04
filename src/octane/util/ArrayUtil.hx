package octane.util;

/**
 * ...
 */
class ArrayUtil
{
	public static inline function sortAlphabetically(input)
	{
		input.sort(function(a:String, b:String):Int {
			a = a.toLowerCase();
			b = b.toLowerCase();
			if (a < b) return -1;
			if (a > b) return 1;
			return 0;
		});
	}
}