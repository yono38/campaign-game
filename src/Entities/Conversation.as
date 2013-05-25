package Entities 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Sean Diamond
   * Modifications by Jason Schapiro
	 */
	public class Conversation extends FlxText
	{
		
		private var dieTimer:Timer;
		
		public function Conversation(x:Number,y:Number,text:String) 
		{
			super(x, y, 60, text);
			//add text to the current state
			this.scrollFactor.x = 0;
			this.scrollFactor.y = 0;
      this.color = 0xff000000;
      this.size = 13;
			FlxG.state.add(this);
      fadeAndDie();
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
     // trace("text killed");
			kill();
		}
		
		private function fadeText(e:Event):void 
		{
			this.alpha = this.alpha -.3;
		}
		
		
	}

}