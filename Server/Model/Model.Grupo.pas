unit Model.Grupo;

interface

uses
   System.Classes, System.Generics.Collections, System.SysUtils, Data.DB, FireDAC.Comp.Client,
   SysTem.Variants, FireDAC.Stan.Param;

type
   TGrupo = class
   private
    Fim_brasao: String;
    Fdt_fundacao: TDateTime;
    Fco_lider: Integer;
    Fnm_grupo: String;
    Fco_cidade: Integer;
    Fco_grupo: Integer;
    procedure Setco_cidade(const Value: Integer);
    procedure Setco_grupo(const Value: Integer);
    procedure Setco_lider(const Value: Integer);
    procedure Setdt_fundacao(const Value: TDateTime);
    procedure Setim_brasao(const Value: String);
    procedure Setnm_grupo(const Value: String);
   public
      class function GetByID(ACO_Grupo : Integer) : TGrupo;
      class function GetAll                       : TObjectList<TGrupo>;
      class function Add(AGrupo : TGrupo)         : Boolean;
      class function Update(AGrupo : TGrupo)      : Boolean;
      class function Delete(ACO_Grupo : Integer)  : Boolean;

      property co_grupo : Integer      read Fco_grupo    write Setco_grupo;
      property co_cidade : Integer     read Fco_cidade   write Setco_cidade;
      property nm_grupo : String       read Fnm_grupo    write Setnm_grupo;
      property dt_fundacao : TDateTime read Fdt_fundacao write Setdt_fundacao;
      property co_lider : Integer      read Fco_lider    write Setco_lider;
      property im_brasao : String      read Fim_brasao   write Setim_brasao;
   end;

implementation

{ TGrupo }

uses
   Dados0;

class function TGrupo.Add(AGrupo: TGrupo): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AStrStream  : TStringStream;
begin

//   Result := False;

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('INSERT INTO GRUPO (CO_GRUPO,                 CO_CIDADE, NM_GRUPO, DT_FUNDACAO, CO_LIDER, IM_BRASAO)       ').
               Append('           VALUES (GEN_ID(INC_CO_GRUPO,  1), :CO_CIDADE, :NM_GRUPO, :DT_FUNDACAO, :CO_LIDER, :IM_BRASAO); ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;
   AFDQuery.SQL.Text   := AStrBuilder.ToString;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.ParamByName('CO_CIDADE').AsInteger    := AGrupo.co_cidade;
         AFDQuery.ParamByName('NM_GRUPO').AsString      := AGrupo.nm_grupo;
         AFDQuery.ParamByName('DT_FUNDACAO').AsDateTime := AGrupo.dt_fundacao;
         AFDQuery.ParamByName('CO_LIDER').AsInteger     := AGrupo.co_lider;

         if AGrupo.im_brasao <> EmptyStr then begin
            AStrStream.Create(AGrupo.im_brasao);
            AFDQuery.ParamByName('IM_BRASAO').LoadFromStream(AStrStream, ftBlob);
            AStrStream.Free;
         end else begin
            AFDQuery.ParamByName('IM_BRASAO').Value := null;
         end;

         AFDQuery.ExecSQL;

         Result := True;

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

class function TGrupo.Update(AGrupo: TGrupo): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AStrStream  : TStringStream;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('UPDATE GRUPO                       ').
               Append('   SET CO_CIDADE   = :CO_CIDADE,   ').
               Append('       NM_GRUPO    = :NM_GRUPO,    ').
               Append('       DT_FUNDACAO = :DT_FUNDACAO, ').
               Append('       CO_LIDER    = :CO_LIDER,    ').
               Append('       IM_BRASAO   = :IM_BRASAO    ').
               Append('   WHERE (CO_GRUPO = :CO_GRUPO);   ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;
   AFDQuery.SQL.Text   := AStrBuilder.ToString;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.ParamByName('CO_CIDADE').AsInteger    := AGrupo.co_cidade;
         AFDQuery.ParamByName('NM_GRUPO').AsString      := AGrupo.nm_grupo;
         AFDQuery.ParamByName('DT_FUNDACAO').AsDateTime := AGrupo.dt_fundacao;
         AFDQuery.ParamByName('CO_LIDER').AsInteger     := AGrupo.co_lider;

         if AGrupo.im_brasao <> EmptyStr then begin
            AStrStream.Create(AGrupo.im_brasao);
            AFDQuery.ParamByName('IM_BRASAO').LoadFromStream(AStrStream, ftBlob);
            AStrStream.Free;
         end else begin
            AFDQuery.ParamByName('IM_BRASAO').Value := null;
         end;
         AFDQuery.ParamByName('CO_GRUPO').AsInteger     := AGrupo.co_grupo;

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

class function TGrupo.Delete(ACO_Grupo: Integer): Boolean;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('DELETE FROM GRUPO              ').
               Append('   WHERE CO_GRUPO = :CO_GRUPO; ');
   ADMCon := TDM0.Create(nil);

   try

      ADMCon.Conexao.StartTransaction;

      try

         Result :=  ADMCon.Conexao.ExecSQL(AStrBuilder.ToString, [ACO_Grupo]) > 0;

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

class function TGrupo.GetAll: TObjectList<TGrupo>;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   ADataSet    : TDataSet;
   AGrupo      : TGrupo;
   AListGrupo  : TObjectList<TGrupo>;
   AStrStream  : TStringStream;
begin
   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('SELECT CO_GRUPO, CO_CIDADE, NM_GRUPO, DT_FUNDACAO, ').
               Append('       CO_LIDER, IM_BRASAO                         ').
               Append('   FROM GRUPO                                      ');
   ADMCon := TDM0.Create(nil);

   try

      ADMCon.Conexao.StartTransaction;
      AListGrupo  := TObjectList<TGrupo>.Create;

      try

         ADMCon.Conexao.ExecSQL(AStrBuilder.ToString, ADataSet);

         ADataSet.First;

         while not ADataSet.Eof do begin

            AGrupo             := TGrupo.Create;
            AGrupo.co_grupo    := ADataSet.FieldByName('CO_GRUPO').AsInteger;
            AGrupo.co_cidade   := ADataSet.FieldByName('CO_CIDADE').AsInteger;
            AGrupo.nm_grupo    := ADataSet.FieldByName('NM_GRUPO').AsString;
            AGrupo.dt_fundacao := ADataSet.FieldByName('DT_FUNDACAO').AsDateTime;
            AGrupo.co_lider    := ADataSet.FieldByName('CO_LIDER').AsInteger;

            if not ADataSet.FieldByName('IM_BRASAO').IsNull then begin
               AStrStream.Create(ADataSet.FieldByName('IM_BRASAO').AsBytes);
               AGrupo.im_brasao := AStrStream.DataString;
               AStrStream.Free;
            end else begin
               AGrupo.im_brasao := EmptyStr;
            end;

            AListGrupo.Add(AGrupo);

            ADataSet.Next;
         end;

         Result := AListGrupo;

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
   end;

end;

class function TGrupo.GetByID(ACO_Grupo: Integer): TGrupo;
var
   AStrBuilder : TStringBuilder;
   ADMCon      : TDM0;
   AFDQuery    : TFDQuery;
   AGrupo      : TGrupo;
   AStrStream  : TStringStream;
begin

   AStrBuilder := TStringBuilder.Create;
   AStrBuilder.Append('SELECT CO_GRUPO, CO_CIDADE, NM_GRUPO, DT_FUNDACAO, ').
               Append('       CO_LIDER, IM_BRASAO                         ').
               Append('   FROM GRUPO                                      ').
               Append('   WHERE CO_GRUPO = :CO_GRUPO;                     ');

   ADMCon := TDM0.Create(nil);

   AFDQuery            := TFDQuery.Create(nil);
   AFDQuery.Connection := ADMCon.Conexao;

   try

      ADMCon.Conexao.StartTransaction;

      try

         AFDQuery.Open(AStrBuilder.ToString, [ACO_Grupo]);

         AGrupo             := TGrupo.Create;
         AGrupo.co_grupo    := AFDQuery.FieldByName('CO_GRUPO').AsInteger;
         AGrupo.co_cidade   := AFDQuery.FieldByName('CO_CIDADE').AsInteger;
         AGrupo.nm_grupo    := AFDQuery.FieldByName('NM_GRUPO').AsString;
         AGrupo.dt_fundacao := AFDQuery.FieldByName('DT_FUNDACAO').AsDateTime;
         AGrupo.co_lider    := AFDQuery.FieldByName('CO_LIDER').AsInteger;

         if not AFDQuery.FieldByName('IM_BRASAO').IsNull then begin
            AStrStream.Create(AFDQuery.FieldByName('IM_BRASAO').AsBytes);
            AGrupo.im_brasao := AStrStream.DataString;
            AStrStream.Free;
         end else begin
            AGrupo.im_brasao := EmptyStr;
         end;

         Result := AGrupo;

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

procedure TGrupo.Setco_cidade(const Value: Integer);
begin
  Fco_cidade := Value;
end;

procedure TGrupo.Setco_grupo(const Value: Integer);
begin
  Fco_grupo := Value;
end;

procedure TGrupo.Setco_lider(const Value: Integer);
begin
  Fco_lider := Value;
end;

procedure TGrupo.Setdt_fundacao(const Value: TDateTime);
begin
  Fdt_fundacao := Value;
end;

procedure TGrupo.Setim_brasao(const Value: String);
begin
  Fim_brasao := Value;
end;

procedure TGrupo.Setnm_grupo(const Value: String);
begin
  Fnm_grupo := Value;
end;

end.
