import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

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
		var newY:Int = cast(scene, MatrixScene).convertLineCol(line);
		var newX:Int = cast(scene, MatrixScene).convertLineCol(col);

		graphic = Image.createRect(20, 20, 0x00FF00);

		x = newX;
		y = newY;
	}
}