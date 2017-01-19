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
	
	
	public static inline function mod(index:Int, length:Int):Int
	{
		var output:Int = index % length;
		
		if (output < 0)
		{
			output = length + output;
		}
		
		return output;
	}
	
	public static inline function destroy(input:Array<Dynamic>):Void
	{
		input.splice(0, input.length);
	}
}