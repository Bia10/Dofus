﻿package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
    import com.ankamagames.dofus.datacenter.spells.SpellState;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;

    public class StateBuff extends BasicBuff 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StateBuff));

        private var _statName:String;
        public var stateId:int;

        public function StateBuff(effect:FightTemporaryBoostStateEffect=null, castingSpell:CastingSpell=null, actionId:uint=0)
        {
            if (effect)
            {
                super(effect, castingSpell, actionId, effect.stateId, null, null);
                this._statName = ActionIdConverter.getActionStatName(actionId);
                this.stateId = effect.stateId;
            };
        }

        override public function get type():String
        {
            return ("StateBuff");
        }

        public function get statName():String
        {
            return (this._statName);
        }

        public function get isSilent():Boolean
        {
            return (SpellState.getSpellStateById(this.stateId).isSilent);
        }

        override public function onApplyed():void
        {
            FightersStateManager.getInstance().addStateOnTarget(this.stateId, targetId);
            SpellWrapper.refreshAllPlayerSpellHolder(targetId);
            super.onApplyed();
        }

        override public function onRemoved():void
        {
            var fbf:FightBattleFrame;
            if (!(_removed))
            {
                FightersStateManager.getInstance().removeStateOnTarget(this.stateId, targetId);
                SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                fbf = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                if (((((((fbf) && (!(fbf.executingSequence)))) && ((fbf.deadFightersList.indexOf(targetId) == -1)))) && (!(this.isSilent))))
                {
                    if (actionId == 952)
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE, [targetId, this.stateId], targetId, -1, false, 2);
                    }
                    else
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE, [targetId, this.stateId], targetId, -1, false, 2);
                    };
                };
            };
            super.onRemoved();
        }

        override public function clone(id:int=0):BasicBuff
        {
            var sb:StateBuff = new StateBuff();
            sb._statName = this._statName;
            sb.stateId = this.stateId;
            sb.id = uid;
            sb.uid = uid;
            sb.actionId = actionId;
            sb.targetId = targetId;
            sb.castingSpell = castingSpell;
            sb.duration = duration;
            sb.dispelable = dispelable;
            sb.source = source;
            sb.aliveSource = aliveSource;
            sb.parentBoostUid = parentBoostUid;
            sb.initParam(param1, param2, param3);
            return (sb);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.types

