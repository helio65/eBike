unit Controller.EventoParticipante;

interface

uses
  System.SysUtils, System.StrUtils, System.Generics.Collections, MVCFramework.Logger,
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerEventoPariticipante = class(TMVCController) 
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/eventoparticipante')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEventoParticipantes;

    [MVCPath('/eventoparticipante/($CO_Evento_Participante)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEventoParticipante(CO_Evento_Participante: Integer);

    [MVCPath('/eventoparticipante')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddEventoParticipante;

    [MVCPath('/eventoparticipante/($CO_Evento_Participante)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateEventoParticipante(CO_Evento_Participante: Integer);

    [MVCPath('/eventoparticipante/($CO_Evento_Participante)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteEventoParticipante(CO_Evento_Participante: Integer);

  end;

implementation

uses
  Model.EventoParticipante;

procedure TControllerEventoPariticipante.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerEventoPariticipante.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerEventoPariticipante.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

//Sample CRUD Actions for a "Customer" entity
procedure TControllerEventoPariticipante.GetEventoParticipantes;
begin
   Render<TEventoParticipante>(TEventoParticipante.GetAll);
end;

procedure TControllerEventoPariticipante.GetEventoParticipante(CO_Evento_Participante: Integer);
begin
   Render(TEventoParticipante.GetByID(CO_Evento_Participante));
end;

procedure TControllerEventoPariticipante.AddEventoParticipante;
var
   AEventoParticipante : TObjectList<TEventoParticipante>;
begin

   AEventoParticipante := Context.Request.BodyAsListOf<TEventoParticipante>;

   try

      if TEventoParticipante.Add(AEventoParticipante) then begin
         Render(201, 'Foto adicionada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEventoParticipante.Free;
   end;

end;

procedure TControllerEventoPariticipante.UpdateEventoParticipante(CO_Evento_Participante: Integer);
var
   AEventoParticipante : TEventoParticipante;
begin

   AEventoParticipante := Context.Request.BodyAs<TEventoParticipante>;

   try

      AEventoParticipante.co_evento_participante := CO_Evento_Participante;

      if TEventoParticipante.Update(AEventoParticipante) then begin
         Render(200, 'Foto atualizada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AEventoParticipante.Free;
   end;
end;

procedure TControllerEventoPariticipante.DeleteEventoParticipante(CO_Evento_Participante: Integer);
begin

   if TEventoParticipante.Delete(CO_Evento_Participante) then begin
      Render(200, 'Foto exluida com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
