package appconfig.book
{
	import flash.utils.Dictionary;

	public class vedioConfigCache
	{
		private static var _dic:Dictionary=new Dictionary();
		public function vedioConfigCache()
		{
			
		}
		
		public static function parseConfig(xml:XML):void
		{
			var id:String;
			var time:Number;
			for each(var xmlelem:XML in xml.vedio.info)
			{
				id = xmlelem.@id;
				time = xmlelem.@time;
				_dic[id]=time;
			}
		}
		
		public static function getVedioTime(id:String):Number
		{
			return _dic[id];
		}
	}
}