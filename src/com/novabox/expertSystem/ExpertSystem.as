package com.novabox.expertSystem 
{
	/**
	 * Expert System 
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class ExpertSystem
	{
		private var factBase:FactBase;
		private var ruleBase:RuleBase;
		
		private var inferedFacts:Array;
		
		public function ExpertSystem() 
		{
			factBase = new FactBase();
			ruleBase = new RuleBase();	
			inferedFacts = new Array();
		}

		public function GetFactBase() : FactBase
		{
			return factBase;
		}
		
		public function GetRuleBase() : RuleBase
		{
			return ruleBase;
		}
	
		public function AddFact(_fact:Fact) : void
		{
			factBase.AddFact(_fact);
		}
		
		public function SetFactValue(_fact:Fact, _value:Boolean) : void
		{
			factBase.SetFactValue(_fact, _value);
		}
		
		public function ResetFacts() : void
		{
			factBase.ResetFacts();
		}
		
		public function AddRule(_rule:Rule) : void
		{
			if (!factBase.HasFact(_rule.GetGoal()))
			{
				factBase.AddFact(_rule.GetGoal());
			}
			
			var premises:Array = _rule.GetPremises();
			
			for (var i:int = 0; i < premises.length; i++)
			{
				var premise:Fact = (premises[i] as Fact);
				if (!factBase.HasFact(premise))
				{
					factBase.AddFact(premise);
				}			
			}
			
			ruleBase.AddRule(_rule);
		}
		
		public function IsRuleValid(_rule:Rule) : Boolean
		{
			
			var goal:Fact = _rule.GetGoal();
			if (factBase.GetFactValue(goal) == true)
			{
				//Already infered
				return false;
			}
			
			var premises:Array = _rule.GetPremises();
			for (var i:int = 0; i < premises.length; i++)
			{
				var premise:Fact = (premises[i] as Fact);
				if (factBase.GetFactValue(premise) == false)
				{
					//One premise is false
					return false;
				}
			}
			return true;
		}
		
		public function GetValidRule() : Rule
		{
			var rules:Array = ruleBase.GetRules();
			for (var i:int = 0; i < rules.length; i++)
			{
				var rule:Rule = (rules[i] as Rule);
				if (IsRuleValid(rule))
				{
					return rule;
				}
			}
			
			return null;
		}
		
		public function ClearInferedFacts() : void
		{
			while (inferedFacts.length > 0)
			{
				inferedFacts.pop();
			}
		}
		
		public function Infer() : void
		{
			ClearInferedFacts();
			
			var validRule:Rule = GetValidRule();
			while (validRule != null)
			{	
				var goal:Fact = validRule.GetGoal();
				factBase.SetFactValue(goal, true);
				inferedFacts.push(goal);
				
				//TraceRule(validRule);
				
				validRule = GetValidRule();
			}
		}
		
		public function GetInferedFacts() : Array
		{
			return inferedFacts;
		}
		
		public function TraceRule(_rule:Rule) : void
		{
			var traceString:String = "";
			var premises:Array = _rule.GetPremises();
			for (var i:int = 0; i < premises.length; i++)
			{
				traceString += (premises[i] as Fact).GetLabel();
				
				if (i < (premises.length - 1))
				{
					traceString += ", ";
				}
			}
			traceString += " -> " + _rule.GetGoal().GetLabel();
			
			trace(traceString);
		}
		
	}

}