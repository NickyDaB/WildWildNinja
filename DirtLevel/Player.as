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
		
		public var _previousY:Number;
		private var _currentY:Number;
		private var positionDiff:Number;
		//End Michelle Stuff
		
		//Hard Coded Shit
		public var handX = x+width;
		public var handY = y+height/2;
		//
		
		// -------------Added By ALEX for AI -----------------
		public var _position:Vector2;
		
		public function get position() {return _position;}
		
		public function Player(iXpos, iYpos, aDoc:Document){
			
			
			onGround = false;
			super(iXpos, iYpos);
			_position = new Vector2(iXpos, iYpos);
			_document = aDoc;
			_previousY = iYpos;
			_currentY = iYpos;
		}
		
		public override function update():void {
			
			_document.scrollGame(-xSpeed, 0);
			_document.x -= xSpeed/2;
			x += xSpeed/2;
			//doubleTapLeft--;
			//doubleTapRight--;
			
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
			
			if(!isJumping){
				isJumping = true; //up
				ySpeed = 75;
				_document.scrollGame(0,ySpeed);
				gotoAndPlay("jump_mation");
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
					xSpeed = 8;
				}
				else if (doubleTapRight > 0 && !rightDown && !isJumping)
				{
					xSpeed = 8;
					dashRight = false;
				}
				else if (dashRight)
				{
					xSpeed = 8;
				}
				else
				{
					xSpeed = 8;
				}
				
				doubleTapRight = 20;
				rightDown = true;
				if (!animating){
					animating = true;
					gotoAndPlay("run");
				}
			}else if (direction == "LEFT") {
				//x = x - 5;
				
				
				if (leftSlide && x <= 0)
				{
					xSpeed = -8;
				}
				else if (doubleTapLeft > 0 && !leftDown && !isJumping)
				{
					xSpeed = -8;
					dashLeft = false;
				}
				else if (dashLeft)
				{
					xSpeed = -8;
				}
				else
				{
					xSpeed = -8;
				}
				
				doubleTapLeft = 20;
				leftDown = true;
				if (!animating){
					animating = true;
					gotoAndPlay("idle");
				}
			}else if (direction == "STAND") {
				xSpeed = 0;
				animate = false;
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("idle");
				dashLeft = false;
				dashRight = false;
			}else {
				trace("ELSE! - Possible Key Release");
				//xSpeed = 0;
				direction = "STAND";
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("idle");
				
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
						if(y < platformList[i].y) //platform above
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
				
				if(this.y + this.height/2 == platformList[i].y) {
					if((this.x >= platformList[i].x) && (this.x <= platformList[i].x + platformList[i].width)) {
						collision = true;
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
			else //Gravity actions
			{
				y -= ySpeed;
				ySpeed -= gravity;
				//if(!collision){_document.y += ySpeed;}
				_position.y = y;
				
			}
			
			if (y >= stage.stageHeight - height)
			{
				isJumping = false;
				y = stage.stageHeight - height;
				_position.y = y;
				collision = false;
			}
			
			//_currentY = _position.y;
			//positionDiff = _previousY - _currentY;
			//if(positionDiff != 0) {
				//_document.scrollGame(0, positionDiff);
				//_previousY = _position.y;
			//}
			 
		}
		
	}

}