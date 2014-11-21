package mediator
{
	import appconfig.app.ProjectLayer;
	import appconfig.book.bookConfigCache;
	
	import event.AppEvent;
	import event.ToolEvent;
	import event.bookEvent;
	import event.bookIconEvent;
	
	import popwindowmanager.PopWindowConst;
	
	import view.ViewConst;
	import view.winBookIcon;

	public class bookIconMediator extends PopupMediator
	{
		private var _bookIcon:winBookIcon;
		
		private var _arrBook:Array;
		public function bookIconMediator()
		{
			super();
		}
		
		override protected function attachEvents():void
		{
			_arrAttachEvent = [bookIconEvent, ToolEvent];
		}
		
		override protected function attachPopWindows():void
		{
			_popupManager.registPop(ViewConst.Book_Icon, winBookIcon, ProjectLayer.LAYER_BOOKICON,
				                    PopWindowConst.POP_NOTSAMEWIN, PopWindowConst.ANI_TYPE_CENTER);
		}
		
		override protected function handler(evt:AppEvent):void
		{
			switch(evt.type)
			{
				case bookIconEvent.OPEN:
					if(evt.params!=null) _arrBook = evt.params;
					
					_bookIcon = _popupManager.Open(ViewConst.Book_Icon,_arrBook) as winBookIcon;			
					break;
				case bookIconEvent.CLOSE:
					_popupManager.Close(ViewConst.Book_Icon);
					break;
				case bookIconEvent.OPEN_BOOK:
					//_popupManager.Close(ViewConst.Book_Icon);
					dispatchEvent(new bookEvent(bookEvent.OPEN_BOOK,evt.params));
					break;
				case ToolEvent.NEXT_PAGE:
					if(_bookIcon && _bookIcon.visible)
					{
						_bookIcon.updatePage(false);
					}
					break;
				case ToolEvent.PREV_PAGE:
					if(_bookIcon && _bookIcon.visible)
					{
						_bookIcon.updatePage(true);	
					}
					break;
			}
		}
	}
}