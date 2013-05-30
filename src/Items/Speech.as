package Items 
{
  import org.flixel.FlxGroup;
  import org.flixel.FlxSprite;
	/**
   * ...
   * @author Jason Schapiro
   */
  import Entities.InfluenceField;
  public class Speech extends FlxGroup
  {
    [Embed(source = '../../gfx/items/speechSpritesheet.png')] private var speechSpritesheet:Class;
    public var speechSprite:FlxSprite;
    public var field:InfluenceField;
    public var x:uint;
    public var y:uint;
    public function Speech(xpos:uint, ypos:uint) 
    {
      x = xpos;
      y = ypos;
      super();
      
      field = new InfluenceField(xpos, ypos, 210, true);
      field.exists = false;
      add(field);
      
      speechSprite = new FlxSprite(xpos, ypos);
      speechSprite.loadGraphic(speechSpritesheet, true, false, 70, 56, false);
      speechSprite.addAnimation("red", [1,3], 5, true);
      speechSprite.addAnimation("blue", [0, 2], 5, true);
      speechSprite.exists = false;
      add(speechSprite);
      
    }
    
    public function purchase(blue:Boolean):void {
      field.setBlue(blue);
      field.exists = true;
      speechSprite.exists = true;
      if (blue) speechSprite.play("blue");
      else speechSprite.play("red");
    }
    
  }

}