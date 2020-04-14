unit U_PharmaSystem;

interface

uses Classes, Contnrs, SysUtils;

type
  TLinhaSolicitacao = Class
  private
    fChave:AnsiString;
    fValor:AnsiString;
  public
    property CHAVE:AnsiString read fChave write fChave;
    property VALOR:AnsiString read fValor write fValor;
  End;

  TListaLinhaSolicitacao = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TLinhaSolicitacao);
    function  GetObject (Index: Integer): TLinhaSolicitacao;
    procedure Insert (Index: Integer; Obj: TLinhaSolicitacao);
  public
    function Add (Obj: TLinhaSolicitacao): Integer;
    property Objects [Index: Integer]: TLinhaSolicitacao read GetObject write SetObject; default;
  end;

  { TArquivo }
  TArquivo = class
  private
    fArquivoRequerimento:TextFile;
    fArquivoEnvio:TextFile;
    fNome:AnsiString;
    fListaLinhaSolicitacao:TListaLinhaSolicitacao;
  public
    constructor Create(NOME_ARQUIVO:AnsiString); overload;
    destructor Destroy; overload;

    procedure CarregaArquivoRequeerimento();
    function LeArquivoLinhaRequeerimento:AnsiString;

    //procedure EscreveArquivoEnvio(Value:AnsiString);
    procedure EscreveChaveArquivoEnvio(Chave:AnsiString; Value:AnsiString);
    procedure FechaArquivoEnvio;

    property NOME:AnsiString read fNome write fNome;
  end;

  { TConvenio }
  TConvenio = class
  private
    fIDCadastro:Integer;
    fIDProjeto:Integer;
    fCodigo:AnsiString;
    fDescricao:AnsiString;
    fEmpresa:AnsiString;
    fModalidade:AnsiString;
  public
    property IDCADASTRO:Integer read fIDCadastro write fIDCadastro;
    property IDPROJETO:Integer read fIDProjeto write fIDProjeto;
    property CODIGO:AnsiString read fCodigo write fCodigo;
    property DESCRICAO:AnsiString read fDescricao write fDescricao;
    property EMPRESA:AnsiString read fEmpresa write fEmpresa;
    property MODALIDADE:AnsiString read fModalidade write fModalidade;
  end;

 { TListadeConvenio }
  TListadeConvenio = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TConvenio);
    function  GetObject (Index: Integer): TConvenio;
    procedure Insert (Index: Integer; Obj: TConvenio);
  public
    function Add (Obj: TConvenio): Integer;
    property Objects [Index: Integer]: TConvenio read GetObject write SetObject; default;
  end;

  { TProduto }
  TProduto = class
  private
    fEAN:AnsiString;
    fCODIGO:AnsiString;
    fDESCRICAO:AnsiString;
    fPRECO_BRUTO:Currency;
    fPRECO_LIQUIDO:Currency;
    fPRECO_RECEBER:Currency;
    fPERCENTUAL_DESCONTO:Double;
    fQUANTIDADE_SOLICITADA:Double;
    fQUANTIDADE_APROVADA:Double;
    fSTATUS_PRODUTO:Integer;
    fMENSAGEM_PRODUTO:AnsiString;
  public
    property EAN:AnsiString read fEAN write fEAN;
    property CODIGO:AnsiString read fCODIGO write fCODIGO;
    property DESCRICAO:AnsiString read fDESCRICAO write fDESCRICAO;
    property PRECO_BRUTO:Currency read fPRECO_BRUTO write fPRECO_BRUTO;
    property PRECO_LIQUIDO:Currency read fPRECO_LIQUIDO write fPRECO_LIQUIDO;
    property PRECO_RECEBER:Currency read fPRECO_RECEBER write fPRECO_RECEBER;
    property PERCENTUAL_DESCONTO:Double read fPERCENTUAL_DESCONTO write fPERCENTUAL_DESCONTO;
    property QUANTIDADE_SOLICITADA:Double read fQUANTIDADE_SOLICITADA write fQUANTIDADE_SOLICITADA;
    property QUANTIDADE_APROVADA:Double read fQUANTIDADE_APROVADA write fQUANTIDADE_APROVADA;
    property STATUS_PRODUTO:Integer read fSTATUS_PRODUTO write fSTATUS_PRODUTO;
    property MENSAGEM_PRODUTO:AnsiString read fMENSAGEM_PRODUTO write fMENSAGEM_PRODUTO;
  end;

  { TListadeProduto }
  TListadeProduto = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TProduto);
    function  GetObject (Index: Integer): TProduto;
    procedure Insert (Index: Integer; Obj: TProduto);
  public
    function Add (Obj: TProduto): Integer;
    property Objects [Index: Integer]: TProduto read GetObject write SetObject; default;
  end;

  { TDadosComplementares }
  TDadosComplementares = class
  private
    fTIPO_PRESCRITOR:Integer;
    fUF_PRESCRITOR:AnsiString;
    fNUMERO_PRESCRITOR:Integer;
    fEMIS_PRESCRICAO:AnsiString;
    fCOMPLEMENTO:AnsiString;
  public
    property TIPO_PRESCRITOR:Integer read fTIPO_PRESCRITOR write fTIPO_PRESCRITOR;
    property UF_PRESCRITOR:AnsiString read fUF_PRESCRITOR write fUF_PRESCRITOR;
    property NUMERO_PRESCRITOR:Integer read fNUMERO_PRESCRITOR write fNUMERO_PRESCRITOR;
    property EMIS_PRESCRICAO:AnsiString read fEMIS_PRESCRICAO write fEMIS_PRESCRICAO;
    property COMPLEMENTO:AnsiString read fCOMPLEMENTO write fCOMPLEMENTO;
  end;

  { TLinhaCupom }
  TLinhaCupom = class
  private
    fLinha:AnsiString;
  public
    property LINHA:AnsiString read fLinha write fLinha;
  end;

  { TCupom }
  TCupom = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TLinhaCupom);
    function  GetObject (Index: Integer): TLinhaCupom;
    procedure Insert (Index: Integer; Obj: TLinhaCupom);
  public
    function Add (Obj: TLinhaCupom): Integer;
    property Objects [Index: Integer]: TLinhaCupom read GetObject write SetObject; default;
  end;


implementation

uses U_PrincipalPharmaSystem, U_Funcoes;

{ TListadeConvenio }

function TListadeConvenio.Add(Obj: TConvenio): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TListadeConvenio.GetObject(Index: Integer): TConvenio;
begin
  Result := inherited GetItem(Index) as TConvenio ;
end;

procedure TListadeConvenio.Insert(Index: Integer; Obj: TConvenio);
begin
  inherited Insert(Index, Obj);
end;

procedure TListadeConvenio.SetObject(Index: Integer; Item: TConvenio);
begin
  inherited SetItem (Index, Item) ;
end;

{ TArquivo }

procedure TArquivo.CarregaArquivoRequeerimento();
var linha:AnsiString;
    LinhaSolicitacao:TLinhaSolicitacao;
    VALOR:String;
    DadosProduto,DadosComplementares:TStringList;
    QtdeLinhasDadosProduto,QtdeLinhasDadosComplementares:Integer;
    Produto:TProduto;
    I:Integer;
    INICIOARQUIVO,FINALARQUIVO:Boolean;
begin
  try
    AssignFile(fArquivoRequerimento,F_PrincipalPharmaSystem.DIRETORIO_REQUERIMENTO+'\'+NOME+'.001');
    Reset(fArquivoRequerimento);
    try
      linha := '';
      while (not(Eof(fArquivoRequerimento)) and (Copy(linha,1,7)<>CHAVE_FINALARQUIVO)) do begin
        linha := LeArquivoLinhaRequeerimento;
        if (Length(linha)>8) then begin
          LinhaSolicitacao := TLinhaSolicitacao.Create;
          LinhaSolicitacao.CHAVE := Copy(linha,1,7);
          LinhaSolicitacao.VALOR := TrimLeft(TrimRight( Copy(linha,Pos('=',linha)+1,Length(linha)) ));
          if (LinhaSolicitacao.CHAVE<>CHAVE_FINALARQUIVO) then
            fListaLinhaSolicitacao.Add(LinhaSolicitacao);
        end;
      end;
    finally
      CloseFile(fArquivoRequerimento);
      //Comentada para Testes Repetitivos
      DeleteFile(F_PrincipalPharmaSystem.DIRETORIO_REQUERIMENTO+'\'+NOME+'.001')
    end;
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Realizar Leitura do Arquivo de Solicitação: '+E.Message);
      Exit;
    end;
  end;
  try
    INICIOARQUIVO := False; FINALARQUIVO := False;
    //Capturar a Identificação da Solicitação e Numero da Operação
    if (fListaLinhaSolicitacao.Count>0) then begin
      for I := 0 to fListaLinhaSolicitacao.Count - 1 do begin
        if not(INICIOARQUIVO) then INICIOARQUIVO := (fListaLinhaSolicitacao[I].CHAVE=CHAVE_IDMENSAGEM);
        if not(FINALARQUIVO) then  FINALARQUIVO  := (fListaLinhaSolicitacao[I].CHAVE=CHAVE_FINALARQUIVO);

        if (INICIOARQUIVO and not(FINALARQUIVO)) then begin
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_IDMENSAGEM) then//ID da Mensagem de Solicitação
            F_PrincipalPharmaSystem.ID_MENSAGEM     := StrToIntDef(fListaLinhaSolicitacao[I].VALOR,0);
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_NUMEROOPERACAO) then//Numero da Operação da Mensagem de Solicitação
            F_PrincipalPharmaSystem.NUMERO_OPERACAO := StrToIntDef(fListaLinhaSolicitacao[I].VALOR,0);

          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_CODIGOPROJETO) then//Identificação do Projeto
            F_PrincipalPharmaSystem.PROJETO := fListaLinhaSolicitacao[I].VALOR;
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_NUMEROCARTAO) then//Identificação do Numero do Cartão
            F_PrincipalPharmaSystem.CARTAO := fListaLinhaSolicitacao[I].VALOR;
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_NUMEROCPF) then//Identificação do CPF
            F_PrincipalPharmaSystem.CPF := StrToInt64Def(fListaLinhaSolicitacao[I].VALOR,0);
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_NUMERONSU) then//Identificação da transação NSU
            F_PrincipalPharmaSystem.NSU := StrToIntDef(fListaLinhaSolicitacao[I].VALOR,0);
          if(fListaLinhaSolicitacao[I].CHAVE=CHAVE_EAN) then//Código EAN para Consulta do Produto
            F_PrincipalPharmaSystem.EAN := fListaLinhaSolicitacao[I].VALOR;

          //Dados dos Produtos
          if (Copy(fListaLinhaSolicitacao[I].CHAVE,1,4)=CHAVE_PRODUTO) then begin
            if (F_PrincipalPharmaSystem.fListadeProduto=nil) then
              F_PrincipalPharmaSystem.fListadeProduto := TListadeProduto.Create();
            if (F_PrincipalPharmaSystem.fListadeProduto.Count<85) then begin//Solicitação Aceita apenas 85 Itens por Mensagem Restrição devido ao Projeto
              DadosProduto := TStringList.Create;
              try
                VALOR := fListaLinhaSolicitacao[I].VALOR;
                QtdeLinhasDadosProduto := ExtractStrings([';'],[' '],PChar(VALOR),DadosProduto);
                if (QtdeLinhasDadosProduto>=6) then begin
                  Produto := TProduto.Create;
                  Produto.CODIGO        := DadosProduto[0];
                  Produto.EAN           := DadosProduto[1];
                  Produto.DESCRICAO     := DadosProduto[2];
                  Produto.PRECO_BRUTO   := StrToCurrDef(DadosProduto[3],0);
                  Produto.PRECO_LIQUIDO := StrToCurrDef(DadosProduto[4],0);
                  Produto.QUANTIDADE_SOLICITADA := StrToFloatDef(DadosProduto[5],0);
                  F_PrincipalPharmaSystem.fListadeProduto.Add(Produto);
                end;
              finally
                DadosProduto.Free;
              end;
            end;
          end;
          //Dados Complementares
          if (fListaLinhaSolicitacao[I].CHAVE=CHAVE_DADOSCOMPLEMENTARES) then begin
            if (F_PrincipalPharmaSystem.fDadosComplementares=nil) then
                F_PrincipalPharmaSystem.fDadosComplementares := TDadosComplementares.Create();
            DadosComplementares := TStringList.Create;
            try
              VALOR := fListaLinhaSolicitacao[I].VALOR+'.';
              QtdeLinhasDadosComplementares := ExtractStrings([';'],[' '],PChar(VALOR),DadosComplementares);
              if (QtdeLinhasDadosComplementares>=5) then begin
                F_PrincipalPharmaSystem.fDadosComplementares.TIPO_PRESCRITOR    := StrToIntDef(DadosComplementares[0],0);
                F_PrincipalPharmaSystem.fDadosComplementares.UF_PRESCRITOR      := DadosComplementares[1];
                F_PrincipalPharmaSystem.fDadosComplementares.NUMERO_PRESCRITOR  := StrToIntDef(DadosComplementares[2],0);
                F_PrincipalPharmaSystem.fDadosComplementares.EMIS_PRESCRICAO    := DadosComplementares[3];
                F_PrincipalPharmaSystem.fDadosComplementares.COMPLEMENTO        := Copy(DadosComplementares[4],1,Length(DadosComplementares[4])-1);
              end;
            finally
              DadosComplementares.Free;
            end;
          end;
        end;
      end;
    end;
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Atribuir Valores da Solicitação: '+E.Message);
      Exit;
    end;
  end;
end;

constructor TArquivo.Create(NOME_ARQUIVO:AnsiString);
begin
  inherited Create;
  NOME := Copy(NOME_ARQUIVO,1,Length(NOME_ARQUIVO)-4);//Pegar apenas Nome do Arquivo sem extenção
  try
    //Apagar Caso Arquivo já exista
    if (FileExists(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.001')) then
      DeleteFile(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.001');
    if (FileExists(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.STS')) then
      DeleteFile(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.STS');
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao deletar Arquivos de Retorno da Pasta de Destino: '+E.Message);
      Exit;
    end;
  end;

  try
    //Gravar Arquivo Temporario para
    AssignFile(fArquivoEnvio,F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.STS');
    Rewrite(fArquivoEnvio);
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Realizar Criação do Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
  //Criação da Lista das Linhas de Solicitação
  fListaLinhaSolicitacao := TListaLinhaSolicitacao.Create;
end;

destructor TArquivo.Destroy;
begin
  fListaLinhaSolicitacao.Free;
  inherited;
end;
{
procedure TArquivo.EscreveArquivoEnvio(Value: AnsiString);
begin
  try
    Writeln(fArquivoEnvio,Value);//Escrever Retorno
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Escrever no Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
end;
}
procedure TArquivo.EscreveChaveArquivoEnvio(Chave:AnsiString; Value:AnsiString);
begin
  try
    Writeln(fArquivoEnvio,Chave + ' = ' + Value);//Escrever Retorno
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Escrever no Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
end;

procedure TArquivo.FechaArquivoEnvio;
var Linha,LinhaResult:AnsiString;
begin
  try
    //Verificar se Existe foi foi gerado algum retorno se não foi retornar mensagem de Erro de Comunicação
    Linha       := '';
    LinhaResult := '';
    Reset(fArquivoEnvio);
    while (not(Eof(fArquivoEnvio))) do begin
      Readln(fArquivoEnvio,Linha);
      if (Trim(Linha)>'') then LinhaResult := Linha;
    end;
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Verificar Conteudo do Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
  try
    Append(fArquivoEnvio);
    if (Trim(LinhaResult)='') then begin
      EscreveChaveArquivoEnvio(CHAVE_IDMENSAGEM,     IntToStr(F_PrincipalPharmaSystem.ID_MENSAGEM));
      EscreveChaveArquivoEnvio(CHAVE_NUMEROOPERACAO, FormatFloat('00000000',F_PrincipalPharmaSystem.NUMERO_OPERACAO));
      EscreveChaveArquivoEnvio(CHAVE_CODIGOSTATUS,   '-1');
      EscreveChaveArquivoEnvio(CHAVE_INSTRUCOES,     'Erro de Comunicação com Web-Service');
    end;

    EscreveChaveArquivoEnvio(CHAVE_FINALARQUIVO, '0');
    Flush(fArquivoEnvio);
    CloseFile(fArquivoEnvio);
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Finalizar Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
  try
    if (FileExists(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.001')) then
      DeleteFile(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.001');
    Sleep(500);
    RenameFile(F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.STS',F_PrincipalPharmaSystem.DIRETORIO_ENVIO+'\'+NOME+'.001');
  except
    on E:Exception do begin
      raise Exception.Create('Erro ao Renomear Arquivo de Retorno: '+E.Message);
      Exit;
    end;
  end;
end;

function TArquivo.LeArquivoLinhaRequeerimento:AnsiString;
begin
  Readln(fArquivoRequerimento,Result);
end;

{ TListaLinhaSolicitacao }

function TListaLinhaSolicitacao.Add(Obj: TLinhaSolicitacao): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TListaLinhaSolicitacao.GetObject(Index: Integer): TLinhaSolicitacao;
begin
  Result := inherited GetItem(Index) as TLinhaSolicitacao ;
end;

procedure TListaLinhaSolicitacao.Insert(Index: Integer; Obj: TLinhaSolicitacao);
begin
  inherited Insert(Index, Obj);
end;

procedure TListaLinhaSolicitacao.SetObject(Index: Integer; Item: TLinhaSolicitacao);
begin
  inherited SetItem (Index, Item) ;
end;

{ TListadeProduto }

function TListadeProduto.Add(Obj: TProduto): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TListadeProduto.GetObject(Index: Integer): TProduto;
begin
  Result := inherited GetItem(Index) as TProduto ;
end;

procedure TListadeProduto.Insert(Index: Integer; Obj: TProduto);
begin
  inherited Insert(Index, Obj);
end;

procedure TListadeProduto.SetObject(Index: Integer; Item: TProduto);
begin
  inherited SetItem (Index, Item) ;
end;

{ TCupom }

function TCupom.Add(Obj: TLinhaCupom): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TCupom.GetObject(Index: Integer): TLinhaCupom;
begin
  Result := inherited GetItem(Index) as TLinhaCupom ;
end;

procedure TCupom.Insert(Index: Integer; Obj: TLinhaCupom);
begin
  inherited Insert(Index, Obj);
end;

procedure TCupom.SetObject(Index: Integer; Item: TLinhaCupom);
begin
  inherited SetItem (Index, Item) ;
end;

end.
