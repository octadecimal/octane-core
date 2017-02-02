package octane.api.platform;

import msignal.Signal.Signal1;
import octane.api.IDestroyable;

/**
 * ...
 */
interface IGameUI extends IDestroyable
{
	var sigEvent:Signal1<String>;
	
	function setup():Void;
	function show():Void;
	function hide():Void;
	
	function enableButtons():Void;
	function disableButtons():Void;
	function setMessage(message:String):Void;
	
	function configureCoinSizes(index:Int, sizes:Array<Dynamic>):Void;
	function configureBets(index:Int, availableBets:Array<Int>):Void;
	function configureColors(config:Dynamic):Void;
	function configureSpin(config:Dynamic):Void;
	
}