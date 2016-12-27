package octane.api.application;

import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import octane.api.IDestroyable;
import octane.application.ApplicationProperties;
import octane.display.Stage;

/**
 * ...
 */
interface IApplication extends IDestroyable
{
	var sigReady:Signal0;
	var sigResized:Signal2<Float, Float>;
	var sigTick:Signal1<Float>;
	
	var properties:IApplicationProperties;
	
	var backgroundColor:Int;
	
	function initialize(properties:ApplicationProperties, ?backgroundColor:Int=0x000000):Void;
	
	function setApplicationView(view:Stage):Void;
}