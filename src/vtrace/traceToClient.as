package vtrace
{

	public class traceToClient extends traceBase
	{
		public function traceToClient()
		{
			super();
		}
		
		override public function Trace(...params):void
		{
			trace(params);
		}
	}
}