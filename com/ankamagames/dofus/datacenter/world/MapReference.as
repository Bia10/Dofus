﻿package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class MapReference implements IDataCenter 
    {

        public static const MODULE:String = "MapReferences";

        public var id:int;
        public var mapId:uint;
        public var cellId:int;


        public static function getMapReferenceById(id:int):MapReference
        {
            var gd:Object = GameData.getObject(MODULE, id);
            return ((GameData.getObject(MODULE, id) as MapReference));
        }

        public static function getAllMapReference():Array
        {
            return ((GameData.getObjects(MODULE) as Array));
        }


    }
}//package com.ankamagames.dofus.datacenter.world

