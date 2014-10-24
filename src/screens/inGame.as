package screens
{
	
	
	import starling.display.Sprite;
	import starling.events.Event;
	import objects.Hero;
	
	public class inGame extends Sprite
	{
		private var hero:Hero;
		
		public function inGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			drawGame();
		}
		
		private function drawGame():void
		{
			hero = new Hero();
			hero.x = stage.stageWidth/2;
			hero.y = stage.stageHeight/2;
			this.addChild(hero)
		}
	public function disposeTemporarily():void
	{
		this.visible = false;
		
				
		}
	}
}