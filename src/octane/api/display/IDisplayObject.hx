package octane.api.display;

import msignal.Signal.Signal1;
import octane.api.IDestroyable;
import octane.display.Container;
import octane.display.DisplayObject;

/**
 */
interface IDisplayObject extends IDestroyable
{
	var sigClicked(default, null):Signal1<DisplayObject>;
	var sigMouseDown(default, null):Signal1<DisplayObject>;
	
	var name(default, default):String;
	var cacheAsBitmap(get, set):Bool;
	var visible(get, set):Bool;
	var x(get, set):Float;
	var y(get, set):Float;
	var pivotX(get, set):Float;
	var pivotY(get, set):Float;
	var scaleX(get, set):Float;
	var scaleY(get, set):Float;
	var width(get, set):Float;
	var height(get, set):Float;
	var alpha(get, set):Float;
	var rotation(get, set):Float;
	var mask(get, set):DisplayObject;
	var parent(default, default):Container;
	var interactive(get, set):Bool;
	
	function removeFromParent(?destroy:Bool = false):Void;
}