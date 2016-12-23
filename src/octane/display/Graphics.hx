package octane.display;

import octane.types.NativeTypes.NativeGraphics;

/**
 * ...
 */
class Graphics extends DisplayObject
{
	private var _native_Graphics(null, null):NativeGraphics;

	/**
	 * Constructor.
	 */
	public function new()
	{
		_native_DisplayObject = _native_Graphics = new NativeGraphics();
		
		super();
	}

	/**
	 * Destructor.
	 */
	override public function destroy():Void
	{
		_native_Graphics = null;
		
		super.destroy();
	}
	
	
	
	// API
	//============================================================================================================

	/**
	 * Clears the graphics buffer.
	 * @return
	 */
	public function clear():Graphics
	{
		_native_Graphics.clear();
		
		return this;
	}
	
	/**
	 * Sets the line style before drawing.
	 * @param	lineWidth
	 * @param	color
	 * @param	alpha
	 * @return
	 */
	public function lineStyle(?lineWidth:Float, ?color:Int, ?alpha:Float):Graphics
	{
		_native_Graphics.lineStyle(lineWidth, color, alpha);
		
		return this;
	}

	/**
	 * Begins a fill.
	 * @param	color
	 * @param	alpha
	 * @return
	 */
	public function beginFill(color:UInt, ?alpha:Float = 1.0):Graphics
	{
		_native_Graphics.beginFill(color, alpha);
		
		return this;
	}

	/**
	 * Ends a fill, effectively drawing the shape.
	 * @return
	 */
	public function endFill():Graphics
	{
		_native_Graphics.endFill();
		
		return this;
	}

	/**
	 * Draws a rectangle.
	 * @param	x
	 * @param	y
	 * @param	width
	 * @param	height
	 * @return
	 */
	public function drawRect(x:Float, y:Float, width:Float, height:Float):Graphics
	{
		_native_Graphics.drawRect(x, y, width, height);
		
		return this;
	}

	/**
	 * Draws a rounded rectangle.
	 * @param	x
	 * @param	y
	 * @param	width
	 * @param	height
	 * @param	radius
	 * @return
	 */
	public function drawRoundedRect(x:Float, y:Float, width:Float, height:Float, radius:Float):Graphics
	{
		_native_Graphics.drawRoundedRect(x, y, width, height, radius);
		
		return this;
	}

	/**
	 * Draws a circle.
	 * @param	x
	 * @param	y
	 * @param	radius
	 * @return
	 */
	public function drawCircle(x:Float, y:Float, radius:Float):Graphics
	{
		_native_Graphics.drawCircle(x, y, radius);
		
		return this;
	}

	/**
	 * Draws an ellipse.
	 * @param	x
	 * @param	y
	 * @param	width
	 * @param	height
	 * @return
	 */
	public function drawEllipse(x:Float, y:Float, width:Float, height:Float):Graphics
	{
		_native_Graphics.drawEllipse(x, y, width, height);
		
		return this;
	}

}