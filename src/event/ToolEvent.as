package event
{
	public class ToolEvent extends AppEvent
	{
		public static const OPEN:String = "ToolEvent_open";
		public static const UPDATE_PAGE:String = "ToolEvent_update_page";
		public static const NEXT_PAGE:String = "ToolEvent_next_page";
		public static const PREV_PAGE:String = "ToolEvent_prev_page";
		
		public function ToolEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, param, bubbles, cancelable);
		}
	}
}