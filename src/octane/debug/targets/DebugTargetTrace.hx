package octane.debug.targets;

import octane.api.debug.IDebugTarget;
import octane.util.StringUtil;

/**
 * ...
 */
class DebugTargetTrace implements IDebugTarget
{
	private static inline var PADDING:Int = 32;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		
	}
	
	
	
	// API
	//============================================================================================================
	
	public function header(caller:Dynamic, message:String):Void
	{
		output("================================================================================================================================================================");
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + " >> " + message);
		div();
	}
	
	public function footer(caller:Dynamic, message:String):Void
	{
		div();
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + " >> " + message);
		output("================================================================================================================================================================");
	}
	
	public function div():Void
	{
		output("----------------------------------------------------------------------------------------------------------------------------------------------------------------");
	}
	
	public function data(caller:Dynamic, message:String):Void
	{
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + "    " + message);
	}
	
	public function info(caller:Dynamic, message:String):Void
	{
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + "  > " + message);
	}
	
	public function warn(caller:Dynamic, message:String):Void
	{
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + "  ! WARNING: " + message);
	}
	
	public function error(caller:Dynamic, message:String):Void
	{
		output(StringUtil.prefix(StringUtil.getClassName(caller), PADDING) + " !! ERROR: " + message);
		
		throw message;
	}
	
	
	
	// PRIVATE
	//============================================================================================================
	
	private function output(message:String):Void
	{
		#if flash
		flash.Lib.trace(message);
		#end
		
		#if js
		untyped __js__("console").log(message);
		#end
	}
}