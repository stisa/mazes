import luxe.States;
import luxe.Input;
import luxe.Vector.Vec;
import luxe.Color;
import Constants;
import luxe.Text;

class ScoreState extends State {

  var closeButton : BoundButton;
  var playButton : BoundButton;
  var scoreText : luxe.Text;

  override function onenter<T>(_:T){
    var score : Int = Constants.score;
    trace("Entering "+this.name);

    scoreText = new luxe.Text({
      color : new Color(0,0,0),
      pos: Luxe.screen.mid,
      point_size: 48,
      align: TextAlign.center,
      text: 'You scored $score points'
    });
    playButton = new BoundButton({
      name: "play",
      pos: Luxe.screen.mid + new Vec(-128,256),
      texture: Luxe.resources.texture('assets/play.png')
    });
    closeButton = new BoundButton({
      name: "close",
      pos: Luxe.screen.mid + new Vec(0,256),
      texture: Luxe.resources.texture('assets/close.png')
    });

    Luxe.input.bind_mouse('click', MouseButton.left );
  }
  override function onleave<T>(_:T){
    Constants.score = 0;
    closeButton.destroy();
    playButton.destroy();
    scoreText.destroy();
  }

  override function oninputup(event_name:String , e : InputEvent) {
    if ( event_name == 'click' ) {
      if ( closeButton.point_inside_circle(e.mouse_event.pos) ) {
        Luxe.shutdown();
      }
      else if ( playButton.point_inside_circle(e.mouse_event.pos) ) {
        this.machine.set('play',null,this);
      }
    }
  }
}
