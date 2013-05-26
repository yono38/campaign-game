package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
  import org.flixel.*;
  
  public class Legend extends FlxGroup
  {
    public var x:uint;
    public var y:uint;
    public var speech:FlxSprite;
    public var radios:FlxGroup;
    public var tv:FlxSprite
    
    public function Legend() 
    {
      x = 22;
      y = 587;
      speech = new FlxSprite(x + 25, y + (.23 * 375));
      speech.exists = false;
      add(speech);
      tv = new FlxSprite(x + 10, y + 148);
      tv.makeGraphic(10, 15, 0xff000000);
      add(tv);    
      radios = new FlxGroup();
      var radio1:FlxSprite = new FlxSprite(x + 100, y + 138);
      radio1.makeGraphic(8, 8, 0xff000000);
      radios.add(radio1);
      var radio2:FlxSprite = new FlxSprite(x + 94, y + 43);
      radio2.makeGraphic(8, 8, 0xff000000);
      radios.add(radio2);      
      var radio3:FlxSprite = new FlxSprite(x + 154, y + 84);
      radio3.makeGraphic(8, 8, 0xff000000);
      radios.add(radio3);
      add(radios);
    }
    
    public function purchased(name:String, isBlue:Boolean):void {
      var color:uint = isBlue ? 0xff0000ff : 0xffff0000;
      if (name == "tv") {
        tv.makeGraphic(10, 15, color);
      }
      else if (name == "speech") {
        speech.exists = true;
        speech.makeGraphic(15, 12, color);
      }
      else if (name == "radio") {
        for (var i:int = 0; i < radios.length; i++) {
          radios.members[i].makeGraphic(8, 8, color);
        }
      }
    }
    
    public function purchasedSign(xpos:uint, ypos:uint, isBlue:Boolean):FlxSprite {
      var xleg:uint = ((xpos - 274) * 0.23) + 22;
      var yleg:uint = (ypos * 0.23) + 587;
      var color:uint = isBlue ? 0xff0000ff : 0xffff0000;
      
      var legendSign:FlxSprite = new FlxSprite(xleg, yleg);
      legendSign.makeGraphic(5, 5, color);
      return legendSign;
    }
    
    
  }

}

/*
public function addToLegend(xpos:uint, ypos:uint) 
{
      x = xpos;
      y = ypos;
      
	  x -= 274; 					//subtracting width of blue menu so calculations aren't skewed by the offset
	  x *= 0.23;					//Legend is 0.23 size of actual map
	  leftLegendX = x + 22; 		//left legend coordinates: (22, 587)
	  rightLegendX = x + 1252;		//right legend coordinates:  (1252, 587)
	  
	  y *= 0.23;
	  leftLegendY = y + 587;
	  rightLegendY = y + 587;
	  
	  //make dot at (leftLegendX, leftLegendY);
	  //make dot at (rightLegendX, rightLegendY);
}
*/