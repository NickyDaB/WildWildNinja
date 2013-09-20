package code.screens {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import code.Document;
	
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class DirtRoom extends Screen{
		
		//Attributes
		public var returnBtn:SimpleButton
		
		//Constructor
		public function DirtRoom(doc:Document) {
			// constructor code
			super(doc);
		}
		
		//Methods
		public override function bringIn()
		{			  
			  super.bringIn();
			  returnBtn.addEventListener(MouseEvent.CLICK, onReturn);
		}
		
		private function onReturn(e:MouseEvent):void
		{
			  doc.displayScreen(TitleScreen);
		}	

	}
	
}
