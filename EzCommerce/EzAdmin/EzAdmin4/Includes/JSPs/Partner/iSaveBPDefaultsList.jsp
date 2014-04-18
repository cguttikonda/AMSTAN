<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%
// Get the input parameters
String FUNCTION = request.getParameter("FUNCTION");
String BusPartner = null;
String SysKey = null;
String SoldTo = null; 

String ChgFlag = null; 
String pChgFlag = null; 

String DefKey = null; 
String pDefKey = null; 
String DefValue = null; 
String pDefValue = null; 
String strTcount =  request.getParameter("TotalCount");
BusPartner = request.getParameter("BusPartner");	
SysKey = request.getParameter("SysKey");	
SoldTo = request.getParameter("SoldTo");	

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
		//in.setPKey(SoldTo.trim()); // CHG : 05/09/2000 
		in.setPKey(SoldTo);
		in.setKey(pDefKey.trim());
		in.setValue(pDefValue.trim());

			
		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setLanguage("EN");
		bnkparams2.setEzKeyValueStructure(in);
		bnkparams2.setSys_key(SysKey);
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		// Add Business Partner Defaults
		BPManager.setCustomerDefaults(bparams2); 

	}//End For
}// End if TotalCount not null

//response.sendRedirect("ezBPSetDefaults.jsp?BusinessPartner=" + BusPartner+"&FUNCTION="+FUNCTION);
response.sendRedirect("ezBPDefaultsList.jsp?saved=Y&BusPartner=" + BusPartner+"&area="+SysKey+"&SoldTo="+SoldTo+"&FUNCTION="+FUNCTION);
%>