package octane.api.sound;

import octane.api.IDestroyable;
import octane.game.model.ResourceList;
import octane.sound.SoundParameters;
import octane.types.DynamicExt;

/**
 * ...
 */
interface ISoundPlayer extends IDestroyable
{
	function setBase64Sound(id:String, data:String):Void;
	
	function playSound(string:String, ?params:Dynamic):Void;
	
	function stopSound(string:String):Void;
	
	var resourceList:ResourceList;
}