package octane.display;

import msignal.Signal.Signal1;
import octane.api.display.IDisplayObject;
import octane.api.display.ISkin;
import octane.display.Container;
import octane.geom.Rectangle;
import octane.types.NativeTypes.NativeDisplayObject;

/**
 * ...
 */
class DisplayObject implements IDisplayObject
{
	/**
	 * Dispatched when `interactive` is set to true and this display object is clicked.
	 */
	public var sigClicked(default, null):Signal1<DisplayObject>;
	
	/**
	 * Dispatched when `interactive` is set to true and the mouse is pressed over this display object.
	 */
	public var sigMouseDown(default, null):Signal1<DisplayObject>;
	
	/**
	 * Dispatched when `interactive` is set to true and the mouse is rolled out of this display object.
	 */
	public var sigMouseOut(default, null):Signal1<DisplayObject>;
	
	/**
	 * Dispatched when `interactive` is set to true and the mouse is rolled over this display object.
	 */
	public var sigMouseOver(default, null):Signal1<DisplayObject>;
	
	
	/**
	 * Name of this display object.
	 */
	public var name(default, default):String;
	
	/**
	 * [DEPRECATE]
	 * Reference to an optional game skin reference. This is useful as it can provide a common
	 * pattern for passing a skin reference to a child display object, and also allows for automated
	 * mechanisms like the DOMBuilder to set this reference so that it's easily exposed and
	 * accesible to the game programmer.
	 */
	public var gameSkin(default, default):ISkin;
	
	/**
	 * If true, this display object will be cached as a bitmap.
	 */
	public var cacheAsBitmap(get, set):Bool;
	
	/**
	 * Display object visibility.
	 */
	public var visible(get, set):Bool;
	
	/**
	 * Display object horizontal position in absolute pixels.
	 */
	public var x(get, set):Float;
	
	/**
	 * Display object vertical position in absolute pixels.
	 */
	public var y(get, set):Float;
	
	/**
	 * Display object x pivot in absolute pixels.
	 */
	public var pivotX(get, set):Float;
	
	/**
	 * Display object y pivot in absolute pixels.
	 */
	public var pivotY(get, set):Float;
	
	/**
	 * Display object horizontal scale.
	 */
	public var scaleX(get, set):Float;
	
	/**
	 * Display object vertical scale.
	 */
	public var scaleY(get, set):Float;
	
	/**
	 * Display object width in absolute pixels.
	 */
	public var width(get, set):Float;
	
	/**
	 * Display object height in absolute scale.
	 */
	public var height(get, set):Float;
	
	/**
	 * Display object alpha.
	 */
	public var alpha(get, set):Float;
	
	/**
	 * Display object rotation in radians.
	 */
	public var rotation(get, set):Float;
	
	/**
	 * Display object mask.
	 */
	public var mask(get, set):DisplayObject;
	
	/**
	 * Parent of this display object.
	 */
	public var parent(default, default):Container;
	
	/**
	 * Interactive flag, if true mouse handlers will be added and interaction signals will be dispatched.
	 */
	public var interactive(get, set):Bool;
	
	/**
	 * Scale resolution.
	 */
	public var resolution(default, set):Float = 1;
	
	
	// Reference to native display object.
	private var _native_DisplayObject(null, null):NativeDisplayObject;
	
	
	// Virtual scale, used for handling resolution with native scaling.
	private var _virtualScaleX:Float = 1;
	private var _virtualScaleY:Float = 1;
	
	
	
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
		sigMouseOut = new Signal1<DisplayObject>();
		sigMouseOver = new Signal1<DisplayObject>();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void
	{
		if (interactive)
		{
			interactive = false;
		}
		
		sigClicked.removeAll();
		sigMouseDown.removeAll();
		sigMouseOut.removeAll();
		sigMouseOver.removeAll();
		
		_native_DisplayObject.destroy();
		
		sigClicked = null;
		sigMouseDown = null;
		sigMouseOut = null;
		sigMouseOver = null;
		gameSkin = null;
		_native_DisplayObject = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Removes this display object from its parent container, also allowing automatic destruction.
	 * @param	destroy		If true, object will also destroy itself.
	 */
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
	
	/**
	 * Aligns and fits this object to the passed rectangluar boundary.
	 * @param	rect			Input rectangle to fit to.
	 * @param	anchorX			Horizontal alignment.
	 * @param	anchorY			Vertical alignemnt.
	 * @param	roundPixels		If turue (default), final fitted vales will be rounded.
	 */
	public function fitToRect(rect:Rectangle, ?anchorX:Float = 0.5, ?anchorY:Float = 0.5, ?roundPixels:Bool = true):Void
	{
		scaleX = scaleY = 1;
		
		if (width > rect.width || height > rect.height)
		{
			scaleX = scaleY = Math.min(rect.width / width, rect.height / height);
		}
		
		x = rect.x + (rect.width  * anchorX) - (width  * anchorX);
		y = rect.y + (rect.height * anchorY) - (height * anchorY);
		
		if (roundPixels)
		{
			x = Math.ffloor(x);
			y = Math.ffloor(y);
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * Mouse up.
	 */
	private function onMouseUp():Void
	{
		sigClicked.dispatch(this);
	}
	
	/**
	 * Mouse down.
	 */
	private function onMouseDown():Void
	{
		sigMouseDown.dispatch(this);
	}
	
	/**
	 * Mouse out.
	 */
	private function onMouseOut():Void
	{
		sigMouseOut.dispatch(this);
	}
	
	/**
	 * Mouse over.
	 */
	private function onMouseOver():Void
	{
		sigMouseOver.dispatch(this);
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
		return _virtualScaleX;
	}
	
	private function set_scaleX(value:Float):Float
	{
		_native_DisplayObject.scale.x = value / resolution;
		return _virtualScaleX = value;
	}
	
	
	private function get_scaleY():Float
	{
		return _virtualScaleY;
	}
	
	private function set_scaleY(value:Float):Float
	{
		_native_DisplayObject.scale.y = value / resolution;
		return _virtualScaleY = value;
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
	
	
	private function set_resolution(value:Float):Float
	{
		this.resolution = value;
		this.scaleX = this.scaleX;
		this.scaleY = this.scaleY;
		
		trace(this.scaleX, this.scaleY);
		
		return this.resolution;
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
			_native_DisplayObject.on("mousedown", onMouseDown);
			_native_DisplayObject.on("mouseup", onMouseUp);
			_native_DisplayObject.on("touchstart", onMouseDown);
			_native_DisplayObject.on("touchend", onMouseUp);
			_native_DisplayObject.on("mouseout", onMouseOut);
			_native_DisplayObject.on("mouseover", onMouseOver);
		}
		else
		{
			_native_DisplayObject.off("mousedown", onMouseDown);
			_native_DisplayObject.off("mouseup", onMouseUp);
			_native_DisplayObject.off("touchstart", onMouseDown);
			_native_DisplayObject.off("touchend", onMouseUp);
			_native_DisplayObject.off("mouseout", onMouseOut);
			_native_DisplayObject.off("mouseover", onMouseOver);
		}
		
		return _native_DisplayObject.interactive = value;
	}
}