unit Model.MembroBike;

interface

uses
   System.Classes, System.Generics.Collections, System.SysUtils, Data.DB, FireDAC.Comp.Client,
   SysTem.Variants, FireDAC.Stan.Param;

type
   TMembroBike = class
   private
    Fnu_serie: String;
    Fim_foto: String;
    Ftx_modelo: String;
    Fco_bike: Integer;
    Fco_marca: Integer;
    Fco_membro: Integer;
    procedure Setco_bike(const Value: Integer);
    procedure Setco_marca(const Value: Integer);
    procedure Setco_membro(const Value: Integer);
    procedure Setim_foto(const Value: String);
    procedure Setnu_serie(const Value: String);
    procedure Settx_modelo(const Value: String);
   public
      class function GetByID(ACO_Bike : Integer) : TMembroBike;
      class function Add(AMembroBike : TMembroBike)        : Boolean;
      class function Update(AMembroBike : TMembroBike)     : Boolean;
      class function Delete(ACO_Bike : Integer)  : Boolean;

      property co_bike : Integer   read Fco_bike   write Setco_bike;
      property co_membro : Integer read Fco_membro write Setco_membro;
      property co_marca : Integer  read Fco_marca  write Setco_marca;
      property tx_modelo : String  read Ftx_modelo write Settx_modelo;
      property nu_serie : String   read Fnu_serie  write Setnu_serie;
      property im_foto : String    read Fim_foto   write Setim_foto;
   end;

implementation

{ TMembroBike }

uses
   Dados0;

class function TMembroBike.Add(AMembroBike: TMembroBike): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AStrStream  : TStringStream;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('INSERT INTO MEMBRO_BIKE (CO_BIKE, CO_MEMBRO, CO_MARCA, TX_MODELO, NU_SERIE, IM_FOTO)                     ').
               Append('                 VALUES (GEN_ID(IN_CO_BIKE, 1), :CO_MEMBRO, :CO_MARCA, :TX_MODELO, :NU_SERIE, :IM_FOTO); ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;
   AFDQuery.SQL.Text   := AStrBuilder.ToString;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.ParamByName('CO_MEMBRO').AsInteger := AMembroBike.co_membro;
         AFDQuery.ParamByName('CO_MARCA').AsInteger  := AMembroBike.co_marca;
         AFDQuery.ParamByName('TX_MODELO').AsString  := AMembroBike.tx_modelo;
         AFDQuery.ParamByName('NU_SERIE').AsString   := AMembroBike.nu_serie;

         if AMembroBike.im_foto <> EmptyStr then begin
            AStrStream.Create(AMembroBike.im_foto);
            AFDQuery.ParamByName('IM_FOTO').LoadFromStream(AStrStream, ftBlob);
            AStrStream.Free;
         end else begin
            AFDQuery.ParamByName('IM_FOTO').Value := null;
         end;

         AFDQuery.ExecSQL;

         Result := True;

         ADMCon.Conexao.Commit;

      except
         on e : Exception do begin
            Result := False;
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

class function TMembroBike.Update(AMembroBike: TMembroBike): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AStrStream  : TStringStream;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('UPDATE MEMBRO_BIKE             ').
               Append('   SET CO_MEMBRO = :CO_MEMBRO, ').
               Append('       CO_MARCA  = :CO_MARCA,  ').
               Append('       TX_MODELO = :TX_MODELO, ').
               Append('       NU_SERIE  = :NU_SERIE,  ').
               Append('       IM_FOTO   = :IM_FOTO    ').
               Append('   WHERE CO_BIKE = :CO_BIKE;   ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;
   AFDQuery.SQL.Text   := AStrBuilder.ToString;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.ParamByName('CO_MEMBRO').AsInteger := AMembroBike.co_membro;
         AFDQuery.ParamByName('CO_MARCA').AsInteger  := AMembroBike.co_marca;
         AFDQuery.ParamByName('TX_MODELO').AsString  := AMembroBike.tx_modelo;
         AFDQuery.ParamByName('NU_SERIE').AsString   := AMembroBike.nu_serie;

         if AMembroBike.im_foto <> EmptyStr then begin
            AStrStream.Create(AMembroBike.im_foto);
            AFDQuery.ParamByName('IM_FOTO').LoadFromStream(AStrStream, ftBlob);
            AStrStream.Free;
         end else begin
            AFDQuery.ParamByName('IM_FOTO').Value := null;
         end;

         AFDQuery.ParamByName('CO_BIKE').AsInteger  := AMembroBike.co_bike;

         AFDQuery.ExecSQL;

         Result := True;

         ADMCon.Conexao.Commit;

      except
         on e : Exception do begin
            Result := False;
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

class function TMembroBike.Delete(ACO_Bike: Integer): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('DELETE FROM MEMBRO_BIKE      ').
               Append('   WHERE CO_BIKE = :CO_BIKE; ');
   ADMCon := TDM0.Create(nil);

   try

      ADMCon.Conexao.StartTransaction;

      try

         Result :=  ADMCon.Conexao.ExecSQL(AStrBuilder.ToString, [ACO_Bike]) > 0;

         ADMCon.Conexao.Commit;

      except
         on e : Exception do begin
            Result := False;
            ADMCon.Conexao.Rollback;
            raise Exception.Create(e.Message);
         end;
      end;

   finally
      AStrBuilder.Free;
      ADMCon.Free;
   end;

end;

class function TMembroBike.GetByID(ACO_Bike: Integer): TMembroBike;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AMembroBike : TMembroBike;
   AStrStream  : TStringStream;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('SELECT CO_BIKE, CO_MEMBRO, CO_MARCA, TX_MODELO, NU_SERIE, IM_FOTO ').
               Append('   FROM MEMBRO_BIKE                                               ').
               Append('   WHERE CO_BIKE = :CO_BIKE;                                      ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.Open(AStrBuilder.ToString, [ACO_Bike]);

         AMembroBike           := TMembroBike.Create;
         AMembroBike.co_bike   := AFDQuery.FieldByName('CO_BIKE').AsInteger;
         AMembroBike.co_membro := AFDQuery.FieldByName('CO_MEMBRO').AsInteger;
         AMembroBike.co_marca  := AFDQuery.FieldByName('CO_MARCA').AsInteger;
         AMembroBike.tx_modelo := AFDQuery.FieldByName('TX_MODELO').AsString;
         AMembroBike.nu_serie  := AFDQuery.FieldByName('NU_SERIE').AsString;

         if not AFDQuery.FieldByName('IM_FOTO').IsNull then begin
            AStrStream.Create(AFDQuery.FieldByName('IM_FOTO').AsBytes);
            AMembroBike.im_foto := AStrStream.DataString;
            AStrStream.Free;
         end else begin
            AMembroBike.im_foto := EmptyStr;
         end;

         Result := AMembroBike;

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

procedure TMembroBike.Setco_bike(const Value: Integer);
begin
  Fco_bike := Value;
end;

procedure TMembroBike.Setco_marca(const Value: Integer);
begin
  Fco_marca := Value;
end;

procedure TMembroBike.Setco_membro(const Value: Integer);
begin
  Fco_membro := Value;
end;

procedure TMembroBike.Setim_foto(const Value: String);
begin
  Fim_foto := Value;
end;

procedure TMembroBike.Setnu_serie(const Value: String);
begin
  Fnu_serie := Value;
end;

procedure TMembroBike.Settx_modelo(const Value: String);
begin
  Ftx_modelo := Value;
end;

end.
