<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%

	String prodData = request.getParameter("chkVal");
	//out.print("**"+prodData+"**");
	String[] products = prodData.split("@@");
	
	ReturnObjFromRetrieve[] prodDet = new ReturnObjFromRetrieve[products.length];
	int rowCnt = 0;
	java.util.ArrayList specType = new java.util.ArrayList();
	
	for(int i=0;i<products.length;i++)
	{
	
		EzcParams ezcpparams = new EzcParams(true);
		EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();

		cnetParams.setStatus("GET_PRDDET_MAINSPEC");
		cnetParams.setProdID(products[i]);
		cnetParams.setQuery("");
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		prodDet[i] = (ReturnObjFromRetrieve)CnetManager.ezGetCnetPrdDetailsByStatus(ezcpparams);
		
		rowCnt = prodDet[i].getRowCount();
		for(int k=0;k<rowCnt;k++)
		{
			if(!specType.contains(prodDet[i].getFieldValueString(k,"HeaderText")))
				specType.add(prodDet[i].getFieldValueString(k,"HeaderText"));
		}
		
	}
%>

<html>
<head> <title>Compare Products</title> 
<script>
		  var tabHeadWidth=95
 	   	  var tabHeight="70%"

</script> 
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body scroll=yes>
<form name="myForm">
	<BR>

	<Table id='InnerBox1Tab' width='90%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
	
<%
	for(int j=0;j<products.length+1;j++)
	{
		if(j==0)
		{
%>
			<Th>&nbsp;</Th>
<%
		}
		else
		{
%>
			<Th><%=prodDet[j-1].getFieldValueString(0,"BodyText")%></Th>	
	
<%
		}
	}
%>
	</Tr>

<%
		for(int i=0;i<specType.size();i++)
		{
			if(i==0) continue;
%>

			<Tr>
<%
			for(int j=0;j<products.length+1;j++)
			{
				if(j==0)
				{
%>
					<Td><b><%=specType.get(i)%></b></Td>
<%
				}
				else
				{
%>
					<Td>
<%
						int idx = prodDet[j-1].getRowId("HeaderText",(String)specType.get(i));
						if(idx!=-1)
							out.print(prodDet[j-1].getFieldValueString(idx,"BodyText"));
						else
							out.print("&nbsp;");
%>
					</Td>	
	
<%
				}
			}
%>
			</Tr>
<%			
		}
%>
	</Table>

<br>	
	
   <DIV >
   <center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
  </center>
  </div>   

</form>
</body>
</html>