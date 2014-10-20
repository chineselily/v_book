package utils
{
	
	
	public class FunctionCache
	{
		//需缓存函数列表
		private var _arrFun:Array;
		//需缓存函数对应的参数
		private var _arrParam:Array;
		
		public function FunctionCache()
		{
			_arrFun = new Array();
			_arrParam = new Array();
		}
		
		public function cacheFun(fun:Function, param:Array):void
		{
			_arrFun.push(fun);
			_arrParam.push(param);
		}
		
		public function getArrFun():Array
		{
			return _arrFun;	
		}
		
		public function getFunArrParam(fun:Function):Array
		{
			var index:int = _arrFun.indexOf(fun);
			if(index!=-1) return _arrParam[index];
			
			return null;
		}
		
		public function getArrParam():Array
		{
			return _arrParam;
		}
		
		public function apply():void
		{
			if(_arrFun==null 
			|| _arrParam==null 
			|| _arrFun.length<1
			|| _arrFun.length!=_arrParam.length) return;
			
			var fun:Function;
			for(var i:int=0; i<_arrFun.length; i+=1)
			{
				fun = _arrFun[i];
				fun.apply(null,_arrParam[i]);
			}
			
		}
		
		public function applyImmediatly(fun:Function, param:Array):void
		{
			if(fun==null) return;
			
			cacheFun(fun,param);
			
			fun.apply(null,param);
		}
	}
}