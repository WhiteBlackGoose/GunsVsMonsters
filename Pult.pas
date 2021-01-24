unit Pult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sCheckBox, ComCtrls, sTrackBar, sGroupBox;
var
  LIGHT_QUAL: integer = 10;
  LIGHT_QUAL_I: integer = 2;
  BOMB_DAMAGE: integer = 50;
  GBOMB_DAMAGE: integer = 100;
  rNormal: integer = 250;
  rBig: integer = 500;
  rSmall: integer = 150;
  rHSpell: integer = 140;
  rSSpell: integer = 120;
  HSPELL_POWER: extended = 0.5;
  PSPELL_POWER: extended = 3;
  IMPL_SIZE: integer = 50;
  DECORATION_ON: boolean = TRUE;
  EXPERIENCE_LEVEL_RANGE: integer = 290000;
  REPAINTING_IS_ON: boolean = TRUE;
  OPP_INTERVAL: integer = 225;
  CANNON_DAMAGE: integer = 160;
  TESLA_DAMAGE: integer = 24;
  MORTAR_DAMAGE: integer = 950;
  PHY_INTERVAL: integer = 15;
type
  TForm5 = class(TForm)
    grp1: TsGroupBox;
    strckbr1: TsTrackBar;
    strckbr2: TsTrackBar;
    grp2: TsGroupBox;
    strckbr3: TsTrackBar;
    strckbr4: TsTrackBar;
    grp3: TsGroupBox;
    strckbr5: TsTrackBar;
    grp4: TsGroupBox;
    strckbr6: TsTrackBar;
    grp5: TsGroupBox;
    chk1: TsCheckBox;
    chk2: TsCheckBox;
    grp6: TsGroupBox;
    strckbr7: TsTrackBar;
    grp7: TsGroupBox;
    strckbr8: TsTrackBar;
    grp8: TsGroupBox;
    strckbr9: TsTrackBar;
    strckbr10: TsTrackBar;
    strckbr11: TsTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure strckbr1Change(Sender: TObject);
    procedure strckbr2Change(Sender: TObject);
    procedure strckbr3Change(Sender: TObject);
    procedure strckbr4Change(Sender: TObject);
    procedure strckbr5Change(Sender: TObject);
    procedure strckbr6Change(Sender: TObject);
    procedure strckbr7Change(Sender: TObject);
    procedure chk1Click(Sender: TObject);
    procedure chk2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure strckbr8Change(Sender: TObject);
    procedure strckbr9Change(Sender: TObject);
    procedure strckbr10Change(Sender: TObject);
    procedure strckbr11Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
uses
  main;
{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
  strckbr1.max := LIGHT_QUAL * 2;
  strckbr1.Position := lIGHT_QUAL;
  strckbr2.max := LIGHT_QUAL_I * 2;
  strckbr2.Position := lIGHT_QUAL_I;
  strckbr3.max := BOMB_DAMAGE * 2;
  strckbr3.Position := BOMB_DAMAGE;
  strckbr4.max := GBOMB_DAMAGE * 2;
  strckbr4.Position := GBOMB_DAMAGE;
  strckbr5.max := rNormal * 2;
  strckbr5.Position := rNormal;
  strckbr6.max := IMPL_SIZE * 2;
  strckbr6.Position := IMPL_SIZE;
  strckbr7.max := EXPERIENCE_LEVEL_RANGE * 2;
  strckbr7.Position := EXPERIENCE_LEVEL_RANGE;
  strckbr8.max := PHY_INTERVAL * 2;
  strckbr8.Position := PHY_INTERVAL;
  strckbr9.max := CANNON_DAMAGE * 2;
  strckbr9.Position := CANNON_DAMAGE;
  strckbr10.max := TESLA_DAMAGE * 2;
  strckbr10.Position := TESLA_DAMAGE;
  strckbr11.max := rBig * 2;
  strckbr11.Position := rBig;
  chk2.Checked := DECORATION_ON;
  chk1.Checked := REPAINTING_IS_ON
end;

procedure TForm5.strckbr1Change(Sender: TObject);
begin
  LIGHT_QUAL := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr2Change(Sender: TObject);
begin
  LIGHT_QUAL_I := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr3Change(Sender: TObject);
begin
  BOMB_DAMAGE := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr4Change(Sender: TObject);
begin
  GBOMB_DAMAGE := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr5Change(Sender: TObject);
begin
  rNormal := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr6Change(Sender: TObject);
begin
  IMPL_SIZE := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr7Change(Sender: TObject);
begin
  EXPERIENCE_LEVEL_RANGE := (sender as TTrackBar).Position;
end;

procedure TForm5.chk1Click(Sender: TObject);
begin
  REPAINTING_IS_ON := chk1.Checked
end;

procedure TForm5.chk2Click(Sender: TObject);
begin
  DECORATION_ON := chk2.Checked
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  left := screen.width - clientwidth;
  top := screen.Height div 2
end;

procedure TForm5.strckbr8Change(Sender: TObject);
var
  f: boolean;
begin
  PHY_INTERVAL := strckbr8.Position;
  f := form1.tmr1.enabled;
  timersable(false);
  timersable(f);
end;

procedure TForm5.strckbr9Change(Sender: TObject);
begin
  CANNON_DAMAGE := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr10Change(Sender: TObject);
begin
  TESLA_DAMAGE := (sender as TTrackBar).Position;
end;

procedure TForm5.strckbr11Change(Sender: TObject);
begin
  rBig := (sender as TTrackBar).Position;
end;

end.
