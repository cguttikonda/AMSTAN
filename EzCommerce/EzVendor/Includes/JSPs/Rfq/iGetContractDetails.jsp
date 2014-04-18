<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: Satyanarayana.S
		Team:   EzcSuite
		Date:   03/10/2005
*****************************************************************************************--%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%	
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();

	String contractNo = request.getParameter("contractNo");
	int POsToConCnt = 0;
	int ConItemsCnt = 0;
	
	ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPOHeaderParams headerParams = new ezc.ezpreprocurement.params.EziPOHeaderParams();
	headerParams.setPONo(contractNo);
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(headerParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve myRet=(ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetContractDetails(mainParams);
	
	ezc.ezparam.ReturnObjFromRetrieve ConHeader = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_HEADER");
	ezc.ezparam.ReturnObjFromRetrieve ConAddr   = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ADDR");
	ezc.ezparam.ReturnObjFromRetrieve ConItems  = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ITEMS");
	ezc.ezparam.ReturnObjFromRetrieve POsToCon  = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADO");
	ezc.ezparam.ReturnObjFromRetrieve OpenQty   = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADOS");
	
	if(POsToCon!=null)
		POsToConCnt = POsToCon.getRowCount();
		
	if(ConItems!=null)
		ConItemsCnt = ConItems.getRowCount();
	
%>



<%--
 --------------- Row 0 ---------------------
05/09/23 09:38:18 0 :: 0 Field Name : PO_HEADER ----> Field Value : ezc.ezparam.ReturnObjFromRetrieve@1ddfed5
05/09/23 09:38:18 0 :: 1 Field Name : PO_ADDR ----> Field Value : ezc.ezparam.ReturnObjFromRetrieve@1856351
05/09/23 09:38:18 0 :: 2 Field Name : PO_ITEMS ----> Field Value : ezc.ezparam.ReturnObjFromRetrieve@3b971e
05/09/23 09:38:18 0 :: 3 Field Name : XADO ----> Field Value : ezc.ezparam.ReturnObjFromRetrieve@3e36cb
05/09/23 09:38:18 0 :: 4 Field Name : XADOS ----> Field Value : ezc.ezparam.ReturnObjFromRetrieve@7f498c
05/09/23 09:38:18 
 --------------- End Of Row 0 --------------
05/09/23 09:38:18  In EzcString Row Count is 1
05/09/23 09:38:18 
 --------------- Row 0 ---------------------
05/09/23 09:38:18 0 :: 0 Field Name : PO_NUMBER ----> Field Value : 5200000008
05/09/23 09:38:18 0 :: 1 Field Name : CO_CODE ----> Field Value : 1000
05/09/23 09:38:18 0 :: 2 Field Name : DOC_CAT ----> Field Value : K
05/09/23 09:38:18 0 :: 3 Field Name : DOC_TYPE ----> Field Value : MK
05/09/23 09:38:18 0 :: 4 Field Name : CREATED_ON ----> Field Value : Fri Sep 16 00:00:00 IST 2005
05/09/23 09:38:18 0 :: 5 Field Name : CREATED_BY ----> Field Value : EZCOM
05/09/23 09:38:18 0 :: 6 Field Name : ITEM_INTVL ----> Field Value : 00001
05/09/23 09:38:18 0 :: 7 Field Name : LAST_ITEM ----> Field Value : 00002
05/09/23 09:38:18 0 :: 8 Field Name : VENDOR ----> Field Value : ALKALIMET
05/09/23 09:38:18 0 :: 9 Field Name : LANGUAGE ----> Field Value : E
05/09/23 09:38:18 0 :: 10 Field Name : PMNTTRMS ----> Field Value : 
05/09/23 09:38:18 0 :: 11 Field Name : DSCNT1_TO ----> Field Value : 0
05/09/23 09:38:18 0 :: 12 Field Name : DSCNT2_TO ----> Field Value : 0
05/09/23 09:38:18 0 :: 13 Field Name : DSCNT3_TO ----> Field Value : 0
05/09/23 09:38:18 0 :: 14 Field Name : CASH_DISC1 ----> Field Value : 0
05/09/23 09:38:18 0 :: 15 Field Name : CASH_DISC2 ----> Field Value : 0
05/09/23 09:38:18 0 :: 16 Field Name : PURCH_ORG ----> Field Value : MDOM
05/09/23 09:38:18 0 :: 17 Field Name : PUR_GROUP ----> Field Value : 103
05/09/23 09:38:18 0 :: 18 Field Name : CURRENCY ----> Field Value : INR
05/09/23 09:38:18 0 :: 19 Field Name : EXCH_RATE ----> Field Value : 1.00000
05/09/23 09:38:18 0 :: 20 Field Name : DOC_DATE ----> Field Value : Fri Sep 16 00:00:00 IST 2005
05/09/23 09:38:18 0 :: 21 Field Name : VPER_START ----> Field Value : Fri Sep 16 00:00:00 IST 2005
05/09/23 09:38:18 0 :: 22 Field Name : VPER_END ----> Field Value : Sun Oct 30 00:00:00 IST 2005
05/09/23 09:38:18 0 :: 23 Field Name : TELEPHONE ----> Field Value : 
05/09/23 09:38:18 0 :: 24 Field Name : INCOTERMS1 ----> Field Value : 
05/09/23 09:38:18 0 :: 25 Field Name : INCOTERMS2 ----> Field Value : 
05/09/23 09:38:18 0 :: 26 Field Name : TARGET_VAL ----> Field Value : 0
05/09/23 09:38:18 0 :: 27 Field Name : PROCEDURE ----> Field Value : ZLOCL2
05/09/23 09:38:18 0 :: 28 Field Name : UPDATE_GRP ----> Field Value : SAP
05/09/23 09:38:18 0 :: 29 Field Name : SUBITEMINT ----> Field Value : 00001
05/09/23 09:38:18 0 :: 30 Field Name : MAST_COND ----> Field Value : X
05/09/23 09:38:18 0 :: 31 Field Name : REL_GROUP ----> Field Value : 01
05/09/23 09:38:18 0 :: 32 Field Name : REL_STRAT ----> Field Value : 01
05/09/23 09:38:18 0 :: 33 Field Name : REL_IND ----> Field Value : 1
05/09/23 09:38:18 0 :: 34 Field Name : REL_STATUS ----> Field Value : X
05/09/23 09:38:18 0 :: 35 Field Name : VEND_NAME ----> Field Value : ALKALI METALS LTD
05/09/23 09:38:18 0 :: 36 Field Name : CURRENCY_ISO ----> Field Value : INR
05/09/23 09:38:18 0 :: 37 Field Name : EXCH_RATE_CM ----> Field Value : 0
05/09/23 09:38:18 
 --------------- End Of Row 0 --------------
05/09/23 09:38:18  In EzcString Row Count is 1
05/09/23 09:38:18 
 --------------- Row 0 ---------------------
05/09/23 09:38:18 0 :: 0 Field Name : ADDRNUMBER ----> Field Value : 0000022165
05/09/23 09:38:18 0 :: 1 Field Name : DATE ----> Field Value : Sat Jan 01 00:00:00 IST 0001
05/09/23 09:38:19 0 :: 2 Field Name : DATE_FROM ----> Field Value : Sat Jan 01 00:00:00 IST 0001
05/09/23 09:38:19 0 :: 3 Field Name : DATE_TO ----> Field Value : Fri Dec 31 00:00:00 IST 9999
05/09/23 09:38:19 0 :: 4 Field Name : TITLE ----> Field Value : 0003
05/09/23 09:38:19 0 :: 5 Field Name : NAME1 ----> Field Value : ALKALI METALS LTD
05/09/23 09:38:19 0 :: 6 Field Name : CITY1 ----> Field Value :                MUMBAI
05/09/23 09:38:19 0 :: 7 Field Name : CITY2 ----> Field Value :                               IN
05/09/23 09:38:19 0 :: 8 Field Name : STREET ----> Field Value : 1-8-23/VIKHROLI
05/09/23 09:38:19 0 :: 9 Field Name : COUNTRY ----> Field Value : IN
05/09/23 09:38:19 0 :: 10 Field Name : LANGU ----> Field Value : E
05/09/23 09:38:19 0 :: 11 Field Name : SORT1 ----> Field Value : CHEMICAL
05/09/23 09:38:19 0 :: 12 Field Name : TIME_ZONE ----> Field Value : INDIA
05/09/23 09:38:19 
 --------------- End Of Row 0 --------------
05/09/23 09:38:19  In EzcString Row Count is 2
05/09/23 09:38:19 
 --------------- Row 0 ---------------------
05/09/23 09:38:19 0 :: 0 Field Name : PO_NUMBER ----> Field Value : 5200000008
05/09/23 09:38:19 0 :: 1 Field Name : PO_ITEM ----> Field Value : 00001
05/09/23 09:38:19 0 :: 2 Field Name : CHANGED_ON ----> Field Value : Fri Sep 16 00:00:00 IST 2005
05/09/23 09:38:19 0 :: 3 Field Name : SHORT_TEXT ----> Field Value : NORFLOXACIN-ESTER
05/09/23 09:38:19 0 :: 4 Field Name : MATERIAL ----> Field Value : 000000000000000301
05/09/23 09:38:19 0 :: 5 Field Name : PUR_MAT ----> Field Value : 000000000000000301
05/09/23 09:38:19 0 :: 6 Field Name : CO_CODE ----> Field Value : 1000
05/09/23 09:38:19 0 :: 7 Field Name : PLANT ----> Field Value : 1010
05/09/23 09:38:19 0 :: 8 Field Name : MAT_GRP ----> Field Value : 102
05/09/23 09:38:19 0 :: 9 Field Name : INFO_REC ----> Field Value : 5300001080
05/09/23 09:38:19 0 :: 10 Field Name : TARGET_QTY ----> Field Value : 10.000
05/09/23 09:38:19 0 :: 11 Field Name : QUANTITY ----> Field Value : 0
05/09/23 09:38:19 0 :: 12 Field Name : UNIT ----> Field Value : KG
05/09/23 09:38:19 0 :: 13 Field Name : ORDERPR_UN ----> Field Value : KG
05/09/23 09:38:19 0 :: 14 Field Name : NET_PRICE ----> Field Value : 1.0000
05/09/23 09:38:19 0 :: 15 Field Name : PRICE_UNIT ----> Field Value : 1
05/09/23 09:38:19 0 :: 16 Field Name : NET_VALUE ----> Field Value : 0
05/09/23 09:38:19 0 :: 17 Field Name : GROS_VALUE ----> Field Value : 10.0000
05/09/23 09:38:19 0 :: 18 Field Name : BASE_UNIT ----> Field Value : KG
05/09/23 09:38:19 0 :: 19 Field Name : OUTL_TARGV ----> Field Value : 10.0000
05/09/23 09:38:19 0 :: 20 Field Name : RELORD_QTY ----> Field Value : 100.000
05/09/23 09:38:19 0 :: 21 Field Name : PRICE_DATE ----> Field Value : Fri Dec 31 00:00:00 IST 9999
05/09/23 09:38:19 0 :: 22 Field Name : DOC_CAT ----> Field Value : K
05/09/23 09:38:19 0 :: 23 Field Name : EFF_VALUE ----> Field Value : 10.0000
05/09/23 09:38:19 0 :: 24 Field Name : UPDATE_GRP ----> Field Value : SAP
05/09/23 09:38:19 0 :: 25 Field Name : WEIGHTUNIT ----> Field Value : KG
05/09/23 09:38:19 
 --------------- End Of Row 0 --------------
05/09/23 09:38:19 
 --------------- Row 1 ---------------------
05/09/23 09:38:19 1 :: 0 Field Name : PO_NUMBER ----> Field Value : 5200000008
05/09/23 09:38:19 1 :: 1 Field Name : PO_ITEM ----> Field Value : 00002
05/09/23 09:38:19 1 :: 2 Field Name : CHANGED_ON ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 1 :: 3 Field Name : SHORT_TEXT ----> Field Value : ABSOLUTE ALCOHOL
05/09/23 09:38:19 1 :: 4 Field Name : MATERIAL ----> Field Value : 000000000021000000
05/09/23 09:38:19 1 :: 5 Field Name : PUR_MAT ----> Field Value : 000000000021000000
05/09/23 09:38:19 1 :: 6 Field Name : CO_CODE ----> Field Value : 1000
05/09/23 09:38:19 1 :: 7 Field Name : PLANT ----> Field Value : 1010
05/09/23 09:38:19 1 :: 8 Field Name : MAT_GRP ----> Field Value : 102
05/09/23 09:38:19 1 :: 9 Field Name : INFO_REC ----> Field Value : 
05/09/23 09:38:19 1 :: 10 Field Name : TARGET_QTY ----> Field Value : 1000.000
05/09/23 09:38:19 1 :: 11 Field Name : QUANTITY ----> Field Value : 0
05/09/23 09:38:19 1 :: 12 Field Name : UNIT ----> Field Value : KG
05/09/23 09:38:19 1 :: 13 Field Name : ORDERPR_UN ----> Field Value : KG
05/09/23 09:38:19 1 :: 14 Field Name : NET_PRICE ----> Field Value : 10.0000
05/09/23 09:38:19 1 :: 15 Field Name : PRICE_UNIT ----> Field Value : 1
05/09/23 09:38:19 1 :: 16 Field Name : NET_VALUE ----> Field Value : 0
05/09/23 09:38:19 1 :: 17 Field Name : GROS_VALUE ----> Field Value : 10000.0000
05/09/23 09:38:19 1 :: 18 Field Name : BASE_UNIT ----> Field Value : KG
05/09/23 09:38:19 1 :: 19 Field Name : OUTL_TARGV ----> Field Value : 10000.0000
05/09/23 09:38:19 1 :: 20 Field Name : RELORD_QTY ----> Field Value : 1.000
05/09/23 09:38:19 1 :: 21 Field Name : PRICE_DATE ----> Field Value : Fri Dec 31 00:00:00 IST 9999
05/09/23 09:38:19 1 :: 22 Field Name : DOC_CAT ----> Field Value : K
05/09/23 09:38:19 1 :: 23 Field Name : EFF_VALUE ----> Field Value : 10000.0000
05/09/23 09:38:19 1 :: 24 Field Name : UPDATE_GRP ----> Field Value : SAP
05/09/23 09:38:19 1 :: 25 Field Name : WEIGHTUNIT ----> Field Value : KG
05/09/23 09:38:19 
 --------------- End Of Row 1 --------------
05/09/23 09:38:19  In EzcString Row Count is 5
05/09/23 09:38:19 
 --------------- Row 0 ---------------------
05/09/23 09:38:19 0 :: 0 Field Name : MANDT ----> Field Value : 150
05/09/23 09:38:19 0 :: 1 Field Name : KONNR ----> Field Value : 5200000008
05/09/23 09:38:19 0 :: 2 Field Name : KTPNR ----> Field Value : 00001
05/09/23 09:38:19 0 :: 3 Field Name : EBELN ----> Field Value : 4500000443
05/09/23 09:38:19 0 :: 4 Field Name : EBELP ----> Field Value : 00010
05/09/23 09:38:19 0 :: 5 Field Name : BEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 0 :: 6 Field Name : MENGE ----> Field Value : 2.000
05/09/23 09:38:19 0 :: 7 Field Name : MEINS ----> Field Value : KG
05/09/23 09:38:19 0 :: 8 Field Name : NETWR ----> Field Value : 2.00
05/09/23 09:38:19 0 :: 9 Field Name : WAERS ----> Field Value : INR
05/09/23 09:38:19 0 :: 10 Field Name : WKURS ----> Field Value : 1.00000
05/09/23 09:38:19 0 :: 11 Field Name : BUKRS ----> Field Value : 1000
05/09/23 09:38:19 0 :: 12 Field Name : WERKS ----> Field Value : 1010
05/09/23 09:38:19 0 :: 13 Field Name : EKORG ----> Field Value : MDOM
05/09/23 09:38:19 0 :: 14 Field Name : AEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 0 :: 15 Field Name : BSTYP ----> Field Value : F
05/09/23 09:38:19 0 :: 16 Field Name : NETWF ----> Field Value : 2.00
05/09/23 09:38:19 
 --------------- End Of Row 0 --------------
05/09/23 09:38:19 
 --------------- Row 1 ---------------------
05/09/23 09:38:19 1 :: 0 Field Name : MANDT ----> Field Value : 150
05/09/23 09:38:19 1 :: 1 Field Name : KONNR ----> Field Value : 5200000008
05/09/23 09:38:19 1 :: 2 Field Name : KTPNR ----> Field Value : 00001
05/09/23 09:38:19 1 :: 3 Field Name : EBELN ----> Field Value : 4500000444
05/09/23 09:38:19 1 :: 4 Field Name : EBELP ----> Field Value : 00010
05/09/23 09:38:19 1 :: 5 Field Name : BEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 1 :: 6 Field Name : MENGE ----> Field Value : 4.000
05/09/23 09:38:19 1 :: 7 Field Name : MEINS ----> Field Value : KG
05/09/23 09:38:19 1 :: 8 Field Name : NETWR ----> Field Value : 4.00
05/09/23 09:38:19 1 :: 9 Field Name : WAERS ----> Field Value : INR
05/09/23 09:38:19 1 :: 10 Field Name : WKURS ----> Field Value : 1.00000
05/09/23 09:38:19 1 :: 11 Field Name : BUKRS ----> Field Value : 1000
05/09/23 09:38:19 1 :: 12 Field Name : WERKS ----> Field Value : 1010
05/09/23 09:38:19 1 :: 13 Field Name : EKORG ----> Field Value : MDOM
05/09/23 09:38:19 1 :: 14 Field Name : AEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 1 :: 15 Field Name : BSTYP ----> Field Value : F
05/09/23 09:38:19 1 :: 16 Field Name : NETWF ----> Field Value : 4.00
05/09/23 09:38:19 
 --------------- End Of Row 1 --------------
05/09/23 09:38:19 
 --------------- Row 2 ---------------------
05/09/23 09:38:19 2 :: 0 Field Name : MANDT ----> Field Value : 150
05/09/23 09:38:19 2 :: 1 Field Name : KONNR ----> Field Value : 5200000008
05/09/23 09:38:19 2 :: 2 Field Name : KTPNR ----> Field Value : 00002
05/09/23 09:38:19 2 :: 3 Field Name : EBELN ----> Field Value : 4500000443
05/09/23 09:38:19 2 :: 4 Field Name : EBELP ----> Field Value : 00020
05/09/23 09:38:19 2 :: 5 Field Name : BEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 2 :: 6 Field Name : MENGE ----> Field Value : 70.000
05/09/23 09:38:19 2 :: 7 Field Name : MEINS ----> Field Value : KG
05/09/23 09:38:19 2 :: 8 Field Name : NETWR ----> Field Value : 700.00
05/09/23 09:38:19 2 :: 9 Field Name : WAERS ----> Field Value : INR
05/09/23 09:38:19 2 :: 10 Field Name : WKURS ----> Field Value : 1.00000
05/09/23 09:38:19 2 :: 11 Field Name : BUKRS ----> Field Value : 1000
05/09/23 09:38:19 2 :: 12 Field Name : WERKS ----> Field Value : 1010
05/09/23 09:38:19 2 :: 13 Field Name : EKORG ----> Field Value : MDOM
05/09/23 09:38:19 2 :: 14 Field Name : AEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 2 :: 15 Field Name : BSTYP ----> Field Value : F
05/09/23 09:38:19 2 :: 16 Field Name : NETWF ----> Field Value : 700.00
05/09/23 09:38:19 
 --------------- End Of Row 2 --------------
05/09/23 09:38:19 
 --------------- Row 3 ---------------------
05/09/23 09:38:19 3 :: 0 Field Name : MANDT ----> Field Value : 150
05/09/23 09:38:19 3 :: 1 Field Name : KONNR ----> Field Value : 5200000008
05/09/23 09:38:19 3 :: 2 Field Name : KTPNR ----> Field Value : 00002
05/09/23 09:38:19 3 :: 3 Field Name : EBELN ----> Field Value : 4500000444
05/09/23 09:38:19 3 :: 4 Field Name : EBELP ----> Field Value : 00020
05/09/23 09:38:19 3 :: 5 Field Name : BEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 3 :: 6 Field Name : MENGE ----> Field Value : 28.000
05/09/23 09:38:19 3 :: 7 Field Name : MEINS ----> Field Value : KG
05/09/23 09:38:19 3 :: 8 Field Name : NETWR ----> Field Value : 280.00
05/09/23 09:38:19 3 :: 9 Field Name : WAERS ----> Field Value : INR
05/09/23 09:38:19 3 :: 10 Field Name : WKURS ----> Field Value : 1.00000
05/09/23 09:38:19 3 :: 11 Field Name : BUKRS ----> Field Value : 1000
05/09/23 09:38:19 3 :: 12 Field Name : WERKS ----> Field Value : 1010
05/09/23 09:38:19 3 :: 13 Field Name : EKORG ----> Field Value : MDOM
05/09/23 09:38:19 3 :: 14 Field Name : AEDAT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 3 :: 15 Field Name : BSTYP ----> Field Value : F
05/09/23 09:38:19 3 :: 16 Field Name : NETWF ----> Field Value : 280.00
05/09/23 09:38:19 
 --------------- End Of Row 3 --------------
05/09/23 09:38:19 
 --------------- Row 4 ---------------------
05/09/23 09:38:19 4 :: 0 Field Name : MANDT ----> Field Value : 150
05/09/23 09:38:19 4 :: 1 Field Name : KONNR ----> Field Value : 5200000008
05/09/23 09:38:19 4 :: 2 Field Name : KTPNR ----> Field Value : 00002
05/09/23 09:38:19 4 :: 3 Field Name : EBELN ----> Field Value : 4500000452
05/09/23 09:38:19 4 :: 4 Field Name : EBELP ----> Field Value : 00010
05/09/23 09:38:19 4 :: 5 Field Name : BEDAT ----> Field Value : Thu Sep 22 00:00:00 IST 2005
05/09/23 09:38:19 4 :: 6 Field Name : MENGE ----> Field Value : 28.000
05/09/23 09:38:19 4 :: 7 Field Name : MEINS ----> Field Value : KG
05/09/23 09:38:19 4 :: 8 Field Name : NETWR ----> Field Value : 280.00
05/09/23 09:38:19 4 :: 9 Field Name : WAERS ----> Field Value : INR
05/09/23 09:38:19 4 :: 10 Field Name : WKURS ----> Field Value : 1.00000
05/09/23 09:38:19 4 :: 11 Field Name : BUKRS ----> Field Value : 1000
05/09/23 09:38:19 4 :: 12 Field Name : WERKS ----> Field Value : 1010
05/09/23 09:38:19 4 :: 13 Field Name : EKORG ----> Field Value : MDOM
05/09/23 09:38:19 4 :: 14 Field Name : AEDAT ----> Field Value : Thu Sep 22 00:00:00 IST 2005
05/09/23 09:38:19 4 :: 15 Field Name : BSTYP ----> Field Value : F
05/09/23 09:38:19 4 :: 16 Field Name : NETWF ----> Field Value : 280.00
05/09/23 09:38:19 
 --------------- End Of Row 4 --------------
05/09/23 09:38:19  In EzcString Row Count is 2
05/09/23 09:38:19 
 --------------- Row 0 ---------------------
05/09/23 09:38:19 0 :: 0 Field Name : KTPNR ----> Field Value : 00001
05/09/23 09:38:19 0 :: 1 Field Name : MENGE ----> Field Value : 6.000
05/09/23 09:38:19 0 :: 2 Field Name : NETWR ----> Field Value : 6.00
05/09/23 09:38:19 0 :: 3 Field Name : LVGDT ----> Field Value : Tue Sep 20 00:00:00 IST 2005
05/09/23 09:38:19 0 :: 4 Field Name : MGOWR ----> Field Value : 0
05/09/23 09:38:19 0 :: 5 Field Name : MGOWR_TXT ----> Field Value : 
05/09/23 09:38:19 
 --------------- End Of Row 0 --------------
05/09/23 09:38:19 
 --------------- Row 1 ---------------------
05/09/23 09:38:19 1 :: 0 Field Name : KTPNR ----> Field Value : 00002
05/09/23 09:38:19 1 :: 1 Field Name : MENGE ----> Field Value : 126.000
05/09/23 09:38:19 1 :: 2 Field Name : NETWR ----> Field Value : 1260.00
05/09/23 09:38:19 1 :: 3 Field Name : LVGDT ----> Field Value : Thu Sep 22 00:00:00 IST 2005
05/09/23 09:38:19 1 :: 4 Field Name : MGOWR ----> Field Value : 0
05/09/23 09:38:19 1 :: 5 Field Name : MGOWR_TXT ----> Field Value : 
05/09/23 09:38:19 
--------------- End Of Row 1 --------------

--%>