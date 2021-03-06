﻿package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionBaseInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class PartyGuestInformations implements INetworkType 
    {

        public static const protocolId:uint = 374;

        public var guestId:uint = 0;
        public var hostId:uint = 0;
        public var name:String = "";
        public var guestLook:EntityLook;
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var status:PlayerStatus;
        public var companions:Vector.<PartyCompanionBaseInformations>;

        public function PartyGuestInformations()
        {
            this.guestLook = new EntityLook();
            this.status = new PlayerStatus();
            this.companions = new Vector.<PartyCompanionBaseInformations>();
            super();
        }

        public function getTypeId():uint
        {
            return (374);
        }

        public function initPartyGuestInformations(guestId:uint=0, hostId:uint=0, name:String="", guestLook:EntityLook=null, breed:int=0, sex:Boolean=false, status:PlayerStatus=null, companions:Vector.<PartyCompanionBaseInformations>=null):PartyGuestInformations
        {
            this.guestId = guestId;
            this.hostId = hostId;
            this.name = name;
            this.guestLook = guestLook;
            this.breed = breed;
            this.sex = sex;
            this.status = status;
            this.companions = companions;
            return (this);
        }

        public function reset():void
        {
            this.guestId = 0;
            this.hostId = 0;
            this.name = "";
            this.guestLook = new EntityLook();
            this.sex = false;
            this.status = new PlayerStatus();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyGuestInformations(output);
        }

        public function serializeAs_PartyGuestInformations(output:ICustomDataOutput):void
        {
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element guestId.")));
            };
            output.writeInt(this.guestId);
            if (this.hostId < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostId) + ") on element hostId.")));
            };
            output.writeInt(this.hostId);
            output.writeUTF(this.name);
            this.guestLook.serializeAs_EntityLook(output);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            output.writeShort(this.status.getTypeId());
            this.status.serialize(output);
            output.writeShort(this.companions.length);
            var _i8:uint;
            while (_i8 < this.companions.length)
            {
                (this.companions[_i8] as PartyCompanionBaseInformations).serializeAs_PartyCompanionBaseInformations(output);
                _i8++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyGuestInformations(input);
        }

        public function deserializeAs_PartyGuestInformations(input:ICustomDataInput):void
        {
            var _item8:PartyCompanionBaseInformations;
            this.guestId = input.readInt();
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element of PartyGuestInformations.guestId.")));
            };
            this.hostId = input.readInt();
            if (this.hostId < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostId) + ") on element of PartyGuestInformations.hostId.")));
            };
            this.name = input.readUTF();
            this.guestLook = new EntityLook();
            this.guestLook.deserialize(input);
            this.breed = input.readByte();
            this.sex = input.readBoolean();
            var _id7:uint = input.readUnsignedShort();
            this.status = ProtocolTypeManager.getInstance(PlayerStatus, _id7);
            this.status.deserialize(input);
            var _companionsLen:uint = input.readUnsignedShort();
            var _i8:uint;
            while (_i8 < _companionsLen)
            {
                _item8 = new PartyCompanionBaseInformations();
                _item8.deserialize(input);
                this.companions.push(_item8);
                _i8++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party

