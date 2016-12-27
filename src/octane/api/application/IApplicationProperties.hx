package octane.api.application;

/**
 * ...
 */
interface IApplicationProperties 
{
	var bucketPath:String = "";
	
	var bucketWidth:Float = 0;
	var bucketHeight:Float = 0;
	
	var isMobile:Bool = false;
	var isPhone:Bool = false;
	var isTablet:Bool = false;
	
	var bucketScale:Float;
}