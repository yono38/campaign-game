package Entities 
{
	/**
   * ...
   * @author Jason Schapiro
   */
  import org.flixel.FlxText;
  import org.flixel.FlxSprite;
  import org.flixel.FlxGroup;
  import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
  
  public class GameEvent extends FlxGroup
  {
    [Embed(source = '../../gfx/events/tax_fraud.png')] private var jailPic:Class;
    [Embed(source = '../../gfx/events/sex_scandal.png')] private var censorPic:Class;
    [Embed(source = '../../gfx/events/viral_video.png')] private var viralPic:Class;
    [Embed(source = '../../gfx/events/bar_fight.png')] private var barPic:Class;

    
    public var type:uint;
    private var box:FlxSprite;
    private var avatar:FlxSprite;
    private var evtTitle:FlxText;
    private var evtDescription:FlxText;
    private var statusText:FlxText;
    private var playerTxt:FlxText;
		private var dieTimer:Timer;
    private var eventTitles:Array;
    private var eventEffects:Array;
    
    public function GameEvent(eventType:uint, player:User) 
    {
      eventTitles = ["Tax Fraud", "Viral Video", "Sex Scandal", "Bar Fight"];
      eventEffects = ["-25% Voters", "+25% Voters", "Xfer 20% to Opponent",  "-10% Voters"];
      type = eventType;
      
      
      // event box background (grey)
      box = new FlxSprite(400, 200);
      box.makeGraphic(600, 300, 0xFFA19FA0);
      add(box);
      
      // event icon
      avatar = new FlxSprite(450, 225);
      if (eventType == 2) avatar.loadGraphic(censorPic);
      else if (eventType == 1) avatar.loadGraphic(viralPic);
      else if (eventType == 3) avatar.loadGraphic(barPic);
      else avatar.loadGraphic(jailPic);
      add(avatar);
      
			// color of all text in box
      var txtColor:uint = 0xFF000000;
      
      //title
      evtTitle = new FlxText(650, 250, 300, eventTitles[eventType]);
      evtTitle.color = txtColor;
      evtTitle.size = 35;
      add(evtTitle);
      
      // player
      playerTxt = new FlxText(650, 300, 350, player.name);
      playerTxt.color = txtColor;
      playerTxt.size = 25;
      add(playerTxt);
      
      // status change
      statusText = new FlxText(650, 350, 400, eventEffects[eventType]);
      statusText.color = 0xFFFF0000;
      statusText.size = 25;
      add(statusText);   
      
      // fade away over time
      fadeAndDie();
    }
    
		public function fadeAndDie():void {
			//fade the text
      
			dieTimer = new Timer(1000, 3);
			dieTimer.addEventListener(TimerEvent.TIMER, fadeText);
			dieTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dieText);
			dieTimer.start();
		}
		
		private function dieText(e:TimerEvent):void 
		{
			dieTimer.removeEventListener(TimerEvent.TIMER, fadeText);
			dieTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, dieText);	
      for (var i:uint = 0; i < this.length; i++) {
        this.members[i].kill(); 
      }
      kill();
		}
		
		private function fadeText(e:Event):void 
		{
      for (var i:uint = 0; i < this.length; i++) {
        this.members[i].alpha -= 0.3;
      }
		}    
  }

}