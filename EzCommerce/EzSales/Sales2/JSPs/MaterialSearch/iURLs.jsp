<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%
/*
	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();
	logs.setUserId("AFSCU1");
	logs.setPassWd("afscu1");
	logs.setConnGroup("666");
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	ezc.ezparam.EzDefReturn ezDefSales = Session.isValidSalesUser();
*/

		String objectKey = request.getParameter("objectKey");
		String objectDesc = request.getParameter("objectDesc");
		//String objectType = request.getParameter("objectType");

		ReturnObjFromRetrieve retURlObj  = null;
		ReturnObjFromRetrieve retReturnObj   = null;
		
		int retURlObjCount=0;
		int retReturnCount=0;

		ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
		ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
		ezc.ezmaterialsearch.params.EziDocumentUrlParams urlParams	=new ezc.ezmaterialsearch.params.EziDocumentUrlParams();
		
		//urlParams.setObjectType("VBAP");
		//urlParams.setObjectKey("0000000861000010"); 

		urlParams.setObjectKey(objectKey);
		urlParams.setObjectType("MARA");
		
		myParams.setObject(urlParams);
		Session.prepareParams(myParams);
		ReturnObjFromRetrieve retObj = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetDocumentURL(myParams);

		try {
		if(retObj!=null)
		{
			
			retObj.toEzcString();
			
			if(retObj.getRowCount()>0)
			{
				retURlObj 	= (ezc.ezparam.ReturnObjFromRetrieve)retObj.getFieldValue("URLS");
				retReturnObj  	= (ezc.ezparam.ReturnObjFromRetrieve)retObj.getFieldValue("RETURN");

				if(retURlObj!=null) retURlObjCount =retURlObj.getRowCount();
				if(retReturnObj!=null) retReturnCount   =retReturnObj.getRowCount();
			}
			
			
			
		}
		
		}
		catch(Exception e1)
		{}

%>
	