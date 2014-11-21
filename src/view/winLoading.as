package view
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import appconfig.app.ProjectStage;

	public class winLoading extends PopWindow
	{
		private var _txtProgress:TextField;
		private var _idProgress:String;
		
		public function winLoading()
		{
			super();
		}
		
		override protected function initialData():void
		{
			_txtProgress = new TextField();
			var txtformat:TextFormat = new TextFormat("Cambria",30,0x8E5420,true);
			_txtProgress.defaultTextFormat = txtformat;
			_txtProgress.setTextFormat(txtformat);
			_txtProgress.text="100%";
			
			_txtProgress.x = ProjectStage.WIDTH/2-20;
			_txtProgress.y = ProjectStage.HEIGHT/2;
			this.addChild(_txtProgress);
		}
		
		override public function Open(params:Array):void
		{
			if(params==null) return;
			
			_idProgress = params[0];
		}
		
		public function update(loaded:int, total:int):void
		{
			_txtProgress.text = String((loaded/total)*100);
		}
	}
}