�
 TFMABOUTBOX 0�	  TPF0TfmAboutBox
fmAboutBoxLeftiTop� ActiveControlMemo1BorderStylebsDialogCaptionAboutClientHeight�ClientWidthyColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameDefault
Font.Style OldCreateOrder	PositionpoScreenCenterPixelsPerInchx
TextHeight TPanelPanel1Left
Top
WidthZHeightF
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabelProductNameLeftlTopWidthsHeightCaptionNavigator Example  TLabelVersionLeftlTop1Width8HeightCaption	Version 1  TImageProgramIconLeft
Top
WidthPHeightFPicture.Data
�  TBitmapv  BMv      v   (                                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �DD�DDDOOODH�����DD�DDODDODH�����DD�DDOOOODH�����DD�DDODDODH�����DD�DDOOOODH�����DD�DDODDODH�����DD�DDOOOODH�����DD���ODDODGwwww�DDODDOOOODGwwww�DDODDODDOD@   w��DODDOOOODH���w��DODDODDO�����w��DODDOOOH����w��DODDODDO����w����DDO�������w����DDH�������w����DDH� �����w����DO�������w����D��������w����O���    ���w���������� ���w���������������w���������������w���������������w���������������w���������������w���������������w���            w��������������w��������������w������������������wwwwwwwwwwwww�Stretch	  TMemoMemo1Left
TopYWidthFHeight� Lines.StringsThis simple example illustrates -     The use of a Data Module )-     Controlling record navigation with )       one DBNavigator for multiple forms/-     Enabling and Disabling Navigational Menu 6       Choices according to the position of a dataset.0-     Using Menu Hotkeys to automatically allow        navigation in TDBFields.3-     The Customer/Orders relationship is protected7        by a Referential Integrity property, preventing.        Customers being deleted with dependent        Orders records.  0The CustOrd form uses the OnEnter events of the -TDBEdit field and the TDBGrid and the Form's ,OnActivate event to reset the DBNavigator's /datasource. In the Customer form, because this 3form has only one control, resetting the navigator -is done only on the form's OnActivate event.  -A simple menu is hooked to the navigator and .individual menu items are enabled or disabled -according to the state of the current datset. ReadOnly	
ScrollBars
ssVerticalTabOrder    TButtonOKButtonLeft� Top^Width^Height!CaptionOKDefault	ModalResultTabOrder   