unit WebModuleBike;

interface

uses System.SysUtils,
     System.Classes,
     Web.HTTPApp,
     MVCFramework;

type
  TWebModuleGeral = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModuleGeral;

implementation

{$R *.dfm}

uses
   System.IOUtils,
   MVCFramework.Commons, MVCFramework.Middleware.Compression,
   Controller.Grupo, Controller.Membro, Controller.MembroBike,
   Controller.Evento, Controller.EventoFoto, Controller.EventoParticipante,
   Controller.Marca;

procedure TWebModuleGeral.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      //enable static files
      Config[TMVCConfigKey.DocumentRoot] := TPath.Combine(ExtractFilePath(GetModuleName(HInstance)), 'www');
      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout] := '0';
      //default content-type
      Config[TMVCConfigKey.DefaultContentType] := TMVCConstants.DEFAULT_CONTENT_TYPE;
      //default content charset
      Config[TMVCConfigKey.DefaultContentCharset] := TMVCConstants.DEFAULT_CONTENT_CHARSET;
      //unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction] := 'false';
      //default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := 'html';
      //view path
      Config[TMVCConfigKey.ViewPath] := 'templates';
      //Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount] := '20';
      //Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature] := 'true';
      // Define a default URL for requests that don't map to a route or a file (useful for client side web app)
      Config[TMVCConfigKey.FallbackResource] := 'index.html';
      // Max request size in bytes
      Config[TMVCConfigKey.MaxRequestSize] := IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);
    end);
  FMVC.AddController(TControllerGrupo);
  FMVC.AddController(TControllerMembro);
  FMVC.AddController(TControllerMembroBike);
  FMVC.AddController(TControllerEvento);
  FMVC.AddController(TControllerEventoPariticipante);
  FMVC.AddController(TControllerEventoFoto);
  FMVC.AddController(TControllerMarca);
  // To enable compression (deflate, gzip) just add this middleware as the last one 
  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);
end;

procedure TWebModuleGeral.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.