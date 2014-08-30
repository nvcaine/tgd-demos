package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class PaddleEntity extends Entity
{
	override public function added()
	{
		initGraphic();

		type = "paddle";
	}

	override public function update()
	{
		if(Input.check(Key.LEFT))
			x -= 10;
		if(Input.check(Key.RIGHT))
			x += 10;
	}

	private function initGraphic()
	{
		var image:Image = Image.createRect(100, 20, 0x00DD00);

		image.centerOrigin();

		graphic = image;

		setHitbox(image.width, image.height);
	}
}