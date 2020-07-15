unit Model.Marca;

interface

uses
   System.Classes, System.Generics.Collections, System.SysUtils, Data.DB, FireDAC.Comp.Client,
   SysTem.Variants, FireDAC.Stan.Param;

type
   TMarca = class
   private
    Fnm_marca: String;
    Fco_marca: Integer;
    Fnm_pais: String;
    procedure Setco_marca(const Value: Integer);
    procedure Setnm_marca(const Value: String);
    procedure Setnm_pais(const Value: String);
   public
      class function GetByID(ACO_Marca : Integer) : TMarca;
      class function GetAll                       : TObjectList<TMarca>;
      class function Add(AMarca : TMarca)         : Boolean;
      class function Update(AMarca : TMarca)      : Boolean;
      class function Delete(ACO_Marca : Integer)  : Boolean;

      property co_marca : Integer read Fco_marca write Setco_marca;
      property nm_marca : String read Fnm_marca write Setnm_marca;
      property nm_pais : String read Fnm_pais write Setnm_pais;
   end;

implementation

{ TMarca }

uses Dados0;

class function TMarca.Add(AMarca: TMarca): Boolean;
begin

end;

class function TMarca.Delete(ACO_Marca: Integer): Boolean;
begin

end;

class function TMarca.GetAll: TObjectList<TMarca>;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AMarca      : TMarca;
   AListeMarca : TObjectList<TMarca>;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('SELECT CO_MARCA, NM_MARCA, NM_PAIS ').
               Append('   FROM MARCA                      ').
               Append('   ORDER BY NM_MARCA               ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;

   try

      ADMCon.Conexao.StartTransaction;
      AListeMarca := TObjectList<TMarca>.Create;

      try

         AFDQuery.Open(AStrBuilder.ToString);

         AFDQuery.First;

         while not AFDQuery.Eof do begin

            AMarca          := TMarca.Create;
            AMarca.co_marca := AFDQuery.FieldByName('CO_MARCA').AsInteger;
            AMarca.nm_marca := AFDQuery.FieldByName('NM_MARCA').AsString;
            AMarca.nm_pais  := AFDQuery.FieldByName('NM_PAIS').AsString;

            AListeMarca.Add(AMarca);

            AFDQuery.Next;

         end;

         Result := AListeMarca;

         ADMCon.Conexao.Commit;

      except
         on e : Exception do begin
            ADMCon.Conexao.Rollback;
            raise Exception.Create(e.Message);
         end;
      end;

   finally
      AStrBuilder.Free;
      ADMCon.Free;
      AFDQuery.Free;
   end;

end;

class function TMarca.GetByID(ACO_Marca: Integer): TMarca;
begin

end;

procedure TMarca.Setco_marca(const Value: Integer);
begin
  Fco_marca := Value;
end;

procedure TMarca.Setnm_marca(const Value: String);
begin
  Fnm_marca := Value;
end;

procedure TMarca.Setnm_pais(const Value: String);
begin
  Fnm_pais := Value;
end;

class function TMarca.Update(AMarca: TMarca): Boolean;
begin

end;

end.
