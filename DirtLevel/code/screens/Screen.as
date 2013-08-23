package code.screens {
	import flash.display.Sprite;
	import code.Document;
	import code.screens.Screen;
	
	public class Screen extends Sprite {
		
		protected var doc:Document;
		public function get Doc():Document { return doc; }
		
		public function Screen(doc:Document) {
			this.doc = doc;
		}

		public function bringIn()
		{
			//stuff
		}
		
		public function bringOut()
		{
			cleanUp();
		}
		
		public function cleanUp()
		{			
			if(doc!=null)
			{
				stage.stageFocusRect = false;
				stage.focus = doc;
				doc.removeChild(this);
			}
		}
	}
	
}
