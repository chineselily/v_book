package appconfig.app
{
	public class ProjectConst
	{
		public static const serverPath:String="http://172.17.3.233/vbook/";//我的电脑上安装了apache,并且在安装目录下D:\Program Files\Apache Software Foundation\Apache2.2\htdocs放文件
		public static const bookconfig_path:String=serverPath+"config/BookConfig.xml";
		public static const bookswf_path:String = serverPath+"swf/";
		public static const bookpng_path:String = serverPath+"png/"
		
		public function ProjectConst()
		{
			
		}
	}
}