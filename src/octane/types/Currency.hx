package octane.types;

/**
 * ...
 * @author Dylan Heyes
 */
abstract Currency(String)
{
	static public var prefix:String = "$";
	
	/**
	 * Constructor.
	 * @param	value
	 */
	inline public function new(str:String) 
	{
		this = str;
	}
	
	@:from
	static public function fromString(str:String)
	{
		return new Currency(str);
	}
	
	@:from
	static public function fromInt(int:Int)
	{
		return new Currency(Std.string(int));
	}
	
	@:to
	public function toFormattedString():String
	{
		return Currency.prefix + this;
	}
	
	@:to
	public function toInt():Int
	{
		return Std.parseInt(this);
	}
	
	@:to
	public function toFloat():Float
	{
		return Std.parseFloat(this);
	}
}