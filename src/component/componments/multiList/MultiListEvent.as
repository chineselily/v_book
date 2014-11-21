package component.componments.multiList
{
	import flash.events.Event;
	
	public class MultiListEvent extends Event
	{
		
		static public const SELECTED:String = "MultiListEvent::selected";
		
		private var _params:Object;
		public function MultiListEvent(type:String, params:Object=null)
		{
			super(type);
			_params = params;
		}
		
		public function get params():Object
		{
			return _params;
		}
		
		public override function clone():Event 
		{ 
			return new MultiListEvent(type, _params);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MultiListEvent", type); 
		}
	}
}