package octane.api.loading;

import msignal.Signal;
import octane.api.IDestroyable;
import octane.types.NativeTypes;

/**
 * ...
 */
interface IAssetLoaderQueue extends ILoaderQueue
{
	var sigStringLoaded(default, null):Signal2<String, Dynamic>;
	var sigXmlLoaded(default, null):Signal2<String, Dynamic>;
	var sigTextureLoaded(default, null):Signal2<String, NativeTexture>;
	var sigSubtextureLoaded(default, null):Signal2<String, NativeTexture>;
	
	function addString(id:String, path:String):Void;
	function addXml(id:String, path:String):Void;
	function addImage(id:String, path:String):Void;
}