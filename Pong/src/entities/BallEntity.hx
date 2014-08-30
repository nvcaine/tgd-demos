package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class BallEntity extends Entity
{
	private var angle:Float = Math.PI / 4;
	private var xDir:Float;
	private var yDir:Float;
	private var speed:Float = 5;

	override public function added()
	{
		var image:Image = Image.createCircle(10, 0xDD5500);

		image.centerOrigin();

		graphic = image;

		setHitbox(image.width, image.height);

		xDir = Math.cos(angle);
		yDir = -Math.sin(angle);

		type = "ball";
	}

	override public function moveCollideX(e:Entity):Bool
	{
		yDir = -yDir;

		if(e.type == "brick")
			scene.remove(e);

		return true;
	}

	override public function moveCollideY(e:Entity):Bool
	{
		yDir = -yDir;

		if(e.type == "brick")
			scene.remove(e);

		return true;
	}

	override public function update()
	{
		checkBounds();
		moveBy(xDir * speed, yDir * speed, ["brick", "paddle"]);

		/*var e:Entity = collideTypes(["brick", "paddle"], x, y);

		if(e != null)
			yDir = -yDir;*/
	}

	private function checkBounds()
	{
		if(x > HXP.width - 15 || x < 15)
			xDir = -xDir;
		if(y > HXP.height - 15 || y < 15)
			yDir = -yDir;
	}
}