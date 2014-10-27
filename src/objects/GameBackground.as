package objects
{
	
	import starling.events.Event;
	import starling.display.Sprite;
	
	public class GameBackground extends Sprite
	{
		private var bgLayer1:BgLayer;
		private var bgLayer2:BgLayer;
		private var bgLayer3:BgLayer;
		private var bgLayer4:BgLayer;
		
		private var _speed:Number = 0;
		
		public function GameBackground()
		{
			super();
		
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
		
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			
		bgLayer1 = new BgLayer(1);
		bgLayer1.parallax = 0.02;
		this.addChild(bgLayer1);
		
		bgLayer2 = new BgLayer(2);
		bgLayer2.parallax = 0.2;
		this.addChild(bgLayer2);
		
		bgLayer3 = new BgLayer(3);
		bgLayer3.parallax = 0.5;
		this.addChild(bgLayer3);
		
		bgLayer4 = new BgLayer(4);
		bgLayer4.parallax = 1;
		this.addChild(bgLayer4);
		
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame)
		
		}
		
		private function onEnterFrame(event:Event):void
		{
			bgLayer1.x -= Math.ceil(_speed*bg 
			
		}
		public function get speed():Number
	{
		return _speed
	}
	public function set speed(value:Number):void
	{
		_speed = value;
	}
	
	}
}