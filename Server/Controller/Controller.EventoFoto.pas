unit Controller.EventoFoto;

interface

uses
  System.SysUtils, System.StrUtils, System.Generics.Collections, MVCFramework.Logger,
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerEventoFoto = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/eventofoto')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEventoFotos;

    [MVCPath('/eventofoto/($CO_Evento_Foto)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEventoFoto(CO_Evento_Foto: Integer);

    [MVCPath('/eventofoto/inserir')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddEventoFoto;

    [MVCPath('/eventofoto/($CO_Evento_Foto)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateEventoFoto(CO_Evento_Foto: Integer);

    [MVCPath('/eventofoto/($CO_Evento_Foto)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteEventoFoto(CO_Evento_Foto: Integer);

  end;

implementation

uses
  Model.EventoFoto;

procedure TControllerEventoFoto.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerEventoFoto.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerEventoFoto.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TControllerEventoFoto.GetEventoFotos;
begin
   Render<TEventoFoto>(TEventoFoto.GetAll);
end;

procedure TControllerEventoFoto.GetEventoFoto(CO_Evento_Foto: Integer);
begin
  Render(TEventoFoto.GetByID(CO_Evento_Foto));
end;

procedure TControllerEventoFoto.AddEventoFoto;
var
   AEventoFoto : TObjectList<TEventoFoto>;
begin

   AEventoFoto := Context.Request.BodyAsListOf<TEventoFoto>;

   try

      if TEventoFoto.Add(AEventoFoto) then begin
         Render(201, 'Foto adicionada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEventoFoto.Free;
   end;

end;

procedure TControllerEventoFoto.UpdateEventoFoto(CO_Evento_Foto: Integer);
var
   AEventoFoto : TEventoFoto;
begin

   AEventoFoto := Context.Request.BodyAs<TEventoFoto>;

   try

      AEventoFoto.co_evento_foto := CO_Evento_Foto;

      if TEventoFoto.Update(AEventoFoto) then begin
         Render(200, 'Foto atualizada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEventoFoto.Free;
   end;

end;

procedure TControllerEventoFoto.DeleteEventoFoto(CO_Evento_Foto: Integer);
begin

   if TEventoFoto.Delete(CO_Evento_Foto) then begin
      Render(200, 'Foto exluida com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
