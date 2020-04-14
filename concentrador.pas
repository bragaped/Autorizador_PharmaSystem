// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.conectapdv.com.br/concentrador/concentrador.asmx?wsdl
//  >Import : http://www.conectapdv.com.br/concentrador/concentrador.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (08/11/2011 20:38:18 - - $Rev: 25127 $)
// ************************************************************************ //

unit concentrador;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ConcentradorSoap12
  // service   : Concentrador
  // port      : ConcentradorSoap12
  // URL       : http://www.conectapdv.com.br/concentrador/concentrador.asmx
  // ************************************************************************ //
  ConcentradorSoap = interface(IInvokable)
  ['{E336EC41-A6C7-9DB9-CD6B-2BB883D04778}']
    function  WS_Efet_Transac(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer; 
                              const cDadosProd: string): string; stdcall;
    function  WS_Fech_Transac(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer; 
                              const nDocFiscal: Integer; const cDadosComplemen: string): string; stdcall;
    function  WS_Efet_Transac2(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer; 
                               const cDadosProd: string; const cDadosComplemen: string): string; stdcall;
    function  WS_Cons_Transac(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Conf_Transac(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Cons_Produto(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer; 
                              const cEAN: string): string; stdcall;
    function  WS_Anul_Transac(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Efet_Cancel(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer; 
                             const cDadosProd: string): string; stdcall;
    function  WS_Fech_Cancel(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Fech_CancelX25(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer;
                                const nNSU_farmacia: Integer): string; stdcall;
    function  WS_Conf_Cancel(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Anul_Cancel(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const nNSU_host: Integer): string; stdcall;
    function  WS_Exec_Layout(const cLayout: string; const cCanal: string): string; stdcall;
    function  WS_Busc_Projetos(const cIdentifica: string): string; stdcall;
    function  WS_Eleg_Portador(const cIdentifica: string; const cProjeto: string; const cTimestamp: string; const cCartao: string; const nCPF: Int64; const cCanal: string): string; stdcall;
    function  WS_Sonda(const Autenticador: string; const CNPJ: string): string; stdcall;
  end;

function GetConcentradorSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ConcentradorSoap;


implementation
  uses SysUtils;

function GetConcentradorSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ConcentradorSoap;
const
  defWSDL = 'http://www.conectapdv.com.br/concentrador/concentrador.asmx?wsdl';
  defURL  = 'http://www.conectapdv.com.br/concentrador/concentrador.asmx';
  defSvc  = 'Concentrador';
  defPrt  = 'ConcentradorSoap12';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ConcentradorSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(ConcentradorSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ConcentradorSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ConcentradorSoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ConcentradorSoap), ioSOAP12);

end.