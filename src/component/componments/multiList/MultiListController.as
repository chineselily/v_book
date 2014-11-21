package component.componments.multiList
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import utils.FilterUtil;

	public class MultiListController
	{
		private var prevButton:DisplayObject;
		private var nextButton:DisplayObject;
		private var prevPageButton:DisplayObject;
		private var nextPageButton:DisplayObject;
		private var firstButton:DisplayObject;
		private var lastButton:DisplayObject;
		
		private var mList:MultiList; 
		
		public function MultiListController(list:MultiList,skin:DisplayObjectContainer)
		{
			mList 				= list;
			this.prevButton     = skin.getChildByName("prevButton");
			this.nextButton     = skin.getChildByName("nextButton");
			this.prevPageButton = skin.getChildByName("prevPageButton");
			this.nextPageButton = skin.getChildByName("nextPageButton");
			this.firstButton    = skin.getChildByName("firstButton");
			this.lastButton     = skin.getChildByName("lastButton");
			
			if(this.prevButton && !this.prevButton.hasEventListener(MouseEvent.CLICK))
				this.prevButton.addEventListener(MouseEvent.CLICK,onButtonClick);		
			if(this.nextButton && !this.nextButton.hasEventListener(MouseEvent.CLICK))
				this.nextButton.addEventListener(MouseEvent.CLICK,onButtonClick);
			if(this.prevPageButton && !this.prevPageButton.hasEventListener(MouseEvent.CLICK))
				this.prevPageButton.addEventListener(MouseEvent.CLICK,onButtonClick);				
			if(this.nextPageButton && !this.nextPageButton.hasEventListener(MouseEvent.CLICK))
				this.nextPageButton.addEventListener(MouseEvent.CLICK,onButtonClick);	
			if(this.firstButton && !this.firstButton.hasEventListener(MouseEvent.CLICK))
				this.firstButton.addEventListener(MouseEvent.CLICK,onButtonClick);	
			if(this.lastButton && !this.lastButton.hasEventListener(MouseEvent.CLICK))
				this.lastButton.addEventListener(MouseEvent.CLICK,onButtonClick);
		}
				
		protected function onButtonClick(evt:Event):void
		{
			if(mList.data == null)
				return;
			switch(evt.currentTarget){
				case prevButton:
					mList.index--;
					break;
				case nextButton:
					mList.index++;
					break;
				case prevPageButton:
					mList.index -= mList.pageNum;
					break;
				case nextPageButton:
					mList.index += mList.pageNum;
					break;
				case firstButton:
					mList.index = 0;
					break;
				case lastButton:
					mList.index = mList.totalIndex;
					break;
			}
			//checkButtonStatus();
		}
		
		public function checkButtonStatus():void
		{
			if(prevButton){
				if(mList.index == 0){
					setMouseEnabled(prevButton,false);
					FilterUtil.applyblack(prevButton);
				}else{
					setMouseEnabled(prevButton,true);
					prevButton.filters = [];
				}
			}
			if(nextButton){
				if(mList.index == mList.totalIndex){
					setMouseEnabled(nextButton,false);
					FilterUtil.applyblack(nextButton);
				}else{
					setMouseEnabled(nextButton,true);
					nextButton.filters = [];
				}
			}
			if(prevPageButton){
				if(mList.index == 0){
					setMouseEnabled(prevPageButton,false);
					FilterUtil.applyblack(prevPageButton);
				}else{
					setMouseEnabled(prevPageButton,true);
					prevPageButton.filters = [];
				}
			}
			if(nextPageButton){
				if(mList.index >= mList.totalIndex){
					setMouseEnabled(nextPageButton,false);
					FilterUtil.applyblack(nextPageButton);
				}else{
					setMouseEnabled(nextPageButton,true);
					nextPageButton.filters = [];
				}
			}
			if(firstButton){
				if(mList.index == 0){
					setMouseEnabled(firstButton,false);
					FilterUtil.applyblack(firstButton);
				}else{
					setMouseEnabled(firstButton,true);
					firstButton.filters = [];
				}
			}
			if(lastButton){
				if(mList.index == mList.totalIndex){
					setMouseEnabled(lastButton,false);
					FilterUtil.applyblack(lastButton);
				}else{
					setMouseEnabled(lastButton,true);
					lastButton.filters = [];
				}
			}
		}
		
		private function setMouseEnabled(dis:DisplayObject,enabled:Boolean):void
		{
			if(dis is SimpleButton)
			{
				(dis as SimpleButton).mouseEnabled = enabled;
			}
			else if(dis is MovieClip)
			{
				(dis as MovieClip).mouseEnabled = enabled;
				(dis as MovieClip).mouseChildren = enabled;
				(dis as MovieClip).buttonMode	= true;
			}
		}
		
		public function setButtonsEnable(enable:Boolean):void
		{
			if(prevButton){
				setMouseEnabled(prevButton,enable);
			}
			if(nextButton){
				setMouseEnabled(nextButton,enable);
			}
			if(prevPageButton){
				setMouseEnabled(prevPageButton,enable);
			}
			if(nextPageButton){
				setMouseEnabled(nextPageButton,enable);
			}
			if(firstButton){
				setMouseEnabled(firstButton,enable);
			}
			if(lastButton){
				setMouseEnabled(lastButton,enable);
			}
		}
	}
}