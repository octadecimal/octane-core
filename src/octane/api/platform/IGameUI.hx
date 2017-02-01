package octane.api.platform;

import msignal.Signal.Signal1;
import octane.api.IDestroyable;

/**
 * ...
 */
interface IGameUI extends IDestroyable
{
	var sigEvent:Signal1<String>;
	
	function show():Void;
	function hide():Void;
}