package event
{
	public class LoadingEvent extends AppEvent
	{
		/**
		 *打开窗口 
		 */		
		public static const OPEN:String="LoadingEvent_OPEN";
		/**
		 *更新加载进度 
		 */		
		public static const UPDATE:String="LoadingEvent_UPDATE";
		/**
		 *关闭窗口 
		 */		
		public static const CLOSE:String="LoadingEvent_CLOSE";
		
		public function LoadingEvent(type:String, param:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, param, bubbles, cancelable);
		}
	}
}