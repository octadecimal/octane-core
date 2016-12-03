package octane.display;

import octane.display.Container;
import octane.geom.Rectangle;

/**
 * ...
 */
class ViewComponent extends Container
{
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	
	
	// API
	//============================================================================================================
	
	public function build():Void
	{
		
	}
	
	public function setInitialState():Void
	{
		
	}
	
	public function addRegion(name:String, region:Rectangle) 
	{
		
	}
}