part of escape;

class Alarm extends Sprite
{
  List<BitmapData> _alarmBitmapDatas;
  Bitmap _alarmBitmap;

  Sound _warning;
  SoundChannel _warningChannel;
  Transition _transition;

  //--------------------------------------------------------------------------------------------

  Alarm()
  {
    _warning = Sounds.resource.getSound("Warning");
    _warningChannel = null;

    _alarmBitmapDatas = Grafix.getAlarms();
    _alarmBitmap = new Bitmap(_alarmBitmapDatas[0]);

    addChild(_alarmBitmap);
  }

  //--------------------------------------------------------------------------------------------

  void start()
  {
    _warningChannel = _warning.play();

    renderJuggler.remove(_transition);

    _transition = new Transition(0, 80, 9.0, TransitionFunction.linear);

    _transition.onUpdate = (value) {
      int frame = value.toInt() % 8;
      _alarmBitmap.bitmapData = _alarmBitmapDatas[(frame <= 4) ? frame + 1 : 8 - frame];
    };

    renderJuggler.add(_transition);
  }

  void stop()
  {
    if (_warningChannel != null)
    {
      _warningChannel.stop();
      _warningChannel = null;
    }

    renderJuggler.remove(_transition);
    _alarmBitmap.bitmapData = _alarmBitmapDatas[0];
  }

}