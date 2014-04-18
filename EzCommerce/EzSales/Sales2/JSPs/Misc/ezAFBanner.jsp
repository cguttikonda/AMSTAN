<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLoginBanner_Lables.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
 	String username		=Session.getUserId();
 	String agent		=(String)session.getValue("Agent");
 	String ctry		=(String)session.getValue("Country");
	String userRole		=(String)session.getValue("UserRole");
 	String userRoleDesc	=null;
  	String SalesType	=(String)session.getValue("SalesType");
  	
 	if (SalesType==null) SalesType=" ";
 	
 	if("LF".equals(userRole))
 		userRoleDesc="Regional Manager"; 
 	else if("CM".equals(userRole))
 		userRoleDesc="Marketing Manager";
 	else if("CU".equals(userRole))
 		userRoleDesc="Stockist";
 	
 	String xmlTagName  = "Support";	
 %>	
 	<%@ include file="ezXMLDataRead.jsp"%> 
 <%
 	String XMLsupportid=xmlTagValue;	
 %>
 

<HTML>
<HEAD>

<title><%= getLabel("BRW_TITLE") %></title>
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
			<IMG src="../../../../EzCommon/Images/Banner/aflogo.jpg" border=0>
			<!--<IMG src="../../../../EzCommon/Images/Banner/ansr_logo12.jpg" border=0 > --> 
		</Td> 
		<TD width='50%' valign='center' align='right' class='blankcell' wrap>
			<Font color='#333333' size='1px'  face="Verdana" > <b> Welcome <%=username%> [<%=agent%>]&nbsp;&nbsp;</Font></b><a title="Click here to log out" href="javascript:callFun('L')" style="cursor:hand;text-decoration: none" ><Font color='red' size='1px'  face="Verdana" ><b>( Log Out )</b></Font></a>
		</TD>

		<TD width='15%' valign='center' class='blankcell'>
<%
       if("CM".equals(userRole)){
%>
		<Font color='#333333' size='1px'  face="Verdana">  <a  href='../DrillDownCatalog/ezMyAccount.jsp' target="display" style="cursor:hand;text-decoration: none"><b>&nbsp;&nbsp;|&nbsp;&nbsp; My Account</a></b>
<%     } %>
		</TD>



		<TD width='8%' valign='center' class='blankcell' align='right'>
			<Font color='#333333' size='1px' face="Verdana"><b>|&nbsp;&nbsp;SEARCH&nbsp;
		</Td>
		<TD width='12%' valign='center' class='blankcell'> 
			<Select name="searchBy" id=FullListBox>
			  <Option value=''>--.--</Option>
			  <Option value='VC'>Vendor Catalog</Option>
			  <Option value='IN'>Product ID</Option>
			  <!--<Option value='ID'>Item Description</Option>-->
			  <!--<Option value='BN'>Brand Name</Option>-->
			  <Option value='AS'> Advanced Search</Option> 
			</Select>
			
		</Td>	
		
		<TD width='10%' valign='center' class='blankcell'>
		<a  href='javascript:search()' style="cursor:hand;text-decoration: none">
		 &nbsp;<img src="../../Images/Common/search-icon.gif" border=0>
		</a>
		</Td>
		
	</TR>
	
	</TABLE>
</TD>

</TR>
</Table>
</BODY>

</HTML>