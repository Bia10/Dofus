﻿package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.berilia.managers.ThemeManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.frames.MiscFrame;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
    import com.ankamagames.tiphon.engine.Tiphon;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.atouin.types.AtouinOptions;
    import com.ankamagames.dofus.types.DofusOptions;
    import com.ankamagames.berilia.types.BeriliaOptions;
    import com.ankamagames.tiphon.types.TiphonOptions;
    import com.ankamagames.tubul.types.TubulOptions;
    import com.ankamagames.dofus.misc.options.ChatOptions;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    [InstanciedApi]
    public class ConfigApi implements IApi 
    {

        private static var _init:Boolean = false;

        private var _module:UiModule;

        public function ConfigApi()
        {
            this.init();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
            _init = false;
        }

        [Untrusted]
        public function getConfigProperty(configModuleName:String, propertyName:String)
        {
            var target:* = OptionManager.getOptionManager(configModuleName);
            if (!(target))
            {
                throw (new ApiError((("Config module [" + configModuleName) + "] does not exist.")));
            };
            if (((target) && (this.isSimpleConfigType(target[propertyName]))))
            {
                return (target[propertyName]);
            };
            return (null);
        }

        [Untrusted]
        public function setConfigProperty(configModuleName:String, propertyName:String, value:*):void
        {
            var target:OptionManager = OptionManager.getOptionManager(configModuleName);
            if (!(target))
            {
                throw (new ApiError((("Config module [" + configModuleName) + "] does not exist.")));
            };
            if (this.isSimpleConfigType(target.getDefaultValue(propertyName)))
            {
                target[propertyName] = value;
            }
            else
            {
                throw (new ApiError((((propertyName + " cannot be set in config module ") + configModuleName) + ".")));
            };
        }

        [Untrusted]
        public function resetConfigProperty(configModuleName:String, propertyName:String):void
        {
            if (!(OptionManager.getOptionManager(configModuleName)))
            {
                throw (ApiError((("Config module [" + configModuleName) + "] does not exist.")));
            };
            OptionManager.getOptionManager(configModuleName).restaureDefaultValue(propertyName);
        }

        [Untrusted]
        [NoBoxing]
        public function createOptionManager(name:String):OptionManager
        {
            var om:OptionManager = new OptionManager(name);
            return (om);
        }

        [Trusted]
        public function getAllThemes():Array
        {
            return (ThemeManager.getInstance().getThemes());
        }

        [Untrusted]
        public function getCurrentTheme():String
        {
            return (ThemeManager.getInstance().currentTheme);
        }

        [Trusted]
        public function isOptionalFeatureActive(id:int):Boolean
        {
            var miscFrame:MiscFrame = (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame);
            return (miscFrame.isOptionalFeatureActive(id));
        }

        [Trusted]
        public function getServerConstant(id:int):Object
        {
            return (MiscFrame.getInstance().getServerSessionConstant(id));
        }

        [Untrusted]
        public function getExternalNotificationOptions(pNotificationType:int):Object
        {
            return (ExternalNotificationManager.getInstance().getNotificationOptions(pNotificationType));
        }

        [Untrusted]
        public function setExternalNotificationOptions(pNotificationType:int, pOptions:Object):void
        {
            ExternalNotificationManager.getInstance().setNotificationOptions(pNotificationType, pOptions);
        }

        [Untrusted]
        public function setDebugMode(activate:Boolean):void
        {
            DofusErrorHandler.manualActivation = activate;
            if (activate)
            {
                DofusErrorHandler.activateDebugMode();
            };
        }

        [Untrusted]
        public function getDebugMode():Boolean
        {
            return (DofusErrorHandler.manualActivation);
        }

        [Untrusted]
        public function debugFileExists():Boolean
        {
            return (DofusErrorHandler.debugFileExists);
        }

        private function init():void
        {
            if (_init)
            {
                return;
            };
            _init = true;
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
        }

        private function isSimpleConfigType(value:*):Boolean
        {
            switch (true)
            {
                case (value is int):
                case (value is uint):
                case (value is Number):
                case (value is Boolean):
                case (value is String):
                case (value is Point):
                    return (true);
            };
            return (false);
        }

        private function onPropertyChanged(e:PropertyChangeEvent):void
        {
            var className:String;
            var newValue:* = e.propertyValue;
            if ((newValue is DisplayObject))
            {
                newValue = SecureCenter.secure(newValue, this._module.trusted);
            };
            var oldValue:* = e.propertyOldValue;
            if ((oldValue is DisplayObject))
            {
                newValue = SecureCenter.secure(newValue, this._module.trusted);
            };
            switch (true)
            {
                case (e.watchedClassInstance is AtouinOptions):
                    className = "atouin";
                    break;
                case (e.watchedClassInstance is DofusOptions):
                    className = "dofus";
                    break;
                case (e.watchedClassInstance is BeriliaOptions):
                    className = "berilia";
                    break;
                case (e.watchedClassInstance is TiphonOptions):
                    className = "tiphon";
                    break;
                case (e.watchedClassInstance is TubulOptions):
                    className = "soundmanager";
                    break;
                case (e.watchedClassInstance is ChatOptions):
                    className = "chat";
                    break;
                default:
                    className = getQualifiedClassName(e.watchedClassInstance);
            };
            KernelEventsManager.getInstance().processCallback(HookList.ConfigPropertyChange, className, e.propertyName, newValue, oldValue);
        }


    }
}//package com.ankamagames.dofus.uiApi

