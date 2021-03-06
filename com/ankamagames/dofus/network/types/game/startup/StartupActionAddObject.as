﻿package com.ankamagames.dofus.network.types.game.startup
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class StartupActionAddObject implements INetworkType 
    {

        public static const protocolId:uint = 52;

        public var uid:uint = 0;
        public var title:String = "";
        public var text:String = "";
        public var descUrl:String = "";
        public var pictureUrl:String = "";
        public var items:Vector.<ObjectItemInformationWithQuantity>;

        public function StartupActionAddObject()
        {
            this.items = new Vector.<ObjectItemInformationWithQuantity>();
            super();
        }

        public function getTypeId():uint
        {
            return (52);
        }

        public function initStartupActionAddObject(uid:uint=0, title:String="", text:String="", descUrl:String="", pictureUrl:String="", items:Vector.<ObjectItemInformationWithQuantity>=null):StartupActionAddObject
        {
            this.uid = uid;
            this.title = title;
            this.text = text;
            this.descUrl = descUrl;
            this.pictureUrl = pictureUrl;
            this.items = items;
            return (this);
        }

        public function reset():void
        {
            this.uid = 0;
            this.title = "";
            this.text = "";
            this.descUrl = "";
            this.pictureUrl = "";
            this.items = new Vector.<ObjectItemInformationWithQuantity>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_StartupActionAddObject(output);
        }

        public function serializeAs_StartupActionAddObject(output:ICustomDataOutput):void
        {
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element uid.")));
            };
            output.writeInt(this.uid);
            output.writeUTF(this.title);
            output.writeUTF(this.text);
            output.writeUTF(this.descUrl);
            output.writeUTF(this.pictureUrl);
            output.writeShort(this.items.length);
            var _i6:uint;
            while (_i6 < this.items.length)
            {
                (this.items[_i6] as ObjectItemInformationWithQuantity).serializeAs_ObjectItemInformationWithQuantity(output);
                _i6++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StartupActionAddObject(input);
        }

        public function deserializeAs_StartupActionAddObject(input:ICustomDataInput):void
        {
            var _item6:ObjectItemInformationWithQuantity;
            this.uid = input.readInt();
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element of StartupActionAddObject.uid.")));
            };
            this.title = input.readUTF();
            this.text = input.readUTF();
            this.descUrl = input.readUTF();
            this.pictureUrl = input.readUTF();
            var _itemsLen:uint = input.readUnsignedShort();
            var _i6:uint;
            while (_i6 < _itemsLen)
            {
                _item6 = new ObjectItemInformationWithQuantity();
                _item6.deserialize(input);
                this.items.push(_item6);
                _i6++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.startup

