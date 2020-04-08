unit UntPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.ListBox, FMX.Edit, FMX.Objects, System.IOUtils, FMX.Gestures,
  System.Actions, FMX.ActnList, FMX.MediaLibrary.Actions, FMX.StdActns;

type
  TfrmPrincipal = class(TForm)
    tbctrlPrincipal: TTabControl;
    tbItemListagem: TTabItem;
    tbItemDetalhe: TTabItem;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    btnVoltar: TButton;
    Label1: TLabel;
    btnAdicionar: TButton;
    lblTitulo: TLabel;
    lsviewContatos: TListView;
    fdConexao: TFDConnection;
    QryContatos: TFDQuery;
    QryContatosNOME: TStringField;
    QryContatosSOBRENOME: TStringField;
    QryContatosCELULAR: TStringField;
    QryContatosTELEFONE: TStringField;
    QryContatosEMAIL: TStringField;
    QryContatosFOTO: TBlobField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Layout1: TLayout;
    Layout2: TLayout;
    edtNome: TEdit;
    edtSobrenome: TEdit;
    edtCelular: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    imgFoto: TImage;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkPropertyToFieldBitmap: TLinkPropertyToField;
    btnSalvar: TButton;
    btnEdicao: TButton;
    btnCancelar: TButton;
    lsboxPopUp: TListBox;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Button1: TButton;
    Button2: TButton;
    ListBoxItem7: TListBoxItem;
    Button3: TButton;
    btnFoto: TButton;
    ActionList1: TActionList;
    actBiblioteca: TTakePhotoFromLibraryAction;
    actCamera: TTakePhotoFromCameraAction;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEdicaoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure lsviewContatosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Button3Click(Sender: TObject);
    procedure btnFotoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure actBibliotecaDidFinishTaking(Image: TBitmap);
    procedure actCameraDidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtivarDesativarBotoes;
    procedure MostrarOcularPopUp(Acao: Boolean);
    procedure MostrarCamera;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TfrmPrincipal.actBibliotecaDidFinishTaking(Image: TBitmap);
begin
  imgFoto.Bitmap.Assign(Image);
  QryContatosFOTO.Assign(Image);
end;

procedure TfrmPrincipal.actCameraDidFinishTaking(Image: TBitmap);
begin
  imgFoto.Bitmap.Assign(Image);
  QryContatosFOTO.Assign(Image);
end;

procedure TfrmPrincipal.AtivarDesativarBotoes;
begin
  if QryContatos.State in [dsEdit, dsInsert] then
    begin
      btnSalvar.Visible   := True;
      btnCancelar.Visible := True;
      btnVoltar.Visible   := False;
      btnEdicao.Visible   := False;
      btnFoto.Enabled     := True;

      edtNome.Enabled       := True;
      edtSobrenome.Enabled  := True;
      edtCelular.Enabled    := True;
      edtTelefone.Enabled   := True;
      edtEmail.Enabled      := True;
    end
    else
      begin
        btnSalvar.Visible   := False;
        btnCancelar.Visible := False;
        btnVoltar.Visible   := True;
        btnEdicao.Visible   := True;
        btnFoto.Enabled     := False;

        edtNome.Enabled       := False;
        edtSobrenome.Enabled  := False;
        edtCelular.Enabled    := False;
        edtTelefone.Enabled   := False;
        edtEmail.Enabled      := False;
      end;
end;

procedure TfrmPrincipal.btnAdicionarClick(Sender: TObject);
begin
  QryContatos.Append;
  tbctrlPrincipal.Next();

  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
  MostrarCamera;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  QryContatos.Cancel;
  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
  MostrarCamera;
end;

procedure TfrmPrincipal.btnEdicaoClick(Sender: TObject);
begin
  QryContatos.Edit;
  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
  MostrarCamera;
end;

procedure TfrmPrincipal.btnFotoClick(Sender: TObject);
begin
  MostrarOcularPopUp(True);
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  QryContatos.Post;
  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
  MostrarCamera;
end;

procedure TfrmPrincipal.btnVoltarClick(Sender: TObject);
begin
    tbctrlPrincipal.Previous();
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  MostrarOcularPopUp(False);
  actBiblioteca.ExecuteTarget(Sender);
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  MostrarOcularPopUp(False);
  actCamera.ExecuteTarget(Sender);
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  MostrarOcularPopUp(False);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryContatos.Active := False;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tbctrlPrincipal.ActiveTab := tbItemListagem;
  tbctrlPrincipal.TabPosition := TTabPosition.None; // Oculta o TabControl em tempo de execu��o

  {COMPILANDO PARA IOS}
  {$IFDEF IOS}
    btnSalvar.Width := 70;
    btnCancelar.Width := 70;
  {$ENDIF}

  {COMPILANDO PARA ANDROID}
  {$IFDEF ANDROID}
    btnSalvar.Width := 50;
    btnCancelar.Width := 50;
  {$ENDIF}

  {Definindo caminho do banco de dados para cada plataforma}
  {$IFDEF MSWINDOWS}
    fdConexao.Params.Values['Databasese'] :=
      'C:\Users\sidne\OneDrive - Fatec Centro Paula Souza\Desenvolvimento\Aplicativo Delphi\Banco de Dados\CONTATOS.IB';
    fdConexao.Params.Values['Protocol'] := 'TCPIP';
  {$ELSE}
    fdConexao.Params.Values['Databasese'] := TPath.Combine(TPath.GetDocumentsPath, 'CONTATOS.IB');
    fdConexao.Params.Values['Protocol'] := 'Local';
  {$ENDIF}

  QryContatos.Active := True;

  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
  MostrarCamera;
end;

procedure TfrmPrincipal.lsviewContatosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  tbctrlPrincipal.Next();
  MostrarCamera;
  AtivarDesativarBotoes;
  MostrarOcularPopUp(False);
end;

procedure TfrmPrincipal.MostrarCamera;
begin
  if QryContatosFOTO.IsNull then
    begin
      btnFoto.Visible := True;
      btnFoto.Enabled := True;
    end
    else
      begin
        btnFoto.Visible := False;
        btnFoto.Enabled := False;
      end;
end;

procedure TfrmPrincipal.MostrarOcularPopUp(Acao: Boolean);
begin
  lsboxPopUp.Visible := Acao;
end;

end.
