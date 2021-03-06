﻿package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameRolePlayNpcInformations extends GameRolePlayActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 156;

        public var npcId:uint = 0;
        public var sex:Boolean = false;
        public var specialArtworkId:uint = 0;


        override public function getTypeId():uint
        {
            return (156);
        }

        public function initGameRolePlayNpcInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, npcId:uint=0, sex:Boolean=false, specialArtworkId:uint=0):GameRolePlayNpcInformations
        {
            super.initGameRolePlayActorInformations(contextualId, look, disposition);
            this.npcId = npcId;
            this.sex = sex;
            this.specialArtworkId = specialArtworkId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.npcId = 0;
            this.sex = false;
            this.specialArtworkId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayNpcInformations(output);
        }

        public function serializeAs_GameRolePlayNpcInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayActorInformations(output);
            if (this.npcId < 0)
            {
                throw (new Error((("Forbidden value (" + this.npcId) + ") on element npcId.")));
            };
            output.writeVarShort(this.npcId);
            output.writeBoolean(this.sex);
            if (this.specialArtworkId < 0)
            {
                throw (new Error((("Forbidden value (" + this.specialArtworkId) + ") on element specialArtworkId.")));
            };
            output.writeVarShort(this.specialArtworkId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayNpcInformations(input);
        }

        public function deserializeAs_GameRolePlayNpcInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.npcId = input.readVarUhShort();
            if (this.npcId < 0)
            {
                throw (new Error((("Forbidden value (" + this.npcId) + ") on element of GameRolePlayNpcInformations.npcId.")));
            };
            this.sex = input.readBoolean();
            this.specialArtworkId = input.readVarUhShort();
            if (this.specialArtworkId < 0)
            {
                throw (new Error((("Forbidden value (" + this.specialArtworkId) + ") on element of GameRolePlayNpcInformations.specialArtworkId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

