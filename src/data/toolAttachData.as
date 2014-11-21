package data
{
	public class toolAttachData
	{
		public var _winName:String;
		public var _curPage:int;
		public var _totalPage:int;
		public function toolAttachData(cur:int, total:int,name:String)
		{
			_winName = name;
			_curPage = cur;
			_totalPage = total;
		}
	}
}