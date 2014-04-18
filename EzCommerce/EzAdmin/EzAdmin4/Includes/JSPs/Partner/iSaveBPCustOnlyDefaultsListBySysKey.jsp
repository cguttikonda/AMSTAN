<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%

String FUNCTION = request.getParameter("FUNCTION");
// Get the input parameters
String BusPartner = null;
String SoldTo = null;

String ChgFlag = null;
String pChgFlag = null;

String DefKey = null;
String pDefKey = null;
String DefValue = null;
String pDefValue = null;

String strTcount =  request.getParameter("TotalCount");
BusPartner = request.getParameter("BusPartner");
SoldTo = request.getParameter("SoldTo");
String sys_key=request.getParameter("SysKey");

if ( strTcount != null )
{
	int TotalCount = (new Integer(strTcount)).intValue();

	for ( int j = 0  ; j < TotalCount; j++ )
	{

		DefKey= "DefaultsKey_"+j;
		DefValue= "DefaultsValue_"+j;
		pDefKey = request.getParameter(DefKey);
		pDefValue = request.getParameter(DefValue);

		// Transfer Structure for the Descriptions
		EzKeyValueStructure in = new EzKeyValueStructure();

		// Set the Structure Values
		in.setPKey(SoldTo.trim());
		in.setKey(pDefKey.trim());
		in.setValue(pDefValue.trim());

		// Add Business Partner Defaults
		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setLanguage("EN");
		bnkparams2.setSys_key("NOT");
		bnkparams2.setEzKeyValueStructure(in);
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		BPManager.setCustomerDefaults(bparams2);
	}//End For
}// End if TotalCount not null

//response.sendRedirect("ezBPSetDefaults.jsp?BusinessPartner=" + BusPartner+"&FUNCTION="+FUNCTION);
response.sendRedirect("ezBPCustOnlyDefaultsListBySysKey.jsp?saved=Y&BusinessPartner=" + BusPartner+"&SoldTo="+SoldTo+"&FUNCTION="+FUNCTION+"&SysKey="+sys_key);

%>