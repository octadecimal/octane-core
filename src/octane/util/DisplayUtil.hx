package octane.util;
import octane.display.DisplayObject;
import octane.display.TextField;
import octane.geom.Point;
import octane.geom.Rectangle;

/**
 * ...
 */
class DisplayUtil
{
	static public function centerPivot(object:DisplayObject, ?roundPixels:Bool = true):Void
	{
		object.pivotX = object.width / 2;
		object.pivotY = object.height / 2;
		
		if (roundPixels)
		{
			object.pivotX = Math.ffloor(object.pivotX);
			object.pivotY = Math.ffloor(object.pivotY);
		}
	}
	
	public function centerPivotAndOffset(object:DisplayObject, ?roundPixels:Bool = true):Void
	{
		centerPivot(object);
		
		object.x += object.pivotX;
		object.y += object.pivotY;
		
		if (roundPixels)
		{
			object.x = Math.ffloor(object.x);
			object.y = Math.ffloor(object.y);
		}
	}
	
	static public function fitTextFieldToRegion(textField:TextField, region:Rectangle):Void
	{
		textField.anchor = new Point(0.5, 0.5);
		
		textField.x = Math.ffloor(region.width / 2);
		textField.y = Math.ffloor(region.height / 2);
	}
	
	static public function expandRectangle(input:Rectangle, width:Float, height:Float):Rectangle
	{
		var output:Rectangle = new Rectangle();
		
		output.x = input.x - width;
		output.width = input.width + width * 2;
		
		output.y = input.y - height;
		output.height = input.height + height * 2;
		
		return output;
	}
}