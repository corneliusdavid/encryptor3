unit ufrmEncryptor3Main;

interface

uses
  WinAPI.Windows, WinAPI.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  uTPLb_CryptographicLibrary, uTPLb_BaseNonVisualComponent, uTPLb_Codec;

type
  TfrmEncryptor3 = class(TForm)
    edtSourceStr: TEdit;
    btnDecrypt: TButton;
    Label4: TLabel;
    edtResultStr: TEdit;
    btnCopyLBSymmetricResult: TButton;
    btnEncrypt: TButton;
    Label8: TLabel;
    Label2: TLabel;
    radAlgorithm: TRadioGroup;
    radCipherMode: TRadioGroup;
    radAESKeySize: TRadioGroup;
    btnAbout: TButton;
    dlgAbout: TTaskDialog;
    lbCodec: TCodec;
    CryptoLib: TCryptographicLibrary;
    lblKey: TLabel;
    edtPassphrase: TEdit;
    dlgAESKeySizeErr: TTaskDialog;
    lblKeyLen: TLabel;
    procedure btnCopyLBSymmetricResultClick(Sender: TObject);
    procedure btnEncryptClick(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure radAlgorithmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPassphraseChange(Sender: TObject);
  private
    function AESAndKeySizeOK: Boolean;
    procedure CopyToClipboard(EditControl: TEdit);
    procedure SetupCipherMode;
    procedure InitAESKey;
  end;

var
  frmEncryptor3: TfrmEncryptor3;


implementation

{$R *.DFM}

uses
  System.NetEncoding,
  uTPLb_StreamUtils, uTPLb_Constants;

procedure TfrmEncryptor3.CopyToClipboard(EditControl: TEdit);
begin
  EditControl.SelectAll;
  EditControl.CopyToClipboard;
  EditControl.SelLength := 0;
end;

procedure TfrmEncryptor3.edtPassphraseChange(Sender: TObject);
begin
  lblKeyLen.Caption := 'Key Length: ' + IntToStr(Length(edtPassphrase.Text));
end;

procedure TfrmEncryptor3.FormCreate(Sender: TObject);
begin
  radAlgorithmClick(nil);
end;

function TfrmEncryptor3.AESAndKeySizeOK: Boolean;
var
  KeySize: Integer;
begin
  Result := radAlgorithm.ItemIndex < 3;

  if not Result then begin
    KeySize := StrToInt(radAESKeySize.Items[radAESKeySize.ItemIndex]) div 8;
    Result := Length(edtPassphrase.Text) = KeySize;

    if not Result then begin
      dlgAESKeySizeErr.Text := Format('The length of the key string must be %d characters.', [KeySize]);
      dlgAESKeySizeErr.Execute;
    end;
  end;
end;

procedure TfrmEncryptor3.btnAboutClick(Sender: TObject);
begin
  dlgAbout.Execute;
end;

procedure TfrmEncryptor3.btnCopyLBSymmetricResultClick(Sender: TObject);
begin
  CopyToClipboard(edtResultStr);
end;

procedure TfrmEncryptor3.SetupCipherMode;
const
  ChainModes: array[0..3] of string = ('CBC', 'CFB', 'CTR', 'ECB');
var
  AESKeySize: Integer;
begin
  lbCodec.StreamCipherId := BlockCipher_ProgId;

  case radAlgorithm.ItemIndex of
    0: begin
      lbCodec.BlockCipherId := DES_ProgId;
    end;
    1: begin
      lbCodec.BlockCipherId := Blowfish_ProgId;
    end;
    2: begin
      lbCodec.BlockCipherId := Twofish_ProgId;
    end;
    3: begin
      AESKeySize := StrToInt(radAESKeySize.Items[radAESKeySize.ItemIndex]);
      lbCodec.BlockCipherId := Format(AES_ProgId, [AESKeySize]);
    end;
  end;

  lbCodec.ChainModeId := 'native.' + ChainModes[radCipherMode.ItemIndex];
end;

procedure TfrmEncryptor3.InitAESKey;
var
  KeyBytes: TArray<System.Byte>;
  KeyStream: TBytesStream;
begin
  KeyBytes := TEncoding.UTF8.GetBytes(edtPassphrase.Text);
  KeyStream := TBytesStream.Create(KeyBytes);
  try
    lbCodec.InitFromStream(KeyStream);
  finally
    KeyStream.Free;
  end;
end;

procedure TfrmEncryptor3.radAlgorithmClick(Sender: TObject);
begin
  if radAlgorithm.ItemIndex < 2 then begin
    ShowMessage('Only TwoFish and AES enabled right now--stream errors with the other two.  Will fix later.');
    radAlgorithm.ItemIndex := 3;
  end;

  radAESkeySize.Enabled := radAlgorithm.ItemIndex = 3;
  edtPassphrase.Enabled := radAlgorithm.ItemIndex = 3;
  lblKey.Enabled := radAlgorithm.ItemIndex = 3;
end;

procedure TfrmEncryptor3.btnEncryptClick(Sender: TObject);
var
  ResultStr: string;
begin
  if AESAndKeySizeOK then begin
    SetupCipherMode;
    InitAESKey;

    lbCodec.EncryptString(edtSourceStr.Text, ResultStr, TEncoding.UTF8);
    edtResultStr.Text := ResultStr;
  end;
end;

procedure TfrmEncryptor3.btnDecryptClick(Sender: TObject);
var
  ResultStr: string;
begin
  SetupCipherMode;
  InitAESKey;

  lbCodec.DecryptString(ResultStr, edtSourceStr.Text, TEncoding.UTF8);
  edtResultStr.Text := ResultStr;
end;

end.
