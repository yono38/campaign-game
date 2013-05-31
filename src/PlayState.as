/*
 *  FlxG.timeScale can change in-game speed!
 */

package
{
  import Entities.*;
  import Items.Radio;
  import Items.Sign;
  import Items.Speech;
  import Items.TV;
	import org.flixel.*;  
	
	public class PlayState extends FlxState
	{
    
    [Embed(source = '../gfx/townMap_new.png')] private var town:Class; 
    
		public var peds:FlxGroup;
    // buildings == anything that's not the pedestrian path
    private var buildings:FlxGroup;
    private var fields:FlxGroup;
    private var signs:FlxGroup;
    private var radios:FlxGroup;    
    private var convos:FlxGroup;
    // includes helper methods for placing dots
    private var legend:Legend;
    // users contain stats, menus for UI
    public var P1:User;
    protected var P1menu:Menu;
    public var P2:User;
    protected var P2menu:Menu;
    public var P1Runner:Runner;
    public var P2Runner:Runner;

    // used to determine default prices for items
    public var prices:Array;
    // static items
    public var myTV:TV;
    public var mySpeech:Speech;
    // purchase areas
    public var buyRadioTxt:FlxText;
    public var radioBuyArea:FlxSprite;
    public var buyTvTxt:FlxText;
    public var tvBuyArea:FlxSprite;
    public var buySpeechTxt:FlxText;
    public var speechBuyArea:FlxSprite;    
    // lists day on screen
    public var currDay:FlxText;
    // keeps track of current game day
    public var currDayInt:uint;
    // tracks start of game
    public var startTime:uint;
    // spaces events out evenly
    private var lastEventDay:uint;
    // bottom bar
    public var progressBar:FlxSprite;
    // used to fade on gameover
    public var endgameFade:FlxSprite;
    private var gameOverTime:Boolean;
    
    private var startLbl:StartLabels;
    
    private var countdownBckgrd:FlxSprite;
    private var countdownText:FlxText;
    
    private var countdown:Boolean;
    
    private function randomNumber(low:Number=0, high:Number=1):Number {
      return Math.floor(Math.random() * (1+high-low)) + low;
    }
    
		override public function create():void
		{
      //Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
      var i:int;
      prices = [5, 1000, 2000, 5000];
  //    prices = [5, 10, 20, 50]; // test
      startTime = FlxU.getTicks();
      currDayInt = 0;
      gameOverTime = false;

      // this group is our collision stuff for pedestrians 
      // buildings == anything that's not the pedestrian path
      buildings = new FlxGroup();
      // setting them up manually, will move this to a seperate class if I'm smart
      // center blocks
      makeBlock(360, 58, 301, 122);
      makeBlock(706, 58, 167, 135);
      makeBlock(909, 58, 209, 135);
      makeBlock(708, 229, 410, 134);
      makeBlock(616, 400, 320, 133);
      makeBlock(386, 560, 293, 109);
      makeBlock(774, 562, 137, 71);
      makeBlock(465, 448, 43, 44);
      makeBlock(569, 674, 520, 100);      
      
      // left side
      makeBlock(0, 0, 1500, 21);
      makeBlock(0, 23, 315, 189);
      makeBlock(0, 209, 660, 154);
      makeBlock(0, 365, 581, 43);
      makeBlock(0, 409, 350, 329);
      makeBlock(0, 735, 743, 53);
      
      // right side
      makeBlock(1158, 24, 342, 378);
      makeBlock(964, 400, 534, 132);
      makeBlock(1096, 536, 412, 36);
      makeBlock(974, 558, 742, 90);
      makeBlock(1114, 652, 390, 112); 
      makeBlock(748,746, 754, 50);      

      add(buildings);
      
      var townMap:FlxSprite = new FlxSprite();
      townMap.loadGraphic(town);
      add(townMap);
      
      fields = new FlxGroup();
      signs = new FlxGroup();
      radios = new FlxGroup();
      
      // Set up radios
      var myRadio:Radio = new Radio(704, 590);
      add(myRadio);
      fields.add(myRadio.field);
      radios.add(myRadio);
      
      var myRadio2:Radio = new Radio(700, 185);
      add(myRadio2);
      fields.add(myRadio2.field);
      radios.add(myRadio2);
      
      var myRadio3:Radio = new Radio(930, 360);
      add(myRadio3);      
      fields.add(myRadio3.field);
      radios.add(myRadio3);  
      
      var myRadio4:Radio = new Radio(314, 31);
      add(myRadio4);      
      fields.add(myRadio4.field);  
      radios.add(myRadio4);      
      
      radioBuyArea = new FlxSprite(1135, 350);
      radioBuyArea.makeGraphic(30, 30, 0x77333333);
      add(radioBuyArea);
      
      buyRadioTxt = new FlxText(1160, 380, 400, "");
      buyRadioTxt.color = 0xffffff00;
      buyRadioTxt.size = 20;
      add(buyRadioTxt);
      
     // Set up TV
      myTV = new TV(309, 614);
      fields.add(myTV.field);
      add(myTV.field);
      add(myTV.tvSprite);

      tvBuyArea = new FlxSprite(350, 620);
      tvBuyArea.makeGraphic(30, 30, 0x77333333);
      add(tvBuyArea);
      
      buyTvTxt = new FlxText(280, 575, 400, "");
      buyTvTxt.color = 0xffffff00;
      buyTvTxt.size = 20;
      add(buyTvTxt);
      
      // Set up Speech
      mySpeech = new Speech(350, 350);
      fields.add(mySpeech.field);     
      add(mySpeech);
      
      speechBuyArea = new FlxSprite(345, 405);
      speechBuyArea.makeGraphic(30, 30, 0x77333333);
      add(speechBuyArea);
      
      buySpeechTxt = new FlxText(340, 380, 400, "");
      buySpeechTxt.color = 0xffffff00;
      buySpeechTxt.size = 20;
      add(buySpeechTxt);
      
      // set up pedestrians
      peds = new FlxGroup();
      for (i = 0; i < 200; i++) {
        var nPed:FlxSprite = new Pedestrian(randomNumber(300,1200), randomNumber(0, FlxG.height));
        peds.add(nPed);
      }
      peds.exists = false;
      add(peds);
      
      // used for storing convos
      convos = new FlxGroup();
      
      // these hold user attributes
      P1 = new User(FlxG["players"][0], 200, true);
      P2 = new User(FlxG["players"][1], 200, false);
      trace("Players in Playstate");
      trace(FlxG["players"]);
      // this is basic HUD
      P1menu = new Menu(P1, true, prices);
      add(P1menu);
      P2menu = new Menu(P2, false, prices);
      add(P2menu);
      
      // runner test
      P1Runner = new Runner(655, 200, P1);
      add(P1Runner);
      P2Runner = new Runner(680, 185, P2);
      add(P2Runner);  
      
      progressBar = new FlxSprite(735, 735); // range from 335 to 1135      
      progressBar.makeGraphic(20, 50, 0xff000000);
      add(progressBar);
      var leftHead:FlxSprite = new FlxSprite(210, 695);
      leftHead.loadGraphic(P1.head);
      leftHead.scale.x = 0.35;
      leftHead.scale.y = 0.35;
      add(leftHead);
      var rightHead:FlxSprite = new FlxSprite(1170, 695);
      rightHead.loadGraphic(P2.head);
      rightHead.scale.x = 0.35;
      rightHead.scale.y = 0.35;
      add(rightHead);
      
      
      legend = new Legend();
      add(legend);
      
      var dayBkgrd:FlxSprite = new FlxSprite(675, 675);
      dayBkgrd.makeGraphic(150, 50, 0xffbbbbbb);
      add(dayBkgrd);      
      
      currDay = new FlxText(690, 680, 400, "Day 0");
      currDay.size = 30;
      currDay.color = 0xff000000;
      add(currDay);
      
      endgameFade = new FlxSprite(270, 0);
      
      // test start labels
      startLbl = new StartLabels();
      add(startLbl);
      
      countdown = true;
      startCountdown();
		}

    // equivalent to draw() function in processing
		override public function update():void
		{
      if (countdown) {
        return;
      }
      peds.exists = true;
     
      // stops peds from hanging out at buildings
      FlxG.collide(peds, buildings, changeDir);
      
      // respawn peds if they start in a building
      FlxG.overlap(peds, buildings, respawn);

      // makes influence fields work
      FlxG.overlap(peds, fields, underTheInfluence);
      
      // activates conversations
      FlxG.overlap(peds, peds, convo);
      
      FlxG.collide(P1Runner, buildings);
      FlxG.collide(P2Runner, buildings);

      
      // don't start game until countdown!
      
      // Player 1 Purchases
      // Sign
      if (FlxG.keys.justPressed("ONE")) {
        if (P1.cash >= prices[0] + (15 * Math.pow(P1.signs, 2))) {
          var newSign:Sign = new Sign(P1Runner.x, P1Runner.y, true);				
          signs.add(newSign);
          fields.add(newSign);
          add(newSign);
          newSign.legendSprite = legend.purchasedSign(newSign.x, newSign.y, newSign.isBlue);
          add(newSign.legendSprite);
          P1.cash -= prices[0] + (15 * Math.pow(P1.signs, 2));
          P1.signs++;
          P1menu.buyFlash('sign');
        }
      }
      // Radio
      buyRadioTxt.text = "";
      FlxG.overlap(P1Runner, radioBuyArea, buyRadio);

      // TV
      buyTvTxt.text = "";
      FlxG.overlap(P1Runner, tvBuyArea, buyTv);
      
      // reset speeching for next turn
      mySpeech.speechingNow = false;
      
      // Speech
      buySpeechTxt.text = "";
      FlxG.overlap(P1Runner, speechBuyArea, buySpeech);
      FlxG.overlap(P1Runner, speechBuyArea, mySpeech.speeching);

      
      // Player 2 Purchases
       // Sign
      if (FlxG.keys.justPressed("SEVEN")) {
        if (P2.cash >= prices[0] + (15 * Math.pow(P2.signs, 2))) {
          var newSign:Sign = new Sign(P2Runner.x, P2Runner.y, false);				
          signs.add(newSign);
          fields.add(newSign);
          add(newSign);
          newSign.legendSprite = legend.purchasedSign(newSign.x, newSign.y, newSign.isBlue);
          add(newSign.legendSprite);
          P2menu.buyFlash('sign');
          P2.cash -= prices[0] + (15 * Math.pow(P2.signs, 2));
          P2.signs++;
        }
      }
      // Radio
      FlxG.overlap(P2Runner, radioBuyArea, buyRadio);
      
      // TV
      FlxG.overlap(P2Runner, tvBuyArea, buyTv);

      // Speech
      FlxG.overlap(P2Runner, speechBuyArea, buySpeech);
      FlxG.overlap(P2Runner, speechBuyArea, mySpeech.speeching);
          
      
      // Move to next day
      currDayInt = Math.floor((FlxU.getTicks() - startTime) / 4000);
      if (currDayInt <= 60) {

      // spawn random events
      if (currDayInt%13 == 0) {
     //   if (currDayInt == 7 || currDayInt == 3 || currDayInt == 5){ // testing
          var chance:Number = Math.random();
          if (chance <= 0.005 && lastEventDay != currDayInt) {
            // choose event type
            var evtType:uint = randomNumber(0, 3);
            // choose affected player
            var evtUsr:User;
            var plyChance:Number = Math.random();
            // try to give bad outcomes to player in the lead
            if (P1.voters > P2.voters * 1.25 && evtType != 3) {
              evtUsr = (plyChance < 0.75) ? P1 : P2;
            }
            else if (P2.voters > P1.voters * 1.25 && evtType != 3) {
              evtUsr = (plyChance < 0.75) ? P2 : P1;              
            }
            else {
              evtUsr = (plyChance < 0.5) ? P1 : P2; 
            }
            var affectP1:Boolean = (plyChance < 0.5) ? true : false;
            var newEvt:GameEvent = new GameEvent(evtType, evtUsr);
            var changeTotal:uint;
            lastEventDay = currDayInt;
            add(newEvt);
            switch (evtType) {
              case 0:
                changeTotal = Math.floor(evtUsr.voters * 0.25);
                trace("Tax Fraud");
                trace("Before: " + evtUsr.voters);
                changeInfluence(false, affectP1, changeTotal);
                trace("After: " + evtUsr.voters);   
                break;
              case 1:
                changeTotal = Math.floor(evtUsr.voters * 0.25);
                trace("Viral Video");
                trace("Before: "+evtUsr.voters);
                changeInfluence(true, affectP1, changeTotal);
                trace("After: "+evtUsr.voters);
                break; 
              case 2:
                changeTotal = Math.floor(evtUsr.voters * 0.2);
                trace("Sex Scandal");
                trace("Before: "+evtUsr.voters);
                changeInfluence(false, affectP1, changeTotal);
                changeInfluence(true, !affectP1, changeTotal);
                trace("After: " + evtUsr.voters);
                break; 
              case 3: 
                changeTotal = Math.floor(evtUsr.voters * 0.1);
                trace("Bar Fight");
                trace("Before: " + evtUsr.voters);
                changeInfluence(false, affectP1, changeTotal);
                trace("After: " + evtUsr.voters);
                break;
              default:
                break;
            }
          }
        }
        
        //Updates all non-flixel objects manually
        P1.update();
        P2.update();
        
        // Voter influence bar
        // 900 movement - 400 each direction
        // voters range from -200 to 200 
        progressBar.x = ((P2.voters - P1.voters) * 2) + 735;
        currDay.text = "Day " + currDayInt;
        super.update();
      }
      
      // set up gameover screen    
      else if (!gameOverTime) {     
        endgameFade.makeGraphic(960, 727, 0x77000000);
        add(endgameFade);
        var gameOver:FlxText;
        var restartTxt:FlxText;
        var newCharTxt:FlxText;
        if (P1.voters > P2.voters) {
          gameOver = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2 - 30, 700, P1.name+" Wins!");
          gameOver.color = 0xff0000ff;
          if (FlxG["demUnlocked"] == false) {
            newCharTxt = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2 + 30, 500, "New Character Unlocked: JFK");
            newCharTxt.color = 0xff0000ff;
            newCharTxt.size = 30;
            add(newCharTxt);
          }          
          FlxG["demUnlocked"] = true;
        }
        else {
          gameOver = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2 - 30, 700, P2.name+" Wins!");
          gameOver.color = 0xffff0000;
          if (FlxG["repUnlocked"] == false) {
            newCharTxt = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2 + 30, 500, "New Character Unlocked: The Governator");
            newCharTxt.color = 0xffff0000;
            newCharTxt.size = 30;
            add(newCharTxt);
          }
          FlxG["repUnlocked"] = true;
        }
        restartTxt = new FlxText(FlxG.width / 2 - 250, FlxG.height / 2 + 120, 500, "Click to Play Again");
        restartTxt.size = 30;
        add(restartTxt);
        gameOver.size = 40;
        add(gameOver);
        FlxG.mouse.show();
        gameOverTime = true;
      }
      else { // check for restart
        if (FlxG.mouse.justPressed())
        {
          FlxG.switchState(new TitleState());
        }
      }
		}
    
    public function createBuild(X:Number, Y:Number, img:Class):void {
      var build:FlxSprite = new FlxSprite(X, Y);
      build.loadGraphic(img);
      build.immovable = true;
      buildings.add(build);
    }
    
    public function makeBlock(X:Number, Y:Number, wid:uint, h:uint):void {
      var block:FlxSprite = new FlxSprite(X, Y);
      block.makeGraphic(wid, h);
      block.immovable = true;
      buildings.add(block);
    }
    
    // change many voters' influence at one time
    public function changeInfluence(isPositive:Boolean, affectP1:Boolean, numChange:uint):void {
      // set up function
      var changed:uint = 0;
      var plrCount:uint = 0;
      var tmpPed:Pedestrian;
      
      // loop through pedestrians until sufficient number changed
      while (changed < numChange && plrCount<200) {
        tmpPed = peds.members[plrCount];
        if (affectP1) {
          if (isPositive && tmpPed.influenced<9) {
            tmpPed.influenced = 10;
            tmpPed.setBlue(true);
            changed++;
            P1.voters++
          }
          else if (!isPositive && tmpPed.influenced > 9) {
            tmpPed.influenced = 0;
            tmpPed.setNormal();
            changed++;
            P1.voters--;            
          }
        }
        else { // affects P2
          if (isPositive && tmpPed.influenced> -9) {
            tmpPed.influenced = -10;
            tmpPed.setBlue(false);
            changed++;
            P2.voters++
          }
          else if (!isPositive && tmpPed.influenced < -9) {
            tmpPed.influenced = 0;
            tmpPed.setNormal();
            changed++;
            P2.voters--;            
          }          
        }
        plrCount++; // always increment pedestrian member count
      }    
    }
    
    public function underTheInfluence(ped:Pedestrian, myField:InfluenceField):void {
      var chance:Number = Math.random();
      if (chance <= myField.influence) {
     //   trace(ped.x+", "+ped.y);
    //    trace(changeDir);
        // got em!
        var strongInf:Boolean;
        if (myField.isBlue && ped.influenced < 20) {
          // at extremes, harder to influence
          if (ped.influenced <= -15 || ped.influenced >= 14) {
            chance = Math.random();
            if (chance <= 0.33) {
              // 33% chance of being influenced
              ped.influenced++;
            }
          }
          // easier to influence if leaning
          else {
            ped.influenced++;
          }
          // update voter counts
          if (ped.influenced == 10) P1.voters++;
          else if (ped.influenced == -9) P2.voters--;  
          
          // draw sprite
          if (ped.influenced >= 10) {
            strongInf = (ped.influenced >= 15) ? true : false;
            ped.setBlue(strongInf);
            P1.power++;
          }
        }
        else if (!myField.isBlue && ped.influenced > -20) {
          if (ped.influenced <= -14 || ped.influenced >= 15) {
            chance = Math.random();
            if (chance <= 0.33) {
              // 33% chance of being influenced
              ped.influenced--; 
            }
          }
          else {
            ped.influenced--;
          }
          
          if (ped.influenced == -10) P2.voters++;
          else if (ped.influenced == 9) P1.voters--;
          
          if (ped.influenced <= -10) {
            strongInf = (ped.influenced <= -15) ? true : false;
            ped.setRed(strongInf);
            P2.power++;
          }          
        }
        if (ped.influenced > -10 && ped.influenced < 10) {
          ped.setNormal();
        }
      }
    }
    
    public function respawnSign(respawner:Sign, build:FlxObject):void {
      respawn(respawner, build);
   //   if (respawner.legendSprite){
      respawner.legendSprite.x = ((respawner.x  - 274) * 0.23) + 22;;
      respawner.legendSprite.y = (respawner.y * 0.23) + 587; ;
   //   }
    }
    
    public function respawn(respawner:FlxObject, build:FlxObject):void {
      respawner.x = randomNumber(300, 1200);
      respawner.y = randomNumber(0, FlxG.height - 50);
    }
    
    public function convo(ped1:Pedestrian, ped2:Pedestrian):void {
      var CONVO_PROBABILITY:Number = 0.00005;
      var chance:Number = Math.random();
      if (chance <= CONVO_PROBABILITY) {
        var newConvo:Conversation;
        if (ped1.influenced > 10) {
          if (ped2.influenced < -10) {
            newConvo = new Conversation(ped1.x, ped1.y, "Fuck you!");            
          }
          else {
            newConvo = new Conversation(ped1.x, ped1.y, "Vote Blue!");
          }
        }
        else if (ped1.influenced < -10) {
          if (ped2.influenced > 10) {
            newConvo = new Conversation(ped1.x, ped1.y, "Fuck you!");            
          }
          newConvo = new Conversation(ped1.x, ped1.y, "Vote Red!");
        }
        else {
          var txtType:uint = randomNumber(0, 2);
          if (txtType == 0) newConvo = new Conversation(ped1.x, ped1.y, "Hi");          
          else if (txtType == 1) newConvo = new Conversation(ped1.x, ped1.y, "Hello");  
          else newConvo = new Conversation(ped1.x, ped1.y, "Good day!");          


        }
        add(newConvo);
      }
      if (!gameOverTime && chance <= (CONVO_PROBABILITY * 10)) { // grassroots by the extremes on those leaning
        if (ped1.influenced <= -15 && (ped2.influenced >  -15 && ped2.influenced < 15)) {
          ped2.influenced--;
        }
        else if (ped1.influenced >= 15 && (ped2.influenced >  -15 && ped2.influenced < 15)) {
          ped2.influenced++;
        }
      }
    }
    
    public function buyRadio(runner:Runner, area:FlxSprite):void {
      buyRadioTxt.text = "Buy!";
      if (runner.user.isBlue && FlxG.keys.justPressed("TWO") && P1.cash >= prices[1]) {
        P1.cash -= prices[1];
        prices[1] *= 1.5;              
        for (var i:int = 0; i < 4; i++) {
          radios.members[i].purchase(true)
        }
        legend.purchased("radio", true);  
        P1menu.buyFlash('radio');
        P1menu.radioOwned.text = "Owned";
        P2menu.radioOwned.text = "";
        
      }
      else if (!runner.user.isBlue && FlxG.keys.justPressed("EIGHT") && P2.cash >= prices[1]) {
        P2.cash -= prices[1];
        prices[1] *= 1.5;              
        for (var i:int = 0; i < 4; i++) {
          radios.members[i].purchase(false);
        }
        legend.purchased("radio", false);                            
        P2menu.buyFlash('radio');
        P2menu.radioOwned.text = "Owned";
        P1menu.radioOwned.text = "";          
      }
      
    }
    
    public function buyTv(runner:Runner, area:FlxSprite):void {
      buyTvTxt.text = "Buy!";
      if (runner.user.isBlue && FlxG.keys.justPressed("THREE") && P1.cash >= prices[2]) {
          myTV.purchase(true);
          legend.purchased("tv", true);   
          P1menu.buyFlash('tv');
          P1.cash -= prices[2];
          prices[2] *= 1.5;  
          P1menu.tvOwned.text = "Owned";
          P2menu.tvOwned.text = "";          
      }
      else if (!runner.user.isBlue && FlxG.keys.justPressed("NINE") && P2.cash >= prices[2]) {
        myTV.purchase(false);
        legend.purchased("tv", false);                            
        P2.cash -= prices[2];
        prices[2] *= 1.5;  
        P2menu.tvOwned.text = "Owned";
        P1menu.tvOwned.text = "";   
        P2menu.buyFlash('tv');
      }
    }

    public function buySpeech(runner:Runner, area:FlxSprite):void {
      buySpeechTxt.text = "Speech!";
      if (runner.user.isBlue && FlxG.keys.justPressed("FOUR") && P1.cash >= prices[3]) {
        P1.cash -= prices[3];
        prices[3] *= 1.5;              
        mySpeech.purchase(true);
        legend.purchased("speech", true);
        P1menu.buyFlash('speech');
        P1menu.speechOwned.text = "Owned";
        P2menu.speechOwned.text = "";   
      }
      else if (!runner.user.isBlue && FlxG.keys.justPressed("ZERO") && P2.cash >= prices[3]) {
        P2.cash -= prices[3];
        prices[3] *= 1.5;              
        mySpeech.purchase(false);
        legend.purchased("speech", false);
        P2menu.buyFlash('speech');
        P2menu.speechOwned.text = "Owned";
        P1menu.speechOwned.text = "";            
      }
    }
    
    
    public function changeDir(ped1:Pedestrian, build:FlxObject):void {
      ped1.changeDir();
    }
    
    
    public function startCountdown():void {
            // sets up the timer
      var flashTimer:FlxTimer = new FlxTimer();
      countdownBckgrd = new FlxSprite(FlxG.width/2 - 300, 25);
      countdownBckgrd.makeGraphic(600, 70, 0xFFbbbbbb);
      add(countdownBckgrd);
      
      countdownText = new FlxText(FlxG.width/2 - 275, 30, FlxG.width/2, "Starting in 3...");
      countdownText.size = 40;
      add(countdownText);
      
      var i:uint = 1;
      flashTimer.start(1, 4, function():void { runCountdown(i++); } );
    }
     
    private function runCountdown(i:uint):void
    {
      
      if (i == 1) {
        countdownText.text = "Starting in 3...2...";
      }
      else if (i==2) {
        countdownText.text = "Starting in 3...2...1...";
        }
      else if (i == 3) {
        countdownText.text = "Starting in 3...2...1...Go!";
        countdown = false;
        startLbl.fadeAndDie();
        startTime = FlxU.getTicks();
      }
      else if (i == 4) {
        countdownBckgrd.kill();
        countdownText.kill();
      }
    }
    
    
	}

}