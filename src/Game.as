package
{
	import starling.display.Sprite;
	import starling.events.Event;
	public class Game extends Sprite
	{
		
		public function Game()
		{
			super();
		this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		
		}
		private var onAddedToStage:Function;{
			
			trace("starling framework initialized!");
			
		}
	
	
	}
	
	
}