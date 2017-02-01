package octane.resources;
import octane.types.DynamicExt;

/**
 * ...
 * @author Dylan Heyes
 */
class ResourceList 
{
	private var _data:DynamicExt;
	
	private var _contexts:Map<String, Map<String, String>>;
	private var _resources:Map<String, String>;
	
	/**
	 * Constructor.
	 * @param	data
	 */
	public function new(data:DynamicExt) 
	{
		_data = data;
		
		_contexts = buildContextMap(data);
		_resources = buildResourceMap(data);
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void
	{
		_data = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Returns the resource path for a resource by id.
	 * @param	id
	 */
	public function getResourcePath(id:String):String
	{
		return _resources.get(id);
	}
	
	/**
	 * Returns a map of resources that belong to the passed context.
	 * @param	context
	 * @return
	 */
	public function getContextResources(context:String):Map<String, String>
	{
		return _contexts.get(context);
	}
	
	
	
	// PRIVATE
	//============================================================================================================
	
	/**
	 * Builds a contextualized map of all resources.
	 * @param	input
	 * @return
	 */
	private function buildContextMap(input:DynamicExt):Map<String, Map<String, String>>
	{
		var output:Map<String, Map<String, String>> = new Map<String, Map<String, String>>();
		
		for (contextKey in input.keys())
		{
			var contextMap:Map<String, String> = new Map<String, String>();
			
			output.set(contextKey, contextMap);
			
			for (assetKey in input.get(contextKey).keys())
			{
				contextMap.set(assetKey, input.get(contextKey).get(assetKey));
			}
		}
		
		return output;
	}
	
	/**
	 * Builds a flat non-contextualized map of all resources.
	 * @param	input
	 * @return
	 */
	private function buildResourceMap(input:DynamicExt):Map<String, String>
	{
		var output:Map<String, String> = new Map<String, String>();
		
		for (contextKey in input.keys())
		{
			var contextExt:DynamicExt = input.get(contextKey);
			
			for (contextAssetKey in contextExt.keys())
			{
				output.set(contextAssetKey, contextExt.get(contextAssetKey));
			}
		}
		
		return output;
	}
}