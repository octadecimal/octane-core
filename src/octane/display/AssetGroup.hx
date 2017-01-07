package octane.display;
import octane.api.display.IAnimation;
import octane.debug.Debug;

/**
 * ...
 */
class AssetGroup extends Container
{
	private var _sprites:Map<String, Sprite>;
	private var _animations:Map<String, IAnimation>;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		_sprites = new Map<String, Sprite>();
		_animations = new Map<String, IAnimation>();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	
	
	// API
	//============================================================================================================
	
	public function setInitialState():Void
	{
		hideAllAssets();
		showSprite("static");
	}
	
	public function addSprite(name:String, sprite:Sprite, ?params:AssetParameters):Void
	{
		_sprites.set(name, sprite);
		
		applyParams(sprite, params);
		
		addChild(sprite);
	}
	
	public function addAnimation(name:String, animation:IAnimation, ?params:AssetParameters):Void
	{
		_animations.set(name, animation);
		
		applyParams(cast animation, params);
		
		animation.fps = 24;
		animation.play();
		
		addChild(cast animation);
		
		trace(name, animation.x, animation.y, animation.width, animation.height);
	}
	
	public function showSprite(name:String):Void
	{
		trace("Showing sprite: " + name);
		
		if (_sprites.exists(name))
		{
			hideAllAssets();
			
			_sprites.get(name).visible = true;
		}
		else
		{
			Debug.warn(this, "Sprite not found: " + name);
		}
	}
	
	public function playAnimation(name:String, ?loop:Bool = false):Void
	{
		trace("Playing animation: " + name);
		
		if (_animations.exists(name))
		{
			//hideAllAssets();
			
			var animation:IAnimation = _animations.get(name);
			
			//animation.sigAnimationComplete.addOnce(onAnimationComplete);
			
			animation.currentFrame = 0;
			animation.visible = true;
			animation.loop = loop;
			animation.play();
		}
		else
		{
			Debug.warn(this, "Animation not found: " + name);
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onAnimationComplete(object:IAnimation):Void
	{
		setInitialState();
	}
	
	
	
	// PRIVATE
	//============================================================================================================
	
	private function hideAllAssets():Void
	{
		for (sprite in _sprites)
		{
			sprite.visible = false;
		}
		
		for (animation in _animations)
		{
			animation.visible = false;
		}
	}
	
	private function applyParams(object:DisplayObject, ?params:AssetParameters):Void
	{
		if (params != null)
		{
			if (params.center)
			{
				object.pivotX = object.width / 2;
				object.pivotY = object.height / 2;
			}
			
			if (params.resolution != 0)
			{
				object.resolution = params.resolution;
			}
			
			if (params.hideOthers)
			{
				hideAllAssets();
			}
		}
		else
		{
			object.pivotX = object.width / 2;
			object.pivotY = object.height / 2;
			
			hideAllAssets();
		}
	}
}