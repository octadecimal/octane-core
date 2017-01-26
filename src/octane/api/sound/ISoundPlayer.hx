package octane.api.sound;

import octane.api.IDestroyable;
import octane.types.DynamicExt;

/**
 * ...
 */
interface ISoundPlayer extends IDestroyable
{
	function setBase64Sound(id:String, data:String):Void;
	
	function playSound(string:String):Void;
}