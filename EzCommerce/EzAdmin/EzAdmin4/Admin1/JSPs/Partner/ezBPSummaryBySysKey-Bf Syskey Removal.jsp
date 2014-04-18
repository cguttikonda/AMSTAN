<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPSummaryBySysKey.jsp"%>
<html>
<head>
<Title>Business Partner Summary</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script>
function UsersSummary(opt)
{
	if(opt ==1)
	{
		document.getElementById("bparea").style.display = "none";
		document.getElementById("bpuser").style.display = "";
		document.getElementById("myUserButton").style.display = "none";
		document.getElementById("myPartnerButton").style.display = "";
	}
	else
	{
		document.getElementById("bpuser").style.display = "none";
		document.getElementById("bparea").style.display = "";
		document.getElementById("myUserButton").style.display = "";
		document.getElementById("myPartnerButton").style.display = "none";
	}
}
</Script>
</head>
<body onLoad='scrollInit();' onresize='scrollInit()' scroll="no">
<form name=myForm method=post action="">
<%

	String browFlag = "IE";
	String isIntranetBP = "";
	String addr1="";
	String addr2="";
	String state="";
	String country="";
	String Zip="";
	Bus_Partner = Bus_Partner.trim();
	if(ret1!=null && !"sel".equals(Bus_Partner))
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
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	      	<Th width="20%" class="labelcell" align="right">Business Partner:</Th>
      		<Td width="20%">
<%
			String buspar=null;
			for(int i=0;i<ret1.getRowCount();i++)
			{
				if(Bus_Partner.equals(ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER").trim()))
				{
					 buspar=ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
					 break;
				}
			}
%>
			      <%=buspar%>
      		</Td>
   	</Tr>
</Table>
<%
	if(ret1!=null)
	{
		if(ret1.getRowCount()==0 && !"sel".equals(websyskey))
		{
%>
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
    				<Td class="displayheader" nowrap>Business Partner Summary</Td>
  			</Tr>
		</Table>
		</div>
<%
			String numUsers = retconfig.getFieldValueString(0,"EBPC_UNLIMITED_USERS");
			if ( numUsers.equals("Y") )
				numUsers = "Unlimited Users";
			else
				numUsers = retconfig.getFieldValueString(0,"EBPC_NUMBER_OF_USERS");

			isIntranetBP = retconfig.getFieldValueString(0,"EPBC_INTRANET_FLAG");
			if ( isIntranetBP.equals("Y"))
				isIntranetBP = "Yes";
			else
				isIntranetBP = "No";
%>

		<div id="InnerBox1Div">
		<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr >
      			<Td valign="top">
   			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
   				<Tr>
            				<Th align = "right" width="49%">Max. No of Users:</Th>
            				<Td width="51%"><%=numUsers%></Td>
          			</Tr>
          			<Tr>
            				<Th align = "right"  width="49%"><nobr>Intranet Business Partner</nobr></Th>
            				<Td width="51%"><%=isIntranetBP%></Td>
          			</Tr>
          			<Tr>
          	  			<Th align = "right" width="49%">Selected Catalog:</Th>
          	  			<Td width="51%" nowrap>
<%
					if(!CatalogNumberDesc.equals("No Catalogs Selected"))
					{
%>
          	  				<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=CatalogNumber%>&catDesc=<%=CatalogNumberDesc%>"><%=CatalogNumberDesc%></a></Td>
<%
					}
					else
					{
%>
						<%=CatalogNumberDesc%>
<%
					}
%>
          			</Tr>
        		</Table>
      			</Td>
      			<Td valign="top">
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
<%
			if ( numBPUsers > 0 )
			{
%>
        			<Tr >
          	  			<Th colspan="2" nowrap align="center">Users Assigned to Business Partner</Th>
          			</Tr>
          			<Tr >
          				<Th width="49%" align = "center">User</Th>
            				<Th width="51%" align = "center">Description</Th>
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
						<Td width="49%"><a href="<%=userUrl%>"><%=uId %></a></Td>
						<Td width="51%"><%= uName %></Td>
					</Tr>
<%
				} //end for
%>
          			<Tr>
            				<Td colspan="2" align="center">
            					<span id = "myUserButton">
               						<img src="../../Images/Buttons/<%=ButtonDir%>/viewuserareas.gif"  onClick="UsersSummary('1')" style="cursor:hand">
               					</span>
            					<span id = "myPartnerButton" style = "display:none">
               						<img src="../../Images/Buttons/<%=ButtonDir%>/viewpartnerareas.gif" onClick="UsersSummary('2')" style="cursor:hand">
               					</span>               					
					</Td>
          			</Tr>
<%
			}
			else
			{
%>
        			<Tr>
        				<Th colspan="2" nowrap class="displayheader">No Users Assigned to Business Partner</Th>
          			</Tr>
<%
			} //end numUsers
%>
        	</Table>
	      	</Td>
    	</Tr>
  	</Table>
	<span id="bparea">
	<Table width="99%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    	<Tr>
      	<Td valign="top" align="center" class="blankcell" colspan="2">
        <Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<% 
	if ( retRows > 0 ) 
	{ 
%>
            	<Tr>
              		<Th  colspan="2" class="labelcell" align="center">Synchronizable Areas</Th>
            	</Tr>
            	<Tr>
              		<Th>Systems</Th>
              		<Th>Description</Th>
            	</Tr>
<% 
	} 
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
					<%= SystemDesc %>
				</Td>
				<Td>&nbsp;</Td>
            		</Tr>
<%
		} //end if
		for( int i=0; i<1; i++)
		{
      			String catAreaDesc = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
      			String catAreaCode = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY");
			CheckBox = "CheckBox_"+i;
%>
			<Tr>
				<Td>&nbsp;</Td>
			<Td>
				<input type="checkbox" name="<%= CheckBox %>" value="checkbox" checked disabled>
				<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=catAreaCode%>"><%= catAreaDesc %> (<%=catAreaCode%>)</a>
			</Td>
			</Tr>
<%
		}
		checkSystemDesc = SystemDesc;
	}
%>
         </Table>
<% 
	if ( retOrgRows > 0 ) 
	{
%>
       		<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
        	<Tr>
              		<Th colspan="4" nowrap class="labelcell" align="center">Non Synchronizable Areas</Th>
              	</Tr>
            	<Tr>
              		<Th width="10%" nowrap>Systems</Th>
              		<Th width="20%" nowrap>Area Type</Th>
	              	<Th width="70%" nowrap>Description</Th>
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
					<Td width="10%" nowrap>
						<input type="checkbox" name="<%= Area %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isOrgAreaSelected %> disabled>
						<%=OrgDesc%>
					</Td>
					<Td width="20%">&nbsp;</Td>
					<Td width="70%">&nbsp;</Td>
				</Tr>
<%
			} //end if
			String orgAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
			String actAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY");
			String orgFlag = retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG");
			String orgFlagDesc = "";
			String isOrgDescSelected = "";
			if ( retbpareas.find("ESKD_SYS_KEY",actAreaDesc) )
				isOrgDescSelected = "checked";
			else
				isOrgDescSelected = "";
			if ( orgFlag.equals("C") ) 
				orgFlagDesc="Sales Area";
			else if ( orgFlag.equals("V") ) 
				 orgFlagDesc="Purchase Area";
			else if ( orgFlag.equals("S") ) 
				orgFlagDesc="Service Area"; 
			else 
				orgFlagDesc="Service Area";

			if ( (!orgFlag.equals(checkOrgFlag)) || (j == retOrgRows-1) )
			{
%>
				<Tr>
					<Td width="10%">&nbsp;</Td>
					<Td width="20%"><%=orgFlagDesc%></Td>
					<Td width="70%">&nbsp;</Td>
				</Tr>
<%
			}
%>
			<Tr>
				<Td width="10%">&nbsp;</Td>
				<Td width="20%">&nbsp;</Td>
				<Td width="70%">
					<input type="checkbox" name="<%= AreaCheckBox %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY") %>" <%= isOrgDescSelected %> onClick="CHG(this.name, <%=sysCount%>)" disabled>
					<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=V&SystemKey=<%=actAreaDesc%>"><%=orgAreaDesc%> (<%=actAreaDesc%>)</a>

				</Td>
			</Tr>
<%
			checkOrgDesc = OrgDesc;
			checkOrgFlag = orgFlag;
		}
%>
		</Table>
<%
	}
%>
      	</Td>
    	</Tr>
  	</Table>
  	<br>
	</span>
	<span id="bpuser"   style="display:none">
<%
	if ( !isIntranetBP.equals("Yes") )
	{
%>

      		<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	     	<Tr >
              		<Th colspan="3" nowrap >Business User Areas</Th>
            	</Tr>
            	<Tr >
              		<Th width="20%">User</Th>
              		<Th width="35%">Area</Th>
              		<Th width="45%">Customer</Th>
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
			   	if ( isBuiltIn.equals("N") )
			   		continue;
				// Erp Customer Number
				String uId = retbpusers.getFieldValueString(j,"EU_ID" );
				String erp_cust_no = retS.getFieldValueString(i,"ECA_NO");
				String userArea = retS.getFieldValueString("EUD_SYS_KEY");
				String ezc_cust_no = retS.getFieldValueString(i,"EC_NO"); // TBD : We need to think about it
				if ( !chgUid.equals(uId) )
				{
%>
					<Tr>
						<Td width="20%"><%=uId%></Td>
						<Td width="35%">&nbsp;</Td>
						<Td width="45%">&nbsp;</Td>
					</Tr>
<%
				}
				if ( !chgUArea.equals(userArea) )
				{
%>
					<Tr>
						<Td width="20%">&nbsp;</Td>
						<Td width="35%"><%=userArea%></Td>
						<Td width="45%">&nbsp;</Td>
					</Tr>
<%
				}
%>
				<Tr>
					<Td width="20%">&nbsp;</Td>
					<Td width="35%">&nbsp;</Td>
					<Td width="45%"><%=retS.getFieldValueString(i,ERP_CUST_NAME)%>(<%=erp_cust_no%>)</Td>
				</Tr>
<%
				chgUid = uId;
				chgUArea = userArea;
			}
		}
%>
		</Table>
<%
	}
	else
	{
%>
      		<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
      		<Tr >
              		<Th colspan="3" nowrap class="labelcell" align="center">Intranet User Areas</Th>
            	</Tr>
            	<Tr>
              		<Th width="30%">User ID</Th>
              		<Th width="70%">Area</Th>
              		<!--<Td width="45%">Customer</Td>-->
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
				//String erp_cust_no = retUA.getFieldValueString(i,"ECA_NO");
				String userArea = retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
				String mySysKey = retUA.getFieldValueString(i,"ESKD_SYS_KEY"); 
				if ( !chgUid.equals(uId) )
				{
%>	
					<Tr>
						<Td width="30%"><%=uId%></Td>
						<Td width="70%">&nbsp;</Td>
						<!--<Td width="45%">&nbsp;</Td>-->
					</Tr>
<%
				}
				if ( !chgUArea.equals(userArea) )
				{
%>
					<Tr>
						<Td width="30%">&nbsp;</Td>
						<Td nowrap width="70%"><%=userArea%> (<%=mySysKey%>)</Td>
						<!--<Td width="45%">&nbsp;</Td>-->
					</Tr>
<%
				}
%>
				<!--<Tr>
					<Td width="30%">&nbsp;</Td>
					<Td width="70%">&nbsp;</Td>
					<Td width="45%"><%//=retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC") %></Td>
				</Tr>-->
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
		</span>
		</div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
<%
	}
	else
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0    width="80%">
		<Tr>
			<Td class = "labelcell" align="center">Please Select Bussiness Partner to continue.
				</Td>
			</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
}
else
{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "labelcell" align="center">Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and Bussiness Partner to continue.</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
}
%>

</form>
</body>
</html>
