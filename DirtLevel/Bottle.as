package  {
	
	public class Bottle extends GameObject{

		public var damage:Number;
		
		public function Bottle(xPlace:int, yPlace:int) {
			// constructor code
			super(xPlace, yPlace);
			
			damage = 15;
		}

	}
	
}
