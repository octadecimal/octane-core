package octane.geom;

import octane.types.NativeTypes.NativeRectangle;

/**
 * A rectangle represents a boundary with a position (x,y) and a width and height.
 */
class Rectangle
{
	/**
	 * X coordinate.
	 */
	public var x(get, set):Float;
	
	/**
	 * Y coordinate.
	 */
	public var y(get, set):Float;
	
	/**
	 * Width.
	 */
	public var width(get, set):Float;
	
	/**
	 * Height.
	 */
	public var height(get, set):Float;
	
	
	// Native rectangle reference
	private var _native_Rectangle(null, null):NativeRectangle;
	
	
	/**
	 * Constructor.
	 */
	public function new(?x:Float = 0, ?y:Float = 0, ?width:Float = 0, ?height:Float = 0) 
	{
		_native_Rectangle = new NativeRectangle(x, y, width, height);
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		_native_Rectangle = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Returns a copy (new instance) of this rectangle.
	 * @return
	 */
	public function clone():Rectangle
	{
		return new Rectangle(x, y, width, height);
	}
	
	/**
	 * Returns true if the passed x,y coordinates exist in this rectangle's boundary.
	 * @param	x
	 * @param	y
	 * @return
	 */
	public function contains(x:Float, y:Float):Bool
	{
		return _native_Rectangle.contains(x, y);
	}
	
	
	
	// ACCESSORS
	//============================================================================================================
	
	function get_x():Float 
	{
		return _native_Rectangle.x;
	}
	
	function set_x(value:Float):Float 
	{
		return _native_Rectangle.x = value;
	}
	
	function get_y():Float 
	{
		return _native_Rectangle.y;
	}
	
	function set_y(value:Float):Float 
	{
		return _native_Rectangle.y = value;
	}
	
	function get_width():Float 
	{
		return _native_Rectangle.width;
	}
	
	function set_width(value:Float):Float 
	{
		return _native_Rectangle.width = value;
	}
	
	function get_height():Float 
	{
		return _native_Rectangle.height;
	}
	
	function set_height(value:Float):Float 
	{
		return _native_Rectangle.height = value;
	}
}