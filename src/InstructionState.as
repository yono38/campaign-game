package
{
	import org.flixel.*;
	
	public class InstructionState extends FlxState
	{
		public var title:FlxText;
		public var click:FlxText;
    [Embed(source = '../gfx/instruction_screen.png')] private var titlePic:Class;

		public function InstructionState()
		{
      
      var titleImg:FlxSprite = new FlxSprite(0, 0);
    //  titleImg.alpha = 0.35;
      titleImg.loadGraphic(titlePic);
      add(titleImg);
 
			click = new FlxText(20, FlxG.height - 50, FlxG.width - 40, "Click to Start");
			click.color = 0xff000000;
      click.alignment = "center";
			click.size = 25;
			
			add(title);
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
			if (FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new PlayState());
			}
			super.update();
		}
	}
}