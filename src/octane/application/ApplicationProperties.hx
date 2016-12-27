package octane.application;
import octane.api.application.IApplicationProperties;

/**
 * ...
 */
class ApplicationProperties implements IApplicationProperties
{
	public var bucketPath:String;
	public var bucketWidth:Float;
	public var bucketHeight:Float;
	public var bucketScale:Float;
	public var isMobile:Bool;
	public var isPhone:Bool;
	public var isTablet:Bool;

	/**
	 * Constructor.
	 */
	public function new() 
	{
		
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		
	}	
}