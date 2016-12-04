package octane.api.application;

import msignal.Signal.Signal0;
import octane.api.IDestroyable;
import octane.application.ApplicationProperties;
import octane.display.Stage;

/**
 * ...
 */
interface IApplication extends IDestroyable
{
	var sigReady:Signal0;
	
	var backgroundColor:Int;
	
	function initialize(properties:ApplicationProperties, ?backgroundColor:Int=0x000000):Void;
	
	function setApplicationView(view:Stage):Void;
}