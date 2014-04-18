<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPSummaryBySysKey.jsp"%>

<html>
<head>
<Title>Business Partner Summary</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezBPSummaryBySysKey.js">
<script src="../../Library/JavaScript/ezTabScroll.js">
</script>
</head>
<%
	if(ret.getRowCount()!=0)
	{
%>
		<body onLoad="asBrow();">
<%
	}
	else
	{
%>
		<body onLoad="asBrow()">
<%
	}
%>


<% String browFlag = "IE"; %>
<script language="JavaScript">
function asBrow()
{
	if(navigator.appName=="Netscape")
	{
		<% browFlag = "NS"; %>
	}
	else
	{
		<% browFlag = "IE"; %>
	}
} //end asBrow

</script>
<%

	String isIntranetBP = "";
	String addr1="";
	String addr2="";
	String state="";
	String country="";
	String Zip="";
	if(ret1!=null && !"sel".equals(Bus_Partner) )
	{

		addr1 = retbpinfo.getFieldValueString(0,"ECA_ADDR_1");
		if ( addr1.equals("null") )addr1="";
		addr2 = retbpinfo.getFieldValueString(0,"ECA_ADDR_2");
		if ( addr2.equals("null") )addr2="";
		state = retbpinfo.getFieldValueString(0,"ECA_STATE");
		country = retbpinfo.getFieldValueString(0,"ECA_COUNTRY");
		Zip = retbpinfo.getFieldValueString(0,"ECA_POSTAL_CODE");
	}
%>
<br>

<form name=myForm method=post action="">
<%


	if(ret.getRowCount()==0)
	{

%>

		<br>
		<br>
		<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No <%=areaLabel%> To List</div>
	    </Td>
	  </Tr></Table>
	  		<input type="hidden" name="Area" value="<%=areaFlag%>">
	  		<input type ="hidden" name="flag" value="1">
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
	return;
	}

%>

<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">

      <Th width="20%" class="labelcell">
        <div align="right">Business Partner:</div>
      </Th>
      <Td width="20%" class="blankcell">

<%
		String buspar=null;
		for(int i=0;i<ret1.getRowCount();i++)
		{
			if(Bus_Partner.equals(ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")))
			{
				 buspar=ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
				 break;
			}
		}
%>
		<%=buspar%>
      </Td>
<!--     <Td width="10%" align="center">
	  <img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="funsubmit1('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
	</Td>-->
    </Tr>
</Table>

<%

		if(ret1!=null)
		{
			if(ret1.getRowCount()==0 && !"sel".equals(websyskey))
			{
%>

				<input type="hidden" name="Area" value="<%=areaFlag%>">
				<input type ="hidden" name="flag" value="1">
				<center>No Partners Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></center>
<% 			return;
			}
		}

%>

<%

	if(ret1!=null && !"sel".equals(websyskey))
	{

		if(!"sel".equals(Bus_Partner))
		{

%>
<div id="theads" align="center">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
  <Tr align="center">
    <Td class="displayheader" nowrap>Business
      Partner Summary</Td>
  </Tr>
</Table>
</div>

<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
    <Tr >
      <Td valign="top">
   <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
  <%
	String numUsers = retconfig.getFieldValueString(0,"EBPC_UNLIMITED_USERS");
	if ( numUsers.equals("Y") )
	{
		numUsers = "Unlimited Users";
	}
	else
	{
		numUsers = retconfig.getFieldValueString(0,"EBPC_NUMBER_OF_USERS");
	}

	isIntranetBP = retconfig.getFieldValueString(0,"EPBC_INTRANET_FLAG");
	if ( isIntranetBP.equals("Y"))
	{
		isIntranetBP = "Yes";
	}
	else
	{
		isIntranetBP = "No";
	}

%>
          <Tr >
            <Td width="49%" height="17"><font face="Arial, Helvetica, sans-serif" size="2"><b>Max.
              No of Users:</b></font></Td>
            <Td width="51%" height="17"><%=numUsers%></Td>
          </Tr>
          <Tr valign="top" >
            <Td width="49%" nowrap height="17"><font face="Arial, Helvetica, sans-serif" size="2"><b>Intranet
              Business Partner:</b></font></Td>
            <Td width="51%" height="17"><%=isIntranetBP%></Td>
          </Tr>
          <Tr >
            <Td width="49%" nowrap><font face="Arial, Helvetica, sans-serif" size="2"><b>Selected
              Catalog:</b></font></Td>
            <Td width="51%" nowrap><font face="Arial, Helvetica, sans-serif" size="2"><b><%= CatalogNumberDesc %></b></font>
            </Td>
          </Tr>
        </Table>
</div>
      </Td>
      <Td valign="top">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
          <%
	if ( numBPUsers > 0 )
	{
%>
          <Tr >
            <Th colspan="2" nowrap><div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b>
			Users Assigned to Business Partner</b></font></div>
            </Th>
          </Tr>
          <Tr >
            <Td width="49%" ><b><font face="Arial, Helvetica, sans-serif" size="2">User
              </font></b></Td>
            <Td width="51%" ><b> <font face="Arial, Helvetica, sans-serif" size="2">Description
              </font></b></Td>
          </Tr>
<%
		for ( int i = 0; i < numBPUsers; i++)
		{
		   String isBuiltIn = retbpusers.getFieldValueString(i,"EU_IS_BUILT_IN_USER");
		   isBuiltIn = isBuiltIn.trim();
		   String uId = retbpusers.getFieldValueString(i,"EU_ID");
		   String uName = retbpusers.getFieldValueString(i,"EU_FIRST_NAME");
		   uName += " "+retbpusers.getFieldValueString(i,"EU_LAST_NAME");
		   String userUrl = "";
		   if ( isIntranetBP.equals("Yes") )
		   {
				userUrl = "../User/ezChangeIntranetUserData.jsp?UserID="+uId+"&Show=Yes";
		   }
		   else
		   {
				userUrl = "../User/ezUserDetails.jsp?UserID="+uId;
		   }
%>
          <Tr >
            <Td width="49%" height="32"><a href="<%=userUrl%>"><%=uId %></a></Td>
            <Td width="51%" height="32"><%= uName %></Td>
          </Tr>
<%
		} //end for
%>
          <Tr >
            <Td colspan="2" height="32">
              <div align="center">
               <img   src="../../Images/Buttons/<%=ButtonDir%>/viewuserareas.gif" name="userarea"  onClick="UsersSummary()" style="cursor:hand">
              </div>
            </Td>
          </Tr>
<%
	}
	else
	{
%>
          <Tr>
            <Th colspan="2" nowrap class="displayheader">No Users
              Assigned to Business Partner</Th>
          </Tr>
<%
	} //end numUsers
%>
        </Table>

      </Td>
    </Tr>
  </Table>
<%
	if ( browFlag.equals("IE") )
	{
%>
		<div id="bparea" style="position:absolute; visibility: visible;">
<%
	}
	else
	{
%>
		<layer visiblity=show>
<%
	}
%>
<div id="InnerBox1Div">
  <Table id="InnerBox1Tab" width="89%" align="center">
    <Tr>
      <Td valign="top" align="center" class="blankcell" colspan="2">
        <div></div>
          <Table align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0" width="100%">
            <% if ( retRows > 0 ) { %>
            <Tr >
              <Th  colspan="2" class="labelcell">
                <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b>Synchronizable
                  Areas</b></font></div>
              </Th>
            </Tr>
            <Tr >
              <Th><font face="Arial, Helvetica, sans-serif" size="2"><b>Systems
                </b></font></Th>
              <Th><font face="Arial, Helvetica, sans-serif" size="2"><b>Description
                </b></font></Th>
            </Tr>
            <% } %> <%
String Area = null;
String AreaCheckBoxFlag = null;
String AreaCheckBox = null;
String System = null;
String CheckBox = null;
String checkSystemDesc = "";
int sysCount = -1;
for( int j = 0; j < retRows; j++)
{
String SystemDesc = "System - "+retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
if ( !SystemDesc.equals(checkSystemDesc) )
{
sysCount++;
System = "ChkSys_"+sysCount;
String isCatalogAreaSelected = "";
String CatalogSystemNo = retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
if ( retbpsys.find(BPP_KEY_VALUE,CatalogSystemNo) )
{
    isCatalogAreaSelected = "checked disabled";
}
else
{
    isCatalogAreaSelected = "";
}
%>
            <Tr >
              <Td>
                <input type="checkbox" name="<%= System %>" value="<%= retCatAreas.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isCatalogAreaSelected %> disabled>
                <%= SystemDesc %> </Td>
              <Td>&nbsp;</Td>
            </Tr>
            <%
} //end if
	for( int i=0; i<1; i++)
	{
      String catAreaDesc = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
	CheckBox = "CheckBox_"+i;
	%>
            <Tr >
              <Td>&nbsp;</Td>
              <Td>
                <input type="checkbox" name="<%= CheckBox %>" value="checkbox" checked disabled>
                <%= catAreaDesc %></Td>
            </Tr>
            <%
	}
	checkSystemDesc = SystemDesc;
}
%>
          </Table>
            <% if ( retOrgRows > 0 ) { %>
        <div align="center">

          <Table width="100%" align="center" bordercolor="#336699" cellpadding="0" cellspacing="0" border="1">
            <Tr>
              <Th colspan="4" nowrap class="labelcell">
                <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b>Non
                    Synchronizable Areas</b></font></div>
                </Th>
              </Tr>

            <Tr>
              <Th width="35%" nowrap><font face="Arial, Helvetica, sans-serif" size="2"><b>Systems
                </b></font></Th>

              <Th width="30%" nowrap><font face="Arial, Helvetica, sans-serif" size="2"><b>
                Area Type</b></font></Th>

              <Th width="35%" nowrap><font face="Arial, Helvetica, sans-serif" size="2"><b>
                Description</b></font></Th>
              </Tr>
              <%


String checkOrgDesc = retOrgs.getFieldValueString(0,"ESKD_SYS_NO");
String checkOrgFlag = "";
for ( int j = 0; j < retOrgRows; j++ )
{
String OrgDesc = "System - "+retOrgs.getFieldValueString(j,"ESKD_SYS_NO");

if ( !OrgDesc.equals(checkOrgDesc) )
{
sysCount++;
Area = "ChkSys_"+sysCount;
String isOrgAreaSelected = "";
String OrgSystemNo = retOrgs.getFieldValueString(j,"ESKD_SYS_NO");

if ( retbpsys.find(BPP_KEY_VALUE,OrgSystemNo) )
{
    isOrgAreaSelected = "checked disabled";
}
else
{
	continue;
}

%>

            <Tr>
              <Td width="40%" nowrap>
                <input type="checkbox" name="<%= Area %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isOrgAreaSelected %> disabled>
                  <%=OrgDesc%></Td>

              <Td width="38%">&nbsp;</Td>

              <Td>&nbsp;</Td>
              </Tr>
              <%
} //end if
	      String orgAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
            String actAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY");
	      String orgFlag = retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG");
      	String orgFlagDesc = "";

            String isOrgDescSelected = "";
		if ( retbpareas.find("ESKD_SYS_KEY",actAreaDesc) )
		{
		    isOrgDescSelected = "checked";
		}
		else
		{
		    isOrgDescSelected = "";
		}

	      if ( orgFlag.equals("C") ) {orgFlagDesc="Sales Area";}
	      else if ( orgFlag.equals("V") ) { orgFlagDesc="Purchase Area"; }
	      else if ( orgFlag.equals("S") ) { orgFlagDesc="Service Area"; }
	      else { orgFlagDesc="Service Area"; }

	      if ( (!orgFlag.equals(checkOrgFlag)) || (j == retOrgRows-1) )
	      {
        %>

            <Tr>
              <Td width="40%">&nbsp;</Td>

              <Td width="38%"> <font face="Arial, Helvetica, sans-serif" size="2"><b>
                <%=orgFlagDesc%></b></font></Td>

              <Td>&nbsp;</Td>
              </Tr>
              <%
	}
	%>

            <Tr>
              <Td width="40%">&nbsp;</Td>
                <Td width="38%">&nbsp;</Td>
                <Td width="38%">
                  <input type="hidden" name = "<%= AreaCheckBox%>CHG" value = "N" >
                  <input type="checkbox" name="<%= AreaCheckBox %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY") %>" <%= isOrgDescSelected %> onClick="CHG(this.name, <%=sysCount%>)" disabled>
                  <%=orgAreaDesc%>
                  <input type="hidden" name="<%= AreaCheckBoxFlag %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG")%>">
                </Td>
                <input type="hidden" name="<%= AreaCheckBox%>VAL" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY")%>">
              </Tr>
              <%
      checkOrgDesc = OrgDesc;
      checkOrgFlag = orgFlag;
}

/**
Keep the row count in hidden type for processing while saving this information
**/
            sysCount++; //Since sysCount starts with -1;
%>
		<input type="hidden" name="TotalCount" value=<%=sysCount%> >
		<input type="hidden" name="AreaCount" value=<%=retOrgRows%> >

            </Table>
          
        </div>
<%}%>
      </Td>
    </Tr>
  </Table>
</div>
<% /** Paste ends here **/ %>
<%
	if ( browFlag.equals("IE") )
	{
%>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
		</div>
<%

	}
	else
	{
%>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
		</layer>
<%

	}
%>
<%
	if ( browFlag.equals("IE") )
	{
%>
		<div id="bpuser"   style="position:absolute;left:10%; visibility: hidden;" >
<%
	}
	else
	{
%>
		<layer visiblity=hide>
<%
	}
%>
<%
if ( !isIntranetBP.equals("Yes") )
{
%>
	<div id="InnerBox1Div">
      <Table id="InnerBox1Tab" width="80%" align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0">
	     	<Tr >
              <Th colspan="3" nowrap class="labelcell">
                <font face="Arial, Helvetica, sans-serif" size="2"><b>Business User
                   Areas</b></font>
              </Th>
            </Tr>
            <Tr >
              <Td width="40%"><font face="Arial, Helvetica, sans-serif" size="2"><b>User
                </b></font></Td>
              <Td width="38%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Area</b></font></Td>
              <Td width="38%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Customer
                </b></font></Td>
            </Tr>
<%
	for( int j = 0; j < numBPUsers; j++)
	{
		ReturnObjFromRetrieve retS = (ReturnObjFromRetrieve)retSoldTo[j];
		int soldLen = retS.getRowCount();
		String chgUid = "";
		String chgUArea = "";
		for ( int i = 0; i < soldLen; i++)
		{
		   	String isBuiltIn = retbpusers.getFieldValueString(j,"EU_IS_BUILT_IN_USER");
		   	isBuiltIn = isBuiltIn.trim();
		   	if ( isBuiltIn.equals("N") )continue;

			// Erp Customer Number
			String uId = retbpusers.getFieldValueString(j,"EU_ID" );
			String erp_cust_no = retS.getFieldValueString(i,"ECA_NO");
			String userArea = retS.getFieldValueString("EUD_SYS_KEY");
			String ezc_cust_no = retS.getFieldValueString(i,"EC_NO"); // TBD : We need to think about it
			if ( !chgUid.equals(uId) )
			{
%>
				<Tr>
				<Td width="40%">
		      	<B><%=uId%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
			if ( !chgUArea.equals(userArea) )
			{
%>
				<Tr>
				<Td width="40%">&nbsp;
				</Td>
				<Td nowrap width="38%">
		      	<B><%=userArea%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
%>
			<Tr>
			<Td width="40%">&nbsp;
			</Td>
			<Td width="38%">&nbsp;
			</Td>
			<Td nowrap width="38%">
		      <%=retS.getFieldValueString(i,ERP_CUST_NAME)%>(<%=erp_cust_no%>)
		   	</Td>
			</Tr>
<%
			chgUid = uId;
			chgUArea = userArea;
		}
	}
%>
</Table>
</div>
<%
}
else
{
%>
      <Table  width="90%" align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0">
      	<Tr >
              <Th colspan="3" nowrap class="labelcell">
                <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b>Intranet User
                   Areas</b></font></div>
              </Th>
            </Tr>
            <Tr>
              <Td width="40%"><font face="Arial, Helvetica, sans-serif" size="2"><b>User ID
                </b></font></Td>
              <Td width="38%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Area</b></font></Td>
              <Td width="38%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Customer
                </b></font></Td>
            </Tr>
<%

	for( int j = 0; j < numBPUsers; j++)
	{
		ReturnObjFromRetrieve retUA = (ReturnObjFromRetrieve)retUserAreas[j];
		int usLen = retUA.getRowCount();
		String chgUid = "";
		String chgUArea = "";
		for ( int i = 0; i < usLen; i++)
		{
			// Erp Customer Number
			String uId = retbpusers.getFieldValueString(j,"EU_ID" );
			String erp_cust_no = retUA.getFieldValueString(i,"ECA_NO");
			String userArea = retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
			String ezc_cust_no = retUA.getFieldValueString(i,"EC_NO"); // TBD : We need to think about it
			if ( !chgUid.equals(uId) )
			{
%>
				<Tr>
				<Td width="40%">
		      	<B><%=uId%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
			if ( !chgUArea.equals(userArea) )
			{
%>
				<Tr>
				<Td width="40%">&nbsp;
				</Td>
				<Td nowrap width="38%">
		      	<B><%=userArea%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
%>
			<Tr>
			<Td width="40%">&nbsp;
			</Td>
			<Td width="38%">&nbsp;
			</Td>
			<Td nowrap width="38%">
		     <%=retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC") %>
		     	</Td>
			</Tr>
<%
			chgUid = uId;
			chgUArea = userArea;
		}
	}
%>
</Table>
<%
} //end if isIntranetBP
%>
<%
	if ( browFlag.equals("IE") )
	{
%>
		<br>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
		</div>
<%

	}
	else
	{
%>
		<br>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
		</layer>
<%

	}
%>

<%
}
else
{
%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select Bussiness Partner to continue.</b></div>
				</Td>
			</Tr>
		</Table>
		<br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>

<%
}
}
else
{
%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
					<Td class = "labelcell">
					<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and Bussiness Partner to continue.</b></div>
				</Td>
				</Tr>
			</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>

<%
}
%>

<input type="hidden" name="Area" value="<%=areaFlag%>">

</form>
</body>
</html>

