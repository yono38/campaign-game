package Managers 
{
	/**
   * ...
   * @author Jason Schapiro
   */
	import Entities.Conversation;
	import org.flixel.*;
	
	public class convoManager extends FlxGroup
	{

		public var numConvos:int = 30;
		private var lastReleased:int = 1;
	//	private var releaseRate:int;
		private var firstAvail:Conversation;
		
		public function convoManager()
		{
			super();
			
			for (var i:int = 0; i < numConvos; i++)
			{
				add(new Conversation(0, 0, "Hi"));
			}
		}
    
    public function talk(bx:int, by:int, myText:String):void
		{
			firstAvail = Conversation(getFirstAvailable());
			
			if (firstAvail)
			{
				firstAvail.talk(bx, by, myText);
			}
		}
    
  }

}