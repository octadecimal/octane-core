package util;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.display.Container;
import octane.util.StringUtil;


class StringUtilTest 
{
	
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	@Test
	public function testGetFullClassName():Void
	{
		var container:Container = new Container();
		Assert.areEqual("octane.display.Container", StringUtil.getFullClassName(container));
		
		var string:String = "";
		Assert.areEqual("String", StringUtil.getFullClassName(string));
	}
	
	@Test
	public function testGetClassName():Void
	{
		var container:Container = new Container();
		Assert.areEqual("Container", StringUtil.getClassName(container));
		
		var string:String = "";
		Assert.areEqual("String", StringUtil.getClassName(string));
	}
	
	@Test
	public function testPrefix():Void
	{
		var string:String = "Test";
		Assert.areEqual("   Test", StringUtil.prefix(string, 7, " "));
		Assert.areEqual("----Test", StringUtil.prefix(string, 8, "-"));
	}
	
	@Test
	public function testSuffix():Void
	{
		var string:String = "Test";
		Assert.areEqual("Test   ", StringUtil.suffix(string, 7, " "));
		Assert.areEqual("Test----", StringUtil.suffix(string, 8, "-"));
	}
	
}