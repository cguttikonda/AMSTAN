<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iChangeIntranetUserData.jsp"%>
<%
	String userId=ret.getFieldValueString(0,USER_ID);
	String firstName=ret.getFieldValueString(0,USER_FIRST_NAME);
	String password=ret.getFieldValueString(0,USER_PASSWORD);
	String middleintial = ret.getFieldValueString(0,USER_MIDDLE_INIT);
	middleintial=("null".equals(middleintial))?"":middleintial;
	String lastName=ret.getFieldValueString(0,USER_LAST_NAME);
	String email=ret.getFieldValueString(0,USER_EMAIL);
	String aType = ret.getFieldValueString(0,USER_BUILT_IN);
	String aus = (aType.equals("Y"))? "checked":"";
	int bpRows = retbp.getRowCount();
	String companyName = null;
	String bpNumber = null;
	String Bus_Partner = ret.getFieldValueString(0,USER_BUSINESS_PARTNER);
	String myKey = retbpareas.getFieldValueString(0,"ESKD_SYS_KEY");
	String myFlag = retbpareas.getFieldValueString(0,"ESKD_SUPP_CUST_FLAG");

	if ( bpRows > 0 )
	{
		for ( int i = 0 ; i < bpRows ; i++ )
		{
			String val = retbp.getFieldValueString(i,BP_NUMBER);
			if(Bus_Partner.equals(val))
			{
				companyName = retbp.getFieldValueString(i,BP_COMPANY_NAME);
				bpNumber = retbp.getFieldValueString(i,BP_NUMBER);
				break;
			}
		}
	}
	String catalogA = retcatuser.getFieldValueString(0,CATALOG_DESC);
	String catalogNum = retcatuser.getFieldValueString(0,CATALOG_DESC_NUMBER);
	if ( catalogA == null || catalogA.equals("null"))
	{
		catalogA = "No Catalogs Selected";
		catalogNum = "0";
	}
%>
<html>
<head>
<Title>Change User Data</Title>
<script  src="../../../Includes/Lib/JavaScript/Users.js"></script>
<script  src="../../Library/JavaScript/ezTabScroll.js"></script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveChangeIntranetUser.jsp ">
<br>
<div id="theads">
<Table id="tabHead" width="89%" align="center" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
  	<Tr align="center">
    	<Td nowrap class="displayheader">View Intranet User Information</Td>
  	</Tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab"  width="89%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
  	<Tr>
      	<Td width="50%" class="blankcell" valign="top">
        <Table  width="100%"  border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
        <Tr>
            	<Td width="43%" class="labelcell"  align="right">User:</Td>
            	<Td width="57%"><%=userId%>
              		<input type="hidden" name="UserID" value="<%= userId%>" >
            	</Td>
       	</Tr>
        <Tr>
           	<Td width="43%" class="labelcell" align="right">First Name:</Td>
            	<Td width="57%"><%=firstName%>
              	<input type="hidden" name="FirstName" size=30 maxlength=60 value="<%=firstName%>">
              	<input type="hidden" name="Password"  value="<%=password%>">
              	<input type="hidden" name="BusPartner" value="<%=BusPartner%>" >
            	</Td>
      	</Tr>
        <Tr>
            	<Td width="43%" class="labelcell" align="right">Middle Initial:</Td>
            	<Td width="57%"><%=middleintial%>
              	<input type="hidden" name="MidInit" size=3 maxlength=3 value="<%=middleintial%>">
            	</Td>
       	</Tr>
        <Tr>
            	<Td width="43%" class="labelcell" align="right">Last Name:</Td>
            	<Td width="57%"><%=lastName%>
			<input type="hidden" name="LastName"   size=30 maxlength=60 value="<%=lastName%>">
	        </Td>
        </Tr>
        <Tr>
            	<Td width="43%" class="labelcell" align="right">Email:</Td>
            	<Td width="57%"><%=email%>
              	<input type="hidden" name="Email"   size=30 maxlength=40 value="<%=email%>">
            	</Td>
      	</Tr>
        <Tr>
            	<Td width="43%" class="labelcell" align="right">User Type:</Td>
            	<Td width="57%">IntranetUser
	            	<input type=hidden name=UserType value="2">
            	</Td>
     	</Tr>
        <Tr>
           	<Td width="43%" class="labelcell" align="right">Admin User:</Td>
            	<Td width="57%">
              	<input type="checkbox"  name="Admin" <%= aus %> disabled >
              	<input type="hidden" name="UserGroup" value="0">
            	</Td>
      	</Tr>
        <Tr>
            	<Td width="43%" class="labelcell" align="right">Business Partner:</Td>
            	<Td width="57%">
<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=myKey%>&Area=<%=myFlag%>&BusinessPartner=<%=Bus_Partner%>"><%=companyName%></a>

		       	<input type=hidden name=PartnerDesc value="<%=companyName%>">
		</Td>
        </Tr>
        </Table>
      	</Td>
      	<Td width="50%" valign="top" class="blankcell">
        <Table width="100%"  border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
        <Tr>
        	<Td class="labelcell" align="right">Catalog:</Td>
            	<Td>
<%
		if ( catalogNum.equals("0") )
		{
			catalogA = "No Catalogs Selected";
%>

				<%=catalogA%>
<%
		}
		else
		{
%>
		<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catalogNum%>&catDesc=<%=catalogA%>"><%=catalogA%></a>
<%
		}
%>

		<input type=hidden name=DisplayCatalog value="<%=catalogA%>">
		<input type="hidden" name="CatalogNumber"  value="<%=catalogNum%>">
		</Td>
        </Tr>
  	<Tr align="center">
        <Td width="100%" colspan="2" class="labelcell"> Selected Sync. Areas </Td>
        </Tr>
<%
	if ( retRows > 0 )
	{
		retcatareas.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		for ( int i = 0 ; i < retRows; i++ )
		{
			String cAreaKey = retcatareas.getFieldValueString(i,"ESKD_SYS_NO");
			String cAreaDesc = retcatareas.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
			String sysDesc = "";
			if ( retcatsys.find("ESD_SYS_NO",cAreaKey) )
	        	{
     		    		int x = retcatsys.getCurrentRowId();
     	    			sysDesc = retcatsys.getFieldValueString(x,"ESD_SYS_DESC");
     			}
%>
			<Tr>
			<Td colspan="2" title = "(<%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=cAreaDesc%>">
				<input type="checkbox" name="ACheckBox" value=<%=cAreaKey%> checked disabled>
				<a href= "../Config/ezSetBusAreaDefaults.jsp?SystemKey=<%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY")%>&Area=C" >
					<input type="text" value="(<%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=cAreaDesc%>"  Class = "DisplayBox" style = "Width:80%;Cursor:hand;text-decoration:underline" readonly>
				</a>
	        	</Td>
			</Tr>
<%
		}
	}
	else
	{
%>
		<Tr>
		<Td colspan="2">
		<font size="2" color="Red">
        	There are no Sales Areas for this Business Partner
        	</font>
        	</Td>
		</Tr>
<%
	}
%>
          	<Tr align="center">
            	<Td width="100%" colspan="2" class="labelcell"> Select Non Sync. Areas </Td>
          	</Tr>
<%
	if ( retbpRows > 0 )
	{
		retbpareas.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		for ( int i = 0 ; i < retbpRows; i++ )
		{
            		String isAreaSelected = "";
            		String intUserArea = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY");
            		if ( retbpSAreas.find("ESKD_SYS_KEY",intUserArea) )
			{
				isAreaSelected="checked";
%>
				<input type="hidden" name="allareakeys" value="<%=retbpareas.getFieldValueString(i,"ESKD_SYS_KEY")%>" >
				<input type="hidden" name="allareaflags" value="<%=retbpareas.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG")%>" >
<%
			}
			else
			{
				isAreaSelected="";
				if ( Show.equals("Yes") )continue;
			}
              		String areaKey = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY");
            		String areaFlag = retbpareas.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
            		String areaDesc = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
            		if ( areaFlag.equals("C") )
			{
				areaDesc = areaDesc+" - Sales Area";
			}
            		else if ( areaFlag.equals("V") )
			{
				areaDesc = areaDesc+" - Purchase Area";
			}
            		else if ( areaFlag.equals("S") )
			{
				areaDesc = areaDesc+" - Service Area";
			}
            		else
			{
				areaDesc = areaDesc+" - Other Area";
			}
%>
		<Tr>
		<Td colspan="2" title = "(<%=areaKey%>) <%=areaDesc%>">
		
		<input type="checkbox" name="CheckBox" value="<%=areaKey%>#<%=areaFlag%>"  <%=isAreaSelected%> disabled>
		<a href= "../Config/ezSetBusAreaDefaults.jsp?SystemKey=<%=areaKey%>&Area=<%=areaFlag%>" >
			<input type="text" value="(<%=areaKey%>) <%=areaDesc%>" Class = "DisplayBox" style = "Width:80%;Cursor:hand;text-decoration:underline" readonly>
		</a>
		</Td>
		</Tr>
<%
		}
	}
	else
	{
%>
		<Tr>
		<Td colspan="2">
		<font size="2" color="Red">
        	There are No Areas for this Business Partner
        	</font>
        	</Td>
		</Tr>
<%
	}
%>
        	</Table>
      		</Td>
    	</Tr>
  	</Table>
	</div>
  	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Information updated successfully');
		</script>
<%
	}
%>
</body>
</html>
