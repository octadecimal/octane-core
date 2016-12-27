package octane.application;

import js.Browser;
import js.html.Event;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import octane.api.application.IApplication;
import octane.api.application.IApplicationProperties;
import octane.debug.Debug;
import octane.display.Stage;
import pixi.core.Pixi;
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
	public var sigResized:Signal2<Float, Float>;
	public var sigTick:Signal1<Float>;
	
	/**
	 * Application properties.
	 */
	public var properties:IApplicationProperties;
	
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
		
		
	}
	
	
	
	// API
	//============================================================================================================
	
	public function initialize(properties:IApplicationProperties, ?backgroundColor:Int=0x000000):Void
	{
		// Application properties
		this.properties = properties;
		
		// Background color
		this.backgroundColor = backgroundColor;
		
		// TODO: Set pixelratio, retina prefix, etc.
		this.pixelRatio = properties.bucketScale;
		
		Settings.RETINA_PREFIX = untyped __js__("/scale-(.+)/");
		
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
	
	/**
	 * event: Window resized.
	 * @param	event
	 */
	override function _onWindowResize(event:Event) 
	{
		if(_applicationView != null && properties != null)
		{
			//_applicationView.x = Math.ffloor(_applicationView.x);
			//_applicationView.y = Math.ffloor(_applicationView.y);
			_applicationView.x = Math.ffloor((Browser.window.innerWidth - properties.bucketWidth) / 2);
			_applicationView.y = Math.ffloor((Browser.window.innerHeight - properties.bucketHeight) / 2);
		}
		
		super._onWindowResize(event);
		
		// Dispatch application signals
		sigResized.dispatch(Browser.window.innerWidth, Browser.window.innerHeight);
	}
	
	/**
	 * event: Animation frame requested.
	 * @param	elapsedTime
	 */
	override function _onRequestAnimationFrame(elapsedTime:Float) 
	{
		frameTime = elapsedTime - _previousTime;
		
		_previousTime = elapsedTime;
		
		sigTick.dispatch(frameTime);
		
		super._onRequestAnimationFrame(elapsedTime);
	}
}