package ConfigManager
{
	import BookConfigData.BookConfigManager;
	
	import LoaderManager.LoaderFactory;
	import LoaderManager.LoaderItemInfo;

	public class LoadConfig
	{
		private static var _instance:LoadConfig;
		
		public function LoadConfig(_interal:BookConfigLoaderInteral)
		{
		}
		
		public static function Instance():LoadConfig
		{
			if(_instance==null) _instance = new LoadConfig(new BookConfigLoaderInteral());
			
			return _instance;
		}
		
		public function loadBookConfig():void
		{
			var sGroup:String = "bookconfigloader";
			LoaderFactory.Instance().addGroup(sGroup,ProjectConst.bookconfig_path)
				                    .addCompleteFun(onBookConfigComplete);
			LoaderFactory.Instance().startGroup(sGroup);
		}
		
		public function onBookConfigComplete(info:LoaderItemInfo):void
		{
			var xml:XML = info.getXML();
			
			BookConfigManager.Instance().parseBookResConfig(xml.book);
		}
	}
}
class BookConfigLoaderInteral{}