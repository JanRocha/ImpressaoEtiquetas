unit UFuncoes;

interface

uses StrUtils, forms, SysUtils, classes, uLkJSON, IniFiles, rtti, TypInfo,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc;

type
  TMethod = (POST, GET, PUT);

  TFuncoes = class
  private
    FidHTTP: TIdHTTP;
    FParams: TStringStream;
    FRetorno: TStringStream;
    FMethod: TMethod;
    FEndPoint: string;
    FServico: string;
    FBearer: WideString;
    Fini: TIniFile;
    procedure Cabecalho();
  public
    function preparaString(value: string; aLimExt: boolean): string;
    function BuscarEmpresaWS(value: string): TlkJSONobject;
    function Consumir(): string;
    function CarregarEmpresas(): TStringList;
    function XMLToClass(retorno: TObject; XML: TXMLDocument): TObject;
    function SerializarJsonObjeto(JSON: string; obj: TObject): TObject;
    function SerializarINI(Arquivo, chave: string; obj: TObject): TObject;
    function GravarINI(Arquivo, chave: string; obj: TObject): TObject;
    procedure GravarLog(msg: string);
    Function Converte( cmd : String) : String;
    destructor Destroy; override;
  end;

implementation

{ TFuncoes }

function TFuncoes.BuscarEmpresaWS(value: string): TlkJSONobject;
var
  s: string;
begin
  Cabecalho();
  FEndPoint := 'https://www.receitaws.com.br/v1/cnpj/';
  FServico := value;
  FMethod := GET;
  s := Consumir();
  Result := TlkJSON.ParseText(s) as TlkJSONobject;
end;

procedure TFuncoes.Cabecalho;
begin
  FidHTTP := TIdHTTP.Create(nil);
  // FHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FParams := TStringStream.Create;
  FRetorno := TStringStream.Create;
  FBearer := '';
  FEndPoint := '';
  FServico := '';
end;

function TFuncoes.CarregarEmpresas: TStringList;
begin
  Result := TStringList.Create;
  Fini := TIniFile.Create(GetCurrentDir + '\Config\Config.ini');
  Result.Delimiter := ';';
  Result.DelimitedText := Fini.ReadString('EMPRESAS', 'CNPJ', '');
end;

function TFuncoes.Consumir: string;
begin
  Result := '';
  FRetorno.Clear;
  try
    case FMethod of
      POST:
        begin
          FidHTTP.POST(FEndPoint + FServico, FParams, FRetorno);
          Result := FRetorno.DataString;
        end;
      GET:
        begin
          FidHTTP.GET(FEndPoint + FServico, FRetorno);
          Result := FRetorno.DataString;
        end;
      PUT:
        begin
          FidHTTP.PUT(FEndPoint + FServico, FRetorno);
          Result := FRetorno.DataString;
        end;
    end;

  except
    on E: Exception do
    begin
      //
    end;
    // Application.MessageBox(PwideChar(E.Message),          'Erro nese cassete p0o00rra');
  end;

end;

function TFuncoes.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (cmd[A] in ['A'..'Z','a'..'z','0'..'9',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','-','_',')','(','*','&','^','%','$',
                        '#','@','!','~' ]) then
        Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
     else
        Result := Result + cmd[A] + ' ';
  end ;

end;

destructor TFuncoes.Destroy;
begin
  FidHTTP.Free;
  // FHandler.Free;
  FParams.Free;
  FRetorno.Free;
  inherited;
end;

procedure TFuncoes.GravarLog(msg: string);
var
  arq: TextFile;
  s, nome: string;
  i: integer;
begin
  nome := ExtractFileName(Application.ExeName);
  nome := ChangeFileExt(nome, '');
  i := Length(nome);
  nome := Copy(nome, 0, i - 4);
  nome := FormatDateTime('yyyy-mm-dd', now) + nome;
  try
    s := GetCurrentDir + '\' + FormatDateTime('dd-mm-yyy', now) + '.LOG';
    AssignFile(arq, s);
    if FileExists(s) then
    begin
      Append(arq);
    end
    else
    begin
      Rewrite(arq);
    end;
    Writeln(arq, FormatDateTime('yyyy-dd-mm hh:mm:ss', now) + ' - ' + msg);
    CloseFile(arq);
  finally

  end;
end;

function TFuncoes.preparaString(value: string; aLimExt: boolean): string;
const
  // Lista de caracteres especiais
  xCarEsp: array [1 .. 38] of String = ('�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�');
  // Lista de caracteres para troca
  xCarTro: array [1 .. 38] of String = ('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A',
    'A', 'A', 'e', 'e', 'E', 'E', 'i', 'i', 'I', 'I', 'o', 'o', 'o', 'o', 'o',
    'O', 'O', 'O', 'O', 'O', 'u', 'u', 'u', 'u', 'u', 'u', 'c', 'C', 'n', 'N');
  // Lista de Caracteres Extras
  xCarExt: array [1 .. 51] of string = ('<', '>', '!', '@', '#', '$', '%', '�',
    '&', '*', '(', ')', '_', '+', '=', '{', '}', '[', ']', '?', ';', ':', ',',
    '|', '*', '"', '~', '^', '�', '`', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '/', '.', '-');
var
  xTexto: string;
  i: integer;
begin
  xTexto := value;
  for i := 1 to 38 do
    xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
  // De acordo com o par�metro aLimExt, elimina caracteres extras.
  if (aLimExt) then
    for i := 1 to 51 do
      xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
  Result := xTexto;
end;

function TFuncoes.GravarINI(Arquivo, chave: string; obj: TObject): TObject;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedades, Propriedade: TRttiProperty;
begin
  Fini := TIniFile.Create(GetCurrentDir + '\' + Arquivo);
  Tipo := Contexto.GetType(obj.ClassInfo);

  for Propriedades in Tipo.GetProperties do
  begin
    case Propriedades.PropertyType.TypeKind of
      tkInteger:
        Fini.WriteInteger(chave, Propriedades.Name, Propriedades.GetValue(obj)
            .AsInteger);
      tkUString, tkLString, tkString, tkWString:
        Fini.WriteString(chave, Propriedades.Name, Propriedades.GetValue(obj)
            .AsString);
      tkEnumeration:
        Fini.WriteBool(chave, Propriedades.Name, Propriedades.GetValue(obj)
            .AsBoolean);
      tkFloat:
        Fini.WriteFloat(chave, Propriedades.Name, Propriedades.GetValue(obj)
            .AsExtended);
    end;
  end;
  Result := obj;
end;

function TFuncoes.SerializarINI(Arquivo, chave: string; obj: TObject): TObject;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
begin
  if not(FileExists(Arquivo)) then
    exit;
  Fini := TIniFile.Create(getcurrentdir+'\'+ Arquivo);
  Tipo := Contexto.GetType(obj.ClassInfo);
  for Propriedade in Tipo.GetProperties do
  begin
    case Propriedade.PropertyType.TypeKind of
      tkInteger:
        Propriedade.SetValue(obj, Fini.ReadInteger(chave, Propriedade.Name, 0));
      tkUString, tkLString, tkString, tkWString:
        Propriedade.SetValue(obj, Fini.ReadString(chave, Propriedade.Name, ''));
      tkEnumeration:
        Propriedade.SetValue(obj, Fini.ReadBool(chave, Propriedade.Name, False)
          );
      tkFloat:
        Propriedade.SetValue(obj, Fini.ReadFloat(chave, Propriedade.Name, 0));
    end;
  end;
  Result:= obj;
end;

function TFuncoes.SerializarJsonObjeto(JSON: string; obj: TObject): TObject;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  oJS: TlkJSONbase;
begin
  oJS := TlkJSON.ParseText(JSON) as TlkJSONbase;
  // if  oJS.SelfType = jsList then
  Tipo := Contexto.GetType(obj.ClassInfo);

  for Propriedade in Tipo.GetProperties do
  begin

    case Propriedade.PropertyType.TypeKind of
      tkInteger:
        Propriedade.SetValue(obj, '');
      tkUString, tkLString, tkString, tkWString:
        Propriedade.SetValue(obj, '');
      tkEnumeration:
        Propriedade.SetValue(obj, '');
      tkFloat:
        Propriedade.SetValue(obj, '');
    end;
  end;
end;

function TFuncoes.XMLToClass(retorno: TObject; XML: TXMLDocument): TObject;
begin

  Result := retorno;
end;

end.
