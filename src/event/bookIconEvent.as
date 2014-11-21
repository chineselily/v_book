package event
{
	public class bookIconEvent extends AppEvent
	{
		public static const OPEN:String = "bookIconEvent::open";
		public static const CLOSE:String = "bookIconEvent::close";
		public static const OPEN_BOOK:String = "bookIconEvent::open_book";
		public function bookIconEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, param, bubbles, cancelable);
		}
	}
}