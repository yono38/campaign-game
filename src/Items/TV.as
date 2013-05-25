package Items 
{
  import org.flixel.FlxGroup;
  import org.flixel.FlxSprite;
	/**
   * ...
   * @author Jason Schapiro
   */
  import Entities.InfluenceField;
  public class TV extends FlxGroup
  {
    [Embed(source = '../../gfx/items/screenSpritesheet.png')] private var tvSpritesheet:Class;
    public var tvSprite:FlxSprite;
    public var field:InfluenceField;
    public var x:uint;
    public var y:uint;
    public function TV(xpos:uint, ypos:uint) 
    {
      x = xpos;
      y = ypos;
      super();
      
      field = new InfluenceField(xpos, ypos, 250, true);
      field.exists = false;
      add(field);
      
      tvSprite = new FlxSprite(xpos, ypos);
      tvSprite.immovable = true;      
      tvSprite.loadGraphic(tvSpritesheet, true, false, 44, 72, false);
      tvSprite.addAnimation("blank", [0], 0);
      tvSprite.addAnimation("blue", [1,4], 15, true);
      tvSprite.addAnimation("red", [2,5], 15, true);
      tvSprite.play("blank");
      add(tvSprite);

    }
    
    public function purchase(blue:Boolean):void {
      field.setBlue(blue);
      if (blue){
        field.makeGraphic(250, 125, 0x500000ff);
      }
      else {
        field.makeGraphic(250, 125, 0x50ff0000);
      }   
      field.exists = true;
      if (blue) tvSprite.play("blue");
      else tvSprite.play("red");
    }
    
  }

}