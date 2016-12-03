package loading;

import haxe.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.api.loading.ILoader;
import octane.loading.StringLoader;

/**
 * ...
 * @author Dylan Heyes
 */
class StringLoaderTest 
{
	public function new() 
	{
		
	}
	
	@AsyncTest
	public function testStringLoader(factory:AsyncFactory):Void
	{
		var handler:Dynamic = factory.createHandler(this, onStringLoaderSuccess, 2500);
		
		var stringLoader:StringLoader = new StringLoader();
		stringLoader.sigSuccess.addOnce(handler);
		stringLoader.sigError.addOnce(onStringLoaderError);
		stringLoader.load("validTextFile", "ValidTextFile.txt");
	}
	
	private function onStringLoaderError(loader:ILoader, error:String):Void
	{
		Assert.fail("String loader failed: " + loader.id + " -> "+error);
	}
	
	private function onStringLoaderSuccess(loader:ILoader, data:String):Void
	{
		Assert.areEqual(data, "Valid text file!");
	}
}