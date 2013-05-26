package Entities 
{
  import org.flixel.FlxBasic;
	/**
   * ...
   * @author Jason Schapiro
   */
  public class User
  {
    public var cash:Number;
    public var isBlue:Boolean;
    public var power:int;
    public var name:String;
    public var signs:uint;
    public var voters:int;
    public var head:Class;
    public var myChar:uint;
    private var names:Array;
    private var heads:Array;
    
    [Embed(source = '../../gfx/chars/reaganHead.png')] public var reaganHeadPic:Class;
    [Embed(source = '../../gfx/chars/dubyaHead.png')] public var dubyaHeadPic:Class;
    [Embed(source = '../../gfx/chars/schwartzeneggerHead.png')] public var schwartzeneggerHeadPic:Class;
    
    [Embed(source = '../../gfx/chars/obamaHead.png')] public var obamaHeadPic:Class;    
    [Embed(source = '../../gfx/chars/clintonHead.png')] public var clintonHeadPic:Class;   
    [Embed(source = '../../gfx/chars/jfkHead.png')] public var jfkHeadPic:Class;   
    
    public function User(char:uint, startCash:uint, colorBlue:Boolean) 
    {
      names = [["Barack Obama", "Bill Clinton", "John F. Kennedy"], ["Ronald Reagan", "The Governator", "George Dubya"]];
      heads = [[obamaHeadPic, clintonHeadPic, jfkHeadPic], [reaganHeadPic, schwartzeneggerHeadPic, dubyaHeadPic]];
      cash = startCash;
      isBlue = colorBlue;
      power = 0;
      voters = 0;
      myChar = char;
      if (colorBlue) {
        name = names[0][char];
        head = heads[0][char];
      }
      else {
        name = names[1][char];
        head = heads[1][char];
      }
      signs = 0;
    }
    
    
    public function update():void
    {
      if (power < 100){
        cash += power * 0.01;
      }
      else if (power < 500) {
        cash += power * 0.005;
      }
      else {
        cash += power * 0.001;
      }
    }
    
  }

}