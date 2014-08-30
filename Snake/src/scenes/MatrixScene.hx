package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

import entities.TileEntity;

class MatrixScene extends Scene
{
	private var lines:Int = 0;
	private var cols:Int = 0;
	private var size:Int = 0;
	private var speed:Float = 0.125;
	private var delay:Float = 0.125;

	private var snake:Array<TileEntity>;
	private var dot:TileEntity;

	private var lineVelocity:Int = 0;
	private var colVelocity:Int = -1;

	private var dead:Bool = false;

	public function new(lines:Int, cols:Int, size: Int)
	{
		super();

		this.lines = lines;
		this.cols = cols;
		this.size = size;

		snake = new Array<TileEntity>();
		dot = new TileEntity(0, 0);
	}

	override public function begin()
	{
		snake.push(new TileEntity(24, 20));
		snake.push(new TileEntity(24, 21));
		snake.push(new TileEntity(24, 22));
		snake.push(new TileEntity(24, 23));
		snake.push(new TileEntity(24, 24));

		for(i in 0...snake.length)
			add(snake[i]);

		randomizeDot();
		add(dot);
	}

	override public function update()
	{
		if(dead)
			return;
	
		if(delay < 0)
		{
			delay = speed;

			updateSnake();
			checkCollision();
		}

		checkInput();
		delay -= HXP.elapsed;
	}


	public function getXYByLineCol(coord:Int):Int
	{
		return coord * size;
	}

	public function getTileSize():Int
	{
		return size;
	}

	private function checkInput()
	{
		if(Input.check(Key.LEFT) && lineVelocity != 0)
		{
			colVelocity = -1;
			lineVelocity = 0;
		}

		if(Input.check(Key.RIGHT) && lineVelocity != 0)
		{
			colVelocity = 1;
			lineVelocity = 0;
		}

		if(Input.check(Key.UP) && colVelocity != 0)
		{
			colVelocity = 0;
			lineVelocity = -1;
		}

		if(Input.check(Key.DOWN) && colVelocity != 0)
		{
			colVelocity = 0;
			lineVelocity = 1;
		}
	}

	/*
	Remove the last snake part from the list,
	update its position using the current direction
	*/

	private function updateSnake()
	{
		var lastTile:TileEntity = snake.pop();
		var firstTile:TileEntity = snake[0];

		this.remove(lastTile);

		lastTile.col = firstTile.col + colVelocity;
		lastTile.line = firstTile.line + lineVelocity;

		if(lastTile.col >= cols)
			lastTile.col = 0;

		if(lastTile.col < 0)
			lastTile.col = cols - 1;

		if(lastTile.line >= lines)
			lastTile.line = 0;

		if(lastTile.line < 0)
			lastTile.line = lines - 1;

		snake.unshift(lastTile);

		add(lastTile);
	}

	/*
	If the next position is taken by the dot,
	add a new TileEntity instance to the front of the array,
	then update the dot.
	*/
	private function checkCollision()
	{
		var head:TileEntity = snake[0];

		if((head.line + lineVelocity == dot.line && head.col == dot.col) || 
			(head.col + colVelocity == dot.col && head.line == dot.line))
		{
			snake.unshift(new TileEntity(dot.line, dot.col));
			add(snake[0]);
			randomizeDot();

			playSound("audio/jump.mp3");
		}

		/*for(i in 1...snake.length)
			if((head.line + lineVelocity == snake[i].line && head.col == snake[i].col) || 
				(head.col + colVelocity == snake[i].col && head.line == snake[i].line))
			{
				dead = true;
				return;
			}*/
	}

	private function playSound(sound:String)
	{
		var sound:Sfx = new Sfx(sound);

		sound.play();
	}

	private function randomizeDot()
	{
		var newLine:Int;
		var newCol:Int;
		var valid:Bool;

		do
		{
			valid = true;
			newLine = Std.random(lines - 1);
			newCol = Std.random(cols - 1);

			for(i in 0...snake.length)
				if(snake[i].line == newLine && snake[i].col == newCol)
				{
					valid = false;
					break;
				}
		}
		while(!valid);

		remove(dot);

		dot.line = newLine;
		dot.col = newCol;

		add(dot);
	}
}