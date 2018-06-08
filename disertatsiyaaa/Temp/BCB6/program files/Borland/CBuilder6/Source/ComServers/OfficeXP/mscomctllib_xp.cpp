// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// C++ TLBWRTR : $Revision:   1.0.1.0.1.2  $
// File generated on 1/29/2002 1:27:44 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINNT\System32\MSCOMCTL.OCX (1)
// LIBID: {831FDD16-0C5C-11D2-A9FC-0000F8754DA1}
// LCID: 0
// Helpfile: C:\WINNT\System32\cmctl198.chm
// HelpString: Microsoft Windows Common Controls 6.0
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v9.0 Access, (c:\program files\microsoft office\office10\msacc.olb)
// Errors:
//   Hint: Symbol 'Controls' renamed to 'Controls_'
// ************************************************************************ //

#include <vcl.h>
#pragma hdrstop

#include "MSComctlLib_XP.h"

#if !defined(__PRAGMA_PACKAGE_SMART_INIT)
#define      __PRAGMA_PACKAGE_SMART_INIT
#pragma package(smart_init)
#endif

namespace Mscomctllib_xp
{


// *********************************************************************//
// GUIDS declared in the TypeLibrary                                      
// *********************************************************************//
const GUID LIBID_MSComctlLib = {0x831FDD16, 0x0C5C, 0x11D2,{ 0xA9, 0xFC, 0x00,0x00, 0xF8, 0x75,0x4D, 0xA1} };
const GUID IID_IVBDataObject = {0x2334D2B1, 0x713E, 0x11CF,{ 0x8A, 0xE5, 0x00,0xAA, 0x00, 0xC0,0x09, 0x05} };
const GUID CLSID_DataObject = {0x2334D2B2, 0x713E, 0x11CF,{ 0x8A, 0xE5, 0x00,0xAA, 0x00, 0xC0,0x09, 0x05} };
const GUID IID_IVBDataObjectFiles = {0x2334D2B3, 0x713E, 0x11CF,{ 0x8A, 0xE5, 0x00,0xAA, 0x00, 0xC0,0x09, 0x05} };
const GUID CLSID_DataObjectFiles = {0x2334D2B4, 0x713E, 0x11CF,{ 0x8A, 0xE5, 0x00,0xAA, 0x00, 0xC0,0x09, 0x05} };
const GUID IID_ITabStrip = {0x1EFB6594, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_ITabStripEvents = {0x1EFB6595, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_TabStrip = {0x1EFB6596, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_ITabs = {0x1EFB6597, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Tabs = {0x1EFB6598, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_ITab = {0x1EFB6599, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Tab = {0x1EFB659A, 0x857C, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IToolbar = {0x66833FE4, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_IToolbarEvents = {0x66833FE5, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Toolbar = {0x66833FE6, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IButtons = {0x66833FE7, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Buttons = {0x66833FE8, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IButton = {0x66833FE9, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Button = {0x66833FEA, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IButtonMenus = {0x66833FEB, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ButtonMenus = {0x66833FEC, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IButtonMenu = {0x66833FED, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ButtonMenu = {0x66833FEE, 0x8583, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IStatusBar = {0x8E3867A1, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_IStatusBarEvents = {0x8E3867A2, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_StatusBar = {0x8E3867A3, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IPanels = {0x8E3867A4, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Panels = {0x8E3867A5, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IPanel = {0x8E3867AA, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Panel = {0x8E3867AB, 0x8586, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IProgressBar = {0x35053A20, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_IProgressBarEvents = {0x35053A21, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ProgressBar = {0x35053A22, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_ITreeView = {0xC74190B4, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_ITreeViewEvents = {0xC74190B5, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_TreeView = {0xC74190B6, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_INodes = {0xC74190B7, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Nodes = {0x0713E8C0, 0x850A, 0x101B,{ 0xAF, 0xC0, 0x42,0x10, 0x10, 0x2A,0x8D, 0xA7} };
const GUID IID_INode = {0xC74190B8, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Node = {0xC74190B9, 0x8589, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IListView = {0xBDD1F049, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_ListViewEvents = {0xBDD1F04A, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListView = {0xBDD1F04B, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IListItems = {0xBDD1F04C, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListItems = {0xBDD1F04D, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IListItem = {0xBDD1F04E, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListItem = {0xBDD1F04F, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IColumnHeaders = {0xBDD1F050, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ColumnHeaders = {0x0713E8C6, 0x850A, 0x101B,{ 0xAF, 0xC0, 0x42,0x10, 0x10, 0x2A,0x8D, 0xA7} };
const GUID IID_IColumnHeader = {0xBDD1F051, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ColumnHeader = {0xBDD1F052, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IListSubItems = {0xBDD1F053, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListSubItems = {0xBDD1F054, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IListSubItem = {0xBDD1F055, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListSubItem = {0xBDD1F056, 0x858B, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IImageList = {0x2C247F21, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_ImageListEvents = {0x2C247F22, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ImageList = {0x2C247F23, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IImages = {0x2C247F24, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListImages = {0x2C247F25, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IImage = {0x2C247F26, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ListImage = {0x2C247F27, 0x8591, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_ISlider = {0xF08DF952, 0x8592, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_ISliderEvents = {0xF08DF953, 0x8592, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Slider = {0xF08DF954, 0x8592, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IControls = {0xC8A3DC00, 0x8593, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_Controls_ = {0xC8A3DC01, 0x8593, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IComboItem = {0xDD9DA660, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ComboItem = {0xDD9DA661, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IComboItems = {0xDD9DA662, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ComboItems = {0xDD9DA663, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID IID_IImageCombo = {0xDD9DA664, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID DIID_DImageComboEvents = {0xDD9DA665, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };
const GUID CLSID_ImageCombo = {0xDD9DA666, 0x8594, 0x11D1,{ 0xB1, 0x6A, 0x00,0xC0, 0xF0, 0x28,0x36, 0x28} };

};     // namespace Mscomctllib_xp
