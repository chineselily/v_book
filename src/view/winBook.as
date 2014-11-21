package view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import appconfig.app.ProjectConst;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import component.button;
	
	import event.ToolEvent;
	import event.bookEvent;
	import event.vedioEvent;
	
	import loadermanager.LoaderFactory;
	
	import mediator.AppDispatcher;
	
	import utils.addCloseBtn;
	import utils.displayMapUtil;

	public class winBook extends PopWindow
	{
		private var _bookLay:Sprite;
		private var _bookbtnLay:Sprite;
		private var _closeLay:Sprite;

		private var bookpath:String;
		private var bookextendpath:String;

		private var bookmov:MovieClip;
		private var extendmc:MovieClip;
		
		private static const VEDIO_SIGN:String = "vedio";
		private var _arrParseFrame:Array;
		
		private var _curFrame:int;
		public function winBook()
		{
			super();
			_arrParseFrame=[];
			_curFrame=1;
		}
		
		override public function initial():void
		{
			_bookLay = new Sprite();
			_bookbtnLay = new Sprite();
			_closeLay = new Sprite();
			this.addChild(_bookLay);
			this.addChild(_bookbtnLay);
			this.addChild(_closeLay);
			createMask(0xffffff,1);
			addClose();
		}
		
		override public function Open(params:Array):void
		{
			bookmov  = _loadLibrary.getAppliactionLib(bookpath).getDisplayobject() as MovieClip;
			bookmov.gotoAndStop(_curFrame);
			_bookLay.addChild(bookmov);
			extendmc = _loadLibrary.getAppliactionLib(bookextendpath).getMovieclip("book_mc");
			_bookbtnLay.addChild(extendmc);
			extendmc.gotoAndStop(_curFrame);
			parseVedioBtn();
			
			AppDispatcher.Instance.dispatchEvent(new ToolEvent(ToolEvent.UPDATE_PAGE,[true,1,bookmov.totalFrames,ViewConst.Book]));
		}
		
		override public function loadRes(progressFun:Function, progressParam:Array, loadcompleteFun:Function, loadcompleteParam:Array, completeFun:Function, completeParam:Array):void
		{
			var idbook:String = loadcompleteParam[1][0];
			bookpath = ProjectConst.bookswf_path+idbook+ProjectConst.book_extend;
			bookextendpath = ProjectConst.bookswfextend_path+idbook+ProjectConst.book_extend;
			
			if(_loadLibrary.getAppliactionLib(bookpath))
			{
				_resStatus=2;
				completeFun.apply(null, completeParam);
			}
			else if(_resStatus!=1)
			{
				_resStatus=1;
				LoaderFactory.Instance().addGroup(POPWINDOWGROUP,bookextendpath) 
					                    .addProgressFun(progressFun,progressParam)
										.addCompleteFun(loadExtendComplete);
				function loadExtendComplete():void
				{
					LoaderFactory.Instance().addGroup(bookpath,bookpath, {type:BulkLoader.TYPE_AVM1})
						.addProgressFun(progressFun, progressParam)
						.addCompleteFun(loadcompleteFun,loadcompleteParam);
				}
			}
		}
		
		public function updatePage(bprev:Boolean=true):void
		{
			if(bprev && _curFrame>1)
			{
				_curFrame-=1;
				bookmov.gotoAndStop(_curFrame);
				extendmc.gotoAndStop(_curFrame);
			}
			if(!bprev && _curFrame<bookmov.totalFrames)
			{
				_curFrame+=1;
				bookmov.gotoAndStop(_curFrame);
				extendmc.gotoAndStop(_curFrame);
			}
			//trace("curFrame=",_curFrame,"bookframe=",bookmov.currentFrame,"booktotal=",bookmov.totalFrames);
			parseVedioBtn();
		}
		
		private function parseVedioBtn():void
		{
			var curFrame:int = extendmc.currentFrame;
			//if(_arrParseFrame.indexOf(curFrame)!=-1) return;
			
			//_arrParseFrame.push(curFrame);
			var arrChild:Array = displayMapUtil.getContainerChildrenList(extendmc,MovieClip);
			for each(var mov:MovieClip in arrChild)
			{
				var btn:button = new button(mov);
				btn.addEventListener(MouseEvent.CLICK, onVedioPlay);
			}
		}
		
		protected function onVedioPlay(evt:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var btn:MovieClip = evt.currentTarget as MovieClip;
			if(btn==null) return;
			
			var svedion:String = btn.name.split("_")[1];
			var svediop:String = ProjectConst.vedio_path+svedion+ProjectConst.vedio_extend;
			AppDispatcher.Instance.dispatchEvent(new vedioEvent(vedioEvent.OPEN_VEDIO,[svediop,svedion]));
			//trace(btn.name);
		}
		
		private function addClose():void
		{
			addCloseBtn.addClose(_closeLay,cclick, new Point(720,50));
			function cclick():void
			{
				AppDispatcher.Instance.dispatchEvent(new bookEvent(bookEvent.CLOSE_BOOK));
			}
		}
	}
}