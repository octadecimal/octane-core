package octane.dom;

import octane.api.display.ISkin;
import octane.debug.Debug;
import octane.display.Button;
import octane.display.Container;
import octane.display.DisplayObject;
import octane.display.Sprite;
import octane.display.TextField;
import octane.display.TextField.TextStyle;
import octane.display.ViewComponent;
import octane.game.view.GameSkin;
import octane.geom.Rectangle;
import octane.types.DynamicExt;
import octane.types.NativeTypes;

/**
 * ...
 */
class DOMBuilder
{
	@inject('GameSkin')
	public var skin:ISkin;
	
	private static inline var SCENE:String = "scene";
	private static inline var CONTAINER:String = "container";
	private static inline var SPRITE:String = "sprite";
	private static inline var TEXTFIELD:String = "textfield";
	private static inline var REGION:String = "region";
	private static inline var BUTTON:String = "button";
	
	private var _scenes:Map<String, DOMElement>;
	private var _prototypes:Map<String, DOMElement>;
	private var _definitions:Map<String, String>;
	private var _textureList:Map<String, NativeTexture>;
	private var _scale:Float;
	private var _regions:Map<String, Rectangle>;
	private var _elements:Map<String, DisplayObject>;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		_regions = new Map<String, Rectangle>();
		_elements = new Map<String, DisplayObject>();
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		// TODO
	}
	
	
	
	// API
	//==================================================================================================================
	
	/**
	 * Sets up the the dom builder.
	 * @param	definitions
	 * @param	textureList
	 * @param	scale
	 */
	public function setup(definitions:Map<String, String>, textureList:Map<String, NativeTexture>, ?scale:Float = 1):Void
	{
		_definitions = definitions;
		_textureList = textureList;
		_scale = scale;
	}
	
	/**
	 * Parses the passed dom xml. Will only create DOMElement objects for each element,
	 * but not create the element. Elements will be created when a scene is built.
	 * @param	dom
	 */
	public function parseDom(dom:Xml):Void
	{
		_scenes = new Map<String, DOMElement>();
		_prototypes = new Map<String, DOMElement>();
		
		// Loop through root elements
		for(rootElement in dom.firstElement().elements())
		{
			// Handle scenes
			if (rootElement.nodeName == "scenes")
			{
				for (scene in rootElement.elements())
				{
					// Get scene id
					var sceneID:String = scene.get("name");
					
					// Ensure scene has id
					if(sceneID == null)
					{
						throw "Found scene without a name: " + scene.toString();
					}
					
					// Parse scene
					_scenes.set(sceneID, parseNode(scene));
				}
			}
			
			// Handle prototypes
			if (rootElement.nodeName == "prototypes")
			{
				for (prototype in rootElement.elements())
				{
					// Get scene id
					var prototypeID:String = prototype.get("name");
					
					// Ensure scene has id
					if(prototypeID == null)
					{
						throw "Found prototype without a name: " + prototype.toString();
					}
					
					// Parse scene
					_prototypes.set(prototypeID, parseNode(prototype, true));
				}
			}
		}
		
		Debug.info(this, "DOM parsed.");
	}
	
	/**
	 * Builds a scene and all of its nested child elements.
	 * @param	sceneName
	 * @param	targetParent
	 * @return
	 */
	public function buildScene(sceneName:String, targetParent:ViewComponent):ViewComponent
	{
		if(!_scenes.exists(sceneName))
		{
			throw "Scene not found: " + sceneName;
		}
		
		var scene:ViewComponent = cast buildElement(_scenes.get(sceneName), targetParent);
		
		return scene;
	}
	
	/**
	 * Retrieves an element by id.
	 * @param	id
	 * @return
	 */
	public function getElementById(id:String):DisplayObject
	{
		if (_elements.exists(id))
		{
			return _elements.get(id);
		}
		else
		{
			throw "Element doesn't exist: " + id;
		}
	}
	
	/**
	 * Retrieves a region by id.
	 * @param	name
	 * @return
	 */
	public function getRegion(name:String):Rectangle
	{
		if (_regions.exists(name))
		{
			return _regions.get(name);
		}
		else
		{
			Debug.warn(this, "Region not found: " + name);
			return null;
		}
	}
	
	/**
	 * Creates an element by prototype.
	 * @param	name
	 * @return
	 */
	public function createFromPrototype(name:String):DisplayObject
	{
		if (_prototypes.exists(name))
		{
			return buildElement(_prototypes.get(name));
		}
		else
		{
			Debug.error(this, "Prototype not found: " + name);
			return null;
		}
	}
	
	
	
	// PRIVATE
	//==================================================================================================================
	
	private function parseNode(node:Xml, ?isPrototype:Bool = false):DOMElement
	{
		var domElementChildren:Array<DOMElement> = new Array<DOMElement>();
		
		for(child in node.elements())
		{
			domElementChildren.push(parseNode(child));
		}
		
		var element:DOMElement = {
			type: node.nodeName,
			name: node.get("name"),
			isPrototype: isPrototype,
			definition: node.get("definition"),
			children: domElementChildren,
			x: Std.parseFloat(node.get("x")),
			y: Std.parseFloat(node.get("y")),
			width: Std.parseFloat(node.get("width")),
			height: Std.parseFloat(node.get("height")),
			scaleX: Std.parseFloat(node.get("scaleX")),
			scaleY: Std.parseFloat(node.get("scaleY")),
			rotation: Std.parseFloat(node.get("rotation")),
			font: node.get("font"),
			fill: node.get("fill"),
			text: node.get("text"),
			up: node.get("up"),
			down: node.get("down"),
			off: node.get("off"),
			region: node.get("region")
		}
		
		return element;
	}

	private function buildElement(element:DOMElement, ?parent:Container = null):Dynamic
	{
		Debug.data(this, "Building element: " + element.name);
		
		var output:Dynamic = null;
		
		switch(element.type)
		{
			case REGION:
				output = buildRegion(element, parent);
			default:
				output = buildDisplayObject(element, parent);
		}
		
		return output;
	}
	
	private function buildDisplayObject(element:DOMElement, ?parent:Container = null):DisplayObject
	{
		var displayObject:DisplayObject = null;	
		var args:Array<Dynamic> = [];
		
		// Get element definition
		var elementDefinitionName:String = _definitions.get(element.definition);
		
		// Build type-specific arguments
		switch(element.type)
		{
			case SPRITE:
				args.push(getTexture(element.name));
			case TEXTFIELD:
				args.push("");
				args.push(getTextStyleFromElement(element));
			case BUTTON:
				args.push(getTexture(element.up));
				args.push(getTexture(element.down));
				args.push(getTexture(element.off));
				if (element.region != null) args.push(createFromPrototype(element.region));
		}
		
		// Create display object from custom definition, otherwise use element type
		if(elementDefinitionName != null)
		{
			// Get custom definition
			var definition:Class<Dynamic> = Type.resolveClass(elementDefinitionName);
			
			// Ensure declared definition exists
			if(definition == null)
			{
				throw "Could not create class from definition for element: "+element.name+" => "+elementDefinitionName+". \n - Does the class exist and have the correct namespace?\n - Does the class inherit from a correct display type?\n - Does the class need a @:keep macro?";
			}
			
			// Create display object from custom definition
			displayObject = Type.createInstance(definition, args);
		}
		else
		{
			// No custom definition defined, build from generic display objects
			switch(element.type)
			{
				case SCENE:
					displayObject = new Container();
				case CONTAINER:
					displayObject = new Container();
				case SPRITE:
					displayObject = new Sprite(args[0]);
				case TEXTFIELD:
					displayObject = new TextField(args[0], args[1]);
				case BUTTON:
					displayObject = new Button(args[0], args[1], args[2], args[3]);
				default:
					throw "Type not found: `" + element.type + "`` for element: " + element.name;
			}
		}
		
		// Set defined properties
		displayObject.name  = element.name;
		displayObject.gameSkin = skin;
		if (isDefined(element.x))         displayObject.x         = element.x * _scale;
		if (isDefined(element.y))         displayObject.y         = element.y * _scale;
		if (isDefined(element.width))     displayObject.width     = element.width * _scale;
		if (isDefined(element.height))    displayObject.height    = element.height * _scale;
		if (isDefined(element.pivotX))    displayObject.pivotX    = element.pivotX * _scale;
		if (isDefined(element.pivotY))    displayObject.pivotY    = element.pivotY * _scale;
		if (isDefined(element.scaleX))    displayObject.scaleX    = element.scaleX;
		if (isDefined(element.scaleY))    displayObject.scaleY    = element.scaleY;
		if (isDefined(element.rotation))  displayObject.rotation  = element.rotation;
		if (isDefined(element.alpha))     displayObject.alpha     = element.alpha;
		
		// Add to parent
		if(parent != null)
		{
			parent.addChild(displayObject);
		}
		
		// Build children
		for(child in element.children)
		{
			buildElement(child, cast(displayObject, Container));
		}
		
		// Call build() on displayObject if view component
		if (Std.is(displayObject, ViewComponent))
		{
			cast(displayObject, ViewComponent).build();
			cast(displayObject, ViewComponent).setInitialState();
		}
		
		// TODO
		// Save element (like below), but create an additional map that stores
		// instances of multiple elements with the same name and expose
		// a method like getElementsById()
		
		// Save element (but ignore prototypes)
		if (!element.isPrototype)
		{
			_elements.set(element.name, displayObject);
		}
		
		// Return created display object element
		return displayObject;
	}
	
	private function buildRegion(element:DOMElement, parent:DisplayObject):Rectangle
	{
		var region:Rectangle = new Rectangle();
		
		// Set defined properties
		if (isDefined(element.x))         region.x         = element.x * _scale;
		if (isDefined(element.y))         region.y         = element.y * _scale;
		if (isDefined(element.width))     region.width     = element.width * _scale;
		if (isDefined(element.height))    region.height    = element.height * _scale;
		
		// Add to parent view component
		if (Std.is(parent, ViewComponent))
		{
			cast(parent, ViewComponent).addRegion(element.name, region);
		}
		
		// Save in region table
		//if (_regions.exists(element.name))
		//{
			//throw "Region already defined, names must be unique for rects: " + element.name;
		//}
		//else
		//{
			_regions.set(element.name, region);
		//}
		
		return region;
	}
	
	private function getTexture(name:String):NativeTexture
	{
		if (_textureList.exists(name))
		{
			return _textureList.get(name);
		}
		else
		{
			Debug.error(this, "Texture not found: " + name + "\n - Is the spelling correct? \n - Has the context this texture belongs to been loaded yet?");
			return null;
		}
	}

	private function getTextStyleFromElement(element:DOMElement):TextStyle
	{
		var textStyle:TextStyle = {};
		
		// TODO
		//textStyle.font = element.font;
		//textStyle.fill = element.fill;
		
		return textStyle;
	}
	
	private function isDefined(property:Dynamic):Bool
	{
		return !Math.isNaN(property);
	}
}