package octane.dom;

typedef DOMElement = 
{
	var name:String;
	var type:String;
	var isPrototype:Bool;
	@:optional var definition:String;
	@:optional var children:Array<DOMElement>;
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var width:Float;
	@:optional var height:Float;
	@:optional var pivotX:Float;
	@:optional var pivotY:Float;
	@:optional var scaleX:Float;
	@:optional var scaleY:Float;
	@:optional var rotation:Float;
	@:optional var alpha:Float;
	@:optional var font:String;
	@:optional var fill:String;
	@:optional var align:String;
	@:optional var text:String;
	@:optional var up:String;
	@:optional var down:String;
	@:optional var off:String;
	@:optional var region:String;
}