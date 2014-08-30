import com.haxepunk.Scene;
import com.haxepunk.HXP;

import entities.BallEntity;
import entities.BrickEntity;
import entities.PaddleEntity;

class MainScene extends Scene
{
	public override function begin()
	{
		addBricks([
			{x: 50, y: 10},{x: 150, y: 10},{x: 250, y: 10},{x: 350, y: 10},{x: 450, y: 10},{x: 550, y: 10},
			{x: 50, y: 30},{x: 150, y: 30},{x: 250, y: 30},{x: 350, y: 30},{x: 450, y: 30},{x: 550, y: 30}
		]);
		addPaddle();
		addBall();
	}

	private function addBricks(data:Array<Dynamic>)
	{
		for(i in 0...data.length)
			this.add(new BrickEntity(data[i].x, data[i].y));
	}

	private function addPaddle()
	{
		this.add(new PaddleEntity(HXP.width / 2, HXP.height - 20));
	}

	private function addBall()
	{
		this.add(new BallEntity(HXP.width / 2, HXP.height - 40));
	}
}