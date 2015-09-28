
import luxe.Vector;
import luxe.Sprite;
import luxe.Color;

class Maze  {

  public var width : Int;
  public var height : Int;
  var cellSize : Int;
  public var cells : Map<String,Cell>;
  public var pos : Vector;
  var track : Array<Cell>;

  public function new ( gridSize: Vector, dimCella: Vector, posiz:Vector){

    height = Std.int(gridSize.y); // number of rows
    width = Std.int(gridSize.x); // number of height
    cellSize = Std.int(dimCella.x);
    pos = posiz;

    cells = new Map();
    for( i in 1...(height+1)){ // Create the grid

      for ( k in 1...(width+1)) {

        var c = new Cell( '$i-$k', i, k );
        cells['$i-$k'] = c;
      }
    } //for

    track = [];

    startPath();
  } // new

  public function startPath() {

    var randColumn : Int = Math.ceil(Math.random()*width);
    var randRow : Int = Math.ceil(Math.random()*height);
    var name : String = Std.string(randRow)+"-"+Std.string(randColumn);

    var cell : Cell = cells[name];

    if ( cell.visited == false && cell.isBorder == false ) {

      makePath(cell);
    }
    else {

      startPath();
    }

  }

  public function makePath(fromCell: Cell) {

    fromCell.visit();

    var neigh = fromCell.getNeighbours(cells); // returned[0] = cell adjacent, returned[1] = cell 1 apart

    if (neigh.length>0){ // are there any neighbours?
      var randNeigh : Int = Math.floor(Math.random()*neigh.length);
      var nextCell : Cell = neigh[randNeigh][1];
      neigh[randNeigh][0].visit(); // break the wall
      track.push(fromCell); // add to list of visited cells
      makePath(nextCell); // continue the path

    } else if ( track.length>0) { // are there any previously visited cells?

      var nextCell = track.pop(); // the last element that we visited
      makePath(nextCell);
    }
    else if ( track.length == 0) {

      trace("Completed");
      completed();
    }
  } // makePath

  var boxArray : Array<phoenix.geometry.QuadGeometry> = [];
  function completed(){

    for ( cell in cells ) {

        var b = cell.drawCell(cellSize,pos);
        boxArray.push(b);
    }
  } // completed

  public function reset() {

    trace("Resetting");
    for ( box in boxArray ) {

      box.drop(); // remove the box from the batcher
    }
  }
} // Maze
