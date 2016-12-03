package octane.display;

import msignal.Signal.Signal1;
import octane.api.display.IAnimation;
import octane.types.NativeTypes.NativeMovieClip;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
class MovieClip extends Sprite implements IAnimation
{
	// Native movieclip
	private var _native_MovieClip(null, null):NativeMovieClip;
	
	/**
	 * Constructor.
	 */
	public function new(textures:NativeTextureArray, ?loop:Bool = true, ?fps:Int = 24)
	{
		_native_DisplayObject = _native_Sprite = _native_MovieClip = new NativeMovieClip(textures);
		
		this.fps = fps;
		this.loop = loop;
		
		sigAnimationComplete = new Signal1<IAnimation>();
		
		_native_MovieClip.onComplete = onMovieClipComplete;
		
		super(textures[0]);
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		_native_MovieClip.onComplete = null;
		
		super.destroy();
	}
	
	
	
	// ACCESSORS
	//============================================================================================================
	
	/**
	 * signal: Animation complete.
	 */
	public var sigAnimationComplete(default, null):Signal1<IAnimation>;
	
	/**
	 * Animation resource (used for resource pooling).
	 */
	//public var resource(default, default):AnimationResource;
	
	
	/**
	 * Current frame (texture index).
	 */
	public var currentFrame(get, set):Int;
	function get_currentFrame():Int
	{
		return _native_MovieClip.currentFrame;
	}
	function set_currentFrame(value:Int):Int
	{
		if (playing)
		{
			_native_MovieClip.gotoAndPlay(value);
		}
		else
		{
			_native_MovieClip.gotoAndStop(value);
		}
		return _native_MovieClip.currentFrame;
	}
	
	
	/**
	 * Total number of frames (textures).
	 */
	public var totalFrames(get, null):Int;
	function get_totalFrames():Int
	{
		return _native_MovieClip.totalFrames;
	}
	
	
	/**
	 * Indicates if the MovieClip is currently playing.
	 */
	public var playing(get, null):Bool;
	function get_playing():Bool
	{
		return _native_MovieClip.playing;
	}
	
	
	/**
	 * Whether or not the movie clip repeats after playing.
	 */
	public var loop(get, set):Bool;
	function get_loop():Bool
	{
		return _native_MovieClip.loop;
	}
	function set_loop(value:Bool):Bool
	{
		return _native_MovieClip.loop = value;
	}
	
	
	/**
	 * MovieClip frame rate.
	 */
	public var fps(get, set):Float;
	function get_fps():Float
	{
		return _native_MovieClip.animationSpeed * 60;
	}
	function set_fps(value:Float):Float
	{
		return _native_MovieClip.animationSpeed = value / 60;
	}
	
	
	/**
	 * MovieClip textures.
	 */
	public var textures(get, set):NativeTextureArray;
	function get_textures():NativeTextureArray
	{
		return _native_MovieClip.textures;
	}
	function set_textures(textures:NativeTextureArray):NativeTextureArray
	{
		return _native_MovieClip.textures = textures;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Plays the MovieClip.
	 */
	public function play(?clip:String):Void
	{
		_native_MovieClip.play();
	}
	
	/**
	 * Stops the MovieClip.
	 */
	public function stop():Void
	{
		_native_MovieClip.stop();
	}
	
	/**
	 * Resets the animation.
	 */
	public function reset():Void
	{
		stop();
		currentFrame = 0;
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * signal: MovieClip completed.
	 */
	private function onMovieClipComplete():Void
	{
		sigAnimationComplete.dispatch(this);
	}
}