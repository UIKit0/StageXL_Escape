part of escape;

class Transition implements Animatable
{
  TransitionFunction _transitionFunction;

  Function _onStart;
  Function _onUpdate;
  Function _onComplete;

  num _startValue;
  num _targetValue;
  num _totalTime;
  num _currentTime;
  num _delay;
  bool _roundToInt;
  bool _started;

  Transition(num startValue, num targetValue, num time, [TransitionFunction transitionFunction = null])
  {
    _transitionFunction = (transitionFunction != null) ? transitionFunction : Transitions.linear;

    _startValue = startValue;
    _targetValue = targetValue;
    _currentTime = 0.0;
    _totalTime = max(0.0001, time);
    _delay = 0.0;
    _roundToInt = false;
    _started = false;
  }

  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------

  bool advanceTime(num time)
  {
    if (_currentTime < _totalTime || _started == false)
    {
      _currentTime = _currentTime + time;

      if (_currentTime > _totalTime)
        _currentTime = _totalTime;

      if (_currentTime >= 0.0)
      {
        if (_started == false) {
          _started = true;

          if (_onStart != null)
            _onStart();
        }

        if (_onUpdate != null) {
          num ratio = _currentTime / _totalTime;
          num transition = _transitionFunction(ratio);
          num value = _startValue + transition * (_targetValue - _startValue);

          _onUpdate(_roundToInt ? value.round() : value);
        }

        if (_onComplete != null && _currentTime == _totalTime) {
          _onComplete();
        }
      }
    }

    return _currentTime < _totalTime;
  }

  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------

  num get totalTime => _totalTime;
  num get currentTime => _currentTime;
  num get delay => _delay;
  bool get roundToInt => _roundToInt;
  bool get isComplete => _currentTime >= _totalTime;

  set delay(num value)
  {
    if (_started == false)
      _currentTime = _currentTime + _delay - value;

    _delay = value;
  }

  set roundToInt(bool value)
  {
    _roundToInt = value;
  }

  //-------------------------------------------------------------------------------------------------

  Function get onStart => _onStart;
  Function get onUpdate => _onUpdate;
  Function get onComplete => _onComplete;

  void set onStart(Function value) { _onStart = value; }
  void set onUpdate(Function value) { _onUpdate = value; }
  void set onComplete(Function value) { _onComplete = value; }
}
