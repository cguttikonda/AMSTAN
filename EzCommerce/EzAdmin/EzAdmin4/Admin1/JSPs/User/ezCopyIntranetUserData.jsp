<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iCopyIntranetUserData.jsp"%>
<html>
<head>
<script Language = "JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>

<Title>Change User Data</Title>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit();document.myForm.InitialPassword.focus()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveAddIntranetUser.jsp">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
<%
if ( !Show.equals("Yes") ) 
{ 
%>
  	<Tr align="center"> 
    	<Td nowrap class="displayheader">Copy Intranet User</Td>
  	</Tr>
<% 
} 
else 
{ 
} 
%>
</Table>

<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr> 
      	<Th width="100%" colspan="2"> Please go through the following information to change</Th>
    	</Tr>
</Table>

<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr> 
      	<Td width="50%" class="blankcell" valign="top"> 
        <Table  width="100%" border="0">
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">User:</Td>
            	<Td width="57%"> <%=newuser_id%>
              		<input type="hidden" name="UserDesc" value="<%=newuser_id%>" >
			<input type="hidden" name="OldUser" value="<%=user_id%>" >
	              	<input type="hidden" name="UserID" value="<%=newuser_id%>" >
            	</Td>
          	</Tr>
          	<Tr>
            	<Td width="43%" class="labelcell" align="right">Password*:</Td>
            	<Td width="57%">
              		<input type="password" style = "width:100%" class=InputBox name="InitialPassword"  size="10" maxlength="10">
            	</Td>
          	</Tr>
          	<Tr>
            	<Td width="43%" class="labelcell" align="right">Confirm Password*:</Td>
            	<Td width="57%">
              		<input type="password" style = "width:100%" name="ConfirmPassword" class=InputBox size="10" maxlength="10">
            	</Td>
          	</Tr>
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">First Name*:</Td>
            	<Td width="57%"> 
              		<input type=text  style = "width:100%" class = "InputBox" name="FirstName"  <%= display %> size=20 maxlength=60 >
            	</Td>
          	</Tr>
	        <Tr> 
            	<Td width="43%" class="labelcell" align="right">Middle Initial:</Td>
            	<Td width="57%"> 
              		<input type=text  style = "width:100%" class = "InputBox" name="MidInit"  <%= display %> size=1 maxlength=1 >
            	</Td>
          	</Tr>
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">Last Name*:</Td>
            	<Td width="57%"> 
              		<input type=text style = "width:100%" class = "InputBox" name="LastName"  <%= display %> size=20 maxlength=60 >
            	</Td>
          	</Tr>
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">Email*:</Td>
            	<Td width="57%"> 
              		<input type=text style = "width:100%" class = "InputBox" name="Email"  <%= display %> size=20 maxlength=40 >
            	</Td>
          	</Tr>
<%
		String uType = ret.getFieldValueString(0,USER_TYPE);
		String selB = "";
		String selI = "";

		String aType = ret.getFieldValueString(0,USER_BUILT_IN);
		String aus = "";
		String disb = "";
		if ( aType.equals("Y") )
		{
     			aus="checked";
		}
%>
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">User Type:</Td>
            	<Td width="57%"> 
              	<select name="UserType" size="1">
                	<!-- Commented by Venkat on 4/25/2001 - No Business user for business partner
                	<option value="3" selected>BusinessUser</option>
		    	-->
                	<option value="2" selected>IntranetUser</option>
              	</select>
            	</Td>
          	</Tr>
          	<Tr> 
            	<Td width="43%" class="labelcell" align="right">Admin User:*</Td>
            	<Td width="57%"> 
            	  	<input type="checkbox" <%= disb %> name="Admin">
            	</Td>
          	</Tr>
	  		<input type="hidden" name="UserGroup" value="0" >
	        <Tr> 
            	<Td width="43%" class="labelcell" align="right">Business Partner:</Td>
            	<Td width="57%"> 
<% 
		int bpRows = retbp.getRowCount();
		String companyName = null;
		String bpNumber = null;
		String Bus_Partner = ret.getFieldValueString(0,USER_BUSINESS_PARTNER);

		if ( bpRows > 0 ) 
		{
			for ( int i = 0 ; i < bpRows ; i++ )
			{		
				String val = retbp.getFieldValueString(i,BP_NUMBER);
				if(Bus_Partner.equals(val))
				{
					companyName = retbp.getFieldValueString(i,BP_COMPANY_NAME);
					bpNumber = retbp.getFieldValueString(i,BP_NUMBER);
				}//End if
			}//End for
			if (companyName != null)
			{
%>			
			        <%=companyName%>
			        <input type="hidden" name="BusPartner" value="<%=bpNumber%>" >
<%
			}
		}//End if bpRows
%>
            	</Td>
          	</Tr>
        	</Table>
      	</Td>
      	<Td width="50%" valign="top" class="blankcell"> 
        <Table  width="100%" border="0">
          	<Tr> 
            	<Td class="labelcell" align="right">Catalog:</Td>
            	<Td> 
<% 
		String catalogA = retcatuser.getFieldValueString(0,CATALOG_DESC);
		String catalogNum = retcatuser.getFieldValueString(0,CATALOG_DESC_NUMBER);
		/** Added by Venkat on 4/27/2001 **/
		if ( catalogA == null || catalogA.equals("null"))
		{
			catalogA = "No Catalogs Selected";
			catalogNum = "0";
		}
		/**Venkats changes end here **/
%>		
      		<%=catalogA%>
      		<input type="hidden" name="CatalogNumber"  value=<%=catalogNum%> >
		</Td>
          	</Tr>
		<!-- Added by Venkat on 4/24/2001 -->
          	<Tr align="center"> 
            	<Td width="100%" colspan="2" class="labelcell"> Selected Sync Areas </Td>
          	</Tr>
<%
		if ( retRows > 0 ) 
		{
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
			out.println("<Tr>");
			out.println("<Td colspan=\"2\">"); 
			out.println(" <font size=\"2\" face=\"Trebuchet MS\" color=\"#000066\">");
        		out.println("<input type=\"checkbox\" name=\"ACheckBox_"+i+"\" value=\""+cAreaKey+"\" checked disabled>"+cAreaDesc);
        		out.println("</Td>");		
			out.println("</Tr>");
			}//End for
		}
		else
		{
			out.println("<Tr>");
			out.println("<Td colspan=\"2\">"); 
			out.println("<font size=\"2\" face=\"Trebuchet MS\" color=\"Red\">");
        		out.println("There are no Sales Areas for this Business Partner");
        		out.println("</font>");		
        		out.println("</Td>");		
			out.println("</Tr>");
		}//End If
%>
          	<Tr align="center"> 
            	<Td width="100%" colspan="2" class="labelcell"> Select Non Sync. Areas </Td>
          	</Tr>
<%
		if ( retbpRows > 0 ) 
		{
%>
<%	
		for ( int i = 0 ; i < retbpRows; i++ )
		{		
            		String isAreaSelected = "";
            		String intUserArea = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY");
            		if ( retbpSAreas.find("ESKD_SYS_KEY",intUserArea) )
			{
				isAreaSelected="checked";
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
			<Td colspan="2">
        		<input type="checkbox" name="CheckBox" value=<%=areaKey%> <%=isAreaSelected%> <%=checDisp%> onClick ="setChangeFlag('<%=i%>', 'ChangeIntranetUser');return document.returnValue;"><%=areaDesc%>
			<input type="hidden" name="areaFlag" value="<%=areaFlag%>" >
      			<input type="hidden" name="ChangeFlag" value="N" >
      			<input type="hidden" name="AreaKey" value="<%=areaKey%>" >
        		</Td>
			</Tr>
<%		}//End for
		}
		else
		{
			out.println("<Tr>");
			out.println("<Td colspan=\"2\">"); 
			out.println("<font size=\"2\" face=\"Trebuchet MS\" color=\"Red\">");
        		out.println("There are No Areas for this Business Partner");
        		out.println("</font>");		
        		out.println("</Td>");		
			out.println("</Tr>");
	}//End If
	out.println("<input type=\"hidden\" name=\"TotalCount\" value=\""+retbpRows+"\" >");
%>
        </Table>
      	</Td>
    	</Tr>
</Table>
</div>
<% 
	if ( !Show.equals("Yes") ) 
	{ 
%>
<br>
  	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    		<!-- input type="submit" name="Submit" value="Create User" onClick="checkAll('ConfirmCopyUser');return document.returnValue" -->
    		<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/createuser.gif" name="Submit" value="Create User" onClick="checkAll('myForm','ConfirmCopyUser');return document.returnValue">
    		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
  	</div>
<% 	
	} 
%>
</form>
<% 
	if ( !Show.equals("Yes") ) 
	{ 
%>
	<script language = "javascript">
		document.myForm.InitialPassword.focus();
	</script>
<% 
	} 
%>
</body>
</html>
