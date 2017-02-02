package octane.api.platform;

import msignal.Signal.Signal1;
import octane.api.IDestroyable;
import octane.integration.ResponseParser;
import octane.game.model.vo.ResponseVO;
import octane.slots.model.parsers.genesis.GameStateParser;

/**
 * ...
 */
interface IPlatform extends IDestroyable
{
	var sigResponseReceived:Signal1<ResponseVO>;
	
	var ui(default, null):IGameUI;
	var integrator(default, null):IIntegrator;
	var communicator(default, null):ICommunicator;
	var responseDefinition:Class<ResponseVO>;
	var lastResponse(default, null):ResponseVO;
	
	function sendRequest(data:Dynamic):Void;
	function registerParser(parser:ResponseParser):Void;
}