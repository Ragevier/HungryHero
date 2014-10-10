package
{
	public class Assets
	{
		[Embed(source="../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		[Embed(source="../media/graphics/welcome_hero.png")]
		public static const WelcomeHero:Class;
	
		[Embed(source="../media/graphics/welcome_title.png")]
		public static const WelcomeTitle:Class;
	
	
		[Embed(source="../media/graphics/welcome_playButton.png")]
		public static const WelcomePlayBtn:Class;
	
		[Embed(source="../media/graphics/welcome_aboutButtom.png")]
		public static const WelcomeAboutBtn:Class;
	
	
		private static var gameTexture:Dictionary = new Dictionary 
		
		public static function getTexture(name:String):Texture
		
		{
			
			if(gameTexture[name] == undefined){
				
			var bitmap:Bitmap = new Assets[name]();
			gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name]:
		}
	
	}
}