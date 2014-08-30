package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class BrickEntity extends Entity
{
	override public function added()
	{
		var image:Image = Image.createRect(100, 20, getRandomColor());

		image.centerOrigin();

		graphic = image;

		type = "brick";

		setHitbox(image.width, image.height);
	}

	override public function update()
	{
		if(collide("ball", x, y) != null)
			scene.remove(this);
	}

	private function getRandomColor()
	{
		var A:Int = 1;
		var R:Int = Std.random(255);
		var G:Int = Std.random(255);
		var B:Int = Std.random(255);

		return (A & 0xFF) << 24 | (R & 0xFF) << 16 | (G & 0xFF) << 8 | (B & 0xFF);
	}
}