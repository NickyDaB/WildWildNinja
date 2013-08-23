package code
{
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class characterStick extends GameObject
	{
		public var handX:Number;
		public var handY:Number;
		
		public function characterStick(iXpos, iYpos, XposOfHandThatHoldsGun, YposOfHandThatHoldsGun){
			super(iXpos, iYpos);
			obeyGravity = false;
			
			handX = XposOfHandThatHoldsGun;
			handY = YposOfHandThatHoldsGun;
		}
		
	}

}