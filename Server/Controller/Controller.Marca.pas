unit Controller.Marca;

interface

uses
  System.SysUtils, System.StrUtils, MVCFramework.Logger, MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/eBike')]
  TControllerMarca = class(TMVCController) 
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/marca')]
    [MVCHTTPMethod([httpGET])]
    procedure GetMarcas;

    [MVCPath('/marca/($CO_Marca)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetMarca(CO_Marca: Integer);

    [MVCPath('/marca')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddMarca;

    [MVCPath('/marca/($CO_Marca)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateMarca(CO_Marca: Integer);

    [MVCPath('/marca/($CO_Marca)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteMarca(CO_Marca: Integer);

  end;

implementation

uses
  Model.Marca;

procedure TControllerMarca.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Hello DelphiMVCFramework World');
end;

procedure TControllerMarca.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TControllerMarca.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TControllerMarca.GetMarcas;
begin
   Render<TMarca>(TMarca.GetAll);
end;

procedure TControllerMarca.GetMarca(CO_Marca: Integer);
begin
  //todo: render the customer by id
end;

procedure TControllerMarca.AddMarca;

begin
  //todo: create a new customer
end;

procedure TControllerMarca.UpdateMarca(CO_Marca: Integer);
begin
  //todo: update customer by id
end;

procedure TControllerMarca.DeleteMarca(CO_Marca: Integer);
begin
  //todo: delete customer by id
end;



end.
