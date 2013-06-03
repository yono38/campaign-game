package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
  import org.flixel.FlxGroup;
  import org.flixel.FlxText;
  import org.flixel.FlxSprite;
  
  public class StartLabels extends FlxGroup
  {
    private var radioLbl:FlxGroup;
    private var radioTower:FlxSprite;
    private var radioText:FlxText;
    
    private var speechLbl:FlxSprite;
    private var speechInfluence:FlxSprite;
    private var speechText:FlxText;
    
    private var tvLbl:FlxSprite;
    private var tvInfluence:FlxSprite;
    private var tvText:FlxText;
    
		private var dieTimer:Timer;
    
    
    [Embed(source = '../../gfx/labels/radiotowerLabel.png')] public var radiotowerPic:Class;
    [Embed(source = '../../gfx/labels/radioLabel.png')] public var radioPic:Class;

    [Embed(source = '../../gfx/labels/tvLabel.png')] public var tvPic:Class;

    [Embed(source = '../../gfx/labels/speechLabel.png')] public var speechPic:Class;
    
    public function StartLabels() 
    {
      super();
      
      tvLbl = new FlxSprite(290, 590);
      tvLbl.loadGraphic(tvPic);
      add(tvLbl);
      
      tvText = new FlxText(385, 635, 400, "Billboard");
      tvText.size = 20;
      tvText.color = 0xFFFFFF00;
      add(tvText);
      
      tvInfluence = new FlxSprite(350, 655);
      tvInfluence.makeGraphic(200, 70, 0x50FFFF00);
      add(tvInfluence);
      
      radioTower = new FlxSprite(1160, 250);
      radioTower.loadGraphic(radiotowerPic);
      add(radioTower);


      var radio1:FlxSprite = new FlxSprite(690, 590);
      radio1.loadGraphic(radioPic);
      add(radio1);
      var radio2:FlxSprite = new FlxSprite(690, 185);
      radio2.loadGraphic(radioPic);
      add(radio2);      
      var radio3:FlxSprite = new FlxSprite(915, 360);
      radio3.loadGraphic(radioPic);
      add(radio3);
      var radio4:FlxSprite = new FlxSprite(300, 31);
      radio4.loadGraphic(radioPic);
      add(radio4);      
            
      radioText = new FlxText(1090, 375, 500, "Radios");
      radioText.size = 20;
      radioText.color = 0xFF551D45;
      add(radioText);
      
      speechLbl = new FlxSprite(338, 347);
      speechLbl.loadGraphic(speechPic);
      add(speechLbl);

      speechInfluence = new FlxSprite(350, 400);
      speechInfluence.makeGraphic(210, 160, 0x50FAA31B);
      add(speechInfluence);      
      
      speechText = new FlxText(440, 375, 400, "Speech");
      speechText.size = 20;
      speechText.color = 0xFFFAA31B;
      add(speechText);
      
  //    fadeAndDie();
      
    }
    
    public function fadeAndDie():void {
			//fade the text
			dieTimer = new Timer(700, 3);
			dieTimer.addEventListener(TimerEvent.TIMER, fadeText);
			dieTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dieText);
			dieTimer.start();
		}
		
		private function dieText(e:TimerEvent):void 
		{
			dieTimer.removeEventListener(TimerEvent.TIMER, fadeText);
			dieTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, dieText);	
      trace("labels killed");
      var i:uint;
      for (i = 0; i < this.length; i++) {
        this.members[i].alpha = 1;
      }
      exists = false;
		}
		
		private function fadeText(e:Event):void 
		{
      var i:uint;
      for (i = 0; i < this.length; i++) {
        this.members[i].alpha -= 0.3;
      }
			
		}
    
  }

}