unit U_PrincipalPharmaSystem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, concentrador, InvokeRegistry, Rio, SOAPHTTPClient, ExtCtrls,
  ComCtrls, ImgList, ToolWin, XMLDoc, XMLIntf, U_PharmaSystem, StdCtrls, Buttons, Mask, JvExMask, JvToolEdit, Spin, jpeg, AppEvnts;

type
  TF_PrincipalPharmaSystem = class(TForm)
    TIAutorizador: TTrayIcon;
    StatusBar: TStatusBar;
    TBMenu: TToolBar;
    tbSalvar: TToolButton;
    tbEditar: TToolButton;
    PCPrincipal: TPageControl;
    TSConfiguracao: TTabSheet;
    ImageList: TImageList;
    TSComandosInternos: TTabSheet;
    lbComandos: TListBox;
    btExecutar: TBitBtn;
    gbIdentificacao: TGroupBox;
    eCNPJ: TMaskEdit;
    eAutenticacao: TEdit;
    eTerminal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gbDiretorios: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    eRequerimento: TJvDirectoryEdit;
    eEnvio: TJvDirectoryEdit;
    ImageListTray: TImageList;
    Timer: TTimer;
    Label6: TLabel;
    eTime: TSpinEdit;
    Image1: TImage;
    tbCancelar: TToolButton;
    tbSair: TToolButton;
    btTimer: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    gbPrescritor: TGroupBox;
    LEstado: TLabel;
    eEstado: TComboBox;
    lConselho: TLabel;
    eConselho: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbEditarClick(Sender: TObject);
    procedure tbSalvarClick(Sender: TObject);
    procedure TIAutorizadorDblClick(Sender: TObject);
    procedure btExecutarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure tbCancelarClick(Sender: TObject);
    procedure tbSairClick(Sender: TObject);
    procedure btTimerClick(Sender: TObject);
    procedure PCPrincipalChanging(Sender: TObject; var AllowChange: Boolean);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure ApplicationEventsRestore(Sender: TObject);
    procedure lbComandosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    //Diretorios Comunica��o
    fDIR_REQUERIMENTO:AnsiString;
    fDIR_ENVIO:AnsiString;
    fTIME:Integer;
    //Dados Conex�o Servidor
    fURL:AnsiString;
    fWSDLLocation:AnsiString;
    fService:AnsiString;
    fPort:AnsiString;

    //Dados Autentica��o
    fCNPJ:AnsiString;
    fNUMERO_TERMINAL:AnsiString;
    fAUTENTICA:AnsiString;
    fUF_PRESCRITOR_PADRAO:AnsiString;
    fCONSELHO_PRESCRITOR_PADRAO:Integer;

    //Dados da Mensagem
    fNOME_ARQUIVO:AnsiString;
    fNUMERO_OPERACAO:Integer;
    fID_MENSAGEM:Integer;
    fPROJETO:AnsiString;
    fCARTAO:AnsiString;
    fCPF:Int64;
    fCANAL:AnsiString;
    fNSU:Integer;
    fNUMERO_CUPOM:Integer;
    fEAN:AnsiString;

    //Armazenamento Temporario da Informa��o
    DATA:AnsiString;

    //Conteudo Retorno
    RETORNO_WEBSERVICE:AnsiString;
    STATUS:Integer;
    INSTRUCOES:AnsiString;
    XMLDoc: TXMLDocument;
    NodePri: IXMLNode;
    NodeSec: IXMLNode;
    NodeTer: IXMLNode;

    //Concentrador PharmaSystem
    DadosConexao: THTTPRIO;
    Concentrador: ConcentradorSoap;

    procedure DIRETORIOLOG();
    procedure VerificaDiretorios();
    procedure CriaARQCONFIGURACOES();
    procedure LeCONFIGURACOES();
    procedure SALVAINI();
    procedure HabilitaConfig();
    procedure SetCAMPOS();
    function GetDIRAPP: AnsiString;

    procedure MessagemStatus(MSG:AnsiString);
    procedure ADDLOG(MSG:AnsiString);
    //Conex�o
    procedure SetConexao();//Setar Conex�o do Web-Service
    procedure CloseConexao();//Finalizar Conex�o do Web-Service

    function getIDENTIFICA: AnsiString;
    function getDATAHORALOCAL: AnsiString;
    function getPRODUTO: AnsiString;
    function getDADOSCOMPLEMENTARES: AnsiString;
  public
    { Public declarations }
    Arquivo: TArquivo;
    fListadeProduto:TListadeProduto;
    fDadosComplementares:TDadosComplementares;
    fCupom:TCupom;

    procedure SETVALUEDEFAULT();//Setar Propriedades para o Default

    //Fun��es Base Projeto
    procedure AUTORIZADOR_ATIVO();

    //Rotinas para Consulta
    procedure WS_Busc_Projetos();//Consulta Projetos Do Terminal Configurado
    procedure WS_Cons_Transac();//Medodo Para Consulta da Transa��o
    procedure WS_Cons_Produto();//Metodo para Consulta de Produto na Autoriza��o
    //Rotinas de Venda
    procedure WS_Eleg_Portador();//Egibilidade do Portador
    procedure WS_Efet_Transac();//Efetiva��o da transa��o
    procedure WS_Fech_Transac();//Fechamento da transa��o
    procedure WS_Conf_Transac();//Confirma��o da transa��o
    procedure WS_Anul_Transac();//Anula��o da transa��o
    //Rotinas de Cancelamento
    procedure WS_Efet_Cancel();//Efetiva��o do cancelamento
    procedure WS_Fech_Cancel();//Fechamento do cancelamento
    procedure WS_Conf_Cancel();//Confirma��o do cancelamento
    procedure WS_Anul_Cancel();//Anula��o do cancelamento


    procedure SolicitacaoVenda();//Processo Responsavel pela Egebilidade do Portador/Efetiva��o da Venda/Fechamento da Transa��o

    property DIRETORIO_APLICACAO:AnsiString read GetDIRAPP;
    //Diretorios Comunica��o
    property DIRETORIO_REQUERIMENTO:AnsiString read fDIR_REQUERIMENTO write fDIR_REQUERIMENTO;
    property DIRETORIO_ENVIO:AnsiString read fDIR_ENVIO write fDIR_ENVIO;
    property TIME:Integer read fTIME write fTIME default 5;
    //Dados Conex�o Servidor
    property URL:AnsiString read fURL write fURL;
    property WSDLLocation:AnsiString read fWSDLLocation write fWSDLLocation;
    property Service:AnsiString read fService write fService;
    property Port:AnsiString read fPort write fPort;
    //Dados Autentica��o
    property CNPJ:AnsiString read fCNPJ write fCNPJ;
    property NUMERO_TERMINAL:AnsiString read fNUMERO_TERMINAL write fNUMERO_TERMINAL;
    property AUTENTICA:AnsiString read fAUTENTICA write fAUTENTICA;
    property UF_PRESCRITOR_PADRAO:AnsiString read fUF_PRESCRITOR_PADRAO write fUF_PRESCRITOR_PADRAO;
    property CONSELHO_PRESCRITOR_PADRAO:Integer read fCONSELHO_PRESCRITOR_PADRAO write fCONSELHO_PRESCRITOR_PADRAO Default 0;
    //Montagem Esquema Padr�o
    property IDENTIFICA:AnsiString read getIDENTIFICA;
    property DATAHORALOCAL:AnsiString read getDATAHORALOCAL;

    //Dados da Mensagem
    property NOME_ARQUIVO:AnsiString read fNOME_ARQUIVO write fNOME_ARQUIVO;
    property NUMERO_OPERACAO:Integer read fNUMERO_OPERACAO write fNUMERO_OPERACAO;
    property ID_MENSAGEM:Integer read fID_MENSAGEM write fID_MENSAGEM;
    property PROJETO:AnsiString read fPROJETO write fPROJETO;
    property CARTAO:AnsiString read fCARTAO write fCARTAO;
    property CPF:Int64 read fCPF write fCPF default 0;
    property CANAL:AnsiString read fCANAL write fCANAL;
    property NSU:Integer read fNSU write fNSU;
    property LISTADEPRODUTOXML:AnsiString read getPRODUTO;
    property NUMERO_CUPOM:Integer read fNUMERO_CUPOM write fNUMERO_CUPOM;
    property DADOSCOMPLEMENTARES:AnsiString read getDADOSCOMPLEMENTARES;
    property EAN:AnsiString read fEAN write fEAN;
  end;

const
  ARQ_CONFIGIGURACAO:String = 'AUTORIZADOR.INI';

var
  F_PrincipalPharmaSystem: TF_PrincipalPharmaSystem;

implementation

uses U_Funcoes, U_DadosComplementares;

{$R *.dfm}

{ TF_PrincipalPharmaSystem }

//Realiza a Cria��o do Arquivo de Configura��es Padr�o
procedure TF_PrincipalPharmaSystem.ADDLOG(MSG: AnsiString);
var ARQLOG:TextFile;
    NOMEARQLOG:AnsiString;
begin
  DIRETORIOLOG;
  NOMEARQLOG := FormatDateTime('DDMMYYYY',Date)+'.LOG';
  AssignFile(ARQLOG,DIRETORIO_APLICACAO+'\LOG\'+ NOMEARQLOG);
  if not(FileExists(NOMEARQLOG)) then
    Rewrite(ARQLOG)
  else begin
    //Reset(ARQLOG);
    Append(ARQLOG);
  end;
  try
    Writeln(ARQLOG,DateTimeToStr(Now)+' - '+MSG);
  finally
    Flush(ARQLOG);
    CloseFile(ARQLOG);
  end;
end;

procedure TF_PrincipalPharmaSystem.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  ADDLOG('Obj: '+Sender.ClassName+' - '+E.Message);
end;

procedure TF_PrincipalPharmaSystem.ApplicationEventsMinimize(Sender: TObject);
begin
 Self.Visible := False;
end;

procedure TF_PrincipalPharmaSystem.ApplicationEventsRestore(Sender: TObject);
begin
  Self.Visible := True;
end;

procedure TF_PrincipalPharmaSystem.AUTORIZADOR_ATIVO;
begin
  Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
  Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));
  Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(0));
  Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, 'Autorizador Ativo!');
end;

procedure TF_PrincipalPharmaSystem.btExecutarClick(Sender: TObject);
begin
  TimerTimer(Sender);
  Timer.Enabled := False;//Desativar Timer
end;

procedure TF_PrincipalPharmaSystem.btTimerClick(Sender: TObject);
begin
  Timer.Enabled := not(Timer.Enabled);
  if (Timer.Enabled) then
    btTimer.Caption := 'Desativar Timer'
  else
    btTimer.Caption := 'Ativar Timer';
end;

procedure TF_PrincipalPharmaSystem.CloseConexao;//Finalizar Conex�o do Web-Service
begin
  MessagemStatus('Finalizando Conex�o');
  MessagemStatus('Ativo - Aguardando Solicita��o');
end;

procedure TF_PrincipalPharmaSystem.CriaARQCONFIGURACOES;
begin
  if not FileExists(DIRETORIO_APLICACAO+'\'+ARQ_CONFIGIGURACAO) then begin
    //Diretorios Comunica��o
    DIRETORIO_REQUERIMENTO := DIRETORIO_APLICACAO+'\REQ';
    DIRETORIO_ENVIO        := DIRETORIO_APLICACAO+'\ENV';
    //Dados Conex�o Servidor
    URL          := 'http://www.conectapdv.com.br/concentrador/concentrador.asmx';
    WSDLLocation := 'http://www.conectapdv.com.br/concentrador/concentrador.asmx?wsdl';
    Service      := 'Concentrador';
    Port         := 'ConcentradorSoap12';
    //Dados Autentica��o
    CNPJ            := '';
    NUMERO_TERMINAL := '0';
    AUTENTICA       := '0';

    SALVAINI;
  end;
end;

procedure TF_PrincipalPharmaSystem.DIRETORIOLOG;
begin
  //Diretorio de Log
  if not(DirectoryExists(DIRETORIO_APLICACAO+'\LOG')) then
    CreateDir(DIRETORIO_APLICACAO+'\LOG');
end;

procedure TF_PrincipalPharmaSystem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TIAutorizador.Animate := False;
  TIAutorizador.Visible := False;
  Timer.Enabled := False;
end;

procedure TF_PrincipalPharmaSystem.FormCreate(Sender: TObject);
begin
  gbIdentificacao.Enabled := False;
  gbDiretorios.Enabled    := False;
  gbPrescritor.Enabled    := False;

  TIAutorizador.Animate := True;
  TIAutorizador.Visible := True;
  eRequerimento.InitialDir := DIRETORIO_APLICACAO+'\REQ';
  eEnvio.InitialDir        := DIRETORIO_APLICACAO+'\ENV';
  MessagemStatus('Carregando Configura��es');
  CriaARQCONFIGURACOES();
  LeCONFIGURACOES();
  VerificaDiretorios();
  SetCAMPOS();

  Application.Minimize;
  Application.ShowMainForm:= False;

  MessagemStatus('Ativo - Aguardando Solicita��o');
  Timer.Enabled := True;
  if (Timer.Enabled) then
    btTimer.Caption := 'Desativar Timer'
  else
    btTimer.Caption := 'Ativar Timer';
end;

procedure TF_PrincipalPharmaSystem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key of
    VK_RETURN, VK_DOWN : Perform(WM_NEXTDLGCTL,0,0);
    VK_UP              : Perform(WM_NEXTDLGCTL,1,0);
  end;
  if (Key = VK_DOWN) then Key := VK_RETURN;
  if (Key = VK_UP) then Key := VK_CONTROL;
end;

//Fun��o para Pegar Data e Hora Formatada no Padr�o Utilizado pelo Autorizador
function TF_PrincipalPharmaSystem.getDADOSCOMPLEMENTARES: AnsiString;
begin
  Result := '';
  if (fDadosComplementares<>nil) then begin
    if (fDadosComplementares.NUMERO_PRESCRITOR>0) then begin
      Result := '<dados>' +
                    '<tipo_prescritor>' + IntToStr(fDadosComplementares.TIPO_PRESCRITOR)                  + '</tipo_prescritor>' +
                    '<uf_prescritor>'   + fDadosComplementares.UF_PRESCRITOR                              + '</uf_prescritor>'   +
                    '<num_prescritor>'  + FormatFloat('###000000',fDadosComplementares.NUMERO_PRESCRITOR) + '</num_prescritor>'  +
                    '<emis_prescricao>' + fDadosComplementares.EMIS_PRESCRICAO                            + '</emis_prescricao>' +
                    '<complemento>'     + fDadosComplementares.COMPLEMENTO                                + '</complemento>'     +
                '</dados>';
    end;
  end;
end;

function TF_PrincipalPharmaSystem.getDATAHORALOCAL: AnsiString;
begin
  Result := FormatDateTime('DDMMYYYYHHNNSS',Now);
end;

function TF_PrincipalPharmaSystem.GetDIRAPP: AnsiString;
begin
  Result := ExtractFileDir(Application.ExeName);
end;

//Fun��o para Gerar Identica��o do Terminal
function TF_PrincipalPharmaSystem.getIDENTIFICA: AnsiString;
begin
  Result := '<identifica>' +
                '<cnpj>'      + CNPJ            + '</cnpj>' +
                '<terminal>'  + NUMERO_TERMINAL + '</terminal>' +
                '<autentica>' + AUTENTICA       + '</autentica>' +
            '</identifica>';
end;

function TF_PrincipalPharmaSystem.getPRODUTO: AnsiString;
var I:Integer;
begin
  Result := '';
  if (fListadeProduto<>nil) then begin
    if (fListadeProduto.Count>0) then begin
      Result := '<produtos>';
      for I := 0 to fListadeProduto.Count - 1 do begin
        Result := Result +
                  '<produto>' +
                      '<ean>'         + fListadeProduto[I].EAN                                         + '</ean>' +
                      '<qtdade>'      + FloatToStr(fListadeProduto[I].QUANTIDADE_SOLICITADA)           + '</qtdade>' +
                      '<prc_bruto>'   + FormatCurr('#######000',fListadeProduto[I].PRECO_BRUTO*100)    + '</prc_bruto>' +
                      '<prc_liquido>' + FormatCurr('#######000',fListadeProduto[I].PRECO_LIQUIDO*100)  + '</prc_liquido>' +
                      '<codigo>'      + fListadeProduto[I].CODIGO                                      + '</codigo>' +
                      '<descricao>'   + fListadeProduto[I].DESCRICAO                                   + '</descricao>' +
                  '</produto>';
      end;
      Result := Result +
                '</produtos>';
    end;
  end;
end;

procedure TF_PrincipalPharmaSystem.HabilitaConfig;
begin
  tbSalvar.Enabled   := not(tbSalvar.Enabled);
  tbCancelar.Enabled := not(tbCancelar.Enabled);
  tbEditar.Enabled   := not(tbEditar.Enabled);
  tbSair.Enabled     := not(tbSair.Enabled);
  Timer.Enabled           := not(Timer.Enabled);
  gbIdentificacao.Enabled := not(gbIdentificacao.Enabled);
  gbDiretorios.Enabled    := not(gbDiretorios.Enabled);
  gbPrescritor.Enabled    := not(gbPrescritor.Enabled);
end;

procedure TF_PrincipalPharmaSystem.lbComandosClick(Sender: TObject);
begin

end;

//Le Informa��es Sobre as Configura��es
procedure TF_PrincipalPharmaSystem.LeCONFIGURACOES;
var ARQ_INI:TIniFile;
begin
  if FileExists(DIRETORIO_APLICACAO+'\'+ARQ_CONFIGIGURACAO) then begin
    ARQ_INI := TIniFile.Create(DIRETORIO_APLICACAO+'\'+ARQ_CONFIGIGURACAO);
    try
      //Diretorios Comunica��o
      DIRETORIO_REQUERIMENTO := ARQ_INI.ReadString('DIRETORIOS','REQUERIMENTO',DIRETORIO_APLICACAO+'\REC');
      DIRETORIO_ENVIO        := ARQ_INI.ReadString('DIRETORIOS','ENVIO',DIRETORIO_APLICACAO+'\ENV');
      TIME                   := ARQ_INI.ReadInteger('DIRETORIOS','TIME',5);
      if (TIME<=2) then TIME := 5;

      //Dados Conex�o Servidor
      URL                   := ARQ_INI.ReadString('WEBSERVICE','URL','http://www.conectapdv.com.br/concentrador/concentrador.asmx');
      WSDLLocation          := ARQ_INI.ReadString('WEBSERVICE','WSDLLocation','http://www.conectapdv.com.br/concentrador/concentrador.asmx?wsdl');
      Service               := ARQ_INI.ReadString('WEBSERVICE','Service','Concentrador');
      Port                  := ARQ_INI.ReadString('WEBSERVICE','Port','ConcentradorSoap12');

      //Dados Autentica��o
      CNPJ                  := ARQ_INI.ReadString('IDENTIFICACAO','CNPJ','');
      NUMERO_TERMINAL       := ARQ_INI.ReadString('IDENTIFICACAO','NUMERO_TERMINAL',FormatFloat('000000',1));
      AUTENTICA             := ARQ_INI.ReadString('IDENTIFICACAO','AUTENTICA',FormatFloat('00000000',0));

      UF_PRESCRITOR_PADRAO  := ARQ_INI.ReadString('PRESCRITOR','UF','SP');
      CONSELHO_PRESCRITOR_PADRAO := ARQ_INI.ReadInteger('PRESCRITOR','CONSELHO',0);
    finally
      ARQ_INI.Free;
    end;
  end;
end;

procedure TF_PrincipalPharmaSystem.MessagemStatus(MSG: AnsiString);
begin
  Application.ProcessMessages;
  StatusBar.Panels[1].Text := MSG;
  StatusBar.Repaint;
  ADDLOG(MSG);
end;

procedure TF_PrincipalPharmaSystem.PCPrincipalChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if tbSalvar.Enabled then
    AllowChange := False;
end;

//Configura��o dos Dadas da Conex�o com o WebService
procedure TF_PrincipalPharmaSystem.SALVAINI;
var ARQ_INI:TIniFile;
begin
  ARQ_INI := TIniFile.Create(DIRETORIO_APLICACAO+'\'+ARQ_CONFIGIGURACAO);
  try
    //Diretorios Comunica��o
    ARQ_INI.WriteString('DIRETORIOS','REQUERIMENTO',DIRETORIO_REQUERIMENTO);
    ARQ_INI.WriteString('DIRETORIOS','ENVIO',DIRETORIO_ENVIO);
    ARQ_INI.WriteInteger('DIRETORIOS','TIME',TIME);
    //Dados Conex�o Servidor
    ARQ_INI.WriteString('WEBSERVICE','URL',URL);
    ARQ_INI.WriteString('WEBSERVICE','WSDLLocation',WSDLLocation);
    ARQ_INI.WriteString('WEBSERVICE','Service',Service);
    ARQ_INI.WriteString('WEBSERVICE','Port',Port);
    //Dados Autentica��o
    ARQ_INI.WriteString('IDENTIFICACAO','CNPJ',CNPJ);
    ARQ_INI.WriteString('IDENTIFICACAO','NUMERO_TERMINAL',NUMERO_TERMINAL);
    ARQ_INI.WriteString('IDENTIFICACAO','AUTENTICA',AUTENTICA);
    //Dados Prescritor
    ARQ_INI.WriteString('PRESCRITOR','UF',UF_PRESCRITOR_PADRAO);
    ARQ_INI.WriteInteger('PRESCRITOR','CONSELHO',CONSELHO_PRESCRITOR_PADRAO);
  finally
    ARQ_INI.Free;
  end;
end;

procedure TF_PrincipalPharmaSystem.SetCAMPOS;
begin
  eCNPJ.Text          := CNPJ;
  eAutenticacao.Text  := AUTENTICA;
  eTerminal.Text      := NUMERO_TERMINAL;

  eConselho.ItemIndex := CONSELHO_PRESCRITOR_PADRAO;
  eEstado.ItemIndex   := eEstado.Items.IndexOf(UF_PRESCRITOR_PADRAO);

  eRequerimento.Text  := DIRETORIO_REQUERIMENTO;
  eEnvio.Text         := DIRETORIO_ENVIO;
  eTime.Value         := TIME;
  Timer.Interval      := TIME*1000;//Setar Intervalos em Segundos
end;

procedure TF_PrincipalPharmaSystem.SetConexao;//Setar Conex�o do Web-Service
begin
  MessagemStatus('Iniciando Conex�o');
  STATUS     := 0;
  INSTRUCOES := '';
  if (DadosConexao=nil) then
    DadosConexao := THTTPRIO.Create(nil);
  DadosConexao.URL          := URL;
  DadosConexao.WSDLLocation := WSDLLocation;
  DadosConexao.Service      := Service;
  DadosConexao.Port         := Port;
  Concentrador := DadosConexao AS ConcentradorSoap;
end;

procedure TF_PrincipalPharmaSystem.SETVALUEDEFAULT;//Setar Propriedades para o Default
begin
  NOME_ARQUIVO    := '';
  ID_MENSAGEM     := 0;
  NUMERO_OPERACAO := 0;
  PROJETO         := '';
  CARTAO          := '';
  CPF             := 0;
  CANAL           := '';
  NSU             := 0;
  UF_PRESCRITOR_PADRAO := 'SP';
  CONSELHO_PRESCRITOR_PADRAO := 0;

  FreeAndNil(fListadeProduto);
  FreeAndNil(fDadosComplementares);
  FreeAndNil(fCupom);
end;

procedure TF_PrincipalPharmaSystem.SolicitacaoVenda;//Processo Responsavel pela Egebilidade do Portador/Efetiva��o da Venda/Fechamento da Transa��o
var Exige_CRM:Boolean;
    Produto: TProduto;
    LINHACUPOM:TLinhaCupom;
    I: Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  fCupom := TCupom.Create;
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Egibilidade do Portador');
      RETORNO_WEBSERVICE := Concentrador.WS_Eleg_Portador(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, CANAL);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Egibilidade do Portador');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM,     IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;

        NSU   := StrToIntDef(NodePri.ChildNodes['nsu_host'].Text,0);//Identifica��o da transa��o
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, IntToStr(NSU));

        DATA  := NodePri.ChildNodes['exige_crm'].Text;//Exige captura de C.R.M.?
        Exige_CRM := (StrToIntDef(DATA,0)=1);
        if (Exige_CRM) and (DADOSCOMPLEMENTARES='') then begin
          Application.CreateForm(TF_DadosComplementares,F_DadosComplementares);
          try
            F_DadosComplementares.ShowModal;
          finally
            if (fDadosComplementares=nil) then fDadosComplementares := TDadosComplementares.Create;
            fDadosComplementares.TIPO_PRESCRITOR  := F_DadosComplementares.eConselho.ItemIndex+1;
            fDadosComplementares.UF_PRESCRITOR    := F_DadosComplementares.eEstado.Text;
            fDadosComplementares.NUMERO_PRESCRITOR:= StrToIntDef(F_DadosComplementares.eNRegistro.Text,0);
            fDadosComplementares.EMIS_PRESCRICAO  := FormatDateTime('DDMMYYYY',F_DadosComplementares.eDataReceita.Date);
            fDadosComplementares.COMPLEMENTO      := F_DadosComplementares.eComplemento.Text;
            F_DadosComplementares.Free;
          end;
        end;

        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

          MessagemStatus('Realizando Efetiva��o da Transa��o');
          //Efetiva��o dos Produtos
          if (Trim(DADOSCOMPLEMENTARES)='') then begin
            RETORNO_WEBSERVICE := Concentrador.WS_Efet_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, LISTADEPRODUTOXML);
          end
          else begin
            RETORNO_WEBSERVICE := Concentrador.WS_Efet_Transac2(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, LISTADEPRODUTOXML, DADOSCOMPLEMENTARES);
          end;
          fListadeProduto.Clear;
          if (Trim(RETORNO_WEBSERVICE)>'') then begin
            MessagemStatus('Lendo Retorno da Efetiva��o de Transa��o');
            XMLDoc.Active := False;
            XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
            XMLDoc.Active := True;
            //Pegar Dados do XML de Retorno
            NodePri := XMLDoc.ChildNodes.FindNode('retorno');
            NodePri.ChildNodes.First;

            STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
            try
              INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
            except end;

            NodeSec := NodePri.ChildNodes['produtos'];
            NodeSec.ChildNodes.First;
            NodeTer := NodeSec.ChildNodes['produto'];
            NodeTer.ChildNodes.First; //Possicionar no Primeiro Produto
            repeat
              //Adiciona Produtos na lista
              Produto := TProduto.Create;
              Produto.CODIGO              := NodeTer.ChildNodes['codigo'].Text;//C�digo do produto (interno do operador)
              Produto.EAN                 := NodeTer.ChildNodes['ean'].Text;//C�digo EAN do produtoK
              Produto.PRECO_BRUTO         := StrToCurrDef(NodeTer.ChildNodes['prc_bruto'].Text,0)/100;//Valor bruto
              Produto.PRECO_LIQUIDO       := StrToCurrDef(NodeTer.ChildNodes['prc_liquido'].Text,0)/100;//Valor l�quido
              Produto.PRECO_RECEBER       := StrToCurrDef(NodeTer.ChildNodes['prc_receber'].Text,0)/100;//Valor a receber
              Produto.PERCENTUAL_DESCONTO := StrToFloatDef(NodeTer.ChildNodes['desconto'].Text,0)/100;//Desconto � conceder
              Produto.STATUS_PRODUTO      := StrToIntDef(NodeTer.ChildNodes['status_prod'].Text,0);//Status do produto
              Produto.MENSAGEM_PRODUTO    := NodeTer.ChildNodes['mens_prod'].Text;//Mensagem
              Produto.QUANTIDADE_APROVADA := StrToFloatDef(NodeTer.ChildNodes['qtdade'].Text,0);//Quantidade aprovada
              fListadeProduto.Add(Produto);

              if (Produto.STATUS_PRODUTO=0) then begin
                STATUS := 0;
                INSTRUCOES := '';
              end;
              NodeTer := NodeTer.NextSibling;//Pular para o Proximo Registro
            until (NodeTer=nil);

            //Gravar Dados para o Envio
            if (fListadeProduto.Count>0) then begin
              for I := 0 to fListadeProduto.Count - 1 do begin
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRODUTO+FormatFloat('000',I),
                                             fListadeProduto[I].CODIGO         + ';' +
                                             fListadeProduto[I].EAN            + ';' +
                                             FormatCurr('######0.00',fListadeProduto[I].PRECO_BRUTO)           + ';' +
                                             FormatCurr('######0.00',fListadeProduto[I].PRECO_LIQUIDO)         + ';' +
                                             FormatCurr('######0.00',fListadeProduto[I].PRECO_RECEBER)         + ';' +
                                             FormatFloat('######0.00',fListadeProduto[I].PERCENTUAL_DESCONTO)  + ';' +
                                             FormatFloat('#########0',fListadeProduto[I].QUANTIDADE_APROVADA)  + ';' +
                                             fListadeProduto[I].MENSAGEM_PRODUTO                               + ';' +
                                             IntToStr(fListadeProduto[I].STATUS_PRODUTO));
                if (fListadeProduto[I].STATUS_PRODUTO=0) then begin
                  STATUS     := 0;
                  INSTRUCOES := '';
                end;
              end;
              INSTRUCOES := INSTRUCOES + IIF(Length(INSTRUCOES)>0,' - ','') + 'Efetiva��o da Transa��o Realizada com Sucesso.';
            end;
          end;
          if (STATUS=0) then begin
            MessagemStatus('Realizando Fechamento da Transa��o');
            RETORNO_WEBSERVICE := Concentrador.WS_Fech_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, NUMERO_CUPOM, DADOSCOMPLEMENTARES);
            if (Trim(RETORNO_WEBSERVICE)>'') then begin
              MessagemStatus('Lendo Retorno do Fechamento da Transa��o');
              XMLDoc.Active := False;
              XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
              XMLDoc.Active := True;
              //Pegar Dados do XML de Retorno
              NodePri := XMLDoc.ChildNodes.FindNode('retorno');
              NodePri.ChildNodes.First;

              STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
              try
                INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
              except end;
              if (STATUS=0) then begin
                DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_bruto'].Text,0)/100);//Valor bruto
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECOBRUTO, DATA);
                DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_liquido'].Text,0)/100);//Valor l�quido
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECOLIQUIDO, DATA);
                DATA  := FormatFloat('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_desconto'].Text,0)/100);//Valor Desconto
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_PERCENTUALDESCONTO, DATA);
                DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_receber'].Text,0)/100);//Valor receber
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECORECEBER, DATA);
                DATA  := NodePri.ChildNodes['autorizacao'].Text;//Autoriza��o
                Arquivo.EscreveChaveArquivoEnvio(CHAVE_AUTORIZACAO, DATA);

                //Pegar Linhas a Serem Impressas no Comprovante
                NodeSec := NodePri.ChildNodes['linhas'];
                NodeSec.ChildNodes.First;//Possicionar na Primeira Linha do Comprovante
                for I := 0 to NodeSec.ChildNodes.Count -1 do begin
                  LINHACUPOM := TLinhaCupom.Create;
                  LINHACUPOM.LINHA := NodeSec.ChildNodes.Nodes[I].Text;
                  fCupom.Add(LINHACUPOM);
                end;

                Arquivo.EscreveChaveArquivoEnvio(CHAVE_TOTALLINHACUPOM, IntToStr(fCupom.Count));
                for I := 0 to fCupom.Count - 1 do
                  Arquivo.EscreveChaveArquivoEnvio(CHAVE_LINHACUPOM+FormatFloat('000',I), fCupom[I].LINHA);

                INSTRUCOES := INSTRUCOES + IIF(Length(INSTRUCOES)>0,' - ','') + 'Fechamento da Transa��o Realizada com Sucesso.';
              end;
            end;
          end;
        end;

        //Processo para Anula��o da Transa��o
        if (NSU>0) and (STATUS<>0) then begin
          MessagemStatus('Realizando Anula��o de Transa��o');
         RETORNO_WEBSERVICE := Concentrador.WS_Anul_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
          if (Trim(RETORNO_WEBSERVICE)>'') then begin
            MessagemStatus('Lendo Retorno da Anula��o de Transa��o');
            STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
            try
              INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
            except end;
            if (STATUS=0) then begin
              STATUS     := 999;
              INSTRUCOES := 'Processo de Venda Anulado.';
            end;
          end;
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES,   INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Egibilidade do Portador: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    fCupom.Clear;
    fListadeProduto.Clear;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.tbEditarClick(Sender: TObject);
begin
  HabilitaConfig();
end;

procedure TF_PrincipalPharmaSystem.tbSalvarClick(Sender: TObject);
begin
  if (eEnvio.Text=eRequerimento.Text) then begin
    Application.MessageBox('Diretorio de Envio deve ser Direferente do Diretorio de Recebimento!','Informa��o',MB_ICONINFORMATION);
    eEnvio.SetFocus;
    Abort;
  end;
  MessagemStatus('Salvando Configura��es');
  CNPJ                  := eCNPJ.Text;
  AUTENTICA             := eAutenticacao.Text;
  NUMERO_TERMINAL       := eTerminal.Text;
  DIRETORIO_REQUERIMENTO:= eRequerimento.Text;
  DIRETORIO_ENVIO       := eEnvio.Text;
  TIME                  := eTime.Value;
  UF_PRESCRITOR_PADRAO  := eEstado.Text;
  CONSELHO_PRESCRITOR_PADRAO := eConselho.ItemIndex;
  SALVAINI;
  Application.MessageBox('Configura��es Salvas com Sucesso!','Informa��o',MB_ICONINFORMATION);
  HabilitaConfig();
end;

procedure TF_PrincipalPharmaSystem.TIAutorizadorDblClick(Sender: TObject);
begin
  Self.Visible := True;
  Self.BringToFront();
end;

procedure TF_PrincipalPharmaSystem.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;//Parar Chamada do Evento
  Application.ProcessMessages;
  try
    NOME_ARQUIVO := VerificaArquivo(DIRETORIO_REQUERIMENTO);//Verfificar se Existe Arquivo de Solicita��o
    if (Trim(NOME_ARQUIVO)>'') then begin
      try
        MessagemStatus('Ativo - Verificando Solicita��o');
        Arquivo := TArquivo.Create(NOME_ARQUIVO);
        try
          Arquivo.CarregaArquivoRequeerimento();
          //Executar Fun��es
          case ID_MENSAGEM of
            0:AUTORIZADOR_ATIVO;//Mostra que o Autorizador est� Ativo
            1:WS_Busc_Projetos;//Consulta Projetos Do Terminal Configurado
            2:WS_Eleg_Portador;//Egibilidade do Portador
            3:WS_Efet_Transac;//Efetiva��o de transa��o
            4:WS_Fech_Transac;//Fechamento de transa��o
            5:WS_Conf_Transac;//Confirma��o de transa��o
            6:WS_Anul_Transac;//Anula��o de transa��o
            7:WS_Efet_Cancel;//Efetiva��o de cancelamento
            8:WS_Fech_Cancel;//Fechamento de cancelamento
            9:WS_Conf_Cancel;//Confirma��o de cancelamento
            10:WS_Anul_Cancel;//Anula��o de cancelamento
            11:WS_Cons_Transac();//Medodo Para Consulta da Transa��o
            12:WS_Cons_Produto();//Metodo para Consulta de Produto no Convenio

            20:SolicitacaoVenda();//Processo Responsavel pela Egebilidade do Portador/Efetiva��o da Venda/Fechamento da Transa��o
          end;
        finally
          Arquivo.FechaArquivoEnvio;
          Arquivo.Free;
          MessagemStatus('Ativo - Aguardando Solicita��o');
        end;
      except
        on E:Exception do begin
          ADDLOG(E.Message);
        end;
      end;
    end;
  finally
    SETVALUEDEFAULT();//Setar Propriedades para o Default
    Timer.Enabled := True;//Reativar Chamada do Evento
  end;
end;

procedure TF_PrincipalPharmaSystem.tbCancelarClick(Sender: TObject);
begin
  MessagemStatus('Carregando Configura��es');
  LeCONFIGURACOES;
  SetCAMPOS();
  HabilitaConfig();
end;

procedure TF_PrincipalPharmaSystem.tbSairClick(Sender: TObject);
begin
  Close;
end;

//Verifica��o para Cria��o dos Diretorios
procedure TF_PrincipalPharmaSystem.VerificaDiretorios;
begin
  DIRETORIOLOG;
  //Diretorio de Recebimento de Mensagens
  if not(DirectoryExists(DIRETORIO_REQUERIMENTO)) then begin
    try
      CreateDir(DIRETORIO_REQUERIMENTO);
    except
      DIRETORIO_REQUERIMENTO := DIRETORIO_APLICACAO+'\REQ';
      CreateDir(DIRETORIO_REQUERIMENTO);
    end;
  end;
  //Diretorio de Envio de Mensagens
  if not(DirectoryExists(DIRETORIO_ENVIO)) then begin
    try
      CreateDir(DIRETORIO_ENVIO);
    except
      DIRETORIO_ENVIO := DIRETORIO_APLICACAO+'\ENV';
      CreateDir(DIRETORIO_ENVIO);
    end;
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Busc_Projetos;//Consulta Projetos Do Terminal Configurado
var Convenio:TConvenio;
    ListadeConvenio:TListadeConvenio;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  ListadeConvenio := TListadeConvenio.Create(True);
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Consulta de Projetos');
      RETORNO_WEBSERVICE := Concentrador.WS_Busc_Projetos(IDENTIFICA);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Consulta');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        NodeSec := NodePri.ChildNodes['projetos'];
        NodeSec.ChildNodes.First; //Possicionar no Primeiro Projeto
        repeat
          //Adicionar Convenio a Lista
          STATUS     := StrToIntDef(NodeSec.ChildNodes['status'].Text,0);//Status da Transa��o
          try
            INSTRUCOES := NodeSec.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
          except end;
          if (STATUS=0) then begin
            //Dados do Projeto
            Convenio := TConvenio.Create;
            Convenio.IDCADASTRO := StrToIntDef(NodeSec.ChildNodes['idcadastro'].Text,0);
            Convenio.IDPROJETO  := StrToIntDef(NodeSec.ChildNodes['idProjeto'].Text,0);
            Convenio.CODIGO     := NodeSec.ChildNodes['codigo'].Text;
            Convenio.DESCRICAO  := NodeSec.ChildNodes['descricao'].Text;
            Convenio.EMPRESA    := NodeSec.ChildNodes['empresa'].Text;
            Convenio.MODALIDADE := NodeSec.ChildNodes['modalidade'].Text;
            ListadeConvenio.Add(Convenio);
          end;

          NodeSec := NodeSec.NextSibling;//Pular para o Proximo Registro
        until (NodeSec=nil);

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));
        //Gravar Dados para o Envio
        if (ListadeConvenio.Count>0) then begin
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TOTALPROJETO, IntToStr(ListadeConvenio.Count));
          for I := 0 to ListadeConvenio.Count - 1 do begin
            Arquivo.EscreveChaveArquivoEnvio(CHAVE_DADOSPROEJTO+FormatFloat('000',I),
                                         IntToStr(ListadeConvenio[I].IDCADASTRO)+ ';' +
                                         IntToStr(ListadeConvenio[I].IDPROJETO) + ';' +
                                         ListadeConvenio[I].CODIGO              + ';' +
                                         ListadeConvenio[I].DESCRICAO           + ';' +
                                         ListadeConvenio[I].EMPRESA             + ';' +
                                         ListadeConvenio[I].MODALIDADE          );
          end;
          INSTRUCOES := INSTRUCOES + 'Consulta Realizada com Sucesso.';
        end;
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Consulta de Projetos: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    ListadeConvenio.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Efet_Cancel;//Executa Cancelamento de Produto na Autoriza��o
var Produto:TProduto;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Efetiva��o de Cancelamento');
      RETORNO_WEBSERVICE := Concentrador.WS_Efet_Cancel(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, LISTADEPRODUTOXML);
      fListadeProduto.Clear;
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Efetiva��o de Cancelamento');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);

          NodeSec := NodePri.ChildNodes['produtos'];
          NodeSec.ChildNodes.First;
          NodeTer := NodeSec.ChildNodes['produto'];
          NodeTer.ChildNodes.First; //Possicionar no Primeiro Produto
          repeat
            //Adiciona Produtos na lista
            Produto := TProduto.Create;
            Produto.CODIGO              := NodeTer.ChildNodes['codigo'].Text;//C�digo do produto (interno do operador)
            Produto.EAN                 := NodeTer.ChildNodes['ean'].Text;//C�digo EAN do produtoK
            Produto.PRECO_BRUTO         := StrToCurrDef(NodeTer.ChildNodes['prc_bruto'].Text,0)/100;//Valor bruto
            Produto.PRECO_LIQUIDO       := StrToCurrDef(NodeTer.ChildNodes['prc_liquido'].Text,0)/100;//Valor l�quido
            Produto.PRECO_RECEBER       := StrToCurrDef(NodeTer.ChildNodes['prc_receber'].Text,0)/100;//Valor a receber
            Produto.PERCENTUAL_DESCONTO := StrToFloatDef(NodeTer.ChildNodes['desconto'].Text,0)/100;//Desconto � conceder
            Produto.STATUS_PRODUTO      := StrToIntDef(NodeTer.ChildNodes['status_prod'].Text,0);//Status do produto
            Produto.MENSAGEM_PRODUTO    := NodeTer.ChildNodes['mens_prod'].Text;//Mensagem
            Produto.QUANTIDADE_APROVADA := StrToFloatDef(NodeTer.ChildNodes['qtdade'].Text,0);//Quantidade aprovada
            fListadeProduto.Add(Produto);

            NodeTer := NodeTer.NextSibling;//Pular para o Proximo Registro
          until (NodeTer=nil);

          //Gravar Dados para o Envio
          if (fListadeProduto.Count>0) then begin
            for I := 0 to fListadeProduto.Count - 1 do begin
              Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRODUTO+FormatFloat('000',I),
                                           //fListadeProduto[I].CODIGO         + ';' +
                                           fListadeProduto[I].EAN            + ';' +
                                           //FormatCurr('######0.00',fListadeProduto[I].PRECO_BRUTO)           + ';' +
                                           //FormatCurr('######0.00',fListadeProduto[I].PRECO_LIQUIDO)         + ';' +
                                           //FormatCurr('######0.00',fListadeProduto[I].PRECO_RECEBER)         + ';' +
                                           //FormatFloat('######0.00',fListadeProduto[I].PERCENTUAL_DESCONTO)  + ';' +
                                           FormatFloat('#########0',fListadeProduto[I].QUANTIDADE_APROVADA)  + ';' +
                                           fListadeProduto[I].MENSAGEM_PRODUTO                               + ';' +
                                           IntToStr(fListadeProduto[I].STATUS_PRODUTO));
            end;
            INSTRUCOES := INSTRUCOES + 'Efetiva��o de Cancelamento Realizada com Sucesso.';
          end;

          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Efetiva��o de Cancelamento: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    fListadeProduto.Clear;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Efet_Transac;//Executa Fun��o de Inclus�o de Produtos na Autoriza��o
var Produto:TProduto;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Efetiva��o da Transa��o');
      if (Trim(DADOSCOMPLEMENTARES)='') then begin
        RETORNO_WEBSERVICE := Concentrador.WS_Efet_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, LISTADEPRODUTOXML);
      end
      else begin
        RETORNO_WEBSERVICE := Concentrador.WS_Efet_Transac2(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, LISTADEPRODUTOXML, DADOSCOMPLEMENTARES);
      end;
      fListadeProduto.Clear;
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Efetiva��o de Transa��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        //Quando exite mais de 1 item na Solicita��o algum item retornar com algum erro a mensagem � informada na tag de erro principal com isso
        //sempre terei que verificar o XML inteiro para analisar se o erro � do produto ou da autoriza��o completa.
        //if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);

          NodeSec := NodePri.ChildNodes['produtos'];
          NodeSec.ChildNodes.First;
          NodeTer := NodeSec.ChildNodes['produto'];
          NodeTer.ChildNodes.First; //Possicionar no Primeiro Produto
          repeat
            //Adiciona Produtos na lista
            Produto := TProduto.Create;
            Produto.CODIGO              := NodeTer.ChildNodes['codigo'].Text;//C�digo do produto (interno do operador)
            Produto.EAN                 := NodeTer.ChildNodes['ean'].Text;//C�digo EAN do produtoK
            Produto.PRECO_BRUTO         := StrToCurrDef(NodeTer.ChildNodes['prc_bruto'].Text,0)/100;//Valor bruto
            Produto.PRECO_LIQUIDO       := StrToCurrDef(NodeTer.ChildNodes['prc_liquido'].Text,0)/100;//Valor l�quido
            Produto.PRECO_RECEBER       := StrToCurrDef(NodeTer.ChildNodes['prc_receber'].Text,0)/100;//Valor a receber
            Produto.PERCENTUAL_DESCONTO := StrToFloatDef(NodeTer.ChildNodes['desconto'].Text,0)/100;//Desconto � conceder
            Produto.STATUS_PRODUTO      := StrToIntDef(NodeTer.ChildNodes['status_prod'].Text,0);//Status do produto
            Produto.MENSAGEM_PRODUTO    := NodeTer.ChildNodes['mens_prod'].Text;//Mensagem
            Produto.QUANTIDADE_APROVADA := StrToFloatDef(NodeTer.ChildNodes['qtdade'].Text,0);//Quantidade aprovada
            fListadeProduto.Add(Produto);

            NodeTer := NodeTer.NextSibling;//Pular para o Proximo Registro
          until (NodeTer=nil);

          //Gravar Dados para o Envio
          if (fListadeProduto.Count>0) then begin
            for I := 0 to fListadeProduto.Count - 1 do begin
              Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRODUTO+FormatFloat('000',I),
                                           fListadeProduto[I].CODIGO         + ';' +
                                           fListadeProduto[I].EAN            + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_BRUTO)           + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_LIQUIDO)         + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_RECEBER)         + ';' +
                                           FormatFloat('######0.00',fListadeProduto[I].PERCENTUAL_DESCONTO)  + ';' +
                                           FormatFloat('#########0',fListadeProduto[I].QUANTIDADE_APROVADA)  + ';' +
                                           fListadeProduto[I].MENSAGEM_PRODUTO                               + ';' +
                                           IntToStr(fListadeProduto[I].STATUS_PRODUTO));
              if (fListadeProduto[I].STATUS_PRODUTO=0) then begin
                STATUS     := 0;
                INSTRUCOES := '';
              end;
            end;
            INSTRUCOES := INSTRUCOES + IIF(Length(INSTRUCOES)>0,' - ','') + 'Efetiva��o da Transa��o Realizada com Sucesso.';
          end;

          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

        //end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Efetiva��o de Transa��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    fListadeProduto.Clear;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Eleg_Portador;//Executa Fun��o de Egebilidade do Portador para Gera��o da NSU da Transa��o
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Egibilidade do Portador');
      RETORNO_WEBSERVICE := Concentrador.WS_Eleg_Portador(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, CANAL);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Egibilidade do Portador');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['modalidade'].Text;//Modalidade do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_MODALIDADEPROJETO, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['empresa'].Text;//Nome da empresa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NOMECREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);
          DATA  := NodePri.ChildNodes['exige_crm'].Text;//Exige captura de C.R.M.?   (03)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_EXIGE_CRM, DATA);
          INSTRUCOES := INSTRUCOES + 'Egibilidade do Portador Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Egibilidade do Portador: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Fech_Cancel;//Executa o Cancelamento da Autoriza��o j� Finalizada e Obtem Comprovante de Cancelamento
var LINHACUPOM:TLinhaCupom;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  fCupom := TCupom.Create;
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Fechamento de Cancelamento');
      RETORNO_WEBSERVICE := Concentrador.WS_Fech_Cancel(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno do Fechamento de Cancelamento');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);
          DATA  := NodePri.ChildNodes['autorizacao'].Text;//Autoriza��o
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_AUTORIZACAO, DATA);

          //Pegar Linhas a Serem Impressas no Comprovante
          NodeSec := NodePri.ChildNodes['linhas'];
          NodeSec.ChildNodes.First;//Possicionar na Primeira Linha do Comprovante
          for I := 0 to NodeSec.ChildNodes.Count -1 do begin
            LINHACUPOM := TLinhaCupom.Create;
            LINHACUPOM.LINHA := NodeSec.ChildNodes.Nodes[I].Text;
            fCupom.Add(LINHACUPOM);
          end;

          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TOTALLINHACUPOM, IntToStr(fCupom.Count));
          for I := 0 to fCupom.Count - 1 do
            Arquivo.EscreveChaveArquivoEnvio(CHAVE_LINHACUPOM+FormatFloat('000',I), fCupom[I].LINHA);

          INSTRUCOES := INSTRUCOES + 'Fechamento de Cancelamento Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Fechamento de Cancelamento: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    fCupom.Clear;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Fech_Transac;//Executa Fun��o de Fechamento da Transa��o e Obten��o do Comprovate a Ser Impresso
var LINHACUPOM:TLinhaCupom;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  fCupom := TCupom.Create;
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Fechamento da Transa��o');
      RETORNO_WEBSERVICE := Concentrador.WS_Fech_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, NUMERO_CUPOM, DADOSCOMPLEMENTARES);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno do Fechamento da Transa��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);
          DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_bruto'].Text,0)/100);//Valor bruto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECOBRUTO, DATA);
          DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_liquido'].Text,0)/100);//Valor l�quido
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECOLIQUIDO, DATA);
          DATA  := FormatFloat('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_desconto'].Text,0)/100);//Valor Desconto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_PERCENTUALDESCONTO, DATA);
          DATA  := FormatCurr('######0.00',StrToCurrDef(NodePri.ChildNodes['prc_receber'].Text,0)/100);//Valor receber
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRECORECEBER, DATA);
          DATA  := NodePri.ChildNodes['autorizacao'].Text;//Autoriza��o
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_AUTORIZACAO, DATA);

          //Pegar Linhas a Serem Impressas no Comprovante
          NodeSec := NodePri.ChildNodes['linhas'];
          NodeSec.ChildNodes.First;//Possicionar na Primeira Linha do Comprovante
          for I := 0 to NodeSec.ChildNodes.Count -1 do begin
            LINHACUPOM := TLinhaCupom.Create;
            LINHACUPOM.LINHA := NodeSec.ChildNodes.Nodes[I].Text;
            fCupom.Add(LINHACUPOM);
          end;


          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TOTALLINHACUPOM, IntToStr(fCupom.Count));
          for I := 0 to fCupom.Count - 1 do
            Arquivo.EscreveChaveArquivoEnvio(CHAVE_LINHACUPOM+FormatFloat('000',I), fCupom[I].LINHA);

          INSTRUCOES := INSTRUCOES + 'Fechamento da Transa��o Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Fechamento da Transa��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    fCupom.Clear;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Conf_Cancel;//Executa Confirma��o do Cancelamento
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Confirma��o de Cancelamento');
      RETORNO_WEBSERVICE := Concentrador.WS_Conf_Cancel(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Confirma��o de Cancelamento');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM,IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO,FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO,DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU,DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER,DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA,DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR,DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA,DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL,DATA);

          INSTRUCOES := INSTRUCOES + 'Confirma��o de Cancelamento Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS,IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES,INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Confirma��o de Cancelamento: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Conf_Transac;//Executa Fun��o de Confirma��o da Transa��o NSU
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Confirma��o da Transa��o');
      RETORNO_WEBSERVICE := Concentrador.WS_Conf_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Confirma��o de Transa��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

          INSTRUCOES := INSTRUCOES + 'Confirma��o da Transa��o Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Confirma��o da Transa��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;


procedure TF_PrincipalPharmaSystem.WS_Cons_Produto;//Metodo para Consulta de Produto na Autoriza��o
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Consulta de Produto na Autoriza��o');
      RETORNO_WEBSERVICE := Concentrador.WS_Cons_Produto(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU, EAN);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Consulta de Produto na Autoriza��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);

          NodeSec := NodePri.ChildNodes['produto'];
          NodeSec.ChildNodes.First;
          DATA  := NodeSec.ChildNodes['ean'].Text+';'+
                   FormatCurr('######0.00',StrToCurrDef(NodeSec.ChildNodes['prc_bruto'].Text,0))+';'+
                   NodeSec.ChildNodes['descricao'].Text+';'+
                   NodeSec.ChildNodes['mensagem'].Text+';'+
                   NodeSec.ChildNodes['status_prod'].Text;
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRODUTO+'000', DATA);

          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

          INSTRUCOES := 'Consulta de Produto na Autoriza��o Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Consulta de Produto na Autoriza��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Cons_Transac;//Medodo Para Consulta da Transa��o
var Produto:TProduto;
    I:Integer;
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Consulta da Autoriza��o');
      RETORNO_WEBSERVICE := Concentrador.WS_Cons_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Consulta da Autoriza��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);

          fListadeProduto := TListadeProduto.Create();

          NodeSec := NodePri.ChildNodes['produtos'];
          NodeSec.ChildNodes.First;
          NodeTer := NodeSec.ChildNodes['produto'];
          NodeTer.ChildNodes.First; //Possicionar no Primeiro Produto
          repeat
            //Adiciona Produtos na lista
            Produto := TProduto.Create;
            Produto.CODIGO              := NodeTer.ChildNodes['codigo'].Text;//C�digo do produto (interno do operador)
            Produto.EAN                 := NodeTer.ChildNodes['ean'].Text;//C�digo EAN do produtoK
            Produto.PRECO_BRUTO         := StrToCurrDef(NodeTer.ChildNodes['prc_bruto'].Text,0)/100;//Valor bruto
            Produto.PRECO_LIQUIDO       := StrToCurrDef(NodeTer.ChildNodes['prc_liquido'].Text,0)/100;//Valor l�quido
            Produto.PRECO_RECEBER       := StrToCurrDef(NodeTer.ChildNodes['prc_receber'].Text,0)/100;//Valor a receber
            Produto.PERCENTUAL_DESCONTO := StrToFloatDef(NodeTer.ChildNodes['desconto'].Text,0)/100;//Desconto � conceder
            Produto.STATUS_PRODUTO      := StrToIntDef(NodeTer.ChildNodes['status_prod'].Text,0);//Status do produto
            Produto.MENSAGEM_PRODUTO    := NodeTer.ChildNodes['mens_prod'].Text;//Mensagem
            Produto.QUANTIDADE_APROVADA := StrToFloatDef(NodeTer.ChildNodes['qtdade'].Text,0);//Quantidade aprovada
            fListadeProduto.Add(Produto);

            NodeTer := NodeTer.NextSibling;//Pular para o Proximo Registro
          until (NodeTer=nil);

          //Gravar Dados para o Envio
          if (fListadeProduto.Count>0) then begin
            for I := 0 to fListadeProduto.Count - 1 do begin
              Arquivo.EscreveChaveArquivoEnvio(CHAVE_PRODUTO+FormatFloat('000',I),
                                           fListadeProduto[I].CODIGO         + ';' +
                                           fListadeProduto[I].EAN            + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_BRUTO)           + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_LIQUIDO)         + ';' +
                                           FormatCurr('######0.00',fListadeProduto[I].PRECO_RECEBER)         + ';' +
                                           FormatFloat('######0.00',fListadeProduto[I].PERCENTUAL_DESCONTO)  + ';' +
                                           FormatFloat('#########0',fListadeProduto[I].QUANTIDADE_APROVADA)  + ';' +
                                           fListadeProduto[I].MENSAGEM_PRODUTO                               + ';' +
                                           IntToStr(fListadeProduto[I].STATUS_PRODUTO));
              if (fListadeProduto[I].STATUS_PRODUTO=0) then begin
                STATUS     := 0;
                INSTRUCOES := '';
              end;
            end;
            INSTRUCOES := INSTRUCOES + IIF(Length(INSTRUCOES)>0,' - ','') + 'Consulta da Autoriza��o Realizada com Sucesso.';
          end;

          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['empresa'].Text;//Nome da empresa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NOMECREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);
          DATA  := NodePri.ChildNodes['nome'].Text;//Nome Paciente
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NOMEPACIENTE, DATA);
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Consulta da Autoriza��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Anul_Cancel;//Executa Anula��o do Cancelamento
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Anula��o de Cancelamento');
      RETORNO_WEBSERVICE := Concentrador.WS_Anul_Cancel(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Anula��o de Cancelamento');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

          INSTRUCOES := INSTRUCOES + 'Anula��o de Cancelamento Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Anula��o de Cancelamento: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

procedure TF_PrincipalPharmaSystem.WS_Anul_Transac;//Executa Analua��o da Transa��o NSU
begin
  XMLDoc := TXMLDocument.Create(Self);// Cria a vari�vel baseada no TXMLDocument
  try
    try
      SetConexao;//Setar Conex�o do Web-Service
      MessagemStatus('Realizando Anula��o de Transa��o');
      RETORNO_WEBSERVICE := Concentrador.WS_Anul_Transac(IDENTIFICA, PROJETO, DATAHORALOCAL, CARTAO, CPF, NSU);
      if (Trim(RETORNO_WEBSERVICE)>'') then begin
        MessagemStatus('Lendo Retorno da Anula��o de Transa��o');
        XMLDoc.LoadFromXML(RETORNO_WEBSERVICE);// Le conte�do do retorno
        XMLDoc.Active := True;
        //Pegar Dados do XML de Retorno
        NodePri := XMLDoc.ChildNodes.FindNode('retorno');
        NodePri.ChildNodes.First;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM, IntToStr(ID_MENSAGEM));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',NUMERO_OPERACAO));

        STATUS     := StrToIntDef(NodePri.ChildNodes['status'].Text,0);//Status da Transa��o
        try
          INSTRUCOES := NodePri.ChildNodes['instrucoes'].Text;//Intru��es para o Operador
        except end;
        if (STATUS=0) then begin
          DATA  := NodePri.ChildNodes['projeto'].Text;//C�digo do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOPROJETO, DATA);
          DATA  := NodePri.ChildNodes['nsu_host'].Text;//Identifica��o da transa��o (01)
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMERONSU, DATA);
          DATA  := NodePri.ChildNodes['header'].Text;//Retorno m�todo
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_HEADER, DATA);
          DATA  := NodePri.ChildNodes['operadora'].Text;//Operadora do programa
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_OPERADORADOPROGRAMA, DATA);
          DATA  := NodePri.ChildNodes['timestamp'].Text;//Timestamp do servidor do projeto
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_TIMESTAMPSERVIDOR, DATA);
          DATA  := NodePri.ChildNodes['cnpj'].Text;//C.N.P.J. da credenciada
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_CNPJCREDENCIADA, DATA);
          DATA  := NodePri.ChildNodes['terminal'].Text;//C�digo do terminal
          Arquivo.EscreveChaveArquivoEnvio(CHAVE_NUMEROTERMINAL, DATA);

          INSTRUCOES := INSTRUCOES + 'Anula��o da Transa��o Realizada com Sucesso.';
        end;

        Arquivo.EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS, IntToStr(STATUS));
        Arquivo.EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES, INSTRUCOES);
      end;
    except
      on E:Exception do begin
        raise Exception.Create('Erro ao Realizar Anula��o de Transa��o: '+E.Message);
        Exit;
      end;
    end;
  finally
    XMLDoc.Free;
    CloseConexao;//Finalizar Conex�o do Web-Service
  end;
end;

end.
