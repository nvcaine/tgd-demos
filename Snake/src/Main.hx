import com.haxepunk.Engine;
import com.haxepunk.HXP;

import scenes.MatrixScene;

class Main extends Engine
{

	override public function init()
	{
//#if debug
		//HXP.console.enable();
//#end
		HXP.scene = new MatrixScene(25, 25, 20);
	}

	public static function main()
	{
		new Main();
	}
}