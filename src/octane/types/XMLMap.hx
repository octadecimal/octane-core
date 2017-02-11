package octane.types;

import octane.assert.Assert;
import octane.debug.Debug;

/**
 * Abstract that wraps XMLNode to provide easier lookup functionality.
 */
@:forward()
abstract XMLMap(XMLNode) from XMLNode to XMLNode
{
	/**
	 * Constructor.
	 * @param	node
	 */
	inline public function new(node:XMLNode) 
	{
		this = node;
	}
	
	
	
	// API
	//============================================================================================================
	
	public function exists(path:String):Bool
	{
		var currentNode = this;
		var paths:Array<String> = path.split(".");
		
		while (paths.length > 0)
		{
			var currentPath:String = paths.shift();
			currentNode = getChildNodeByName(currentNode, currentPath);
			
			if (currentNode == null)
			{
				return false;
			}
		}
		
		return true;
	}
	
	public function get(path:String):XMLMap
	{
		var currentNode = this;
		var paths:Array<String> = path.split(".");
		
		while (paths.length > 0)
		{
			var currentPath:String = paths.shift();
			currentNode = getChildNodeByName(currentNode, currentPath);
			
			Assert.isNotNull(currentNode, "Failed to find node `" + currentPath + "` in path `" + path + "`");
		}
		
		return new XMLMap(currentNode);
	}
	
	public function getString(path:String):String
	{
		return get(path).text;
	}
	
	public function getInt(path:String):Int
	{
		return Std.parseInt(get(path).text);
	}
	
	public function getFloat(path:String):Float
	{
		return Std.parseFloat(get(path).text);
	}
	
	public function getBool(path:String):Bool
	{
		return get(path).text.toLowerCase() == "true";
	}
	
	public function hasChildren(path:String):Bool
	{
		var node:XMLMap = get(path);
		return node.childNodes != null && node.childNodes.length > 0;
	}
	
	
	
	// PRIVATE
	//============================================================================================================
	
	private function getChildNodeByName(node:XMLMap, name:String):XMLMap
	{
		for (childNode in node.childNodes)
		{
			if (childNode.nodeName == name)
			{
				return childNode;
			}
		}
		
		return null;
	}
}