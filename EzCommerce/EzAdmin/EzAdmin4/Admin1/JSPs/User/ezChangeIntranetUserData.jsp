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
	String myWebSyskey=(String)session.getValue("myWebSyskey");
	String myAreaFlag=(String)session.getValue("myAreaFlag");
	

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
	<script  src="../../../Includes/Lib/JavaScript/Users.js">
	</script>
<script  src="../../Library/JavaScript/ezTabScroll.js"></script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad = "scrollInit()" onResize = "scrollInit()" scroll = "no">
<br>

<form name=myForm method=post action="ezSaveChangeIntranetUser.jsp">
<Table width="89%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
  <Tr align="center">
    <Td nowrap class="displayheader">Change Intranet User Information</Td>
  </Tr>
</Table>

<div id="theads">
  <Table  id="tabHead" width="90%" align="center" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
    <Tr>
      <Th width="100%" colspan="2"> Please go through the following information to change</Th>
    </Tr>
  </Table>
</div>
<div id="InnerBox1Div">
<Table  id="InnerBox1Tab" width="90%" align="center" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
    <Tr>
      <Td width="50%" class="blankcell" valign="top">
        <Table  width="100%" border="0">
          <Tr>
            <Td width="43%" class="labelcell">User:</Td>
            <Td width="57%">
              <input type="hidden" name="UserID" value="<%= userId%>" >
<%
				if("2".equals((String)session.getValue("myUserType")))
				{
%>
					<a href="../User/ezViewIntranetUserData.jsp?UserID=<%= userId%>"><%= userId%></a>
<%
				}
				else
				{
%>
					<a href="../User/ezUserDetails.jsp?UserID=<%= userId%>"><%= userId%></a>
<%
				}
%>	

		
            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">First Name:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="FirstName" size=30 maxlength=60 value="<%=firstName%>">
              <input type="hidden" name="Password"  value="<%=password%>">
              <input type="hidden" name="BusPartner" value="<%=BusPartner%>" >
            </Td>
         </Tr>
          <Tr>
            <Td width="43%" class="labelcell">Middle Initial:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="MidInit" size=3 maxlength=3 value="<%=middleintial%>">
            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">Last Name:</Td>
            <Td width="57%">
			<input type=text class = "InputBox" name="LastName"   size=30 maxlength=60 value="<%=lastName%>">

            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">Email:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="Email"   size=30 maxlength=40 value="<%=email%>">
            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">User Type:</Td>
            <Td width="57%">IntranetUser
	            <input type=hidden name=UserType value="2">
            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">Admin User:</Td>
            <Td width="57%">
              <input type="checkbox"  name="Admin" <%= aus %> >
              <input type="hidden" name="UserGroup" value="0">
            </Td>
          </Tr>
          <Tr>
            <Td width="43%" class="labelcell">Business Partner:</Td>
            <Td width="57%">
		<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=myWebSyskey%>&Area=<%=myAreaFlag%>&BusinessPartner=<%=BusPartner%>"><%=companyName%></a>
		        	<input type=hidden name=PartnerDesc value="<%=companyName%>">
		</Td>
          </Tr>
        </Table>

      </Td>
      <Td width="50%" valign="top" class="blankcell">
	<Table width="100%" border="0">
          <Tr>
            <Td class="labelcell">Catalog:</Td>
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
		<Td colspan="2">
			
			<input type="checkbox" name="ACheckBox" value=<%=cAreaKey%> checked disabled>
			<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=myAreaFlag%>&SystemKey=<%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY")%>"><%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>(<%=retcatareas.getFieldValueString(i,"ESKD_SYS_KEY")%>)&nbsp;</a>

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
if ( retbpRows > 0 ) {
%>

<%
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
            /*if ( areaFlag.equals("C") ){ areaDesc = areaDesc+" - Sales Area";}
            else if ( areaFlag.equals("V") ){ areaDesc = areaDesc+" - Purchase Area";}
            else if ( areaFlag.equals("S") ){ areaDesc = areaDesc+" - Service Area";}
            else { areaDesc = areaDesc+" - Other Area";}*/

%>
		<Tr>
		<label for="cb_<%=i%>">
		<Td colspan="2" title = "<%=areaDesc%> (<%=areaKey%>)">
		<input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=areaKey%>#<%=areaFlag%>"  <%=isAreaSelected%> >
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=areaKey%>">
			<input type = "text" value = "<%=areaDesc%> (<%=areaKey%>)" class = "DisplayBox" size = "30" readonly Style = "Cursor:hand;text-decoration:underline">
		</a>
        	</Td>
		</label>
		</Tr>
<%
	}


}else{
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
  		<input type=hidden name="fromListByRole" value="<%=fromListByRole%>">
  		<input type=hidden name="roleVal" value="<%=roleVal%>">
  		<input type=hidden name="sysVal" value="<%=sysVal%>">

  <div id="ButtonDiv" align="center" style = "position:absolute;top:90%;width:100%">
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" tabindex="12" onClick="checkAll('myForm','ChangeIntranetUser');return document.returnValue;">
    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
</form>

	<script language = "javascript">
		document.myForm.FirstName.focus();
	</script>
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

