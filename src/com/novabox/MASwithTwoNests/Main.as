package com.novabox.MASwithTwoNests
{
	import com.novabox.expertSystem.ExpertSystem;
	import com.novabox.expertSystem.Rule;
	import com.novabox.expertSystem.Fact;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	
	import fl.events.ComponentEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class Main extends Sprite 
	{
		public static var world:World;
		
		protected var paused:Boolean;		
		protected var startFromHome:CheckBox;
		protected var homeGettingBigger:CheckBox;
		protected var pauseButton:Button;
		protected var restartButton:Button;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			InitializeUI();			
		}
		
		private function init(e:Event = null):void 
		{
			paused = false;
			if (pauseButton)
			{
				pauseButton.label = "Pause";
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			world = new World();
			
			stage.addChild(world);
		
			world.Initialize();
			
			stage.addEventListener(Event.ENTER_FRAME, Update);
			
		}
		
		private function InitializeUI() : void
		{
			startFromHome = new CheckBox();
			startFromHome.label = "Start from home";
			startFromHome.width = 200;
			startFromHome.x = 610;
			startFromHome.y = 0;
			addChild(startFromHome);
			startFromHome.addEventListener(MouseEvent.CLICK, SwitchStartFromHome);
			
			homeGettingBigger = new CheckBox();
			homeGettingBigger.label = "Home expansion";
			homeGettingBigger.selected = true;
			homeGettingBigger.width = 200;
			homeGettingBigger.x = 610;
			homeGettingBigger.y = 20;
			addChild(homeGettingBigger);
			homeGettingBigger.addEventListener(MouseEvent.CLICK, SwitchHomeExpansion);
			
			pauseButton = new Button();
			pauseButton.label = "Pause";
			pauseButton.x = 610;
			pauseButton.y = 45;
			addChild(pauseButton);
			pauseButton.addEventListener(MouseEvent.CLICK, Pause);

			restartButton = new Button();
			restartButton.label = "Restart";
			restartButton.x = 610;
			restartButton.y = 70;
			addChild(restartButton);
			restartButton.addEventListener(MouseEvent.CLICK, Restart);
			
		}
		
		private function SwitchStartFromHome(_e:Event) : void
		{
			World.BOT_START_FROM_HOME = startFromHome.selected;
		}
		
		private function SwitchHomeExpansion(_e:Event) : void
		{
			World.HOME_GETTING_BIGGER = homeGettingBigger.selected;
		}

		private function Pause(_e:Event) : void
		{
			paused = !paused;
			if (paused)
			{
				(_e.currentTarget as Button).label = "Play";
			}
			else
			{
				(_e.currentTarget as Button).label = "Pause";				
			}
		}
		
		private function Restart(_e:Event): void
		{
			stage.removeEventListener(Event.ENTER_FRAME, Update);
			while (stage.numChildren > 1)
			{
				stage.removeChildAt(1);
			}
			
			
			init(_e);
		}
		
		
		private function Update(_event:Event) : void
		{
			if (!paused)
			{
				TimeManager.timeManager.Update();
				world.Update();
			}
		}
	}
	
}