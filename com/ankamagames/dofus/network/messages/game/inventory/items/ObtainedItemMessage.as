﻿package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObtainedItemMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6519;

        private var _isInitialized:Boolean = false;
        public var genericId:uint = 0;
        public var baseQuantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6519);
        }

        public function initObtainedItemMessage(genericId:uint=0, baseQuantity:uint=0):ObtainedItemMessage
        {
            this.genericId = genericId;
            this.baseQuantity = baseQuantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.genericId = 0;
            this.baseQuantity = 0;
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
            this.serializeAs_ObtainedItemMessage(output);
        }

        public function serializeAs_ObtainedItemMessage(output:ICustomDataOutput):void
        {
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element genericId.")));
            };
            output.writeVarShort(this.genericId);
            if (this.baseQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.baseQuantity) + ") on element baseQuantity.")));
            };
            output.writeVarInt(this.baseQuantity);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObtainedItemMessage(input);
        }

        public function deserializeAs_ObtainedItemMessage(input:ICustomDataInput):void
        {
            this.genericId = input.readVarUhShort();
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element of ObtainedItemMessage.genericId.")));
            };
            this.baseQuantity = input.readVarUhInt();
            if (this.baseQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.baseQuantity) + ") on element of ObtainedItemMessage.baseQuantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

