unit lg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    mmo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
procedure log(s: string);
var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure log(s: string);
begin
  //form4.caption := s;
  //form4.mmo1.Lines.Add('[' + timetostr(time) + '] ' + s)
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  left := screen.width - clientwidth;
  top := screen.Height - clientheight - 390
end;

end.
