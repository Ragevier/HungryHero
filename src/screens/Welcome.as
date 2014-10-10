package screens
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Welcome extends Sprite
	{
		public function Welcome()
		{
			super();
		
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		
		}
	private function onAddedToStage(event:Event):void{
		trace("welcome screen initialized");
	}
		
	
	}
}