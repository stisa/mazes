
import luxe.Component;
import luxe.Vector;

class BoundingCircle extends Component {

  var radius: Float;
  override function init() {

      var vis = cast entity; // should'nt change at runtime, leaving it here for now
      var v1 = vis.geometry.vertices[0].pos;
      var v2 =vis.geometry.vertices[1].pos;

      radius = dist(v1,v2);
      trace(radius);
  }

  function dist(v1:Vector,v2:Vector):Float {
    // looks like vertices[0] is the center of the ngon,
    // this allows us to easily get the radius of the BoundingCircle
    var x = Math.abs(v2.x-v1.x);
    var y = Math.abs(v2.y-v1.y);
    return Math.sqrt((x*x)+(y*y));
  }

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
  }
}
