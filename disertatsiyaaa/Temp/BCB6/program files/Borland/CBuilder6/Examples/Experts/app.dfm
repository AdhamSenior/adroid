�
 TAPPEXPERT 0S  TPF0
TAppExpert	AppExpertLeft� TopHBorderStylebsDialogCaptionApplication WizardClientHeightClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameDefault
Font.Style OldCreateOrderPositionpoScreenCenterOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight 	TPaintBoxSampleLeftTopWidthkHeightHOnPaintSamplePaint  TButton	CancelBtnLeft�Top WidthMHeightCancel	CaptionCancelModalResultTabOrder   TButton
PrevButtonLeftTop WidthMHeightCaption< &BackEnabledTabOrderOnClickNextPrevClick  TButton
NextButtonLeft`Top WidthMHeightCaption&Next >TabOrderOnClickNextPrevClick  TPageControlPageControlLeftsTopWidth�Height� 
ActivePageMenusTabOrderTabStop 	TTabSheetMenusCaptionMenus
TabVisible TLabelLabel1LeftTopWidth�Height-AutoSizeCaptionhYour application can contain a menu bar by checking one or more of the following standard Windows menus:WordWrap	  TLabelLabel2Left Top;WidthPHeightAutoSizeCaption9The file menu contains items such as Open, Save and Exit.  TLabelLabel3Left TopgWidthFHeightAutoSizeCaption6The Edit menu contains Undo, Cut, Copy and Paste items  TLabelLabel4Left Top� WidthOHeightAutoSizeCaption`The Window menu contains window management functions specficially designed for MDI applications.WordWrap	  TLabelLabel5Left Top� WidthbHeight!AutoSizeCaptionhThe Help menu provides access to your application's help file, as well as an item to show the About box.WordWrap	  	TCheckBox
cbFileMenuLeftTop'Width� HeightCaption
&File menuTabOrder OnClickMenuClicked  	TCheckBox
cbEditMenuLeftTopSWidth� HeightCaption
&Edit menuTabOrderOnClickMenuClicked  	TCheckBoxcbWindowMenuLeftTopWidth� HeightCaption&Window menuTabOrderOnClickMenuClicked  	TCheckBox
cbHelpMenuLeftTop� WidthaHeightCaption
&Help menuTabOrderOnClickMenuClicked   	TTabSheet
ExtensionsCaption
Extensions
TabVisible TLabelLabel6LeftTopWidth�Height-AutoSizeCaption�The table below allows you to define the file extensions to be used by the File Open and File Save dialog boxes.  Press Add to create a new entry in the table. Extension entry example:  *.TXT;*.asc;*.DoCFocusControl
ExtListBoxWordWrap	  TPanelPanel1LeftTop4Width9Height� 
BevelOuter	bvLoweredCaptionPanel1TabOrder  THeader	ExtHeaderLeftTopWidth7HeightBorderStylebsNoneFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameDefault
Font.Style 
ParentFontSections.Sections 150 Description 64 Extension TabOrder OnSizedHeaderSized  TListBox
ExtListBoxLeft TopWidth5Height� BorderStylebsNoneCtl3D
ItemHeightParentCtl3DStylelbOwnerDrawFixedTabOrder
OnDrawItemDrawExtension   TButton	AddButtonLeftLTopAWidthAHeightCaption&AddTabOrderOnClickAddClick  TButton
EditButtonLeftLTopaWidthAHeightCaption&EditTabOrderOnClick	EditClick  TButtonDeleteButtonLeftLTop� WidthAHeightCaption&DeleteTabOrderOnClickDeleteClick  TButtonUpButtonLeftLTop� WidthAHeightCaption&UpTabOrderOnClick	MoveClick  TButton
DownButtonLeftLTop� WidthAHeightCaptionD&ownTabOrderOnClick	MoveClick   	TTabSheet	SpeedbtnsCaption	Speedbtns
TabVisible TLabelLabel7LeftTopWidth�Height-AutoSizeCaption�You can create a speedbar for your application by selecting speed buttons from the Available commands list, and pressing Insert to add them to the speedbar.  Press Space to add spacers.WordWrap	  	TPaintBoxSpeedbarLeft	Top3Width�Height+OnMouseDownSpeedMouseDownOnPaintSpeedbarPaint  TLabelLabel8Left
TopfWidth*HeightAutoSizeCaption&Menus:FocusControlMenuList  TLabelLabel9Left� TopfWidthxHeightAutoSizeCaptionAvailable &commands:FocusControlMenuItemList  TListBoxMenuListLeftToprWidthyHeightq
ItemHeightItems.StringsFileEditWindowHelp TabOrder OnClickMenuListClick  TListBoxMenuItemListLeft� TopvWidth� Heightq
ItemHeightStylelbOwnerDrawFixedTabOrder
OnDrawItemDrawMenuItem  TButtonButton1LeftJTopvWidthAHeightCaptionInsertTabOrderOnClickInsertClick  TButtonButton2LeftJTop� WidthAHeightCaptionRemoveTabOrderOnClickRemoveClick  TButtonButton3LeftJTop� WidthAHeightCaptionSpaceTabOrderOnClick
SpaceClick   	TTabSheetAppInfoCaptionAppInfo
TabVisible TLabelLabel13LeftTopPWidthHeightAutoSizeCaption3Enter the &path in which to store this application:FocusControlAppPath  TLabelLabel10LeftTopWidth� HeightAutoSizeCaption.Enter the &name to assign to this application:FocusControlAppName  TLabelLabel15LeftTopWidthYHeightAutoSizeCaption=The Application Wizard is ready to generate your application!  	TGroupBox	GroupBox1LeftTop|WidthmHeight]CaptionOptionsTabOrder  	TCheckBoxcbMDIAppLeftTopWidthHeightCaptionCreate &MDI applicationTabOrder   	TCheckBoxcbStatusLineLeftTop,Width� HeightCaptionCreate a &status lineTabOrder  	TCheckBoxcbHintsLeftTopDWidth� HeightCaptionEnable &hintsTabOrder   TEditAppPathLeftTop`WidthHeightTabOrderTextAppPath  TButton
PathBrowseLeft/Top^WidthQHeightCaption	Browse...TabOrderOnClickBrowseClick  TEditAppNameLeftTop,Width� HeightTabOrderTextAppName     