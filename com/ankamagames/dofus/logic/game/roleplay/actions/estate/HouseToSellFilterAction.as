﻿package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseToSellFilterAction implements Action 
    {

        public var areaId:int;
        public var atLeastNbRoom:uint;
        public var atLeastNbChest:uint;
        public var skillRequested:uint;
        public var maxPrice:uint;


        public static function create(areaId:int, atLeastNbRoom:uint, atLeastNbChest:uint, skillRequested:uint, maxPrice:uint):HouseToSellFilterAction
        {
            var a:HouseToSellFilterAction = new (HouseToSellFilterAction)();
            a.areaId = areaId;
            a.atLeastNbRoom = atLeastNbRoom;
            a.atLeastNbChest = atLeastNbChest;
            a.skillRequested = skillRequested;
            a.maxPrice = maxPrice;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.estate

