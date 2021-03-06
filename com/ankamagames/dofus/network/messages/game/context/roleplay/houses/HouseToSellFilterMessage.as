﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseToSellFilterMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6137;

        private var _isInitialized:Boolean = false;
        public var areaId:int = 0;
        public var atLeastNbRoom:uint = 0;
        public var atLeastNbChest:uint = 0;
        public var skillRequested:uint = 0;
        public var maxPrice:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6137);
        }

        public function initHouseToSellFilterMessage(areaId:int=0, atLeastNbRoom:uint=0, atLeastNbChest:uint=0, skillRequested:uint=0, maxPrice:uint=0):HouseToSellFilterMessage
        {
            this.areaId = areaId;
            this.atLeastNbRoom = atLeastNbRoom;
            this.atLeastNbChest = atLeastNbChest;
            this.skillRequested = skillRequested;
            this.maxPrice = maxPrice;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.areaId = 0;
            this.atLeastNbRoom = 0;
            this.atLeastNbChest = 0;
            this.skillRequested = 0;
            this.maxPrice = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseToSellFilterMessage(output);
        }

        public function serializeAs_HouseToSellFilterMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.areaId);
            if (this.atLeastNbRoom < 0)
            {
                throw (new Error((("Forbidden value (" + this.atLeastNbRoom) + ") on element atLeastNbRoom.")));
            };
            output.writeByte(this.atLeastNbRoom);
            if (this.atLeastNbChest < 0)
            {
                throw (new Error((("Forbidden value (" + this.atLeastNbChest) + ") on element atLeastNbChest.")));
            };
            output.writeByte(this.atLeastNbChest);
            if (this.skillRequested < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillRequested) + ") on element skillRequested.")));
            };
            output.writeVarShort(this.skillRequested);
            if (this.maxPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxPrice) + ") on element maxPrice.")));
            };
            output.writeVarInt(this.maxPrice);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseToSellFilterMessage(input);
        }

        public function deserializeAs_HouseToSellFilterMessage(input:ICustomDataInput):void
        {
            this.areaId = input.readInt();
            this.atLeastNbRoom = input.readByte();
            if (this.atLeastNbRoom < 0)
            {
                throw (new Error((("Forbidden value (" + this.atLeastNbRoom) + ") on element of HouseToSellFilterMessage.atLeastNbRoom.")));
            };
            this.atLeastNbChest = input.readByte();
            if (this.atLeastNbChest < 0)
            {
                throw (new Error((("Forbidden value (" + this.atLeastNbChest) + ") on element of HouseToSellFilterMessage.atLeastNbChest.")));
            };
            this.skillRequested = input.readVarUhShort();
            if (this.skillRequested < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillRequested) + ") on element of HouseToSellFilterMessage.skillRequested.")));
            };
            this.maxPrice = input.readVarUhInt();
            if (this.maxPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxPrice) + ") on element of HouseToSellFilterMessage.maxPrice.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

