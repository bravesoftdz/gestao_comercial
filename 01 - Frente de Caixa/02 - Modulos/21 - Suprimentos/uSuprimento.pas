unit uSuprimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, ACBrBase, ACBrPosPrinter, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, Vcl.StdCtrls, JvExStdCtrls, JvMemo,
  RzPanel, RzDlgBtn, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, JvExExtCtrls, JvImage, ACBrUtil,
  ACBrEnterTab;

type
  TFrSuprimento = class(TForm)
    JvImage2: TJvImage;
    Panel1: TPanel;
    JvImage3: TJvImage;
    Label7: TLabel;
    JvImage1: TJvImage;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ed_saldo_atual: TJvCalcEdit;
    ed_valor: TJvCalcEdit;
    ed_saldo_apos: TJvCalcEdit;
    RzDialogButtons1: TRzDialogButtons;
    ed_anotacoes: TJvMemo;
    Pop00: TPopupMenu;
    S1: TMenuItem;
    FDQuery1: TFDQuery;
    ACBrPosPrinter1: TACBrPosPrinter;
    ACBrEnterTab1: TACBrEnterTab;
    Label1: TLabel;
    procedure ed_valorExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JvImage1Click(Sender: TObject);
    procedure RzDialogButtons1ClickOk(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    // Cupom gerencial
    FBuffer : TStringList;
    PrintSegundaVia : Boolean;

    procedure Cupom_Gerencial_Cabecalho;
    procedure Cupom_Gerencial_Corpo;
    procedure Cupom_Gerencial_Rodape;
    function Cupom_Gerencial_Imprimir : boolean;
  public
    { Public declarations }
  end;

var
  FrSuprimento: TFrSuprimento;

implementation

uses
   uModulo, Classe.Empresa, Classe.Operador, Classe.Caixa, uPrincipal,
  Classe.Suprimentos;

{$R *.dfm}

procedure TFrSuprimento.Cupom_Gerencial_Cabecalho;
begin
   // Inicia a objeto de strings
   FBuffer := TStringList.Create;

   // Inicia a cria��o do cabe�alho
   FBuffer.Clear;

   // Identifica��es b�sicas
   FBuffer.Add('</ae><c>' +
                  PadSpace(
                     'Lj: '    + ObjSuprimentos.CodigoEmpresa
                     + ' '
                     + 'Cx: '  + ObjCaixa.Caixa_Codigo.ToString()
                     + ' '
                     + 'Op: '  + ObjSuprimentos.OperadorNome,
                     Trunc(ACBrPosPrinter1.ColunasFonteCondensada),
                     '|')

   );

   // Titulo do cupom
   FBuffer.Add('</linha_simples>');
   FBuffer.Add('</ce><c>' + FEmpresaClass.RazaoSocial);
   FBuffer.Add('</ce><c>' + FEmpresaClass.NomeFantasia);
   FBuffer.Add('</ce><c>' + FEmpresaClass.Endereco + ',' + Format('%.3d', [FEmpresaClass.Numero]));
   FBuffer.Add('</ce><c>' + FEmpresaClass.Bairro + ' - ' + FEmpresaClass.Cidade + ' - ' + 'CEP: ' + FEmpresaClass.Cep);

   FBuffer.Add('</linha_simples>');
   FBuffer.Add('</ce></fn><n>COMPROVANTE DE ENTRADA</n>');
   FBuffer.Add('</ce></fb><c>' + DateToStr(ObjSuprimentos.DataSuprim) + ' - ' + TimeToStr(ObjSuprimentos.HoraSuprim));
end;

procedure TFrSuprimento.Cupom_Gerencial_Corpo;
begin
   FBuffer.Add('</linha_simples>');

   // Exibe o total do cupom
   FBuffer.Add('<ae><c>' +
      PadSpace(
         'Saldo Atual R$'
         + '|'
         + FormatFloat(',0.00', ObjSuprimentos.SaldoAtual),
         Trunc(ACBrPosPrinter1.ColunasFonteCondensada),
         '|'
      ) + '</c>'
   );

   // Exibe o total do cupom
   FBuffer.Add('<ae></fn><e>' +
      PadSpace(
         'Suprimento R$'
         + '|'
         + FormatFloat(',0.00', ObjSuprimentos.ValorSuprim),
         Trunc(ACBrPosPrinter1.ColunasFonteExpandida),
         '|'
      ) + '</e>'
   );

   // Exibe o total do cupom
   FBuffer.Add('<ae><c>' +
      PadSpace(
         'Saldo Apos R$'
         + '|'
         + FormatFloat(',0.00', ObjSuprimentos.SaldoApos),
         Trunc(ACBrPosPrinter1.ColunasFonteCondensada),
         '|'
      ) + '</c>'
   );

   FBuffer.Add('</zera>');

   // Exibe o total do cupom
   FBuffer.Add('<ae><c>' + ObjSuprimentos.Anotacoes + '</c>');

   FBuffer.Add('</zera>');
   FBuffer.Add('</zera>');

   // Exibe o total do cupom
   FBuffer.Add('</ce><c>' + '----------------------------------' );
   FBuffer.Add('</ce><c>' + 'Ass. Responsavel' );

end;

function TFrSuprimento.Cupom_Gerencial_Imprimir : boolean;
var
   i,n : Integer;
begin
   Result := false;

   with ACBrPosPrinter1 do
   begin
      Porta  := ObjCaixa.Caixa_Printer_Porta_G;
      Modelo := TACBrPosPrinterModelo(ObjCaixa.Caixa_Printer_Model_G);

      if Modelo = ppEscPosEpson  then
      begin
         EspacoEntreLinhas := 50;
         LinhasEntreCupons := 5;
      end;

      if Modelo = ppEscBematech then
      begin
         EspacoEntreLinhas := 1;
         LinhasEntreCupons := 3;
      end;

      Ativar;
   end;

   // Cria o objeto e configura os dados
   if not Assigned(ObjSuprimentos) then
      ObjSuprimentos := TCupomSuprimento.Create;

   Cupom_Gerencial_Cabecalho;
   Cupom_Gerencial_Corpo;
   Cupom_Gerencial_Rodape;

   // Determinao tipo de corte do papel
   FBuffer.Add('</corte_total>');

   try

      try

         for n := 1 to ObjCaixa.Caixa_Cupom_Vias_S do
         begin
            for i := 0 to FBuffer.Count - 1 do
               ACBrPosPrinter1.Buffer.Add( FBuffer[I] );

            ACBrPosPrinter1.Imprimir;   // Imprime o Buffer
         end;

          Result := true;

      except
         Imprime_display('erro ao imprimir comprovante, verifique a impressora', clRed);
         Sleep(1000);
         Imprime_display_anterior;
         Abort;
      end;

   finally
      ACBrPosPrinter1.Desativar;
      FreeAndNil( FBuffer );
   end;

   FreeAndNil(ObjSuprimentos);

end;

procedure TFrSuprimento.Cupom_Gerencial_Rodape;
begin
   FBuffer.Add('</linha_simples>');

   if PrintSegundaVia then
      FBuffer.Add('TechCore-PDV - http://techcore.com.br (2� Via)')
   else
      FBuffer.Add('TechCore-PDV - http://techcore.com.br')
end;

procedure TFrSuprimento.ed_valorExit(Sender: TObject);
begin
   ed_saldo_apos.Value := ( ed_saldo_atual.Value + ed_valor.Value );
end;

procedure TFrSuprimento.FormCreate(Sender: TObject);
var
   aQuery : TFDQuery;
   rTroco : Real;
begin
   {coloca os caracteres em mai�sculos no memo}
   TEdit(ed_anotacoes).CharCase := ecUpperCase;

   aQuery            := TFDQuery.Create(self);
   aQuery.Connection := FrModulo.DBCon_Local;


   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Data:       09/03/2019
      Descri��o:  Carrega o valor total do troco
   ------------------------------------------------------------------------------------- }
   aQuery.Close;
   aQuery.SQL.Clear;
   aQuery.SQL.Add('SELECT SUM(F_VLR_TROCO) AS F_VLR_TROCO FROM C000050 WHERE ID_ABERTURA = :ID_ABERTURA');
   aQuery.ParamByName('ID_ABERTURA').AsString := VR_ID_ABERTURA;
   aQuery.Open();

   rTroco := aQuery.FieldByName('F_VLR_TROCO').AsFloat;


   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Data:       26/02/2019
      Descri��o:  Recupera o valor atual do caixa na data atual
   ------------------------------------------------------------------------------------- }
   try
      aQuery.Close;
      aQuery.SQL.Clear;
      aQuery.SQL.Add('SELECT');
      aquery.SQL.Add('  SUM(F_PARCELA_VALOR) +');
      aQuery.SQL.Add('  COALESCE((SELECT F_ABER_VALOR   FROM C000001 WHERE ID_ABERTURA = :ID_ABERTURA),0) -');
      aQuery.SQL.Add('  COALESCE((SELECT SUM(SNG_VALOR) FROM C000053 WHERE ID_ABERTURA = :ID_ABERTURA),0) -');
      aQuery.SQL.Add('  COALESCE((SELECT SUM(RET_VALOR) FROM C000054 WHERE ID_ABERTURA = :ID_ABERTURA),0) +');
      aQuery.SQL.Add('  COALESCE((SELECT SUM(SUP_VALOR) FROM C000055 WHERE ID_ABERTURA = :ID_ABERTURA),0) AS SALDO_ATUAL');
      aQuery.SQL.Add('FROM');
      aQuery.SQL.Add('  VW_REL_FORMA_PAGTO AS T1');
      aQuery.SQL.Add('WHERE');
      aQuery.SQL.Add('  T1.F_CUPOM_STATUS = 1');
      aQuery.SQL.Add('AND');
      aQuery.SQL.Add('  T1.F_CODIGO       = 1');
      aQuery.SQL.Add('AND');
      aQuery.SQL.Add('  T1.ID_ABERTURA    = :ID_ABERTURA');
      aQuery.ParamByName('ID_ABERTURA').AsString := VR_ID_ABERTURA;
      aQuery.Open();

      ed_saldo_atual.Value := ( aQuery.FieldByName('SALDO_ATUAL').AsFloat - rTroco );

   finally
      FreeAndNil( aQuery );
   end;
end;

procedure TFrSuprimento.JvImage1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrSuprimento.Label1Click(Sender: TObject);
begin
   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Data:       03/03/2019
      Descri��o:  Ap�s gravar os dados, efetua a impress�o da sangria
   ------------------------------------------------------------------------------------- }
   PrintSegundaVia := true;

   if not Cupom_Gerencial_Imprimir then
      Abort;
end;

procedure TFrSuprimento.RzDialogButtons1ClickOk(Sender: TObject);
var
   aQuery : TFDQuery;
begin
   PrintSegundaVia := false;

   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Data:       26/02/2019
      Descri��o:  Verifica se foi informado o valor da sangria
   ------------------------------------------------------------------------------------- }
   if ed_valor.AsInteger <= 0 then
   begin
      Imprime_display('informe o valor da entrada.', clYellow);
      Sleep(1000);
      Imprime_display_anterior;
      ed_valor.SetFocus;
      Abort;
   end;

   if Length( ed_anotacoes.Text ) < 15  then
   begin
      Imprime_display('informe a justificativa desta entrada com no m�nimo 15 caracteres.', clYellow);
      Sleep(1000);
      Imprime_display_anterior;
      ed_anotacoes.SetFocus;
      Abort;
   end;

   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Data:       03/03/2019
      Descri��o:  Efetua o lan�amento da sangria
   ------------------------------------------------------------------------------------- }
   try
      try
         aQuery            := TFDQuery.Create(self);
         aQuery.Connection := FrModulo.DBCon_Local;

         aQuery.SQL.Add('INSERT INTO C000055(');
         aQuery.SQL.Add('  ID_EMPRESA,');
         aQuery.SQL.Add('  ID_CAIXA,');
         aQuery.SQL.Add('  ID_OPERADOR,');
         aQuery.SQL.Add('  SUP_DATA,');
         aQuery.SQL.Add('  SUP_SALDO_ATUAL,');
         aQuery.SQL.Add('  SUP_VALOR,');
         aQuery.SQL.Add('  SUP_SALDO_APOS,');
         aQuery.SQL.Add('  SUP_ANOTACOES');
         aQuery.SQL.Add(')VALUES(');
         aQuery.SQL.Add('  :ID_EMPRESA,');
         aQuery.SQL.Add('  :ID_CAIXA,');
         aQuery.SQL.Add('  :ID_OPERADOR,');
         aQuery.SQL.Add('  :SUP_DATA,');
         aQuery.SQL.Add('  :SUP_SALDO_ATUAL,');
         aQuery.SQL.Add('  :SUP_VALOR,');
         aQuery.SQL.Add('  :SUP_SALDO_APOS,');
         aQuery.SQL.Add('  :SUP_ANOTACOES)');
         aQuery.ParamByName('ID_EMPRESA').AsInteger    := FEmpresaClass.ID;
         aQuery.ParamByName('ID_CAIXA').AsInteger      := ObjCaixa.Caixa_ID;
         aQuery.ParamByName('ID_OPERADOR').AsInteger   := ObjOperador.Opr_IDOperador;
         aQuery.ParamByName('SUP_DATA').AsDateTime     := Now;
         aQuery.ParamByName('SUP_SALDO_ATUAL').AsFloat := ed_saldo_atual.Value;
         aQuery.ParamByName('SUP_VALOR').AsFloat       := ed_valor.Value;
         aQuery.ParamByName('SUP_SALDO_APOS').AsFloat  := ed_saldo_apos.Value;
         aQuery.ParamByName('SUP_ANOTACOES').AsString  := ed_anotacoes.Text;
         aQuery.ExecSQL;

         { -----------------------------------------------------------------------------------
            Autor:      Winston Moreira
            Data:       03/03/2019
            Descri��o:  Ap�s gravar os dados, efetua a impress�o da sangria
         ------------------------------------------------------------------------------------- }
         if not Cupom_Gerencial_Imprimir then
            Abort;

      except
         Imprime_display('erro ao gravar a entrada na tabela', clRed);
         Sleep(1000);
         Imprime_display_anterior;
         ed_valor.SetFocus;
         Abort;
      end;
   finally
      FreeAndNil( aQuery );
   end;

   Self.ModalResult := mrOk;
end;

procedure TFrSuprimento.S1Click(Sender: TObject);
begin
   Self.Close;
end;

end.
