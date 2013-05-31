package Items 
{
  import Entities.Runner;
  import org.flixel.FlxGroup;
  import org.flixel.FlxSprite;
	/**
   * ...
   * @author Jason Schapiro
   */
  import Entities.InfluenceField;
  public class Speech extends FlxGroup
  {
    [Embed(source = '../../gfx/items/speechSpritesheet_new.png')] private var speechSpritesheet:Class;
    public var speechSprite:FlxSprite;
    public var field:InfluenceField;
    public var x:uint;
    public var y:uint;
    public var purchased:Boolean;
    public var purchasedBlue:Boolean;
    public var speechingNow:Boolean;
    
    public function Speech(xpos:uint, ypos:uint) 
    {
      x = xpos;
      y = ypos;
      super();
      
      purchased = false;
      purchasedBlue = false;
      speechingNow = false;
      
      field = new InfluenceField(xpos, ypos, 210, true);
      field.exists = false;
      add(field);
      
      speechSprite = new FlxSprite(xpos, ypos);
      speechSprite.loadGraphic(speechSpritesheet, true, false, 70, 56, false);
      speechSprite.addAnimation("empty", [0], 0, false);
      speechSprite.addAnimation("blue", [1,4], 5, true);
      speechSprite.addAnimation("red", [2, 5], 5, true);
      speechSprite.play("empty");
      add(speechSprite);

    }
    
    override public function update():void {
      if (speechingNow) {
        field.exists = true;
        if (purchasedBlue) speechSprite.play("blue");
        else speechSprite.play("red");
      } 
      else {
        speechSprite.play("empty");
        field.exists = false;
      }
      trace("speechingNow in speech update: " + speechingNow);
      super.update();
    }
    
    public function purchase(blue:Boolean):void {
      field.setBlue(blue);
      field.exists = true;
      purchased = true;
      if (blue) {
   //     speechSprite.play("blue");
        purchasedBlue = true;
      }
      else {
   //     speechSprite.play("red");
        purchasedBlue = false;
      }
    }
    
    public function speeching(runner:Runner, area:FlxSprite) {
      if (purchased && runner.user.isBlue == purchasedBlue) {
        speechingNow = true;
        trace("speeching now!");
      }
    }
    
  }

}