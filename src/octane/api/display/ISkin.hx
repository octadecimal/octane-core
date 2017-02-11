package octane.api.display;

import octane.api.IDestroyable;
import octane.api.skin.ITextureProvider;
import octane.display.AssetGroup;
import octane.types.DynamicExt;
import octane.types.NativeTypes.NativeTexture;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
interface ISkin extends IDestroyable
{
	var assetGroupDefinitions(null, default):DynamicExt;
	var animationDefinitions(null, default):DynamicExt;
	
	function attachTextureProvider(textureProvider:ITextureProvider):Void;
	function getTextures(textureNamePrefix:String):NativeTextureArray;
	function getTexture(textureName:String):NativeTexture;
	function hasTexture(textureName:String):Bool;
	function getSpineData(resourceName:String):Dynamic;
	function getAssetGroup(name:String):AssetGroup;
	
	function addGroupedTexture(groupName:String, textureName:String, texture:String):Void;
	function getGroupedTexture(groupName:String, textureName:String):NativeTexture;
}