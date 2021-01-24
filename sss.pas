unit sss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sLabel, math, mc_utils, acPNG, ExtCtrls;

type
  TForm3 = class(TForm)
    lbl1: TsLabel;
    lbl2: TsLabel;
    img1: TImage;
    img2: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form3: TForm3;

implementation
uses
  menu, main;
{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
  function round1(e: Extended; step: integer = 0): extended;
  begin
    if step = 0 then
      result := round(e)
    else
    begin
      result := round(e * power(10, step)) / power(10, step)
    end;
  end;
begin
  width := form2.width;
  height := form2.height;
  lbl2.Caption := '';
  if stat.overall.battles <> 0 then
  begin
    lbl1.Caption := 'Kills for battle: ' + floattostr(round1(stat.overall.kills / stat.overall.battles, 1)) + 'k/b';
    lbl2.Caption := 'Damage for battle: ' + IntToNumber(round(stat.overall.damage / stat.overall.battles)) + 'd/b' + #13#10;
    lbl2.Caption := lbl2.Caption + 'Battles: ' + (IntToNumber(stat.overall.battles)) + #13#10;
    lbl2.Caption := lbl2.Caption + 'Damage: ' + (IntToNumber(round(stat.overall.Damage))) + #13#10;
    lbl2.Caption := lbl2.Caption + 'Kills: ' + (IntToNumber(round(stat.overall.kills))) + #13#10;
    lbl2.Caption := lbl2.Caption + 'Damage for kill: ' + floattostr(round(stat.overall.Damage / stat.overall.kills)) + 'd/k';
  end
  else
    lbl1.Caption := 'No saved statistics'
end;



end.
