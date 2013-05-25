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
    
    public function User(nme:String, startCash:uint, colorBlue:Boolean) 
    {
      cash = startCash;
      isBlue = colorBlue;
      power = 0;
      voters = 0;
      name = nme;
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