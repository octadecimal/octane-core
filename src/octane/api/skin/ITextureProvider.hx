package octane.api.skin;

import octane.api.IDestroyable;
import octane.display.SpineResource;
import octane.types.NativeTypes.NativeTexture;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
interface ITextureProvider extends IDestroyable
{
	function hasTexture(textureName:String):Bool;
	function getTexture(key:String):NativeTexture;
	function getTextures(key:String):NativeTextureArray;
	function getSpineResource(key:String):SpineResource;
}