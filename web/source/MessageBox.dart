part of escape;

class MessageBox extends Sprite
{
  DelayedCall _showTimeout;
  Function _doneFunction;

  MessageBox(String text)
  {
    Bitmap background = new Bitmap(Grafix.resource.getBitmapData("MessageBox"));
    addChild(background);

    TextField textField = new TextField();
    textField.defaultTextFormat = new TextFormat("Arial", 24, 0xFFFFFF, bold:true, align:TextFormatAlign.CENTER);
    textField.width = 240;
    textField.height = 200;
    textField.wordWrap = true;
    //textField.selectable = false;
    textField.text = text;
    textField.x = 47;
    textField.y = 130 - textField.textHeight / 2;
    //textField.filters = [new GlowFilter(0x000000, 0.7, 3, 3)];   // ToDo
    textField.mouseEnabled = false;
    addChild(textField);

    _showTimeout = null;

    addEventListener(MouseEvent.CLICK, _onClick);
  }

  //----------------------------------------------------------------------
  //----------------------------------------------------------------------

  void show(Function doneFunction)
  {
    this.parent.addChild(this);  // move to top
    this.x = - this.width;
    this.y = 150;

    _doneFunction = doneFunction;

    Tween tween = new Tween(this, 0.3, TransitionFunction.easeOutCubic);
    tween.animate("x", 110);
    tween.onComplete = () => _showTimeout = renderJuggler.delayCall(_hide, 10);

    renderJuggler.add(tween);
  }

  //----------------------------------------------------------------------

  void _hide()
  {
    if (_showTimeout != null)
    {
      renderJuggler.remove(_showTimeout);
      _showTimeout = null;

      _doneFunction();

      Tween tween = new Tween(this, 0.4, TransitionFunction.easeInCubic);
      tween.animate("x", 800);
      tween.onComplete = () => this.parent.removeChild(this);

      renderJuggler.add(tween);
    }
  }

  //----------------------------------------------------------------------

  void _onClick(MouseEvent me)
  {
    _hide();
  }
}
