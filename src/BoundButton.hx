
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.Vector;

typedef BoundButtonOptions = {

  > VisualOptions,

  @:optional var radius : Float;
  @:optional var sides : Int;
}


class BoundButton extends Visual {

  var radius : Float;
  var sides : Int;

  override function new( options:BoundButtonOptions) {
    if(options.radius != null) {
      radius = options.radius;
    }
    if(options.sides != null) {
      sides = options.sides;
    }

    options.geometry = Luxe.draw.ngon({ x: 0, y: 0, solid: true, sides: sides, r: radius });

    super(options);

  } // new

  function dist(v1:Vector,v2:Vector):Float {
    var x = Math.abs(v2.x-v1.x);
    var y = Math.abs(v2.y-v1.y);
    return Math.sqrt((x*x)+(y*y));
  } // dist

  public function point_inside_circle(point:Vector):Bool {
  // If radius > dist(pos,point)
  // => point is inside circle
    var d = dist(pos,point);
    if (radius > d){
      return true;
    }
    else {
      return false;
    }
  } // point_inside_circle
}
