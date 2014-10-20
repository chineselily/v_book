package aniManager
{
	import com.greensock.TweenLite;

	public class aniManager
	{
		private static var _instance:aniManager;
		public function aniManager()
		{
		}
		
		public static function Instance():aniManager
		{
			if(_instance ==  null) _instance = new aniManager(new aniManagerInteral());
			
			return _instance;
		}
		
		public function to(target:Object, duration:Number, vars:Object):void
		{
			TweenLite.to(target, duration, vars);
		}
	}
}

class aniManagerInteral{}