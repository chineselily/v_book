package mediator
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	
	import event.AppEvent;

	public class BaseMediator extends EventDispatcher
	{
		private var _appDispatcher:AppDispatcher;
		protected var _arrAttachEvent:Array=null;
		
		public function BaseMediator()
		{
			_appDispatcher = AppDispatcher.Instance;
			attachEvents();
			listenEventImp();
		}
		
		override public function dispatchEvent(event:Event):Boolean
		{
			return _appDispatcher.dispatchEvent(event);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_appDispatcher.addEventListener(type,listener);
		}
		
		private function listenEventImp():void
		{
			if(_arrAttachEvent==null) return;
			
			for(var i:int=0;i<_arrAttachEvent.length;i+=1)
			{
				var attachEvent:Class = _arrAttachEvent[i] as Class;
				var xml:XML = describeType(attachEvent);
				for each(var constantxml:XML in xml..constant)
				{
					//trace(constantxml.@name);
					addEventListener(attachEvent[constantxml.@name],handler);
				}
			}
		}
		
		/**
		 * 以下两个函数在子类中需要重写
		 */
		
		/**
		 * 事件处理函数 
		 * @param evt
		 */		
		protected function handler(evt:AppEvent):void
		{
			
		}
		/**
		 * 将Mediator关联监听的Events
		 */		
		protected function attachEvents():void
		{
			//_arrAttachEvent = [AppEvent];
		}
	}
}