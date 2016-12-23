package octane.display;

import octane.display.DisplayObject;
import octane.types.NativeTypes.NativeSprite;
import octane.types.NativeTypes.NativeTexture;

/**
 * ...
 */
class Sprite extends DisplayObject
{
	private var _native_Sprite(null, null):NativeSprite;
	
	/**
	 * Constructor.
	 */
	public function new(texture:NativeTexture) 
	{
		if (_native_DisplayObject == null)
		{
			_native_DisplayObject = _native_Sprite = new NativeSprite(texture);
		}
		
		super();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy() 
	{
		super.destroy();
	}
	
	
	
	// ACCESSORS
	//============================================================================================================
	
	public var texture(get, set):NativeTexture;
	
	private function get_texture():NativeTexture
	{
		return _native_Sprite.texture;
	}
	
	private function set_texture(value:NativeTexture):NativeTexture
	{
		return _native_Sprite.texture = value;
	}
	
	
	public var tint(get, set):Int;
	
	private function get_tint():Int
	{
		return _native_Sprite.mask;
	}
	
	private function set_tint(value:Int):Int
	{
		return _native_Sprite.tint = value;
	}
}