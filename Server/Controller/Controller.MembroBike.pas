unit Controller.MembroBike;

interface

uses
  System.SysUtils, System.StrUtils, MVCFramework.Logger, MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerMembroBike = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public

    [MVCPath('/membrobike/($CO_Bike)')]
    [MVCHTTPMethod([httpGET])]
    procedure GeMembroBike(CO_Bike: Integer);

    [MVCPath('/membrobike')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddMembroBike;

    [MVCPath('/membrobike/($CO_Bike)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateMembroBike(CO_Bike: Integer);

    [MVCPath('/membrobike/($CO_Bike)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteMembroBike(CO_Bike: Integer);

  end;

implementation

uses
  Model.MembroBike;

procedure TControllerMembroBike.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerMembroBike.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerMembroBike.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TControllerMembroBike.GeMembroBike(CO_Bike: Integer);
begin
   Render(TMembroBike.GetByID(CO_Bike));
end;

procedure TControllerMembroBike.AddMembroBike;
var
   AMembroBike : TMembroBike;
begin

   AMembroBike := Context.Request.BodyAs<TMembroBike>;

   try

      if TMembroBike.Add(AMembroBike) then begin
         Render(201, 'Bike adicionada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AMembroBike.Free;
   end;

end;

procedure TControllerMembroBike.UpdateMembroBike(CO_Bike: Integer);
var
   AMembroBike : TMembroBike;
begin

   AMembroBike := Context.Request.BodyAs<TMembroBike>;

   try

      AMembroBike.co_bike := CO_Bike;

      if TMembroBike.Add(AMembroBike) then begin
         Render(200, 'Bike atualizada com sucesso!');
      end else begin
         Render(500, 'Internal Server Error');
      end;

   finally
      AMembroBike.Free;
   end;

end;

procedure TControllerMembroBike.DeleteMembroBike(CO_Bike: Integer);
begin

   if TMembroBike.Delete(CO_Bike) then begin
      Render(200, 'Bike exluida com sucesso!');
   end else begin
      Render(500, 'Internal Server Error');
   end;

end;



end.
