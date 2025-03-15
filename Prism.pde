class Prism
{
  static final float Length = 1;
  final float Velocity = 0.1;
  
  int _x;
  int _z;
  float _xf;
  float _zf;
  final color _color;
  
  boolean _moving;
  float _vx;
  float _vz;
  
  int _fromx;
  int _fromz;
  
  Prism(int x, int z)
  {
    _x = x;
    _xf = x * (Length + Gap);
    _z = z;
    _zf = z * (Length + Gap);
    _color = color(random(256), random(256), random(256));
    _moving = false;
    _vx = 0;
    _vz = 0;
    _fromx = x;
    _fromz = z;
  }
  
  boolean Exist(int x, int z)
  {
    if ((x == _x && z == _z) ||
        (x == _fromx && z == _fromz))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void Update()
  {
    if (_moving)  // 移動中
    {
      _xf += _vx;
      _zf += _vz;
      
      final float Margin = 0.01;
      float xf = _xf / (Length + Gap);
      float zf = _zf / (Length + Gap);
      if (abs(_x - xf) <= Margin &&
          abs(_z - zf) <= Margin )
      {
        _xf = _x * (Length + Gap);
        _zf = _z * (Length + Gap);
        _vx = 0;
        _vz = 0;
        _fromx = _x;
        _fromz = _z;
        _moving = false;
      }
    }
    else  // 停止中
    {
      // 移動の方向
      int dir = int(random(4));  // 0:↑, 1:→, 2:↓, 3:←
      int dx = 0, dz = 0;
      switch (dir)
      {
        case 0: dx =  0; dz =  1; break;
        case 1: dx =  1; dz =  0; break;
        case 2: dx =  0; dz = -1; break;
        case 3: dx = -1; dz =  0; break;
        default : print("Invalid dir"); break;
      }
      
      // 移動先がフィールド内かどうか
      int tarx = _x + dx;
      int tarz = _z + dz;
      if (tarx >= 0 && tarx < FieldWidth &&
          tarz >= 0 && tarz < FieldHeight)
      {
        // 空いているか
        if (!PrismExists(g_prisms, tarx, tarz))
        {
          // 移動フラグを立てる
          _x = tarx;
          _z = tarz;
          _vx = dx * Velocity;
          _vz = dz * Velocity;
          _moving = true;
        }
      }
    }
  }
  
  void Draw()
  {
    pushMatrix();
    
    fill(_color);
    final float H = 1;
    translate(_xf + Length / 2, -H / 2, _zf + Length / 2);
    box(Length, H, Length);
    
    popMatrix();
  }
}
