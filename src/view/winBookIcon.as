package view
{
	import flash.display.MovieClip;
	
	import component.button;
	import component.componments.multiList.MultiList;
	
	import event.ToolEvent;
	
	import mediator.AppDispatcher;
	
	import utils.displayMapUtil;

	public class winBookIcon extends PopWindow
	{
		//public var prevPageButton:MovieClip;
		//public var nextPageButton:MovieClip;
		
		private var _multilist:MultiList;
		
		public function winBookIcon()
		{
			super();
		}
		
		override protected function initialData():void
		{
			//displayMapUtil.mapDisplay(_skin,this);
			//var btn1:button = new button(prevPageButton);
			//var btn2:button = new button(nextPageButton);
			
			_multilist = new MultiList(bookListItem,null,4,4,78,37);
			//_multilist.setController(_skin);
			_multilist.x=-225;_multilist.y=-306;
			_skin.addChild(_multilist);
		}
		
		override public function Open(params:Array):void
		{
			if(_skin.contains(_multilist))
				_skin.removeChild(_multilist);
			_multilist.data = params;
			
			AppDispatcher.Instance.dispatchEvent(new ToolEvent(ToolEvent.UPDATE_PAGE,[true,1,_multilist.totalIndex+1,ViewConst.Book_Icon]));
		}
		
		override public function onOpenComplete(params:Array):void
		{
			if(!_skin.contains(_multilist))	
				_skin.addChild(_multilist);
		}
		
		public function updatePage(bPrev:Boolean=true):void
		{
			if(bPrev && _multilist.index>0)
				_multilist.index-=1;
			if(!bPrev && _multilist.index<_multilist.totalIndex)
				_multilist.index+=1;
		}
	}
}
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.geom.Point;

import appconfig.app.ProjectConst;

import component.button;
import component.componments.multiList.ListItem;

import event.bookIconEvent;

import loadermanager.LoaderFactory;
import loadermanager.LoaderFactoryLibrary;
import loadermanager.LoaderItemInfo;

import mediator.AppDispatcher;

import utils.alignTool;

class bookListItem extends ListItem
{
	public function bookListItem()
	{
		setSkin(LoaderFactoryLibrary.Instance().getMovieClip("iconItem_mc"));
		skin.x+=42.5;
		skin.y+=54;
	}
	
	override public function set data(value:Object):void
	{
		super.data = value;
		//this.visible=true;
		if(value==null) return;
		
		var bookid:String = value as String;
		LoaderFactory.Instance().addGroup("bookListItem",ProjectConst.bookpng_path+bookid+ProjectConst.icon_extend)
			                    .addCompleteFun(onComplete);
		function onComplete(info:LoaderItemInfo):void
		{
			var pig:Bitmap = info.getBitmap();
			var point:Point=alignTool.alignDisplayobjects(skin,pig,alignTool.MIDDLE);
			pig.x=point.x; pig.y=point.y;
			while(skin.numChildren>0) 
				skin.removeChildAt(0);
			skin.addChild(pig);
			
			var btn:button = new button(skin);
			btn.addEventListener(MouseEvent.CLICK, onClick);
		}
	}
	
	protected function onClick(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		AppDispatcher.Instance.dispatchEvent(new bookIconEvent(bookIconEvent.OPEN_BOOK,[data]));
	}
}