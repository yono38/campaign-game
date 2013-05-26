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
    
    [Embed(source = '../gfx/chars/obama.png')] private var obamaBody:Class;
    [Embed(source = '../gfx/chars/clinton.png')] private var clintonBody:Class;
    private var demNameList:Array;    
    private var demName:FlxText;
    private var demChar:FlxSprite;
    private var demBg1:FlxSprite;
    private var demBg2:FlxSprite;
    private var demBodies:Array;
    private var demHeadBgs:Array;
    private var demState:uint;
    
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
			title.size = 40;
      
      subtitle = new FlxText(20, FlxG.height - 100, FlxG.width - 40, "You have 60 days to win");
			subtitle.color = txtColor;
      subtitle.alignment = "center";
			subtitle.size = 32;

			p1 = new FlxText(20, 500, FlxG.width - 40, "Player 1: UP/DOWN/RIGHT");
			p1.color = txtColor;
      p1.alignment = "center";
			p1.size = 35;			
      
			p2 = new FlxText(20, 560, FlxG.width - 40, "Player 2: W/S/D");
			p2.color = txtColor;
      p2.alignment = "center";
			p2.size = 35;		
      
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

      repNameList = ["Reagan", "Governator", "Dubya"];
      repBodies = [reaganBody, schwartzeneggerBody, dubyaBody];
      var repHeads:Array = [reaganHeadPic, schwartzeneggerHeadPic, dubyaHeadPic];
      repHeadBgs = [repBg1, repBg2, repBg3];
      var i:uint;
      for (i = 0; i < 3; i++) {
        // sets up menu choices
        repHeadBgs[i] = new FlxSprite(FlxG.width - 177, 80 + i * 200 );
        repHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);
        var repHeadPic:FlxSprite = new FlxSprite(FlxG.width - 177, 80 + i * 200 );
        repHeadPic.loadGraphic(repHeads[i]);
        add(repHeadBgs[i]);
        add(repHeadPic);
      }
      // holds full body image
      repChar = new FlxSprite(1075, 80);
      add(repChar);
      
      // Democrat
      demName = new FlxText(200, 40, 200, "");
      demName.color = txtColor;
      demName.size = 25;
      add(demName);
      
      demNameList = ["Obama", "Clinton"]
      demBodies = [obamaBody, clintonBody];
      var demHeads:Array = [obamaHeadPic, clintonHeadPic];
      demHeadBgs = [demBg1, demBg2];
      for (i = 0; i < 2; i++) {
        demHeadBgs[i] = new FlxSprite(50, 80 + i * 200 );
        demHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);
        var demHeadPic:FlxSprite = new FlxSprite(50, 80 + i * 200 );
        demHeadPic.loadGraphic(demHeads[i]);
        add(demHeadBgs[i]);
        add(demHeadPic);
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
      if (FlxG.keys.justPressed("DOWN") && repState < 2) {
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
      if (FlxG.keys.justPressed("S") && demState < 1) {
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
				FlxG.switchState(new InstructionState());
			}
			super.update();
		}
    
    protected function setRepState():void {
      var i:uint;
      for (i = 0; i < repHeadBgs.length;i++){
        if (i == repState) { repHeadBgs[i].makeGraphic(127, 127, 0xbbff0000); }
        else {repHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);}
      }
      repChar.loadGraphic(repBodies[repState]);
      repName.text = repNameList[repState];
      FlxG["players"][1] = repState;
    }
    
    protected function setDemState():void {
      var i:uint;
      for (i = 0; i < demHeadBgs.length;i++){
        if (i == demState) { demHeadBgs[i].makeGraphic(127, 127, 0xbb0000ff); }
        else {demHeadBgs[i].makeGraphic(127, 127, 0xffbbbbbb);}
      }
      demName.text = demNameList[demState];      
      demChar.loadGraphic(demBodies[demState]);
      FlxG["players"][0] = demState;
    }    
	}
}