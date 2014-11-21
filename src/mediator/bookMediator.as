package mediator
{
	import appconfig.app.ProjectLayer;
	
	import event.AppEvent;
	import event.ToolEvent;
	import event.bookEvent;
	import event.bookIconEvent;
	
	import popwindowmanager.PopWindowConst;
	
	import view.ViewConst;
	import view.winBook;

	public class bookMediator extends PopupMediator
	{
		private var _book:winBook;
		public function bookMediator()
		{
			super();
		}
		
		override protected function attachEvents():void
		{
			_arrAttachEvent = [bookEvent, ToolEvent];
		}
		
		override protected function attachPopWindows():void
		{
			_popupManager.registPop(ViewConst.Book,winBook,ProjectLayer.LAYER_BOOK,
				                    PopWindowConst.POP_NOTSAMEWIN,PopWindowConst.ANI_TYPE_CENTER);
		}
		
		override protected function handler(evt:AppEvent):void
		{
			switch(evt.type)
			{
				case bookEvent.OPEN_BOOK:
					_book = _popupManager.Open(ViewConst.Book,evt.params) as winBook;
					break;
				case ToolEvent.NEXT_PAGE:
					if(_book && _book.visible)
						_book.updatePage(false);
					break;
				case ToolEvent.PREV_PAGE:
					if(_book && _book.visible)
						_book.updatePage();
					break;
				case bookEvent.CLOSE_BOOK:
					_popupManager.Close(ViewConst.Book);
					dispatchEvent(new ToolEvent(ToolEvent.UPDATE_PAGE,[false, ViewConst.Book]));
					//dispatchEvent(new bookIconEvent(bookIconEvent.OPEN));
					break;
			}
		}
	}
}