package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
	import org.flixel.*;
	
	public class InfluenceField extends FlxSprite
	{
    public var radius:uint;
    public var isBlue:Boolean;
    public var influence:Number;
    
    public function InfluenceField(xpos:uint, ypos:uint, rad:uint, blue:Boolean) 
    {
      influence = 0.05;
      isBlue = blue;
      immovable = true;
      x = xpos;
      y = ypos;
      radius = rad;
      if (blue){
        makeGraphic(radius, radius, 0x500000ff);
      }
      else {
        makeGraphic(radius, radius, 0x50ff0000);
      }
    }
    
    public function setBlue(makeBlue:Boolean):void {
      isBlue = makeBlue ? true : false; 
      if (makeBlue){
        makeGraphic(radius, radius, 0x500000ff);
      }
      else {
        makeGraphic(radius, radius, 0x50ff0000);
      }      
    }
    
  }

}