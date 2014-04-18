<%@ include file="iLang_Labels.jsp" %>

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

// For stock report option

String sel_prd_mnt_yr_L = getLabel("SEL_PRD_MNT_YR");
String stk_rpts_L 	= getLabel("STK_RPTS");
String no_stk_data_L 	= getLabel("NO_STK_DATA");
String sel_slsoff_L 	= getLabel("SEL_SLSOFF");
String view_by_so_L 	= getLabel("VIEW_BY_SO");
String no_stk_by_so_L 	= getLabel("NO_STK_BY_SO");
String pls_slt_L 	= getLabel("PLS_SLT");
String prd_mnt_yr_L 	= getLabel("PRD_MNT_YR");
String stk_by_L 	= getLabel("STK_BY");
String no_stk_by_L 	= getLabel("NO_STK_BY");
String sel_sales_area_L = getLabel("SEL_SALES_AREA");
String view_by_stkist_L = getLabel("VIEW_BY_STKIST");
String no_stk_by_stkist_L= getLabel("NO_STK_BY_STKIST");
String sel_sa_prd_L 	= getLabel("SEL_SA_PRD");
String info_by_sa_L 	= getLabel("INFO_BY_SA");
String no_stk_by_sa_L	= getLabel("NO_STK_BY_SA");
String head_qtr_L 	= getLabel("HEAD_QTR");
String dist_mgr_L 	= getLabel("DIST_MGR");
String zonal_mgr_L	= getLabel("ZONAL_MGR");
String sls_off_L 	= getLabel("SLS_OFF");
String sls_area_L 	= getLabel("SLS_AREA");
String stockist_L	= getLabel("STOCKIST");
String clk_to_view_rpt_L= getLabel("CLK_TO_VIEW_RPT");
String mat_L 		= getLabel("MAT");
String all_c_L		= getLabel("ALL_C");
String month_L 		= getLabel("MONTH");
String year_L 		= getLabel("YEAR");
String tot_L 		= getLabel("TOT");
String unit_pri_L 	= getLabel("UNIT_PRI");
String value_L 		= getLabel("VALUE");
String clo_bal_L 	= getLabel("CLO_BAL");
String quan_L 		= getLabel("QUAN");
String returns_L 	= getLabel("RETURNS");
String sec_sales_L 	= getLabel("SEC_SALES");
String chg_stk_stmt_L 	= getLabel("CHG_STK_STMT");
String sel_L 		= getLabel("SEL");
String no_stk_stmt_L 	= getLabel("NO_STK_STMT");
String sel_stk_n_updt_L	= getLabel("SEL_STK_N_UPDT");
String wait_req_pro_L 	= getLabel("WAIT_REQ_PRO");



String mnth_yr_go_L 	= getLabel("MNTH_YR_GO");
String stk_summ_info_L 	= getLabel("STK_SUMM_INFO");
String opening_L 	= getLabel("OPENING");
String reciepts_L 	= getLabel("RECIEPTS");
String secondary_L 	= getLabel("SECONDARY");
String closing_L 	= getLabel("CLOSING");
String transit_L 	= getLabel("TRANSIT");

// For Add Stock

String no_inv_found_L 	= getLabel("NO_INV_FOUND");
String inv_lst_L 	= getLabel("INV_LST");
String cust_L 		= getLabel("CUST");
String clk_n_get_invs_L = getLabel("CLK_N_GET_INVS");
String in_no_L 		= getLabel("IN_NO");
String lr_date_L 	= getLabel("LR_DATE");
String disputed_L 	= getLabel("DISPUTED");
String rec_date_L 	= getLabel("REC_DATE");
String less_thn_todt_L 	= getLabel("LESS_THN_TODT");
String grt_thn_invdt_L 	= getLabel("GRT_THN_INVDT");
String sel_rec_dt_L 	= getLabel("SEL_REC_DT");
String sel_inv_fr_invno_L= getLabel("SEL_INV_FR_INVNO");
String add_stk_to_prnt_L= getLabel("ADD_STK_TO_PRNT");
String no_stk_to_prnt_L	= getLabel("NO_STK_TO_PRNT");
String for_L		= getLabel("FOR");
String no_prds_L	= getLabel("NO_PRDS");
String bal_L		= getLabel("BAL");
String sel_anthr_prd_L	= getLabel("SEL_ANTHR_PRD");
String fill_all_rows_L	= getLabel("FILL_ALL_ROWS");
String max_30prds_L	= getLabel("MAX_30PRDS");
String ent_no_of_lines_L= getLabel("ENT_NO_OF_LINES");
String cli_log_end_sess_L= getLabel("CLI_LOG_END_SESS");
String tt_clk_hr_prt_L	= getLabel("TT_CLK_HR_PRT");


String con_stk_stmt_L	= getLabel("CON_STK_STMT");
String con_stk_sub_stmt_L= getLabel("CON_STK_SUB_STMT");
String sub_re_conf1_L	= getLabel("SUB_RE_CONF1");
String sub_re_conf2_L	= getLabel("SUB_RE_CONF2");
String sub_re_conf3_L	= getLabel("SUB_RE_CONF3");

String no_prds_to_edit_L= getLabel("NO_PRDS_TO_EDIT");
String no_prds_to_view_L= getLabel("NO_PRDS_TO_VIEW");
String cls_stk_chk_L	= getLabel("CLS_STK_CHK");

//Ends Here
		
// Added on 24-11-2004

//String clkHrHome_L 	= getLabel("TT_CLK_HR_HOME");
String clk_hr_to_lout_L = getLabel("TT_CLK_HR_ENTR_LOUT");
String no_cust_L 	= getLabel("NO_CUST");
String s_area_L 	= getLabel("S_AREA");

String mat_desc_L 	= getLabel("MAT_DESC");
String ret_frm_com_L 	= getLabel("RET_FRM_COM");
String expc_stk_L 	= getLabel("EXPC_STK");
//String s_area_L 	= getLabel("S_AREA");

String del_stk_st_L 	= getLabel("DEL_STK_ST");

//Added by Jagan on 25-11-2004

String 	stk_stmt_entr_L = getLabel("STK_STMT_ENTR");
String 	home_L = getLabel("HOME");
String 	l_out_L = getLabel("L_OUT");
String 	stk_rpt_entrd_L = getLabel("STK_RPT_ENTRD");
String 	no_of_stk_rpts_entrd_L = getLabel("NO_OF_STK_RPTS_ENTRD");
String 	prod_li_L = getLabel("PROD_LI");
String 	no_prodcts_to_add_L = getLabel("NO_PRODCTS_TO_ADD");
//String 	grt_thn_invdt_L = getLabel("GRT_THN_INVDT");
String 	plz_slct_inv_fr_invno_L = getLabel("PLZ_SLCT_INV_FR_INVNO");
String 	plz_slct_cust_L = getLabel("PLZ_SLCT_CUST");
//String 	no_inv_found_L = getLabel("NO_INV_FOUND");
//String 	clk_n_get_invs_L = getLabel("CLK_N_GET_INVS");
String 	plz_slct_rcvd_dt_fr_inv_L = getLabel("PLZ_SLCT_RCVD_DT_FR_INV");
String 	bil_L = getLabel("BIL");
String 	bilv_L = getLabel("BILV");
String 	frs_L = getLabel("FRS");
String 	frsv_L = getLabel("FRSV");
String 	bon_L = getLabel("BON");
String 	bonv_L = getLabel("BONV");
%>
