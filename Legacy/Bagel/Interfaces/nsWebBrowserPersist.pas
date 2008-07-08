unit nsWebBrowserPersist;

interface

uses
  nsTypes,nsXPCOM,nsGeckoStrings;

const
  NS_ICANCELABLE_IID: TGUID = '{d94ac0a0-bb18-46b8-844e-84159064b0bd}';

  NS_IWEBBROWSERPERSIST_IID: TGUID = '{dd4e0a6a-210f-419a-ad85-40e8543b9465}';
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_NONE = 0;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_FROM_CACHE = 1;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_BYPASS_CACHE = 2;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_IGNORE_REDIRECTED_DATA = 4;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_IGNORE_IFRAMES = 8;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_NO_CONVERSION = 16;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_REPLACE_EXISTING_FILES = 32;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_NO_BASE_TAG_MODIFICATIONS = 64;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_FIXUP_ORIGINAL_DOM = 128;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_FIXUP_LINKS_TO_DESTINATION = 256;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_DONT_FIXUP_LINKS = 512;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_SERIALIZE_OUTPUT = 1024;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_DONT_CHANGE_FILENAMES = 2048;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_FAIL_ON_BROKEN_LINKS = 4096;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_CLEANUP_ON_FAILURE = 8192;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_AUTODETECT_APPLY_CONVERSION = 16384;
  NS_IWEBBROWSERPERSIST_PERSIST_FLAGS_APPEND_TO_FILE = 32768;
  NS_IWEBBROWSERPERSIST_PERSIST_STATE_READY = 1;
  NS_IWEBBROWSERPERSIST_PERSIST_STATE_SAVING = 2;
  NS_IWEBBROWSERPERSIST_PERSIST_STATE_FINISHED = 3;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_SELECTION_ONLY = 1;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_FORMATTED = 2;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_RAW = 4;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_BODY_ONLY = 8;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_PREFORMATTED = 16;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_WRAP = 32;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_FORMAT_FLOWED = 64;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_ABSOLUTE_LINKS = 128;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_ENCODE_W3C_ENTITIES = 256;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_CR_LINEBREAKS = 512;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_LF_LINEBREAKS = 1024;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_NOSCRIPT_CONTENT = 2048;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_NOFRAMES_CONTENT = 4096;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_ENCODE_BASIC_ENTITIES = 8192;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_ENCODE_LATIN1_ENTITIES = 16384;
  NS_IWEBBROWSERPERSIST_ENCODE_FLAGS_ENCODE_HTML_ENTITIES = 32768;

type
  nsICancelable = interface;
  nsIWebBrowserPersist = interface;
  nsICancelable = interface(nsISupports)
  ['{d94ac0a0-bb18-46b8-844e-84159064b0bd}']
    procedure Cancel(aReason: nsresult); safecall;
  end;

  nsIWebBrowserPersist = interface(nsICancelable)
  ['{dd4e0a6a-210f-419a-ad85-40e8543b9465}']
    function GetPersistFlags(): PRUint32; safecall;
    procedure SetPersistFlags(aPersistFlags: PRUint32); safecall;
    property PersistFlags: PRUint32 read GetPersistFlags write SetPersistFlags;
    function GetCurrentState(): PRUint32; safecall;
    property CurrentState: PRUint32 read GetCurrentState;
    function GetResult(): PRUint32; safecall;
    property _Result: PRUint32 read GetResult;
    function GetProgressListener(): nsIWebProgressListener; safecall;
    procedure SetProgressListener(aProgressListener: nsIWebProgressListener); safecall;
    property ProgressListener: nsIWebProgressListener read GetProgressListener write SetProgressListener;
    procedure SaveURI(aURI: nsIURI; aCacheKey: nsISupports; aReferrer: nsIURI; aPostData: nsIInputStream; const aExtraHeaders: PAnsiChar; aFile: nsISupports); safecall;
    procedure SaveChannel(aChannel: nsIChannel; aFile: nsISupports); safecall;
    procedure SaveDocument(aDocument: nsIDOMDocument; aFile: nsISupports; aDataPath: nsISupports; const aOutputContentType: PAnsiChar; aEncodingFlags: PRUint32; aWrapColumn: PRUint32); safecall;
    procedure CancelSave(); safecall;
  end;

implementation

end.
