﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class EmotePlayErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5688;

        private var _isInitialized:Boolean = false;
        public var emoteId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5688);
        }

        public function initEmotePlayErrorMessage(emoteId:uint=0):EmotePlayErrorMessage
        {
            this.emoteId = emoteId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.emoteId = 0;
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
            this.serializeAs_EmotePlayErrorMessage(output);
        }

        public function serializeAs_EmotePlayErrorMessage(output:ICustomDataOutput):void
        {
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element emoteId.")));
            };
            output.writeByte(this.emoteId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EmotePlayErrorMessage(input);
        }

        public function deserializeAs_EmotePlayErrorMessage(input:ICustomDataInput):void
        {
            this.emoteId = input.readUnsignedByte();
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element of EmotePlayErrorMessage.emoteId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.emote

