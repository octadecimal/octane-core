package octane.util;

/**
 * ...
 */
class StringUtil
{
	public static inline function getClassName(object:Dynamic)
	{
		return getFullClassName(object).split(".").pop();
	}
	
	public static inline function getFullClassName(object:Dynamic)
	{
		return Type.getClassName(Type.getClass(object));
	}
	
	public static inline function prefix(input:String, len:Int, ?pattern:String = " "):String
	{
		var output:String = "";
		
		for (i in input.length...len)
		{
			output += pattern;
		}
		
		return output + input;
	}
	
	public static inline function suffix(input:String, len:Int, ?pattern:String = " "):String
	{
		var output:String = "";
		
		for (i in input.length...len)
		{
			output += pattern;
		}
		
		return input + output;
	}
}