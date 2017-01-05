package util;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.util.ArrayUtil;


class ArrayUtilTest 
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
	public function testSortAlphabetically():Void
	{
		var array:Array<String> = ["c", "y", "c", "x", "a", "zzzz", "bbb", "d"];
		
		ArrayUtil.sortAlphabetically(array);
		
		Assert.areEqual(array[0], "a");
		Assert.areEqual(array[1], "bbb");
		Assert.areEqual(array[2], "c");
		Assert.areEqual(array[3], "c");
		Assert.areEqual(array[4], "d");
		Assert.areEqual(array[5], "x");
		Assert.areEqual(array[6], "y");
		Assert.areEqual(array[7], "zzzz");
	}
}