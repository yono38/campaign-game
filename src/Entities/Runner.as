package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
  import org.flixel.*;

  public class Runner extends FlxSprite
  {
    [Embed(source = '../../gfx/chars/littleClinton.png')] private var littleClinton:Class;
    private var xSpeed:Number;
    private var ySpeed:Number;
    private var user:User;
    public function Runner(xpos:uint, ypos:uint, plyr:User) 
    {
      loadGraphic(littleClinton);
      x = xpos;
      y = ypos;
      xSpeed = ySpeed = 2;
      user = plyr;
    }
    
    override public function update():void {
      if (user.isBlue){
        if (FlxG.keys.A == true) {
          x -= xSpeed;
        }
        else if (FlxG.keys.D == true) {
          x += xSpeed;
        }
        if (FlxG.keys.W == true) {
          y -= ySpeed;
        }
        else if (FlxG.keys.S == true) {
          y += ySpeed;
        }
      }
      else {
        if (FlxG.keys.LEFT == true) {
          x -= xSpeed;
        }
        else if (FlxG.keys.RIGHT == true) {
          x += xSpeed;
        }
        if (FlxG.keys.UP == true) {
          y -= ySpeed;
        }
        else if (FlxG.keys.DOWN == true) {
          y += ySpeed;
        }
      }        
      

    }
    
  }

}