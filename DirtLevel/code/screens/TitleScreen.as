﻿package code.screens {
	
	import code.Document;
	import code.screens.Game;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	
	public class TitleScreen extends Screen {
		
		public var startBtn:SimpleButton, creditsBtn:SimpleButton, helpBtn:SimpleButton;
		
		public function TitleScreen(doc:Document) {
			super(doc);
		}
		
		public override function bringIn()
		{			  
			  super.bringIn();
			  startBtn.addEventListener(MouseEvent.CLICK, onStart);
			  creditsBtn.addEventListener(MouseEvent.CLICK, onCredits);
			  helpBtn.addEventListener(MouseEvent.CLICK, onHelp);
		}
		
		private function onStart(e:MouseEvent):void
		{
			  doc.displayScreen(Game);
		}		
		
		private function onCredits(e:MouseEvent):void
		{
			 // doc.displayScreen(AboutScreen);
		}	
		
		private function onHelp(e:MouseEvent):void
		{
			  //doc.displayScreen(HelpScreen);
		}
		
		public override function cleanUp()
		{
			  startBtn.removeEventListener(MouseEvent.CLICK, onStart);
			  creditsBtn.removeEventListener(MouseEvent.CLICK, onCredits);
			  helpBtn.removeEventListener(MouseEvent.CLICK, onHelp);
			  super.cleanUp();
		}


	}
	
}
