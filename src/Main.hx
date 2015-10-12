
import luxe.Input;
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;
import luxe.Screen;
import luxe.Visual;
import luxe.States;

class Main extends luxe.Game {

  var maze_once : Bool = false;
  var player_once : Bool = false;

  var stateSelector : States;

  override function config(config:luxe.AppConfig) {
    if(Luxe.snow.platform == 'web') {
      config.window.width = 1280;
      config.window.height = 720;
    }
    return config;
  } //config

  override function ready() {
    Luxe.renderer.clear_color.rgb(0xe2e6e2);
    var parcel =  new luxe.Parcel({
      textures : [
        {id: 'assets/play.png'},
        {id: 'assets/close.png'},
        {id: 'assets/up.png'},
        {id: 'assets/down.png'},
        {id: 'assets/left.png'},
        {id: 'assets/right.png'},
      ],
    });
    new luxe.ParcelProgress({
      parcel : parcel,
      background: new Color().rgb(0xe2e6e2),
      oncomplete: set_start
    });
    parcel.load();

    stateSelector = new States();
    stateSelector.add( new MenuState({name: "menu"}));
    stateSelector.add( new PlayState({name: "play"}));
    stateSelector.add( new ScoreState({name: "score"}));
    // Bind button clicks
    Luxe.input.bind_mouse('click', MouseButton.left);

  } //ready

  function set_start( parcel: luxe.Parcel) {
    stateSelector.set("menu");

  }

  override function onwindowsized ( e:WindowEvent ) {

        Luxe.camera.center = Luxe.screen.mid;
  }

  var console:Bool = false;
  override function onkeyup( e:KeyEvent ) {

    if (e.keycode == Key.escape) {
      Luxe.shutdown();
    }
    if( e.keycode == Key.key_c && console == false) {
      console = true;
      Luxe.showConsole(console);
    } else if (e.keycode == Key.key_c && console == true){
      console = false;
      Luxe.showConsole(console);
    }
  } //onkeyup

} //Main
