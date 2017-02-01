package octane.display;

import octane.types.NativeTypes;

/**
 * ...
 */
class Container extends DisplayObject
{
	/**
	 * Number of children in this container's display list.
	 */
	public var numChildren(get, null):Int;
	
	
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
		if (_native_Container == null)
		{
			_native_DisplayObject = _native_Container = new NativeContainer();
		}
		
		// Create child lookup map
		if (_childrenMap == null)
		{
			_childrenMap = new Map<NativeDisplayObject, DisplayObject>();
		}
		
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
	
	
	
	// ACCESSORS
	//============================================================================================================
	
	private function get_numChildren():Int 
	{
		return _native_Container.children.length;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Adds the passed child display object on top of this container's display list.
	 * @param	child
	 */
	public function addChild(child:DisplayObject):DisplayObject
	{
		return addChildAt(child, numChildren);
	}
	
	/**
	 * Adds the passed child display object at the specified index of this container's display list.
	 * @param	child
	 * @param	index
	 */
	public function addChildAt(child:DisplayObject, index:Int):DisplayObject
	{
		_childrenMap.set(child._native_DisplayObject, child);
		_native_Container.addChildAt(child._native_DisplayObject, index);
		child.parent = this;
		return child;
	}
	
	/**
	 * Removes the passed child from this container's display list.
	 * @param	child
	 * @return
	 */
	public function removeChild(child:DisplayObject):DisplayObject
	{
		_childrenMap.remove(child._native_DisplayObject);
		_native_Container.removeChild(child._native_DisplayObject);
		child.parent = null;
		return child;
	}
	
	/**
	 * Returns a reference to the child display object in this container's display list that exists at the 
	 * specified index.
	 * @param	index
	 * @return
	 */
	public function getChildAt(index:Int):DisplayObject
	{
		return _childrenMap.get(_native_Container.getChildAt(index));
	}
	
	/**
	 * Returns a reference to a child display object that matches the specified name.
	 * @param	childName
	 * @return
	 */
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