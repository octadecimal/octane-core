package octane.display;
import octane.types.NativeTypes.NativeTexture;


/**
 * ...
 */
class Button extends Sprite
{
	private var _textureUp:NativeTexture;
	private var _textureDown:NativeTexture;
	private var _textureOff:NativeTexture;
	
	/**
	 * Constructor.
	 */
	public function new(textureUp:NativeTexture, textureDown:NativeTexture, textureOff:NativeTexture) 
	{
		_textureUp = textureUp;
		_textureDown = textureDown;
		_textureOff = textureOff;
		
		super(textureUp);
		
		sigMouseDown.add(onSigMouseDown);
		sigClicked.add(onSigMouseUp);
		
		enable();
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
	
	public function enable():Void
	{
		interactive = true;
		
		texture = _textureUp;
	}
	
	public function disable():Void
	{
		interactive = false;
		
		texture = _textureOff;
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onSigMouseUp(displayObject:DisplayObject):Void
	{
		if (interactive)
		{
			texture = _textureUp;
		}
		else
		{
			texture = _textureOff;
		}
	}
	
	private function onSigMouseDown(displayObject:DisplayObject):Void
	{
		if (interactive)
		{
			texture = _textureDown;
		}
		else
		{
			texture = _textureOff;
		}
	}
}