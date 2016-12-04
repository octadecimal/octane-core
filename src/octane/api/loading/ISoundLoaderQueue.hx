package octane.api.loading;

import msignal.Signal.Signal2;
import octane.api.IDestroyable;

/**
 * ...
 */
interface ISoundLoaderQueue extends ILoaderQueue
{
	var sigSoundLoaded(default, null):Signal2<String, Dynamic>;
	
	function addSound(id:String, path:String):Void;
}