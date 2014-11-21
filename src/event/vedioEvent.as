package event
{
	public class vedioEvent extends AppEvent
	{
		public static const OPEN_VEDIO:String = "vedioEvent::open_vedio";
		public static const CLOSE_VEDIO:String = "vedioEvent::close_vedio";
		
		public function vedioEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, param, bubbles, cancelable);
		}
	}
}