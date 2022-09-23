package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Future;
import openfl.display.BitmapData;
import openfl.utils.Assets;

class Startup extends FlxState
{
	var bg:FlxSprite;
	var loading:FlxText;

	// shit can precache online images and even asset images
	public static var precacheList:Array<String> = [
		'https://media.discordapp.net/attachments/907738207528050718/1020080809056669736/Img_2022_09_15_14_57_53.jpg',
		'https://media.discordapp.net/attachments/907738207528050718/1020066776760995971/unknown.png',
		'https://media.discordapp.net/attachments/907738207528050718/1020068815863824473/unknown.png'
	];

	override function create()
	{
		FlxG.save.bind("Cool Save", "Bushtrain460615");
		SaveData.initSettings();

		FlxG.keys.preventDefaultKeys = [TAB];
		FlxG.game.focusLostFramerate = 30;

		var yScroll:Float = Math.max(0.25 - (0.05 * (length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(AssetPaths.image('bg'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		loading = new FlxText(0, 0, 0, "Loading...", 22);
		loading.setFormat("_sans", 22, FlxColor.WHITE, LEFT);
		loading.screenCenter();
		add(loading);

		for (i in 0...precacheList.length)
		{
			AssetPaths.precacheImage(precacheList[i]);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		var shitDone = AssetPaths.imgsDone + AssetPaths.sndsDone;
		var shitToBeDone = AssetPaths.imgsToBeDone + AssetPaths.sndsToBeDone;

		if (shitDone != shitToBeDone)
		{
			loading.text = shitToBeDone - shitDone + " assets left";
		}

		if (shitDone == shitToBeDone)
		{
			loading.text = "Done!";
		}

		if (loading.text == "Done!")
		{
			new FlxTimer().start(1.5, (twn:FlxTimer) -> FlxG.switchState(new states.MainMenu()));
		}
		super.update(elapsed);
	}
}
