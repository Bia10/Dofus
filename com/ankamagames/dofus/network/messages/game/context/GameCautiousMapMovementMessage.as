﻿package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameCautiousMapMovementMessage extends GameMapMovementMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6497;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6497);
        }

        public function initGameCautiousMapMovementMessage(keyMovements:Vector.<uint>=null, actorId:int=0):GameCautiousMapMovementMessage
        {
            super.initGameMapMovementMessage(keyMovements, actorId);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameCautiousMapMovementMessage(output);
        }

        public function serializeAs_GameCautiousMapMovementMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameMapMovementMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameCautiousMapMovementMessage(input);
        }

        public function deserializeAs_GameCautiousMapMovementMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

