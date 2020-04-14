unit U_Funcoes;

interface

uses SysUtils;

procedure DeleteArquivos(Diretorio:String;Extencao:String);
function VerificaArquivo(Diretorio:AnsiString):AnsiString;
function IIF(Condicao:Boolean; ResultTrue:String; ResultFalse:String):String;

const
    //Chaves Primarias das Operações
    CHAVE_IDMENSAGEM          : AnsiString = '000-000';
    CHAVE_NUMEROOPERACAO      : AnsiString = '001-000';
    CHAVE_CODIGOPROJETO       : AnsiString = '002-000';
    CHAVE_NUMEROCARTAO        : AnsiString = '003-000';
    CHAVE_NUMEROCPF           : AnsiString = '004-000';
    CHAVE_NUMERONSU           : AnsiString = '005-000';
    CHAVE_PRODUTO             : AnsiString = '006-';//Pode Haver Multiplos por Isso a Não Especificação da Chave do 2 Campo
    CHAVE_DOCUMENTOFISCAL     : AnsiString = '007-000';
    CHAVE_DADOSCOMPLEMENTARES : AnsiString = '008-000';
    CHAVE_NSUFARMACIA         : AnsiString = '009-000';
    CHAVE_EAN                 : AnsiString = '010-000';

    CHAVE_ : AnsiString = '000-000';

    //Chaves para Retorno Apenas
    CHAVE_TOTALPROJETO        : AnsiString = '011-000';//Quantidade Total de Projetos
    CHAVE_DADOSPROEJTO        : AnsiString = '012-';//Dados dos Projetos - Pode Haver Multiplos por Isso a Não Especificação da Chave do 2 Campo
    CHAVE_HEADER              : AnsiString = '013-000';
    CHAVE_OPERADORADOPROGRAMA : AnsiString = '014-000';
    CHAVE_MODALIDADEPROJETO   : AnsiString = '015-000';
    CHAVE_TIMESTAMPSERVIDOR   : AnsiString = '016-000';
    CHAVE_CNPJCREDENCIADA     : AnsiString = '017-000';
    CHAVE_NOMECREDENCIADA     : AnsiString = '018-000';
    CHAVE_NUMEROTERMINAL      : AnsiString = '019-000';
    CHAVE_EXIGE_CRM           : AnsiString = '020-000';
    CHAVE_PRECOBRUTO          : AnsiString = '021-000';
    CHAVE_PRECOLIQUIDO        : AnsiString = '022-000';
    CHAVE_PERCENTUALDESCONTO  : AnsiString = '023-000';
    CHAVE_PRECORECEBER        : AnsiString = '024-000';
    CHAVE_AUTORIZACAO         : AnsiString = '025-000';
    CHAVE_NOMEPACIENTE        : AnsiString = '026-000';

    CHAVE_TOTALLINHACUPOM     : AnsiString = '040-000';//Quantidade Total de LINHA CUPOM
    CHAVE_LINHACUPOM          : AnsiString = '041-';//Pode Haver Multiplos por Isso a Não Especificação da Chave do 2 Campo

    //Chave Status
    CHAVE_CODIGOSTATUS        : AnsiString = '099-000';
    CHAVE_INSTRUCOES          : AnsiString = '099-001';
    //Chave para Final do Arquivo
    CHAVE_FINALARQUIVO        : AnsiString = '999-000';

implementation

procedure DeleteArquivos(Diretorio:String;Extencao:String);
var I:Integer;
    SR: TSearchRec;
begin
  if (Extencao='*') then Exit;
  if (Diretorio='C') or (Diretorio='c') or (Diretorio='D') or (Diretorio='D') then
    Diretorio := UpperCase(Diretorio)+':';
  if Copy(Diretorio,Length(Diretorio)-1,1)='\' then
    Diretorio := Copy(Diretorio,0,Length(Diretorio)-1);
  I := FindFirst(Diretorio+'\*.'+Extencao, faAnyFile, SR);
  while I = 0 do begin
    DeleteFile(Diretorio+'\'+SR.Name);
    I := FindNext(SR);
  end;
end;

function VerificaArquivo(Diretorio:AnsiString):AnsiString;
var I:Integer;
    SR: TSearchRec;
begin
  Result := '';
  I := FindFirst(Diretorio+'\*.001', faAnyFile, SR);
  while I = 0 do begin
    Result := SR.Name;
    if Result='' then
      I := FindNext(SR)
    else
      I := 1;
  end;
end;

function IIF(Condicao:Boolean; ResultTrue:String; ResultFalse:String):String;
begin
  if Condicao then
    Result := ResultTrue
  else
    Result := ResultFalse;
end;

end.
