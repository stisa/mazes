
import luxe.Color;
import luxe.Vector;

class Cell {
  public var name : String;
  public var row : Int;
  public var column : Int;
  public var visited : Bool = false;
  public var neighbours : Array<Array<Cell>>;
  public var isBorder : Bool;

  public function new ( nome: String, riga: Int, colonna: Int) {

    row = riga;
    column = colonna;

    if ( row == 1 || column == 1 ) { // FIXME: Should also avoid last row/column
      isBorder = true;
    } else {
      isBorder = false;
    }

  }

  public function getNeighbours(cells:Map<String,Cell>) {
    neighbours = [];

    // neighbour cells adjacent
    var nameSopra : String = Std.string(row-1)+'-$column';
    var nameSotto : String = Std.string(row+1)+'-$column';
    var nameSx : String = '$row-'+Std.string(column-1);
    var nameDx : String = '$row-'+Std.string(column+1);

    // neighbour cells 1 cells away
    var nameSopra2 : String = Std.string(row-2)+'-$column';
    var nameSotto2 : String = Std.string(row+2)+'-$column';
    var nameSx2 : String = '$row-'+Std.string(column-2);
    var nameDx2 : String = '$row-'+Std.string(column+2);

    var nameArray : Array<Array<String>> = [[nameSopra,nameSopra2],[nameSotto,nameSotto2],[nameSx,nameSx2],[nameDx,nameDx2]];
    //trace(nameArray);//
    for (name in nameArray) {
      var cellD1 : Cell = cells[name[0]];
      var cellD2 : Cell = cells[name[1]];
      if ( cellD2!= null && cellD2.visited == false) {
        var cellArray : Array<Cell> = [cellD1, cellD2];
        neighbours.push(cellArray);
      }
    }
    return neighbours;

  }

  public function visit() {
    visited = true;
  }

  var black = new Color(0,0,0);
  var white = new Color(1,1,1);

  public function drawCell(cellSize:Int, maze_pos: Vector) {

    var colore : Color = white;
    if ( visited == true ) {
      colore = black;
    }
    var box = Luxe.draw.box({
      x: maze_pos.y+column*(cellSize+2),
      y: maze_pos.x+row*(cellSize+2),
      w: cellSize,
      h: cellSize,
      color : colore
    });
    return box;
  }

}