﻿package com.ankamagames.jerakine.utils.display
{
    import flash.display.Stage;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.events.NativeWindowDisplayStateEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.StageQuality;
    import flash.display.StageDisplayState;
    import flash.display.NativeWindow;
    import flash.display.NativeWindowDisplayState;

    public class StageShareManager 
    {

        private static const NOT_INITIALIZED:int = -77777;
        private static var _stage:Stage;
        private static var _startWidth:uint;
        private static var _startHeight:uint;
        private static var _rootContainer:DisplayObjectContainer;
        private static var _customMouseX:int = NOT_INITIALIZED;//-77777
        private static var _customMouseY:int = NOT_INITIALIZED;//-77777
        private static var _setQualityIsEnable:Boolean;
        private static var _chrome:Point = new Point();
        private static var _mouseOnStage:Boolean;
        private static var _isActive:Boolean;
        public static var nativeWindowStartWidth:uint;
        public static var nativeWindowStartHeight:uint;
        public static var chromeWidth:uint;
        public static var chromeHeight:uint;
        public static var justExitFullScreen:Boolean = false;
        public static var shortcutUsedToExitFullScreen:Boolean = false;


        public static function set rootContainer(d:DisplayObjectContainer):void
        {
            _rootContainer = d;
        }

        public static function get rootContainer():DisplayObjectContainer
        {
            return (_rootContainer);
        }

        public static function get stage():Stage
        {
            return (_stage);
        }

        public static function get windowScale():Number
        {
            var stageWidth:Number;
            var stageHeight:Number;
            var scale:Number;
            if (AirScanner.hasAir())
            {
                stageWidth = ((stage.nativeWindow.width - chrome.x) / startWidth);
                stageHeight = ((stage.nativeWindow.height - chrome.y) / startHeight);
                scale = Math.min(stageWidth, stageHeight);
                return (scale);
            };
            return (Math.min((stage.stageWidth / startWidth), (stage.stageHeight / startHeight)));
        }

        public static function set stage(value:Stage):void
        {
            _stage = value;
            _startWidth = 0x0500;
            _startHeight = 0x0400;
            if (AirScanner.hasAir())
            {
                _stage["nativeWindow"].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, displayStateChangeHandler);
            };
            _stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
            _stage.addEventListener(Event.ACTIVATE, onActivate);
            _stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        }

        public static function testQuality():void
        {
            var oldQuality:String = _stage.quality;
            _stage.quality = StageQuality.MEDIUM;
            _setQualityIsEnable = (_stage.quality.toLowerCase() == StageQuality.MEDIUM);
            _stage.quality = oldQuality;
        }

        public static function setFullScreen(enabled:Boolean, onlyMaximize:Boolean=false):void
        {
            if (AirScanner.hasAir())
            {
                if (enabled)
                {
                    if (!(onlyMaximize))
                    {
                        StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
                    }
                    else
                    {
                        StageShareManager.stage["nativeWindow"].maximize();
                    };
                }
                else
                {
                    if (!(onlyMaximize))
                    {
                        StageShareManager.stage.displayState = StageDisplayState.NORMAL;
                    }
                    else
                    {
                        StageShareManager.stage["nativeWindow"].minimize();
                    };
                };
            }
            else
            {
                if (AirScanner.isStreamingVersion())
                {
                    try
                    {
                        StageShareManager.stage.displayState = ((enabled) ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL);
                    }
                    catch(error:Error)
                    {
                    };
                };
            };
        }

        public static function get startWidth():uint
        {
            return (_startWidth);
        }

        public static function get startHeight():uint
        {
            return (_startHeight);
        }

        public static function get setQualityIsEnable():Boolean
        {
            return (_setQualityIsEnable);
        }

        public static function get mouseX():int
        {
            if (_customMouseX == NOT_INITIALIZED)
            {
                return (_rootContainer.mouseX);
            };
            return (_customMouseX);
        }

        public static function set mouseX(v:int):void
        {
            _customMouseX = v;
        }

        public static function get mouseY():int
        {
            if (_customMouseY == NOT_INITIALIZED)
            {
                return (_rootContainer.mouseY);
            };
            return (_customMouseY);
        }

        public static function set mouseY(v:int):void
        {
            _customMouseY = v;
        }

        public static function get stageOffsetX():int
        {
            return (_rootContainer.x);
        }

        public static function get stageOffsetY():int
        {
            return (_rootContainer.y);
        }

        public static function get stageScaleX():Number
        {
            return (_rootContainer.scaleX);
        }

        public static function get stageScaleY():Number
        {
            return (_rootContainer.scaleY);
        }

        public static function get mouseOnStage():Boolean
        {
            return (_mouseOnStage);
        }

        public static function get chrome():Point
        {
            return (_chrome);
        }

        public static function set chrome(value:Point):void
        {
            _chrome = value;
        }

        public static function get isActive():Boolean
        {
            return (_isActive);
        }

        private static function displayStateChangeHandler(event:NativeWindowDisplayStateEvent):void
        {
            var nativeWindow:NativeWindow;
            if (event.beforeDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
                if (AirScanner.hasAir())
                {
                    nativeWindow = _stage["nativeWindow"];
                    if (event.afterDisplayState == NativeWindowDisplayState.NORMAL)
                    {
                        nativeWindow.width = (nativeWindow.width - 1);
                        nativeWindow.width = (nativeWindow.width + 1);
                    };
                };
            };
        }

        private static function onStageMouseLeave(pEvent:Event):void
        {
            _mouseOnStage = false;
        }

        private static function onStageMouseMove(pEvent:MouseEvent):void
        {
            _mouseOnStage = true;
        }

        private static function onActivate(event:Event):void
        {
            _isActive = true;
        }

        private static function onDeactivate(event:Event):void
        {
            _isActive = false;
        }


    }
}//package com.ankamagames.jerakine.utils.display

