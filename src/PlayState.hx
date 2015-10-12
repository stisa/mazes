import luxe.States;
import luxe.Vector;
import luxe.Color;
import luxe.Vector.Vec;
import luxe.Input;

class PlayState extends State {

  var upButton : BoundButton;
  var downButton : BoundButton;
  var rightButton : BoundButton;
  var leftButton : BoundButton;
  var closeButton : BoundButton;
  var cellSize : Vector = new Vector(14,14);
  var maze : Maze;
  var gridSize : Vector;

  override function onenter<T>(_:T){
    trace("entering "+this.name);
    if (Luxe.snow.platform == 'web') {
      gridSize = new Vector( (Luxe.screen.w-280)/cellSize.x, ( Luxe.screen.h-256 )/cellSize.y );
      createDesktopControls();
    } else {
      gridSize = new Vector( (Luxe.screen.w-200)/cellSize.x, ( Luxe.screen.h-340 )/cellSize.y );
      createDesktopControls();
    }
    maze = new Maze({ name: 'grid', gridSize: gridSize, cellSize: cellSize, pos: new Vector(4*cellSize.x,4*cellSize.y) });
  }

  function createControls() {

    upButton = new BoundButton({
      name: "up",
      pos: new Vector(260,1220),
      texture: Luxe.resources.texture('assets/up.png')
    });
    downButton = new BoundButton({
      name: "down",
      pos: new Vector(440,1195),
      texture: Luxe.resources.texture('assets/down.png')
    });
    leftButton = new BoundButton({
      name: "left",
      pos: new Vector(88,1210),
      texture: Luxe.resources.texture('assets/left.png')
    });
    rightButton = new BoundButton({
      name: "right",
      pos: new Vector(632,1210),
      texture: Luxe.resources.texture('assets/right.png')
    });

    // Bind mouse/touch controls
    //if target == mobile
    Luxe.input.bind_mouse('left', MouseButton.left);
    Luxe.input.bind_mouse('right', MouseButton.left);
    Luxe.input.bind_mouse('up', MouseButton.left);
    Luxe.input.bind_mouse('down', MouseButton.left);

  }

  function createDesktopControls() {

    upButton = new BoundButton({
      name: "up",
      pos: Luxe.screen.mid + new Vec(-64,Luxe.screen.mid.y-60),
      texture: Luxe.resources.texture('assets/up.png')

    });
    downButton = new BoundButton({
      name: "down",
      pos: Luxe.screen.mid + new Vec(64,Luxe.screen.mid.y-60),
      //pos: new Vector(440,635),
      texture: Luxe.resources.texture('assets/down.png')
    });
    leftButton = new BoundButton({
      name: "left",
      pos: Luxe.screen.mid + new Vec(-192,Luxe.screen.mid.y-60),
      //pos: new Vector(88,635),
      texture: Luxe.resources.texture('assets/left.png')
    });
    rightButton = new BoundButton({
      name: "right",
      pos: Luxe.screen.mid + new Vec(192,Luxe.screen.mid.y-60),
      //pos: new Vector(632,635),
      texture: Luxe.resources.texture('assets/right.png')
    });
    closeButton = new BoundButton({
      name: "close",
      pos: new Vec(Luxe.screen.w-40,42),
      texture: Luxe.resources.texture('assets/close.png')
      //size: new Vector(96,64),
      //color: new Color(1,0.2,0.2)
    });

    // Bind mouse/touch controls
    //if target == mobile
    Luxe.input.bind_mouse('left', MouseButton.left);
    Luxe.input.bind_mouse('right', MouseButton.left);
    Luxe.input.bind_mouse('up', MouseButton.left);
    Luxe.input.bind_mouse('down', MouseButton.left);
    Luxe.input.bind_mouse('reset', MouseButton.left);

    if (Luxe.snow.platform  == 'desktop' || Luxe.snow.platform  == 'web' ) {
      Luxe.input.bind_key('click', Key.space);
      Luxe.input.bind_key('left', Key.key_a);
      Luxe.input.bind_key('right', Key.key_d);
      Luxe.input.bind_key('up', Key.key_w);
      Luxe.input.bind_key('down', Key.key_s);
      Luxe.input.bind_key('reset', Key.key_r);

    }

  }
  override function oninputup ( event_name:String, e:InputEvent ) {
    if (e.type == mouse) {
      switch( event_name ) {
      /*
     case 'click':
          if ( mazeButton.point_inside_AABB(e.mouse_event.pos) ) {
              this.machine.set('play');
              //this.machine.unset(this);
              maze = new Maze({ name: 'grid', gridSize: gridSize, cellSize: cellSize, pos: new Vector(4*cellSize.x,4*cellSize.y) });
          }
          if ( resetButton.point_inside_AABB(e.mouse_event.pos) ) {
            //this.machine.current_state.unset();
            //Reset the scene
            trace("res");
            maze.reset();
            //maze_once = false;
          }
          */
        //control click
        case 'reset':
          if ( closeButton.point_inside_circle(e.mouse_event.pos) ) {
            //Reset the scene
            trace("res");
            maze.reset();
          }
        case 'left':
          if ( maze.player != null && leftButton.point_inside_circle(e.mouse_event.pos) ) {

            maze.player.move(event_name);
          }
        case 'right':
          if ( maze.player != null && rightButton.point_inside_circle(e.mouse_event.pos) ) {

            maze.player.move(event_name);
          }
        case 'up':
          if ( maze.player != null && upButton.point_inside_circle(e.mouse_event.pos) ) {

            maze.player.move(event_name);
          }
        case 'down':
          if ( maze.player != null && downButton.point_inside_circle(e.mouse_event.pos) ) {

            maze.player.move(event_name);
          }

      } //switch
    } //MouseEvent

    if (e.type == keys) {
      switch( event_name ) {
        case 'left':
            maze.player.move(event_name);
        case 'right':
            maze.player.move(event_name);
        case 'up':
            maze.player.move(event_name);
        case 'down':
            maze.player.move(event_name);
        case 'reset':
            //reset maze
      }  //switch
    } //Key
  }

} //PlayState
