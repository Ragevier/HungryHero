package screens
{
		
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import objects.GameBackground;
	import objects.Hero;
	import objects.Obstacle;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	import starling.utils.deg2rad;
	
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
		private var hitObstacle:Number = 0;
		private const MIN_SPEED:Number = 650;
		
		private var scoreDistance:int;
		private var obstacleGapCount:int;
		
		private var gameArea:Rectangle;
		private var obstaclesToAnimate:Vector.<Obstacle>;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		
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
		
		gameArea = new Rectangle(0, 100, stage.stageWidth, stage.stageHeight - 250);
		
		
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
	hitObstacle = 0; 
	bg.speed = 0;
	scoreDistance = 0;
	obstacleGapCount = 0;
	
	obstaclesToAnimate = new Vector.<Obstacle>();
	
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
		this.addEventListener(TouchEvent.TOUCH, onTouch)
		this.addEventListener(Event.ENTER_FRAME, onGameTick);
		
	}
	
	private function onTouch(event:TouchEvent):void
	{
		touch = event.getTouch(stage);
		
		touchX = touch.globalX;
		touchY = touch.globalY;
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
				
				if(hitObstacle <= 0)
				{
					hero.y -= (hero.y - touchY) * 0.1;
				
					if(hero.y >gameArea.bottom - hero.height * 0.5)
					{
						hero.y = gameArea.bottom - hero.height * 0.5;
					}
					if(hero.y < gameArea.top + hero.height * 0.5)
					{
						hero.y = gameArea.top + hero.height * 0.5;
					}
				}
				
				
				playerSpeed -= (playerSpeed -MIN_SPEED) * 0.01;
				bg.speed = playerSpeed*elapsed;
				
				scoreDistance +=(playerSpeed * elapsed) * 0.1;
				trace(scoreDistance);
			
				initObstacle();
				animateObstacles();
				
				
				break;
			case "over":
				break;			
			
		}
	}
	
	private function animateObstacles():void
	{
		var obstacleToTrack:Obstacle;
		for (var i:uint = 0;i<obstaclesToAnimate.length;i++)
		{
			obstacleToTrack = obstaclesToAnimate[i];
			if	(obstacleToTrack.distance > 0)
			{
				obstacleToTrack.distance -= playerSpeed * elapsed;
			}
			else
			{
				if(obstacleToTrack.watchOut)
				{
					obstacleToTrack.watchOut = false;
				}
			obstacleToTrack.x -=(obstacleToTrack.speed) * elapsed;
		}
			if (obstacleToTrack.x < obstacleToTrack.width || gameState == "over")
			{
				obstaclesToAnimate.splice(i, 1);
				this.removeChild(obstacleToTrack);
			}
		}
	}
	
	private function initObstacle():void
	{
		if(obstacleGapCount < 1200)
		{
			obstacleGapCount += playerSpeed * elapsed;
		}
		else if(obstacleGapCount != 0)
		{
			obstacleGapCount = 0;
			createObstacle(Math.ceil(Math.random() * 4), Math.random() * 1000 + 1000);
		}
	}
	
	private function createObstacle(type:Number, distance:Number):void
	{
		var obstacle:Obstacle = new Obstacle(type, distance, true, 300);
		obstacle.x = stage.stageWidth;
		this.addChild(obstacle);
	
	if (type <=3)
	{
		if (Math.random() > 0.5)
		{
			
			obstacle.y = gameArea.top;
			obstacle.position = "top";
		}
		else
		{
			obstacle.y = gameArea.bottom - obstacle.height;
			obstacle.position = "bottom";	
		}	
	}
	else
	{
		obstacle.y = int(Math.random() * (gameArea.bottom - obstacle.height - gameArea.top)) + gameArea.top;
		obstacle.position = "middle";
		}
	obstaclesToAnimate.push(obstacle);
	}
	
	private function checkElapsed(event:Event):void
	{
		timePrevious = timeCurrent;
		timeCurrent = getTimer();
		elapsed = (timeCurrent - timePrevious) * 0.001;
	}	
	
	}
}