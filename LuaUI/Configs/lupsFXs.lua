-- $Id: lupsFXs.lua 3485 2008-12-19 23:06:30Z jk $

----------------------------------------------------------------------------
-- GROUNDFLASHES -----------------------------------------------------------
----------------------------------------------------------------------------
groundFlash = {
  life       = 40,
  size       = 30,
  sizeGrowth = 7,
  colormap   = { {1, 1, 0.5, 0.3},{1, 1, 0, 0.04},{1, 0.3, 0, 0} }
}

groundFlashBlue = {
  life       = 20,
  size       = 100,
  texture    = "bitmaps/GPL/Lups/groundflash.png",
  colormap   = { {0.5, 0.5, 1.0, 0.3},{0.5, 0.5, 1.0, 0.4},{0.5, 0.5, 1.0, 0.4},{0.5, 0.5, 1.0, 0.3}, },
  repeatEffect = true,
}

groundFlashViolett = {
  life       = 50,
  size       = 80,
  texture    = "bitmaps/GPL/Lups/groundflash.png",
  colormap   = { {0.9, 0.1, 0.9, 0.1},{0.9, 0.1, 0.9, 0.2},{0.9, 0.1, 0.9, 0.2},{0.9, 0.1, 0.9, 0.1}, },
  repeatEffect = true,
}

groundFlashCorestor = {
  life       = 50,
  size       = 80,
  texture    = "bitmaps/notAlab/corestor.png",
  colormap   = { {0.9, 0.9, 0.0, 0.15},{0.9, 0.9, 0.0, 0.20},{0.9, 0.9, 0.0, 0.20},{0.9, 0.9, 0.0, 0.15}, },
  repeatEffect = true,
}
groundFlashArmestor = {
  life       = 50,
  size       = 80,
  texture    = "bitmaps/GPL/Lups/gf_armestor.png",
  colormap   = { {0.9, 0.9, 0.0, 0.2},{0.9, 0.9, 0.0, 0.3},{0.9, 0.9, 0.0, 0.3},{0.9, 0.9, 0.0, 0.2}, },
  repeatEffect = true,
}


----------------------------------------------------------------------------
-- BURSTS ------------------------------------------------------------------
----------------------------------------------------------------------------
corfusBursts = {
  delay      = 30,
  life       = math.huge,
  pos        = {0,40,0},
  rotSpeed   = 0.5,
  rotSpread  = 1,
  rotairdrag = 1,
  arc        = 90,
  arcSpread  = 0,
  size       = 22,
  sizeSpread = 5,
  colormap   = { {0.10, 0.8, 0.8, 0.4} },
  directional= true,
  repeatEffect = true,
  count      = 17,
}

cafusBursts = {
  life       = math.huge,
  pos        = {0,58,-5},
  rotSpeed   = 0.5,
  rotSpread  = 1,
  arc        = 90,
  arcSpread  = 0,
  size       = 35,
  sizeSpread = 10,
  colormap   = { {0.5, 0.5, 1.0, 0.3} },
  directional= true,
  repeatEffect = true,
  count      = 20,
}

corjamtBursts = {
  layer      = -35,
  life       = math.huge,
  pos        = {3.3,30,0},
  rotSpeed   = 0.7,
  rotSpread  = 0,
  arc        = 14,
  arcSpread  = 0,
  size       = 14,
  sizeSpread = 10,
  texture    = "bitmaps/GPL/Lups/shieldbursts5.png",
  colormap   = { {1, 0.6, 1, 0.25} },
  directional= true,
  repeatEffect = true,
  count      = 60,
}

coreterBursts = {
  layer      = -35,
  piece      = "sphere", 
  life       = math.huge,
  pos        = {0,0,0},
  rotSpeed   = 0.7,
  rotSpread  = 0,
  arc        = 14,
  arcSpread  = 0,
  size       = 14,
  sizeSpread = 5,
  texture    = "bitmaps/GPL/Lups/shieldbursts5.png",
  colormap   = { {1, 0.6, 1, 0.35} },
  directional= true,
  repeatEffect = true,
  count      = 60,
}

----------------------------------------------------------------------------
-- COLORSPHERES ------------------------------------------------------------
----------------------------------------------------------------------------
cafusShieldSphere = {
  layer=-35,
  life=20,
  pos={0,58.9,-4.5},
  size=24,
  colormap1 = { {0.9, 0.9, 1, 0.75},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 0.75} },
  colormap2 = { {0.2, 0.2, 1, 0.7},{0.2, 0.2, 1, 0.75},{0.2, 0.2, 1, 0.75},{0.2, 0.2, 1, 0.7} },
  repeatEffect=true
}

corfusShieldSphere = {
  layer=-35,
  life=20,
  pos={0, 65, -5},
  size = 25,
  colormap1 = { {0.9, 0.9, 1, 0.75},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 0.75} },
  colormap2 = { {0.05, 0.35, .44, 0.7},{0.05, 0.35, .44, 0.75},{0.05, 0.35, .44, 0.75},{0.05, 0.35, .44, 0.7} },
  --colormap2 = { {0.05, 0.35, .44, 0.7},{0.05, 0.35, .48, 0.75},{0.05, 0.35, .44, 0.75},{0.05, 0.35, .40, 0.7} },
  repeatEffect=true
}

cormfusShieldSphere = {
  layer=-35,
  life=20,
  pos={0, 40, 0},
  size = 40,
  colormap1 = { {0.9, 0.9, 1, 0.75},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 1.0},{0.9, 0.9, 1, 0.75} },
  colormap2 = { {0.05, 0.35, .44, 0.9},{0.05, 0.35, .44, 0.95},{0.05, 0.35, .44, 0.95},{0.05, 0.35, .44, 0.9} },
  --colormap2 = { {0.05, 0.05, .05, 0.8},{0.05, 0.05, .05, 0.85},{0.05, 0.05, .05, 0.85},{0.05, 0.05, .05, 0.8} },
  repeatEffect=true
}


----------------------------------------------------------------------------
-- LIGHT -------------------------------------------------------------------
----------------------------------------------------------------------------
cafusCorona = {
  pos         = {0,58.9,-4.5},
  life        = math.huge,
  lifeSpread  = 0,
  size        = 80,
  sizeGrowth  = 0,
  colormap    = { {0.2, 0.2, 0.9, 0.01} },
  --texture     = 'bitmaps/circularthingy.tga',
  texture     = 'bitmaps/GPL/groundflash.tga',
  count       = 1,
  repeatEffect = true,
}

corfusCorona = {
  delay       = 25,
  pos         = {0,40.5,0},
  life        = math.huge,
  lifeSpread  = 0,
  size        = 55,
  sizeGrowth  = 0,
  colormap    = { {0.3, 0.7, 1, 0.005}  },
  texture     = 'bitmaps/GPL/groundflash.tga',
  count       = 1,
  repeatEffect = true,
}


corfusNova = {
  layer       = -11,
  pos         = {0,40.5,0},
  life        = 26,
  lifeSpread  = 0,
  size        = 0,
  sizeGrowth  = 3,
  colormap    = { {1, 1, 1, 0.005} },
  texture     = 'bitmaps/GPL/smallflare_blue.png',
  count       = 1,
}


corfusNova2 = {
  layer       = -11,
  delay       = 10,
  pos         = {0,40.5,0},
  life        = 35,
  lifeSpread  = 0,
  size        = 0,
  sizeGrowth  = 2,
  colormap    = { {0.15, 0.35, 0.5, 0.005},{0.15, 0.35, 0.5, 0.005},{0, 0, 0, 0.005} },
  texture     = 'bitmaps/GPL/groundflash.tga',
  count       = 1,
}


corfusNova3 = {
  layer       = -10,
  delay       = 25,
  pos         = {0,40.5,0},
  life        = math.huge,
  lifeSpread  = 0,
  size        = 100,
  sizeGrowth  = 0,
  colormap    = { {1, 1, 1, 0.005} },
  texture     = 'bitmaps/GPL/smallflare_blue.png',
  count       = 1,
  repeatEffect= true,
}


corfusNova4 = {
  layer       = -5,
  delay       = 25,
  pos         = {0,40.5,0},
  life        = math.huge,
  lifeSpread  = 0,
  size        = 40,
  sizeGrowth  = 0,
  colormap    = { {0.05, 0.2, 0.5, 0.005},{0, 0, 0, 0.005} },
  texture     = 'bitmaps/Saktoths/groundring.tga',
  count       = 1,
  repeatEffect= true,
}


corfusNova5 = {
  layer       = -5,
  delay       = 20,
  pos         = {0,40.5,0},
  life        = 15,
  lifeSpread  = 0,
  size        = 0,
  sizeGrowth  = 6,
  colormap    = { {0.1, 0.35, 0.65, 0.005},{0, 0, 0, 0.005} },
  texture     = 'bitmaps/Saktoths/groundring.tga',
  count       = 1,
}


radarBlink = {
  piece       = "dish",
  onActive    = true,
  pos         = {0.5,31,1.2},
  life        = 120,
  size        = 25,
  sizeGrowth  = 2,
  colormap    = { {0.3, 1, 1, 0.005}, {0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005},{0, 0, 0, 0.005} },
  texture     = 'bitmaps/GPL/smallflare_blue.png',
  count       = 1,
  repeatEffect= true,
}


----------------------------------------------------------------------------
-- OverDrive FXs -----------------------------------------------------------
----------------------------------------------------------------------------

armmexJet = {
  color={0,0,0},
  emitVector={0,-1,0},
  width=7,
  length=100,
  animSpeed=0.5,
  distortion=0.01,
  jitterWidthScale=1.7,
  jitterLengthScale=1.5,
  piece="exhaust",
  onActive=true
}


cormexGlow = {
  layer       = -5,
  delay       = 0,
  pos         = {0,0,0},
  piece       = "tamper",

  partpos = "x,y,z|"..
	"y=((i>3) and 59) or 50,"..
	"local i=i%4,"..
	"x=((i>1) and -5) or 5,"..
	"z=(((i==0)or(i==3)) and -5) or 5",

  life        = math.huge,
  lifeSpread  = 0,
  sizeGrowth  = 0,

  size        = 15,
  size1       = 15,
  size2       = 25,

  colormap    = { {0.001, 0.1, 0.1, 0.002}, },
  color1      = {0.001, 0.1, 0.1, 0.002},
  color2      = {0.05, 0.5, 0.7, 0.005},

  texture     = 'bitmaps/GPL/groundflash.tga',
  count       = 8,
  repeatEffect= true,
  onActive    = true,
}


----------------------------------------------------------------------------
-- SimpleParticles ---------------------------------------------------------
----------------------------------------------------------------------------
roostDirt = {
  layer        = 10,
  speed        = 0,
  speedSpread  = 0.45,
  life         = 170,
  lifeSpread   = 10,
  partpos      = "x,0,z | alpha=(i/6)*pi*2, r=5+rand()*10, x=r*cos(alpha),z=r*sin(alpha)",
  colormap     = { {0, 0, 0, 0.02}, {0.28, 0.30, 0.30, 0.5}, {0.25, 0.25, 0.30, 0.5}, {0, 0, 0, 0.02} },
  rotSpeed     = 0.3,
  rotFactor    = 1.0,
  rotFactorSpread = -2.0,
  rotairdrag   = 0.99,
  rotSpread    = 360,
  size         = 30,
  sizeSpread   = 10,
  sizeGrowth   = 0.08,
  emitVector   = {0,1,0},
  emitRotSpread = 70,
  texture      = 'bitmaps/GPL/smoke_orange.png',
  count        = 5,
  repeatEffect = true,
}