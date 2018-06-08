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

// C++ TLBWRTR : $Revision:   1.151.1.0.1.21  $
// File generated on 1/28/2002 7:55:54 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Common Files\Microsoft Shared\DAO\DAO350.DLL (1)
// LIBID: {00025E01-0000-0000-C000-000000000046}
// LCID: 0
// Helpfile: C:\Program Files\Common Files\Microsoft Shared\DAO\dao35.hlp
// HelpString: Microsoft DAO 3.5 Object Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v8.0 Access, (c:\program files\microsoft office\office\msacc8.olb)
// Errors:
//   Hint: Symbol 'EOF' renamed to 'EOF_'
// ************************************************************************ //

#include <vcl.h>
#pragma hdrstop

#include "DAO_97.h"

#if !defined(__PRAGMA_PACKAGE_SMART_INIT)
#define      __PRAGMA_PACKAGE_SMART_INIT
#pragma package(smart_init)
#endif

namespace Dao_97
{


// *********************************************************************//
// GUIDS declared in the TypeLibrary                                      
// *********************************************************************//
const GUID LIBID_DAO = {0x00025E01, 0x0000, 0x0000,{ 0xC0, 0x00, 0x00,0x00, 0x00, 0x00,0x00, 0x46} };
const GUID IID__Collection = {0x000000A0, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__DynaCollection = {0x000000A2, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__DAO = {0x0000000A, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__DBEngine = {0x00000021, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_DBEngine = {0x00000010, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_PrivDBEngine = {0x00000011, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Error = {0x00000023, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Errors = {0x00000025, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Workspace = {0x00000039, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Workspaces = {0x0000003B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__TableDef = {0x00000049, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_TableDefs = {0x0000004B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_TableDef = {0x00000013, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Database = {0x00000071, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Databases = {0x00000073, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__QueryDef = {0x00000079, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_QueryDefs = {0x0000007B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_QueryDef = {0x00000018, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Recordset = {0x00000031, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Recordsets = {0x00000033, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__Field = {0x00000051, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_Field = {0x00000014, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Fields = {0x00000053, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__Index = {0x00000059, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_Index = {0x00000015, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Indexes = {0x0000005B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_IndexFields = {0x0000005D, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Parameter = {0x00000081, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Parameters = {0x00000083, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__User = {0x00000069, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_User = {0x00000017, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Users = {0x0000006B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__Group = {0x00000061, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_Group = {0x00000016, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Groups = {0x00000063, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID__Relation = {0x00000089, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID CLSID_Relation = {0x00000019, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Relations = {0x0000008B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Property = {0x00000027, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Properties = {0x00000029, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Container = {0x00000091, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Containers = {0x00000093, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Document = {0x00000099, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Documents = {0x0000009B, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Connection = {0x00000041, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };
const GUID IID_Connections = {0x00000043, 0x0000, 0x0010,{ 0x80, 0x00, 0x00,0xAA, 0x00, 0x6D,0x2E, 0xA4} };

};     // namespace Dao_97
