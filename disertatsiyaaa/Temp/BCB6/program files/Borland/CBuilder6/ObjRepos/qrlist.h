//----------------------------------------------------------------------------
#ifndef QRListH
#define QRListH
//----------------------------------------------------------------------------
#include <vcl\ExtCtrls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Quickrpt.hpp>
#include <vcl\Dialogs.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Controls.hpp>
#include <vcl\Graphics.hpp>
#include <vcl\Classes.hpp>
#include <vcl\SysUtils.hpp>
#include <vcl\Messages.hpp>
#include <vcl\Windows.hpp>
#include <vcl\System.hpp>
//----------------------------------------------------------------------------
class TQRListForm : public TForm
{
__published:
        TQuickRep *QuickRep1;
	TTable *MasterTable;
	TQRBand *DetailBand1;
	TQRBand *PageFooterBand1;
	TQRBand *TitleBand1;
	TQRBand *ColumnHeaderBand1;
	TQRSysData *QRSysData1;
	TQRLabel *QRLabel1;
	TQRLabel *QRLabel2;
	TQRSysData *QRSysData2;
private:
public:
	virtual __fastcall TQRListForm(TComponent* AOwner);
};
//----------------------------------------------------------------------------
extern PACKAGE TQRListForm *QRListForm;
//----------------------------------------------------------------------------
#endif    
