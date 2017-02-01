package octane.platforms.standalone;

import msignal.Signal.Signal1;
import octane.api.platform.ICommunicator;
import octane.api.platform.IGameUI;
import octane.api.platform.IIntegrator;
import octane.api.platform.IPlatform;
import octane.game.model.parsers.Parser;
import octane.debug.Debug;
import octane.game.model.vo.ResponseVO;


/**
 * ...
 */
class StandalonePlatform implements IPlatform
{
	public var sigResponseReceived:Signal1<Dynamic>;
	
	public var ui(default, null):IGameUI;
	public var integrator(default, null):IIntegrator;
	public var communicator(default, null):ICommunicator;
	
	public var responseDefinition:Class<ResponseVO> = ResponseVO;
	
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
	
	
	/* INTERFACE octane.api.platform.IPlatform */
	
	public function sendRequest(data:Dynamic):Void 
	{
		
	}
	
	
	/* INTERFACE octane.api.platform.IPlatform */
	
	public function registerParser(parser:Parser):Void 
	{
		
	}
	
	
	/* INTERFACE octane.api.platform.IPlatform */
	
}