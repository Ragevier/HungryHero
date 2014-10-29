package screens
{
		
	import flash.utils.getTimer;
	
	import objects.GameBackground;
	import objects.Hero;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class inGame extends Sprite
	{
		
		private var startButton:Button;
		private var bg:GameBackground
		private var hero:Hero;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var gameState:String;
		private var playerSpeed:Number;
		private var hitObsticle:Number = 0;
		private const MIN_SPEED:Number = 650;
		
		
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
			bg = new GameBackground();
			
			this.addChild(bg)
			
			hero = new Hero();
			hero.x = stage.stageWidth/2;
			hero.y = stage.stageHeight/2;
			this.addChild(hero)
		
		startButton = new Button(Assets.getAtlas().getTexture("startButton"));
		startButton.x = stage.stageWidth * 0.5 - startButton.width * 0.5;
		startButton.y = stage.stageHeight * 0.5 - startButton.height * 0.5;
		this.addChild(startButton);
		}
	public function disposeTemporarily():void
	{
		this.visible = false;			
		}
	public function initialize():void
	{
		this.visible = true	
	
		
	this.addEventListener(Event.ENTER_FRAME, checkElapsed);
	
	hero.x = -stage.stageWidth;
	hero.y = stage.stageHeight * 0.5;
	
	gameState = "idle";
	playerSpeed = 0;
	hitObsticle = 0; 
	bg.speed = 0;
	
	startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
	}
	
	private function onStartButtonClick(event:Event):void
	{
		startButton.visible = false;
		startButton.removeEventListener(Event.TRIGGERED, onStartButtonClick);
		launchHero();
	}
	private function launchHero():void
	{
		
		this.addEventListener(Event.ENTER_FRAME, onGameTick);
		
	}
	
	private function onGameTick(event:Event):void
	{
		switch(gameState)
		{
			case "idle":
			
			if (hero.x < stage.stageWidth * 0.5 * 0.5)
			{
				hero.x +=((stage.stageWidth * 0.5 * 0.5 + 10) - hero.x) * 0.5;
				hero.y = stage.stageHeight * 0.5; 
				
				playerSpeed +=(MIN_SPEED - playerSpeed) * 0.05;
				bg.speed = playerSpeed * elapsed;
				
			}
			else
			{
				gameState = "flying";
			
			}
			break;
			
			case "flying":
				playerSpeed -= (playerSpeed -MIN_SPEED) * 0.01;
				bg.speed = playerSpeed*elapsed;
				
			
				break;
			case "over":
				break;			
			
		}
	}
	
	private function checkElapsed(event:Event):void
	{
		timePrevious = timeCurrent;
		timeCurrent = getTimer();
		elapsed = (timeCurrent - timePrevious) * 0.001;
	}	
	
	}
}