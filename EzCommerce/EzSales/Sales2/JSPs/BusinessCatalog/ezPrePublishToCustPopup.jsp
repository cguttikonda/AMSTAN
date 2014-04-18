<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddGroup_Lables.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%

	int soldToCnt=0;
	ArrayList desiredSteps=new ArrayList();
	desiredSteps.add("1");
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate((String)session.getValue("Templet"));
	paramsu.setSyskey((String)session.getValue("SalesAreaCode"));
	paramsu.setPartnerFunction("AG");
	paramsu.setParticipant((String)session.getValue("UserGroup"));
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	ezc.ezparam.ReturnObjFromRetrieve retSoldTo =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	if(retSoldTo!=null && retSoldTo.getRowCount()>0)
		soldToCnt = retSoldTo.getRowCount();
%>

<html>
<head> <title>Compare Products</title> 
<script>
	var tabHeadWidth=80;
	var tabHeight="60%";  
	function funcLoad()
	{
		window.returnValue = ""
	}
	function selCustomer()
	{
		window.returnValue = document.myForm.customer.value
		window.close()
	
	}
</script> 
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body scroll=no>
<form method="post" onLoad="funcLoad()" name="myForm">

<%
	if(soldToCnt>0)
	{
%>

	<BR><BR>
	<Div id='inputDiv' style='position:relative;align:center;width:80%;left:10%'>
	<Table width="70%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
	
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>
	
		<Table  align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0>
		<Tr align=center>
		<Th>Select Customer</Th>
		<Td align='center'>
		<select name="customer">
<%	 
		for(int i=0;i<soldToCnt;i++)
		{
%>
			<Option value="<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>"><%=retSoldTo.getFieldValueString(i,"ECA_NAME")%>[<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>]</option>
<%
		}
%>
		</select>
		</td>
		</tr>
		</Table>
		</td>
		
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
	</Table>
	</Div>	


<%
	}
	else
	{
		String noDataStatement ="No Personal Catalogs present"; 
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
<%
	}
%>

<br>	
	
   <DIV >
   <center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if(soldToCnt>0)
	{
		buttonName.add("Ok");
		buttonMethod.add("selCustomer()");
	
	}
	
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
  </center>
  </div>   

</form>
</body>
</html>