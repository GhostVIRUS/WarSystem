-- ������ ��� �������� War System

--=================--
--= �����: ����1 =--
--=================--

classes.player1 =
{
  -- game properties --

  display     = "�����",
  health      = 2000,
  percussion  = 10,
  fragility   = 1,


  -- physical properties --

  width     = 37,
  length    = 50,

  mass      = 1.5,
  inertia   = 750.0,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {1200, 45},        -- engine power: linear,angular
  max_speed = {800,  3.4},        -- max speed: linear, angular
}

--======================--
--= ���� ���������� �1 =--
--======================--

classes.boss1 =
{
  -- game properties --

  display     = "������ ����",
  health      = 1775,
  percussion  = 10,
  fragility   = 1,


  -- physical properties --

  width     = 42,
  length    = 40,

  mass      = 1.5,
  inertia   = 800.0,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {900, 45},        -- engine power: linear,angular
  max_speed = {200,  3.4},        -- max speed: linear, angular
}


--======================--
--= ������o� ��������� =--
--======================--

classes.ekivator1 =
{
  -- game properties --

  display     = "��������",
  health      = 1200,
  percussion  = 10,
  fragility   = 1,


  -- physical properties --

  width     = 39,
  length    = 38,

  mass      = 1.2,
  inertia   = 750.0,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {900, 45},        -- engine power: linear,angular
  max_speed = {200,  3.4},        -- max speed: linear, angular
}

--=============--
--= ��������� =--
--=============--

classes.rebel =
{
  -- game properties --

  display     = "���������",
  health      = 999,
  percussion  = 1,
  fragility   = 10,


  -- physical properties --

  width     = 39,
  length    = 38,

  mass      = 1.2,
  inertia   = 800.0,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {900, 45},        -- engine power: linear,angular
  max_speed = {200,  3.4},        -- max speed: linear, angular
}

--==========--
--= ������ =--
--==========--

classes.camera =
{
  -- game properties --

  display     = "������",
  health      = 0,
  percussion  = 0,
  fragility   = 0,


  -- physical properties --

  width     = 0,
  length    = 0,

  mass      = 99999,
  inertia   = 1,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {1, 1},        -- engine power: linear,angular
  max_speed = {1,  1},        -- max speed: linear, angular
}

--==========--
--= ����������� =--
--==========--

classes.speak =
{
  -- game properties --

  display     = "�����������",
  health      = 100000,
  percussion  = 10,
  fragility   = 1,


  -- physical properties --

  width     = 0,
  length    = 0,

  mass      = 99999,
  inertia   = 100000,

  dry_fric  = {450, 5000, 28},   -- dry friction: x,y,angular
  vis_fric  = {2.0,  2.5,  0},   -- viscous friction: x,y,angular

  power     = {1, 1},        -- engine power: linear,angular
  max_speed = {1,  1},        -- max speed: linear, angular
}
--��� �� ����� 100%
classes["speak"] = tcopy(classes.player1)
classes["speak"].inertia = 100000;
classes["speak"].power[1] = 1; 
classes["speak"].power[2] = 2;
classes["speak"].max_speed[1]=1;
classes["speak"].max_speed[2]=2;


--for i = 1, 100 classes["class"..i] = tcopy(classes.player1) end