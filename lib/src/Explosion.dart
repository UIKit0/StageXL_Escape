part of escape;

class ExplosionParticle {
  Bitmap bitmap;
  num startX;
  num startY;
  num angle;
  num velocity;
  num rotation;
}

class Explosion extends Sprite implements Animatable {

  List<ExplosionParticle> _particles;
  num _currentTime;

  Explosion(ResourceManager resourceManager, Juggler juggler, int color, int direction) {

    _particles = new List<ExplosionParticle>();
    _currentTime = 0.0;

    this.mouseEnabled = false;

    Bitmap chain = Grafix.getChain(resourceManager, color, direction);
    Random random = new Random();

    num angle;
    num velocity;
    num rotatation;

    for(int y = 0; y <= 1; y++) {
      for(int x = 0; x <= 1; x++) {

        if (x == 0 && y == 0) { angle = PI * 1.15; rotation = - PI * 2; }
        if (x == 1 && y == 0) { angle = PI * 1.85; rotation = PI * 2; }
        if (x == 1 && y == 1) { angle = PI * 0.15; rotation = PI * 2; }
        if (x == 0 && y == 1) { angle = PI * 0.85; rotation = - PI * 2; }

        angle = angle + 0.2 * PI * random.nextDouble();
        velocity = 80.0 + 40.0 * random.nextDouble();

        Bitmap bitmap = new Bitmap(chain.bitmapData);
        bitmap.clipRectangle = new Rectangle(x * 25, y * 25, 25, 25);
        bitmap.pivotX = 12.5 + x * 25;
        bitmap.pivotY = 12.5 + y * 25;
        bitmap.x = x * 25;
        bitmap.y = y * 25;
        addChild(bitmap);

        ExplosionParticle particle = new ExplosionParticle();
        particle.bitmap = bitmap;
        particle.startX = x * 25 + 12.5;
        particle.startY = y * 25 + 12.5;
        particle.angle = angle;
        particle.velocity = velocity;
        particle.rotation = rotation;

        _particles.add(particle);
      }
    }
  }

  //----------------------------------------------------------------------------------------------------------

  bool advanceTime(num time) {

    _currentTime = min(0.8, _currentTime + time);

    num gravity = 981.0;

    for(var particle in _particles) {

      var bitmap = particle.bitmap;
      var angle = particle.angle;
      var velocity = particle.velocity;
      var rotation = particle.rotation;
      var posX = particle.startX + _currentTime * (cos(angle) * velocity);
      var posY = particle.startY + _currentTime * (sin(angle) * velocity + _currentTime * gravity * 0.5);

      bitmap.x = posX;
      bitmap.y = posY;
      bitmap.rotation = _currentTime * rotation;
    }

    if (_currentTime >= 0.6) {
      this.alpha = (0.8 - _currentTime) / 0.2;
    }

    if (_currentTime >= 0.8) {
      this.removeFromParent();
    }

    return (_currentTime < 0.8);
  }

}