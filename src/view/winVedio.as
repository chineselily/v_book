package view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	
	import appconfig.book.bookConfigCache;
	import appconfig.book.vedioConfigCache;
	
	import component.button;
	
	import event.vedioEvent;
	
	import loadermanager.LoaderFactory;
	
	import mediator.AppDispatcher;
	
	import utils.addCloseBtn;
	import utils.displayMapUtil;

	public class winVedio extends PopWindow
	{
		private var _netStream:NetStream; 
		private var _duration:Number;//返回总时间，秒为单位 
		private var _video:Video;
		private var _svedio:String;
		
		public var time_txt:TextField;
		public var play_btn:MovieClip;
		public var stop_btn:MovieClip;
		private var btnplay:button;
		private var btnstop:button;
		
		private var _isPlay:Boolean = false;//是否在播放 
		
		public function winVedio()
		{
			super();
			
			var _netConnection:NetConnection = new NetConnection(); 
			_netConnection.connect(null); 
			var _clientOb:Object = new Object(); 
			_clientOb.onMetaData = onMD; 
			_netStream = new NetStream(_netConnection); 
			_netStream.bufferTime = 15; 
			_netStream.client = _clientOb; 
			_video = new Video(800,800); 
			_video.attachNetStream(_netStream);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus); 
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			
			this.addChild(_video);
		}
		private function onMD(data:Object):void 
		{ 
			trace("data..",data);
			_duration = data.duration; 
		} 
		protected function onFrame(evt:Event):void
		{
			// TODO Auto-generated method stub
			if(_isPlay)
			{
				time_txt.text=Math.floor(_netStream.time/60) +":"+ Math.round(_netStream.time%60)+"/" 
					+Math.floor(_duration/60) +":"+ Math.round(_duration%60); 
			}
		}
		
		override protected function initialData():void
		{
			_skin.x=400;
			_skin.y=800+_skin.height/2;
			
			displayMapUtil.mapDisplay(_skin,this);
			time_txt.text="00:00/00:00";
			btnplay = new button(play_btn);
			btnstop = new button(stop_btn);
			chgVisible(false);
			btnplay.addEventListener(MouseEvent.CLICK, onClick);
			btnstop.addEventListener(MouseEvent.CLICK, onClick);
			
			addCloseBtn.addClose(this,closeClick);
			createMask(0xffffff,1);
		}

		private function closeClick():void
		{
			AppDispatcher.Instance.dispatchEvent(new vedioEvent(vedioEvent.CLOSE_VEDIO));
			_video.clear();
			_netStream.close();
		}
		protected function onClick(evt:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var btn:MovieClip = evt.currentTarget as MovieClip;
			if(btn==play_btn && !_isPlay)
				playVedio();
			else
			{
				try
				{
					_netStream.togglePause();
					chgVisible(!btnplay.visible);
				}catch(er:Error)
				{
					trace(er);
				}
			}
		}
		
		override public function Open(params:Array):void
		{
			_svedio = params[0];
			_duration = vedioConfigCache.getVedioTime(params[1]);
			playVedio();
		}
		
		private function playVedio():void
		{
			_netStream.play(_svedio);
		}
		
		private function onNetStatus(evt:NetStatusEvent):void 
		{ 
			switch(evt.info.code) 
			{ 
				case "NetStream.Play.Start"://开始播放 
					_isPlay = true; 
					chgVisible(false);
					break; 
				case "NetStream.Play.Stop"://全部播放完 
					_isPlay =false;
					chgVisible(true);
					break; 
				case "NetStream.Buffer.Empty"://缓冲 
					break; 
			} 
		} 
		private function chgVisible(bplay:Boolean):void
		{
			btnplay.visible=bplay;
			btnstop.visible=!bplay;
		}
	}
}