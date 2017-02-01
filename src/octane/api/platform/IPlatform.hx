package octane.api.platform;

import msignal.Signal.Signal1;
import octane.api.IDestroyable;
import octane.game.model.parsers.Parser;
import octane.game.model.vo.ResponseVO;
import octane.slots.model.parsers.genesis.GameStateParser;

/**
 * ...
 */
interface IPlatform extends IDestroyable
{
	var sigResponseReceived:Signal1<Dynamic>;
	
	var ui(default, null):IGameUI;
	var integrator(default, null):IIntegrator;
	var communicator(default, null):ICommunicator;
	var responseDefinition:Class<ResponseVO>;
	
	function sendRequest(data:Dynamic):Void;
	function registerParser(parser:Parser):Void;
}