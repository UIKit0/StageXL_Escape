library escape;

import 'dart:async';
import 'dart:math';
import 'package:stagexl/stagexl.dart';

part 'src/Alarm.dart';
part 'src/Board.dart';
part 'src/BoardEvent.dart';
part 'src/BoardStatus.dart';
part 'src/Bonus.dart';
part 'src/ExitBox.dart';
part 'src/Explosion.dart';
part 'src/Field.dart';
part 'src/Game.dart';
part 'src/Grafix.dart';
part 'src/Head.dart';
part 'src/InfoBox.dart';
part 'src/Lock.dart';
part 'src/MessageBox.dart';
part 'src/Special.dart';
part 'src/SpecialJokerChain.dart';
part 'src/SpecialJokerLink.dart';
part 'src/SpecialWobble.dart';
part 'src/ValueCounter.dart';

class Escape extends Sprite {

  ResourceManager _resourceManager;
  Juggler _juggler;

  Escape(ResourceManager resourceManager) {
    _resourceManager = resourceManager;
    this.onAddedToStage.listen(_onAddedToStage);
  }

  _onAddedToStage(Event e) {
    _juggler = stage.juggler;
    var game = new Game(_resourceManager, _juggler);
    addChild(new Bitmap(_resourceManager.getBitmapData("Background")));
    addChild(game);
    game.start();
  }
}


