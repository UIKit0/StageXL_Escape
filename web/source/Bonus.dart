part of escape;

class Bonus extends Sprite
{
  Sprite _textFieldContainer;

  Bonus(int points)
  {
    TextField textField = new TextField();
    textField.defaultTextFormat = new TextFormat("Arial", 30, 0xFFFFFF, bold:true, align:TextFormatAlign.CENTER);
    textField.width = 110;
    textField.height = 36;
    textField.wordWrap = false;
    //textField.selectable = false;
    textField.x = 646;
    textField.y = 130;
    //textField.filters = [new GlowFilter(0x000000, 1.0, 2, 2)]; // ToDo
    textField.mouseEnabled = false;
    textField.text = points.toString();
    textField.x = - textField.width / 2;
    textField.y = - textField.height / 2;

    _textFieldContainer = new Sprite();
    _textFieldContainer.addChild(textField);
    addChild(_textFieldContainer);

    //-------------------------------------------------

    Transition transition = new Transition(0.0, 1.0, 1.5, Transitions.easeOutCubic);

    transition.onUpdate = (value) {
      _textFieldContainer.alpha = 1 - value;
      _textFieldContainer.y = - value * 50;
      _textFieldContainer.scaleX = 1.0 + 0.1 * sin(value * 10);
      _textFieldContainer.scaleY = 1.0 + 0.1 * cos(value * 10);
    };

    transition.onComplete = () {
      this.removeFromParent();
    };

    renderJuggler.add(transition);
  }

}