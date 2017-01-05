package display ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import octane.display.Container;
import octane.display.DisplayObject;


class DisplayObjectTest 
{
	private var _displayObject:DisplayObject;
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
		_displayObject = new Container();
	}
	
	@AfterClass
	public function afterClass():Void
	{
		_displayObject.removeFromParent(true);
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
	public function testProperties():Void
	{
		_displayObject.x = 100;
		Assert.areEqual(100, _displayObject.x);
		
		_displayObject.y = 50.5;
		Assert.areEqual(50.5, _displayObject.y);
		
		_displayObject.pivotX = 0.5;
		Assert.areEqual(0.5, _displayObject.pivotX);
		
		_displayObject.pivotY = 12345;
		Assert.areEqual(12345, _displayObject.pivotY);
		
		_displayObject.scaleX = 0.5;
		Assert.areEqual(0.5, _displayObject.scaleX);
		
		_displayObject.scaleY = -2.75;
		Assert.areEqual(-2.75, _displayObject.scaleY);
		
		_displayObject.width = 0;
		Assert.areEqual(0, _displayObject.width);
		
		_displayObject.height = 0;
		Assert.areEqual(0, _displayObject.height);
		
		_displayObject.alpha = 0.335;
		Assert.areEqual(0.335, _displayObject.alpha);
		
		_displayObject.rotation = Math.PI / 2;
		Assert.areEqual(Math.PI / 2, _displayObject.rotation);
		
		_displayObject.visible = false;
		Assert.isFalse(_displayObject.visible);
		
		_displayObject.visible = true;
		Assert.isTrue(_displayObject.visible);
		
		_displayObject.cacheAsBitmap = false;
		Assert.isFalse(_displayObject.cacheAsBitmap);
		
		_displayObject.cacheAsBitmap = true;
		Assert.isTrue(_displayObject.cacheAsBitmap);
		
		_displayObject.interactive = true;
		Assert.isTrue(_displayObject.interactive);
		
		_displayObject.interactive = false;
		Assert.isFalse(_displayObject.interactive);
		
		_displayObject.mask = new Container();
		Assert.isNotNull(_displayObject.mask);
		Assert.isType(_displayObject.mask, Container);
		
		_displayObject.mask = null;
		Assert.isNull(_displayObject.mask);
	}
	
	@Test
	private function testParenting():Void
	{
		_displayObject.removeFromParent(false);
		
		var container:Container = new Container();
		container.addChild(_displayObject);
		
		Assert.isNotNull(_displayObject.parent);
		Assert.areEqual(_displayObject.parent, container);
		
		_displayObject.removeFromParent(false);
		
		Assert.isNull(_displayObject.parent);
	}
}