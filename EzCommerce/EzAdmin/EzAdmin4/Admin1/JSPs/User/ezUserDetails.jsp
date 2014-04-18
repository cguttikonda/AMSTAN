<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserDetails.jsp"%>
<%
	String myWSKey = (String)session.getValue("myWebSyskey");
	String myAFlag = (String)session.getValue("myAreaFlag");

%>
<html>
<head>
<Title>User Details</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezUserDetails.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
<form name=myForm method=post action="">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr align="center">
      		<Td class="displayheader">Basic Information for <%=ret.getFieldValueString(0,USER_ID)%></Td>
    	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
   	<Tr>
      	<Td width="52%" class="blankcell">
	<Table  border=1 align='left' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
          	<Tr>
            		<Td width="43%" class="labelcell" align = "right">User ID:</Td>
            		<Td width="57%"><%=ret.getFieldValueString(0,USER_ID)%></Td>
          	</Tr>
          	<Tr>
            		<Td width="43%" class="labelcell" align = "right">First Name:</Td>
            		<Td width="57%"><%=ret.getFieldValueString(0,USER_FIRST_NAME)%></Td>
          	</Tr>
<%
		String midint = (String) ret.getFieldValue(0,USER_MIDDLE_INIT);
		if ( midint == null )midint = "";
%>
          	<Tr>
            		<Td  width="43%" class="labelcell" align = "right">Middle Initial:</Td>
            		<Td width="57%"><%=midint%>&nbsp;</Td>
          	</Tr>
          	<Tr>
            	<Td  width="43%" class="labelcell" align = "right">Last Name:</Td>
            	<Td width="57%"><%=ret.getFieldValueString(0,USER_LAST_NAME)%></Td>
          	</Tr>
          	<Tr>
          	  	<Td  width="43%" class="labelcell" align = "right">Email:</Td>
            		<Td width="57%"><%=ret.getFieldValueString(0,USER_EMAIL)%></Td>
          	</Tr>
      	</Table>
      	</Td>
      	<Td width="48%" class="blankcell" valign = top>
	<Table  border=1 align='left' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
<%
		String uType = ret.getFieldValueString(0,USER_TYPE);
		String selB = "";
		String selI = "";
		if ( uType.equals("3") )
     			selB = "selected";
		else
		     selI = "selected";

		String aType = ret.getFieldValueString(0,USER_BUILT_IN);
		String aus = "";
		if ( uType.equals("2") && aType.equals("Y") )
		     aus = "checked";
%>
          	<Tr>
          	  	<Td width="43%" class="labelcell" align = "right">User Type:</Td>
          	  	<Td width="57%">Business User</Td>
          	</Tr>
          	<Tr>
            		<Td width="43%" class="labelcell" align = "right">Admin User:</Td>
            		<Td width="57%"><input type="checkbox" disabled name="Admin" <%= aus %>></Td>
          	</Tr>
          	<Tr>
            	<Td width="43%" class="labelcell" align = "right">Business Partner:</Td>
            	<Td width="57%">
<%
		int bpRows = retbp.getRowCount();
		String companyName = null;
		String Bus_Partner = (String)(ret.getFieldValue(0,USER_BUSINESS_PARTNER));
		if ( bpRows > 0 )
		{
			for ( int i = 0 ; i < bpRows ; i++ )
			{
				String val = (retbp.getFieldValue(i,BP_NUMBER)).toString();
				if(Bus_Partner.equals(val))
				{
					companyName = (String)retbp.getFieldValue(i,BP_COMPANY_NAME);
				}
			}




			if (companyName != null)
			{
%>
				<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=webSysKey%>&Area=<%=myAFlag%>&BusinessPartner=<%=Bus_Partner.trim()%>"> <%=companyName%></a>
<%
			}
		}
%>
            	</Td>
          	</Tr>
          	<Tr>
            	<Td width="43%" class="labelcell"  align = "right">Catalog:</Td>
<%
		String catalog = retcat.getFieldValueString(0,CATALOG_DESC);
		String catalogNo = retcat.getFieldValueString(0,"EPC_NO");
		if (catalog.equals("null") || "null".equals(catalog))
			catalog = "";
		if (catalogNo.equals("null") || "null".equals(catalogNo))
			catalogNo = "";
%>
            	<Td width="57%"><a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catalogNo%>&catDesc=<%=catalog%>"><%=catalog%></a>&nbsp;</Td>
          	</Tr>
        </Table>
      	</Td>
    	</Tr>
</Table>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0">
<Tr align="center">
	<Td colspan="2" class="labelcell"> ERP Customers</Td>
</Tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	int syskeyCount = 0;
	int custRows 	= retsoldto.getRowCount();
	
	if(retSyskey!=null)
		syskeyCount = retSyskey.getRowCount();
		
	String soldToSyskey = null;
	if ( custRows > 0 )
	{
		for ( int i = 0 ; i < custRows; i++ )
		{
			String pFunction = retsoldto.getFieldValueString(i,"EC_PARTNER_FUNCTION");
			pFunction  = pFunction.trim();
			if ( pFunction.equals("AG") || pFunction.equals("VN") )
			{
				soldToSyskey = retsoldto.getFieldValueString(i,"EC_SYS_KEY");
				for(int j=0;j<syskeyCount;j++)
				{
					if(soldToSyskey.equals(retSyskey.getFieldValueString(j,"ESKD_SYS_KEY")))
					{
%>
						<Tr>
						<Td colspan = "2" align="left">
							<input type="checkbox" disabled name="CheckBox" value="Selected" checked>
							<%=retsoldto.getFieldValue(i,ERP_CUST_NAME)%>&nbsp;
							(<%=retsoldto.getFieldValue(i,"EC_ERP_CUST_NO")%>)&nbsp;
							 <a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=myAFlag%>&SystemKey=<%=soldToSyskey%>"><%=retSyskey.getFieldValueString(j,"ESKD_SYS_KEY_DESC")%>&nbsp;
							(<%=soldToSyskey%>)</a>
		        			</Td>
						</Tr>
<%
					}
				}
			}
  		}
	}
%>
</Table>
</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:85%;width:100%">
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>
</form>
</body>
</html>
