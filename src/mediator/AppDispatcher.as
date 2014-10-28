package mediator
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class AppDispatcher extends EventDispatcher
	{
		private static var _instance:AppDispatcher;
		public function AppDispatcher(_interal:AppDispatcherInteral,target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function get Instance():AppDispatcher
		{
			if(_instance==null) _instance = new AppDispatcher(new AppDispatcherInteral());
			return _instance;
		}
	}
}
class AppDispatcherInteral{}