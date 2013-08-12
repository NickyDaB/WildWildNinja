package  
{
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class PlatformerSkeleton extends GameObject
	{
		//attributes
		private var onGround:Boolean;
		private var animate:Boolean = false;
		private var animating:Boolean = false;
		
		private var jumpHeight:Number = 32;
		private var xVelocity:Number = 0;
		
		private var direction:String = "stand";
		private var whatToAnimate:String = "stand";
		
		public function PlatformerSkeleton(iXpos, iYpos){
			onGround = false;
			super(iXpos, iYpos);
		}
		
		public override function update() {
			if (obeyGravity == true){
				if (y < stage.stageHeight-(this.height/2)-32){
					if (y + 8 > stage.stageHeight - (this.height / 2) - 32){
						y = stage.stageHeight - (this.height / 2) - 32;
						onGround = true;
					}else {y = y + 8;}
				}else {onGround = true;}
			}
			x = x + xVelocity;
			if (xVelocity > 0){
				if (xVelocity - friction < 0){
						xVelocity = 0;
				}else {xVelocity = xVelocity - friction;}
			}
		}
		
		public function jump(){
			if (onGround){
				onGround = false;
				y = y - jumpHeight;
			}
		}
		
		public function move(iDirection)
		{
			//trace("iDirect: " + iDirection);
			direction = iDirection.toUpperCase(); 
			if (direction == "RIGHT") {
				xVelocity = 6;
				if(xVelocity + 2 < 10){
					xVelocity += 2;
				}else { xVelocity = 10;}
				if (!animating){
					animating = true;
					gotoAndPlay("walkRight");
				}
			}else if (direction == "LEFT") {
				x = x - 5;
				if (!animating){
					animating = true;
					gotoAndPlay("walkLeft");
				}
			}else if (direction == "STAND") {
				animate = false;
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("stand");
			}else {
				trace("ELSE! - Possible Key Release");
				direction = "STAND";
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("stand");
			}
		}
		
	}

}