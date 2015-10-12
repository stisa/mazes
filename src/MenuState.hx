import luxe.States;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.Input;
import luxe.Vector.Vec;

class MenuState extends State {

  var playButton : Sprite;
  var closeButton : Sprite;

  override function onenter<T>(_:T) {
      createButtons();
  }
  override function onleave<T>(_:T) {
    trace("leaving "+ this.name);
    playButton.destroy();
    closeButton.destroy();
  }
  function createButtons() {
    // Create Buttons
    playButton = new Sprite({
      name: "play",
      pos: Luxe.screen.mid - new Vec(128,0),
      texture: Luxe.resources.texture('assets/play.png')
      //size: new Vector(96,64),
      //color: new Color(0,0,0)
    });
    closeButton = new Sprite({
      name: "close",
      pos: Luxe.screen.mid + new Vec(128,0),
      texture: Luxe.resources.texture('assets/close.png')
      //size: new Vector(96,64),
      //color: new Color(1,0.2,0.2)
    });
  }// createButtons


  override function oninputup ( event_name:String, e:InputEvent ) {
    if( event_name =='click' ) {

      if ( e.type == mouse ) { // Check if the click is inside the box

        if ( playButton.point_inside_AABB(e.mouse_event.pos) ) {
          this.machine.set('play',null,this);
        }
        if ( closeButton.point_inside_AABB(e.mouse_event.pos) ) {
          Luxe.shutdown();
        }
      }
    }
  } // oninputup

}
