package mediator
{
	import appconfig.app.ProjectLayer;
	
	import event.AppEvent;
	import event.LoadingEvent;
	
	import popwindowmanager.PopWindowConst;
	
	import view.ViewConst;
	import view.winLoading;

	public class LoadingMediator extends PopupMediator
	{
		private var _loading:winLoading;
		public function LoadingMediator()
		{
			super();
		}
		/**
		 * 事件处理函数 
		 * @param evt
		 */		
		override protected function handler(evt:AppEvent):void
		{
			switch(evt.type)
			{
				case LoadingEvent.OPEN:
					_loading = _popupManager.Open(ViewConst.Loading,evt.params) as winLoading;
					break;
				case LoadingEvent.UPDATE:
					if(_loading)
						_loading.update(evt.params[0],evt.params[1]);
					break;
			}
		}
		/**
		 * 将Mediator关联监听的Events
		 */		
		override protected function attachEvents():void
		{
			_arrAttachEvent = [LoadingEvent];
		}
		
		override protected function attachPopWindows():void
		{
			_popupManager.registPop(ViewConst.Loading,winLoading,ProjectLayer.LAYER_LOADING,
				                    PopWindowConst.POP_NOTSAMEWIN,PopWindowConst.ANI_TYPE_CENTER);
		}
	}
}