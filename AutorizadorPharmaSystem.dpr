program AutorizadorPharmaSystem;

uses
  Forms,
  Windows,
  U_PrincipalPharmaSystem in 'U_PrincipalPharmaSystem.pas' {F_PrincipalPharmaSystem},
  concentrador in 'concentrador.pas',
  U_PharmaSystem in 'U_PharmaSystem.pas',
  U_Funcoes in 'U_Funcoes.pas',
  U_DadosComplementares in 'U_DadosComplementares.pas' {F_DadosComplementares};

{$R *.res}

var
  Handle: THandle;

begin
  Handle := FindWindow( 'TF_PrincipalPharmaSystem','Autorizador PharmaSystem');
  if (Handle <> 0) then  begin { Já está aberto }
    Application.Terminate;
    Exit;  
  end;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Autorizador PharmaSystem';
  Application.CreateForm(TF_PrincipalPharmaSystem, F_PrincipalPharmaSystem);
  Application.Run;
end.
