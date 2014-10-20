package Trace
{

	public class TraceManager
	{
		private static var _instance:TraceManager;
		
		public static const CLIENT:int = 0;//输出到客户端
		public static const SERVER:int = 1;//输出到服务器
		public static const ALL:int = 2;//两边都输出
		
		private var _arr:Vector.<TraceBase>;
		
		public function TraceManager(_interal:TraceManagerInteral)
		{
			_arr = new Vector.<TraceBase>();
			_arr.push(new TraceToClient(), new TraceToServer());
		}
		
		public static function Instance():TraceManager
		{
			if(_instance==null) _instance = new TraceManager(new TraceManagerInteral());
			
			return _instance;
		}
		
		public function TraceOut(obj:Object, iType:int=ALL):void
		{
			if(iType>2 || iType<0) return;
			
			if(iType==2)
			{
				for(var i:int=0;i<_arr.length;i+=1)
					_arr[i].Trace(obj);
			}
			else
			{
				_arr[iType].Trace(obj);
			}
		}
	}
}
class TraceManagerInteral{}