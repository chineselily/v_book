package utils
{
	
	
	public class functionCache
	{
		//需缓存函数列表
		private var _arrFun:Array;
		//需缓存函数对应的参数
		private var _arrParam:Array;
		
		public function functionCache()
		{
			_arrFun = new Array();
			_arrParam = new Array();
		}
		
		public function cacheFun(fun:Function, param:Array):void
		{
			if(_arrFun.indexOf(fun)!=-1 && _arrParam.indexOf(param)!=-1) return;
			
			_arrFun.push(fun);
			_arrParam.push(param);
		}
		
		public function apply(addParam:Array=null):void
		{
			if(_arrFun==null 
			|| _arrParam==null 
			|| _arrFun.length<1
			|| _arrFun.length!=_arrParam.length) return;
			
			for(var i:int=0; i<_arrFun.length; i+=1)
			{
				sapply(_arrFun[i],_arrParam[i],addParam);
			}
			
		}
		
		public static function sapply(fun:Function, param:Array, addparam:Array=null):void
		{
			if(fun==null) return;

			if(addparam!=null) param = addparam.concat(param);
			fun.apply(null,param);
		}
	}
}