package popwindowmanager
{
	import flash.display.Sprite;
	
	import appconfig.app.ProjectLayer;
	import appconfig.window.windowCache;
	
	import view.PopWindow;

	public class PopWindowData
	{
		private var _id:String;//窗口ID
		private var _iclone:int;//同类窗口打开多个时，用于区分
		private var _winClazz:Class;//对应的窗口类
		private var _win:PopWindow;//窗口类
		private var _aniType:int;// 窗口打开动画
		private var _popType:int;//窗口是否可以重叠打开
		private var _layer:int;//窗口在界面上的层
		
		public function PopWindowData(tid:String, twinclazz:Class, tlay:int, taniType:int, tpopType:int)
		{
			id=tid;
			_iclone=0;
			_winClazz = twinclazz;
			_layer = tlay;
			_popType = tpopType;
			_aniType = taniType;
		}
		
		public function get win():PopWindow
		{
			if(_win==null)
			{
				_win = new winClazz() as PopWindow;
				_win.popData = this;
			}
			return _win;
		}
		public function get winClazz():Class
		{
			return _winClazz;
		}

		public function set id(value:String):void
		{
			_id = value;
		}		
		public function get id():String
		{
			return _id;
		}
		public function get clone_id():String
		{
			return _id+"_"+_iclone;
		}

		public function set layer(value:int):void
		{
			_layer = value;
		}
		public function get layer():int
		{
			return _layer;
		}
		
		public function set popType(value:int):void
		{
			_popType = value;
		}	
		public function get popType():int
		{
			return _popType;
		}
		
		public function get aniType():int
		{
			return _aniType;
		}
		public function set aniType(value:int):void
		{
			_aniType = value;
		}

		public function get resPath():String
		{
			return windowCache.Instance.windowPath(_id);
		}
		
		public function get isNoRes():Boolean
		{
			return resPath==null || resPath=="";
		}
		
		public function get container():Sprite
		{
			return ProjectLayer.Instance.getLayer(_layer);
		}
		
		public function clone():PopWindowData
		{
			var data:PopWindowData = new PopWindowData(this.id,this._winClazz,this._layer,this.aniType,this.popType);
			data._iclone+=1;
			return data;
		}
	}
}