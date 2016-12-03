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
		var handler:Dynamic = factory.createHandler(this, onLoaderQueueComplete, 1500);
		
		var loaderQueue:PixiLoaderQueue = new PixiLoaderQueue();
		loaderQueue.addImage("image_01", "image_01.png");
		loaderQueue.addImage("image_02", "image_02.png");
		loaderQueue.addXml("xml_01", "ValidXML.xml");
		
		loaderQueue.sigXmlLoaded.add(onXmlLoaded);
		loaderQueue.sigTextureLoaded.add(onSigTextureLoaded);
		loaderQueue.sigComplete.addOnce(handler);
		
		loaderQueue.startLoading();
	}
	
	private function onXmlLoaded(id:String, xml:Xml) 
	{
		trace("Loaded xml: " + id);
		
		Assert.isType(xml, Xml);
		Assert.areNotEqual(id, "xml_01");
	}
	
	private function onSigTextureLoaded(id:String, texture:NativeTexture) 
	{
		trace("Loaded texture: " + id);
		
		Assert.isType(texture, NativeTexture);
		Assert.isTrue(id == "image_01" || id == "image_02");
	}
	
	private function onLoaderQueueComplete():Void
	{
		
	}
}