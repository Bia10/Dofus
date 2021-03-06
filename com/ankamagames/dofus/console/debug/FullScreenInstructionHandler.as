﻿package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.display.StageDisplayState;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class FullScreenInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var resX:uint;
            var resY:uint;
            switch (cmd)
            {
                case "fullscreen":
                    if (args.length == 0)
                    {
                        if (AirScanner.hasAir())
                        {
                            if (StageShareManager.stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"])
                            {
                                StageShareManager.stage.displayState = StageDisplayState["NORMAL"];
                            }
                            else
                            {
                                console.output("Resolution needed.");
                            };
                        };
                    }
                    else
                    {
                        if (args.length == 2)
                        {
                            if (AirScanner.hasAir())
                            {
                                resX = uint(args[0]);
                                resY = uint(args[1]);
                                StageShareManager.stage.fullScreenSourceRect = new Rectangle(0, 0, resX, resY);
                                StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
                            };
                        };
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "fullscreen":
                    return ("Toggle the full-screen display mode.");
            };
            return ("Unknown command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

