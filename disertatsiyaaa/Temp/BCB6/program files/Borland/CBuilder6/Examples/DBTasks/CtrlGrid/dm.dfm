�
 TDM1 0�  TPF0TDM1DM1Left\Top�Height� WidthB TTable	tblMasterActive	DatabaseNameBCDEMOS	IndexNameSYMBOL	TableName
MASTER.DBFLeftTop TStringFieldtblMasterSYMBOL	AlignmenttaCenterDisplayLabelSymbolDisplayWidth	FieldNameSYMBOLSize  TStringFieldtblMasterCO_NAMEDisplayLabelCompanyDisplayWidth	FieldNameCO_NAME  TStringFieldtblMasterEXCHANGEDisplayLabelExchangeDisplayWidth	FieldNameEXCHANGESize  TStringFieldtblMasterIndustryLongName	AlignmenttaCenterDisplayLabelIndustryDisplayWidth	FieldNameIndustryLongNameLookup	LookupDataSettblIndustryLookupKeyFieldsIND_CODELookupResultField	LONG_NAME	KeyFieldsINDUSTRYSize   TFloatFieldtblMasterCUR_PRICEDisplayLabelCurrent PriceDisplayWidth
	FieldName	CUR_PRICEDisplayFormat
$ #,###.00
EditFormat#,###.00  TFloatFieldtblMasterYRL_HIGHDisplayLabelYr. HighDisplayWidth
	FieldNameYRL_HIGHDisplayFormat
$ #,###.00
EditFormat#,###.00  TFloatFieldtblMasterYRL_LOWDisplayLabelYr. LowDisplayWidth
	FieldNameYRL_LOWDisplayFormat
$ #,###.00
EditFormat#,###.00  TFloatFieldtblMasterP_E_RATIO	AlignmenttaCenterDisplayLabel	P/E RatioDisplayWidth
	FieldName	P_E_RATIO  TFloatFieldtblMasterPROJ_GRTH	AlignmenttaCenterDisplayLabelProj. GrowthDisplayWidth
	FieldName	PROJ_GRTHDisplayFormat###%
EditFormat###  TSmallintFieldtblMasterINDUSTRY	AlignmenttaCenterDisplayLabelIndustryDisplayWidth
	FieldNameINDUSTRYVisible  TSmallintFieldtblMasterPRICE_CHG	AlignmenttaCenterDisplayLabelPrice ChangeDisplayWidth
	FieldName	PRICE_CHGDisplayFormat###%
EditFormat###  TStringFieldtblMasterRATING	AlignmenttaCenterDisplayLabelRatingDisplayWidth	FieldNameRATINGSize  TFloatFieldtblMasterRANK	AlignmenttaCenterDisplayLabelRankDisplayWidth	FieldNameRANK  TSmallintFieldtblMasterOUTLOOK	AlignmenttaCenterDisplayLabelOutlookDisplayWidth	FieldNameOUTLOOK  TStringFieldtblMasterRCMNDATION	AlignmenttaCenterDisplayLabelRecc.DisplayWidth	FieldName
RCMNDATIONSize  TStringFieldtblMasterRISK	AlignmenttaCenterDisplayLabelRiskDisplayWidth	FieldNameRISKSize   TDataSourcedsMasterDataSet	tblMasterLeftLTop  TTabletblIndustryActive	DatabaseNameBCDEMOS	IndexNameIND_CODEMasterFieldsINDUSTRY	TableNameINDUSTRY.DBFLeft� Top TSmallintFieldtblIndustryIND_CODE	FieldNameIND_CODEVisible  TStringFieldtblIndustryIND_NAME	FieldNameIND_NAMESize  TStringFieldtblIndustryLONG_NAME	FieldName	LONG_NAME   TDataSource
dsIndustryDataSettblIndustryLeft� Top  TTabletblHoldingsActive		AfterOpentblHoldingsAfterOpen	AfterPosttblHoldingsAfterPostOnCalcFieldstblHoldingsCalcFieldsDatabaseNameBCDEMOS	IndexNameSYMBOLMasterFieldsSYMBOLMasterSourcedsMaster	TableNameHOLDINGS.DBFLeft$TopL TFloatFieldtblHoldingsACCT_NBRDisplayLabelAccount No.	FieldNameACCT_NBR  TFloatFieldtblHoldingsSHARESDisplayLabelShares	FieldNameSHARESDisplayFormat###,###,###
EditFormat###,###,###  TFloatFieldtblHoldingsPUR_PRICEDisplayLabelPurchase Price	FieldName	PUR_PRICEDisplayFormat
$ #,###.00
EditFormat#,###.00  
TDateFieldtblHoldingsPUR_DATEDisplayLabelPurchase Date	FieldNamePUR_DATEDisplayFormatmmm. dd, yyyy  TStringFieldtblHoldingsSYMBOL	FieldNameSYMBOLVisibleSize  TCurrencyFieldtblHoldingsPUR_COST
Calculated		FieldNamePUR_COST   TDataSource
dsHoldingsDataSettblHoldingsLeft`TopL   