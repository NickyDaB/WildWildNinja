package  
{
	/**
	 * ...
	 * @author Michelle L.
	 */
	public class Player extends PlatformerSkeleton 
	{
		
		//attributes
		private var onGround:Boolean;
		private var animate:Boolean = false;
		private var animating:Boolean = false;
		
		private var jumpHeight:Number = 32;
		private var xVelocity:Number = 0;
		
		private var direction:String = "stand";
		private var whatToAnimate:String = "stand";
		
		//Michelle Stuff
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;		
		public var leftSlide:Boolean = false;
		public var rightSlide:Boolean = false;
		public var rightDown:Boolean = false;
		public var leftDown:Boolean = false;
		
		private var gravity:int = 15;
		private var fric:int = 10;
		private var isJumping = false;
		private var collision:Boolean = false;
		private var doubleTapRight:int = 0;
		private var doubleTapLeft:int = 0;
		private var dashRight:Boolean = false;
		private var dashLeft:Boolean = false;
		
		private var _document:Document; 
		//End Michelle Stuff
		
		//Hard Coded Shit
		public var handX = x+width;
		public var handY = y+height/2;
		//
		
		// -------------Added By ALEX for AI -----------------
		public var _position:Vector2;
		
		public function Player(iXpos, iYpos, aDoc:Document){
			
			
			onGround = false;
			super(iXpos, iYpos);
			_position = new Vector2(iXpos, iYpos);
			_document = aDoc;
		}
		
		public override function update() {
			//Start Nick's Old Code
			/*if (obeyGravity == true){
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
			}*/ // End Nick's Old Code
			
			//move player in X direction
			//trace(xSpeed);
			//x += xSpeed;
			//_position.x = ;
			_document.scrollGame(-xSpeed, 0);
			doubleTapLeft--;
			doubleTapRight--;
			
			if(x < 0)
			{
				x = 0;
				//xSpeed = 0;
			}
			else if(x > stage.width - width)
			{
				x = stage.width - width;
				//xSpeed = 0;
			}
			
		}
		
		public function jump(){
			//Start Nick's Old Code
			/*if (onGround){ 
				onGround = false;
				y = y - jumpHeight;
			}*/ //End Nick's Old Code
			
			if(!isJumping){
				isJumping = true; //up
				ySpeed = 75;
				
			}
		}
		
		public function move(iDirection)
		{
			//trace("iDirect: " + iDirection);
			direction = iDirection.toUpperCase(); 
			if (direction == "RIGHT") {
				/*xVelocity = 6;
				
				if(xVelocity + 2 < 10){
					xVelocity += 2;
				}else { xVelocity = 10;}*/
				
				if (rightSlide && _position.x >= stage.stageWidth)
				{
					xSpeed = 25;
				}
				else if (doubleTapRight > 0 && !rightDown && !isJumping)
				{
					xSpeed = 30;
					dashRight = true;
				}
				else if (dashRight)
				{
					xSpeed = 30;
				}
				else
				{
					xSpeed = 8;
				}
				
				doubleTapRight = 20;
				rightDown = true;
				if (!animating){
					animating = true;
					gotoAndPlay("walkRight");
				}
			}else if (direction == "LEFT") {
				//x = x - 5;
				
				
				if (leftSlide && x <= 0)
				{
					xSpeed = -25;
				}
				else if (doubleTapLeft > 0 && !leftDown && !isJumping)
				{
					xSpeed = -30;
					dashLeft = true;
				}
				else if (dashLeft)
				{
					xSpeed = -30;
				}
				else
				{
					xSpeed = -8;
				}
				
				doubleTapLeft = 20;
				leftDown = true;
				if (!animating){
					animating = true;
					gotoAndPlay("walkLeft");
				}
			}else if (direction == "STAND") {
				xSpeed = 0;
				animate = false;
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("stand");
				dashLeft = false;
				dashRight = false;
			}else {
				trace("ELSE! - Possible Key Release");
				//xSpeed = 0;
				direction = "STAND";
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("stand");
				
			}
		}
		
		public function jumpCollisions(platformList:Array):void
		{
			if (y < stage.stageHeight )//&& (x + width < platformList[i].x  || x > platformList[i].x + platformList[i].width))
			{
				isJumping = true;
			}
			for (var i:int = 0; i < platformList.length; i++)
			{
				
				
				if(isJumping)
				{

					/*if(player.hitTestObject(plat2))
					{
						trace("crash");
						trace (player.y);
						trace (player.ySpeed);
						if(player.y < plat2.y + plat2.height)
						{
							trace("below");
							player.ySpeed = player.y;
							player.y = plat2.height + plat2.y;
							
							//trace(player.y);
						}
						else
						{
							trace("blah");//player.y = plat2.y + plat2.height/2 + player.height;
						}
					}*/
					if(x + width > platformList[i].x  && x < platformList[i].x + platformList[i].width && !collision)
					{
						if (y > platformList[i].y + platformList[i].height)
						{
							if((y  - ySpeed) <= (platformList[i].y + platformList[i].height)) //below
							{
							
								y = platformList[i].y + platformList[i].height;
								ySpeed = 0;
								_position.y = y;
								//trace("below");
								collision = true;
							}
						}
						if(y < platformList[i].y) //above
						{
							if ((y  - ySpeed) > platformList[i].y - height)
							{
								y = platformList[i].y - height;
								ySpeed = 0;
								_position.y = y;
								isJumping = false;
								collision = false;
								//trace("above");
							}
							//player.ySpeed = 0;
							
						}
					}				
				}		
			}
			
			//Wall Sliding
			if (leftSlide && x <= 0 && ySpeed <=  0)
			{
				y -= ySpeed;
				ySpeed -= (gravity - fric);
				_position.y = y;
				isJumping = false;
				trace("SlideL");
			}
			else if (rightSlide && x + width >= stage.stageWidth && ySpeed <=  0) 
			{
				y -= ySpeed;
				ySpeed -= (gravity - fric);
				_position.y = y;
				isJumping = false;
				trace("SlideR");
			}
			else
			{
				y -= ySpeed;
				ySpeed -= gravity;
				_position.y = y;
				
			}
			
			if (y >= stage.stageHeight - height)
			{
				isJumping = false;
				y = stage.stageHeight - height;
				_position.y = y;
				collision = false;
			}	
		}
		
	}

}