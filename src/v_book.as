package
{
	import flash.display.Sprite;
	
	import appconfig.app.ProjectConst;
	import appconfig.app.ProjectLayer;
	import appconfig.app.ProjectMediatorMap;
	import appconfig.book.bookConfigCache;
	import appconfig.book.vedioConfigCache;
	import appconfig.window.windowCache;
	
	import event.ToolEvent;
	import event.bookIconEvent;
	
	import loadermanager.LoaderFactory;
	import loadermanager.LoaderItemInfo;
	
	import mediator.AppDispatcher;
	
	[SWF(width="800",height="850" , backgroundColor="#ffffff")]
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
				
				bookConfigCache.parseBookResConfig(xml);
				
				loadVedioConfig();
			}
		}
		
		private function loadVedioConfig():void
		{
			var sGroup:String = "vedioConfigLoader";
			LoaderFactory.Instance().addGroup(sGroup,ProjectConst.vedioconfig_path)
				.addCompleteFun(onvedioConfigComplete);
			
			function onvedioConfigComplete(info:LoaderItemInfo):void
			{
				var xml:XML = info.getXML();
				vedioConfigCache.parseConfig(xml);
				loadwinSWFConfig();
			}
		}
		
		private function loadwinSWFConfig():void
		{
			var sGroup:String = "winconfigloader";
			LoaderFactory.Instance().addGroup(sGroup,ProjectConst.winconfig_path)
				.addCompleteFun(onwinConfigComplete);
			
			function onwinConfigComplete(info:LoaderItemInfo):void
			{
				var xml:XML = info.getXML();
				windowCache.Instance.cache(xml);
				
				ProjectMediatorMap.Instance().Map();
				
				_dispatcher.dispatchEvent(new bookIconEvent(bookIconEvent.OPEN,bookConfigCache.arrBookId));
				_dispatcher.dispatchEvent(new ToolEvent(ToolEvent.OPEN));
			}
		}
	}
}