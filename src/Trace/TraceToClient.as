package Trace
{

	public class TraceToClient extends TraceBase
	{
		public function TraceToClient()
		{
			super();
		}
		
		override public function Trace(...params):void
		{
			trace(params);
		}
	}
}