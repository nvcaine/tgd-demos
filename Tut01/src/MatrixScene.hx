import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MatrixScene extends Scene
{
	private var lines:Int;
	private var cols:Int;
	private var size:Int;

	private var lineDir:Int = 0;
	private var colDir:Int = 1;
	private var snake:Array<TileEntity>;

	private var delay:Float = 0.3;

	private var food:TileEntity;

	public function new(numLines:Int, numCols:Int, size:Int)
	{
		super();

		this.lines = numLines;
		this.cols = numCols;
		this.size = size;

		snake = new Array<TileEntity>();
	}

	override public function begin()
	{
		snake.push(new TileEntity(1, 3));
		snake.push(new TileEntity(1, 2));
		snake.push(new TileEntity(1, 1));

		add(snake[0]);
		add(snake[1]);
		add(snake[2]);

		initFood();
	}

	override public function update()
	{
		delay -= HXP.elapsed;

		if(delay <= 0)
		{
			moveSnake();
			delay = 0.3;
		}

		checkInput();
		checkCollision();
	}

	public function convertLineCol(value:Int):Int
	{
		return value * size;
	}

	private function moveSnake()
	{
		var lastTile:TileEntity = snake.pop();
		var newLine:Int = snake[0].line + lineDir;
		var newCol:Int = snake[0].col + colDir;

		if(newLine >= lines)
			newLine = 0;
		if(newLine < 0)
			newLine = lines - 1;
		if(newCol >= cols)
			newCol = 0;
		if(newCol < 0)
			newCol = cols - 1;

		remove(lastTile);

		lastTile.line = newLine;
		lastTile.col = newCol;

		snake.unshift(lastTile);
		add(lastTile);
	}

	private function checkInput()
	{
		if(Input.check(Key.UP) && lineDir == 0)
		{
			colDir = 0;
			lineDir = -1;
		}
		if(Input.check(Key.DOWN) && lineDir == 0)
		{
			colDir = 0;
			lineDir = 1;
		}
		if(Input.check(Key.LEFT) && colDir == 0)
		{
			colDir = -1;
			lineDir = 0;
		}
		if(Input.check(Key.RIGHT) && colDir == 0)
		{
			colDir = 1;
			lineDir = 0;
		}
	}

	private function checkCollision()
	{
		var head:TileEntity = snake[0];

		if(head.line + lineDir == food.line && head.col + colDir == food.col)
		{
			var newEntity:TileEntity = new TileEntity(food.line, food.col);

			remove(food);

			snake.unshift(newEntity);
			add(newEntity);

			initFood();
		}
	}

	private function initFood()
	{
		var line:Int = Std.random(lines);
		var col:Int = Std.random(cols);

		food = new TileEntity(line, col);

		add(food);
	}
}