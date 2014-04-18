<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />

<%
	
	String user_id = request.getParameter("UserID");
	
	/***************** Sub User Authorizations Start ******************/
	
	Hashtable subUserAuthHT = new Hashtable();
	
	subUserAuthHT.put("VONLY","View");
	subUserAuthHT.put("VEDIT","View and Edit");
	
	/***************** Sub User Authorizations End ******************/
	
%>
<%@ include file="../../../Includes/JSPs/Misc/iSubUserDetails.jsp"%>


<html>
<head>
<Title>User Details</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=89
	var tabHeight="45%"
</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  onLoad='scrollInit()' onResize='scrollInit()' scroll=no>
<form name=myForm method=post action="">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr align="center">
      		<Td class="displayheader">Basic Information for <%=ret.getFieldValueString(0,"EU_ID")%></Td>
    	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
   
    	
    	<Tr>
		<input type = "hidden" name = "soldTo" value="">
		<Th width = "25%" align="right">User ID</Th>
		<Td width = "25%">&nbsp;<%=ret.getFieldValueString(0,"EU_ID")%></Td>
		<Th width = "25%" align="right">User Name</Th>
		<Td width = "25%">&nbsp;<%=ret.getFieldValueString(0,"EU_FIRST_NAME")%></Td>	
	</Tr>
	<Tr>
	
		<Th width = "25%" align = "right">E Mail</Th>
		<Td width = "25%" >&nbsp;<%=ret.getFieldValueString(0,"EU_EMAIL")%></Td>
		<Th width = "25%" align = "right">Authorization</Td>
		<Td width = "25%">
<%
		String subUserAuth = (String)subUserAuthHT.get(suAuth);
		
		if(subUserAuth==null || "null".equals(subUserAuth)) subUserAuth = "";
%>
		&nbsp;<%=subUserAuth%>
		</Td>	
	</Tr>
	
</Table>

<Div id="theads">
	<Table  width="89%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
     	<Tr align="center">
		<Th> ERP Customers / Purchase Areas</Th>
        </Tr>
        </table>
        </div>
  	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:89%;height:45%;left:2%">
	<Table  align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	int syskeyCount = 0;
	int custRows 	= retsoldto.getRowCount(); 
	
	if(retSyskey!=null)
		syskeyCount = retSyskey.getRowCount(); 
		
	String soldToSyskey = null;
	if ( syskeyCount > 0 )
	{
		for ( int i = 0 ; i < syskeyCount; i++ )
		{
			String Checked = "";
			//String pFunction = retsoldto.getFieldValueString(i,"EC_PARTNER_FUNCTION");
			//pFunction  = pFunction.trim();
			//if ( pFunction.equals("AG") || pFunction.equals("VN") )
			//{
				soldToSyskey = retSyskey.getFieldValueString(i,"eud_sys_key");
				for(int j=0;j<custRows;j++)
				{
					if(soldToSyskey.equals(retsoldto.getFieldValueString(j,"EUD_SYS_KEY")))
						Checked = "checked";
%>
						<Tr>
						<Td colspan = "2" align="left">
							<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO")%>#<%=(retsoldto.getFieldValue(j,"EC_SYS_KEY"))%>" <%=Checked%>>
							<%=retsoldto.getFieldValue(j,"ECA_NAME")%>&nbsp;
							(<%=retsoldto.getFieldValue(j,"EC_ERP_CUST_NO")%>)&nbsp;
							 <%=retSyskey.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>&nbsp;
							(<%=soldToSyskey%>)
						</Td> 
						</Tr>

					<input type=hidden name="SelSoldTo" value="<%=retsoldto.getFieldValueString(j,"EUD_VALUE")%>">
					<input type=hidden name="SelSysKey" value="<%=retsoldto.getFieldValueString(j,"EUD_SYS_KEY")%>">

<%			
				} 
			//}
%>


<%			
			}
	  		
	}
	else
	{
%>
	<Tr>
		<Td>No ERP Customers To List</Td>
	</Tr>
<%
}
%>
</Table>
</div>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	
	out.println(getButtonStr(buttonName,buttonMethod));


%>
<Div id="MenuSol"></Div>
</form>
</body>
</html>
