package mediator
{
	import appconfig.app.ProjectLayer;
	
	import event.AppEvent;
	import event.vedioEvent;
	
	import popwindowmanager.PopWindowConst;
	
	import view.ViewConst;
	import view.winVedio;

	public class vedioMediator extends PopupMediator
	{
		private var _vedio:winVedio;
		public function vedioMediator()
		{
			super();
		}
		
		override protected function attachEvents():void
		{
			_arrAttachEvent = [vedioEvent];
		}
		
		override protected function attachPopWindows():void
		{
			_popupManager.registPop(ViewConst.Vedio,winVedio,ProjectLayer.LAYER_VEDIO,
				                    PopWindowConst.POP_NOTSAMEWIN,PopWindowConst.ANI_TYPE_NONE);
		}
		
		override protected function handler(evt:AppEvent):void
		{
			switch(evt.type)
			{
				case vedioEvent.OPEN_VEDIO:
					_vedio = _popupManager.Open(ViewConst.Vedio,evt.params) as winVedio;
					break;
				case vedioEvent.CLOSE_VEDIO:
					_popupManager.Close(ViewConst.Vedio);
					break;
			}
		}
	}
}