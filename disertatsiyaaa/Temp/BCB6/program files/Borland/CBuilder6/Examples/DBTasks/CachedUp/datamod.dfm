�
 TCACHEDATA 0�  TPF0
TCacheData	CacheDataLeft� TopwHeight� Width�  TDataSourceCacheDSDataSet
CacheQueryLeftcTop  	TDatabaseCacheDB	AliasNameIBLOCAL	Connected	DatabaseNameCACHEDBLoginPromptParams.StringsUSER NAME=SYSDBAPASSWORD=masterkey SessionNameDefaultTransIsolationtiDirtyReadLeftdTopH  TQuery
CacheQueryActive	CachedUpdates	OnCalcFieldsCacheQueryCalcFieldsOnUpdateErrorUpdateErrorHandlerDatabaseNameCACHEDBRequestLive	SQL.Strings*SELECT PROJECT.PROJ_ID , PROJECT.PROJ_NAMEFROM PROJECT PROJECTORDER BY PROJECT.PROJ_ID UpdateObject	UpdateSQLLeftTopData
6  Ver 2.0,QBE - Integra Visual Database Builder,0, 10, 1600, 1106,,,,,
 , , - Distinct & Quote,,,,,
    1, - Number of Tables,-1, -1, 534, 405, 526, 181,,,,
PROJECT,PROJECT,20, 20, 141, 145,,,,,
    2, - Number of Columns,,,,,,
PROJ_ID,PROJECT,                  65,     , ,,1,
     , - Number of Criteria,,,,,,
PROJ_NAME,PROJECT,                   1,     , ,,,
     , - Number of Criteria,,,,,,
     , - Number of Joins,,,,,,

"SELECT Statement"
,,,,,,,
SELECT	PROJECT.PROJ_ID , PROJECT.PROJ_NAME
FROM	PROJECT PROJECT
ORDER BY
	PROJECT.PROJ_ID,,,,,,,
 TStringFieldCacheQueryPROJ_ID	FieldNamePROJ_IDSize  TStringFieldCacheQueryPROJ_NAME	FieldName	PROJ_NAME  TStringFieldCacheQueryUpdateStatus
Calculated	DisplayWidth	FieldNameUpdateStatus   
TUpdateSQL	UpdateSQLModifySQL.Stringsupdate PROJECTset  PROJ_ID = :PROJ_ID,  PROJ_NAME = :PROJ_NAMEwhere  PROJ_ID = :OLD_PROJ_ID and  PROJ_NAME = :OLD_PROJ_NAME InsertSQL.Stringsinsert into PROJECT  (PROJ_ID, PROJ_NAME)values  (:PROJ_ID, :PROJ_NAME) DeleteSQL.Stringsdelete from PROJECTwhere  PROJ_ID = :OLD_PROJ_ID and  PROJ_NAME = :OLD_PROJ_NAME LeftTopD   