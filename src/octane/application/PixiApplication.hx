package octane.application;

import js.Browser;
import js.html.CanvasElement;
import js.html.Element;
import js.html.Event;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import octane.api.application.IApplication;
import octane.api.application.IApplicationProperties;
import octane.debug.Debug;
import octane.display.Stage;
import pixi.core.Settings;
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
	
	/**
	 * Application resized.
	 */
	public var sigResized:Signal2<Float, Float>;
	
	/**
	 * Application tick.
	 */
	public var sigTick:Signal1<Float>;
	
	/**
	 * Application properties.
	 */
	public var properties:IApplicationProperties;
	
	/**
	 * Bucket and screen boundaries.
	 */
	public var bucketWidth:Float;
	public var bucketHeight:Float;
	public var screenWidth:Float;
	public var screenHeight:Float;
	
	/**
	 * Time since last frame.
	 */
	public var frameTime:Float;
	
	
	// Application view
	private var _applicationView:Stage;
	
	// Previous time, used for measuring frame times
	private var _previousTime:Float;
	
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		sigReady = new Signal0();
		sigResized = new Signal2();
		sigTick = new Signal1();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		sigReady.removeAll();
		sigResized.removeAll();
		sigTick.removeAll();
		
		_applicationView.destroy();
		
		sigReady = null;
		sigResized = null;
		sigTick = null;
		properties = null;
		_applicationView = null;
	}
	
	
	
	// API
	//============================================================================================================
	
	/**
	 * Initializes the application.
	 * @param	properties
	 * @param	backgroundColor
	 */
	public function initialize(properties:IApplicationProperties, ?backgroundColor:Int=0x000000):Void
	{
		// Application properties
		this.properties = properties;
		
		// Save bucket props
		this.bucketWidth = properties.bucketWidth;
		this.bucketHeight = properties.bucketHeight;
		
		// Background color
		this.backgroundColor = backgroundColor;
		
		// Set resolution
		this.pixelRatio = properties.bucketScale;
		Settings.RETINA_PREFIX = untyped __js__("/scale-(.+)/");
		
		// Start
		start();
		
		// Center the renderer
		//canvas.style.position = "";
		//renderer.view.style.padding = 0;
		//renderer.view.style.margin = "auto";
		//renderer.view.style.display = "block";
		
		// Listen for ticks
		app.ticker.add(onTick);
		
		// Force resize
		_onWindowResize(null);
		
		// Dispatch
		sigReady.dispatch();
	}
	
	/**
	 * Set the applicaiton view, can be called after application has already been initialized.
	 * @param	view
	 */
	public function setApplicationView(view:Stage):Void
	{
		_applicationView = view;
		
		// Add native stage
		stage.addChild(view.nativeStage);
		
		// Force resize
		_onWindowResize(null);
		
		Debug.info(this, "Application view set.");
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	/**
	 * event: Window resized.
	 * @param	event
	 */
	override function _onWindowResize(event:Event) 
	{
		this.screenWidth = Browser.window.innerWidth;
		this.screenHeight = Browser.window.innerHeight;
		
		if(_applicationView != null && properties != null)
		{
			//_applicationView.x = Math.ffloor(_applicationView.x);
			//_applicationView.y = Math.ffloor(_applicationView.y);
			//_applicationView.x = Math.ffloor((Browser.window.innerWidth - properties.bucketWidth) / 2);
			//_applicationView.y = Math.ffloor((Browser.window.innerHeight - properties.bucketHeight) / 2);
		}
		
		super._onWindowResize(event);
		
		// Dispatch application signals
		sigResized.dispatch(Browser.window.innerWidth, Browser.window.innerHeight);
	}
	
	/**
	 * event: Animation frame requested.
	 * @param	elapsedTime
	 */
	override function _onRequestAnimationFrame() 
	{
		// Render
		super._onRequestAnimationFrame();
	}
	
	/**
	 * event: Tick.
	 */
	private function onTick():Void 
	{
		// Dispatch tick
		sigTick.dispatch(app.ticker.deltaTime);
	}
}