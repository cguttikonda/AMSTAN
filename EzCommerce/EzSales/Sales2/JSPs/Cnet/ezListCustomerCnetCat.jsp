<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Cnet/iListCustomerCnetCat.jsp"%> 
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%> 
<script>
	function updateCustCat()
	{
		if(document.myForm.soldTo.value!='sel')
		{ 
			document.myForm.action = "ezUpdateCustomerCnetCat.jsp"   
			document.myForm.submit()
		}
		else
			alert("Please select a customer");
	}
	function changeSoldTo()
	{
		if(document.myForm.soldTo.value!='sel')
		{
			document.myForm.action = "ezListCustomerCnetCat.jsp"
			document.myForm.submit()
		}
	}
	function popAlert()
	{
		<%if("Y".equals(upd)){%>
			alert('Categories updated')
		<%}%>
	}
	
</script> 
</head>

<body scroll="yes" onLoad="popAlert()">
<form name="myForm" method="post">

<%
if(soldToCnt==0)
{
	noDataStatement = "No customer(s) present";
%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	return;
}
%>

	<table width="95%" style="position:relative;background-color:white;width:95%;left:3%;border:1px solid;border-color:lightgrey;padding:0px;">  
	<tr> 
		<td width="70%" align="right" style="background-color:#ABCDCE">
		
		<b>Customer</b><select name='soldTo' id="soldTo" tabIndex=2 style="border:1px solid;align:right" onChange= 'changeSoldTo()'>
		<option value="sel">Select Customer</option>
<%				
		String sel = "";
		for(int i = 0;i < soldToCnt;i++)
		{
			if(soldTo!=null && soldTo.equals(retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")))
				sel = "selected";
			else
				sel = "";
%>						
			<option value="<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>" <%=sel%>><%=retSoldTo.getFieldValueString(i,"ECA_NAME")%>[<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>]</option>
<%
		}
%>				
		</select>
		</td>
		<td width="30%" align="left" style="background-color:#ABCDCE">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Update");
	buttonMethod.add("updateCustCat()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
		
		</td>
	</tr>
	</table>
  
<%
if(soldTo==null)
{
	noDataStatement = "Please select customer";
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
}
else if(soldTo!=null && retCatCnt==0)
{
	noDataStatement = "No categories present";
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
}
else
{
%>
	<input type="hidden" name="soldToSel" value="<%=soldTo%>">
	<input type="hidden" name="retCatCnt" value="<%=retCatCnt%>">
	<Div  id="categoriesDiv" style="position:relative;background-color:white;width:95%;left:3%;border:1px solid;border-color:lightgrey;padding:0px;">
	<table width="100%" style="background-color:whitesmoke">
	<tr>
<%
	String catID = "",catDesc="",selCat="";
	retCat.sort(new String[]{"EMM_TYPE"},true);
	for(int i=1;i<=retCatCnt;i++)
	{
		catID = retCat.getFieldValueString(i-1,"EMM_TYPE"); 
		catDesc = retCat.getFieldValueString(i-1,"EMM_FAMILY"); 
		if(catDesc!=null)
		{
			catDesc = replaceString(catDesc,"&","¥");
			catDesc = replaceString(catDesc,"'","`");
		}
		
		if(selCustCat.contains(catID))
			selCat = "checked";
		else
			selCat = "";
		
%>
		<td width="33%" style="background-color:whitesmoke"> 
		<input type="checkbox" name="ic_<%=i%>" <%=selCat%> value="<%=catID%>"><%=retCat.getFieldValueString(i-1,"EMM_FAMILY")%>
		</td>
<%
		if(i%3==0 && i!=retCatCnt) 
		{
%>
			</tr>
			<tr>
<%
		}
	}
	if(retCatCnt%3!=0)
	{
		for(int k=0;k<retCatCnt%3;k++)
		{
%>
		<td width="33%" style="background-color:whitesmoke">
		&nbsp;
		</td>
<%
		}
	}
%>
	</tr>
	</table>
	</Div>
   <DIV >
   <center>

  </center>
  </div>   
<%
}
%>

</form>
</body>
<Div id="MenuSol"></Div>
</html>
