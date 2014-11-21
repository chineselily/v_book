package view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import component.button;
	
	import event.ToolEvent;
	
	import mediator.AppDispatcher;
	
	import utils.displayMapUtil;

	public class winTool extends PopWindow
	{
		public var prevPageButton:MovieClip;
		public var nextPageButton:MovieClip;
		public var page_txt:TextField;

		private var prevbtn:button;
		private var nextbtn:button;
		
		private var _curPage:int;
		private var _totalPage:int;
		public function winTool()
		{
			super();
		}
		
		override protected function initialData():void
		{
			displayMapUtil.mapDisplay(_skin,this);
			
			prevbtn = new button(prevPageButton);
			nextbtn = new button(nextPageButton);
			
			prevbtn.addEventListener(MouseEvent.CLICK, onClick);
			nextbtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		override public function Open(params:Array):void
		{
			super.Open(params);
			update(params);
		}
		
		protected function onClick(evt:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(evt.currentTarget == prevPageButton)
			{
				if(_curPage>1)
				{
					_curPage-=1;
					AppDispatcher.Instance.dispatchEvent(new ToolEvent(ToolEvent.PREV_PAGE));
					updateTxt();
				}
			}
			else if(evt.currentTarget == nextPageButton)
			{
				if(_curPage<_totalPage)
				{
					_curPage+=1;
					AppDispatcher.Instance.dispatchEvent(new ToolEvent(ToolEvent.NEXT_PAGE));
					updateTxt();
				}
			}
		}
		
		public function update(param:Array):void
		{
			_curPage=param[0];
			_totalPage=param[1];
			updateTxt();
		}
		private function updateTxt():void
		{
			var swhite:String = "  ";
			page_txt.text = _curPage+swhite+"/"+swhite+_totalPage;
		}
	}
}