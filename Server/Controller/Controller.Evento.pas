unit Controller.Evento;

interface

uses
  System.SysUtils, System.StrUtils, MVCFramework.Logger, MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerEvento = class(TMVCController) 
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public

    [MVCPath('/evento')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEventos;

    [MVCPath('/evento/($CO_Evento)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEvento(CO_Evento: Integer);

    [MVCPath('/evento')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddEvento;

    [MVCPath('/evento/($CO_Evento)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateEvento(CO_Evento: Integer);

    [MVCPath('/evento/($CO_Evento)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteEvento(CO_Evento: Integer);

  end;

implementation

uses
  Model.Evento;

procedure TControllerEvento.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerEvento.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerEvento.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TControllerEvento.GetEventos;
begin
   Render<TEvento>(TEvento.GetAll);
end;

procedure TControllerEvento.GetEvento(CO_Evento: Integer);
begin
   Render(TEvento.GetByID(CO_Evento));
end;

procedure TControllerEvento.AddEvento;
var
   AEvento : TEvento;
begin

   AEvento := Context.Request.BodyAs<TEvento>;

   try

      if TEvento.Add(AEvento) then begin
         Render(201, 'Evento adicionado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEvento.Free;
   end;

end;

procedure TControllerEvento.UpdateEvento(CO_Evento: Integer);
var
   AEvento : TEvento;
begin

   AEvento := Context.Request.BodyAs<TEvento>;

   try

      AEvento.co_membro := CO_Evento;

      if TEvento.Add(AEvento) then begin
         Render(200, 'Evento atualizado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEvento.Free;
   end;

end;

procedure TControllerEvento.DeleteEvento(CO_Evento: Integer);
begin

   if TEvento.Delete(CO_Evento) then begin
      Render(200, 'Evento exluido com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
