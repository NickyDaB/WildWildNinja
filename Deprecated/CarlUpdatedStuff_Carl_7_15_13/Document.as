package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Document extends Sprite
	{
		//Layers
		public var floorLayer:Sprite;
		
		//MASTER VARIABLES
		public var gameObjectList:Array;
		public var floorList:Array;
		public var temp:Number;
		
		//Game Objects
		public var testBlock:GameObject;
		public var testBlock32:Cube32;
		public var tempBlock32:Cube32;
		public var player:PlatformerSkeleton;
		public var playerGunTest:characterStick;
		public var gun:Gun;
		
		public function Document() 
		{
			begin();
		}
		
		public function begin()
		{
			//create layers
			floorLayer = new Sprite();
			
			//add layers as children
			addChild(floorLayer);
			
			//game Objects
			gameObjectList = new Array();
			floorList = new Array();
			floorFiller();
			//EXAMPLE FORMAT:
			// X = new X();
			// push it onto the gameObjectList
			// child it to the appropriate layer
			testBlock = new GameObject(350, 0);
			gameObjectList.push(testBlock);
			addChild(testBlock);
			player = new PlatformerSkeleton(200, 0);
			gameObjectList.push(player);
			addChild(player);
			playerGunTest = new characterStick(stage.stageWidth/2, stage.stageHeight/2, 30.5, 20);
			gameObjectList.push(playerGunTest);
			addChild(playerGunTest);
			gun = new Gun(playerGunTest);
			gameObjectList.push(gun);
			addChild(gun);
			
			//Event Listeners
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, platformerInputPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, platformerInputRelease);
		}
		
		public function platformerInputPress(event:KeyboardEvent):void {
			//trace("you pressed key: " + event.keyCode);
			if (event.keyCode == 68)
			{
				player.move("RIGHT");
			}
			if (event.keyCode == 65)
			{
				player.move("Left");
			}
			if (event.keyCode == 32 || event.keyCode == 87)
			{
				player.jump();
			}
			if (event.keyCode == 81 || event.keyCode == 87)
			{
				gun.changeWeapon();
			}
			if (event.keyCode == 69)
			{
				gun.shoot();
			}
		}
		
		public function platformerInputRelease(event:KeyboardEvent):void {
			//trace("you released key: " + event.keyCode);
			if (event.keyCode == 68)
			{
				player.move("RIGHT_STOP");
			}
			if (event.keyCode == 65)
			{
				player.move("LEFT_STOP");
			}
			if (event.keyCode == 32 || event.keyCode == 87)
			{
				player.jump();
			}else {
				player.move("Stand");
			}
		}
		
		public function update(e:Event)
		{
			
			for (var i:int = 0; i < gameObjectList.length; i++)
			{
				gameObjectList[i].update();
			}
		}
		
		public function floorFiller()
		{
			temp = stage.stageWidth / 32;
			
			
			for (var i:Number = 0; i < temp; i++) {
				tempBlock32 = new Cube32(i*(32), stage.stageHeight-(32/2));
				gameObjectList.push(tempBlock32);
				floorList.push(tempBlock32);
				floorLayer.addChild(tempBlock32);
			}
			
		}
		
	}

}