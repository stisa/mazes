
import luxe.Color;
import luxe.Vector;

class Cell {

  public var name : String;
  public var row : Int;
  public var column : Int;
  public var visited : Bool = false;
  public var neighbours : Array<Array<Cell>>;
  public var isBorder : Bool;
  public var isFirst : Bool = false;
  public var isLast : Bool = false;

  public function new ( nome: String, riga: Int, colonna: Int, maze_righe, maze_colonne) {

    row = riga;
    column = colonna;

    if ( row == 1 || column == 1  || row == maze_righe || column == maze_colonne ) { // FIXME: Should also avoid last row/column
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

    // neighbour cells 1 cell away
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

  public var box : phoenix.geometry.QuadGeometry;
  public function drawCell(cellSize: Vector, maze_pos: Vector) {

    var colore : Color = new Color(1,1,1);
    if ( visited ) {

      colore = new Color(0,0,0);
    }
    if ( isFirst ){

      colore = new Color(1,0,0);
    }
    if ( isLast ){

      colore = new Color(0,1,0);
    }

    box = Luxe.draw.box({
      x: maze_pos.x+column*(cellSize.x+2),
      y: maze_pos.y+row*(cellSize.y+2),
      w: cellSize.x,
      h: cellSize.y,
      color : colore
    });
    return box;
  }
}
