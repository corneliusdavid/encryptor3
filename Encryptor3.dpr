program Encryptor3;

uses
  Vcl.Forms,
  ufrmEncryptor3Main in 'ufrmEncryptor3Main.pas',
  Vcl.Themes, Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Glow');
  Application.Title := 'The Encryptor!';
  Application.CreateForm(TfrmEncryptor3, frmEncryptor3);
  Application.Run;
end.
