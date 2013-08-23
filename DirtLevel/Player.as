package  
{
	 
	//Author: Alex Williams
	
	import flash.display.Sprite;	
	import flash.geom.Point;
	
	public class Player extends GameObject
	{
		
		//attributes
		private var onPlatform:Boolean;
		private var animate:Boolean = false;
		private var animating:Boolean = false;
		
		private var direction:String = "stand";
		private var whatToAnimate:String = "stand";
		
		//Movement Variables
		public var xSpeed:Number;
		public var ySpeed:Number;
		private var gravity:Number;
		
		private var jumping:Boolean;;
		private var falling:Boolean;
		private var collision:Boolean;
		private var _wallSlide:Boolean;
		private var _sprint:Boolean;
		
		private var refPoint:Point;
		private var convertedRefPoint:Point;
		private var compareX:Number;
		private var compareY:Number;
		
		//Base Variables for Game
		private var _document:Document;
		
		//Hard Coded Locations for Hands
		public var handX = x+width;
		public var handY = y+height/2;
	
		public var _position:Vector2;
		private var idleHeight:Number;
		private var idleWidth:Number;
		
		public function get position() {return _position;}
		public function get wallSlide() {return _wallSlide;}
		public function get sprint() {return _sprint;}
		
		public function set wallSlide(slide:Boolean) {_wallSlide = slide;}
		public function set sprint(run:Boolean) {_sprint = run;}
		public function set position(pos:Vector2) {_position = pos;}
		
		public function Player(iXpos, iYpos, aDoc:Document){
			
			
			onPlatform = false;
			jumping = true;
			super(iXpos, iYpos);
			_position = new Vector2(0, 0);
			_document = aDoc;
			
			_wallSlide = false;
			_sprint = false;
			
			//_center = new Vector2((iXpos),(iYpos));
			//trace(width);
			//trace(height);
			
			xSpeed = 0;
			ySpeed = 0;
			
			gravity = 2;
			idleHeight = height;
			idleWidth = width;
			
			//graphics.clear();
			//graphics.lineStyle(2,0x000000);
			//graphics.drawCircle(width/2,_position.y + height,10);
			//graphics.drawCircle(width/2,_position.y,10);
			
		}
		
		override public function update():void {
			
			//graphics.clear();
			//graphics.lineStyle(2,0x000000);
			//graphics.drawCircle(width/2,y + height * 2,10);
			//graphics.drawCircle(width/2,y,10);
			
			collisions(_document.platformList);
			 
			if(x >= stage.stageWidth/4) {
				//_document.x -= xSpeed; //Breaks the parallax
				_document.scrollGame(-xSpeed * 2,0);
			}
			else {
				x += xSpeed;
			}
			
			if(jumping) {
				ySpeed -= gravity;
				if(ySpeed <= 0) {falling = true; jumping = false;}
				if(y <= (stage.stageHeight * .40)) {
					_document.scrollGame(0,ySpeed);
				}
			}
			
			if(falling) {
				ySpeed -= gravity;
			}
			
			
			if(y <= (stage.stageHeight * .40)) {
				//_document.y += ySpeed;
				_document.scrollGame(0, -ySpeed);
			}else if (jumping || falling) {
				//_document.y += ySpeed * 1.3;
				_document.scrollGame(0, ySpeed);
			}
			else {
				y -= ySpeed;
			}
			
		}
		
		public function setYSpeed(){
			
			if(onPlatform){
				jumping = true; //up
				onPlatform = false;
				ySpeed = 40;
				//_document.scrollGame(0,ySpeed);
				gotoAndPlay("jump_mation");
			}
		}
		
		public function setXSpeed(iDirection) {
			//trace("iDirect: " + iDirection);
			direction = iDirection.toUpperCase(); 
			if (direction == "RIGHT") {
				 
				if (_sprint && onPlatform) {
					xSpeed = 20;
				}
				else {
					xSpeed = 8;
				}
				
				if (!animating){
					animating = true;
					gotoAndPlay("run");
				}
				
			}else if (direction == "LEFT") {

			
				if (_sprint && onPlatform) {
					xSpeed = -8;
				}
				else {
					xSpeed = -8;
				}
				
				if (!animating){
					animating = true;
					gotoAndPlay("run");
				}
			}else if (direction == "STAND") {
				xSpeed = 0;
				animate = false;
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("idle");
			}else {
				trace("ELSE! - Possible Key Release");
				//xSpeed = 0;
				direction = "STAND";
				animating = false;
				whatToAnimate = "stand";
				gotoAndStop("idle");
				
			}
			
			collisions(_document.platformList);
			
		}
		
		public function collisions(platformList:Array):void {
			
			graphics.clear();
			graphics.lineStyle(2,0x000000);
			graphics.drawCircle(_position.x,0,10);
			graphics.drawCircle(_position.x + width,0,10);
			graphics.drawCircle(0,_position.y,10);
			graphics.drawCircle(0,_position.y + height,10);
			
			refPoint = new Point(_position.x, _position.y);
			convertedRefPoint = this.localToGlobal(refPoint);
			
			//trace(convertedRefPoint.x);
			//trace(convertedRefPoint.y);
			
			direction.toUpperCase();
			
			for (var i:int = 0; i < platformList.length; i++)
			{
				compareX = Math.abs((convertedRefPoint.x - platformList[i].x));
				compareY = Math.abs((convertedRefPoint.y - platformList[i].y));
				
				if((compareX <= 170) || (compareY <= 170)) {
				
					if(onPlatform) {
						//trace("plat");
						if(direction == "RIGHT") {
							if(((convertedRefPoint.x + width) >= platformList[i].x) && ((convertedRefPoint.x + width) 
									<= platformList[i].x + platformList[i].width)) {
								if((convertedRefPoint.y <= (platformList[i].y + platformList[i].height)) && 
									((convertedRefPoint.y >= platformList[i].y))) {
									xSpeed = 0;
									x = platformList[i].x - width;
								}
								
							}
						}else if (direction == "LEFT") {
						
							if(((convertedRefPoint.x) <= platformList[i].x + platformList[i].width) && 
									((convertedRefPoint.x) >= platformList[i].x)) {
								if((convertedRefPoint.y <= (platformList[i].y + platformList[i].height)) && 
									((convertedRefPoint.y >= platformList[i].y))) {
									xSpeed = 0;
									x = platformList[i].x + platformList[i].width;
								}
							}
						}
						
					}else if(jumping) {
						
					}else if(falling) {
						//trace("jumping");
						//against

						//landing on platform
						if((convertedRefPoint.y + height >= platformList[i].y) && 
								(convertedRefPoint.y + height <= platformList[i].y + platformList[i].height)) {
									//trace("test");
							if(((convertedRefPoint.x + width) >= platformList[i].x) && ((convertedRefPoint.x + width) 
									<= platformList[i].x + platformList[i].width)) {
										onPlatform = true;
										falling = false;
										ySpeed = 0;
										y = platformList[i].y - height;
										
							}else  if (((convertedRefPoint.x) <= platformList[i].x + platformList[i].width) && 
										((convertedRefPoint.x) >= platformList[i].x)) {
										onPlatform = true;
										falling = false;
										ySpeed = 0;
										y = platformList[i].y - height;
										
							}
						}
					}
				} 
			}
			
		}
		
	}

}