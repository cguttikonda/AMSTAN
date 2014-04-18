<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%
	JCO.Client client_U = null;
	JCO.Function function_U = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

	String salesOrder = request.getParameter("salesOrder");
	String poSONums[] = null;

	if(salesOrder!=null)
		poSONums = salesOrder.split("ÿ");

	java.util.HashMap multiFileName = new java.util.HashMap();

	for(int s=0;s<poSONums.length;s++)
	{
		String soNum_U = poSONums[s];

		try
		{
			client_U = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			function_U = EzSAPHandler.getFunction("Z_EZ_DOC_ATTACHMENTS",site_S+"~"+skey_S);

			JCO.ParameterList docList = function_U.getImportParameterList();

			docList.setValue(soNum_U,"DOCUMENT_ID");
			docList.setValue("H","ATTACHMENT_TYPE");

			client_U.execute(function_U);

			JCO.Table fileList_U = function_U.getTableParameterList().getTable("FILELIST");

			if(fileList_U!=null)
			{
				if(fileList_U.getNumRows()>0)
				{
					do
					{
						String fileName_U = (String)fileList_U.getValue("FILENAME");
						String instId_U = (String)fileList_U.getValue("INSTID");

						if(!multiFileName.containsKey(fileName_U))
							multiFileName.put(fileName_U,instId_U);
					}
					while(fileList_U.nextRow());
				}
			}
		}
		catch(Exception e){}
		finally
		{
			if(client_U!=null)
			{
				JCO.releaseClient(client_U);
				client_U = null;
				function_U=null;
			}
		}
	}
%>
<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
<script>
function getAttach(str)
{
	document.myForm.lineNo.value=str;

	document.myForm.action="ezViewOrSaveFile.jsp";
	document.myForm.submit();
}
</script>
<form name="myForm">
<input type="hidden" name="lineNo">
<Div style="background-color:#FFFFFF">
<Table width="100%" height="50px" align=center border=0 cellSpacing=1 bgcolor="#FFFFFF">
<%
	Map sortedMap = new TreeMap(multiFileName);

	Set file_N = sortedMap.entrySet();
	Iterator file_NIte = file_N.iterator();
	int i=0;

	while(file_NIte.hasNext())
	{
		Map.Entry fileData = (Map.Entry)file_NIte.next();

		String fileKey = (String)fileData.getKey();
		String fileVal = (String)fileData.getValue();
%>
		<tr><td><a href="javascript:getAttach(<%=i%>)"><%=fileKey%></a></td></tr>
		<input type="hidden" name="fileKey_<%=i%>" value="<%=fileKey%>">
		<input type="hidden" name="fileVal_<%=i%>" value="<%=fileVal%>">
<%
		i++;
	}
%>
</Table>
</Div>
</form>