package octane.display;

import octane.types.NativeTypes.NativeStage;

/**
 * ...
 */
class Stage extends ViewComponent
{
	public var nativeStage(get, null):NativeStage;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
	}
	
	/**
	 * Destructor.
	 */
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	
	
	// ACCESSORS
	// =========================================================================================

	private function get_nativeStage():NativeStage
	{
		return _native_Container;
	}
}