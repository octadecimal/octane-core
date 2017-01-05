package octane.display;

import octane.types.NativeTypes;

/**
 * ...
 */
class Container extends DisplayObject
{
	// Native object
	private var _native_Container:NativeContainer;

	// Child map that maps native display types to abstract types
	private var _childrenMap:Map<NativeDisplayObject, DisplayObject>;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		// Create native container
		_native_DisplayObject = _native_Container = new NativeContainer();
		
		// Create child lookup map
		_childrenMap = new Map<NativeDisplayObject, DisplayObject>();
		
		super();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		_childrenMap = null;
		
		super.destroy();
	}
	
	
	
	// API
	//============================================================================================================
	
	public function addChild(child:DisplayObject):DisplayObject
	{
		_native_Container.addChild(child._native_DisplayObject);
		_childrenMap.set(child._native_DisplayObject, child);
		child.parent = this;
		return child;
	}
	
	public function addChildAt(child:DisplayObject, index:Int):DisplayObject
	{
		_native_Container.addChildAt(child._native_DisplayObject, index);
		_childrenMap.set(child._native_DisplayObject, child);
		child.parent = this;
		return child;
	}
	
	public function removeChild(child:DisplayObject):DisplayObject
	{
		_native_Container.removeChild(child._native_DisplayObject);
		_childrenMap.remove(child._native_DisplayObject);
		child.parent = null;
		return child;
	}
	
	public function getChildByName(childName:String):DisplayObject
	{
		for(child in _childrenMap)
		{
			if(child.name == childName)
			{
				return child;
			}
		}
		
		return null;
	}
}