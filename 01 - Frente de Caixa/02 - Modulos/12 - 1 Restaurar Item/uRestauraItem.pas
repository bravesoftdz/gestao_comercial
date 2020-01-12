unit uRestauraItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, RzEdit, RzLabel, Vcl.Buttons, PngSpeedButton, Vcl.Menus,
  Data.DB;

type
  TFrRestauraItem = class(TForm)
    Shape3: TShape;
    lb_cancelar_item: TRzLabel;
    ed_restaura_item: TRzNumericEdit;
    Image1: TImage;
    Pop00: TPopupMenu;
    C1: TMenuItem;
    C2: TMenuItem;
    N1: TMenuItem;
    dsProdutos: TDataSource;
    procedure C1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Libera_Cancelar : Boolean;
  public
    { Public declarations }
    PularSenha : Boolean;
  end;

var
  FrRestauraItem: TFrRestauraItem;

implementation

uses
   uVendas, uSenhaOperador, uPrincipal;

{$R *.dfm}

procedure TFrRestauraItem.C1Click(Sender: TObject);
begin
   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Dat:        20/02/2019
      Descri��o:  Confirma se foi digitado o n�mero do produto, se n�o solicita ao
                  operador que digite.
   ------------------------------------------------------------------------------------- }
   if ed_restaura_item.IntValue = 0 then
   begin
      Imprime_display('digite o n�mero do item a ser restaurado', clWhite);
      ed_restaura_item.SelectAll;
      Sleep(1000);
      Imprime_display_anterior;
      Abort;
   end;

   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Dat:        20/02/2019
      Descri��o:  Tenta localizar o item no DataSet de produtos
   ------------------------------------------------------------------------------------- }
   if not dsProdutos.DataSet.Locate('F_ITEM', ed_restaura_item.Value, []) then
   begin
      Imprime_display('item n�o localizado no cupom', clYellow);
      ed_restaura_item.SelectAll;
      Sleep(1000);
      Imprime_display_anterior;
      Abort;
   end;


   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Dat:        26/02/2019
      Descri��o:  Checa se este item j� foi cancelado
   ------------------------------------------------------------------------------------- }
   if dsProdutos.DataSet.FieldByName('F_STATUS').AsInteger = 1 then
   begin
      Imprime_display('este item n�o est� cancelado.', clYellow);
      ed_restaura_item.SelectAll;
      Sleep(1000);
      Imprime_display('restaurar item do cupom.', clYellow);
      Abort;
   end;

   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Dat:        20/02/2019
      Descri��o:  Cancela o item espec�ficado no painel
   ------------------------------------------------------------------------------------- }
   if lb_cancelar_item.Caption = 'CONFIRMA?' then
   begin

      try
         // coloca o cursro no modo de edi��o e altera o status
         dsProdutos.DataSet.Edit;
         dsProdutos.DataSet.FieldByName('f_status').AsInteger := 1;
         dsProdutos.DataSet.Post;

         Imprime_display('Item restaurado com sucesso', clYellow);
         Sleep(700);
         Imprime_display('informe o produto desejado.', clWhite);

         // Fecha o formul�rio confirmado o cancelamento
         Self.ModalResult := mrOk;

         Exit;

      except
         Imprime_display('Erro ao restaurar o item', clRed);
         ed_restaura_item.SelectAll;
         Sleep(1000);
         Imprime_display('restaurar item do cupom.', clYellow);

         lb_cancelar_item.Caption := 'ITEM N.�:';
      end;

   end;


   { -----------------------------------------------------------------------------------
      Autor:      Winston Moreira
      Dat:        20/02/2019
      Descri��o:  Se tudo certo, exibe a confirma��o do cancelamento
   ------------------------------------------------------------------------------------- }
   lb_cancelar_item.Caption := 'CONFIRMA?';
end;

procedure TFrRestauraItem.C2Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrRestauraItem.FormShow(Sender: TObject);
begin
   // Posiciona a tela de item no formul�rio
   Self.top  := FrVendas.pn_Principal.Top + 400;
   Self.Left := FrVendas.pn_Principal.Left + 46;
end;

end.
