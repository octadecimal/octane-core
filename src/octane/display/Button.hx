package octane.display;

import octane.geom.Rectangle;
import octane.types.NativeTypes.NativeTexture;
import octane.util.DisplayUtil;


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
	
	// Textfield label region
	private var _labelRegion:Rectangle;
	
	
	/**
	 * Constructor.
	 */
	public function new(textureUp:NativeTexture, textureDown:NativeTexture, textureOff:NativeTexture, ?labelRegion:Rectangle) 
	{
		super();
		
		// Save textures
		_textureUp = textureUp;
		_textureDown = textureDown;
		_textureOff = textureOff;
		if (_textureOff == null) _textureOff = _textureUp;
		if (_textureDown == null) _textureDown = _textureUp;
		
		// Label region
		_labelRegion = labelRegion != null ? labelRegion : new Rectangle(0, 0, _textureUp.width, _textureUp.height);
		
		// Create button sprite
		_sprite = new Sprite(textureUp);
		addChild(_sprite);
		
		// Mouse events
		sigMouseDown.add(onSigMouseDown);
		sigClicked.add(onSigMouseUp);
		sigMouseOver.add(onSigMouseOver);
		sigMouseOut.add(onSigMouseOut);
		
		// Initially enable
		enable();
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		if (_textureUp != null) _textureUp.destroy();
		if (_textureDown != null) _textureDown.destroy();
		if (_textureOver != null) _textureOver.destroy();
		if (_textureOff != null) _textureOff.destroy();
		if (_sprite != null) _sprite.removeFromParent(true);
		if (_label != null) _label.removeFromParent(true);
		if (_labelRegion != null) _labelRegion.destroy();
		
		_textureUp = null;
		_textureDown = null;
		_textureOver = null;
		_textureOff = null;
		_sprite = null;
		_label = null;
		_labelRegion = null;
		
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
		else
		{
			_label.text = text;
		}
		
		DisplayUtil.fitTextFieldToRegion(_label, _labelRegion);
	}
	
	
	
	// HANDLERS
	//============================================================================================================
	
	private function onSigMouseUp(displayObject:DisplayObject):Void
	{
		_isPressed = false;
		_label.pivotY = 0;
		
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
			_label.pivotY = -1;
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
		_label.pivotY = 0;
		_sprite.texture = _textureUp;
	}
}