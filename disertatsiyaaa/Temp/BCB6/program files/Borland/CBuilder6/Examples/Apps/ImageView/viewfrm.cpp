//----------------------------------------------------------------------------
//Borland C++Builder
//Copyright (c) 1987, 1998-2002 Borland International Inc. All Rights Reserved.
//----------------------------------------------------------------------------
//---------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ViewFrm.h"
//---------------------------------------------------------------------
#pragma resource "*.dfm"
TViewFrm *ViewFrm;
//---------------------------------------------------------------------
__fastcall TViewFrm::TViewFrm(TComponent *Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------
