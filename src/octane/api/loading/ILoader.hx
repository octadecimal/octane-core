package octane.api.loading;

import msignal.Signal.Signal2;
import octane.api.IDestroyable;

/**
 * 
 */
interface ILoader extends IDestroyable
{
	public var id(default, null):String;
	public var data(default, null):Dynamic;
	
	public var sigSuccess(default, null):Signal2<ILoader, Dynamic>;
	public var sigError(default, null):Signal2<ILoader, Dynamic>;
	
	public function load(id:String, url:String):Void;
}