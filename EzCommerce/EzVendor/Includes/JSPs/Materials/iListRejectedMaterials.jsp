<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.params.*,ezc.ezshipment.client.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	Hashtable remarks = new Hashtable();

	EzShipmentManager shManager = new EzShipmentManager();
	EziSearchInputStructure inParams = new EziSearchInputStructure();
	inParams.setVendor(((String)session.getValue("SOLDTO")).trim());
	inParams.setDocnum("%");
	ReturnObjFromRetrieve matlist=null;
	ReturnObjFromRetrieve rejtexts=null;

	int Count=0;
	int textcount=0;

	EzcParams ezParams = new EzcParams(true);
	ezParams.setObject(inParams);
	Session.prepareParams(ezParams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve) shManager.ezGetRejectedMaterialsList(ezParams);


	if(retObj.getRowCount()>0)
	{
		matlist=(ReturnObjFromRetrieve)retObj.getFieldValue(0,"MATLIST");
		rejtexts=(ReturnObjFromRetrieve)retObj.getFieldValue(0,"REJTEXTS");
		Count=matlist.getRowCount();
		textcount=rejtexts.getRowCount();
	}



	for(int i=0;i<textcount;i++)
	{
		String ponum=rejtexts.getFieldValueString(i,"PONO");
		String text=rejtexts.getFieldValueString(i,"TEXTLINES");
		remarks.put(ponum,text);
	}




%>
