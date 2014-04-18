<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLoginBanner_Lables.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import = "ezc.ezmisc.params.*,ezc.ezparam.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session" />
<%
	
 	String username		=Session.getUserId();
 	String agent		=(String)session.getValue("Agent");
 	String ctry		=(String)session.getValue("Country");
	String userRole		=(String)session.getValue("UserRole");
 	String userRoleDesc	=null;
  	String SalesType	=(String)session.getValue("SalesType");
  	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
	String user=Session.getUserId();	
  	
 	if (SalesType==null) SalesType=" ";
 	
 	if("LF".equals(userRole))
 		userRoleDesc="Regional Manager"; 
 	else if("CM".equals(userRole))
 		userRoleDesc="Marketing Manager";
 	else if("CU".equals(userRole))
 		userRoleDesc="Stockist";
 	
 	String xmlTagName  = "Support";	
 	String  reviewToActCnt ="0",savedOrdersCnt="0";
 	
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetWorkFlowSessionUsers.jsp"%>
<%
	String send_U = "";
	
	if("CU".equals(userRole))
		send_U = superiorsusers;
	else
		send_U = sabardinates;


 	EzcParams reviewMainParams = new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	//miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_WF_DOC_HISTORY_HEADER WHERE EWDHH_NEXT_PARTICIPANT IN(SELECT EWWU_GROUP FROM EZC_WF_WORKGROUP_USERS WHERE EWWU_USER='"+username+"') AND EWDHH_MODIFIED_BY !='"+username+"' AND EWDHH_WF_STATUS='NEGOTIATED'");
	miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_SYSKEY IN('"+salesAreaCode+"') AND  EWDHH_WF_STATUS IN ('NEGOTIATED') AND EWDHH_CREATED_BY IN('"+user+"','"+send_U+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN('"+agentCode+"')");
	reviewMainParams.setLocalStore("Y");
	reviewMainParams.setObject(miscParams);
	Session.prepareParams(reviewMainParams);
	
	ezc.ezparam.ReturnObjFromRetrieve reviewOrdersObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(reviewMainParams);
 	
 	if(reviewOrdersObj!=null && reviewOrdersObj.getRowCount()>0) 	
 	reviewToActCnt = reviewOrdersObj.getFieldValueString(0,"REVIEW_COUNT");
 	
 	
 	reviewMainParams = new EzcParams(false);
	miscParams = new EziMiscParams();

	//miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_WF_DOC_HISTORY_HEADER WHERE EWDHH_NEXT_PARTICIPANT IN(SELECT EWWU_GROUP FROM EZC_WF_WORKGROUP_USERS WHERE EWWU_USER='"+username+"') AND EWDHH_MODIFIED_BY !='"+username+"' AND EWDHH_WF_STATUS='NEGOTIATED'");
	miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_SYSKEY IN('"+salesAreaCode+"') AND  EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN('"+user+"','"+send_U+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN('"+agentCode+"')");
	reviewMainParams.setLocalStore("Y");
	reviewMainParams.setObject(miscParams);
	Session.prepareParams(reviewMainParams);

	ezc.ezparam.ReturnObjFromRetrieve savedOrdersObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(reviewMainParams);

	if(savedOrdersObj!=null && savedOrdersObj.getRowCount()>0) 	
 	savedOrdersCnt = savedOrdersObj.getFieldValueString(0,"REVIEW_COUNT");
 	
 	
 %>	
 	<%@ include file="ezXMLDataRead.jsp"%> 
 <%
 	String XMLsupportid=xmlTagValue;	
 %>
 

<HTML>
<HEAD>

<title>Welcome To American Standard</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	function callFun(clickedOn)
	{
		if(clickedOn=='H')
		{
			top.display.location.href = "ezWelcome.jsp";
		}	
		else if(clickedOn=='L')
		{
			top.location.href='../Misc/ezLogout.jsp'
		} 
	}
	
	function search()
	{
		var searcObj =document.myForm.searchBy;
		var selVal   =searcObj.value;
		
		if(selVal==''){
			alert('Please select search key');
			searcObj.focus();
			return;
		}else{
			top.display.location.href="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp?searcKey="+selVal;
		}
	}
	
	function funCRILogo()
	{
		parent.document.getElementById("display").src="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
	}
	
</Script>
<Style>
	a{
	   color: #30366A;
	   text-decoration:none;
	}
	
	a:link{
	   color: #30366A;
	   text-decoration:none;
	}
	
	a:hover{
	   color: #30366A;
	   text-decoration:underline;
	   font-weight:normal
	}
	
	a:visited{
	   color: #30366A;
	}
</Style>	
</HEAD>

<Body leftMargin=0 topMargin=0 bgcolor='#FFFFFF' MARGINWIDTH="0" MARGINHEIGHT="0">
<Form name="myForm" method="POST">
<input type=hidden name='changePurArea' value='N'>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0  class='blankcell'>
<TR>
<TD width=100% valign=top bgcolor="#FFFFFF">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 class='blankcell'>
	
	<TR class='blankcell'>
		<Td width='10%' class='blankcell' > 
			<!--<a href="javascript:funCRILogo()"><IMG src="../../../../EzCommon/Images/Banner/ansr_logo12.jpg" border=0></a> --> 
			<!--<IMG src="../../../../EzCommon/Images/Banner/continental_resources_logo.png" border=0 > --> 
			<IMG src="../../../../EzCommon/Images/Banner/amstd_logo.gif" border=0 >
		</Td> 
		<TD width='40%' valign='center' align='center' class='blankcell' wrap>
			<Font color='#333333' size='1px'  face="Verdana" > <b> Welcome <%=username%> [<%=agent%>]&nbsp;&nbsp;</Font></b><a title="Click here to log out" href="javascript:callFun('L')" style="cursor:hand;text-decoration: none" ><Font color='red' size='1px'  face="Verdana" ><b>( Log Out )</b></Font></a>
			
		</TD>

		<TD width='25%' valign='center' class='blankcell'>
		
		<a title="Click here to View Revieworders" href="../Sales/ezSavedOrdersList.jsp?orderStatus='NEGOTIATED'&RefDocType=P" target="display" style="cursor:hand;text-decoration: none" ><b>Orders in Review  : <Font color='red' size='2px'  face="Verdana">
		<input type="text" class=tx size=1 style="background-color:white;color:red;font-size:12px;font-weight:bold" name="reviewCnt" value="<%=reviewToActCnt%>">
		</Font></b></a>
		<%
		if("CU".equals(userRole))
		{
		%>
		<br>
		<a title="Click here to View Revieworders" href="../Sales/ezSavedOrdersList.jsp?orderStatus='NEW'&RefDocType=P" target="display" style="cursor:hand;text-decoration: none" ><b>Count of Saved Orders  : <Font color='red' size='1px'  face="Verdana">
		<input type="text" class=tx size=1 style="background-color:white;color:red;font-size:12px;font-weight:bold" name="reviewCnt" value="<%=savedOrdersCnt%>">
		</Font></b></a>
		<%
		}
		%>
		</td>
		
		<TD width='25%' valign='center' class='blankcell'>
		<a title="Click here to View Open Invoices" href="../SelfService/ezGridOpenInvoices.jsp?&FromForm=OpenInvoiceList" target="display" style="cursor:hand;text-decoration: none" ><b>Open Invoices  : <Font color='red' size='2px'  face="Verdana">
		<input type="text" class=tx size=1 style="background-color:white;color:red;font-size:12px;font-weight:bold" name="invoiceCnt" value="8">
		</Font></b></a>
		<br>
		<a title="Click here to View Quotes" href="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='SUBMITTED'" target="display" style="cursor:hand;text-decoration: none" ><b>Quotes Expiring this Month  : <Font color='red' size='1px'  face="Verdana">
		<input type="text" class=tx size=1 style="background-color:white;color:red;font-size:12px;font-weight:bold" name="quotesCnt" value="2">
		</Font></b></a>
		</TD>
<%
       if("CM".equals(userRole)){
%>
		<!--<Font color='#333333' size='1px'  face="Verdana">  <a  href='../DrillDownCatalog/ezMyAccount.jsp' target="display" style="cursor:hand;text-decoration: none"><b>&nbsp;&nbsp;|&nbsp;&nbsp; My Account</a></b>-->
<%     } %>
		</TD>



		<!--<TD width='8%' valign='center' class='blankcell' align='right'>
			<Font color='#333333' size='1px' face="Verdana"><b>|&nbsp;&nbsp;SEARCH&nbsp;
		</Td>
		<TD width='12%' valign='center' class='blankcell'> 
			<Select name="searchBy" id=FullListBox style="border:1px solid">
			  <Option value=''>--.--</Option>
			  <Option value='VC'>Vendor Catalog</Option>
			  <Option value='IN'>Product ID</Option>
			  <Option value='ID'>Item Description</Option>
			  <Option value='BN'>Brand Name</Option>
			  <Option value='AS'> Advanced Search</Option> 
			</Select>
			
		</Td>	
		
		<TD width='10%' valign='center' class='blankcell'>
		<a  href='javascript:search()' style="cursor:hand;text-decoration: none">
		 &nbsp;<img src="../../Images/Common/search-icon.gif" border=0>
		</a>
		</Td>-->
			
		
	</TR>
		
	
	</TABLE>
</TD>

</TR>
</Table>
</BODY>

</HTML>