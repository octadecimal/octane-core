package octane.application;
import octane.api.application.IApplicationProperties;

/**
 * ...
 */
class ApplicationProperties implements IApplicationProperties
{
	public var bucketPath:String = "resources/default/1024x648/scale-1/";
	public var bucketWidth:Float = 1024;
	public var bucketHeight:Float = 768;
	
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