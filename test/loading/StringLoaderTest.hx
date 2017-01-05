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
	static private inline var TIMEOUT:Float = 2500;
	
	public function new() 
	{
		
	}
	
	@AsyncTest
	public function testStringLoaderSuccess(factory:AsyncFactory):Void
	{
		function onStringLoaderError(loader:ILoader, error:String):Void
		{
			Assert.fail("String loader failed: " + loader.id + " -> " + error);
			loader.destroy();
		}
		
		function onStringLoaderSuccess(loader:ILoader, data:String):Void
		{
			Assert.areEqual(data, "Valid text file!");
			loader.destroy();
		}
		
		var handler:Dynamic = factory.createHandler(this, onStringLoaderSuccess, TIMEOUT);
		
		var stringLoader:StringLoader = new StringLoader();
		stringLoader.sigSuccess.addOnce(handler);
		stringLoader.sigError.addOnce(onStringLoaderError);
		stringLoader.load("validTextFile", "ValidTextFile.txt");
	}
	
	@AsyncTest
	public function testStringLoaderFail(factory:AsyncFactory):Void
	{
		function onStringLoaderError(loader:ILoader, error:String):Void
		{
			loader.destroy();
		}
		
		function onStringLoaderSuccess(loader:ILoader, data:String):Void
		{
			Assert.fail("String loader should have failed: " + loader.id);
		}
		
		var handler:Dynamic = factory.createHandler(this, onStringLoaderError, TIMEOUT);
		
		var stringLoader:StringLoader = new StringLoader();
		stringLoader.sigSuccess.addOnce(onStringLoaderSuccess);
		stringLoader.sigError.addOnce(handler);
		stringLoader.load("MissingTextFile", "MissingTextFile.txt");
	}
}