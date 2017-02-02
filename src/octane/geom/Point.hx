package octane.geom;

import octane.types.NativeTypes.NativePoint;

/**
 * 
 */
class Point
{
	public var _native_Point(default, null):NativePoint;
	
	/**
	 * X coordinate.
	 */
	public var x(get, set):Float;
	
	/**
	 * Y coordinate.
	 */
	public var y(get, set):Float;
	
	/**
	 * Constructor.
	 * @param	x
	 * @param	y
	 */
	public function new(?x:Float = 0, ?y:Float = 0) 
	{
		_native_Point = new NativePoint(x, y);
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void
	{
		_native_Point = null;
	}
	
	
	
	// API
	// =========================================================================================
	
	/**
	 * Creates and returns a new copy of this point.
	 * @return
	 */
	public function clone():Point
	{
		return new Point(x, y);
	}
	
	/**
	 * Returns the angle between this point and the passed point.
	 * @param	point
	 * @return
	 */
	public function angleBetween(point:Point):Float
	{
		return Math.atan2(point.y - y, point.x - x);
	}
	
	/**
	 * Returns the distance from the passed point to this point.
	 * @param	point
	 * @return
	 */
	public function distanceBetween(point:Point):Float
	{
		var dx:Float = point.x - x;
		var dy:Float = point.y - y;
		
		return Math.sqrt(dx * dx + dy * dy);
	}
	
	
	
	// ACCESSORS
	// =========================================================================================
	
	function get_x():Float 
	{
		return _native_Point.x;
	}
	
	function set_x(value:Float):Float 
	{
		return _native_Point.x = value;
	}
	
	function get_y():Float 
	{
		return _native_Point.y;
	}
	
	function set_y(value:Float):Float 
	{
		return _native_Point.y = value;
	}
}