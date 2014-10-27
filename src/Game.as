package
{
	
	
	import events.NavigationEvent;
	
	import screens.Welcome;
	import screens.inGame;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Game extends Sprite
	{
		private var screenWelcome:Welcome
		private var screeninGame:inGame
		
		public function Game()
		{
			super();
		this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		
		}
		
		private function onAddedToStage(event:Event):void
		{
			
		trace("starling framework initialized!");
			
		this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
		
		screeninGame = new inGame();	
		screeninGame.disposeTemporarily();
		this.addChild(screeninGame)
		
		screenWelcome = new Welcome();
		this.addChild(screenWelcome);
		screenWelcome.initialize();
		
		
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
		
			switch (event.params.id)
			{
				case "play":
				screenWelcome.disposeTemporarily();
				screeninGame.initialize();
					break;
			}
		}	
	}	
}