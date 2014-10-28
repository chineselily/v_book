package utils
{
	import com.greensock.TweenLite;

	public class aniTool
	{
		private static var _instance:aniTool;
		public function aniTool()
		{
		}
		
		public static function Instance():aniTool
		{
			if(_instance ==  null) _instance = new aniTool(new aniManagerInteral());
			
			return _instance;
		}
		
		public function to(target:Object, duration:Number, vars:Object):void
		{
			TweenLite.to(target, duration, vars);
		}
	}
}

class aniManagerInteral{}