unit Controller.Membro;

interface

uses
  System.SysUtils, System.StrUtils, MVCFramework.Logger, MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerMembro = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/membros')]
    [MVCHTTPMethod([httpGET])]
    procedure GetMembros;

    [MVCPath('/membros/($CO_Membro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetMembro(CO_Membro: Integer);

    [MVCPath('/membros')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddMembro;

    [MVCPath('/membros/($CO_Membro)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateMembro(CO_Membro: Integer);

    [MVCPath('/membros/($CO_Membro)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteMembro(CO_Membro: Integer);

  end;

implementation

uses
  Model.Membro;

procedure TControllerMembro.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerMembro.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerMembro.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TControllerMembro.GetMembros;
begin
   Render<TMembro>(TMembro.GetAll);
end;

procedure TControllerMembro.GetMembro(CO_Membro: Integer);
begin
   Render(TMembro.GetByID(CO_Membro));
end;

procedure TControllerMembro.AddMembro;
var
   AMembro : TMembro;
begin

   AMembro := Context.Request.BodyAs<TMembro>;

   try

      if TMembro.Add(AMembro) then begin
         Render(201, 'Membro adicionado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AMembro.Free;
   end;

end;

procedure TControllerMembro.UpdateMembro(CO_Membro: Integer);
var
   AMembro : TMembro;
begin

   AMembro := Context.Request.BodyAs<TMembro>;

   try

      AMembro.co_membro := CO_Membro;

      if TMembro.Add(AMembro) then begin
         Render(200, 'Membro atualizado com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AMembro.Free;
   end;

end;

procedure TControllerMembro.DeleteMembro(CO_Membro: Integer);
begin

   if TMembro.Delete(CO_Membro) then begin
      Render(200, 'Membro exluido com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
