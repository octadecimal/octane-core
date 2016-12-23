package octane.skin;

import octane.api.IDestroyable;
import octane.types.NativeTypes.NativeTexture;
import octane.types.NativeTypes.NativeTextureArray;

/**
 * ...
 */
interface ITextureProvider extends IDestroyable
{
	public function getTexture(key:String):NativeTexture;
	public function getTextures(key:String):NativeTextureArray;
}