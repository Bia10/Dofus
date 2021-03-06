﻿package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceMembershipMessage extends AllianceJoinedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6390;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6390);
        }

        public function initAllianceMembershipMessage(allianceInfo:AllianceInformations=null, enabled:Boolean=false):AllianceMembershipMessage
        {
            super.initAllianceJoinedMessage(allianceInfo, enabled);
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
            this.serializeAs_AllianceMembershipMessage(output);
        }

        public function serializeAs_AllianceMembershipMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AllianceJoinedMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceMembershipMessage(input);
        }

        public function deserializeAs_AllianceMembershipMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

