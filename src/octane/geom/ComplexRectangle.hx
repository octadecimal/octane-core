package octane.geom;

/**
 * A ComplexRectangle is a subclass of Rectangle that provides additional
 * components, corner points and line edges, that are useful for some geometric
 * calculations but are otherwise unnecessary and excessive for most uses of Rectangle.
 */
class ComplexRectangle extends Rectangle
{
	public var topLeftCorner:Point;
	public var topRightCorner:Point;
	public var bottomLeftCorner:Point;
	public var bottomRightCorner:Point;
	
	public var leftEdge:Line;
	public var rightEdge:Line;
	public var topEdge:Line;
	public var bottomEdge:Line;
	
	public var top:Point;
	public var right:Point;
	public var bottom:Point;
	public var left:Point;
	
	/**
	 * Constructor.
	 */
	public function new(?x:Float=0, ?y:Float=0, ?width:Float=0, ?height:Float=0) 
	{
		super(x, y, width, height);
		
		topLeftCorner = new Point(x, y);
		topRightCorner = new Point(x + width, y);
		bottomLeftCorner = new Point(x, y + height);
		bottomRightCorner = new Point(x + width, y + height);
		
		leftEdge = new Line(topLeftCorner, bottomLeftCorner);
		rightEdge = new Line(topRightCorner, bottomRightCorner);
		topEdge = new Line(topLeftCorner, topRightCorner);
		bottomEdge = new Line(bottomLeftCorner, bottomRightCorner);
		
		top = topEdge.getCenter();
		right = rightEdge.getCenter();
		bottom = bottomEdge.getCenter();
		left = leftEdge.getCenter();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		topLeftCorner.destroy();
		topRightCorner.destroy();
		bottomLeftCorner.destroy();
		bottomRightCorner.destroy();
		leftEdge.destroy();
		rightEdge.destroy();
		topEdge.destroy();
		bottomEdge.destroy();
		top.destroy();
		right.destroy();
		bottom.destroy();
		left.destroy();
		
		topLeftCorner = null;
		topRightCorner = null;
		bottomLeftCorner = null;
		bottomRightCorner = null;
		leftEdge = null;
		rightEdge = null;
		topEdge = null;
		bottomEdge = null;
		top = null;
		right = null;
		bottom = null;
		left = null;
		
		super.destroy();
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Returns the nearest line edge of the passed point.
	 * Hard-coded logic but performant. 
	 * @param	point
	 * @return
	 */
	public function getNearestEdge(point:Point):Line
	{
		var dTop:Float = top.distanceBetween(point);
		var dRight:Float = right.distanceBetween(point);
		var dBottom:Float = bottom.distanceBetween(point);
		var dLeft:Float = left.distanceBetween(point);
		
		// Top
		if (dTop < dRight && dTop < dBottom && dTop < dLeft)
		{
			return topEdge;
		}
		
		// Right
		if (dRight < dTop && dRight < dBottom && dRight < dLeft)
		{
			return rightEdge;
		}
		
		// Bottom
		if (dBottom < dTop && dBottom < dRight && dBottom < dLeft)
		{
			return bottomEdge;
		}
		
		// Left
		if (dLeft < dTop && dLeft < dRight && dLeft < dBottom)
		{
			return leftEdge;
		}
		
		return null;
	}
}