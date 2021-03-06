﻿package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildInformationsPaddocksMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5959;

        private var _isInitialized:Boolean = false;
        public var nbPaddockMax:uint = 0;
        public var paddocksInformations:Vector.<PaddockContentInformations>;

        public function GuildInformationsPaddocksMessage()
        {
            this.paddocksInformations = new Vector.<PaddockContentInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5959);
        }

        public function initGuildInformationsPaddocksMessage(nbPaddockMax:uint=0, paddocksInformations:Vector.<PaddockContentInformations>=null):GuildInformationsPaddocksMessage
        {
            this.nbPaddockMax = nbPaddockMax;
            this.paddocksInformations = paddocksInformations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.nbPaddockMax = 0;
            this.paddocksInformations = new Vector.<PaddockContentInformations>();
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
            this.serializeAs_GuildInformationsPaddocksMessage(output);
        }

        public function serializeAs_GuildInformationsPaddocksMessage(output:ICustomDataOutput):void
        {
            if (this.nbPaddockMax < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbPaddockMax) + ") on element nbPaddockMax.")));
            };
            output.writeByte(this.nbPaddockMax);
            output.writeShort(this.paddocksInformations.length);
            var _i2:uint;
            while (_i2 < this.paddocksInformations.length)
            {
                (this.paddocksInformations[_i2] as PaddockContentInformations).serializeAs_PaddockContentInformations(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInformationsPaddocksMessage(input);
        }

        public function deserializeAs_GuildInformationsPaddocksMessage(input:ICustomDataInput):void
        {
            var _item2:PaddockContentInformations;
            this.nbPaddockMax = input.readByte();
            if (this.nbPaddockMax < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbPaddockMax) + ") on element of GuildInformationsPaddocksMessage.nbPaddockMax.")));
            };
            var _paddocksInformationsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _paddocksInformationsLen)
            {
                _item2 = new PaddockContentInformations();
                _item2.deserialize(input);
                this.paddocksInformations.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

