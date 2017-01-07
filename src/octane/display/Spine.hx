package octane.display;

import msignal.Signal.Signal1;
import octane.api.display.IAnimation;
import octane.types.NativeTypes.NativeSpine;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
class Spine extends Container implements IAnimation
{
	// Native movieclip
	private var _native_Spine(null, null):NativeSpine;
	
	/**
	 * Animation complete.
	 */
	public var sigAnimationComplete(default, null):Signal1<IAnimation>;
	

	/**
	 * Constructor.
	 * @param	spineData
	 */
	public function new(spineData:Dynamic) 
	{
		if (_native_Spine == null)
		{
			_native_DisplayObject = _native_Container = _native_Spine = new NativeSpine(spineData);
		}
		
		super();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	
	
	// 
	//============================================================================================================
	
	@:isVar public var currentFrame(get, set):Int;
	
	function get_currentFrame():Int 
	{
		return currentFrame;
	}
	
	function set_currentFrame(value:Int):Int 
	{
		return currentFrame = value;
	}
	
	public var totalFrames(get, null):Int;
	
	function get_totalFrames():Int 
	{
		return totalFrames;
	}
	
	public var playing(get, null):Bool;
	
	function get_playing():Bool 
	{
		return playing;
	}
	
	@:isVar public var loop(get, set):Bool;
	
	function get_loop():Bool 
	{
		return loop;
	}
	
	function set_loop(value:Bool):Bool 
	{
		return loop = value;
	}
	
	@:isVar public var fps(get, set):Float;
	
	function get_fps():Float 
	{
		return fps;
	}
	
	function set_fps(value:Float):Float 
	{
		return fps = value;
	}
	
	@:isVar public var textures(get, set):NativeTextureArray;
	
	function get_textures():NativeTextureArray 
	{
		return textures;
	}
	
	function set_textures(value:NativeTextureArray):NativeTextureArray 
	{
		return textures = value;
	}
	
	public function play(?clip:String="animation"):Void 
	{
		trace("PLAY: " + clip);
		_native_Spine.state.setAnimation(0, clip, true);
		
		var g:Graphics = new Graphics();
		g.beginFill(0x0);
		g.drawEllipse(0, 0, 10, 10);
		g.endFill();
		addChild(g);
	}
	
	public function stop():Void 
	{
		
	}
	
	public function reset():Void 
	{
		
	}
}