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
	public var id(default, null):String;
	public var sigComplete(default, null):Signal1<Sound>;
	
	private var _native_Sound:NativeSound;
	
	/**
	 * Constructor.
	 */
	public function new(id:String, url:String, ?loop:Bool = false) 
	{
		this.id = id;
		sigComplete = new Signal1<Sound>();
		
		var params:WaudSoundOptions = {};
		
		params.autoplay = true;
		params.loop = loop;
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
	
	
	
	// API
	//============================================================================================================
	
	public function stop():Void
	{
		_native_Sound.stop();
		sigComplete.dispatch(this);
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onSoundComplete(sound:NativeISound):Void
	{
		sigComplete.dispatch(this);
		destroy();
	}
}