<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddGroup_Lables.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
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
	//out.println(retSoldTo.toEzcString());

%>
<html>
<head>
<title>ezAdd Group</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script LANGUAGE="JavaScript">
	   var tabHeadWidth=75
 	   var tabHeight="45%"
	function changePassword()
	{

		var count=0;
		var len=document.myForm.cust.length;
		var obj=document.myForm.cust;

		if(isNaN(len))
		{
			if(obj.checked)
			{

				count++;
			}
		}

		else
		{
			for(var i=0;i<len;i++)
			{
				if(obj[i].checked)
				count++;
			}	
		}
		if(count==0)
		{
			alert("Please select one user to change password");
				return;
		}
		else
		{

			document.myForm.action="ezPreChangeCustomerPwd.jsp";
			document.myForm.submit();
		}	
		


	}
</script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body onLoad="scrollInit();" scroll=no onresize="scrollInit()">
<form method="post" name="myForm">

<%
  String display_header = "Customer List"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<br>
<%
	if(soldToCnt==0)
	{
		String noDataStatement = "No customers present";
%>


		<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
<%
	}
	else
	{
%>
	<Div id="theads">
		<Table  width="75%" align=center id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="5%"  align="center">&nbsp;</th>
			<Th width="30%" align="center">Customer Code</th>
			<Th width="65%" align="left">Customer Name</th>
		</Tr>	
		</Table>
	</Div>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:85%;height:45%;left:8%">
	<Table align=center id="InnerBox1Tab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%				
		for(int i = 0;i < soldToCnt;i++)
		{
%>	
			<Tr>
			<Td width="5%" align="center"><input type="radio" value="<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>" name="cust"></Td>
			<Td width="30%" align="center"><%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%></Td>
			<Td width="65%" align="left"><%=retSoldTo.getFieldValueString(i,"ECA_NAME")%></Td>
			</Tr>
<%
		}
%>				
	</Table>
	</Div>
	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Change Password");
		buttonMethod.add("changePassword()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Div>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
