package Entities
{
	/**
	 * ...
	 * @author Jason Schapiro
	 */
	import org.flixel.*;
	
	public class Pedestrian extends FlxSprite
	{
    [Embed (source = '../../gfx/personSpritesheet.png')] private var person:Class;
    
    protected var timeStep:int;
    protected var timeCount:int;
    // level of influence (ranged from -20 for red to +20 for blue)
    public var influenced:int;
    
		private function randomNumber(low:Number=0, high:Number=1):Number {
      return Math.floor(Math.random() * (1+high-low)) + low;
    }
    
		public function Pedestrian(nxpos:int, nypos:int)
		{
			loadGraphic(person, true, false, 22, 22, false);
      addAnimation("normal", [2], 0, false);
      addAnimation("blue", [0], 0, false);
      addAnimation("leanblue", [3], 0, false);
      addAnimation("red", [1], 0, false);
      addAnimation("leanred", [4], 0, false);

			x = nxpos;
			y = nypos;
      velocity.x = randomNumber(-20, 20);
      velocity.y = randomNumber( -20, 20);
      timeStep = randomNumber(200, 7000);
      timeCount = 0;
      influenced = 0;
      play("normal");
		}
    
    public function setRed(isStrong:Boolean):void {
        if (isStrong) play("red");
        else  play("leanred"); 
    }
    
    public function setBlue(isStrong:Boolean):void {
      if (isStrong) play("blue");
      else play("leanblue");
    }
    
    public function setNormal():void {
      play("normal");
    }
		
		override public function update():void
		{
			timeCount++;
      if (timeCount >= timeStep) {
        changeDir();
        timeStep = randomNumber(200, 7000);
        timeCount = 0;
      }
      
      //Updates all the objects appropriately
			super.update();
		}
    
    public function changeDir():void
    {
      velocity.x = randomNumber( -20, 20);
      velocity.y = randomNumber( -20, 20);
    }
	
	}

}