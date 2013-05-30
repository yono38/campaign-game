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
    public var radioOwned:FlxText;
		public var speechText:FlxText;
    public var speechOwned:FlxText;
		public var tvText:FlxText;
    public var tvOwned:FlxText;
    public var voterText:FlxText;
		
		public var color:uint;
		public var usr:User;
		public var x:uint;
		public var y:uint;
		public var arrowPos:uint;
		public var upKey:String;
		public var downKey:String;
		public var selectKey:String;
    public var priceArr:Array;
    private var flashingArr:Array;
		
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
      
			signText = new FlxText(x + 20, 240, 300, keys[0]+") Sign: $");
			signText.size = 21;
			signText.color = color;
			add(signText);
			
			radioText = new FlxText(x + 20, 300, 300, keys[1]+") Radio: $1000");
			radioText.size = 21;
			radioText.color = color;
			add(radioText);

			radioOwned = new FlxText(x + 20, 325, 300, "");
			radioOwned.size = 21;
			radioOwned.color = 0xff000000;
			add(radioOwned);
      
			tvText = new FlxText(x + 20, 360, 500, keys[2]+") Billboard: $2000");
			tvText.size = 18;
			tvText.color = color;
			add(tvText);

			tvOwned = new FlxText(x + 20, 385, 300, "");
			tvOwned.size = 21;
			tvOwned.color = 0xff000000;
			add(tvOwned);      
			
			speechText = new FlxText(x + 20, 420, 300, keys[3]+ ") Speech: $5000");
			speechText.size = 21;
			speechText.color = color;
			add(speechText);
      
			speechOwned = new FlxText(x + 20, 445, 300, "");
			speechOwned.size = 21;
			speechOwned.color = 0xff000000;
			add(speechOwned);            
      flashingArr = [ false, false, false, false ];
		}
		
		override public function update():void
		{
			cashText.text = "$" + usr.cash.toFixed(2);
      voterText.text = "Voters: " + usr.voters;
			var txtarr:Array = (signText.text).split("$");
      var signPrice:Number = ((50 + 15 * Math.pow(usr.signs, 2)));
      signText.text = txtarr[0] + "$" + signPrice.toFixed(0);
      if (!flashingArr[0]){
        if (usr.cash < signPrice) {
          signText.color = 0xffbbbbbb;
        }
        else { signText.color = color; }
      }
      
			txtarr = (radioText.text).split("$");
      radioText.text = txtarr[0] + "$" + (priceArr[1]).toFixed(0);
      if (!flashingArr[1]) {
   //     trace("modifying radio color for "+headerText.text);
        if (usr.cash < priceArr[1]) {
          radioText.color = 0xffbbbbbb;        
        }
        else { radioText.color = color; }
      }
      
			txtarr = (tvText.text).split("$");
      tvText.text = txtarr[0] + "$" + (priceArr[2]).toFixed(0);
      if (!flashingArr[2]){
        if (usr.cash < priceArr[2]) {
          tvText.color = 0xffbbbbbb;        
        }
        else { tvText.color = color; }
      }
      
      txtarr = (speechText.text).split("$");
      speechText.text = txtarr[0] + "$" + (priceArr[3]).toFixed(0);
      if (!flashingArr[3]){
        if (usr.cash < priceArr[3]) {
          speechText.color = 0xffbbbbbb;        
        }
        else { speechText.color = color; }
      }
			super.update();
		
		}
    
    public function buyFlash(itemName:String):void {
      // chooses which text to affect
      var flashText:FlxText;
      var endFlashIdx:uint;
      switch (itemName) {
        case 'radio':
          flashText = radioText;
          endFlashIdx = 1;
          break;
        case 'tv':
          flashText = tvText;
          endFlashIdx = 2;
          break;
        case 'speech':
          flashText = speechText;
          endFlashIdx = 3;
          break;
        case 'sign':
          flashText = signText;
          endFlashIdx = 0;
          break;
        default:
          return;
      }
      // sets up the timer
      var flashTimer:FlxTimer = new FlxTimer();
      var endFlashTimer:FlxTimer = new FlxTimer();
      flashingArr[endFlashIdx] = true;
      var i:uint = 1;
      flashTimer.start(0.05, 12, function():void { toggleColor(flashText, i++); } );
      endFlashTimer.start(0.7, 1, function():void { flashingArr[endFlashIdx] = false; } );
    }
     
    private function toggleColor(flashText:FlxText, i:uint):void
    {
      if (i%2 == 0) {
        flashText.color = color;
      }
      else {
        flashText.color = 0xFFFFFF00;
      }
    }
		
	}
}