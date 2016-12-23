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
	
	public function addSprite(name:String, sprite:Sprite):Void
	{
		_sprites.set(name, sprite);
		
		sprite.pivotX = sprite.width / 2;
		sprite.pivotY = sprite.height / 2;
		
		addChild(sprite);
	}
	
	public function addAnimation(name:String, animation:IAnimation):Void
	{
		_animations.set(name, animation);
		
		animation.pivotX = animation.width / 2;
		animation.pivotY = animation.height / 2;
		
		animation.fps = 24;
		animation.play();
		
		addChild(cast animation);
	}
	
	public function showSprite(name:String):Void
	{
		if (_sprites.exists(name))
		{
			hideAllAssets();
			
			_sprites.get(name).visible = true;
		}
	}
	
	public function playAnimation(name:String, ?loop:Bool = false):Void
	{
		if (_animations.exists(name))
		{
			hideAllAssets();
			
			var animation:IAnimation = _animations.get(name);
			
			animation.sigAnimationComplete.addOnce(onAnimationComplete);
			
			animation.visible = true;
			animation.loop = loop;
			animation.play();
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
}