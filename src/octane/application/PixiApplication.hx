package octane.application;

import js.Browser;
import js.html.Event;
import msignal.Signal.Signal0;
import octane.api.application.IApplication;
import octane.api.application.IApplicationProperties;
import octane.application.ApplicationProperties;
import octane.debug.Debug;
import octane.display.Stage;
import pixi.plugins.app.Application;

/**
 * ...
 */
class PixiApplication extends Application implements IApplication
{
	/**
	 * Application ready.
	 */
	public var sigReady:Signal0;
	
	// Application view
	private var _applicationView:Stage;
	
	// Application properties
	private var _applicationProperties:IApplicationProperties;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		sigReady = new Signal0();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		sigReady.removeAll();
		
		
	}
	
	
	
	// API
	//============================================================================================================
	
	public function initialize(properties:ApplicationProperties, ?backgroundColor:Int=0x000000):Void
	{
		_applicationProperties = properties;
		
		// Set pixel ratio, capped at 2
		//pixelRatio = (Browser.window.devicePixelRatio >= 2) ? 2 : 1;
		pixelRatio = 1;
		//Pixi.RETINA_PREFIX = untyped __js__("/scale-(.+)/");
		
		// Background color
		this.backgroundColor = backgroundColor;
		
		// Start
		start();
		
		// Center the renderer
		canvas.style.position = "";
		renderer.view.style.padding = 0;
		renderer.view.style.margin = "auto";
		renderer.view.style.display = "block";
		
		// Force resize
		_onWindowResize(null);
		
		// Dispatch
		sigReady.dispatch();
	}
	
	public function setApplicationView(view:Stage):Void
	{
		_applicationView = view;
		
		// Add native stage
		stage.addChild(view.nativeStage);
		
		// Force resize
		_onWindowResize(null);
		
		Debug.info(this, "Application view set.");
	}
	
	
	
	// OVERRIDES
	//============================================================================================================
	
	override function _onWindowResize(event:Event) 
	{
		if(_applicationView != null && _applicationProperties != null)
		{
			_applicationView.x = Math.ffloor(Browser.window.innerWidth / 2 - _applicationProperties.bucketWidth / 2);
			_applicationView.y = Math.ffloor(Browser.window.innerHeight / 2 - _applicationProperties.bucketHeight / 2);
		}
		
		super._onWindowResize(event);
	}
}