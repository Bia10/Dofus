﻿package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class EmblemSymbolCategory implements IDataCenter 
    {

        public static const MODULE:String = "EmblemSymbolCategories";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemSymbolCategory));

        public var id:int;
        public var nameId:uint;
        private var _name:String;


        public static function getEmblemSymbolCategoryById(id:int):EmblemSymbolCategory
        {
            return ((GameData.getObject(MODULE, id) as EmblemSymbolCategory));
        }

        public static function getEmblemSymbolCategories():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }


    }
}//package com.ankamagames.dofus.datacenter.guild

