package octane.sound;

import octane.api.sound.ISoundPlayer;
import octane.game.model.ResourceList;
import octane.types.DynamicExt;
import octane.util.StringUtil;

/**
 * ...
 */
class WaudSoundPlayer implements ISoundPlayer
{
	public var resourceList:ResourceList;
	
	private var _base64Sounds:Map<String, String>;
	private var _activeSounds:Map<String, WaudSound>;
	

	/**
	 * Constructor.
	 */
	public function new() 
	{
		Waud.init();
		Waud.autoMute();
		
		_activeSounds = new Map<String, WaudSound>();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		
	}
	
	
	
	// API
	//============================================================================================================
	
	public function setBase64Sound(id:String, data:String):Void 
	{
		if (_base64Sounds == null)
		{
			_base64Sounds = new Map<String, String>();
		}
		
		_base64Sounds.set(id, data);
	}
	
	public function playSound(id:String, ?params:Dynamic):Void 
	{
		var sound:WaudSound = null;
		
		if (params == null)
		{
			params = { autoplay: true, onend: onSoundStopped };
		}
		else
		{
			params.autoplay = true;
			params.onend = onSoundStopped;
		}
		
		if (_base64Sounds != null && _base64Sounds.exists(id))
		{
			sound = new WaudSound(_base64Sounds.get(id), params);
		}
		else
		{
			sound = new WaudSound(resourceList.getResourcePath(id), params);
		}
		
		_activeSounds.set(id, sound);
	}
	
	public function stopSound(id:String):Void
	{
		var sound:WaudSound = _activeSounds.get(id);
		sound.stop();
		onSoundStopped(sound);
	}
	
	private function onSoundStopped(sound:IWaudSound) 
	{
		trace(sound.url);
		
		trace("PRE");
		sound.stop();
		
		
		for (key in _activeSounds.keys())
		{
			if (_activeSounds.get(key) == sound)
			{
				_activeSounds.remove(key);
			}
		}
		
		trace("POST");
		trace(_activeSounds.keys());
	}
}