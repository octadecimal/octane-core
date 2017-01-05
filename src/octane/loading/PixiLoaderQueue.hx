package octane.loading;

import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import octane.api.loading.IAssetLoaderQueue;
import octane.api.loading.ILoader;
import octane.debug.Debug;
import octane.types.NativeTypes.NativeTexture;
import pixi.loaders.Loader;
import pixi.loaders.Resource;

/**
 * ...
 */
class PixiLoaderQueue implements IAssetLoaderQueue
{
	/**
	 * String loaded.
	 */
	public var sigStringLoaded(default, null):Signal2<String, Dynamic>;
	
	/**
	 * Xml loaded.
	 */
	public var sigXmlLoaded(default, null):Signal2<String, Dynamic>;
	
	/**
	 * Texture (single) loaded.
	 */
	public var sigTextureLoaded(default, null):Signal2<String, NativeTexture>;
	
	/**
	 * Subtextures (tilesheet) loaded.
	 */
	public var sigSubtextureLoaded(default, null):Signal2<String, NativeTexture>;
	
	/**
	 * Loading progress.
	 */
	public var sigProgress(default, null):Signal2<Float, String>;
	
	/**
	 * Loading complete.
	 */
	public var sigComplete(default, null):Signal0;
	
	/**
	 * Number of resources to load.
	 */
	public var numResourcesToLoad:Int = 0;
	
	/**
	 * Number of resources loaded.
	 */
	public var numResourcesLoaded:Int = 0;
	
	/**
	 * Progress value.
	 */
	public var progress(default, null):Float = 1;
	
	
	// Pixi loader queue (handles textures)
	private var _pixiLoader:Loader;
	
	// Raw strings to load
	private var _stringResources:Map<String, String>;
	
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		Debug.data(this, "Creating...");
		
		sigTextureLoaded = new Signal2();
		sigSubtextureLoaded = new Signal2();
		sigStringLoaded = new Signal2();
		sigXmlLoaded = new Signal2();
		sigProgress = new Signal2();
		sigComplete = new Signal0();
		
		_pixiLoader = new Loader();
		
		_stringResources = new Map<String, String>();
		
		Debug.info(this, "Created.");
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		Debug.info(this, "Destroying...");
		
		sigStringLoaded.removeAll();
		sigXmlLoaded.removeAll();
		sigTextureLoaded.removeAll();
		sigSubtextureLoaded.removeAll();
		sigProgress.removeAll();
		sigComplete.removeAll();
		
		_pixiLoader = null;
		
		Debug.info(this, "Destroyed.");
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Adds a string (json, txt, etc) to be loaded.
	 * @param	id
	 * @param	path
	 */
	public function addString(id:String, path:String):Void
	{
		numResourcesToLoad++;
		
		_pixiLoader.add(id, path, onPixiResourceLoaded);
	}
	
	/**
	 * Adds an xml file to be loaded.
	 * @param	id
	 * @param	path
	 */
	public function addXml(id:String, path:String):Void
	{
		numResourcesToLoad++;
		
		_stringResources.set(id, path);
	}
	
	/**
	 * Adds an image to be loaded.
	 * @param	id
	 * @param	path
	 */
	public function addImage(id:String, path:String):Void
	{
		numResourcesToLoad++;
		
		_pixiLoader.add(id, path, onPixiResourceLoaded);
	}
	
	/**
	 * Starts loading the queue.
	 */
	public function startLoading():Void
	{
		if (numResourcesToLoad == 0)
		{
			return;
		}
		
		progress = 0;
		numResourcesLoaded = 0;
		
		// Start pixi loading
		_pixiLoader.load();
		
		// Load strings
		for (key in _stringResources.keys())
		{
			var stringLoader:StringLoader = new StringLoader();
			stringLoader.sigSuccess.addOnce(onStringLoaded);
			stringLoader.load(key, _stringResources.get(key));
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * signal: Pixi resource loaded.
	 * @param	resource
	 */
	private function onPixiResourceLoaded(resource:Resource):Void
	{
		if (resource.isImage)
		{
			sigTextureLoaded.dispatch(resource.name, resource.texture);
		}
		
		if (resource.isJson)
		{
			if (resource.textures != null)
			{
				for (texture in Reflect.fields(resource.textures))
				{
					sigSubtextureLoaded.dispatch(texture, NativeTexture.fromFrame(texture));
				}
			}
			else
			{
				sigStringLoaded.dispatch(resource.name, resource.data);
			}
		}
		
		handleProgress(resource.name);
	}
	
	/**
	 * signal: Raw string loaded.
	 * @param	loader
	 * @param	data
	 */
	private function onStringLoaded(loader:ILoader, data:String) 
	{
		if (loader.id.lastIndexOf(".xml") > -1)
		{
			sigXmlLoaded.dispatch(loader.id, Xml.parse(data));
		}
		
		handleProgress(loader.id);
	}
	
	/**
	 * Handles progress updates.
	 */
	private function handleProgress(id:String):Void
	{
		numResourcesLoaded++;
		
		progress = numResourcesLoaded / numResourcesToLoad;
		
		sigProgress.dispatch(progress, id);
		
		if (numResourcesLoaded == numResourcesToLoad)
		{
			Debug.info(this, "Queue complete.");
			sigComplete.dispatch();
			
			_stringResources = new Map<String, String>();
			numResourcesToLoad = 0;
			numResourcesLoaded = 0;
		}
	}
}