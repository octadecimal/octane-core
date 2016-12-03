package octane.display;

import msignal.Signal;
import octane.api.display.IDisplayObject;
import octane.display.Container;
import octane.types.NativeTypes;

/**
 * ...
 */
class DisplayObject implements IDisplayObject
{
	private var _native_DisplayObject(null, null):NativeDisplayObject;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		if (_native_DisplayObject == null)
		{
			throw "Expected native display object.";
		}
		
		sigClicked = new Signal1<DisplayObject>();
		sigMouseDown = new Signal1<DisplayObject>();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void
	{
		_native_DisplayObject.destroy();
	}
	
	
	
	// SIGNALS
	//============================================================================================================
	
	public var sigClicked(default, null):Signal1<DisplayObject>;
	public var sigMouseDown(default, null):Signal1<DisplayObject>;
	
	
	
	// PROPERTIES
	//============================================================================================================
	
	public var name(default, default):String;
	
	public var cacheAsBitmap(get, set):Bool;
	
	public var visible(get, set):Bool;
	
	public var x(get, set):Float;
	
	public var y(get, set):Float;
	
	public var pivotX(get, set):Float;
	
	public var pivotY(get, set):Float;
	
	public var scaleX(get, set):Float;
	
	public var scaleY(get, set):Float;
	
	public var width(get, set):Float;
	
	public var height(get, set):Float;
	
	public var alpha(get, set):Float;
	
	public var rotation(get, set):Float;
	
	public var mask(get, set):DisplayObject;
	
	public var parent(default, default):Container;
	
	public var interactive(get, set):Bool;
	
	
	
	// API
	//============================================================================================================
	
	public function removeFromParent(?destroy:Bool = false):Void
	{
		if (parent != null)
		{
			parent.removeChild(this);
		}
		
		if (destroy)
		{
			this.destroy();
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onMouseUp():Void
	{
		sigClicked.dispatch(this);
	}
	
	private function onMouseDown():Void
	{
		sigMouseDown.dispatch(this);
	}
	
	
	
	// GETTERS/SETTERS
	//============================================================================================================
	
	private function get_cacheAsBitmap():Bool
	{
		return _native_DisplayObject.cacheAsBitmap;
	}
	
	private function set_cacheAsBitmap(value:Bool):Bool
	{
		return _native_DisplayObject.cacheAsBitmap = value;
	}
	
	
	private function get_visible():Bool
	{
		return _native_DisplayObject.visible;
	}
	
	private function set_visible(value:Bool):Bool
	{
		return _native_DisplayObject.visible = value;
	}
	
	
	private function get_x():Float
	{
		return _native_DisplayObject.x;
	}
	
	private function set_x(value:Float):Float
	{
		return _native_DisplayObject.x = value;
	}
	
	
	private function get_y():Float
	{
		return _native_DisplayObject.y;
	}
	
	private function set_y(value:Float):Float
	{
		return _native_DisplayObject.y = value;
	}
	
	
	private function get_pivotX():Float
	{
		return _native_DisplayObject.pivot.x;
	}
	
	private function set_pivotX(value:Float):Float
	{
		return _native_DisplayObject.pivot.x = value;
	}
	
	
	private function get_scaleX():Float
	{
		return _native_DisplayObject.scale.x;
	}
	
	private function set_scaleX(value:Float):Float
	{
		return _native_DisplayObject.scale.x = value;
	}
	
	
	private function get_scaleY():Float
	{
		return _native_DisplayObject.scale.y;
	}
	
	private function set_scaleY(value:Float):Float
	{
		return _native_DisplayObject.scale.y = value;
	}
	
	
	private function get_pivotY():Float
	{
		return _native_DisplayObject.pivot.y;
	}
	
	private function set_pivotY(value:Float):Float
	{
		return _native_DisplayObject.pivot.y = value;
	}
	
	
	private function get_width():Float
	{
		return _native_DisplayObject.getBounds().width;
	}
	
	private function set_width(value:Float):Float
	{
		return scaleX = value / width;
	}
	
	
	private function get_height():Float
	{
		return _native_DisplayObject.getBounds().height;
	}
	
	private function set_height(value:Float):Float
	{
		return scaleY = value / height;
	}
	
	
	private function get_alpha():Float
	{
		return _native_DisplayObject.alpha;
	}
	
	private function set_alpha(value:Float):Float
	{
		return _native_DisplayObject.alpha = value;
	}
	
	
	private function get_rotation():Float
	{
		return _native_DisplayObject.rotation;
	}
	
	private function set_rotation(value:Float):Float
	{
		return _native_DisplayObject.rotation = value;
	}
	
	
	private function get_mask():DisplayObject
	{
		return _native_DisplayObject.mask;
	}
	
	private function set_mask(value:DisplayObject):DisplayObject
	{
		return _native_DisplayObject.mask = value;
	}
	
	
	private function get_interactive():Bool
	{
		return _native_DisplayObject.interactive;
	}
	
	private function set_interactive(value:Bool):Bool
	{
		if (value)
		{
			_native_DisplayObject.on("mouseup", onMouseUp);
			_native_DisplayObject.on("mousedown", onMouseDown);
		}
		else
		{
			_native_DisplayObject.off("mouseup", onMouseUp);
			_native_DisplayObject.off("mousedown", onMouseDown);
		}
		
		return _native_DisplayObject.interactive = value;
	}
}