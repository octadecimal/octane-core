package loading;

import haxe.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.loading.PixiLoaderQueue;
import octane.types.NativeTypes.NativeTexture;

/**
 * ...
 * @author Dylan Heyes
 */
class PixiLoaderQueueTest 
{
	var _loaderQueue:PixiLoaderQueue;
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
		// This will run once per test class
	}
	
	@AfterClass
	public function afterClass():Void
	{
		// This will run once per test class
		
		_loaderQueue.destroy();
	}
	
	@Before
	public function setup():Void
	{
		// This will run before every test
	}
	
	@After
	public function tearDown():Void
	{
		// This will run after every test
	}
	
	
	@Test
	public function testExample():Void
	{
		Assert.isTrue(true);
	}
	
	@AsyncTest
	public function testLoad2Textures(factory:AsyncFactory):Void
	{
		var handler:Dynamic = factory.createHandler(this, onLoaderQueueComplete, 5000);
		
		_loaderQueue = new PixiLoaderQueue();
		_loaderQueue.startLoading();
		
		_loaderQueue.addImage("image_01.png", "image_01.png");
		_loaderQueue.addImage("image_02.png", "image_02.png");
		_loaderQueue.addXml("ValidXML.xml", "ValidXML.xml");
		_loaderQueue.addString("Phoenix_0.json", "Phoenix_0.json");
		_loaderQueue.addString("ValidTextFile.txt", "ValidTextFile.txt");
		_loaderQueue.addString("ValidJSON.json", "ValidJSON.json");
		
		_loaderQueue.sigXmlLoaded.add(onXmlLoaded);
		_loaderQueue.sigTextureLoaded.add(onSigTextureLoaded);
		_loaderQueue.sigSubtextureLoaded.add(onSigSubtextureLoaded);
		_loaderQueue.sigComplete.addOnce(handler);
		
		_loaderQueue.startLoading();
	}
	
	private function onXmlLoaded(id:String, xml:Xml) 
	{
		Assert.isType(xml, Xml);
		Assert.areEqual(id, "ValidXML.xml");
	}
	
	private function onSigTextureLoaded(id:String, texture:NativeTexture) 
	{
		Assert.isNotNull(texture);
		Assert.isType(texture, NativeTexture);
		Assert.isTrue(id == "image_01.png" || id == "image_02.png");
	}
	
	private function onSigSubtextureLoaded(id:String, texture:NativeTexture) 
	{
		Assert.isNotNull(texture);
		Assert.isType(texture, NativeTexture);
		Assert.isTrue(id.indexOf("Phoenix1_") > -1);
	}
	
	private function onLoaderQueueComplete():Void
	{
		
	}
}