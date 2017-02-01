package octane.sound;

import msignal.Signal.Signal1;
import octane.types.NativeTypes.NativeISound;
import octane.types.NativeTypes.NativeSound;

/**
 * ...
 * @author Dylan Heyes
 */
class Sound 
{
	/**
	 * Sound id.
	 */
	public var id(default, null):String;
	
	/**
	 * Sound volume.
	 */
	public var volume(default, set):Float = 1;
	
	/**
	 * Global sound volume.
	 */
	public var globalVolume(null, set):Float = 1;
	
	/**
	 * Sound completed.
	 */
	public var sigComplete(default, null):Signal1<Sound>;
	
	
	// Native sound reference
	private var _native_Sound:NativeSound;
	
	// Flags
	private var _isReady:Bool = false;
	
	
	/**
	 * Constructor.
	 */
	public function new(id:String, url:String, loop:Bool, globalVolume:Float) 
	{
		this.id = id;
		this.globalVolume = globalVolume;
		
		sigComplete = new Signal1<Sound>();
		
		var params:WaudSoundOptions = {};
		params.autoplay = true;
		params.loop = loop;
		params.onload = onSoundReady;
		params.onend = onSoundComplete;
		
		_native_Sound = new NativeSound(url, params);
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void
	{
		sigComplete.removeAll();
		sigComplete = null;
		
		_native_Sound.destroy();
		_native_Sound = null;
	}
	
	
	
	// ACCESSORS
	//============================================================================================================
	
	/**
	 * Sets the internal sound volume.
	 * @param	value
	 */
	private function set_volume(value:Float):Float 
	{
		if (_isReady)
		{
			_native_Sound.setVolume(value * globalVolume);
		}
		
		return volume = value;
	}
	
	/**
	 * Sets the internal global volume.
	 * @param	value
	 */
	private function set_globalVolume(value:Float):Float 
	{
		if (_isReady)
		{
			_native_Sound.setVolume(value * volume);
		}
		
		return globalVolume = value;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Stops the sound.
	 */
	public function stop():Void
	{
		_native_Sound.stop();
		sigComplete.dispatch(this);
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * Sound is ready and loaded.
	 * @param	sound
	 */
	private function onSoundReady(sound:NativeISound):Void
	{
		// Flag as ready
		_isReady = true;
		
		// Set initial sound volume
		_native_Sound.setVolume(volume * globalVolume);
	}
	
	/**
	 * Sound completed.
	 * @param	sound
	 */
	private function onSoundComplete(sound:NativeISound):Void
	{
		// Dispatch complete
		sigComplete.dispatch(this);
		
		// Destroy sound
		destroy();
	}
}