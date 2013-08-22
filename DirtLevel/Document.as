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
		//MASTER VARIABLES
		public var gameObjectList:Array; // List of every game object in the game
		public var _environmentList:Array; //Holds references to Art Assests and non interacatable objects
		public var temp:Number;
		public var weaponList:Array; //temp list for all the bullets in the game
		
		//Layers - Handles proper depth of all art on screen
		public var landscapeLayer:Sprite; //Clouds, Mountains
		public var backgroundLayer:Sprite; //Open space for other details
		public var midgroundLayer:Sprite; // Building Fronts
		public var detailLayer:Sprite; // Non-entities (Lamp Posts, non-interactable art)
		public var platformLayer:Sprite; // Interactable Art (Boxes, Barrels)
		public var entityLayer:Sprite; // Player, enemies, bullets
		public var foregroundLayer:Sprite; // Deatils infront of everything else (Flowers, Dust Clouds)
		
		//Lists for Layers - A list of every given object on that sprite layer
		public var landscapeList:Array;
		public var backgroundList:Array;
		public var midgroundList:Array;
		public var detailList:Array;
		public var platformList:Array; //Holds all Platforms and interactable objects
		public var entityList:Array;	
		public var foregroundList:Array;
		
		
<<<<<<< HEAD
		//MASTER VARIABLES
		public var gameObjectList:Array;
		public var _environmentList:Array; //Holds references to Art Assests and non interacatable objects
		public var temp:Number;
		public var weaponList:Array;
		public var enemyWeaponList:Array;
		
=======
		//The "xShift" var is the number that we offset that layer's x movement by to give the illusion of depth of field through paralax scrolling. It gets multipled via the xScroll speed during update. 
		//For example .10 would be move at 10% of xSpeed.
		public var landscapeShift:Number = .10;
		public var backgroundShift:Number = .25; 		
		public var midgroundShift:Number = .5;
		public var detailShift:Number = .75; 		
		public var platformShift:Number = .75;
		public var foregroundShift:Number = 1.25;
>>>>>>> origin/Nick
		
		//Game Objects
		public var testBlock:GameObject;
		public var testBlock32:Cube32;
		public var tempBlock32:Cube32;
		public var platTestBlock32:Cube32;
		public var player:Player;
		public var playerGunTest:characterStick;
		public var weapon:Weapon;
		//public var plat:Platform;
		
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
			landscapeLayer =  new Sprite(); //Clouds, Mountains
			backgroundLayer =  new Sprite(); //Open space for other details
			midgroundLayer = new Sprite(); // Building Fronts
			detailLayer = new Sprite(); // Non-entities (Lamp Posts, non-interactable art)
			platformLayer = new Sprite(); // Interactable Art (Boxes, Barrels)
			entityLayer = new Sprite(); // Player, enemies, bullets
			foregroundLayer = new Sprite(); // Deatils infront of everything else (Flowers, Dust Clouds)
			
			//add layers as children
			addChild(landscapeLayer);
			addChild(backgroundLayer);
			addChild(midgroundLayer);
			addChild(detailLayer);
			addChild(platformLayer);
			addChild(entityLayer);
			addChild(foregroundLayer);
			
			//game Objects
			gameObjectList = new Array();
			weaponList = new Array();
			enemyWeaponList = new Array();
			_environmentList = new Array();
			
			landscapeList = new Array();
			backgroundList = new Array();
			midgroundList = new Array();
			detailList = new Array();
			platformList = new Array();
			entityList = new Array();
			foregroundList = new Array();
			
			player = new Player(20, 0, this);
			player.scaleX = .75;
			player.scaleY = .75;
			gameObjectList.push(player);
			entityLayer.addChild(player);
			
			weapon = new Weapon(player, this);
			gameObjectList.push(weapon);
			entityLayer.addChild(weapon);
			
			addPlatform(525, 150, 150, 20);
			addPlatform(190, 260, 270, 20);
			addPlatform(0, 455, 720, 25);
			
			//Enemy Manager
			enemManager = new EnemyManager(this);
			entityLayer.addChild(enemManager.enemyList[0]);
			
			//Parllax Test
			var cube1:Cube32 = new Cube32(stage.stageWidth / 2, 16); //Landscape
			gameObjectList.push(cube1);
			landscapeList.push(cube1);
			landscapeLayer.addChild(cube1);
			var cube2:Cube32 = new Cube32(stage.stageWidth / 2, 32); // Background
			gameObjectList.push(cube2);
			backgroundList.push(cube2);
			backgroundLayer.addChild(cube2);
			var cube3:Cube32 = new Cube32(stage.stageWidth / 2, 48); // Midground
			gameObjectList.push(cube3);
			midgroundList.push(cube3);	
			midgroundLayer.addChild(cube3);	
			var cube4:Cube32 = new Cube32(stage.stageWidth / 2, 64); // Detail
			gameObjectList.push(cube4);
			detailList.push(cube4);
			detailLayer.addChild(cube4);
			var cube5:Cube32 = new Cube32(stage.stageWidth / 2, 80); // Foreground
			gameObjectList.push(cube5);
			foregroundList.push(cube5);
			foregroundLayer.addChild(cube5);
			
			//Event Listeners
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, platformerInputPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, platformerInputRelease);
		}
		
		public function platformerInputPress(event:KeyboardEvent):void {
			//trace("you pressed key: " + event.keyCode);
			if (event.keyCode == 68 || event.keyCode == 39)
			{
				player.move("RIGHT");
				//trace("right");
				player.rightSlide = true;
				
			}
			if (event.keyCode == 65 || event.keyCode == 37)
			{
				player.move("LEFT");
				//trace("left");
				player.leftSlide = true;
			}
			if (event.keyCode == 32 || event.keyCode == 87 || event.keyCode == 38)
			{
				player.jump();
				//trace("jump");
			}
			//q
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
			
			//Begin Alex Stuff
			_curTime = getTimer( );
			_dt = (_curTime - _lastTime)/1000;
			_lastTime = _curTime;
			graphics.clear();
			
			enemManager.update(player.x,player.y, _dt);
			//END Alex Stuff
		}
		
		public function addPlatform(xLoc:Number, yLoc:Number, w:Number, h:Number): void
		{
			var plat:Platform = new Platform();
			plat.x = xLoc;
			plat.y = yLoc;
			plat.width = w;
			plat.height = h;
			gameObjectList.push(plat);
			platformList.push(plat);
			platformLayer.addChild(plat);
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
		
		public function scrollGame(xShift:Number, yShift:Number):void {
			var i:int = 0;			
			
			for(i = 0; i < landscapeList.length; i++) {
					
					landscapeList[i].x += xShift * landscapeShift;
					landscapeList[i].y += yShift;
				
			}
			for(i = 0; i < backgroundList.length; i++) {
					
					backgroundList[i].x += xShift * backgroundShift;
					backgroundList[i].y += yShift;
				
			}
			for(i = 0; i < midgroundList.length; i++) {
					
					midgroundList[i].x += xShift * midgroundShift;
					midgroundList[i].y += yShift;
				
			}
			for(i = 0; i < detailList.length; i++) {
					
					detailList[i].x += xShift * detailShift;
					detailList[i].y += yShift;
				
			}
			for(i = 0; i < platformList.length; i++) {
					
					platformList[i].x += xShift * platformShift;
					platformList[i].y += yShift;
				
			}
			for(i = 0; i < foregroundList.length; i++) {
					
					foregroundList[i].x += xShift * foregroundShift;
					foregroundList[i].y += yShift;
				
			}
			
			for(i = 0; i < enemyWeaponList.length; i++)
			{
				enemyWeaponList[i].x += xShift;
				enemyWeaponList[i].y += yShift;
			}
			
			enemManager.scrollEnemy(xShift, yShift);
		}
	}
}