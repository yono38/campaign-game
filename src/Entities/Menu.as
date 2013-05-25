package Entities
{
	/**
	 * ...
	 * @author Jason Schapiro
	 */
	import org.flixel.*;
	import Entities.User;
	
	public class Menu extends FlxGroup
	{
		// all the textings
		public var headerText:FlxText;
		public var cashText:FlxText;
		public var signText:FlxText;
		public var radioText:FlxText;
		public var speechText:FlxText;
		public var tvText:FlxText;
    public var voterText:FlxText;
		
		public var itemArray:Array;
		public var color:uint;
		public var usr:User;
		public var x:uint;
		public var y:uint;
		public var arrowPos:uint;
		public var upKey:String;
		public var downKey:String;
		public var selectKey:String;
    public var priceArr:Array;
		
		public function Menu(myusr:User, isLeft:Boolean, prices:Array)
		{
			// defaults
			//    width = 270;
			//    height = 790;
			if (!isLeft)
			{
				x = 1230;
				color = 0xffff0000;
				upKey = "UP";
				downKey = "DOWN";
				selectKey = "ENTER";
			}
			else
			{
				x = 0;
				color = 0xff0000ff;
				upKey = "W";
				downKey = "S";
				selectKey = "D";
			}
			y = 0;
			active = true;
			arrowPos = 0;
			// end defaults;
			
      priceArr = prices;
			usr = myusr;
			
			super();
			
			// name
			headerText = new FlxText(x + 40, 20, 300, usr.name);
			headerText.size = 20
			headerText.color = color;
			add(headerText);
			
			// cash
			cashText = new FlxText(x + 20, 60, 300, "$" + usr.cash.toFixed(2));
			cashText.size = 21;
			cashText.color = color;
			add(cashText);

			// cash
			voterText = new FlxText(x + 20, 100, 300, "$" + usr.voters);
			voterText.size = 21;
			voterText.color = color;
			add(voterText);			
      
			// items
			signText = new FlxText(x + 30, 160, 300, "> Sign: $");
			signText.size = 21;
			signText.color = color;
			add(signText);
			
			radioText = new FlxText(x + 30, 240, 300, "Radio: $1000");
			radioText.size = 21;
			radioText.color = color;
			add(radioText);
			
			tvText = new FlxText(x + 30, 320, 300, "TV: $2000");
			tvText.size = 21;
			tvText.color = color;
			add(tvText);
			
			speechText = new FlxText(x + 30, 400, 300, "Speech: $5000");
			speechText.size = 21;
			speechText.color = color;
			add(speechText);
			
			itemArray = new Array(signText, radioText, tvText, speechText);
      
		
		}
		
		override public function update():void
		{
			cashText.text = "$" + usr.cash.toFixed(2);
      voterText.text = "Voters: " + usr.voters;
			var txtarr:Array = (signText.text).split("$");
      signText.text = txtarr[0] + "$" + ((50 + 15 * Math.pow(usr.signs, 2))).toFixed(0);

			txtarr = (radioText.text).split("$");
      radioText.text = txtarr[0] + "$" + (priceArr[1]).toFixed(0);
      
			txtarr = (tvText.text).split("$");
      tvText.text = txtarr[0] + "$" + (priceArr[2]).toFixed(0);
      
      txtarr = (speechText.text).split("$");
      speechText.text = txtarr[0] + "$" + (priceArr[3]).toFixed(0);
      
			super.update();
		
		}
		
		public function upMenu():void
		{
			if (arrowPos != 0)
			{
				itemArray[arrowPos].text = (itemArray[arrowPos].text).substr(2);
				arrowPos--;
				itemArray[arrowPos].text = "> " + itemArray[arrowPos].text;
			}
		}
		
		public function downMenu():void
		{
			if (arrowPos != 3)
			{
				itemArray[arrowPos].text = (itemArray[arrowPos].text).substr(2);
				arrowPos++;
				itemArray[arrowPos].text = "> " + itemArray[arrowPos].text;
			}
		}
	}
}