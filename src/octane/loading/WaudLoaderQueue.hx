package octane.loading;

import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import octane.api.loading.ISoundLoaderQueue;
import octane.debug.Debug;

/**
 * ...
 */
class WaudLoaderQueue implements ISoundLoaderQueue
{
	/**
	 * Sound loaded.
	 */
	public var sigSoundLoaded(default, null):Signal2<String, Dynamic>;
	
	/**
	 * Loading progress.
	 */
	public var sigProgress(default, null):Signal2<Float, String>;
	
	/**
	 * Loading complete.
	 */
	public var sigComplete(default, null):Signal0;
	
	/**
	 * Progress value.
	 */
	public var progress(default, null):Float = 1;
	
	// Queued sounds
	private var _queue:Map<String, String>;
	
	// Counting
	private var _numSoundsToLoad:Int = 0;
	private var _numSoundsLoaded:Int = 0;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		Debug.data(this, "Creating...");
		
		// TODO: Defer these to the soundplayer once created
		Waud.init();
		Waud.enableTouchUnlock();
		Waud.autoMute();
		
		sigSoundLoaded = new Signal2();
		sigProgress = new Signal2();
		sigComplete = new Signal0();
		
		_queue = new Map<String, String>();
		
		Debug.info(this, "Created.");
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		Debug.info(this, "Destroying...");
		
		sigSoundLoaded.removeAll();
		sigProgress.removeAll();
		sigComplete.removeAll();
		
		_queue = null;
		
		Debug.info(this, "Destroyed.");
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Adds a sound to the queue for loading.
	 * @param	id
	 * @param	path
	 */
	public function addSound(id:String, path:String):Void 
	{
		_numSoundsToLoad++;
		
		_queue.set(path, id);
	}
	
	/**
	 * Starts loading the queue.
	 */
	public function startLoading():Void 
	{
		if (_numSoundsToLoad == 0)
		{
			return;
		}
		
		_numSoundsLoaded = 0;
		progress = 0;
		
		for (key in _queue.keys())
		{
			var sound:WaudSound = new WaudSound(key, { autoplay: false, onload: onSoundLoaded });
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * signal: Sound loaded.
	 * @param	sound
	 */
	private function onSoundLoaded(sound:IWaudSound):Void
	{
		_numSoundsLoaded++;
		
		progress = _numSoundsLoaded / _numSoundsToLoad;
		
		sigSoundLoaded.dispatch(_queue.get(sound.url), sound);
		
		if (_numSoundsLoaded == _numSoundsToLoad)
		{
			Debug.info(this, "Queue complete.");
			_numSoundsToLoad = 0;
			_numSoundsLoaded = 0;
			_queue = new Map<String, String>();
			sigComplete.dispatch();
		}
		
		sigProgress.dispatch(progress, _queue.get(sound.url));
	}
}