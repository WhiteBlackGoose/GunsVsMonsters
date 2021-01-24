program GvM;

uses
  Forms,
  main in 'main.pas' {Form1},
  menu in 'menu.pas' {Form2},
  sss in 'sss.pas' {Form3},
  lg in 'lg.pas' {Form4},
  Pult in 'Pult.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
