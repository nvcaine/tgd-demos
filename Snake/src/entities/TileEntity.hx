package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

import scenes.MatrixScene;

class TileEntity extends Entity
{
	public var line:Int;
	public var col:Int;

	public function new(line:Int, col:Int)
	{
		super(0, 0);

		this.line = line;
		this.col = col;
	}

	override public function added()
	{
		var tileSize:Int = getScene().getTileSize();

		graphic = Image.createRect(tileSize, tileSize, 0x00FF00);

		this.y = getScene().getXYByLineCol(line);
		this.x = getScene().getXYByLineCol(col);
	}

	private function getScene():MatrixScene
	{
		return cast(scene, MatrixScene);
	}
}