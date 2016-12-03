package octane.util;

/**
 * ...
 */
class StringUtil
{
	public static function getClassName(object:Dynamic):String
	{
		return getFullClassName(object).split(".").pop();
	}
	
	public static function getFullClassName(object:Dynamic):String
	{
		return Type.getClassName(Type.getClass(object));
	}
	
	public static function prefix(input:String, len:Int, ?pattern:String = " ")
	{
		var output:String = "";
		
		for (i in input.length...len)
		{
			output += pattern;
		}
		
		return output + input;
	}
	
	public static function suffix(input:String, len:Int, ?pattern:String = " ")
	{
		var output:String = "";
		
		for (i in input.length...len)
		{
			output += pattern;
		}
		
		return input + output;
	}
}