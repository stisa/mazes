
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.Color;
import luxe.tween.Actuate;

typedef PlayerOptions = {

  > VisualOptions,

  @:optional var cell : Cell;
  @:optional var maze : Maze;
}


class Player extends Visual {

  var cell : Cell;
  var maze : Maze;
  var column : Int;
  var row : Int;
  var pathArray : Array<Cell>;

    override public function new(options: PlayerOptions) {

      if ( options.cell!=null ){

        cell = options.cell;
        row = cell.row;
        column = cell.column;
      }
      if ( options.maze!=null ){

        maze = options.maze;
      }
      pathArray =[];
      pathArray.push(cell);

      super(options);
    }

    public function move(direction : String) {
      var currPos = this.pos;
      var currCell = pathArray[pathArray.length -1]; // current head cell
      switch(direction){
        case 'left':
          --column;
          var next : Cell =maze.cells['$row-$column'];
          if ( next != null && next.isLast ==true ) {
            trace("Goal Reached");
          }
          else if ( next != null && next.visited==true ){
            pathArray.push(next); //update head cell
          }
          else {
            ++column;
          }
        case 'right':
          ++column;
          var next : Cell =maze.cells['$row-$column'];
          if ( next != null && next.isLast ==true ) {
            trace("Goal Reached");
          }
          else if ( next != null && next.visited==true ){
            pathArray.push(next);
          }
          else {
            --column;
          }
        case 'up':
          --row;
          var next : Cell =maze.cells['$row-$column'];
          if ( next != null && next.isLast ==true ) {
            trace("Goal Reached");
          }
          else if ( next != null && next.visited==true ){
            pathArray.push(next);
          }
          else {
            ++row;
          }
        case 'down':
          ++row;
          var next : Cell =maze.cells['$row-$column'];
          if ( next != null && next.isLast ==true ) {
            trace("Goal Reached");
          }
          else if ( next != null && next.visited==true ){
            pathArray.push(next);
          }
          else {
            --row;
          }
      }
      trace(pathArray.length);
      pathArray[pathArray.length -1].box.color = new Color(0,0.8,0.6); // head cell
      pathArray[pathArray.length -2].box.color = new Color(0.88,1,0.88); // make the old head part of the tail
    }

    public function reset(){
      this.destroy();
    }
}
