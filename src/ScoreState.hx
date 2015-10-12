import luxe.States;
import luxe.Input;
import luxe.Vector.Vec;
import luxe.Color;
import Constants;
import luxe.Text;

class ScoreState extends State {

  var closeButton : BoundButton;

  override function onenter<T>(_:T){
    var score : Int = Constants.score;
    trace("Entering "+this.name);

    Luxe.draw.text({
      color : new Color(0,0,0),
      pos: Luxe.screen.mid,
      point_size: 48,
      align: TextAlign.center,
      text: 'You scored $score points'
    });
    closeButton = new BoundButton({
      name: "close",
      pos: Luxe.screen.mid + new Vec(0,256),
      texture: Luxe.resources.texture('assets/close.png')
    });

    Luxe.input.bind_mouse('close', MouseButton.left );
  }

  override function oninputup(event_name:String , e : InputEvent) {
    if ( event_name == 'close' ) {
      if ( closeButton.point_inside_circle(e.mouse_event.pos) ) {
        Luxe.shutdown();
      }
    }
  }
}
