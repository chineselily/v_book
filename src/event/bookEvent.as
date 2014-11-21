package event
{
	public class bookEvent extends AppEvent
	{
		public static const OPEN_BOOK:String="bookEvent::open_book";
		public static const CLOSE_BOOK:String = "bookEvent::close_book";
		
		public function bookEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, param, bubbles, cancelable);
		}
	}
}