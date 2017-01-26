package octane.sound;

import octane.api.sound.ISoundPlayer;
import octane.types.DynamicExt;

/**
 * ...
 */
class WaudSoundPlayer implements ISoundPlayer
{
	private var _base64Sounds:Map<String, String>;
	

	/**
	 * Constructor.
	 */
	public function new() 
	{
		Waud.init();
		Waud.autoMute();
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
	
	public function playSound(id:String):Void 
	{
		if (_base64Sounds != null && _base64Sounds.exists(id))
		{
			new WaudSound(_base64Sounds.get(id), { autoplay: true });
		}
		else
		{
			// TODO
		}
	}
}