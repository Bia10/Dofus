﻿package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightTriggerGlyphTrapMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5741;

        private var _isInitialized:Boolean = false;
        public var markId:int = 0;
        public var triggeringCharacterId:int = 0;
        public var triggeredSpellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5741);
        }

        public function initGameActionFightTriggerGlyphTrapMessage(actionId:uint=0, sourceId:int=0, markId:int=0, triggeringCharacterId:int=0, triggeredSpellId:uint=0):GameActionFightTriggerGlyphTrapMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.markId = markId;
            this.triggeringCharacterId = triggeringCharacterId;
            this.triggeredSpellId = triggeredSpellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.markId = 0;
            this.triggeringCharacterId = 0;
            this.triggeredSpellId = 0;
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
            this.serializeAs_GameActionFightTriggerGlyphTrapMessage(output);
        }

        public function serializeAs_GameActionFightTriggerGlyphTrapMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeShort(this.markId);
            output.writeInt(this.triggeringCharacterId);
            if (this.triggeredSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.triggeredSpellId) + ") on element triggeredSpellId.")));
            };
            output.writeVarShort(this.triggeredSpellId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightTriggerGlyphTrapMessage(input);
        }

        public function deserializeAs_GameActionFightTriggerGlyphTrapMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.markId = input.readShort();
            this.triggeringCharacterId = input.readInt();
            this.triggeredSpellId = input.readVarUhShort();
            if (this.triggeredSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.triggeredSpellId) + ") on element of GameActionFightTriggerGlyphTrapMessage.triggeredSpellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

