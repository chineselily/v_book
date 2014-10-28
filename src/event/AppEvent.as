package event
{
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import avmplus.getQualifiedClassName;
	
	public class AppEvent extends Event
	{
		protected var _params:Array;
		public function AppEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_params = param;
		}
		
		public function get params():Array
		{
			return _params;
		}
		
		override public function clone():Event
		{
			var classRef:Class = getDefinitionByName(flash.utils.getQualifiedClassName(this)) as Class;
			return new classRef(type);
		}
	}
}