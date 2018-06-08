//----------------------------------------------------------------------------
//Borland C++Builder
//Copyright (c) 1987, 1998-2002 Borland International Inc. All Rights Reserved.
//----------------------------------------------------------------------------
//---------------------------------------------------------------------------
#ifndef TDump1H
#define TDump1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <Menus.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:	// IDE-managed Components
    TOpenDialog *OpenDlg;
	TMainMenu *MainMenu1;
	TMenuItem *File1;
	TPanel *TopPnl;
	TPopupMenu *PopupMenu1;
	TMenuItem *Find1;
	TSaveDialog *SaveDialog1;
	TMenuItem *Print1;
	TPrintDialog *PrintDialog1;
	TMenuItem *TDumpfile1;
	TMenuItem *TLibfile1;
	TMenuItem *BCC32file1;
	TMenuItem *ILinkfile1;
	TMenuItem *TLinkfile1;
	TMenuItem *Makefile1;
	TMenuItem *Help1;
	TMenuItem *Options1;
	TMenuItem *OutFileMi;
    TPageControl *PageCtl;
	TTabSheet *TDumpTab;
	TLabel *TDlab0;
	TLabel *TDlab1;
	TLabel *TDlab2;
	TLabel *TDlab3;
	TLabel *TDlab4;
	TLabel *TDlab5;
	TLabel *TDlab6;
	TLabel *TDlab7;
	TLabel *TDlab8;
	TLabel *TDlab9;
	TLabel *TDlab10;
	TLabel *TDlab11;
	TLabel *TDlab12;
	TLabel *TDlab13;
	TLabel *TDlab14;
	TLabel *TDlab15;
	TLabel *TDlab16;
	TLabel *TDlab17;
	TLabel *TDlab18;
	TLabel *TDlab19;
	TLabel *TDlab20;
	TLabel *TDlab21;
	TLabel *TDlab22;
	TCheckBox *TDcb0;
	TCheckBox *TDcb1;
	TCheckBox *TDcb2;
	TCheckBox *TDcb3;
	TCheckBox *TDcb4;
	TCheckBox *TDcb5;
	TCheckBox *TDcb6;
	TCheckBox *TDcb7;
	TCheckBox *TDcb8;
	TCheckBox *TDcb9;
	TCheckBox *TDcb10;
	TCheckBox *TDcb11;
	TCheckBox *TDcb12;
	TCheckBox *TDcb13;
	TCheckBox *TDcb14;
	TCheckBox *TDcb15;
	TCheckBox *TDcb16;
	TCheckBox *TDcb17;
	TCheckBox *TDcb18;
	TCheckBox *TDcb19;
	TCheckBox *TDcb20;
	TCheckBox *TDcb21;
	TCheckBox *TDcb22;
	TTabSheet *TLibTab;
	TBevel *Bevel1;
	TCheckBox *TLcb0;
	TCheckBox *TLcb1;
	TCheckBox *TLcb2;
	TCheckBox *TLcb3;
	TCheckBox *TLcb4;
	TCheckBox *TLcb5;
	TCheckBox *TLcb6;
	TCheckBox *TLcb7;
	TCheckBox *TLcb8;
	TCheckBox *TLcb9;
	TTabSheet *ImpDefTab;
	TCheckBox *IDcb0;
	TTabSheet *ImpLibTab;
	TCheckBox *ILcb0;
	TCheckBox *ILcb1;
	TCheckBox *ILcb2;
	TCheckBox *ILcb3;
	TCheckBox *ILcb4;
	TTabSheet *BCC32Tab;
	TTabSheet *ILink32Tab;
	TCheckBox *IKcb1;
	TCheckBox *IKcb0;
	TCheckBox *IKcb2;
	TCheckBox *IKcb3;
	TCheckBox *IKcb4;
	TCheckBox *IKcb5;
	TCheckBox *IKcb6;
	TCheckBox *IKcb7;
	TCheckBox *IKcb8;
	TCheckBox *IKcb10;
	TCheckBox *IKcb11;
	TCheckBox *IKcb12;
	TCheckBox *IKcb13;
	TCheckBox *IKcb14;
	TCheckBox *IKcb15;
	TCheckBox *IKcb16;
	TCheckBox *IKcb17;
	TCheckBox *IKcb18;
	TCheckBox *IKcb19;
	TCheckBox *IKcb20;
	TCheckBox *IKcb21;
	TCheckBox *IKcb22;
	TCheckBox *IKcb23;
	TCheckBox *IKcb24;
	TCheckBox *IKcb25;
	TCheckBox *IKcb26;
	TCheckBox *IKcb27;
	TCheckBox *IKcb28;
	TCheckBox *IKcb29;
	TCheckBox *IKcb30;
	TCheckBox *IKcb31;
	TCheckBox *IKcb32;
	TCheckBox *IKcb33;
	TCheckBox *IKcb34;
	TCheckBox *IKcb35;
	TCheckBox *IKcb36;
	TCheckBox *IKcb37;
	TTabSheet *MakeTab;
	TTabSheet *TDStrp32Tab;
	TTabSheet *BRCC32Tab;
	TTabSheet *GrepTab;
	TMenuItem *ImpDef1;
	TLabel *ILlab0;
	TLabel *ILlab1;
	TLabel *ILlab2;
	TLabel *ILlab3;
	TLabel *ILlab4;
	TLabel *IDlab0;
	TLabel *TLlab0;
	TLabel *TLlab1;
	TLabel *TLlab2;
	TLabel *TLlab3;
	TLabel *TLlab5;
	TLabel *TLlab6;
	TLabel *TLlab7;
	TLabel *TLlab8;
	TLabel *TLlab9;
	TLabel *IKlab0;
	TLabel *IKlab1;
	TLabel *IKlab2;
	TLabel *IKlab3;
	TLabel *IKlab4;
	TLabel *IKlab5;
	TLabel *IKlab6;
	TLabel *IKlab7;
	TLabel *IKlab8;
	TLabel *IKlab10;
	TLabel *IKlab11;
	TLabel *IKlab12;
	TLabel *IKlab13;
	TLabel *IKlab14;
	TLabel *IKlab15;
	TLabel *IKlab16;
	TLabel *IKlab17;
	TLabel *IKlab18;
	TLabel *IKlab19;
	TLabel *IKlab20;
	TLabel *IKlab21;
	TLabel *IKlab22;
	TLabel *IKlab23;
	TLabel *IKlab24;
	TLabel *IKlab25;
	TLabel *IKlab26;
	TLabel *IKlab27;
	TLabel *IKlab28;
	TLabel *IKlab29;
	TLabel *IKlab30;
	TLabel *IKlab31;
	TLabel *IKlab32;
	TLabel *IKlab33;
	TLabel *IKlab34;
	TLabel *IKlab35;
	TLabel *IKlab36;
	TLabel *IKlab37;
	TTabSheet *TabSheet2;
	TLabel *TKlab40;
	TCheckBox *TKcb0;
	TCheckBox *TKcb1;
	TCheckBox *TKcb2;
	TCheckBox *TKcb3;
	TCheckBox *TKcb4;
	TCheckBox *TKcb5;
	TCheckBox *TKcb6;
	TCheckBox *TKcb8;
	TCheckBox *TKcb9;
	TCheckBox *TKcb10;
	TCheckBox *TKcb11;
	TCheckBox *TKcb12;
	TCheckBox *TKcb13;
	TCheckBox *TKcb14;
	TCheckBox *TKcb15;
	TCheckBox *TKcb16;
	TCheckBox *TKcb21;
	TCheckBox *TKcb22;
	TCheckBox *TKcb23;
	TCheckBox *TKcb24;
	TCheckBox *TKcb25;
	TLabel *TKlab0;
	TLabel *TKlab1;
	TLabel *TKlab2;
	TLabel *TKlab3;
	TLabel *TKlab4;
	TLabel *TKlab5;
	TLabel *TKlab6;
	TLabel *TKlab8;
	TLabel *TKlab9;
	TLabel *TKlab10;
	TLabel *TKlab11;
	TLabel *TKlab12;
	TLabel *TKlab13;
	TLabel *TKlab14;
	TLabel *TKlab15;
	TLabel *TKlab16;
	TLabel *TKlab21;
	TLabel *TKlab22;
	TLabel *TKlab23;
	TLabel *TKlab24;
	TLabel *TKlab25;
	TCheckBox *TKcb27;
	TCheckBox *TKcb28;
	TCheckBox *TKcb29;
	TCheckBox *TKcb30;
	TCheckBox *TKcb31;
	TCheckBox *TKcb32;
	TCheckBox *TKcb33;
	TCheckBox *TKcb34;
	TCheckBox *TKcb35;
	TCheckBox *TKcb36;
	TCheckBox *TKcb37;
	TCheckBox *TKcb38;
	TCheckBox *TKcb39;
	TCheckBox *TKcb40;
	TCheckBox *TKcb41;
	TLabel *TKlab27;
	TLabel *TKlab28;
	TLabel *TKlab29;
	TLabel *TKlab30;
	TLabel *TKlab31;
	TLabel *TKlab32;
	TLabel *TKlab33;
	TLabel *TKlab34;
	TLabel *TKlab35;
	TLabel *TKlab36;
	TLabel *TKlab37;
	TLabel *TKlab38;
	TLabel *TKlab39;
	TLabel *TKlab41;
	TCheckBox *TKcb17;
	TLabel *TKlab17;
	TCheckBox *TKcb18;
	TLabel *TKlab18;
	TCheckBox *TKcb19;
	TLabel *TKlab19;
	TCheckBox *TKcb20;
	TLabel *TKlab20;
	TCheckBox *MKcb0;
	TLabel *MKlab0;
	TLabel *MKlab1;
	TCheckBox *MKcb1;
	TCheckBox *MKcb2;
	TCheckBox *MKcb3;
	TCheckBox *MKcb4;
	TCheckBox *MKcb5;
	TCheckBox *MKcb6;
	TCheckBox *MKcb7;
	TCheckBox *MKcb8;
	TCheckBox *MKcb9;
	TCheckBox *MKcb10;
	TCheckBox *MKcb11;
	TCheckBox *MKcb12;
	TCheckBox *MKcb13;
	TCheckBox *MKcb14;
	TCheckBox *MKcb15;
	TCheckBox *MKcb16;
	TCheckBox *MKcb17;
	TCheckBox *MKcb18;
	TCheckBox *MKcb19;
	TLabel *MKlab19;
	TLabel *MKlab18;
	TLabel *MKlab17;
	TLabel *MKlab16;
	TLabel *MKlab15;
	TLabel *MKlab14;
	TLabel *MKlab13;
	TLabel *MKlab12;
	TLabel *MKlab11;
	TLabel *MKlab10;
	TLabel *MKlab9;
	TLabel *MKlab8;
	TLabel *MKlab7;
	TLabel *MKlab6;
	TLabel *MKlab5;
	TLabel *MKlab4;
	TLabel *MKlab3;
	TLabel *MKlab2;
	TTabSheet *Cpp32Tab;
	TTabSheet *TouchTab;
	TMenuItem *SetWorkingDir1;
	TLabel *Label6;
	TLabel *Label7;
	TLabel *Label8;
	TLabel *Label9;
	TMenuItem *N2;
	TMenuItem *Close1;
	TMenuItem *Closeall1;
	TMenuItem *SaveAs2;
	TMenuItem *Save2;
	TMenuItem *N4;
	TCheckBox *BRcb0;
	TLabel *BRlab0;
	TCheckBox *BRcb1;
	TCheckBox *BRcb3;
	TCheckBox *BRcb4;
	TCheckBox *BRcb5;
	TCheckBox *BRcb6;
	TCheckBox *BRcb7;
	TCheckBox *BRcb8;
	TCheckBox *BRcb9;
	TCheckBox *BRcb10;
	TCheckBox *BRcb11;
	TCheckBox *BRcb14;
	TLabel *BRlab14;
	TLabel *BRlab11;
	TLabel *BRlab10;
	TLabel *BRlab9;
	TLabel *BRlab8;
	TLabel *BRlab7;
	TLabel *BRlab6;
	TLabel *BRlab5;
	TLabel *BRlab4;
	TLabel *BRlab3;
	TLabel *BRlab1;
	TMenuItem *BRCC321;
	TCheckBox *CPcb0;
	TCheckBox *CPcb1;
	TCheckBox *CPcb2;
	TCheckBox *CPcb3;
	TCheckBox *CPcb4;
	TCheckBox *CPcb5;
	TCheckBox *CPcb6;
	TCheckBox *CPcb7;
	TCheckBox *CPcb8;
	TLabel *CBlab8;
	TLabel *CBlab7;
	TLabel *CBlab6;
	TLabel *CBlab5;
	TLabel *CBlab4;
	TLabel *CBlab3;
	TLabel *CBlab2;
	TLabel *CBlab1;
	TLabel *CBlab0;
	TMenuItem *CPP321;
	TMenuItem *TDStrp321;
	TMenuItem *Grep1;
	TMenuItem *Touch1;
	TCheckBox *DScb0;
	TLabel *DSlab0;
	TCheckBox *TCcb0;
	TCheckBox *TCcb2;
	TCheckBox *TCcb4;
	TCheckBox *TCcb5;
	TCheckBox *TCcb6;
	TCheckBox *TCcb1;
	TLabel *TClab0;
	TLabel *TClab2;
	TLabel *TClab4;
	TLabel *TClab5;
	TLabel *TClab6;
	TLabel *TClab1;
	TLabel *Label15;
	TCheckBox *TCcb3;
	TLabel *TClab3;
	TCheckBox *TCcb7;
	TLabel *TClab7;
	TLabel *TClab8;
	TCheckBox *TCcb8;
	TCheckBox *GPcb0;
	TCheckBox *GPcb1;
	TCheckBox *GPcb2;
	TCheckBox *GPcb3;
	TCheckBox *GPcb4;
	TCheckBox *GPcb5;
	TCheckBox *GPcb6;
	TCheckBox *GPcb7;
	TCheckBox *GPcb8;
	TCheckBox *GPcb9;
	TCheckBox *GPcb10;
	TLabel *GPlab0;
	TLabel *GPlab1;
	TLabel *GPlab2;
	TLabel *GPlab3;
	TLabel *GPlab4;
	TLabel *GPlab5;
	TLabel *GPlab6;
	TLabel *GPlab7;
	TLabel *GPlab8;
	TLabel *GPlab9;
	TLabel *GPlab10;
	TMenuItem *About1;
	TMenuItem *OpenAtCursor;
	TMenuItem *File2;
	TMenuItem *Browse1;
	TMenuItem *Save3;
	TMenuItem *SaveAs3;
	TMenuItem *Exit1;
	TMenuItem *Open2;
	TMenuItem *N3;
	TMenuItem *Open3;
	TMenuItem *Find2;
	TFindDialog *FindDialog1;
	TMenuItem *FindNext1;
	TMenuItem *FindNext2;
	TMenuItem *ToolDescription1;
	TMenuItem *BCC321;
	TMenuItem *ImpLib2;
	TMenuItem *ImpDef2;
	TMenuItem *TLib1;
	TMenuItem *ILink321;
	TMenuItem *TLink321;
	TMenuItem *Make1;
	TMenuItem *BRCC322;
	TMenuItem *CPP322;
	TMenuItem *TDStrp322;
	TMenuItem *Grep2;
	TMenuItem *Touch2;
	TMenuItem *N1;
    TRichEdit *CmdStrRE;
	TLabel *TLlab10;
	TCheckBox *TLcb10;
	TLabel *Label4;
	TLabel *Label20;
	TMenuItem *New1;
	TCheckBox *CPcb9;
	TCheckBox *CPcb10;
	TCheckBox *CPcb11;
	TCheckBox *CPcb12;
	TCheckBox *CPcb13;
	TCheckBox *CPcb14;
	TCheckBox *CPcb15;
	TCheckBox *CPcb16;
	TLabel *CBlab16;
	TLabel *CBlab15;
	TLabel *CBlab14;
	TLabel *CBlab13;
	TLabel *CBlab12;
	TLabel *CBlab11;
	TLabel *CBlab10;
	TLabel *CBlab9;
	TLabel *TLlab4;
	TButton *Button1;
	TButton *Button2;
	TButton *Button3;
	TButton *Button4;
	TButton *Button5;
	TButton *Button6;
	TButton *Button7;
	TLabel *Label21;
	TLabel *Label22;
	TLabel *Label23;
	TLabel *Label24;
	TLabel *Label25;
	TLabel *Label26;
	TLabel *Label27;
	TMenuItem *Print2;
   TTabSheet *CoffTab;
   TTabSheet *ConvertTab;
   TTabSheet *Tasm32;
   TTabSheet *TLibImp;
   TTabSheet *TRegSvr;
   TSpeedButton *RunBtn;
    TSpeedButton *BackBtn;
   TSpeedButton *ClearBtn;
   TSpeedButton *BrowseBtn;
    TPanel *BCCPnl2;
    TPanel *BCCPnl3;
    TButton *PrevBtn;
    TCheckBox *BCcb34;
    TCheckBox *BCcb35;
    TCheckBox *BCcb89;
    TCheckBox *BCcb90;
    TCheckBox *BCcb36;
    TCheckBox *BCcb91;
    TCheckBox *BCcb92;
    TCheckBox *BCcb93;
    TCheckBox *BCcb94;
    TCheckBox *BCcb95;
    TCheckBox *BCcb37;
    TCheckBox *BCcb38;
    TCheckBox *BCcb39;
    TCheckBox *BCcb96;
    TCheckBox *BCcb40;
    TCheckBox *BCcb97;
    TCheckBox *BCcb98;
    TCheckBox *BCcb41;
    TCheckBox *BCcb42;
    TLabel *BClab42;
    TLabel *BClab41;
    TLabel *BClab98;
    TLabel *BClab97;
    TLabel *BClab40;
    TLabel *BClab96;
    TLabel *BClab39;
    TLabel *BClab38;
    TLabel *BClab37;
    TLabel *BClab95;
    TLabel *BClab94;
    TLabel *BClab93;
    TLabel *BClab92;
    TLabel *BClab91;
    TLabel *BClab36;
    TLabel *BClab90;
    TLabel *BClab89;
    TLabel *BClab35;
    TLabel *BClab34;
    TCheckBox *BCcb99;
    TCheckBox *BCcb100;
    TCheckBox *BCcb101;
    TCheckBox *BCcb102;
    TCheckBox *BCcb103;
    TCheckBox *BCcb104;
    TCheckBox *BCcb43;
    TCheckBox *BCcb105;
    TCheckBox *BCcb106;
    TCheckBox *BCcb44;
    TCheckBox *BCcb45;
    TCheckBox *BCcb46;
    TCheckBox *BCcb107;
    TCheckBox *BCcb108;
    TLabel *BClab108;
    TLabel *BClab107;
    TLabel *BClab46;
    TLabel *BClab45;
    TLabel *BClab44;
    TLabel *BClab106;
    TLabel *BClab105;
    TLabel *BClab104;
    TLabel *BClab43;
    TLabel *BClab103;
    TLabel *BClab102;
    TLabel *BClab101;
    TLabel *BClab100;
    TLabel *BClab99;
    TButton *Button8;
    TCheckBox *BCcb19;
    TCheckBox *BCcb20;
    TCheckBox *BCcb21;
    TCheckBox *BCcb66;
    TCheckBox *BCcb22;
    TCheckBox *BCcb23;
    TCheckBox *BCcb67;
    TCheckBox *BCcb69;
    TCheckBox *BCcb68;
    TCheckBox *BCcb70;
    TCheckBox *BCcb24;
    TCheckBox *BCcb71;
    TCheckBox *BCcb72;
    TCheckBox *BCcb73;
    TCheckBox *BCcb25;
    TCheckBox *BCcb26;
    TCheckBox *BCcb74;
    TCheckBox *BCcb75;
    TCheckBox *BCcb27;
    TLabel *BClab19;
    TLabel *BClab20;
    TLabel *BClab21;
    TLabel *BClab66;
    TLabel *BClab22;
    TLabel *BClab23;
    TLabel *BClab67;
    TLabel *BClab68;
    TLabel *BClab69;
    TLabel *BClab70;
    TLabel *BClab24;
    TLabel *BClab71;
    TLabel *BClab72;
    TLabel *BClab73;
    TLabel *BClab25;
    TLabel *BClab26;
    TLabel *BClab74;
    TLabel *BClab75;
    TLabel *BClab27;
    TCheckBox *BCcb76;
    TCheckBox *BCcb77;
    TCheckBox *BCcb28;
    TCheckBox *BCcb29;
    TCheckBox *BCcb30;
    TCheckBox *BCcb78;
    TCheckBox *BCcb79;
    TCheckBox *BCcb31;
    TCheckBox *BCcb32;
    TCheckBox *BCcb82;
    TCheckBox *BCcb80;
    TCheckBox *BCcb81;
    TCheckBox *BCcb83;
    TCheckBox *BCcb84;
    TCheckBox *BCcb33;
    TCheckBox *BCcb85;
    TCheckBox *BCcb86;
    TCheckBox *BCcb87;
    TCheckBox *BCcb88;
    TLabel *BClab76;
    TLabel *BClab77;
    TLabel *BClab28;
    TLabel *BClab29;
    TLabel *BClab30;
    TLabel *BClab78;
    TLabel *BClab79;
    TLabel *BClab31;
    TLabel *BClab32;
    TLabel *BClab82;
    TLabel *BClab80;
    TLabel *BClab81;
    TLabel *BClab83;
    TLabel *BClab84;
    TLabel *BClab33;
    TLabel *BClab85;
    TLabel *BClab86;
    TLabel *BClab87;
    TLabel *BClab88;
    TButton *Button10;
    TButton *Button11;
    TPanel *BCCPnl1;
    TCheckBox *BCcb47;
    TCheckBox *BCcb0;
    TCheckBox *BCcb1;
    TCheckBox *BCcb2;
    TCheckBox *BCcb3;
    TCheckBox *BCcb48;
    TCheckBox *BCcb4;
    TCheckBox *BCcb5;
    TCheckBox *BCcb49;
    TCheckBox *BCcb6;
    TCheckBox *BCcb7;
    TCheckBox *BCcb8;
    TCheckBox *BCcb9;
    TCheckBox *BCcb10;
    TCheckBox *BCcb50;
    TCheckBox *BCcb11;
    TCheckBox *BCcb12;
    TCheckBox *BCcb51;
    TCheckBox *BCcb52;
    TLabel *BClab47;
    TLabel *BClab0;
    TLabel *BClab1;
    TLabel *BClab2;
    TLabel *BClab3;
    TLabel *BClab48;
    TLabel *BClab4;
    TLabel *BClab5;
    TLabel *BClab49;
    TLabel *BClab6;
    TLabel *BClab7;
    TLabel *BClab8;
    TLabel *BClab9;
    TLabel *BClab10;
    TLabel *BClab50;
    TLabel *BClab11;
    TLabel *BClab12;
    TLabel *BClab51;
    TLabel *BClab52;
    TCheckBox *BCcb13;
    TCheckBox *BCcb14;
    TCheckBox *BCcb15;
    TCheckBox *BCcb53;
    TCheckBox *BCcb54;
    TCheckBox *BCcb16;
    TCheckBox *BCcb55;
    TCheckBox *BCcb17;
    TCheckBox *BCcb56;
    TCheckBox *BCcb57;
    TCheckBox *BCcb58;
    TCheckBox *BCcb59;
    TCheckBox *BCcb60;
    TCheckBox *BCcb61;
    TCheckBox *BCcb62;
    TCheckBox *BCcb63;
    TCheckBox *BCcb64;
    TCheckBox *BCcb65;
    TCheckBox *BCcb18;
    TLabel *BClab13;
    TLabel *BClab14;
    TLabel *BClab15;
    TLabel *BClab53;
    TLabel *BClab54;
    TLabel *BClab16;
    TLabel *BClab55;
    TLabel *BClab17;
    TLabel *BClab56;
    TLabel *BClab57;
    TLabel *BClab58;
    TLabel *BClab59;
    TLabel *BClab60;
    TLabel *BClab61;
    TLabel *BClab62;
    TLabel *BClab63;
    TLabel *BClab64;
    TLabel *BClab65;
    TLabel *BClab18;
    TButton *Button9;
    TLabel *Label1;
    TPanel *ResultPnl;
    TPageControl *PageCtl2;
    TTabSheet *ResultsTab;
    TRichEdit *ResultsRE;
    TMenuItem *N5;
    TMenuItem *ViewResults1;
    TMenuItem *RevisePath1;
    TLabel *CFlab2;
    TLabel *CFlab1;
    TLabel *CFlab0;
    TCheckBox *CFcb0;
    TCheckBox *CFcb1;
    TCheckBox *CFcb2;
    TLabel *Label2;
    TMemo *Memo1;
    TLabel *TPlab0;
    TLabel *TPlab1;
    TLabel *TPlab2;
    TLabel *TPlab3;
    TCheckBox *TPcb0;
    TCheckBox *TPcb1;
    TCheckBox *TPcb2;
    TCheckBox *TPcb3;
    TCheckBox *TPcb4;
    TCheckBox *TPcb5;
    TCheckBox *TPcb6;
    TCheckBox *TPcb7;
    TCheckBox *TPcb8;
    TCheckBox *TPcb9;
    TLabel *TPlab4;
    TLabel *TPlab5;
    TLabel *TPlab6;
    TLabel *TPlab7;
    TLabel *TPlab8;
    TLabel *TPlab9;
    TLabel *Label19;
    TCheckBox *TScb0;
    TCheckBox *TScb1;
    TCheckBox *TScb2;
    TCheckBox *TScb3;
    TCheckBox *TScb4;
    TCheckBox *TScb5;
    TCheckBox *TScb6;
    TCheckBox *TScb7;
    TCheckBox *TScb8;
    TCheckBox *TScb9;
    TCheckBox *TScb10;
    TCheckBox *TScb11;
    TCheckBox *TScb12;
    TCheckBox *TScb13;
    TCheckBox *TScb14;
    TCheckBox *TScb15;
    TCheckBox *TScb16;
    TCheckBox *TScb17;
    TCheckBox *TScb18;
    TLabel *TSlab0;
    TLabel *TSlab1;
    TLabel *TSlab2;
    TLabel *TSlab3;
    TLabel *TSlab4;
    TLabel *TSlab5;
    TLabel *TSlab6;
    TLabel *TSlab7;
    TLabel *TSlab8;
    TLabel *TSlab9;
    TLabel *TSlab10;
    TLabel *TSlab11;
    TLabel *TSlab12;
    TLabel *TSlab13;
    TLabel *TSlab14;
    TLabel *TSlab15;
    TLabel *TSlab16;
    TLabel *TSlab17;
    TLabel *TSlab18;
    TCheckBox *TScb19;
    TCheckBox *TScb20;
    TCheckBox *TScb21;
    TCheckBox *TScb22;
    TCheckBox *TScb23;
    TCheckBox *TScb24;
    TCheckBox *TScb25;
    TCheckBox *TScb26;
    TCheckBox *TScb27;
    TCheckBox *TScb28;
    TCheckBox *TScb29;
    TCheckBox *TScb30;
    TCheckBox *TScb31;
    TCheckBox *TScb32;
    TCheckBox *TScb33;
    TCheckBox *TScb34;
    TCheckBox *TScb35;
    TCheckBox *TScb36;
    TLabel *TSlab36;
    TLabel *TSlab35;
    TLabel *TSlab34;
    TLabel *TSlab33;
    TLabel *TSlab32;
    TLabel *TSlab31;
    TLabel *TSlab30;
    TLabel *TSlab29;
    TLabel *TSlab28;
    TLabel *TSlab27;
    TLabel *TSlab26;
    TLabel *TSlab25;
    TLabel *TSlab24;
    TLabel *TSlab23;
    TLabel *TSlab22;
    TLabel *TSlab21;
    TLabel *TSlab20;
    TLabel *TSlab19;
    TCheckBox *TRcb0;
    TCheckBox *TRcb1;
    TCheckBox *TRcb2;
    TLabel *TRlab2;
    TLabel *TRlab1;
    TLabel *TRlab0;
    TMenuItem *Coff2omf1;
    TMenuItem *Convert1;
    TMenuItem *Tasm321;
    TMenuItem *TLibImp1;
    TMenuItem *TRegSvr1;
    TLabel *Label3;
    TLabel *Label5;
    TLabel *Label10;
	void __fastcall RunBtnClick(TObject *Sender);
	void __fastcall ToolsPg(TObject *Sender);
	void __fastcall FindDialog1Find(TObject *Sender);
	void __fastcall Print1Click(TObject *Sender);
	void __fastcall ToolsMi(TObject *Sender);
	void __fastcall BackBtnClick(TObject *Sender);
	void __fastcall AdvBtnClick(TObject *Sender);
	void __fastcall Toolcbs(TObject *Sender);
	void __fastcall LabToCB(TObject *Sender);
	void __fastcall OpenClick(TObject *Sender);
	void __fastcall ResultsREKeyPress(TObject *Sender, char &Key);
	void __fastcall SetWorkingDir1Click(TObject *Sender);
	void __fastcall CloseActive(TObject *Sender);
	void __fastcall Closeall1Click(TObject *Sender);
	void __fastcall Save2Click(TObject *Sender);
	void __fastcall SaveAs2Click(TObject *Sender);
	void __fastcall GrepMi(TObject *Sender);
	void __fastcall About1Click(TObject *Sender);
	void __fastcall ClearClick(TObject *Sender);
	void __fastcall OpenAtCursorClick(TObject *Sender);
	void __fastcall BrowseMi(TObject *Sender);
	void __fastcall Find2Click(TObject *Sender);
	void __fastcall Exit1Click(TObject *Sender);
	void __fastcall OutFileMiClick(TObject *Sender);
	void __fastcall ToolHelpMi(TObject *Sender);
	void __fastcall New1Click(TObject *Sender);
	void __fastcall Operations(TObject *Sender);
	void __fastcall SymbolBtn(TObject *Sender);
    void __fastcall Button10Click(TObject *Sender);
    void __fastcall Button8Click(TObject *Sender);
    void __fastcall Button11Click(TObject *Sender);
    void __fastcall ViewResults(TObject *Sender);
    void __fastcall RevisePath1Click(TObject *Sender);
    
    
    
    
    void __fastcall CmdStrREMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
    void __fastcall PageCtlMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
    void __fastcall ResultPnlMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
private:	// User declarations
    bool Tasm;
    bool TlbImp;
    bool TRegAX;
    bool Convert;
    bool Coff;
    bool TDump;
    bool TLib;
    bool ImpDef;
    bool ImpLib;
    bool BCC32;
    bool ILink32;
    bool TLink32;
    bool Make;
    bool BRCC32;
    bool CPP32;
    bool TDStrp32;
    bool Grep;
    bool Touch;
    bool SourceFileSelected;
    bool Clear;
    bool IsDirty;
    int FileNameLen;
    long PosFound;

    String FilterStr;
    String AppCaption;
    String BCBRoot;
    String LibOps;
    String WintoolsDir;
    String DefExt;
    String OptionString;
    String SourceFileDir;
    String StripExt;
    String ODFileName;
    String NewDestEdit;
    String NewSourceEdit;
    String WorkDir;
    String SourceEd;
    String DestEd;
    String BinPth;
    String LibPth;
    String IncPth;
    String ObjPth;
    TObject *DummySender;
    TStringList *ObjList;

   void PrepareCmdLine();
   void ResetTools();  
   void __fastcall ClearCtls();
   void SetupTool(String Caption);
   void GetRegInfo();
   void CreateNewPage(String TabName, String LoadFile);
   int GetFileSize(String SFile);
   int HandleOpenDlgs(String FilterStr);
   bool IsWindowsNT();
   void SetEnvPath();
   String StripFileExt(String FileName);

public:		// User declarations
	__fastcall TMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif
 