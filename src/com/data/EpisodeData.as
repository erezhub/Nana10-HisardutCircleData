package com.data
{
	public class EpisodeData
	{
		private var _order:int;
		private var _date:String;
		private var _tribe1:TribeData;
		private var _tribe2:TribeData;
		private var currentTribe:Boolean;
		public var members:Array;
		
		public function EpisodeData(order:int, date:String)
		{
			_order = order;
			_date = date;
			members = [];
		}

		public function get order():int
		{
			return _order;
		}

		public function get date():String
		{
			return _date;
		}

		public function getTribeById(id:int):TribeData
		{
			if (_tribe1.id == id) return _tribe1;
			return _tribe2;
		}
		
		public function getTribeByOrder(i:int):TribeData
		{
			return this["_tribe"+i];
		}
		
		public function addTribe(tribeData:TribeData):void
		{
			if (currentTribe)
			{
				_tribe2 = tribeData;
			}
			else
			{
				currentTribe = true;
				_tribe1 = tribeData;
			}
		}
		
		public function getMemberById(id:int):MemberData
		{
			for (var i:int = 0; i < members.length; i++)
			{
				if (members[i].id == id) return members[i];
			}
			return null;
		}
		
		public function get totalMember():int
		{
			return members.length;
		}
	}
}