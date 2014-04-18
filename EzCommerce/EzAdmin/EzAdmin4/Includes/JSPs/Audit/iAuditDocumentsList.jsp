
<%@ page import ="ezc.ezparam.*" %>
<%@ page import = "ezc.ezaudit.params.*" %>
<%@ page import = "java.util.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="auditManager" class="ezc.ezaudit.client.EzAuditManager" scope="page" />

<%

		StringTokenizer st=null;
		String totalString=request.getParameter("auditId");

		String auditId="";
		String site="";
		String tableName="";
		if(totalString!=null && !"".equals(totalString) && !"null".equals(totalString))
		{
			st=new StringTokenizer(totalString,"~");
			auditId=st.nextToken();
			site=st.nextToken();
			tableName=st.nextToken();
		}

		String columnValue[]=request.getParameterValues("Columns");
		String columnsString="";
		
		if(columnValue!=null)
		{
				for(int i=0;i<columnValue.length;i++)
				{
					columnsString=columnsString+"'"+columnValue[i]+"',";
				}
				columnsString=columnsString.substring(0,columnsString.length()-1);
		}
		
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		EziAuditTableListParams inParams = new EziAuditTableListParams();
		mainParams.setLocalStore("Y");
		mainParams.setObject(inParams);
		Session.prepareParams(mainParams);
		ReturnObjFromRetrieve retTable=(ReturnObjFromRetrieve)auditManager.getAuditDocumentsList(mainParams);

		EziAuditTableDetailsParams inParamsCol =null;
		ReturnObjFromRetrieve retCol=null;

		Hashtable columns=new Hashtable();

		if(auditId!=null && !"".equals(auditId) && !"null".equals(auditId))
		{


			inParamsCol = new EziAuditTableDetailsParams();
			inParamsCol.setAuditId(auditId);
			mainParams.setLocalStore("Y");
			mainParams.setObject(inParamsCol);
			Session.prepareParams(mainParams);
			retCol=(ReturnObjFromRetrieve)auditManager.getAuditDocumentDetails(mainParams);

			if(retCol.getRowCount()>0)
			{
				for(int i=0;i<retCol.getRowCount();i++)

				if(!columns.containsKey(retCol.getFieldValueString(i,"FIELDNAME")))
				{
					columns.put(retCol.getFieldValueString(i,"FIELDNAME"),retCol.getFieldValueString(i,"AUDITID"));
				}


			}
		}

	ReturnObjFromRetrieve retLog=null;
	if((auditId!=null && !"".equals(auditId) && !"null".equals(auditId)) &&(columnValue!=null ))
	{
		EziAuditLogDetailsParams logParams=new EziAuditLogDetailsParams();

		logParams.setSiteNo(site);
		logParams.setTableName(tableName);
		logParams.setFieldName(columnsString);
		mainParams.setLocalStore("Y");
		mainParams.setObject(logParams);
		Session.prepareParams(mainParams);
		retLog=(ReturnObjFromRetrieve)auditManager.getAuditDocumentLog(mainParams);
	}

%>
