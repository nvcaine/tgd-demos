import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class MainScene extends Scene
{
	public override function begin()
	{
		var e:Entity = new Entity(100, 100);

		e.graphic = Image.createCircle(50, 0x00FF00);

		this.add(e);
	}
}