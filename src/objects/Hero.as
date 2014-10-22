package objects
{
	import starling.core.Starling
	import flash.events.Event;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class heroArt extends Sprite
	{
		private var Heroart:MovieClip;
		public function Hero()
		{
			super();
		this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		createHeroArt();
			
		}
		
		private function createHeroArt():void
		{
		
		heroArt = new MovieClip(Assets.getAtlas().getTextures("fly_"), 20);
		
		heroArt.x = Math.ceil(-heroArt.width/2);
		heroArt.y = Math.ceil(-heroArt.height/2);
		
		
		starling.core.Starling.juggler
		this.addChild(heroArt);	
		}
	}
}