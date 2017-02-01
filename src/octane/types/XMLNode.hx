package octane.types;

/**
 * @author Dylan Heyes
 */
typedef XMLNode =
{
	public var nodeName:String;
	@:optional public var attributes:Dynamic;
	@:optional public var text:String;
	@:optional public var childNodes:Array<XMLMap>;
}