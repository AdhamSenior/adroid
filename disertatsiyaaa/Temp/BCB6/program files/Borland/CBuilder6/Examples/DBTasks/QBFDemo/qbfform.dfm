�
 TQUERYFORM 08  TPF0
TQueryForm	QueryFormLeft� Top� Width�Height�CaptionAd-Hoc Query DemoColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameDefault
Font.Style OldCreateOrderPositionpoScreenCenterOnCreate
FormCreatePixelsPerInchx
TextHeight TBitBtnBitBtn1Left2Top"Width]Height)CaptionE&xitTabOrder KindbkClose  	TGroupBox	GroupBox1Left
TopFWidth$Height5Caption
 Options: TabOrder 	TCheckBox	CheckBox1LeftTopWidth� HeightCaptionShow File &ExtensionsChecked	State	cbCheckedTabOrder   	TCheckBox	CheckBox2Left� TopWidth0HeightCaption&Show &System Tables for Remote AliasesTabOrder   TPageControlPageControl1Left
Top
Width$Height4
ActivePage	TabSheet2TabOrder 	TTabSheet	TabSheet1CaptionExample TLabelLabel5Left
Top� Width&HeightCaption&Value:FocusControlEdit1  TLabelLabel1LeftTopWidthoHeightCaption&Database Aliases:FocusControlListBox1  TLabelLabel2Left� TopWidth.HeightCaption&Tables:FocusControlListBox2  TLabelLabel3LeftfTopWidth(HeightCaption&Fields:FocusControlListBox3  TLabelLabel4LeftTop� Width#HeightCaptionT&ype:FocusControl	ComboBox1  TListBoxListBox1LeftTopWidth� Height� 
ItemHeightSorted	TabOrder OnClickListBox1Click  TListBoxListBox2Left� TopWidth� Height� 
ItemHeightTabOrderOnClickListBox2Click  TListBoxListBox3LeftfTopWidth� Height� 
ItemHeightTabOrder  TEditEdit1Left:Top� WidtheHeightTabOrder  	TComboBox	ComboBox1Left4Top� Width� HeightStylecsDropDownList
ItemHeightTabOrderItems.Strings<No field conditions>equalsis not equal tois less thanis less than or equal tois greater thanis greater than or equal tostarts withdoesn't start with	ends withdoesn't end withcontainsdoesn't containis blankis not blank   TBitBtnBitBtn2Left�Top� WidthoHeight!Caption
&Run QueryTabOrderOnClickBitBtn2Click
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� wwp�wwwwwwx�wwwwwwxwwwwwwx�wwwwwww �wwwwww��wwwwwwwwwww��wwwww  ��wwww��x�wwww��wwww�w��wwwp�  wwwwx���wwwwp���www��x�www  �www���w�www�����ww�ww��wwp��  wwx�w���wwp����wwwx�wx�wwww��wwww�ww�wwww����www�wwx�wwwp���wwwx�����wwp    wwwx����w	NumGlyphs   	TTabSheet	TabSheet2CaptionInformation TMemoMemo1LeftTopWidthHeightTabStopColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style Lines.Strings>This example shows a way to provide users with the ability to define their own queries.   To use the example: *   1)  Choose an alias containing tables, %   2)  Choose a table in that alias, !   3)  Choose a field to search, 3   4)  Pick the type of search you want to perform,#   5)  Enter a value to search for,&   6)  Choose the Show Results button. >If your query returns records, then a Results Viewer displays Cthose results; otherwise, you'll receive a message indicating that no records matched the search. <The Show File Extensions options lets you choose whether or 2not file extensions are displayed for table names. 6The Show System Tables option is used only for remote >aliases and indicates whether or not the system tables should be displayed. 
ParentFontReadOnly	
ScrollBars
ssVerticalTabOrder     TDataSourceDataSource1Left�TopG  TTableTable1Left�TopG   