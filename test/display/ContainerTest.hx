package display ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.display.Container;


class ContainerTest 
{
	private var _container:Container;
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
		_container = new Container();
	}
	
	@AfterClass
	public function afterClass():Void
	{
		_container.destroy();
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
	public function testAddChild():Void
	{
		var child:Container = new Container();
		
		_container.addChild(child);
		
		Assert.areEqual(child.parent, _container);
		
		_container.removeChild(child);
	}
	
	@Test
	public function testGetChildByName():Void
	{
		var child:Container = new Container();
		child.name = "testChild";
		
		_container.addChild(child);
		
		Assert.areEqual(child, _container.getChildByName("testChild"));
		
		_container.removeChild(child);
	}
	
	public function testGetChildAt():Void
	{
		var child1:Container = new Container();
		var child2:Container = new Container();
		
		_container.addChild(child1);
		_container.addChild(child2);
		
		Assert.areEqual(child1, _container.getChildAt(0));
		Assert.areEqual(child2, _container.getChildAt(1));
		
		_container.removeChild(child1);
		_container.removeChild(child2);
	}
}