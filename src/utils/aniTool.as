package utils
{
	import com.greensock.TweenLite;

	public class aniTool
	{
		public function aniTool()
		{
		}
		
		public static function to(target:Object, duration:Number, vars:Object):void
		{
			TweenLite.to(target, duration, vars);
		}
	}
}

class aniManagerInteral{}