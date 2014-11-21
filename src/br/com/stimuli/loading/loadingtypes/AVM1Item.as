package br.com.stimuli.loading.loadingtypes
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import br.com.stimuli.loading.ForcibleLoader;
	
	public class AVM1Item extends ImageItem
	{
		public function AVM1Item(url:URLRequest, type:String, uid:String)
		{
			super(url, type, uid);
		}
		
		override public function load() : void
		{
			//super.load();
			loader = new Loader();
			
			var fLoader:ForcibleLoader = new ForcibleLoader(this);
			//loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler, false, 0, true);
			//loader.contentLoaderInfo.addEventListener(Event.INIT, onInitHandler, false, 0, true);
			//loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 100, true);
			//loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler, false, 0, true);
			//loader.contentLoaderInfo.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);  
			//loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false, 0, true);

			try{
				// TODO: test for security error thown.
				//loader.load(url, _context);
				fLoader.load(url);
			}catch( e : SecurityError){
				onSecurityErrorHandler(_createErrorEvent(e));
			}
		}
		
		override public function onCompleteHandler(evt : Event) : void 
		{
			if (loader.content != null) 
			{
				var mc:MovieClip = this.loader.content as MovieClip;
			}
			super.onCompleteHandler(evt);
		}
		
	}
}