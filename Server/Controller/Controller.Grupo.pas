unit Controller.Grupo;

interface

uses
  System.StrUtils, System.SysUtils, MVCFramework, MVCFramework.Commons, MVCFramework.Logger;

type

  [MVCPath('/eBike')]
  TcontrollerGrupo = class(TMVCController) 
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public

    [MVCPath('/grupos')]
    [MVCHTTPMethod([httpGET])]
    procedure GetGrupos;

    [MVCPath('/grupos/($CO_Grupo)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetGrupo(CO_Grupo : Integer);

    [MVCPath('/grupos')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddGrupo;

    [MVCPath('/grupos/(($CO_Grupo)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateGrupo(CO_Grupo : Integer);

    [MVCPath('/grupos/(($CO_Grupo)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteGrupo(CO_Grupo : Integer);

  end;

implementation

uses
   Model.Grupo;

procedure TcontrollerGrupo.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TcontrollerGrupo.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TcontrollerGrupo.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TcontrollerGrupo.GetGrupos;
begin
   Render<TGrupo>(TGrupo.GetAll);
end;

procedure TcontrollerGrupo.GetGrupo(CO_Grupo : Integer);
begin
  Render(TGrupo.GetByID(CO_Grupo));
end;

procedure TcontrollerGrupo.AddGrupo;
var
   AGrupo : TGrupo;
begin

   AGrupo := Context.Request.BodyAs<TGrupo>;

   try

      if TGrupo.Add(AGrupo) then begin
         Render(201, 'Grupo criado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AGrupo.Free;
   end;

end;

procedure TcontrollerGrupo.UpdateGrupo(CO_Grupo : Integer);
var
   AGrupo : TGrupo;
begin

   AGrupo := Context.Request.BodyAs<TGrupo>;

   try

      AGrupo.co_grupo := CO_Grupo;

      if TGrupo.Add(AGrupo) then begin
         Render(200, 'Grupo atualizado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AGrupo.Free;
   end;

end;

procedure TcontrollerGrupo.DeleteGrupo(CO_Grupo : Integer);
begin

   if TGrupo.Delete(CO_Grupo) then begin
      Render(200, 'Grupo exluido com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
