<%@ include file="iLang_Lables.jsp" %>

<%

	String edsaor_L = getLabel("TT_EDIT_SO");
	String salesOrder_L = getLabel("S_ORDER");
	String weorno_L = getLabel("WEORNO");
	String weordate_L = getLabel("WEORDATE");
	String crby_L = getLabel("CREATED_BY");
	String lamoby_L = getLabel("LA_MO_BY");
	String banker_L = getLabel("BANKER");
	String pono_L = getLabel("PONO");
	String podate_L = getLabel("PODATE");
	String curr_L = getLabel("CURR");
	String soldto_L = getLabel("SOLD_TO");
	String shipto_L = getLabel("SHIPTO");
	String esnet_L = getLabel("EST_NET_VAL");
	String prdesc_L = getLabel("PROD");
	String uom_L = getLabel("UOM");
	String quan_L = getLabel("QUAN");
	String price_L = getLabel("PRI");
	String value_L = getLabel("VALUE");
	String reqdat_L = getLabel("REQUIR_DAT");
	String dat_L = getLabel("DAT");
	String req_L = getLabel("REQ");
	String con_L = getLabel("CON");
	String ord_L = getLabel("ORD");
	String foc_L = getLabel("FOC");
	String podet_L = getLabel("PO_DET");
	String tecondweb_L = getLabel("TE_COND_WEB");
	String none_L = getLabel("NONE");
	String txForm_L = getLabel("TAX_FORM");
	String disCash_L = getLabel("DIS_CASH");
	String discount_L = getLabel("DISC");
	String friCharg_L = getLabel("FRI_CHARGES");
	
	
	//Newly added labels by suryamohan on 8/4/2003
	String invNo_L = getLabel("INV_NO");
	String invDate_L = getLabel("INV_DATE");
	String batNo_L = getLabel("BAT_NO");
	String mrp_L = getLabel("MRP");
	String category_L = getLabel("CATEGORY");
	
	
	//*******************GML*************

	String delDate_L = getLabel("DEL_DATE");
	String notes_L = getLabel("NOTES");
	String sArea_L = getLabel("S_AREA");
	String plant_L = getLabel("PLANT");
	String tOCD_L = getLabel("THIS_ORD_CAN_DEL");
	String clDdLkQt_L = getLabel("CL_DD_LK_QT");
	String taxDutiAppli_L = getLabel("TAXES_DUTIES_APPLI");
	String multiple_L = getLabel("MULTIPLE");

	//ALERTS 01/08/2002

	String plzSelSarea_A = getLabel("PLZ_SEL_SAREA");
        String plzSelPlant_A = getLabel("PLZ_SEL_PLANT");
        String plzSelProd_A = getLabel("PLZ_SELECT_PROD");
        String plzRetOrdCust_A = getLabel("EDIT_INF_FRIE_RET_CUST");
        String plzRetOrdBP_A = getLabel("EDIT_INF_DIS_SUB_BP");
        String plzRetFocOrdBP_A = getLabel("EDIT_INF_FOC_SUB_BP"); 
        String plzRetPriOrdBP_A = getLabel("EDIT_INF_PRI_SUB_BP"); 
        String notEntValDisPer_A = getLabel("NOT_ENT_VAL_DIS_PER"); 
        String disPerNotZero_A = getLabel("DIS_PER_NOT_ZERO"); 
        String disCashNotZero_A = getLabel("DIS_CASH_NOT_ZERO"); 
        String plzEntValiDis_A = getLabel("PLZ_ENT_VALI_NUM_DIS_PER");
        String plzEntDisNum_A = getLabel("PLZ_CASH_IN_NUM");
        String plzSelLinesToDel_A = getLabel("PLZ_LINES_DEL");
        String plzSelReqDt_A = getLabel("PLZ_REQ_CLK");
        String reqDtGtToday_A = getLabel("COMP_REQ_DT");
        String plzSelConfDt_A = getLabel("PLZ_CONFIRM_DATE");
        String confDtGtToday_A = getLabel("CONFIRM_DATE_GREAT_EQL_TODAY");
        String confDtGtReqDt_A = getLabel("PLZ_COMP_CONF");
        String permaDelLines_A = getLabel("PERMA_DEL_LINES");
        String plzEnter_A = getLabel("PLZ_ENTER");
        String plzPriceChanQuant_A = getLabel("PLZ_PRI_CHAN_QUAN");
        String saveFurModifi_A = getLabel("SAVE_FUR_MODI");
        String saveOrder_A = getLabel("SAVE_ORDER");
        String approOrder_A = getLabel("APPRO_ORD2");
	String delOrder_A = getLabel("DEL_ORD2");
	
	String returnOrder_A = getLabel("RET_ORD2");
	String postOrder_A = getLabel("POST_ORD2");
	String acceptOrder_A = getLabel("ACC_ORD2");

        String accOrdeApproval_A = getLabel("ACC_ORD_APPRO");
 	String subOrdeApproval_A = getLabel("SUB_ORD_APPRO");
        String plzSelPTerms_A = getLabel("PLZ_SEL_PTERMS");
        String changeQutConti_A = getLabel("CHAN_QUAN_CONTI");
	String plzSelShipTO_A = getLabel("PLZ_SEL_SHIP_TO");
        String plzIncoTerms_A = getLabel("PLZ_INCO_TERM");
        String plzQutDeliDate_A = getLabel("PLZ_QUT_DELI");
        String plzConfiPrice_A = getLabel("PLZ_CONFI_PRICE");
        String quanLessEqual_A = getLabel("QUAN_LESS_EQUAL");
	String confiLessEqual_A = getLabel("CONFI_LESS_EQAL");
        String plzValidQty_A = getLabel("PLZ_VAL_QTY");
        String plzValidCPrice_A = getLabel("PLZ_VALID_CPRICE");
        String focLessZero_A = getLabel("FOC_LESS_ZERO"); 
        String plzFOCNum_A = getLabel("PLZ_FOC_NUM");
	String plzFreight_A = getLabel("PLZ_FREIGHT");
	String freightLessZero_A = getLabel("FREIGHT_LESS_ZERO");
        String plzValidFrightNum_A = getLabel("PLZ_VALI_FNUM");
		

	String viewTC_T = getLabel("TT_CLK_HR_RMKS");
	String clickPrePage_T = getLabel("TT_CLICK_PREV_PAGE");
	String getPri_T = getLabel("TT_GET_PRICE");
	String clkDelLine_T = getLabel("TT_CLK_DEL_LINE");
	String viewRea_T = getLabel("TT_VIEW_REA");
	String ordDet_T = getLabel("TT_CLICK_ORD_DET");
	String viewDelSche_T = getLabel("TT_VIEW_DEL_SCH");
	String viewDispDet_T = getLabel("TT_VIEW_DIS_DET");
	String viewBillDet_T = getLabel("TT_VIEW_BILL_DET");

	String clkHrHome_L = getLabel("TT_CLK_HR_HOME");
	String clkHrPrint_L = getLabel("TT_CLK_HR_PRT");
	String clkHrSave_L = getLabel("TT_CLK_HR_SAVE");
	String clkHrPostSap_L = getLabel("TT_CLK_HR_SAP");
	String clkHrEdtRmks_L = getLabel("TT_CLK_HR_CHG_RMKS");
%>
