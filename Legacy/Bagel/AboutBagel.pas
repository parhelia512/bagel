unit AboutBagel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsXPCOM, nsXPCOMGlue,nsError, GeckoBrowser,
  ComCtrls, nsHttp, nsGeckoStrings, nsNetUtil,BagelConst,Version,
  Graphics, ShellAPI;

type
  TAboutBagelForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label1: TLabel;
    Image1: TImage;
    ListView1: TListView;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DrawIcon;
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  AboutBagelForm: TAboutBagelForm;

implementation

{$R *.dfm}

procedure TAboutBagelForm.DrawIcon;
var
  SHFileInfo:TShFileInfo;
  IconHandle:HICON;
  icon:TIcon;
begin
  SHGetFileInfo(
    PChar(Application.ExeName),
    0, SHFileInfo, Sizeof(TSHFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
    SHGFI_ICON or SHGFI_TYPENAME);
  IconHandle := SHFileInfo.hIcon;
  DrawIconEx(
    Image1.Canvas.Handle,
    0,0,
    IconHandle, 32, 32, 0, 0,
    DI_NORMAL);
  DestroyIcon(IconHandle);
end;

procedure TAboutBagelForm.FormShow(Sender: TObject);
var
  item:TListItem;
  list:TStringList;
  i:Integer;
  http:nsIHttpProtocolHandler;
  productSub:nsACString;
  ips:IInterfacedCString;
  tmp:String;
  info: OSVERSIONINFO;
begin

  DrawIcon;

  ListVIew1.Clear;
  tmp:='Bagel作者=plus7'+#13#10;
  tmp:=tmp+'TGeckoBrowser作者=>>74'+#13#10;
  tmp:=tmp+'Contributers=募集中'+#13#10;
  tmp:=tmp+'SpecialThanks=Mozilla.org'+#13#10;
  tmp:=tmp+' =CodeGear'+#13#10;
  tmp:=tmp+' =OpenJane'+#13#10;
  tmp:=tmp+' =github'+#13#10;
  tmp:=tmp+' =ホットゾヌ'+#13#10;
  tmp:=tmp+' =ギコナビ'+#13#10;
  tmp:=tmp+' =Donut,DonutP,unDonut,Donut RAPT'+#13#10;
  tmp:=tmp+' =いまBagelを使っているあなた'+#13#10;

  list:=TStringList.Create;
  list.SetText(PChar(tmp));
  for i:=0 to list.Count-1 do
  begin
    item:=TListItem.Create(ListView1.Items);
    ListView1.Items.AddItem(item);
    item.Caption:=list.Names[i];
    item.SubItems.Add(Copy(list.Strings[i],1+Pos('=',list.Strings[i]),Length(list.Strings[i])-Pos('=',list.Strings[i])) );
  end;

  Label2.Caption:='Bagel ' + version.theVersion.StringVersion;

  Memo1.Clear;

  Memo1.lines.Add('【OS】');

  info.dwOSVersionInfoSize := SizeOf(info);
  GetVersionEx(info);
  if info.dwPlatFormId = VER_PLATFORM_WIN32_NT then
  begin
    Memo1.lines.Add('OS ： Windows NT');
    Memo1.lines.Add('Version ' + IntToStr(info.dwMajorVersion) + '.' + IntToStr(info.dwMinorVersion) + ' ' + info.szCSDVersion);
    Memo1.lines.Add('Build ' + IntToStr(info.dwBuildNumber));
  end
  else if info.dwPlatFormId = VER_PLATFORM_WIN32_WINDOWS then
  begin
    Memo1.lines.Add('OS ： Windows (Win32)');
    Memo1.lines.Add('Version ' + IntToStr(info.dwMajorVersion) + '.' +
       IntToStr(info.dwMinorVersion));
    Memo1.lines.Add('Build ' + IntToStr($FFFF and info.dwBuildNumber));;
  end
  else
    Memo1.lines.Add('OS ： Windowns3.1 + Win32s');

  NS_GetService('@mozilla.org/network/protocol;1?name=http',nsIHttpProtocolHandler,http);

  ips:=NewCString();
  productSub:=ips.ACString;

  Memo1.lines.Add('【Gecko】');

  http.GetUserAgent(productSub);
  Memo1.Lines.Add('ユーザーエージェント ： '+ips.ToString);

  http.GetMisc(productSub);
  Memo1.Lines.Add('リビジョン ： ' +ips.ToString);

  http.GetProductSub(productSub);
  Memo1.Lines.Add('Gecko ： '+ips.ToString);

  http := nil;

  Memo1.lines.Add('【Bagel】');
  Memo1.Lines.Add('バージョン ： '+theVersion.StringVersion);
  Memo1.Lines.Add('ステータス ： '+BAGEL_STATUS);

  Memo1.lines.Add('【常駐ソフト/ファイアウォール等】');
  Memo1.lines.Add('');

end;

procedure TAboutBagelForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=caFree;
end;

end.
