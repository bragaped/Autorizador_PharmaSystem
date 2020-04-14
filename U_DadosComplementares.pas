unit U_DadosComplementares;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, JvExMask, JvToolEdit, ExtCtrls;

type
  TF_DadosComplementares = class(TForm)
    btOK: TBitBtn;
    LEstado: TLabel;
    lConselho: TLabel;
    LNRegistro: TLabel;
    LDataReceita: TLabel;
    LComplemento: TLabel;
    eDataReceita: TJvDateEdit;
    eEstado: TComboBox;
    eConselho: TComboBox;
    eNRegistro: TEdit;
    eComplemento: TEdit;
    procedure eEstadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eNRegistroKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_DadosComplementares: TF_DadosComplementares;

implementation

uses U_PrincipalPharmaSystem;

{$R *.dfm}

procedure TF_DadosComplementares.btOKClick(Sender: TObject);
begin
  if (Trim(eEstado.Text)='') then begin
    Application.MessageBox('Estado Inválido!','Atenção',MB_ICONINFORMATION);
    eEstado.SetFocus;
    Abort;
  end;
  if (Trim(eConselho.Text)='') then begin
    Application.MessageBox('Conselho Inválido!','Atenção',MB_ICONINFORMATION);
    eConselho.SetFocus;
    Abort;
  end;
  if (Trim(eNRegistro.Text)='') or (StrToIntDef(F_DadosComplementares.eNRegistro.Text,0)=0) then begin
    Application.MessageBox('Numero do Registro Inválido!','Atenção',MB_ICONINFORMATION);
    eNRegistro.SetFocus;
    Abort;
  end;
  if (Trim(eDataReceita.Text)='') then begin
    Application.MessageBox('Data da Receita Inválido!','Atenção',MB_ICONINFORMATION);
    eDataReceita.SetFocus;
    Abort;
  end;
  Close;
end;

procedure TF_DadosComplementares.eEstadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) then
    TComboBox(Sender).DroppedDown;
end;

procedure TF_DadosComplementares.eNRegistroKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9',Char(8)]) then
    Key := #0;
end;

procedure TF_DadosComplementares.FormCreate(Sender: TObject);
begin
  eEstado.Text        := F_PrincipalPharmaSystem.UF_PRESCRITOR_PADRAO;
  eConselho.ItemIndex := F_PrincipalPharmaSystem.CONSELHO_PRESCRITOR_PADRAO;
end;

procedure TF_DadosComplementares.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key of
    VK_RETURN, VK_DOWN : Perform(WM_NEXTDLGCTL,0,0);
    VK_UP              : Perform(WM_NEXTDLGCTL,1,0);
  end;
  if (Key = VK_DOWN) then Key := VK_RETURN;
  if (Key = VK_UP) then Key := VK_CONTROL;
end;

procedure TF_DadosComplementares.FormShow(Sender: TObject);
begin
  SetWindowPos(Self.Handle, HWND_TOPMOST, Self.Left, Self.Top, Self.Width, Self.Height, 0);
  SetForegroundWindow(Self.Handle);
end;

end.
