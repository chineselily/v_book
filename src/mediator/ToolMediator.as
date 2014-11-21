package mediator
{
	import appconfig.app.ProjectLayer;
	import appconfig.book.bookConfigCache;
	
	import data.toolAttachData;
	
	import event.AppEvent;
	import event.ToolEvent;
	
	import popwindowmanager.PopWindowConst;
	
	import view.ViewConst;
	import view.winTool;

	public class ToolMediator extends PopupMediator
	{
		private var _winTool:winTool;
		
		private var _arroldAttach:Array;
		private var _curAttach:toolAttachData;
		public function ToolMediator()
		{
			super();
			_curAttach=null;
			_arroldAttach=[];
		}
		
		override protected function attachEvents():void
		{
			_arrAttachEvent = [ToolEvent];
		}
		
		override protected function attachPopWindows():void
		{
			_popupManager.registPop(ViewConst.Tool, winTool, ProjectLayer.LAYER_TOOL, 
				                    PopWindowConst.POP_NOTSAMEWIN,PopWindowConst.ANI_TYPE_BOTTOM);
		}
		
		override protected function handler(evt:AppEvent):void
		{
			switch(evt.type)
			{
				case ToolEvent.OPEN:
					_winTool = _popupManager.Open(ViewConst.Tool,[curPage,totalPage]) as winTool;
					break;
				case ToolEvent.UPDATE_PAGE:
					var badd:Boolean = evt.params[0];
					if(badd)
					{
						addAttach(new toolAttachData(evt.params[1],evt.params[2],evt.params[3]));
					}
					else
					{
						delAttach(evt.params[1]);
						_curAttach = _arroldAttach.length>0?_arroldAttach[0]:null;
					}
					if(_winTool && _winTool.visible)
						_winTool.update([curPage,totalPage]);
					break;
			}
		}
		
		private function addAttach(tdata:toolAttachData):void
		{
			delAttach(tdata._winName);
			_curAttach = tdata;
			_arroldAttach.unshift(tdata);
		}
	
		private function delAttach(name:String):void
		{
			for(var i:int=0;i<_arroldAttach.length;i+=1)
			{
				if((_arroldAttach[i] as toolAttachData)._winName == name)
				{
					_arroldAttach.splice(i,1);
					break;
				}
			}
			if(_curAttach && _curAttach._winName == name)
				_curAttach=null;
		}
		
		private function get curPage():int
		{
			return _curAttach==null?1:_curAttach._curPage;
		}
		
		private function get totalPage():int
		{
			return _curAttach==null?1:_curAttach._totalPage;
		}
	}
}