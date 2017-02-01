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