package
{
	import org.flixel.*;
	
	public class TitleState extends FlxState
	{
		private var title:FlxText;
    private var subtitle:FlxText;
    private var p1:FlxText;
    private var p2:FlxText;
		private var click:FlxText;
    
    [Embed(source = '../gfx/political_pixel_title.png')] private var titlePic:Class;

    [Embed(source = '../gfx/chars/obamaHead.png')] private var obamaHeadPic:Class;    
    [Embed(source = '../gfx/chars/clintonHead.png')] private var clintonHeadPic:Class;    
    [Embed(source = '../gfx/chars/jfkHead.png')] private var jfkHeadPic:Class;    
    
    [Embed(source = '../gfx/chars/obama.png')] private var obamaBody:Class;
    [Embed(source = '../gfx/chars/clinton.png')] private var clintonBody:Class;
    [Embed(source = '../gfx/chars/jfk.png')] private var jfkBody:Class;
    
    private var demNameList:Array;    
    private var demName:FlxText;
    private var demChar:FlxSprite;
    private var demBg1:FlxSprite;
    private var demBg2:FlxSprite;
    private var demBg3:FlxSprite;    
    private var demBodies:Array;
    private var demHeadBgs:Array;
    private var demState:uint;
    // takes care of locked secret character
    private var demTotal:uint;
    
    [Embed(source = '../gfx/chars/reagan.png')] private var reaganBody:Class;
    [Embed(source = '../gfx/chars/schwartzenegger.png')] private var schwartzeneggerBody:Class;
    [Embed(source = '../gfx/chars/dubya.png')] private var dubyaBody:Class;

    [Embed(source = '../gfx/chars/reaganHead.png')] private var reaganHeadPic:Class;
    [Embed(source = '../gfx/chars/dubyaHead.png')] private var dubyaHeadPic:Class;
    [Embed(source = '../gfx/chars/schwartzeneggerHead.png')] private var schwartzeneggerHeadPic:Class;
    private var repNameList:Array;
    private var repName:FlxText;
    private var repChar:FlxSprite;
    private var repBg1:FlxSprite;
    private var repBg2:FlxSprite;
    private var repBg3:FlxSprite;
    private var repBodies:Array;
    private var repHeadBgs:Array;    
    private var repState:uint;
    private var repTotal:uint;


    
		public function TitleState()
		{
			var txtColor:uint = 0xFF000000;
      
      // Center Area 
      var titleImg:FlxSprite = new FlxSprite(0, 0);
      titleImg.alpha = 0.35;
      titleImg.loadGraphic(titlePic);
      add(titleImg);
      
			title = new FlxText(20, 20, FlxG.width - 40, "The Campaign");
      title.color = txtColor;
			title.alignment = "center";
			title.size = 50;
      
      subtitle = new FlxText(20, FlxG.height - 100, FlxG.width - 40, "You have 60 days to win");
			subtitle.color = txtColor;
      subtitle.alignment = "center";
			subtitle.size = 32;

			var controlsText:FlxText = new FlxText(20, 155, FlxG.width - 40, "Runner Controls");
			controlsText.color = txtColor;
      controlsText.alignment = "center";
			controlsText.size = 40;		      
      add(controlsText);
      
			p1 = new FlxText(20, 220, FlxG.width - 40, "Player 1:                       ");
			p1.color = txtColor;
      p1.alignment = "center";
			p1.size = 35;			
      
    //  var p1ctrl:FlxSprite = new FlxSprite(FlxG.width/2, 300);
    //  p1ctrl.loadGraphic(WASD);
    //  add(p1ctrl);
    
      var WASDkeys:FlxGroup = addKeys(-75);
      add(WASDkeys);
      
      var WASDkeytxt:FlxGroup = addWASDText();
      add(WASDkeytxt);
      
      var Arrowkeys:FlxGroup = addKeys(25);
      add(Arrowkeys);

      var Arrowkeytxt:FlxGroup = addArrowText();
      add(Arrowkeytxt);      
      
			p2 = new FlxText(20, 320, FlxG.width - 40, "Player 2:                       ");
			p2.color = txtColor;
      p2.alignment = "center";
			p2.size = 35;		

    //  var p2ctrl:FlxSprite = new FlxSprite(FlxG.width/2, 400);
    //  p2ctrl.loadGraphic(ArrowKeys);
    //  add(p2ctrl); 
      var runTxt:FlxText = new FlxText(FlxG.width/2-250, FlxG.height - 350, 500, "Run to place signs and convert voters to gain money");
      runTxt.alignment = "center";
      runTxt.color = txtColor;
      runTxt.size = 25;
      add(runTxt);
    
      var numctrl:FlxText = new FlxText(FlxG.width/2-250, FlxG.height - 250, 500, "Use the number keys to purchase items and increase influence over large areas");
      numctrl.alignment = "center";
      numctrl.color = txtColor;
      numctrl.size = 25;
      add(numctrl);
      
			click = new FlxText(20, FlxG.height - 50, FlxG.width - 40, "Click to Continue");
			click.color = txtColor;
      click.alignment = "center";
			click.size = 25;
      // End Center Area
      
      // Character menus
      
      // Republican
      repName = new FlxText(1075, 40, 200, "");
      repName.color = txtColor;
      repName.size = 25;
      add(repName);

      repNameList = ["Reagan", "Dubya", "Governator"];
      repBodies = [reaganBody, dubyaBody, schwartzeneggerBody];
      var repHeads:Array = [reaganHeadPic, dubyaHeadPic, schwartzeneggerHeadPic];
      repHeadBgs = [repBg1, repBg2, repBg3];
      var i:uint;
      repTotal = (FlxG["repUnlocked"]) ? 3 : 2;
      for (i = 0; i < repTotal; i++) {
        // sets up menu choices
        repHeadBgs[i] = new FlxSprite(FlxG.width - 177, 80 + i * 200 );
        repHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);
        var repHeadPic:FlxSprite = new FlxSprite(FlxG.width - 177, 80 + i * 200 );
        repHeadPic.loadGraphic(repHeads[i]);
        add(repHeadBgs[i]);
        add(repHeadPic);
      }
      // holds unknown box
      if (!FlxG["repUnlocked"]) {
        repHeadBgs[repTotal] = new FlxSprite(FlxG.width - 177, 480 );
        repHeadBgs[repTotal].makeGraphic(127, 127, 0xff000000);
        add(repHeadBgs[repTotal]);
        var repUnknown:FlxText = new FlxText(FlxG.width - 155, 470, 500, "?");
        repUnknown.size = 400;
        add(repUnknown);
      }
      // holds full body image
      repChar = new FlxSprite(1075, 80);
      add(repChar);
      
      // Democrat
      demName = new FlxText(200, 40, 200, "");
      demName.color = txtColor;
      demName.size = 25;
      add(demName);
      
      demNameList = ["Obama", "Clinton", "JFK"]
      demBodies = [obamaBody, clintonBody, jfkBody];
      var demHeads:Array = [obamaHeadPic, clintonHeadPic, jfkHeadPic];
      demHeadBgs = [demBg1, demBg2, demBg3];
      demTotal = (FlxG["demUnlocked"]) ? 3 : 2;
      for (i = 0; i < demTotal; i++) {
        demHeadBgs[i] = new FlxSprite(50, 80 + i * 200 );
        demHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);
        var demHeadPic:FlxSprite = new FlxSprite(50, 80 + i * 200 );
        demHeadPic.loadGraphic(demHeads[i]);
        add(demHeadBgs[i]);
        add(demHeadPic);
      }
      if (!FlxG["demUnlocked"]) {
        demHeadBgs[demTotal] = new FlxSprite(50, 480 );
        demHeadBgs[demTotal].makeGraphic(127, 127, 0xff000000);
        add(demHeadBgs[demTotal]);
        var demUnknown:FlxText = new FlxText(75, 470, 500, "?");
        demUnknown.size = 400;
        add(demUnknown);
      }      
      demChar = new FlxSprite(200, 80);
      add(demChar);
      
      // keep old players if already set
      if (FlxG["players"] != null) {
        demState = FlxG["players"][0];
        repState = FlxG["players"][1];
      }
      else { // set to default players
        // [dem, rep]
        trace("FlxG['players'] is null");
        FlxG["players"] = [0, 0];
        demState = 0;
        repState = 0;      
      }
      // does the real work for setting up the selection menus
      // based on demState/repState variables
      setDemState();
      setRepState();

			add(title);
      add(subtitle);
      add(p1);
      add(p2);
			add(click);
			FlxG.mouse.show();
		}
    
    override public function create():void 
    {
      FlxG.bgColor = 0xFFffffff;
      super.create();
    }
		
		override public function update():void
		{
      // right menu
      if (FlxG.keys.justPressed("DOWN") && repState < repTotal-1) {
        // move down
        repState++;
        setRepState();
      }
      else if (FlxG.keys.justPressed("UP") && repState > 0) {
        // move up
        repState--;
        setRepState();
      }
      
      // left menu
      if (FlxG.keys.justPressed("S") && demState < demTotal-1) {
        // move down
        demState++;
        setDemState();
      }
      else if (FlxG.keys.justPressed("W") && demState > 0) {
        // move up
        demState--;
        setDemState();
      }
      
			if (FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new PlayState());
			}
			super.update();
		}
    
    protected function setRepState():void {
      var i:uint;
      for (i = 0; i < repTotal;i++){
        if (i == repState) { repHeadBgs[i].makeGraphic(127, 127, 0xbbff0000); }
        else {repHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);}
      }
      repChar.loadGraphic(repBodies[repState]);
      repName.text = repNameList[repState];
      FlxG["players"][1] = repState;
    }
    
    protected function setDemState():void {
      var i:uint;
      for (i = 0; i < demTotal;i++){
        if (i == demState) { demHeadBgs[i].makeGraphic(127, 127, 0xbb0000ff); }
        else {demHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);}
      }
      demName.text = demNameList[demState];      
      demChar.loadGraphic(demBodies[demState]);
      FlxG["players"][0] = demState;
    }
    
    protected function addKeys(ypos:int):FlxGroup {
      var myKeys:FlxGroup = new FlxGroup();     
      var topSquare:FlxSprite = new FlxSprite(785, 300+ypos);
      topSquare.makeGraphic(50, 50, 0xff000000);
      myKeys.add(topSquare);
      var btmleft:FlxSprite = new FlxSprite(740, 352+ypos);
      btmleft.makeGraphic(43, 43, 0xff000000);
      myKeys.add(btmleft);
      var btmctr:FlxSprite = new FlxSprite(785, 352+ypos);
      btmctr.makeGraphic(43, 43, 0xff000000);
      myKeys.add(btmctr);
      var btmrght:FlxSprite = new FlxSprite(830, 352+ypos);
      btmrght.makeGraphic(43, 43, 0xff000000);
      myKeys.add(btmrght); 
      return myKeys;
    }
    
    protected function addWASDText():FlxGroup {
      var WASDtxt:FlxGroup = new FlxGroup();
      var Wkey:FlxText = new FlxText(790, 225, 50, "W");
      Wkey.color = 0xffffffff;
      Wkey.size = 35;
      WASDtxt.add(Wkey);
      var Akey:FlxText = new FlxText(745, 278, 50, "A");
      Akey.color = 0xffffffff;
      Akey.size = 35;
      WASDtxt.add(Akey);
      var Skey:FlxText = new FlxText(795, 278, 50, "S");
      Skey.color = 0xffffffff;
      Skey.size = 35;
      WASDtxt.add(Skey); 
      var Dkey:FlxText = new FlxText(835, 278, 50, "D");
      Dkey.color = 0xffffffff;
      Dkey.size = 35;
      WASDtxt.add(Dkey);      
      return WASDtxt;
    }
    
    protected function addArrowText():FlxGroup {
      var Arrowtxt:FlxGroup = new FlxGroup();
      var Upkey:FlxText = new FlxText(795, 325, 50, "^");
      Upkey.color = 0xffffffff;
      Upkey.size = 65;
      Arrowtxt.add(Upkey);
      var Leftkey:FlxText = new FlxText(745, 378, 50, "<");
      Leftkey.color = 0xffffffff;
      Leftkey.size = 35;
      Arrowtxt.add(Leftkey);
      var Downkey:FlxText = new FlxText(790, 378, 50, "V");
      Downkey.color = 0xffffffff;
      Downkey.size = 35;
      Arrowtxt.add(Downkey); 
      var Rightkey:FlxText = new FlxText(835, 378, 50, ">");
      Rightkey.color = 0xffffffff;
      Rightkey.size = 35;
      Arrowtxt.add(Rightkey);      
      return Arrowtxt;
    }    
    
	}
}