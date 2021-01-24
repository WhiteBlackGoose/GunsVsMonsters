unit menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, sSpeedButton, inifiles, StdCtrls, sLabel, mc_utils,
  ComCtrls, sComboBoxes, Mask, sMaskEdit, ExtCtrls, sPanel, acPNG;

type
  TForm2 = class(TForm)
    btn3: TsSpeedButton;
    spnl1: TsPanel;
    lbl2: TsLabel;
    btn2: TsSpeedButton;
    lbl1: TsWebLabel;
    cbb1: TsComboBoxEx;
    spnl2: TsPanel;
    btn4: TsSpeedButton;
    btn5: TsSpeedButton;
    btn1: TsSpeedButton;
    btn6: TsSpeedButton;
    btn7: TsSpeedButton;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img6: TImage;
    lbl3: TsLabelFX;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
procedure allenable(value: boolean);
procedure allinv(value: boolean);
procedure play(coins: integer);
var
  Form2: TForm2;
  CurrentUser: string = 'Hunter';
implementation
uses
  main, sss;
{$R *.dfm}



function LoadUser(user: string): boolean;
var
  f: TIniFile;
  st: TStat;
  pth: string;
  key: string;
begin
  result := false;
  pth := mainpath + 'res/' + user + '.ini';
  if not fileexists(pth) then exit;
  CurrentUser := user;
  f := TIniFile.Create(pth);
  st.overall.kills := f.ReadInteger('data', 'kills', 0);
  st.overall.Damage := f.ReadInteger('data', 'damage', 0);
  st.overall.battles := f.ReadInteger('data', 'battles', 0);
  st.key := f.ReadString('key', 'key', '');
  key := md5(inttostr(st.overall.kills) + ' ' +
                  inttostr(round(st.overall.damage)) + ' ' +
                  inttostr(st.overall.battles) + ':::');
  if st.key = key then
  begin
    stat.overall.kills := st.overall.kills;
    stat.overall.damage := st.overall.damage;
    stat.overall.battles := st.overall.battles;
  end
  else
  begin
    showmessage('File was damaged or changed. User account was recreated.');
  end;
  f.Free;
  result := true;
end;

function SaveUser(user: string): boolean;
var
  f: TIniFile;
  pth: string;
begin
  result := false;
  pth := mainpath + 'res/' + user + '.ini';
  if not fileexists(pth) then createFile(PAnsiChar(pth));
  f := TIniFile.Create(pth);
  f.WriteInteger('data', 'kills', stat.overall.kills);
  f.WriteInteger('data', 'damage', round(stat.overall.damage));
  f.WriteInteger('data', 'battles', stat.overall.battles);
  f.WriteString('key', 'key', md5(inttostr(stat.overall.kills) + ' ' +
                                  inttostr(round(stat.overall.damage)) + ' ' +
                                  inttostr(stat.overall.battles) + ':::'));
  f.Free;
  result := true;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Users: TStringList;
  i: integer;
begin
  spnl1.Left := (clientwidth - spnl1.Width) div 2;
  spnl1.top := (clientheight - spnl1.height) div 2;
  btn6.Left := (clientwidth - btn6.Width) div 2;
  
  mainpath := getpath();
  users := (TStringList.create);
  Users.text := getFilesFrom(mainpath + 'res/', false, '.ini');
  for i := 0 to users.Count - 1 do
    if users[i] <> '' then
      cbb1.ItemsEx.AddItem(ExtractFileCaption(ExtractFileName(users[i])), 0, 0, 0, 0, 0);
  users.Free;
  spnl2.Left := 0;
  spnl2.top := 0;
end;

procedure allenable(value: boolean);
begin
  with form2 do
  begin
    btn1.Enabled := value;
    btn3.Enabled := value;
    btn4.Enabled := value;
    btn5.Enabled := value;
    btn6.Enabled := value;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveuser(currentuser)
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  if (cbb1.Text <> '') then
    if not loaduser(cbb1.text) then
    begin
      createfile((mainpath + 'res/' + cbb1.text + '.ini'));
      loaduser(cbb1.text);
    end;
  allenable(true);
  spnl1.Visible := false;
  lbl3.Visible := true;
  lbl3.Caption := 'Hi, ' + CurrentUser
end;

procedure TForm2.btn3Click(Sender: TObject);
begin
  form3.show;
  form3.formshow(nil)
end;

procedure TForm2.btn6Click(Sender: TObject);
begin
  allinv(true)
end;

procedure allinv(value: boolean);
begin
  with form2 do
  begin
    btn6.Visible := not value;
    btn3.Visible := not value;
    spnl2.Visible := value
  end;
end;

procedure play(coins: integer);
begin
  delay(plate(form2.Left, form2.Top, form2.Width, form2.Height), ['3', '2', '1'], 400);
  form2.hide;
  inited := false;
  form1.Show;
  stat.current.coins := coins
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  state := snormal;
  play(350)
end;

procedure TForm2.btn4Click(Sender: TObject);
begin
  state := ssandbox;
  play(1300)
end;

procedure TForm2.btn5Click(Sender: TObject);
begin
  state := srichstyle;
  play(150000)
end;

procedure TForm2.btn7Click(Sender: TObject);
begin
  allinv(false)
end;

end.
