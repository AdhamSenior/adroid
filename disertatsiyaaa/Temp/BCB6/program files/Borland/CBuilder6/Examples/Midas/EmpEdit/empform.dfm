�
 TEMPLOYEEFORM 0H
  TPF0TEmployeeFormEmployeeFormLeft� Topo
AutoScrollCaptionEmployee AdministratorClientHeight� ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameDefault
Font.Style OldCreateOrder	PixelsPerInch`
TextHeight TLabelLabel1LeftTop=Width2HeightCaption
First NameFocusControl	FirstName  TLabelLabel2Left{Top=Width=HeightAutoSizeCaption	Last NameFocusControlLastName  TLabelLabel3Left� Top>WidthHeightCaptionExtFocusControlPhoneExt  TLabelLabel4LeftTopvWidth-HeightCaption	Hire DateFocusControlHireDate  TLabelLabel5Left{ToptWidthHeightCaptionSalaryFocusControlSalary  TLabelLabel6LeftTopWidth4Height	AlignmenttaRightJustifyCaptionEmp #: Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TDBTextDBText1LeftITopWidthDHeight	DataFieldEmpNo
DataSourceEmpDataFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TDBEdit	FirstNameLeftTopLWidthNHeight	DataField	FirstName
DataSourceEmpDataTabOrder   TDBEditLastNameLeft{TopLWidthcHeight	DataFieldLastName
DataSourceEmpDataTabOrder  TDBEditPhoneExtLeft� TopLWidth1Height	DataFieldPhoneExt
DataSourceEmpDataTabOrder  TDBEditHireDateLeftTop� WidthIHeight	DataFieldHireDate
DataSourceEmpDataTabOrder  TDBEditSalaryLeftyTop� Width`Height	DataFieldSalary
DataSourceEmpDataTabOrder  TButtonQueryButtonLeft@TopHWidthiHeightCaption&Get EmployeesTabOrderOnClickQueryButtonClick  TDBNavigatorDBNavigator1Left� TopWidth� Height
DataSourceEmpDataVisibleButtonsnbFirstnbPriornbNextnbLastnbPostnbCancel TabOrder  TButtonUpdateButtonLeft@TopgWidthiHeightCaption&Update EmployeesTabOrderOnClickUpdateButtonClick  TButton
UndoButtonLeft@Top� WidthiHeightCaptionU&ndo Last ChangeTabOrderOnClickUndoButtonClick  
TStatusBar
StatusBar1Left Top� Width�HeightPanelsWidth^ Width2  SimplePanel  TDataSourceEmpDataDataSet	EmployeesOnDataChangeEmpDataDataChangeLefthTop  TClientDataSet	Employees
Aggregates PacketRecords
Params ProviderNameEmpProviderRemoteServerDCOMConnection1OnReconcileErrorEmployeesReconcileErrorLeftHTop  TDCOMConnectionDCOMConnection1
ServerGUID&{629125E8-A68C-4E6E-8357-DA139070A320}
ServerNameEmpSrvr.EmpServer_BCBLeft�Top   