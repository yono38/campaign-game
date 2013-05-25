package Items 
{
  import Entities.InfluenceField;
  import org.flixel.FlxSprite;
	/**
   * ...
   * @author Jason Schapiro
   */
  public class Sign extends InfluenceField
  {
    [Embed(source = '../../gfx/items/signSpritesheet.png')] private var signSpritesheet:Class;
    public var legendSprite:FlxSprite;
    
    public function Sign(xpos:uint, ypos:uint, blue:Boolean)
    {
     influence = 0.1;
     super(xpos, ypos, 24, blue);
     loadGraphic(signSpritesheet, true, false, 22, 24, false);
     addAnimation("blue", [0], 0, false);
     addAnimation("red", [1], 0, false);
     if (blue) { play("blue"); }
     else { play("red");}
    }
    
  }

}