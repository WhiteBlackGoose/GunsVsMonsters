unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, mc_utils, math, StdCtrls, sLabel, sPanel, Buttons,
  sSkinManager, sSpeedButton, mmsystem, UQPixels, pult, acImage;

type
  TForm1 = class(TForm)
    img1: TImage;
    tmr1: TTimer;
    tmr2: TTimer;
    lbl1: TsLabel;
    lbl2: TsLabel;
    spnl1: TsPanel;
    btn1: TsSpeedButton;
    sknmngr1: TsSkinManager;
    btn2: TsSpeedButton;
    lbl3: TsLabel;
    tmr3: TTimer;
    btn5: TsSpeedButton;
    btn6: TsSpeedButton;
    btn7: TsSpeedButton;
    btn8: TsSpeedButton;
    btn9: TsSpeedButton;
    btn10: TsSpeedButton;
    btn11: TsSpeedButton;
    btn12: TsSpeedButton;
    btn13: TsSpeedButton;
    tmr5: TTimer;
    btn14: TsSpeedButton;
    lbl4: TsLabel;
    btn3: TsSpeedButton;
    btn4: TsSpeedButton;
    btn15: TsSpeedButton;
    btn16: TsSpeedButton;
    lbl5: TsLabel;
    btn17: TsSpeedButton;
    tmr4: TTimer;
    lbl6: TsLabel;
    img2: TsImage;
    lbl7: TsLabel;
    procedure tmr1Timer(Sender: TObject);
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmr2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure img1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure tmr5Timer(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure btn16Click(Sender: TObject);
    procedure btn4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn17Click(Sender: TObject);
    procedure img1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmr4Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



  TExPoint = record
    x, y: extended;
  end;
  TProgress = record
    Min, Max, Current: extended;
  end;

  TCOun = (tcGood, tcBad);

  TPat = class
    location: TExPoint;
    visible: boolean;
    width, height: integer;
    HPLevel: TProgress;
    COun: TCOun;
  end;

  TDefType = (dtTower, dtTownhall, dtCannon, dtTesla, dtWall, dtBomb, dtGBomb, dtMyWar, dtMortar, dtMine, dtHealSpell, dtPoisonSpell, dtSuperSpell);
  TSpellType = (stHeal, stPoison, stSuper);
  TBType = (btCasual, btExtra);

  TBuilding = class;

  TBot = class(TPat)
  public
    Speed: extended;
    PrevPos: TPoint;
    aim: TBuilding;
    glyph: TBitmap;
    enable: boolean;
    damaging: boolean;
    damage: extended;
    BType: TBType;
  end;



  TBotOptions = record
    speed: extended;
    damage: extended;
    Size: TPlate;
    maxhp: integer;
  end;



  TShot = class(TPat)
    aim: TBot;
    busy: boolean;
    damage: extended;
    radius: integer;
  end;

  TBuilding = class(TPat)
    DefType: TDefType;
    enable: boolean;
    IsHealing: boolean;
  end;

  TTower = class(TBuilding)
  public
    color: TColor;
    shot: TShot;
    glyph: TBitmap;
  end;

  TCannon = class(TTower)
  public
    deg: Extended;
    LastDeg: Extended;
    ShotSpeed: integer;
  end;

  TTesla = class(TTower)
  public
    ILight: integer;
  end;

  TTownHall = class(TBuilding)
    glyph: TBitmap;
  end;

  TWall = class(TBuilding)
  end;

  TBomb = class(TBuilding)
  end;

  TGBomb = class(TBuilding)
  end;

  TMyWar = class(TTower)
    damaging: boolean;
  end;

  TMine = class(TBuilding)
  end;

  TStat = record
          current: record
            kills: integer;
            damage: extended;
            coins, gold: Integer;
            level: integer;
          end;
          overall: record
            kills: integer;
            damage: extended;
            coins: int64;
            battles: integer;
          end;
          key: string;
        end;

procedure BuildOpp(x, y: extended; botoptions: TBotOptions; Type_: TBtype);
procedure rectangle(location: TExPoint; w, h: integer; color: TColor);
function Sq_tr(x1, y1, x2, y2: extended): extended;
procedure paint_R;
procedure changeaim(bot: TPat; ChooseFromBad: boolean);
procedure MovePatTo(ToMove, aim: TPat; speed: extended);
procedure resetWin;
procedure drawlight(LFrom, LTo: TExPoint; ACanvas: TCanvas);
function plusEp(p: TExPoint; inc: extended): TExPoint;
procedure sound(name: string);
procedure SAVE_SESSION;
procedure timersAble (value: boolean);
procedure StartGame();
procedure EndGame();
var
  Form1: TForm1;
  bots: array of TBot;
  buis: array of TBuilding;
  TownHall: TTownHall;
  mainpath: string;
  tmp_bmp: TBitmap;
  opp_bmp: array of TBitmap;
  opp_m: integer = 0;
  step: integer = 0;
  wall_bmp: TBitmap;
  Tesla_bmp: TBitmap;
  bomb_bmp: TBitmap;
  GBomb_bmp: TBitmap;
  MyWar_bmp: TBitmap;
  Mine_bmp: TBitmap;
  Tree_bmp: TBitmap;
  shot_bmp: TBitmap;
  mortar_bmp: TBitmap;
  shot2_bmp: TBitmap;
  stat: TStat;
  state: (sNormal, sSandbox, sRichstyle);
  GameField: record
               width, height: integer;
               qp: TQuickPixels;
             end;
  mode: TDefType = dtTownhall;
  lastCoord: TPoint;
  IsPaused: boolean = false;
  IsSoundEnabled: boolean = false;
  inited: boolean = false;
  Background: TBitmap;
  qp_bmp: TQuickPixels;
  Wheel: TRandomWheel;
  Decor_: array of record
          PPic: TBitmap;
          Location: TPlate;
         end;
  spells: array of record
            radius: integer;
            SpellType: TSpellType;
            EnableCode: integer;
            loc: TExPoint;
          end;
  BeforePlayTime, lasttime: int64;
  down: boolean = false;
  fps: record
    lasttime: int64;
    frames: integer;
  end;
  phyFps: record
    lasttime: int64;
    frames: integer;
  end;
  MaxPaintRTime: integer = 0;
implementation
uses
  menu, lg;
{$R *.dfm}

procedure rectangle(location: TExPoint; w, h: integer; color: TColor);
begin
  with form1.img1.Picture.Bitmap.Canvas do
  begin
    pen.color := color;
    brush.color := color;
    rectangle(round(location.x), round(location.y), round(location.x) + w, round(location.y) + h);
  end;
end;

procedure MovePatTo(ToMove, aim: TPat; speed: extended);
var
  x_M, y_M: extended;
  asma, bsma, csma, abig, bbig, cbig, alpha: extended;
  x_0, y_0: boolean;
begin
  abig  := ToMove.location.y - aim.location.y;
  y_0 := abig >= 0;
  bbig  := ToMove.location.x - aim.location.x;
  x_0 := bbig >= 0;
  abig := module(abig);
  Bbig := module(bbig);
  cbig  := sqrt(sqr(abig) + sqr(bbig));
  alpha := (arccos(abig / cbig));
  csma  := Speed / (sin((Alpha)) + cos((alpha)));
  bsma  := csma * sin((alpha));
  asma  := Speed - bsma;
  x_m   := -bsma;
  if not x_0 then
    x_m := x_m * -1;
  y_m   := -asma;
  if not y_0 then
    y_m := Y_m * -1;
  ToMove.location.x := ToMove.location.x + x_m;
  ToMove.location.y := ToMove.location.Y + Y_m;
end;

procedure ellipse(location: TExPoint; w, h: integer; color: TColor);
begin
  with form1.img1.Picture.Bitmap.Canvas do
  begin
    pen.color := color;
    brush.color := color;
    ellipse(round(location.x), round(location.y), round(location.x) + w, round(location.y) + h);
  end;
end;

procedure buildDecor(loc: TPlate; picture: TBitmap);
begin
  setlength(Decor_, length(Decor_) + 1);
  with Decor_[high(Decor_)] do
  begin
    plateassign(location, loc);
    PPic := picture;
  end;
end;

procedure buildSpell(x, y: integer; radius_: integer; Ty: TSpellType);
begin
  setlength(spells, length(spells) + 1);
  with spells[high(spells)] do
  begin
    radius := radius_;
    spelltype := ty;
    if ty = stHeal then
      enableCode := 500;
    if ty = stPoison then
      enableCode := 350;
    if ty = stSuper then
      enableCode := 100;
    loc.x := x;
    loc.y := y;
  end;
end;

procedure buildTower(x, y: extended; ty: TDefType = dtCannon);
begin

  setlength(buis, length(buis) + 1);
  if ty in [dtCannon, dtMortar] then
    buis[high(buis)] := TCannon.Create;
  if ty = dtTesla then
    buis[high(buis)] := TTesla.Create;
  if ty = dtWall then
    buis[high(buis)] := TWall.Create;
  if ty = dtBomb then
    buis[high(buis)] := TBomb.Create;
  if ty = dtGBomb then
    buis[high(buis)] := TGBomb.Create;
  if ty = dtMyWar then
    buis[high(buis)] := TMyWar.Create;
  if ty = dtMine then
    buis[high(buis)] := TMine.Create;
  with buis[high(buis)] do
  begin
    deftype := ty;
    location.x := x;
    location.y := y;
    enable := true;
    hplevel.Min := 0;
    if ty = dtWall then
      hplevel.max := 1300;

    if ty = dtBomb then
      hplevel.Max := 10;

    if ty = dtGBomb then
      hplevel.Max := 10;

    if ty = dtMyWar then
      hplevel.Max := 450;

    if ty = dtCannon then
      hplevel.Max := 300;

    if ty = dtTesla then
      hplevel.Max := 180;

    if ty = dtMine then
      hplevel.Max := 100;

    if ty = dtMortar then
      hplevel.Max := 500;

    hplevel.current := hplevel.max;
    width := IMPL_SIZE;
    height := IMPL_SIZE;
    visible := true;
    if ty = dtwall then exit;
    if ty = dtBomb then exit;
    if ty = dtGBomb then exit;
    if ty = dtMine then exit;
    if ty = dtMyWar then
      (buis[high(buis)] as TMyWar).damaging := false;
    (buis[high(buis)] as TTower).glyph := TBitmap.create;
    (*
    if ty = dtCannon then
      (buis[high(buis)] as TCannon).glyph.LoadFromFile(mainpath + 'res/gun1.bmp');
    if ty = dtMortar then
      (buis[high(buis)] as TCannon).glyph.LoadFromFile(mainpath + 'res/gun1.bmp');*)
    (buis[high(buis)] as TTower).shot := TShot.create;
    (buis[high(buis)] as TTower).shot.busy := false;
    (buis[high(buis)] as TTower).shot.location.x := location.x;
    (buis[high(buis)] as TTower).shot.location.y := location.y;
    if ty = dtCannon then
      (buis[high(buis)] as TTower).shot.radius := rNormal;
    if ty = dtTesla then
      (buis[high(buis)] as TTower).shot.radius := rBig;
    if ty = dtMyWar then
      (buis[high(buis)] as TTower).shot.radius := 1000;
    if ty = dtMortar then
      (buis[high(buis)] as TTower).shot.radius := 200;
    if ty in [dtCannon, dtMortar] then
    begin
      (buis[high(buis)] as TCannon).deg := 1;
      (buis[high(buis)] as TCannon).LastDeg := 0;
    end;
    if ty = dtCannon then
      (buis[high(buis)] as TTower).shot.damage := CANNON_DAMAGE;
    if ty = dtMortar then
      (buis[high(buis)] as TTower).shot.damage := MORTAR_DAMAGE;
    if ty = dtTesla then
      (buis[high(buis)] as TTower).shot.damage := TESLA_DAMAGE;
    if ty = dtCannon then
      (buis[high(buis)] as TCannon).ShotSpeed := 10;
    if ty = dtMortar then
      (buis[high(buis)] as TCannon).ShotSpeed := 7;
  end;
end;

procedure BuildOpp(x, y: extended; botoptions: TBotOptions; Type_: TBtype);
var
  i: integer;
begin
  setlength(bots, length(bots) + 1);
  bots[high(bots)] := TBot.Create;
  with bots[high(bots)] do
  begin
    BType := type_;
    visible := true;
    damage := 0.05;
    if BotOptions.damage <> -1 then
      damage := botoptions.damage;
    damaging := false;
    speed := 2;
    if botoptions.speed <> -1 then
      speed := botoptions.speed;
    location.x := x;
    location.y := y;
    HPLevel.min := 0;
    hplevel.max := botoptions.maxhp;
    hplevel.current := botoptions.maxhp;
    enable := true;
    changeaim(bots[high(bots)], false);
    COun := tcBad;
    width := botoptions.Size.width;
    height := botoptions.Size.height;
  end;
end;

procedure changeaim(bot: TPat; ChooseFromBad: boolean);
var
  i: integer;
  min, cu: extended;
  UpTo: integer;
  function NoAimOn(bot1: TBot): boolean;
  var
    i: integer;
  begin
    result := true;
    for i := 0 to high(buis) do
      if buis[i].DefType in [dtCannon, dtMortar] then
        if (buis[i] as TCannon).shot.aim = bot1 then
        begin
          result := false;
          exit;
        end;
  end;
var
  radius: integer;
begin
  if not ChooseFromBad then
  begin
    with bot as TBot do
    begin
      aim := townHall;
      min := sq_tr(location.x, location.y, townhall.location.x, townhall.location.y);
      UpTo := high(buis);
      for i := 0 to UpTo do
      begin
        if buis[i].enable then
        begin
          cu := sq_tr(location.x, location.y, buis[i].location.x, buis[i].location.y);
          if cu < min then
          begin
            aim := buis[i];
            min := cu;
          end;
        end;
      end;
    end;
  end
  else
  begin
    with bot as TShot do
    begin
      //aim := bots[random(length(bots))];
      aim := nil;
      //min := sq_tr(location.x, aim.location.x, location.y, aim.location.y);
      min := 1000;
      UpTo := high(bots);
      for i := 0 to UpTo do
      begin
        if (bots[i].visible) then// and (NoAimOn(bots[i])) then
        begin
          cu := sq_tr(location.x, location.y, bots[i].location.x, bots[i].location.y);
          //cu := module(cu);
          if (cu < min) and (cu <= radius) then
          begin
            aim := bots[i];
            min := cu;
          end;
        end;
      end;
    end;
  end;
end;

procedure WorkOutPhyE;
var
  i, j: integer;
  tmp: TBuilding;
  a_0, b_0: extended;
  a_I, b_I: boolean;
  procedure mul(location: TExPoint);
  const
    radius = 70;
    quality = 30;
  var
    x: extended;
    p: TPoint;
    bo: TBotOptions;
  begin
    x := -radius;
    bo.speed := 2.5;
    bo.damage := 0.05 * stat.current.level;
    bo.Size.width := 16;
    bo.Size.height := 16;
    bo.maxhp := 50 * stat.current.level;
    while x < 2 * radius do
    begin
      p.x := round(x);
      p.y := round(sqrt(sqr(radius) + sqr(x)));
      buildopp(p.x, p.y, bo, btCasual);
      p.y := -round(sqrt(sqr(radius) + sqr(x)));
      buildopp(p.x + location.x, p.y + location.y, bo, btCasual);
      x := x + quality;
    end;
  end;
begin
  if BeforePlayTime > 0 then
  begin
    BeforePlayTime := BeforePlayTime - (getmscount - lasttime);
    lasttime := GetMSCount;
  end;
  inc(PhyFps.frames);
  for i := 0 to high(bots) do
  begin
    if bots[i].enable and bots[i].visible then
    begin
      if not bots[i].damaging then
      begin
        changeaim(bots[i], false);
        if bots[i].aim <> nil then
        begin
          MovePatTo(bots[i], bots[i].aim, bots[i].Speed);
          if sq_tr(bots[i].location.x, bots[i].location.y, bots[i].aim.location.x, bots[i].aim.location.y) < 40 then
            bots[i].damaging := true;
        end;
      end
      else
      begin
        bots[i].aim.HPLevel.Current := bots[i].aim.HPLevel.Current - bots[i].damage;
        if bots[i].aim.HPLevel.Min >= bots[i].aim.HPLevel.current then
        begin
          tmp := bots[i].aim;
          bots[i].aim.enable := false;
          bots[i].aim.visible := false;
          if (bots[i].aim.DefType = dtBomb) or (bots[i].aim.DefType = dtGBomb) then
            for j := 0 to high(bots) do
              if bots[j].visible then
              begin
                if sq_tr(bots[j].location.x, bots[j].location.y, bots[i].aim.location.x, bots[i].aim.location.y) < 100 then
                begin
                  if bots[i].aim.DefType = dtBomb then
                    bots[j].HPLevel.Current := bots[j].HPLevel.Current - BOMB_DAMAGE
                  else
                    bots[j].HPLevel.Current := bots[j].HPLevel.Current - GBOMB_DAMAGE;
                  if bots[j].hplevel.Current <= bots[j].HPLevel.Min then
                    bots[j].visible := false
                end;
              end;
          for j := 0 to high(bots) do
            if bots[j].visible then
              if bots[j].aim = tmp then
              begin
                changeaim(bots[j], false);
                bots[j].enable := true;
                bots[j].damaging := false;
              end;
          if (bots[i].aim = townhall) and (bots[i].aim.enable = false) then
          begin
            timersable(false);
            //showmessage('Fail.');
            mc_utils.delay(plate(0, 0, screen.width, screen.height), ['GAME OVER'], 1500);
            form1.close;
            exit;
          end;
        end;
      end;
    end;
  end;

  for i := 0 to high(buis) do
  begin
    buis[i].IsHealing := false;
    if buis[i].DefType in [dtCannon, dtMortar] then
    begin
      if buis[i].enable and buis[i].visible then
        with buis[i] as TCannon do
        begin
          if shot.busy then
          begin
            if shot.aim <> nil then
            begin
              MovePatTo(shot, shot.aim, ShotSpeed);
              if (sq_tr(shot.location.x, shot.location.y, shot.aim.location.x, shot.aim.location.y) < 15) then
              begin
                shot.aim.HPLevel.Current := shot.aim.HPLevel.Current - shot.damage;
                if buis[i].DefType = dtMortar then
                  for j := 0 to high(bots) do
                    if bots[j].enable then
                      if sqrt(sqr(shot.location.x - bots[j].location.x) + sqr(shot.location.y - bots[j].location.y)) < 110 then
                      begin
                        bots[j].HPLevel.Current := bots[j].HPLevel.Current - shot.damage / 2;
                        if bots[j].HPLevel.Current <= 0 then
                          bots[j].enable := false;
                      end;
                if shot.aim.visible then
                stat.current.damage := stat.current.damage + shot.damage;
                if shot.aim.HPLevel.Current <= shot.aim.HPLevel.Min then
                begin
                  shot.busy := false;
                  if shot.aim.visible then
                    inc(stat.current.kills);
                  shot.aim.visible := false;
                end
                else
                begin
                  shot.location.x := buis[i].location.x + (buis[i].width - 10) div 2;
                  shot.location.y := buis[i].location.y + (buis[i].height - 10) div 2;
                  a_0 := (shot.location.x - shot.aim.location.x);
                  b_0 := (shot.location.y - shot.aim.location.y);
                  LastDeg := deg;
                  deg := arctan2(a_0 , b_0);
                end;
                resetWin;
              end;
              if (shot.location.x < 0) or (shot.location.x > GameField.width) or (shot.location.y > GameField.height) or (shot.location.y < 0) then
                shot.busy := false;
            end;
          end
          else
          begin
            if length(bots) <> 0 then
            begin
              if buis[i].enable then
              begin
                shot.location.x := buis[i].location.x + (buis[i].width - 10) div 2;
                shot.location.y := buis[i].location.y + (buis[i].height - 10) div 2;
                changeaim(shot, true);
                if shot.aim <> nil then
                begin
                  sound('shot');
                  shot.busy := true;
                end;
                if shot.aim <> nil then
                begin
                  a_0 := (shot.location.x - shot.aim.location.x);
                  b_0 := (shot.location.y - shot.aim.location.y);
                  LastDeg := deg;
                  deg := arctan2(a_0 , b_0);
                end;
              end;
            end;
          end;
        end;
    end;
    if buis[i].DefType = dtTesla then
    begin
      if buis[i].visible and buis[i].enable then
        with buis[i] as TTesla do
        begin
          if shot.aim <> nil then
          begin
            if shot.busy then
            begin
              if shot.aim <> nil then
              begin
                inc(ILight);
                if ILight = 1600 then ILight := 0;
                if ILight mod LIGHT_QUAL < LIGHT_QUAL_I then
                begin
                  shot.aim.HPLevel.Current := shot.aim.HPLevel.Current - shot.damage;
                  if shot.aim.visible then
                    stat.current.damage := stat.current.damage + shot.damage;
                end;
                if shot.aim.HPLevel.Current <= shot.aim.HPLevel.min then
                begin
                  shot.busy := false;
                  if shot.aim.visible then
                    inc(stat.current.kills);
                  
                  shot.aim.visible := false;
                  changeaim(shot, true);
                  if shot.aim <> nil then shot.busy := true;
                end;
                resetwin
              end;
            end
            else
            begin
              changeaim(shot, true);
              if shot.aim <> nil then
                shot.busy := true;
            end;
          end
          else
          begin
            changeaim(shot, true);
              if shot.aim <> nil then
                shot.busy := true;
          end;
        end;
    end;
    if buis[i].DefType = dtMyWar then
      if buis[i].visible and buis[i].enable then
        with buis[i] as TMyWar do
          if not damaging then
            if shot.busy then
            begin
              if shot.aim <> nil then
                if shot.aim.visible then
                  MovePatTo(buis[i], shot.aim, 0.5)
                else
                begin
                  changeaim(shot, true);
                end
              else
                changeaim(shot, true);
              if shot.aim <> nil then
                if sq_tr(location.x, location.y, shot.aim.location.x, shot.aim.location.y) < 20 then
                  damaging := true;
            end
            else
            begin
              changeaim(shot, true);
              if shot.aim <> nil then shot.busy := true;
            end
          else
          begin
            shot.aim.HPLevel.Current := shot.aim.HPLevel.Current - shot.damage;
            if shot.aim.visible then
              stat.current.damage := stat.current.damage + shot.damage;
            if shot.aim.HPLevel.Current <= shot.aim.HPLevel.min then
            begin
              shot.busy := false;
              damaging := false;
              if shot.aim.visible then
                inc(stat.current.kills);
              shot.aim.visible := false;
              changeaim(shot, true);
              if shot.aim <> nil then
                shot.busy := true;
            end;
          end;
  end;

  for i := 0 to high(spells) do
  begin
    if spells[i].EnableCode > 0 then
    begin
      if spells[i].SpellType = stHeal then
      begin
        for j := 0 to high(buis) do
          if (buis[j].visible and buis[j].enable) then
            if sq_tr(buis[j].location.x, buis[j].location.y, spells[i].loc.x, spells[i].loc.y) <= spells[i].radius then
            begin
              buis[j].HPLevel.Current := buis[j].HPLevel.Current + HSPELL_POWER;
              if buis[j].HPLevel.Current > buis[j].HPLevel.max then
                buis[j].HPLevel.Current := buis[j].HPLevel.max;
              buis[j].IsHealing := true;
            end;
      end;
      if spells[i].SpellType = stPoison then
      begin
        for j := 0 to high(bots) do
          if (bots[j].visible) then
            if sq_tr(bots[j].location.x, bots[j].location.y, spells[i].loc.x, spells[i].loc.y) <= spells[i].radius then
            begin
              bots[j].HPLevel.Current := bots[j].HPLevel.Current - PSPELL_POWER;
              if bots[j].HPLevel.Current < bots[j].HPLevel.min then
              begin
                bots[j].visible := false;
                inc(stat.current.kills)
              end;
            end;
      end;
      if spells[i].SpellType = stSuper then
      begin
        for j := 0 to high(bots) do
          if (bots[j].visible) then
            if sq_tr(bots[j].location.x, bots[j].location.y, spells[i].loc.x, spells[i].loc.y) <= spells[i].radius then
            begin
              bots[j].HPLevel.Current := bots[j].HPLevel.min - 1;
              bots[j].visible := false;
              buildTower(bots[j].location.x, bots[j].location.y, dtMyWar);
            end;
      end;
      inc(spells[i].EnableCode, -1);
    end;
  end;


  if step = 0 then
    inc(opp_m);
  if opp_m = high(opp_bmp) + 1 then
    opp_m := 0;
  inc(step);
  if step = 10 then step := 0;
end;

procedure WorkOutPhy;
var
  timespent: int64;
begin
  while true do
  begin
    timespent := GetMSCount;
    try
      WorkOutPhyE;
    except
    end;
    timespent := getmscount - timespent;
    if timespent < PHY_INTERVAL then
      sleep(PHY_INTERVAL - timespent);
    if not form1.visible then
      exit;
  end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
  t: int64;
begin
  //WorkOutPhyE;
  tmr1.Enabled := false;
  while true do
  begin
    if REPAINTING_IS_ON then
    begin
      t := getmscount;
      paint_r;
      t := getmscount - t;
    end;
    if MaxPaintRTime < t then
      MaxPaintRTime := t;
    inc(fps.frames);
    //if t < PHY_interval then
      //tmr1.Interval := PHY_INTERVAL - t;
    //sleep(PHY_INTERVAL - t);
    application.ProcessMessages;
    if not visible then
      exit;
  end;
end;

procedure paint_R;
var
  i: integer;
  a: TExPoint;
  procedure drawprogress(b: TPat);
  var
    width: integer;
    height: integer;
    padding_x: integer;
    padding_y: integer;
  type
    TGColor = array [0..1] of TColor;
  var
    newlock: TExPoint;
    GR, RD: integer;
    ptt_col: TGColor;
  begin
    width := IMPL_SIZE;
    height := IMPL_SIZE div 5;
    padding_x := 3;
    padding_y := 3;
    if b.COun = tcGood then
    begin
      ptt_col[0] := cllime;
      ptt_col[1] := clred;
    end
    else
    begin
      //ptt_col[0] := $8b00ff;
      ptt_col[0] := RGB(139, 0, 255);
      ptt_col[1] := clblack;
    end;
    newlock.x := b.location.x + (b.width - width) div 2;
    newlock.y := b.location.y - height;
    rectangle(newlock, width, height, clblack);
    newlock.x := newlock.x + padding_x;
    newlock.y := newlock.y + padding_y;
    GR := round((width - padding_x * 2) * (b.HPLevel.Current / (b.HPLevel.Max - b.HPLevel.Min)));
    rectangle(newlock, GR, height - padding_y * 2, ptt_col[0]);
    newlock.x := newlock.x + GR;
    rectangle(newlock, width - GR - padding_x * 2, height - padding_y * 2, ptt_col[1]);
  end;
const
  SSize = 20;
  BWidth = 2;
  SQFS = 20;
var
  newP: TExPoint;
  x, y: integer;
  function plusEp1(p: TExPoint; w, h: integer): TExPoint;
  begin
    result.x := p.x + w;
    result.y := p.y + h;
  end;
  procedure rectangle1(x, y: integer; color: TColor);
  var
    p: TExPoint;
  begin
    p.x := x;
    p.y := y;
    rectangle(p, SQFS, SQFS, color);
  end;
  procedure draw(pat: TPat; bmp: TBitmap);
  var
    x, y: integer;
  begin
    form1.img1.Picture.Bitmap.Canvas.StretchDraw(rect(round(pat.location.x),
                                                        round(pat.location.y),
                                                        round(pat.location.x) + pat.width,
                                                        round(pat.location.y) + pat.height), bmp);
(*    SetStretchBltMode(form1.img1.Picture.Bitmap.Canvas.Handle, HALFTONE);
    StretchBlt(form1.img1.Picture.Bitmap.Canvas.Handle, round(pat.location.x),
                              round(pat.location.y),
                              0 + pat.width,
                              0 + pat.height, bmp.Canvas.Handle, 0, 0,
    bmp.Width, bmp.Height, SRCCOPY);*)
  end;
var
  BG: TPat;
  procedure drawDec(loc: TPlate; pic: TBitmap);
  var
    x, y, xC, yC: integer;
    a: TQuickPixels;
  begin
    a := TQuickPixels.Create;
    a.Attach(pic);
    for x := 0 to pic.width - 1 do
      for y := 0 to pic.height - 1 do
        if a.Pixels[x, y] <> $99ff99 then
        begin
          xC := x + (loc.left);
          yC := y + (loc.top);
          if xC > gamefield.width - 1 then xc := gamefield.width - 1;
          if yC > gamefield.height - 1 then yc := gamefield.height - 1;
          gamefield.qp.pixels[xC, yC] := a.Pixels[x, y];
        end;
    a.Free;
  end;
  procedure ellipseBlend(xP, yP: integer; radius: integer; color: TColor = clwhite; const BORDER_WIDTH: integer = 15; start: integer = 1);
  var
    x, y: extended;
    xR, yR, i: integer;
    value: TColor;
  begin
    for i := start to border_width do
    begin
      x := -radius;
      while x < radius do
      begin
        y := (sqrt(sqr(radius) - sqr(x)));
        xR := round(x) + xP;
        yR := round(y) + yP;
        if xR < 0 then xR := 0;
        if xR > gamefield.width - 1 then xR := gamefield.width - 1;
        if yR < 0 then yR := 0;
        if yR > gamefield.height - 1 then yR := gamefield.height - 1;
        gamefield.qp.Pixels[xR, yR] := blendcolor(gamefield.qp.Pixels[xR, yR], color, 255 - ((i - 1) * (255 div border_width)));
        x := x + 1;
      end;
      x := -radius;
      while x < radius do
      begin
        y := -(sqrt(sqr(radius) - sqr(x)));
        xR := round(x) + xP;
        yR := round(y) + yP;
        if xR < 0 then xR := 0;
        if xR > gamefield.width - 1 then xR := gamefield.width - 1;
        if yR < 0 then yR := 0;
        if yR > gamefield.height - 1 then yR := gamefield.height - 1;
        gamefield.qp.Pixels[xR, yR] := blendcolor(gamefield.qp.Pixels[xR, yR], color, 255 - ((i - 1) * (255 div border_width)));
        x := x + 1;
      end;
      //exit;
      y := -radius;
      while y < radius do
      begin
        x := (sqrt(sqr(radius) - sqr(y)));
        xR := round(x) + xP;
        yR := round(y) + yP;
        if xR < 0 then xR := 0;
        if xR > gamefield.width - 1 then xR := gamefield.width - 1;
        if yR < 0 then yR := 0;
        if yR > gamefield.height - 1 then yR := gamefield.height - 1;
        gamefield.qp.Pixels[xR, yR] := blendcolor(gamefield.qp.Pixels[xR, yR], color, 255 - ((i - 1) * (255 div border_width)));
        y := y + 1;
      end;
      y := -radius;
      while y < radius do
      begin
        x := -(sqrt(sqr(radius) - sqr(y)));
        xR := round(x) + xP;
        yR := round(y) + yP;
        if xR < 0 then xR := 0;
        if xR > gamefield.width - 1 then xR := gamefield.width - 1;
        if yR < 0 then yR := 0;
        if yR > gamefield.height - 1 then yR := gamefield.height - 1;
        gamefield.qp.Pixels[xR, yR] := blendcolor(gamefield.qp.Pixels[xR, yR], color, 255 - ((i - 1) * (255 div border_width)));
        y := y + 1;
      end;
      inc(radius, 1)
    end;
  end;
var
  ColorToDrawRect: TColor;
begin
  ColorToDrawRect := clPurple;

  //for i := 0 to
  A.x := 0;
  a.y := 0;

  bg := TPat.Create;
  bg.location.x := 0;
  bg.location.y := 0;
  bg.width := GameField.width;
  bg.height := GameField.height;
  rectangle(a, GameField.width, GameField.height, $99ff99);

  for i := 0 to high(bots) do
    if bots[i].visible and bots[i].enable then
    begin
      NewP.x := bots[i].location.x;
      newP.y := bots[i].location.y;
      //ellipse(NewP, SSize, SSize, bots[i].colorA);
      NewP.x := bots[i].location.x + BWidth;
      newP.y := bots[i].location.y + BWidth;
      //ellipse(newp, SSize - BWidth * 2, SSize - BWidth * 2, bots[i].colorB);
      (*
      form1.img1.Picture.Bitmap.Canvas.StretchDraw(rect(round(bots[i].location.x),
                                                        round(bots[i].location.y),
                                                        round(bots[i].location.x) + bots[i].width,
                                                        round(bots[i].location.y) + bots[i].height), opp_bmp[opp_m]);*)
      draw(bots[i], opp_bmp[opp_m]);
      if bots[i].HPLevel.Current <> bots[i].HPLevel.max then
        drawprogress(bots[i])
    end;
  if townhall.enable then
  begin
    draw(townhall, townhall.glyph);
    drawprogress(townhall);
  end;


  for i := 0 to high(buis) do
    if buis[i].enable then
    begin
      if (buis[i].location.x = lastcoord.x - IMPL_SIZE div 2) and (buis[i].location.y = lastcoord.y - IMPL_SIZE div 2) then
        ColorToDrawRect := clred;
      if buis[i].DefType in [dtCannon, dtMortar] then
      begin
        //ellipse((buis[i] as TCannon).shot.location, 10, 10, clred);
        if buis[i].DefType = dtCannon then
          drawdec(plate(round((buis[i] as TCannon).shot.location.x), round((buis[i] as TCannon).shot.location.y), 0, 0), shot_bmp)
        else
          drawdec(plate(round((buis[i] as TCannon).shot.location.x), round((buis[i] as TCannon).shot.location.y), 0, 0), shot2_bmp);
        if (buis[i] as TCannon).deg <> (buis[i] as TCannon).LastDeg then
        begin
          if buis[i].DefType = dtCannon then
            QuickRotate(tmp_bmp, (buis[i] as TTower).glyph, (buis[i] as TCannon).deg, $99ff99)
          else
            QuickRotate(mortar_bmp, (buis[i] as TTower).glyph, (buis[i] as TCannon).deg, $99ff99);
          //QuickRotate((buis[i] as TTower).glyph, tmp_bmp, (buis[i] as TCannon).deg, $99ff99);
          (buis[i] as TCannon).LastDeg := (buis[i] as TCannon).deg;
        end;

        draw(buis[i], (buis[i] as TCannon).glyph);
        (*
        if getMSCount mod 10000 in [0..100] then
          (buis[i] as TCannon).glyph.SaveToFile(getpath + 'crya.bmp');*)
        (*
        if buis[i].DefType = dtCannon then
          draw(buis[i], tmp_bmp)
        else
          draw(buis[i], mortar_bmp)*)
      end;

      if buis[i].DefType = dttesla then
      begin
        draw(buis[i], tesla_bmp);
      end;
      if (buis[i].DefType = dtwall) then
        draw(buis[i], wall_bmp);
      if (buis[i].DefType = dtBomb) then
        draw(buis[i], bomb_bmp);
      if (buis[i].DefType = dtGBomb) then
        draw(buis[i], GBomb_bmp);
      if (buis[i].DefType = dtMyWar) then
        draw(buis[i], MyWar_bmp);
      if (buis[i].DefType = dtMine) then
        draw(buis[i], Mine_bmp);
      if not ((buis[i].DefType = dtTesla) or (buis[i].DefType = dtCannon) or (buis[i].DefType = dtMortar) or (buis[i].DefType = dtwall) or (buis[i].DefType = dtBomb) or (buis[i].DefType = dtGBomb) or (buis[i].DefType = dtMyWar) or (buis[i].DefType = dtMine)) then
        rectangle(buis[i].location, 30, 30, clblack);
      if buis[i].IsHealing then
      begin
        rectangle(plusep1(buis[i].location, 2, 0), 4, 8, clred);
        rectangle(plusep1(buis[i].location, 0, 2), 8, 4, clred);
      end;
    end;

  for i := 0 to high(buis) do
    if buis[i].enable then
      if buis[i].HPLevel.Current <> buis[i].HPLevel.max then
        drawprogress(buis[i]);
  for i := 0 to high(buis) do
    if buis[i].enable and (buis[i].DefType = dtTesla) then
      if buis[i].visible then
          if (buis[i] as TTesla).ILight mod LIGHT_QUAL < LIGHT_QUAL_I then
            if (buis[i] as TTesla).shot.aim <> nil then
            begin
              newP.x := (buis[i] as TTesla).location.x + buis[i].width div 2;
              newP.y := (buis[i] as TTesla).location.y + buis[i].height div 2;
              DrawLight(newP, PlusEp((buis[i] as TTesla).shot.aim.location, (buis[i] as TTesla).shot.aim.width div 2), form1.img1.canvas);
              //DrawLight(newP, PlusEp((buis[i] as TTesla).shot.aim.location, (buis[i] as TTesla).shot.aim.width div 2), form1.img1.canvas);
            end;

  for i := 0 to high(spells) do
    if spells[i].EnableCode > 0 then
    begin
      if spells[i].SpellType = stHeal then
        ellipseblend(round(spells[i].loc.x), round(spells[i].loc.y), spells[i].radius - 5, clYellow, 20, 5);
      if spells[i].SpellType = stPoison then
        ellipseblend(round(spells[i].loc.x), round(spells[i].loc.y), spells[i].radius - 5, clMaroon, 20, 5);
      if spells[i].SpellType = stSuper then
        ellipseblend(round(spells[i].loc.x), round(spells[i].loc.y), spells[i].radius - 5, clblue, 20, 5);
    end;

  if decoration_on then
    for i := 0 to high(Decor_) do
      drawdec(decor_[i].Location, decor_[i].PPic);


  if mode <> dttownhall then
  begin
    newP.x := lastcoord.x - IMPL_SIZE div 2;
    newP.y := lastcoord.y - IMPL_SIZE div 2;
    if newP.x < 0 then newP.x := 0;
    if newP.y < 0 then newP.y := 0;
    if newP.x + IMPL_SIZE > gamefield.width - 1 then newP.x := gamefield.width - 1 - IMPL_SIZE;
    if newP.y + IMPL_SIZE > gamefield.height - 1 then newP.y := gamefield.height - 1 - IMPL_SIZE;
    //rectangle(newp, 50, 50, clred)
    if (mode <> dtPoisonSpell) and (mode <> dtHealSpell) and (mode <> dtSuperSpell) then
      for x := round(newP.x) to round(newP.x) + IMPL_SIZE do
        for y := round(newP.y) to round(newP.y) + IMPL_SIZE do
          gamefield.qp.Pixels[x, y] := blendcolor(ColorToDrawRect, gamefield.qp.Pixels[x, y], 128);
    if (mode = dtCannon) then
      ellipseblend(round(newP.x), round(newP.y), rNormal);
    if (mode = dtMortar) then
      ellipseblend(round(newP.x), round(newP.y), 200);
    if (mode = dtTesla) then
      ellipseblend(round(newP.x), round(newP.y), rBig);
    if (mode = dtPoisonSpell) or (mode = dtHealSpell) or (mode = dtSuperSpell) then
      ellipseblend(round(newP.x), round(newP.y), rHSpell);
  end;
end;

function Sq_tr(x1, y1, x2, y2: extended): extended;
var
  wi, he: extended;
begin
  wi := (x1 - x2);
  he := (y1 - y2);
  result := sqrt(sqr(wi) + sqr(he))
end;

procedure TForm1.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  //buildopp(x, y, clblue)
  down := true;
  x := x div IMPL_SIZE * IMPL_SIZE + IMPL_SIZE div 2;
  y := y div IMPL_SIZE * IMPL_SIZE + IMPL_SIZE div 2;
  if (mode <> dtPoisonSpell) and (mode <> dtHealSpell) and (mode <> dtSuperSpell) and (mode <> dtTownHall) then
  begin
    for i := 0 to high(buis) do
      if buis[i].enable then
        if (buis[i].location.x = x - IMPL_SIZE div 2) and (buis[i].location.y = y - IMPL_SIZE div 2) then
          exit;
    if (trunc(townhall.location.x) in [x - IMPL_SIZE div 2, x + IMPL_SIZE div 2, x]) and (trunc(townhall.location.y) in [y - IMPL_SIZE div 2, y + IMPL_SIZE div 2, y]) then
      exit;
  end;
  if mode = dtCannon then
    if stat.current.coins >= 50 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 50;
    end;
  if mode = dtTesla then
    if stat.current.coins >= 35 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 35;
    end;
  if mode = dtWall then
    if stat.current.coins >= 20 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 20;
    end;
  if mode = dtBomb then
    if stat.current.coins >= 5 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 5;
    end;
  if mode = dtGBomb then
    if stat.current.coins >= 10 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 10;
    end;
  if mode = dtMyWar then
    if stat.current.coins >= 85 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 85;
    end;
  if mode = dtMortar then
    if stat.current.coins >= 450 then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - 450;
    end;
  if mode = dtMine then
    if stat.current.coins >= strtoint(btn10.Caption) then
    begin
      buildtower(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, mode);
      stat.current.coins := stat.current.coins - strtoint(btn10.Caption);
      btn10.Caption := inttostr(round(strtoint(btn10.Caption) * 1.5))
    end;
  if mode = dtHealspell then
    if stat.current.coins >= strtoint(btn4.Caption) then
    begin
      buildspell(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, rHSpell, stHeal);
      stat.current.coins := stat.current.coins - strtoint(btn4.Caption);
    end;
  if mode = dtPoisonSpell then
    if stat.current.coins >= strtoint(btn15.Caption) then
    begin
      buildspell(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, rHSpell, stPoison);
      stat.current.coins := stat.current.coins - strtoint(btn15.Caption);
    end;
  if mode = dtSuperSpell then
    if stat.current.coins >= strtoint(btn16.Caption) then
    begin
      buildspell(x - IMPL_SIZE div 2, y - IMPL_SIZE div 2, rSSpell, stSuper);
      stat.current.coins := stat.current.coins - strtoint(btn16.Caption);
    end;
  if (mode = dtTownHall) and (Button = mbRight) then
    for i := 0 to high(buis) do
      if buis[i].enable then
        if (buis[i].location.x = x - IMPL_SIZE div 2) and (buis[i].location.y = y - IMPL_SIZE div 2) then
        begin
          buis[i].enable := false;
          exit;
        end;
  (*if (mode <> dtWall) and (mode <> dtBomb) and (mode <> dtGBomb) then
  begin
    mode := dttownhall;
    btn5.Down := true;
  end;*)
  resetwin;
end;

procedure TForm1.tmr2Timer(Sender: TObject);
var
  state, i: integer;
  x, y: extended;
  opt: array [0..5] of TBotOptions;
  QHp: integer;
  QDg: integer;
  Qs: dict;

  function GetLevel(damage: integer): integer;
  begin
    result := damage div 125000 + 1
  end;
  function genopt(var bo: TBotOptions; damage, speed, size, maxhp: extended): TBotOptions;
  begin
    bo.damage := damage;
    bo.speed := speed;
    bo.Size.width := round(size);
    bo.Size.height := round(size);
    bo.maxhp := round(maxhp);
  end;
var
  num: integer;
begin
  if BeforePlayTime > 0 then
    exit;
  state := random(4);
  if state = 0 then
  begin
    x := 0;
    y := random(GameField.height);
  end;
  if state = 1 then
  begin
    x := random(GameField.width);
    y := 0;
  end;
  if state = 2 then
  begin
    x := GameField.width;
    y := random(GameField.height);
  end;
  if state = 3 then
  begin
    x := random(GameField.width);
    y := GameField.height;
  end;
  num := stat.current.level;
  stat.current.level := getlevel(round(stat.current.damage));
  if stat.current.level > num then
    stat.current.gold := stat.current.gold + 3;
  QHp := stat.current.level;
  QDg := stat.current.level;
  if lbl4.Caption <> 'Level: ' + inttostr(QHp) then
    resetwin;

  genopt(opt[0], 0.05 * QDg, 2, round(IMPL_SIZE * 0.5), 100 * QHp);
  genopt(opt[1], 0.3 * QDg, 1, round(IMPL_SIZE * 0.8), 270 * QHp);
  genopt(opt[2], 0.4 * QDg, 0.7, round(IMPL_SIZE * 1.2), 400 * QHp);
  genopt(opt[3], 0.01 * QDg, 6, round(IMPL_SIZE * 0.26), 50 * QHp);
  genopt(opt[4], 1.0 * QDg, 0.3, round(IMPL_SIZE * 2.3), 3000 * QHp);
  genopt(opt[5], 10 * QDg, 0.1, round(IMPL_SIZE * 4.3), 30000 * QHp);

  num := GetRandomSpice(wheel);
  if num <> 2 then
    buildopp(x, y, opt[num], btCasual)
  else
    buildopp(x, y, opt[num], btExtra)
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
  GetRandomWheel(wheel, [500, 200, 50, 250, 10, 2]);
  //GetRandomWheel(wheel, [50, 20, 5, 25, 1, 2000]);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not inited then
    StartGame();
  fps.frames := 0;
  fps.lasttime := getmscount;
  PhyFps.frames := 0;
  PhyFps.lasttime := getmscount;
end;

procedure resetWin;
begin
  with form1 do
  begin
    lbl1.Caption := 'Kills: ' + inttonumber(stat.current.kills);
    lbl2.Caption := 'Damage: ' + inttonumber(round(stat.current.damage));
    lbl3.Caption := 'Coins: ' + inttonumber(round(stat.current.coins));
    lbl4.Caption := 'Level: ' + inttonumber(round(stat.current.level));
    lbl7.Caption := inttonumber(round(stat.current.gold));
    stat.overall.coins := round(sqrt((stat.overall.kills * (stat.overall.damage))))
  end;
end;

procedure drawlight(LFrom, LTo: TExPoint; ACanvas: TCanvas);
const
  QUAL = 10;
  HEIGHT = 15;
  Colors: array [0..4] of TColor = (clwhite, clblue, clskyblue, clBlue, clskyblue);
var
  lns: array of record
                    left: integer;
                    c1: integer;
                  end;
  a, i: integer;
  tmp: TExPoint;
var
  yLines: array of record
                     x, y: integer;
                   end;
  procedure clr(color: TColor; width: integer);
  var
    i: integer;
  begin
    with ACanvas do
    begin
      ACanvas.moveTo(round(LFrom.x), round(LFrom.y));
      Pen.Color := color;
      Pen.Width := width;
      for i := 0 to high(YLines) do
        lineto(YLines[i].x, YLines[i].y);
    end;
  end;
begin
  a := round(LFrom.x - LTo.x);
  a := module(a) div QUAL;
  if a > 10 then
  begin
    if LFrom.x >= Lto.x then
    begin
      tmp.x := LFrom.x;
      tmp.y := LFrom.y;
      LFrom.x := LTo.x;
      LFrom.y := LTo.y;
      Lto.x := tmp.x;
      Lto.y := tmp.y;
    end
  end
  else
  begin
    if LFrom.y >= Lto.y then
    begin
      tmp.x := LFrom.x;
      tmp.y := LFrom.y;
      LFrom.x := LTo.x;
      LFrom.y := LTo.y;
      Lto.x := tmp.x;
      Lto.y := tmp.y;
    end
  end;


  setlength(lns, a);
  setlength(YLines, a);
  ACanvas.moveTo(round(LFrom.x), round(LFrom.y));
  ACanvas.pen.Width := 2;
  if length(lns) > 10 then
  begin
    for i := 0 to high(lns) do
    begin
      lns[i].left := (i + 1) * QUAL + round(LFrom.x);
      lns[i].c1 := round(LFrom.y - (LFrom.y - LTo.y) / (length(lns) + 2) * (i + 1));
    end;
    for i := 0 to high(lns) do
    begin
      //lineI(random(height) + lns[i].c1, lns[i].left)
      YLines[i].y := random(height) + lns[i].c1;
      YLines[i].x := lns[i].left;
    end;
  end
  else
    //ACanvas.LineTo(round(LTo.x), round(LTo.y));
  begin
    //height := round(LFrom.y - LTo.y);
    a := round(LFrom.y - LTo.y);
    a := module(a) div QUAL;
    setlength(lns, a);
    setlength(YLines, a);
    for i := 0 to high(lns) do
    begin
      lns[i].left := (i + 1) * QUAL + round(LFrom.y);
      lns[i].c1 := round(LFrom.x - (LFrom.x - LTo.x) / (length(lns) + 2) * (i + 1));
    end;
    for i := 0 to high(lns) do
    begin
      //lineI(random(height) + lns[i].c1, lns[i].left)
      YLines[i].x := random(height) + lns[i].c1;
      YLines[i].y := lns[i].left;
    end;
  end;

  clr(clNavy, 5);
  clr(clblue, 4);
  clr(clSkyblue, 3);
  clr(claqua, 2);
  clr(clwhite, 1);

  ACanvas.pen.Width := 1;
end;

function plusEp(p: TExPoint; inc: extended): TExPoint;
begin
  result.x := p.x + inc;
  result.y := p.y + inc;
end;


procedure TForm1.tmr3Timer(Sender: TObject);
  function cntMines: integer;
  var
    i: integer;
  begin
    result := 0;
    for i := 0 to high(buis) do
      if (buis[i].DefType = dtMine) and (buis[i].visible) and (buis[i].enable) then
        inc(result)
  end;
var
  delta: integer;
begin
  delta := cntMines + 1;
  inc(stat.current.coins, delta);
  resetwin
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  mode := dtTesla
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  mode := dtCannon
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
  mode := dtTownhall
end;

procedure TForm1.img1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lastCoord.x := x div IMPL_SIZE * IMPL_SIZE + IMPL_SIZE div 2;
  lastCoord.y := y div IMPL_SIZE * IMPL_SIZE + IMPL_SIZE div 2;
  if down and ((mode = dtWall) or (state = srichstyle)) then
    img1MouseDown(self, mbLeft, [], x, y);
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
  mode := dtWall
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
  mode := dtBomb
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
  mode := dtGBomb
end;

procedure TForm1.btn9Click(Sender: TObject);
begin
  mode := dtMyWar
end;

procedure TForm1.btn10Click(Sender: TObject);
begin
  mode := dtMine
end;

procedure TForm1.btn11Click(Sender: TObject);
begin
  IsPaused := not IsPaused;
  if IsPaused then
    btn11.Glyph.LoadFromFile(mainpath + 'res/cont.bmp')
  else
    btn11.Glyph.LoadFromFile(mainpath + 'res/pause.bmp');
  spnl1.enabled := not IsPaused;
  timersAble(not IsPaused);
  if not IsPaused then
  begin
    windowstate := wsMaximized;
    borderstyle := bsNone
  end
  else
    borderstyle := bsSingle
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  btn11.top := 10;
  btn11.left := GAMEFIELD.width - 10 - btn11.Width;
  btn12.Left := btn11.Left;
  btn12.top := btn11.Top + btn11.width + 10;
  btn14.Left := btn12.Left;
  btn14.top := btn12.Top + btn12.width + 10;
  btn13.Left := btn14.Left;
  btn13.top := btn14.Top + btn14.width + 10;
  btn3.Left := btn13.Left;
  btn3.top := btn13.Top + btn13.width + 10;
end;

procedure TForm1.btn12Click(Sender: TObject);
var
  i: integer;
begin
  setlength(buis, 0);
  setlength(bots, 0);
  stat.current.damage := 0;
  stat.current.coins := 0;
  stat.current.kills := 0;
  stat.current.level := 1;
  resetwin;
  buildtower(townhall.location.x - 100, townhall.location.y - 125);
  buildtower(townhall.location.x + 200, townhall.location.y + 125);
  buildtower(townhall.location.x + 100, townhall.location.y - 125, dtTesla);
  buildtower(townhall.location.x - 50, townhall.location.y + 75, dtTesla);
end;

procedure TForm1.btn13Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.tmr5Timer(Sender: TObject);
begin
  borderstyle := bsNone;
  tmr5.Enabled := false;
end;

procedure TForm1.btn14Click(Sender: TObject);
begin
  IsSoundEnabled := not IsSoundEnabled;
  if IsSoundEnabled then
    btn14.Glyph.LoadFromFile(mainpath + 'res/sndon.bmp')
  else
    btn14.Glyph.LoadFromFile(mainpath + 'res/sndoff.bmp');
end;

procedure sound(name: string);
begin
  if IsSoundEnabled then
    sndPlaySound(PAnsiChar(mainpath + 'res/' + name + '.wav'), SND_ASYNC)
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EndGame();
  if form5.Visible then
    form5.Close
end;

procedure SAVE_SESSION;
begin
  stat.overall.kills := stat.overall.kills + stat.current.kills;
  stat.overall.damage := stat.overall.damage + stat.current.damage;
end;

procedure timersAble (value: boolean);
begin
  with form1 do
  begin
    tmr2.Interval := OPP_INTERVAL;
    tmr1.Enabled := value;
    tmr2.Enabled := value;
    tmr3.Enabled := value;
    tmr5.Enabled := value;
  end;
end;

procedure EndGame();
  procedure clr(p: TBitmap);
  begin
    p.Free;
  end;
var
  x: integer;
begin

  SAVE_SESSION;
  setlength(buis, 0);

  setlength(bots, 0);
  setlength(Decor_, 0);

  setlength(spells, 0);
  stat.current.damage := 0;
  stat.current.coins := 0;
  stat.current.kills := 0;
  resetwin;

  timersAble(false);
  inc(stat.overall.battles);
  form1.btn10.Caption := '115';
  form2.show;

  townhall.Free;
  clr(tmp_bmp);
  for x := 0 to high(opp_bmp) do
    clr(opp_bmp[x]);

  clr(tesla_bmp);
  clr(wall_bmp);
  clr(bomb_bmp);
  clr(GBomb_bmp);
  clr(MyWar_bmp);
  clr(Mine_bmp);
  clr(Background);
  clr(mortar_bmp);
end;

procedure StartGame();
var
  x, y: integer;
  opt: TBotOptions;
  procedure crt(var bmp: TBitmap; path: string);
  var
    x, y: integer;
  begin
    bmp := TBitmap.Create;
    bmp.LoadFromFile(mainpath + 'res/' + path);
    bmp.PixelFormat := pf24bit;
    for x := 0 to bmp.Width - 1 do
      for y := 0 to bmp.height - 1 do
        if module(bmp.Canvas.Pixels[x, y] - clwhite) < $101010 then
          bmp.Canvas.Pixels[x, y] := $99ff99;
    bmp.TransparentColor := $99ff99;
    //bmp.Transparent := true;
    bmp.TransparentMode := tmfixed
  end;
begin
  BeforePlayTime := 10000;
  lasttime := GetMSCount;
  with form1 do
  begin
    stat.current.level := 1;
    stat.current.gold := 0;
    inited := true;
    doublebuffered := true;

    townhall := TTownHall.Create;
    townhall.DefType := dtTownHall;
    townhall.location.x := (screen.width - 100) / 2;
    townhall.location.y := (screen.height - 50) / 2;

    townhall.HPLevel.Max := 70000;
    townhall.HPLevel.min := 0;
    townhall.HPLevel.current := 70000;
    townhall.width := 100;
    townhall.height := 66;

    townhall.enable := true;
    townhall.visible := true;
    crt(townhall.glyph, 'TH1.bmp');
    //buildtower(500, 320, clmaroon);
     (*
    buildtower(townhall.location.x - 100, townhall.location.y - 125);
    //buildtower(townhall.location.x + 170, townhall.location.y - 120);
    buildtower(townhall.location.x + 200, townhall.location.y + 125);
    //buildtower(townhall.location.x - 120, townhall.location.y + 110);
    //buildtower(townhall.location.x - 70, townhall.location.y - 70, dtTesla);
    buildtower(townhall.location.x + 100, townhall.location.y - 125, dtTesla);
    //buildtower(townhall.location.x + 120, townhall.location.y + 60, dtTesla);
    buildtower(townhall.location.x - 50, townhall.location.y + 75, dtTesla);
   *)
    GameField.width := screen.width;
    GameField.height := screen.height - spnl1.Height;
    img1.Picture.Bitmap.Width := GameField.width;
    img1.Picture.Bitmap.height := GameField.Height;
    img1.Picture.Bitmap.PixelFormat := pf24bit;
    log('6');
    gamefield.qp := TQuickPixels.Create;
    gamefield.qp.attach(form1.img1.Picture.Bitmap);
    (*opt.speed := 0.5;
    opt.damage := 1;
    opt.maxhp := 600000;
    opt.Size.width := 100;
    opt.Size.height := 100;
    buildopp(1600, 0, opt);
    tmr2.Enabled := false;
    *)
    crt(tmp_bmp, 'gun1.bmp');
    y := file_count(getpath + 'res/opp');
    setlength(opp_bmp, y);
    for x := 0 to high(opp_bmp) do
      crt(opp_bmp[x], 'opp/opp_' + inttostr(x) + '.bmp');
    crt(tesla_bmp, 'tesla5.bmp');
    crt(wall_bmp, 'wall.bmp');
    crt(bomb_bmp, 'bomb.bmp');
    crt(GBomb_bmp, 'GBomb.bmp');
    crt(MyWar_bmp, 'MyAr.bmp');
    crt(Mine_bmp, 'mine.bmp');
    crt(Background, 'background.bmp');
    crt(tree_bmp, 'tree.bmp');
    crt(shot_bmp, 'shot.bmp');
    crt(shot2_bmp, 'shot2.bmp');
    crt(mortar_bmp, 'mortar.bmp');
    //mortar_bmp := GetBmpFromAny(getpath + 'res/mortar.bmp');
    //zoom(tree_bmp, 100, 100);
    try
      setlength(Decor_, 0);
      if DECORATION_ON then
      begin
        for x := 1 to 10 do
          buildDecor(plate(random(gamefield.width), random(gamefield.height), IMPL_SIZE * 2, IMPL_SIZE * 2), tree_bmp);
      end;
    except
      on e: exception do
        log(e.Message)
    end;

  end;
  mc_utils.DoAsyncAction(WorkOutPhy).Priority := tpHigher;
  timersAble(true);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  if form5.Visible = false then
    form5.show
  else
    form5.Close
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  mode := dtHealSpell;
end;

procedure TForm1.btn15Click(Sender: TObject);
begin
  mode := dtPoisonSpell;
end;

procedure TForm1.btn16Click(Sender: TObject);
begin
  mode := dtSuperSpell
end;

procedure TForm1.btn4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  descriptions: array [0..11] of string = ('Ничего',
                                           'Бомба' + #13#10 + 'Урон: 50',
                                           'Большая бомба' + #13#10 + 'Урон: 100',
                                           'Блок' + #13#10 + 'Прочность: 800',
                                           'Тесла' + #13#10 + 'Урон: 12' + #13#10 + 'Прочность: 180' + #13#10 + 'Радиус: 500',
                                           'Пушка' + #13#10 + 'Урон: 80' + #13#10 + 'Прочность: 300' + #13#10 + 'Радиус: 250',
                                           'Воин' + #13#10 + 'Урон: 80' + #13#10 + 'Прочность: 450' + #13#10 + 'Радиус обнаружения: 1000',
                                           'Шахта' + #13#10 + 'Скорость добычи: 1',
                                           'Оживляющее зелье' + #13#10 + 'Мощность: 0.5' + #13#10 + 'Радиус: 140' + #13#10 + 'Время действия: 500',
                                           'Отравляющее зелье' + #13#10 + 'Мощность: 3' + #13#10 + 'Радиус: 140' + #13#10 + 'Время действия: 350',
                                           'Супер-зелье' + #13#10 + 'Перевоплощение: всех в радиусе' + #13#10 + 'Радиус: 120' + #13#10 + 'Время действия: 100',
                                           'Мортира' + #13#10 + 'Урон: 650' + #13#10 + 'Прочность: 500' + #13#10 + 'Радиус: 200');
begin
  lbl5.Caption := descriptions[(sender as TsSpeedButton).tag]
end;

procedure TForm1.btn17Click(Sender: TObject);
begin
  mode := dtMortar
end;

procedure TForm1.img1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  down := false;
end;

procedure TForm1.tmr4Timer(Sender: TObject);
begin
  if not visible then
    exit;
  lbl6.Caption := 'FPS: ' + str(roundex(fps.frames / (getmscount - fps.lasttime) * 1000, 2)) + #13#10 + 'PPS: ' + str(roundex(PhyFps.frames / (getmscount - PhyFps.lasttime) * 1000, 2)) + #13#10 + 'MRT: ' + str(MaxPaintRTime) + 'ms';
  fps.frames := 0;
  fps.lasttime := getmscount;
  PhyFps.frames := 0;
  PhyFps.lasttime := getmscount
end;

end.

