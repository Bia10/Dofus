﻿package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TaxCollectorGuildInformations extends TaxCollectorComplementaryInformations implements INetworkType 
    {

        public static const protocolId:uint = 446;

        public var guild:BasicGuildInformations;

        public function TaxCollectorGuildInformations()
        {
            this.guild = new BasicGuildInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (446);
        }

        public function initTaxCollectorGuildInformations(guild:BasicGuildInformations=null):TaxCollectorGuildInformations
        {
            this.guild = guild;
            return (this);
        }

        override public function reset():void
        {
            this.guild = new BasicGuildInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorGuildInformations(output);
        }

        public function serializeAs_TaxCollectorGuildInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_TaxCollectorComplementaryInformations(output);
            this.guild.serializeAs_BasicGuildInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorGuildInformations(input);
        }

        public function deserializeAs_TaxCollectorGuildInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guild = new BasicGuildInformations();
            this.guild.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild.tax

