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
    public var headPic:FlxSprite;
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
      
      // avatar
      headPic = new FlxSprite(x + 40, 30);
      headPic.loadGraphic(myusr.head);
      headPic.scale.x = 0.5;
      headPic.scale.y = 0.5;
      add(headPic);
			
			// cash
			cashText = new FlxText(x + 20, 140, 300, "$" + usr.cash.toFixed(2));
			cashText.size = 21;
			cashText.color = color;
			add(cashText);

			// cash
			voterText = new FlxText(x + 20, 180, 300, "$" + usr.voters);
			voterText.size = 21;
			voterText.color = color;
			add(voterText);			
      
			// items
      var keys:Array;
      if (isLeft) {
        keys = [1, 2, 3, 4];
      }
      else {
        keys = [7, 8, 9, 0];
      }
      
			signText = new FlxText(x + 30, 240, 300, keys[0]+") Sign: $");
			signText.size = 21;
			signText.color = color;
			add(signText);
			
			radioText = new FlxText(x + 30, 300, 300, keys[1]+") Radio: $1000");
			radioText.size = 21;
			radioText.color = color;
			add(radioText);
			
			tvText = new FlxText(x + 30, 360, 500, keys[2]+") TV: $2000");
			tvText.size = 21;
			tvText.color = color;
			add(tvText);
			
			speechText = new FlxText(x + 30, 420, 300, keys[3]+ ") Speech: $5000");
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
      var signPrice:Number = ((50 + 15 * Math.pow(usr.signs, 2)));
      signText.text = txtarr[0] + "$" + signPrice.toFixed(0);
      if (usr.cash < signPrice) {
        signText.color = 0xffbbbbbb;
      }
      else { signText.color = color; }
      
			txtarr = (radioText.text).split("$");
      radioText.text = txtarr[0] + "$" + (priceArr[1]).toFixed(0);
      if (usr.cash < priceArr[1]) {
        radioText.color = 0xffbbbbbb;        
      }
      else { radioText.color = color; }
      
			txtarr = (tvText.text).split("$");
      tvText.text = txtarr[0] + "$" + (priceArr[2]).toFixed(0);
      if (usr.cash < priceArr[2]) {
        tvText.color = 0xffbbbbbb;        
      }
      else { tvText.color = color; }
      
      txtarr = (speechText.text).split("$");
      speechText.text = txtarr[0] + "$" + (priceArr[3]).toFixed(0);
            if (usr.cash < priceArr[3]) {
        speechText.color = 0xffbbbbbb;        
      }
      else { speechText.color = color; }
      
			super.update();
		
		}
		
    /*
    // Deprecated 
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
    */
	}
}