package mediator
{
	import event.AppEvent;
	
	import popwindowmanager.PopWindowManager;

	public class PopupMediator extends BaseMediator
	{
		protected var _popupManager:PopWindowManager;
		
		public function PopupMediator()
		{
			_popupManager = PopWindowManager.Instance();
			super();
			attachPopWindows();
		}
		
		/**
		 * 以下两个函数在子类中需要重写
		 */
		
		/**
		 * 事件处理函数 
		 * @param evt
		 */		
		override protected function handler(evt:AppEvent):void
		{
			
		}
		/**
		 * 将Mediator关联监听的Events
		 */		
		override protected function attachEvents():void
		{
			//_arrAttachEvent = [AppEvent];
		}
		/**
		 * 向popupmanager注册窗口 
		 */		
		protected function attachPopWindows():void
		{

		}
	}
}