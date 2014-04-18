<%@ include file="iLang_Lables.jsp" %>

<%

String aStockForecast_L = getLabel("A_STO_FORE");
String addStockStat_L = getLabel("A_STO_STAT");
String addStockInfo_L = getLabel("A_STO_INFO");
String forMonYear_L = getLabel("FOR_M_YEAR");
String myear_L = getLabel("M_YEAR");
String prod_L = getLabel("PROD");
String prodDesc_L = getLabel("PROD");
String uom_L = getLabel("UOM");
String pack_L = getLabel("PACK");
String openStock_L = getLabel("OPEN_STOCK");
String openBal_L = getLabel("OPEN_BAL");
String receipts_L = getLabel("RECEIPT");
//String colbal_L = getLabel("COL_BAL");
String sales_L = getLabel("SAL");
String salesAdj_L = getLabel("SAL_ADJ");
String devolu_L = getLabel("DEVOLU");
String stoTransit_L = getLabel("STO_TRAN");
String rollForecast_L = getLabel("ROLL_FORE");
String enterRemarks_L = getLabel("ENTER_REMARKS");
String price_L = getLabel("PRI");
String closeStock_L = getLabel("CLO_STOCK");
String expecStock_L = getLabel("EXPEC_STOCK");
String rem_L = getLabel("REM");
String uHaveSelAgentCust_L = getLabel("U_HAVE_SEL");
String here_L = getLabel("HERE");
String selProd_L = getLabel("SEL_PROD");
String addStockNewProd_L = getLabel("ADD_STOCK_NEW_PROD");
String noEntries_L = getLabel("NO_ENTRIES");
String upStockStat_L = getLabel("UP_STOCK_STAT");
String opStock_L = getLabel("OP_STOCK");
String cloStock_L = getLabel("CL_STOCK");
String expectedStock_L = getLabel("EX_STOCK");
String remark_L = getLabel("REMARK");
String urAuthEditStock_L = getLabel("UR_AUTH_STOCK");
String preMonthStock_L = getLabel("PRE_MON_STOCK");
String uSelMoreAddStostmt_L = getLabel("U_SEL_MORE_TO_ADD_STOCK_STMT");
String stockInfYetEnt_L = getLabel("STOCK_INF_YET_ENT");
String retFromCo_L = getLabel("RET_FROM_CO");
String retFromMrk_L = getLabel("RET_FROM_MARKET");

String clkHrVewStock_L = getLabel("TT_CLK_HR_VEW_STOCK");
String clkHrHome_L = getLabel("TT_CLK_HR_HOME");
String clkHrUpdtStk_L = getLabel("TT_CLK_HR_UPDT_STOCK");
String clkHrSave_L = getLabel("TT_CLK_HR_SAVE");
String clkHrProdLns_L =getLabel("TT_CLK_HR_PROD_LNS");
String clkHrEntrRmks_L = getLabel("TT_CLK_HR_ENTR_RMKS");
String clkHrChgRmks_L = getLabel("TT_CLK_HR_CHG_RMKS");
String clkHrDeStkInfo_L = getLabel("TT_CLK_HR_DEL_STK_INFO");
String clkHrVewRmks_L = getLabel("TT_CLK_HR_RMKS");
// for ezEditStockInfo

String editStock_L = getLabel("E_STO_STA");
String selCustPGo_L = getLabel("SEL_CUST_P_GO");
String uCanEditSstmt_L = getLabel("U_CAN_EDIT_SSTMT");
String oAfter_L = getLabel("ONLY_AFT");
String forcust_L = getLabel("FOR_CUST");
String nostkst_L = getLabel("NO_STK_ST");


// for ezDeleteStockInfo

String delstk_L = getLabel("DEL_STK");
String selcust_L = getLabel("SEL_CUST");
String selCustContinue_L = getLabel("SEL_CUST_CONTI");
String fSelCustNoStock_L = getLabel("F_SEL_CUST_NO_STOCK");

// for ezViewStockInfo

String viewStk_L = getLabel("VI_STK_STAT");
String selCustDt_L = getLabel("SEL_CUST_DATE");
String uCanViewSstmt_L = getLabel("U_CAN_VIEW_SSTMT");

//ALERTS 
String closeBalNotNeg_A = getLabel("CLO_BAL_NONEG");
String fieldValNum_A = getLabel("FIELD_VAL_NUM");
String fieldValPosi_A = getLabel("FIELD_VAL_POSITIVE");
String aboutUpdateSure_A = getLabel("ABOUT_UPDATE_SURE");
String plzSelCust_A = getLabel("P_SEL_CUST");
String plzSelProd_A = getLabel("PLZ_SEL_PROD");
String delProdUSure_A = getLabel("DEL_PROD_SURE");
String valueNumeric_A = getLabel("VALUE_NUMERIC");
String valuePositive_A = getLabel("FIELD_VAL_POSITIVE");
String uHaveSel_A = getLabel("U_HAVE_SEL");
String plzStockDeSelect_A = getLabel("PLZ_STOCK_DESELMAT");
String plzSelMat_A = getLabel("PLZ_SEL_MAT");
String moreOnceSelProdOnce_A = getLabel("MONCE_SELPROD_ONCE");
String uHaveAlreadySub_A = getLabel("U_HAVE_SUB");

String janu_L = getLabel("JANU");
String febr_L = getLabel("FEBR");
String marc_L = getLabel("MARC");
String apri_L = getLabel("APRI");
String may_L =  getLabel("MAY");
String june_L = getLabel("JUNE");
String july_L = getLabel("JULY");
String augu_L = getLabel("AUGU");
String sept_L = getLabel("SEPT");
String octo_L = getLabel("OCTO");
String nove_L = getLabel("NOVE");
String dece_L = getLabel("DECE");
String stkStmt_L = getLabel("UPDATE_STOCK");
String adjRmk_L = getLabel("ADJ_REM");
String clkHrSeeAdjRmks_L = getLabel("TT_CLK_HR_SEE_ADJ_RMKS");
String clkHrChgAdjRmks_L = getLabel("TT_CLK_HR_CHG_ADJ_RMKS");
String clkHrGetsheet_L = getLabel("TT_CLK_HR_GET_SL_SHT");
%>
