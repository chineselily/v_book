package BookConfigData
{
	import ConfigManager.ProjectConst;

	public class BookResConfigData
	{
		public var id:String;
		public var page:int;
		public var index:int;
		private var _bpath:String;
		private var _ppath:String;
		
		public function BookResConfigData()
		{
			id="no name";
		}
		
		public function parsexml(xml:XML):void
		{
			id = xml.@id;
			page = xml.@page;
			index = xml.@index;
			_bpath = xml.@bpath;
			_ppath = xml.@ppath;
		}
		
		public function get bpath():String
		{
			return ProjectConst.bookswf_path+_bpath;
		}
		
		public function get ppath():String
		{
			return ProjectConst.bookpng_path+_ppath;
		}
	}
}