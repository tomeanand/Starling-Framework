package 
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.system.Capabilities;
    
    import starling.core.Starling;
    
    [Frame(factoryClass="Preloader")]
    [SWF(width="320", height="480", frameRate="60", backgroundColor="#222222")]
    public class Startup extends Sprite
    {
        private var mStarling:Starling;
        
        public function Startup()
        {
            if (stage) start();
            else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function start():void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // required on Windows and Android, needs more memory
            
            mStarling = new Starling(Game, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
        }
        
        private function onAddedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            start();
        }
        
        private function onContextCreated(event:Event):void
        {
            // set framerate to 30 in software mode
            
            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                Starling.current.nativeStage.frameRate = 30;
        }
    }
}