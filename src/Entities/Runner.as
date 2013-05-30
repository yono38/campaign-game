package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
  import org.flixel.*;

  public class Runner extends FlxSprite
  {
    [Embed(source = '../../gfx/chars/littleReagan.png')] public var reaganHeadPic:Class;
    [Embed(source = '../../gfx/chars/littleDubya.png')] public var dubyaHeadPic:Class;
    [Embed(source = '../../gfx/chars/littleSchwartzenegger.png')] public var schwartzeneggerHeadPic:Class;
    
    [Embed(source = '../../gfx/chars/littleObama.png')] public var obamaHeadPic:Class;    
    [Embed(source = '../../gfx/chars/littleClinton.png')] public var clintonHeadPic:Class;    
    [Embed(source = '../../gfx/chars/littleJFK.png')] public var jfkHeadPic:Class;    

    private var heads:Array;
    private var xSpeed:Number;
    private var ySpeed:Number;
    public var user:User;
    public function Runner(xpos:uint, ypos:uint, plyr:User) 
    {
      heads = [[obamaHeadPic, clintonHeadPic, jfkHeadPic], [reaganHeadPic, dubyaHeadPic, schwartzeneggerHeadPic]];
      if (plyr.isBlue) {
        loadGraphic(heads[0][plyr.myChar]);
      }
      else {
        loadGraphic(heads[1][plyr.myChar]);
      }
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