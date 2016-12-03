package octane.loading;

import haxe.Http;
import msignal.Signal.Signal2;
import octane.api.loading.ILoader;

/**
 * ...
 */
class StringLoader implements ILoader
{
	public var sigSuccess(default, null):Signal2<ILoader, Dynamic>;
	public var sigError(default, null):Signal2<ILoader, Dynamic>;
	
	public var id(default, null):String;
	public var data(default, null):String;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		sigSuccess = new Signal2();
		sigError = new Signal2();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		sigSuccess.removeAll();
		
		sigSuccess = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Loads a generic text-based string. May be of any file type (txt, json, etc).
	 * @param	id		Resource id.
	 * @param	url		Resource url.
	 */
	public function load(id:String, url:String):Void
	{
		this.id = id;
		
		var http:Http = new Http(url);
		
		http.onError = onError;
		http.onData = onSuccess;
		
		http.request(false);
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * Loading successful.
	 * @param	data
	 */
	private function onSuccess(data:String):Void
	{
		this.data = data;
		sigSuccess.dispatch(this, data);
	}
	
	/**
	 * Loading error.
	 * @param	error
	 */
	private function onError(error:String):Void
	{
		sigError.dispatch(this, error);
		
		throw "String loading failed: " + id + " -> " + error;
	}
}