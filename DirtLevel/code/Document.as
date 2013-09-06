package code
{
	import flash.display.Sprite;
	import flash.events.Event;
	import code.screens.*;
	
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Document extends Sprite
	{
		private var game:Game;
		private var currentScreen:Screen;
		
		public function Document()
		{
			super();
			displayScreen(TitleScreen);
		}
		
		public function displayScreen(s:Class)
		{
			if(currentScreen != null)
					currentScreen.bringOut();
					
			if( s == Game){
				currentScreen = game = new Game(this);
				addChild(game);
				game.begin();						
			}else if(s == MusicTester){						
				currentScreen = new MusicTester(this);
				addChild(currentScreen);
			}else {
				currentScreen = new s(this);
				addChild(currentScreen);
			}	
			
			currentScreen.bringIn();
		}
	}
}