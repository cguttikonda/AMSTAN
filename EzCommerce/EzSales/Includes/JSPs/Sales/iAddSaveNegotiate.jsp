<%@ page import="java.util.*"%>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session" />
<%
	ezc.ezparam.EzcParams mainParams=null;
	EzcParams indexMainParams = new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setQuery("SELECT MAX(EON_INDEX_NO) INDEX_NO FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+weborno+"'");
	indexMainParams.setLocalStore("Y");
	indexMainParams.setObject(miscParams);
	Session.prepareParams(indexMainParams);

	ReturnObjFromRetrieve retIndexNo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(indexMainParams);
	String indexNO = "";

	if(retIndexNo != null)
		indexNO = retIndexNo.getFieldValueString(0,"INDEX_NO");

	if(indexNO == null || indexNO.equalsIgnoreCase("null") || indexNO.equals(""))
		indexNO = "0";
	else
		indexNO = String.valueOf(Integer.parseInt(indexNO) + 1);

	EziMiscParams insMiscParams = null;

 	for(int i=0;i<prodCodeLength;i++)
	{
		String line 	    = String.valueOf((i+1)*10);

		String prefPrice    = itemListPrice[i];
		prefPrice 	    = ((prefPrice == null) || (("").equals(prefPrice)))?"0":prefPrice;
		
		log4j.log("iteration======>"+i, "D");
		log4j.log("linelinelineline======>"+line, "D");
		log4j.log("itemListPrice======>"+itemListPrice[i], "D");
		log4j.log("prefPriceprefPrice======>"+prefPrice, "D");

		EzcParams orderMainParams = new EzcParams(false);

		insMiscParams = new EziMiscParams();
		insMiscParams.setQuery("INSERT INTO EZC_ORDER_NEGOTIATE(EON_ORDER_NO,EON_ITEM_NO,EON_INDEX_NO,EON_CREATED_BY,EON_CREATED_ON,EON_MODIFIED_BY,EON_MODIFIED_ON,EON_PRICE,EON_STATUS,EON_ITEM_PRICE,EON_EXT1,EON_EXT2,EON_EXT3) VALUES('"+weborno+"','"+line+"','"+indexNO+"','"+user+"',getDate(),'"+user+"',getDate(),'"+prefPrice+"','INPROCESS','"+prefPrice+"','','','')");
		orderMainParams.setLocalStore("Y");
		orderMainParams.setObject(insMiscParams);
		Session.prepareParams(orderMainParams);
		
		ezMiscManager.ezAdd(orderMainParams);
	}
%>