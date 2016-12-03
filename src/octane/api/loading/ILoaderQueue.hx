package octane.api.loading;

import msignal.Signal;
import octane.api.IDestroyable;

/**
 * ...
 */
interface ILoaderQueue extends IDestroyable
{
	var sigProgress(default, null):Signal2<Float, String>;
	var sigComplete(default, null):Signal0;
	
	var progress(default, null):Float;
	
	function startLoading():Void;
}