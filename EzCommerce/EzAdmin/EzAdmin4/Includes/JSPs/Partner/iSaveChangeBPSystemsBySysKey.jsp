<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%
//Venkat Created this JSP page on 4/22/2001
String ChkSys = null;
String SysNum = null;

String pChkSys = null;
String pSysNum = null;
String [] Systems = null;
String BusPartner = request.getParameter("BusinessPartner");
String area=request.getParameter("Area");
String websyskey=request.getParameter("WebSysKey");


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

	// This is to find the number of selected rows
	for ( int i = 0 ; i < TotalCount; i++ ) {
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
		//SysNum = "SysNum_"+i; //Commented on 4/21/2001 by Venkat

		pChkSys = request.getParameter(ChkSys);
		if ( pChkSys != null ){
			// Get Data from The Local Database
			Systems[selCount] = new String(pChkSys);
			selCount++;
		}
	}//End For

	String GetAreaKey, GetAreaFlag, pGetAreaKey, pGetAreaFlag = "";
	int selAreaCnt = 0;

	for ( int m = 0; m < AreaCount; m++ )
	{
	     GetAreaKey = "OrgArea_"+m;
	     pGetAreaKey = request.getParameter(GetAreaKey);
	     if ( pGetAreaKey != null )selAreaCnt++;
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
			ebptrow.setEbpaClient("200"); // TBD
			pGetAreaFlag = request.getParameter(GetAreaFlag);
			ebptrow.setEbpaSysKey(getAreaVal);
			ebptrow.setEbpaAreaFlag(pGetAreaFlag);
                  ebptrow.setEbpaBussPartner(BusPartner);
			ebptrow.setLanguage("EN");
			ebpt.appendRow(ebptrow);
            }
	}//End For

	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	bparams.setBussPartner(BusPartner);
	bparams.setObject(ebpt);
	Session.prepareParams(bparams);

	//Update Business Partner
	ReturnObjFromRetrieve retAddBP = (ReturnObjFromRetrieve)BPManager.setBussPartnerAreas(bparams);

      //Update newly Added or removed systems
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

//response.sendRedirect("../Partner/ezChangeBPSystemsBySysKey.jsp?saved=Y&BusinessPartner="+BusPartner);
response.sendRedirect("../Partner/ezChangeBPSystemsBySysKey.jsp?saved=Y&BusinessPartner="+BusPartner+"&Area="+area+"&WebSysKey="+websyskey);
%>