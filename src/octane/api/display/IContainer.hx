package octane.api.display;

import octane.display.DisplayObject;

/**
 * ...
 */
interface IContainer extends IDisplayObject
{
	function addChild(child:DisplayObject):DisplayObject;
	function removeChild(child:DisplayObject):DisplayObject;
	function getChildByName(childName:String):DisplayObject;
}