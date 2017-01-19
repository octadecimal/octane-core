package octane.util;

/**
 * ...
 */
class MathUtil
{
	public static inline function mod(index:Int, length:Int):Int
	{
		var output:Int = index % length;
		
		if (output < 0)
		{
			output = length + output;
		}
		
		return output;
	}
}