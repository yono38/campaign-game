package
{
	import org.flixel.*;
  import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	public class CreditState extends FlxState
	{
		private var title:FlxText;
    private var backBtn:FlxButtonPlus;
    [Embed(source = '../gfx/political_pixel_title.png')] private var titlePic:Class;
    

		public function CreditState()
		{
      var background:FlxSprite = new FlxSprite(0, 0);
      background.alpha = 0.35;
      background.loadGraphic(titlePic);
      add(background);
 
			title = new FlxText(20,  25, FlxG.width - 40, "Credits");
			title.color = 0xff000000;
      title.alignment = "center";
			title.size = 55;			
			add(title);

			var createdby:FlxText = new FlxText(20,  115, FlxG.width - 40, "Created By");
			createdby.color = 0xff000000;
      createdby.alignment = "center";
			createdby.size = 35;			
			add(createdby);      

			var me:FlxText = new FlxText(20,  170, FlxG.width - 40, "Jason Schapiro");
			me.color = 0xffff0000;
      me.alignment = "center";
			me.size = 32;			
			add(me);      

			var artby:FlxText = new FlxText(20,  235, FlxG.width - 40, "Including Art By");
			artby.color = 0xff000000;
      artby.alignment = "center";
			artby.size = 35;			
			add(artby);           

			var artists:FlxText = new FlxText(20,  285, FlxG.width - 40, "Kirsten Sugar\nRebecca Hillegass");
			artists.color = 0xff0000ff;
      artists.alignment = "center";
			artists.size = 25;			
			add(artists);           

			var inspire:FlxText = new FlxText(20,  375, FlxG.width - 40, "Pixel Art Inspired By");
			inspire.color = 0xff000000;
      inspire.alignment = "center";
			inspire.size = 35;			
			add(inspire);           

			var inspirers:FlxText = new FlxText(20,  425, FlxG.width - 40, "Pixelpolitics.Tumblr.Com\nPokemon(TM)");
			inspirers.color = 0xffff0000;
      inspirers.alignment = "center";
			inspirers.size = 25;			
			add(inspirers);         

			var thanksTo:FlxText = new FlxText(20,  525, FlxG.width - 40, "Thanks to:");
			thanksTo.color = 0xff000000;
      thanksTo.alignment = "center";
			thanksTo.size = 35;			
			add(thanksTo);           

			var thanked:FlxText = new FlxText(20,  575, FlxG.width - 40, "John Roth, Stanford Medenhall, Kirsten Sugar, Syed Salahuddin, Kaho Abe, Raybit Tang, Akbar, My Family, Becks, and all my Awesome playtesters!");
			thanked.color = 0xff0000ff;
      thanked.alignment = "center";
			thanked.size = 25;			
			add(thanked);         
      
      backBtn = new FlxButtonPlus(FlxG.width / 2 - 100, FlxG.height - 50, goBack, null, "Back", 200, 40);
      backBtn.textNormal.size *= 2;
      backBtn.textHighlight.size *= 2;
      add(backBtn);   
      
			FlxG.mouse.show();
		
		}
    
    private function goBack():void {
      FlxG.switchState(new TitleState());
    }
    
    override public function create():void 
    {
      FlxG.bgColor = 0xFFffffff;
      super.create();
    }
		
		override public function update():void
		{
	/*		if (FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new PlayState());
			} */
			super.update();
		}
	}
}