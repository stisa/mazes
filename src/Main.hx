
import luxe.Input;
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;
import luxe.Screen;

class Main extends luxe.Game {

  var maze : Maze;
  var button : Sprite;
  var resetButton : Sprite;
  var touch_once : Bool = false;
  var cellSize : Vector = new Vector(14,14);
  var gridSize : Vector;

  override function config(config:luxe.AppConfig) {

      return config;
  } //config

  override function ready() {

    Luxe.renderer.clear_color.rgb(0xe2e6e2);

    createButtons();

    gridSize = new Vector( (Luxe.screen.w-200)/cellSize.x, ( Luxe.screen.h-340 )/cellSize.y );
    Luxe.input.bind_mouse('click', MouseButton.left);
    Luxe.input.bind_key('click', Key.space);
  } //ready

  override function onwindowsized ( e:WindowEvent ) {

        Luxe.camera.center = Luxe.screen.mid;
  }


  override function onkeyup( e:KeyEvent ) {

    if (e.keycode == Key.escape) {

      Luxe.shutdown();
    }
    if (e.keycode == Key.key_r) {

      //Reset the scene
      maze.reset();
      touch_once = false;
    }
  } //onkeyup

  function createButtons() {

    button = new Sprite({
      name: "play",
      pos: new Vector(240,1210),
      size: new Vector(192,96),
      color: new Color(0,0,0)
    });

    resetButton = new Sprite({
      name: "reset",
      pos: new Vector(500,1210),
      size: new Vector(96,96),
      color: new Color(1,0.2,0.2)
    });
  }

  override function oninputup ( event_name:String, e:InputEvent ) {

    switch( event_name ) {
      case 'click':

        if ( e.type == mouse ) { // Check if the click is inside the box

          if ( touch_once == false && button.point_inside_AABB(e.mouse_event.pos) ) {

            touch_once = true;
            maze = new Maze( gridSize, cellSize, new Vector(4*cellSize.x,4*cellSize.y) );
          }
          else if ( resetButton.point_inside_AABB(e.mouse_event.pos) ) {

            //Reset the scene
            maze.reset();
            touch_once = false;
          }
        }
        else if ( e.type == keys ) { // just generate the maze if the starting event is a keyboard event

          if( touch_once == false ) {

            touch_once = true;
            maze = new Maze( gridSize, cellSize, new Vector(4*cellSize.x,4*cellSize.y) );
          }
        }
      //click
    } //switch
  }
} //Main
