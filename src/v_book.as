package
{
	import flash.display.Sprite;
	
	import ConfigManager.LoadConfig;
	
	
	public class v_book extends Sprite
	{
		public function v_book()
		{
			LoadConfig.Instance().loadBookConfig();	
		}
	}
}