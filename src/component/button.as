package component
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class button extends Sprite
	{
		private var _btnSkin:DisplayObjectContainer;
		public function button(skin:DisplayObjectContainer)
		{
			_btnSkin = skin;
			_btnSkin.mouseChildren=false;
			_btnSkin.addEventListener(MouseEvent.ROLL_OVER, onRoll);
			_btnSkin.addEventListener(MouseEvent.ROLL_OUT, onRoll);
	/*		if(_btnSkin.parent!=null)
			{
				x=_btnSkin.x;
				y=_btnSkin.y;
				name=_btnSkin.name;
				rotation=_btnSkin.rotation;
				_btnSkin.parent.addChild(this);
				_btnSkin.parent.removeChild(_btnSkin);
				_btnSkin.x=0;_btnSkin.y=0;_btnSkin.rotation=0;
				this.addChild(_btnSkin);
				this.visible = _btnSkin.visible;
			}*/
		}
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_btnSkin.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		protected function onRoll(evt:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(evt.type==MouseEvent.ROLL_OVER)
			{
				TweenLite.to(_btnSkin,0.5,{scaleX:1.2, scaleY:1.2});
			}
			else if(evt.type==MouseEvent.ROLL_OUT)
			{
				TweenLite.to(_btnSkin,0.5,{scaleX:1, scaleY:1});
			}
		}
	}
}