package octane.display;

import octane.display.DisplayObject;
import octane.geom.Point;
import octane.geom.Rectangle;
import octane.types.NativeTypes.NativeTextField;
//import pixi.core.text.TextStyle;

/**
 * ...
 */
class TextField extends Sprite
{
	/**
	 * Text.
	 */
	public var text(get, set):String;
	
	
	// Native textfield reference
	private var _native_TextField(default, null):NativeTextField;
	
	/**
	 * Constructor.
	 */
	public function new(text:String, ?style:Dynamic = null) 
	{
		if (_native_DisplayObject == null)
		{
			_native_DisplayObject = _native_Container = _native_Sprite = _native_TextField = new NativeTextField(text, style);
		}
		
		super(null);
		
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	
	
	// ACCESSORS
	//============================================================================================================

	private function get_text():String
	{
		return _native_TextField.text;
	}
	
	private function set_text(value:String):String
	{
		return _native_TextField.text = value;
	}
}