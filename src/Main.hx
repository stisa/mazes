
import luxe.Input;
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;
import luxe.Screen;

class Main extends luxe.Game {

  var maze : Maze;
  var gridSize : Vector;

  var maze_once : Bool = false;
  var player_once : Bool = false;
  var cellSize : Vector = new Vector(14,14);

  var player : Player;

  var mazeButton : Sprite;
  var playerButton : Sprite;
  var resetButton : Sprite;

  override function config(config:luxe.AppConfig) {

      return config;
  } //config

  override function ready() {

    Luxe.renderer.clear_color.rgb(0xe2e6e2);

    createButtons();

    gridSize = new Vector( (Luxe.screen.w-200)/cellSize.x, ( Luxe.screen.h-340 )/cellSize.y );

    maze = new Maze( gridSize, cellSize, new Vector(4*cellSize.x,4*cellSize.y) );

    Luxe.input.bind_mouse('click', MouseButton.left);
    Luxe.input.bind_key('click', Key.space);

    Luxe.input.bind_key('left', Key.key_a);
    Luxe.input.bind_key('right', Key.key_d);
    Luxe.input.bind_key('up', Key.key_w);
    Luxe.input.bind_key('down', Key.key_s);
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
      maze_once = false;
      player_once = false;
    }
  } //onkeyup

  function createButtons() {

    mazeButton = new Sprite({
      name: "maze",
      pos: new Vector(120,1210),
      size: new Vector(96,96),
      color: new Color(0,0,0)
    });
    playerButton = new Sprite({
      name: "player",
      pos: new Vector(330,1210),
      size: new Vector(96,96),
      color: new Color(0.2,0.2,1)
    });
    resetButton = new Sprite({
      name: "reset",
      pos: new Vector(600,1210),
      size: new Vector(96,96),
      color: new Color(1,0.2,0.2)
    });
  }

  override function oninputup ( event_name:String, e:InputEvent ) {

    switch( event_name ) {
      case 'click':

        if ( e.type == mouse ) { // Check if the click is inside the box

          if ( maze_once == false && mazeButton.point_inside_AABB(e.mouse_event.pos) ) {

            maze_once = true;
            maze = new Maze( gridSize, cellSize, new Vector(4*cellSize.x,4*cellSize.y) );

          }
          if ( player_once == false && playerButton.point_inside_AABB(e.mouse_event.pos) ) {

            player_once = true;
            player = new Player({
              name: 'player',
              geometry: maze.startCell.box,
              cell: maze.startCell,
              maze: maze,
              color: new Color(0,0,1),
              depth: 2
            });

          }
          if ( resetButton.point_inside_AABB(e.mouse_event.pos) ) {

            //Reset the scene
            maze.reset();
            player.reset();
            maze_once = false;
            player_once = false;
          }
        }
        /*else if ( e.type == keys ) { // just generate the maze if the starting event is a keyboard event

          if( touch_once == false ) {

            touch_once = true;
            player = new Player({
              name: 'player',
              geometry: maze.cells['5-5'].box,
              maze: maze,
              depth: 2,
              color: new Color(0,0,1)
            });
          }
        }*/

      //click
      case 'left':
        player.move(event_name);
      case 'right':
        player.move(event_name);
      case 'up':
        player.move(event_name);
      case 'down':
        player.move(event_name);
    } //switch
  }
} //Main
