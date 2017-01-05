package octane.assert;

import octane.debug.Debug;

/**
 * ...
 */
class Assert
{
	static public inline function isTrue(condition:Bool, message:String):Void
	{
#if debug		
		if (!condition)
		{
			Debug.error("[ASSERT]", "[FAIL isTrue] " + message);
		}
#end
	}
	
	static public inline function isNotNull(object:Dynamic, message:String):Void
	{
#if debug		
		if (object == null)
		{
			Debug.error("[ASSERT]", "[FAIL isNotNull] " + message);
		}	
#end
	}
}