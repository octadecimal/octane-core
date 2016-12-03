package octane.api.debug;
import octane.api.IDestroyable;

/**
 * ...
 */
interface IDebugTarget extends IDestroyable
{
	function header(caller:Dynamic, message:String):Void;
	function footer(caller:Dynamic, message:String):Void;
	function data(caller:Dynamic, message:String):Void;
	function info(caller:Dynamic, message:String):Void;
	function warn(caller:Dynamic, message:String):Void;
	function error(caller:Dynamic, message:String):Void;
	function div():Void;
}