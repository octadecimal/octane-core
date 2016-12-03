package octane.api.display;

import msignal.Signal.Signal1;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
interface IAnimation extends IDisplayObject
{
	var sigAnimationComplete(default, null):Signal1<IAnimation>;
	
	var currentFrame(get, set):Int;
	var totalFrames(get, null):Int;
	var playing(get, null):Bool;
	var loop(get, set):Bool;
	var fps(get, set):Float;
	var textures(get, set):NativeTextureArray;
	//var resource(default, default):AnimationResource;
	
	function play(?clip:String):Void;
	function stop():Void;
	function reset():Void;
}