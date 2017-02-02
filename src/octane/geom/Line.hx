package octane.geom;

/**
 * ...
 */
class Line
{
	public var start:Point;
	public var end:Point;
	
	public var a:Float = 0;
	public var b:Float = 0;
	public var c:Float = 0;
	
	/**
	 * Constructor.
	 */
	public function new(start:Point, end:Point) 
	{
		this.start = start;
		this.end = end;
		
		a = end.y - start.y;
		b = start.x - end.x;
		c = a * start.x + b * start.y;
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		start.destroy();
		end.destroy();
		
		start = null;
		end = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	public function intersectionPoint(line:Line):Point
	{
		var delta:Float = a * line.b - line.a * b;
		
		if (delta == 0)
		{
			return new Point(0, 0);
		}
		
		var x:Float = (line.b * c - b * line.c) / delta;
		var y:Float = (a * line.c - line.a * c) / delta;
		
		return new Point(x, y);
	}
	
	public function getCenter():Point
	{
		return new Point(start.x + (end.x - start.x) * 0.5, start.y + (end.y - start.y) * 0.5);
	}
}