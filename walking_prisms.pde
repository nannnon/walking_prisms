final int FieldWidth = 30;
final int FieldHeight = 30;
final float Gap = 1;
final int PrismsNum = round(FieldWidth * FieldHeight * 0.98);

ArrayList<Prism> g_prisms = new ArrayList<Prism>();
int g_counter = 0;
float g_t = 0;

void setup()
{
  // X← Y↓ Z↑
  size(2048, 2048, P3D);
  perspective(PI / 3, float(width) / float(height), 0.1, 1000);
  
  // 角柱を追加
  for (int i = 0; i < PrismsNum; ++i)
  {
    int x = 0, z = 0;
    do
    {
      x = int(random(FieldWidth));
      z = int(random(FieldHeight));
    }
    while (PrismExists(g_prisms, x, z));
    
    g_prisms.add(new Prism(x, z));
  }
}

void draw()
{
  lights();
  directionalLight(255, 255, 255, 1, 1, -1);
  background(0);
  
  float w = FieldWidth * (Prism.Length + Gap) - Gap;
  float h = 1;
  float d = FieldHeight * (Prism.Length + Gap) - Gap;
  
  float cameraX = 0;
  float cameraZ = 0;
  if (g_counter < 200)
  {
    ++g_counter;
    final float T = 0;
    cameraX = w / 2 + cos(T) * 50;
    cameraZ = d / 2 + sin(T) * 50;
  }
  else
  {
    g_t += 0.005;
    cameraX = w / 2 + cos(g_t) * 50;
    cameraZ = d / 2 + sin(g_t) * 50;
  }
  camera(cameraX, -30, cameraZ, w / 2, 0, d / 2, 0, 1, 0);
  
  // 地面
  pushMatrix();
  fill(255, 255, 255);
  translate(w / 2, h / 2, d / 2);
  box(w, h, d);
  popMatrix();
  
  // 角柱
  for (Prism p : g_prisms)
  {
    p.Update();
    p.Draw();
  }
  
  saveFrame("frames/######.png");
}
