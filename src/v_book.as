package
{
	import flash.display.Sprite;
	
	import appconfig.app.ProjectConst;
	import appconfig.app.ProjectLayer;
	import appconfig.app.ProjectMediatorMap;
	import appconfig.book.BookConfigCache;
	
	import event.LoadingEvent;
	
	import loadermanager.LoaderFactory;
	import loadermanager.LoaderItemInfo;
	
	import mediator.AppDispatcher;
	
	
	public class v_book extends Sprite
	{
		private var _dispatcher:AppDispatcher;
		public function v_book()
		{
			_dispatcher = AppDispatcher.Instance;
			ProjectLayer.Instance.initLayer(this);
			loadBookConfig();
		}
		
		private function loadBookConfig():void
		{
			var sGroup:String = "bookconfigloader";
			LoaderFactory.Instance().addGroup(sGroup,ProjectConst.bookconfig_path)
				.addCompleteFun(onBookConfigComplete);
			
			function onBookConfigComplete(info:LoaderItemInfo):void
			{
				var xml:XML = info.getXML();
				
				BookConfigCache.parseBookResConfig(xml.book);
				
				ProjectMediatorMap.Instance().Map();
				
				_dispatcher.dispatchEvent(new LoadingEvent(LoadingEvent.OPEN));
			}
		}
		
		private function loadSWFConfig():void
		{
			
		}
	}
}