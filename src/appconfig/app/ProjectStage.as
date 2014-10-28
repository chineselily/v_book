package appconfig.app
{
	public class ProjectStage
	{
		public static const WIDTH:Number=800;
		public static const HEIGHT:Number=600;
		
		private static var _x:Number=0;
		private static var _y:Number=0;
		private static var _width:Number=WIDTH;
		private static var _height:Number=HEIGHT;
		
		public function ProjectStage()
		{
		}
		
		public static function onResize(newWidth:Number, newHeight:Number):void
		{
			_width = newWidth;
			_height = newHeight;
			
			_x = (newWidth-WIDTH)/2;
			_y = (newHeight-HEIGHT)/2;
		}
		
		public static function get x():Number
		{
			return _x;
		}
		
		public static function get y():Number
		{
			return _y;
		}
		
		public static function get width():Number
		{
			return _width;
		}
		
		public static function get height():Number
		{
			return _height;
		}
	}
}