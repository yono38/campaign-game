/** 
*
* */

package
{
 import org.flixel.*;
 
 //[SWF(width="750", height="395", backgroundColor="#ffffff")] // small version
 [SWF(width="1500", height="790", backgroundColor="#ffffff")] // original size version

 public class Main extends FlxGame
 {
  public function Main():void
  {
   FlxG["players"] = new Array();
   FlxG["demUnlocked"] = false;
   FlxG["repUnlocked"] = false;
 //    super(1500, 790, TitleState, 0.5); // small version
   
   super(1500, 790, TitleState, 1); // original size version
   useSoundHotKeys = false;


  }
 }
}