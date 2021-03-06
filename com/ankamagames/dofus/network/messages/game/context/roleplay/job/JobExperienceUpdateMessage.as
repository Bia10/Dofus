﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobExperienceUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 0x1616;

        private var _isInitialized:Boolean = false;
        public var experiencesUpdate:JobExperience;

        public function JobExperienceUpdateMessage()
        {
            this.experiencesUpdate = new JobExperience();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (0x1616);
        }

        public function initJobExperienceUpdateMessage(experiencesUpdate:JobExperience=null):JobExperienceUpdateMessage
        {
            this.experiencesUpdate = experiencesUpdate;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.experiencesUpdate = new JobExperience();
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
            this.serializeAs_JobExperienceUpdateMessage(output);
        }

        public function serializeAs_JobExperienceUpdateMessage(output:ICustomDataOutput):void
        {
            this.experiencesUpdate.serializeAs_JobExperience(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobExperienceUpdateMessage(input);
        }

        public function deserializeAs_JobExperienceUpdateMessage(input:ICustomDataInput):void
        {
            this.experiencesUpdate = new JobExperience();
            this.experiencesUpdate.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

