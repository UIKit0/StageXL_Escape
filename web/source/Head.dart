part of escape;

class Head extends Sprite
{
  List<BitmapData> _headBitmapDatas;
  Bitmap _headBitmap;

  Transition _nodTransition;

  //--------------------------------------------------------------------------------------------

  Head()
  {
    _headBitmapDatas = Grafix.getHeads();

    _headBitmap = new Bitmap(_headBitmapDatas[0]);
    _headBitmap.x = -_headBitmap.width / 2;
    _headBitmap.y = -_headBitmap.height / 2;

    addChild(_headBitmap);

    _nodTransition = null;
  }

  //--------------------------------------------------------------------------------------------

  void nod(int count)
  {
    renderJuggler.remove(_nodTransition);

    _nodTransition = new Transition(0, count, 0.5 * count, TransitionFunction.linear);

    _nodTransition.onUpdate = (value) {
      int frame = ((value * _headBitmapDatas.length) % _headBitmapDatas.length).toInt();
      _headBitmap.bitmapData = _headBitmapDatas[frame];
      _headBitmap.y = sin(value * 2 * PI) * 3 - _headBitmap.height / 2;
    };

    renderJuggler.add(_nodTransition);
  }

  void nodStop()
  {
    renderJuggler.remove(_nodTransition);
    _headBitmap.bitmapData = _headBitmapDatas[0];
  }

}