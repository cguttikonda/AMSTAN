<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%
	String websyskey=request.getParameter("WebSysKey");
	String Area =request.getParameter("Area");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");
	
	String ChkSys = null;
	String SysNum = null;

	String pChkSys = null;
	String pSysNum = null;
	String [] Systems = null;
	String BusPartner = request.getParameter("BusPartner");

	EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();
	String strTcount =  request.getParameter("TotalCount");
	String areCount = request.getParameter("AreaCount");
	int AreaCount = 0;
	if ( areCount != null )
	{
		AreaCount = (new Integer(areCount)).intValue();
	}
	if ( strTcount != null )
	{
		int TotalCount = (new Integer(strTcount)).intValue();
		int selCount =  0;

		for ( int i = 0 ; i < TotalCount; i++ )
		{
			ChkSys = "ChkSys_"+i;
			pChkSys = request.getParameter(ChkSys);
			if ( pChkSys != null ){
				selCount = selCount + 1;
			}
		}

		Systems = new String[selCount];
		selCount = 0;

		for ( int i = 0  ; i < TotalCount; i++ ){
			ChkSys = "ChkSys_"+i;
			pChkSys = request.getParameter(ChkSys);
			if ( pChkSys != null )
			{
				Systems[selCount] = new String(pChkSys);
				selCount++;
			}
		}

		String GetAreaKey, GetAreaFlag, pGetAreaKey, pGetAreaFlag = "";
		int selAreaCnt = 0;
		for ( int m = 0; m < AreaCount; m++ )
		{
			GetAreaKey = "OrgArea_"+m;
			pGetAreaKey = request.getParameter(GetAreaKey);
			if ( pGetAreaKey != null )
				selAreaCnt++;
		}

		for ( int i = 0  ; i < AreaCount; i++ )
		{
			GetAreaKey = "OrgArea_"+i;
			GetAreaFlag = "OrgAreaFlag_"+i;
			String changedArea = request.getParameter(GetAreaKey+"_CHG");
			String getAreaVal = request.getParameter(GetAreaKey+"_VAL");

			pGetAreaKey = request.getParameter(GetAreaKey);

			if ( getAreaVal != null && changedArea != null && changedArea.equals("Y") )
			{
				EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
				ebptrow.setEbpaClient("200");
				pGetAreaFlag = request.getParameter(GetAreaFlag);
				ebptrow.setEbpaSysKey(getAreaVal);
				ebptrow.setEbpaAreaFlag(pGetAreaFlag);
				ebptrow.setEbpaBussPartner(BusPartner);
				ebptrow.setLanguage("EN");
				ebpt.appendRow(ebptrow);
			}
		}

		EzcBussPartnerParams bparams = new EzcBussPartnerParams();
		bparams.setBussPartner(BusPartner);
		bparams.setObject(ebpt);
		Session.prepareParams(bparams);

		ReturnObjFromRetrieve retAddBP = (ReturnObjFromRetrieve)BPManager.setBussPartnerAreas(bparams);
		EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams1= new EzcBussPartnerNKParams();
		EzAddBussPartnerStructure bpaddstruct1 = new EzAddBussPartnerStructure();
		bnkparams1.setLanguage("EN");
		bpaddstruct1.setSys_no(Systems);
		bparams1.setBussPartner(BusPartner);
		bparams1.setObject(bnkparams1);
		bparams1.setObject(bpaddstruct1);
		Session.prepareParams(bparams1);
		BPManager.addBussPartnerSystems(bparams1);
	}

	if(websyskey!=null && !"".equals(websyskey))
		response.sendRedirect("../Partner/ezListBPBySysKey.jsp?saved=Y&BusinessPartner="+BusPartner+"&Area="+Area +"&WebSysKey="+websyskey+"&searchcriteria="+mySearchCriteria);
	else
		response.sendRedirect("../Partner/ezListBP.jsp");
%>
