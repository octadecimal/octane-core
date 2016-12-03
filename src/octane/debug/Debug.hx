package octane.debug;

import octane.api.debug.IDebugTarget;

/**
 * ...
 */
class Debug
{
	// Debug targets
	private static var _targets:Array<IDebugTarget> = [];
	
	/**
	 * Static destructor.
	 */
	public static function destroy():Void 
	{
		for (target in _targets)
		{
			target.destroy();
		}
		
		_targets = null;
	}
	
	/**
	 * Adds a IDebugTarget that can hook into debug messages.
	 * @param	target
	 */
	public static function addTarget(target:IDebugTarget):Void
	{
		_targets.push(target);
	}
	
	
	
	// LOGGING
	//============================================================================================================
	
	public static inline function header(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.header(caller, message);
		}
	}
	
	public static inline function footer(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.footer(caller, message);
		}
	}
	
	public static inline function div():Void
	{
		for (target in _targets)
		{
			target.div();
		}
	}
	
	public static inline function data(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.data(caller, message);
		}
	}
	
	public static inline function info(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.info(caller, message);
		}
	}
	
	public static inline function warn(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.warn(caller, message);
		}
	}
	
	public static inline function error(caller:Dynamic, message:String):Void
	{
		for (target in _targets)
		{
			target.error(caller, message);
		}
	}
}