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
	private var _native_TextField(default, null):NativeTextField;
	
	private var _region:Rectangle;
	
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
	
	
	
	// PROPERTIES
	//============================================================================================================
	
	/**
	 * Text.
	 */
	public var text(get, set):String;

	/**
	 * Gets the width of this display object.
	 */
	override public function get_width():Float
	{
		return _native_TextField.width;
	}

	/**
	 * Sets the width of this display object.
	 */
	override public function set_width(value:Float):Float
	{
		_native_TextField.width = value;
		return _native_TextField.width;
	}

	/**
	 * Gets the height of this display object.
	 */
	override public function get_height():Float
	{
		return _native_TextField.height;
	}

	/**
	 * Sets the height of this display object.
	 */
	override public function set_height(value:Float):Float
	{
		return _native_TextField.height = value;
	}
	
	
	
	// ACCESSORS
	//============================================================================================================

	function get_text()
	{
		return _native_TextField.text;
	}
	function set_text(value:String)
	{
		return _native_TextField.text = value;
	}
}

/*typedef TextStyle = {
	@:optional var font:String;
	@:optional var fill:String;
	@:optional var align:String;
	@:optional var stroke:String;
	@:optional var strokeThickness:Float;
	@:optional var wordWrap:Bool;
	@:optional var wordWrapWidth:Float;
	@:optional var lineHeight:Float;
	@:optional var dropShadow:Bool;
	@:optional var dropShadowColor:String;
	@:optional var dropShadowAngle:Float;
	@:optional var dropShadowDistance:Float;
	@:optional var padding:Float;
	@:optional var textBaseline:String;
	@:optional var lineJoin:String;
	@:optional var miterLimit:Int;
}*/

enum TextFieldAlign {
	LEFT;
	CENTER;
	RIGHT;
}