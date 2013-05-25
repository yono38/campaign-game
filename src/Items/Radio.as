package Items 
{
	/**
   * ...
   * @author Jason Schapiro
   */
  import Entities.InfluenceField;
  import org.flixel.FlxGroup;
  import org.flixel.FlxSprite;
  import org.flixel.FlxPoint;
  
  public class Radio extends FlxGroup
  {
    [Embed(source = '../../gfx/items/radioSpriteSheet.png')] private var radioSpritesheet:Class;
    public var radioSprite:FlxSprite;
    public var field:InfluenceField;
    public var x:uint;
    public var y:uint;
    public var color:String;
    public function Radio(xpos:uint, ypos:uint) 
    {
      x = xpos;
      y = ypos;
      color = "Black";
      super();
      
      field = new InfluenceField(xpos, ypos, 50, true);
      field.influence = 0.025;
      field.exists = false;
      add(field);
      
      radioSprite = new FlxSprite(xpos, ypos);
      radioSprite.immovable = true;
      radioSprite.loadGraphic(radioSpritesheet, true, false, 18, 27, false);
      radioSprite.scale = new FlxPoint(2,2);
      radioSprite.addAnimation("blank", [0], 0);
      radioSprite.addAnimation("blue", [2,4], 15, true);
      radioSprite.addAnimation("red", [3,5], 15, true);
      radioSprite.play("blank");
      add(radioSprite);  
    }
    
    public function purchase(blue:Boolean):void {
      field.setBlue(blue);
      field.exists = true;
      if (blue) radioSprite.play("blue");
      else radioSprite.play("red");
    }    
    
  }

}