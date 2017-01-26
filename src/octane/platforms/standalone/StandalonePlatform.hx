package octane.platforms.standalone;

import octane.api.platform.ICommunicator;
import octane.api.platform.IGameUI;
import octane.api.platform.IIntegrator;
import octane.api.platform.IPlatform;
import octane.debug.Debug;


/**
 * ...
 */
class StandalonePlatform implements IPlatform
{
	public var ui(default, null):IGameUI;
	public var integrator(default, null):IIntegrator;
	public var communicator(default, null):ICommunicator;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		Debug.data(this, "Creating...");
		
		Debug.info(this, "Created.");
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		Debug.data(this, "Destroying...");
		
		Debug.info(this, "Destroyed.");
	}
	
}