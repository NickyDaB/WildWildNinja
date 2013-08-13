package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Document extends Sprite
	{
		//Layers
		public var floorLayer:Sprite;
		public var bulletLayer:Sprite;
		public var platformLayer:Sprite;
		
		//MASTER VARIABLES
		public var gameObjectList:Array;
		public var floorList:Array;
		public var platformList:Array;
		public var temp:Number;
		public var weaponList:Array;
		
		//Game Objects
		public var testBlock:GameObject;
		public var testBlock32:Cube32;
		public var tempBlock32:Cube32;
		public var platTestBlock32:Cube32;
		public var player:Player;
		public var playerGunTest:characterStick;
		public var weapon:Weapon;
		//public var plat:Platform;
		
		/*
		//Michelle TEST
		public var gravity:int = 15;
		public var friction:int = 10;
		public var collision:Boolean = false;
		public var leftSlide:Boolean = false;
		public var rightSlide:Boolean = false;*/
		
		//AI Handler
		public var enemManager:EnemyManager;
		
		//AI Movement Timings
		private var _lastTime: Number;
		private var _curTime: Number;
		private var _dt: Number;
		
		public function Document() 
		{
			addEventListener(Event.ENTER_FRAME, frameLoop);
			begin();
		}
		
		public function begin()
		{
			_lastTime = getTimer( );
			
			//create layers
			floorLayer = new Sprite();
			bulletLayer = new Sprite();
			platformLayer = new Sprite();
			
			//add layers as children
			addChild(floorLayer);
			addChild(bulletLayer);
			addChild(platformLayer);
			
			//game Objects
			gameObjectList = new Array();
			weaponList = new Array();
			floorList = new Array();
			platformList = new Array();
			floorFiller();
			//EXAMPLE FORMAT:
			// X = new X();
			// push it onto the gameObjectList
			// child it to the appropriate layer
			testBlock = new GameObject(350, 0);
			gameObjectList.push(testBlock);
			addChild(testBlock);
			player = new Player(200, 0);
			player.scaleX = .75;
			player.scaleY = .75;
			gameObjectList.push(player);
			addChild(player);
			/*playerGunTest = new characterStick(stage.stageWidth/2, stage.stageHeight/2, 30.5, 20);
			gameObjectList.push(playerGunTest);
			addChild(playerGunTest);*/
			weapon = new Weapon(player, this);
			gameObjectList.push(weapon);
			addChild(weapon);
			
			
			//addPlatform(283, 256, 270, 20);
			addPlatform(525, 150, 150, 20);
			addPlatform(190, 260, 270, 20);
			addPlatform(0, 455, 720, 25);
			
			
			/*platTestBlock32 = new Cube32(200, 200);
			gameObjectList.push(platTestBlock32);
			platformList.push(platTestBlock32);
			platformLayer.addChild(platTestBlock32);*/
			
			//Enemy Manager
			enemManager = new EnemyManager(this);
			addChild(enemManager.enemyList[0]);
			
			//Event Listeners
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, platformerInputPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, platformerInputRelease);
		}
		
		private function frameLoop(e: Event ):void
		{
			
		}
		
		public function platformerInputPress(event:KeyboardEvent):void {
			//trace("you pressed key: " + event.keyCode);
			if (event.keyCode == 68 || event.keyCode == 39)
			{
				player.move("RIGHT");
				trace("right");
				player.rightSlide = true;
			}
			if (event.keyCode == 65 || event.keyCode == 37)
			{
				player.move("LEFT");
				trace("left");
				player.leftSlide = true;
			}
			if (event.keyCode == 32 || event.keyCode == 87 || event.keyCode == 38)
			{
				player.jump();
				trace("jump");
			}
			if (event.keyCode == 81)
			{
				weapon.changeWeapon();
			}
			//y
			if (event.keyCode == 89)
			{
				weapon.shoot();
				//enemManager.enemyList[0].lowerHealth = 5;
			}
			//u
			if (event.keyCode == 85)
			{
				enemManager.spawnEnemy();
			}
			if(event.keyCode == 67) // C button, changes behavoirs
			{
				enemManager.changeBehavior();
			}
		}
		
		public function platformerInputRelease(event:KeyboardEvent):void {
			//trace("you released key: " + event.keyCode);
			if (event.keyCode == 68 || event.keyCode == 39)
			{
				player.move("STAND");
				player.rightSlide = false;
				player.rightDown = false;
			}
			if (event.keyCode == 65 || event.keyCode == 37)
			{
				player.move("STAND");
				player.leftSlide = false;
				player.leftDown = false;
			}
			if (event.keyCode == 32 || event.keyCode == 87 || event.keyCode == 38)
			{
				player.jump();
			}else {
				player.move("STAND");
			}
		}
		
		public function update(e:Event)
		{
			
			for (var j:int = 0; j < gameObjectList.length; j++)
			{
				gameObjectList[j].update();
			}
			
			player.update();
			//move player in Y direction
			player.jumpCollisions(platformList);
			/*
			//Begin Michelle's Stuff
			player.x += player.xSpeed;
			//player.y += player.ySpeed;
			
			if(player.x < 0)
			{
				player.x = 0;
				player.xSpeed = 0;
			}
			else if(player.x > stage.width - player.width)
			{
				player.x = stage.width - player.width;
				player.xSpeed = 0;
			}
			*/
			//Collision checks with all platforms
			//jumpCollisions();
			//END Michelle's Stuff
			
			
			//Begin Alex Stuff
			_curTime = getTimer( );
			_dt = (_curTime - _lastTime)/1000;
			_lastTime = _curTime;
			graphics.clear();
			
			enemManager.update(player.x,player.y, _dt);
			//END Alex Stuff
		}
		
		public function floorFiller() : void
		{
			temp = stage.stageWidth / 32;
			
			for (var i:Number = 0; i < temp; i++) {
				tempBlock32 = new Cube32(i*(32), stage.stageHeight-(32/2));
				gameObjectList.push(tempBlock32);
				floorList.push(tempBlock32);
				floorLayer.addChild(tempBlock32);
			}
			
		}
		
		public function addPlatform(xLoc:Number, yLoc:Number, w:Number, h:Number): void
		{
			var plat:Platform = new Platform();
			plat.x = xLoc;
			plat.y = yLoc;
			plat.width = w;
			plat.height = h;
			platformLayer.addChild(plat)
			platformList.push(plat);
		}
		
		public function drawLine (startX:Number, startY:Number, endX:Number, endY:Number):void
		{
			with (graphics)
			{
				lineStyle(1);
				moveTo(startX, startY);
				lineTo(endX, endY);
			}
		}
		
		/*public function jumpCollisions():void
		{
			for (var i:int = 0; i < platformList.length; i++)
			{
				if (player.y < stage.stageHeight - plat1.height - player.height && (player.x + player.width < platformList[i].x  || player.x > platformList[i].x + platformList[i].width))
				{
					player.isJumping = true;
				}
				
				if(player.isJumping)
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
					}
					if(player.x + player.width > platformList[i].x  && player.x < platformList[i].x + platformList[i].width && !collision)
					{
						if (player.y > platformList[i].y + platformList[i].height)
						{
							if((player.y  - player.ySpeed) <= (platformList[i].y + platformList[i].height)) //below
							{
							
								player.y = platformList[i].y + platformList[i].height;
								player.ySpeed = 0;
								player._position.y = player.y;
								trace("below");
								collision = true;
							}
						}
						if(player.y < platformList[i].y) //above
						{
							if ((player.y  - player.ySpeed) > platformList[i].y - player.height)
							{
								player.y = platformList[i].y - player.height;
								player.ySpeed = 0;
								player._position.y = player.y;
								player.isJumping = false;
								collision = false;
							}
							//player.ySpeed = 0;
							trace("above");
						}
					}
					
					//Wall Sliding
					if (leftSlide && player.x <= 0 && player.ySpeed <=  0)
					{
						player.y -= player.ySpeed;
						player.ySpeed -= (gravity - friction);
						player._position.y = player.y;
						player.isJumping = false;
						trace("Slide");
					}
					else if (rightSlide && player.x + player.width >= stage.stageWidth && player.ySpeed <=  0) 
					{
						player.y -= player.ySpeed;
						player.ySpeed -= (gravity - friction);
						player._position.y = player.y;
						player.isJumping = false;
					}
					else
					{
						player.y -= player.ySpeed;
						player.ySpeed -= gravity;
						player._position.y = player.y;
						
					}
					
					if (player.y >= stage.stageHeight - plat1.height - player.height)
					{
						player.isJumping = false;
						player.y = stage.stageHeight - plat1.height - player.height;
						player._position.y = player.y;
						collision = false;
					}					
				}		
			}
		}*/
	}

}