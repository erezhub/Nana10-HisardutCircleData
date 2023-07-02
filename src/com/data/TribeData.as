package com.data
{
	public class TribeData
	{
		private var _id:int;
		private var _vetoFrom:int;
		private var _vetoTo:int;
		private var _statue:int;
		private var _necklace:int;
		private var _outcasted:int;
		private var _active:Boolean;
		public var members:Array;
		public var tribeYPos:Number;
		
		public function TribeData(id:int, active:Boolean, vetoFrom:int = 0, vetoTo:int = 0, statue:int = 0, necklace:int = 0, outcasted:int = 0)
		{
			_id = id;
			_vetoFrom = vetoFrom;
			_vetoTo = vetoTo;
			_statue = statue;
			_necklace = necklace;
			_outcasted = outcasted;
			_active = active;
			members = [];
		}

		public function get id():int
		{
			return _id;
		}

		public function get vetoFrom():int
		{
			return _vetoFrom;
		}

		public function get vetoTo():int
		{
			return _vetoTo;
		}
		
		public function getMemberById(id:int):MemberData
		{
			for (var i:int = 0; i < members.length; i++)
			{
				if (members[i].id == id) return members[i];
			}
			return null;
		}

		public function get active():Boolean
		{
			return _active;
		}

		public function get statue():int
		{
			return _statue;
		}

		public function get necklace():int
		{
			return _necklace;
		}

		public function set vetoFrom(value:int):void
		{
			_vetoFrom = value;
		}

		public function set vetoTo(value:int):void
		{
			_vetoTo = value;
		}

		public function set statue(value:int):void
		{
			_statue = value;
		}

		public function set necklace(value:int):void
		{
			_necklace = value;
		}

		public function set active(value:Boolean):void
		{
			_active = value;
		}

		public function get outcasted():int
		{
			return _outcasted;
		}

		public function set outcasted(value:int):void
		{
			_outcasted = value;
		}


	}
}