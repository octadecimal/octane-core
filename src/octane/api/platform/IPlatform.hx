package octane.api.platform;
import octane.api.IDestroyable;

/**
 * ...
 */
interface IPlatform extends IDestroyable
{
	var ui(default, null):IGameUI;
	var integrator(default, null):IIntegrator;
	var communicator(default, null):ICommunicator;
}