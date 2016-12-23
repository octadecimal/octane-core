package octane.display;
import octane.types.NativeTypes.NativeTexture;


/**
 * ...
 */
class Button extends Container
{
	/**
	 * Optional behavior that may be associated with this button.
	 */
	public var behavior:String;
	
	// Up texture
	private var _textureUp:NativeTexture;
	
	// Down texture
	private var _textureDown:NativeTexture;
	
	// Down texture
	private var _textureOver:NativeTexture;
	
	// Off texture
	private var _textureOff:NativeTexture;
	
	// Pressed state
	private var _isPressed:Bool = false;
	
	// Button sprite
	private var _sprite:Sprite;
	
	// Textfield label
	private var _label:TextField;
	
	
	/**
	 * Constructor.
	 */
	public function new(textureUp:NativeTexture, textureDown:NativeTexture, textureOff:NativeTexture) 
	{
		super();
		
		_textureUp = textureUp;
		_textureDown = textureDown;
		_textureOff = textureOff;
		
		if (_textureOff == null) _textureOff = _textureUp;
		if (_textureDown == null) _textureDown = _textureUp;
		
		_sprite = new Sprite(textureUp);
		addChild(_sprite);
		
		sigMouseDown.add(onSigMouseDown);
		sigClicked.add(onSigMouseUp);
		sigMouseOver.add(onSigMouseOver);
		sigMouseOut.add(onSigMouseOut);
		
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
		
		_sprite.texture = _textureUp;
	}
	
	public function disable():Void
	{
		interactive = false;
		
		_sprite.texture = _textureOff;
	}
	
	public function setText(text:String):Void
	{
		if (_label == null)
		{
			_label = new TextField(text, { fontSize: "9pt" });
			addChild(_label);
		}
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onSigMouseUp(displayObject:DisplayObject):Void
	{
		_isPressed = false;
		_label.y = 0;
		
		if (interactive)
		{
			_sprite.texture = _textureUp;
		}
		else
		{
			_sprite.texture = _textureOff;
		}
	}
	
	private function onSigMouseDown(displayObject:DisplayObject):Void
	{
		if (interactive)
		{
			_isPressed = true;
			_label.y = 1;
			_sprite.texture = _textureDown;
		}
		else
		{
			_sprite.texture = _textureOff;
		}
	}
	
	private function onSigMouseOver(displayObject:DisplayObject):Void
	{
		if (_isPressed)
		{
			_sprite.texture = _textureDown;
		}
		else
		{
			_sprite.texture = _textureUp;
		}
	}
	
	private function onSigMouseOut(displayObject:DisplayObject):Void
	{
		_isPressed = false;
		_label.y = 0;
		_sprite.texture = _textureUp;
	}
}