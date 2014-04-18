<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iChangeUserData.jsp"%>
<%

	String myAreaFlag=(String)session.getValue("myAreaFlag");
	String userId=	ret.getFieldValueString(0,USER_ID);
	String firstName=ret.getFieldValueString(0,USER_FIRST_NAME);
	String lastName=ret.getFieldValueString(0,USER_LAST_NAME);
	String middleIntial=ret.getFieldValueString(0,USER_MIDDLE_INIT);
	String email=ret.getFieldValueString(0,USER_EMAIL);
	String password=ret.getFieldValueString(0,USER_PASSWORD);

	middleIntial=("null".equals(middleIntial))?" ":middleIntial;


	String uType = ret.getFieldValueString(0,USER_TYPE);
	String selB = "";
	String selI = "";
	if ( uType.equals("3") )
	{
	     selB = "selected";
	}
	else
	{
	     selI = "selected";
	}
	String aType = ret.getFieldValueString(0,USER_BUILT_IN);
	String aus = "";
	String disb = "disabled";


	int bpRows = retbp.getRowCount();
	String companyName = null;
	String bpNumber = null;
	String Bus_Partner = (String)(ret.getFieldValue(0,USER_BUSINESS_PARTNER));
	if ( bpRows > 0 )
	{
		for ( int i = 0 ; i < bpRows ; i++ )
		{
			String val = (retbp.getFieldValue(i,BP_NUMBER)).toString();
			if(Bus_Partner.equals(val))
			{
				companyName = (String)retbp.getFieldValue(i,BP_COMPANY_NAME);
				bpNumber = (String)retbp.getFieldValue(i,BP_NUMBER);
				break;
			}
		}
	}


	int tempCount = retcatuser.getRowCount();
	String catalogA = "No Catalog Exists";
	String catalogNum = "0";
	if(tempCount > 0){
		catalogA = (String)(retcatuser.getFieldValue(0,CATALOG_DESC));
		catalogNum = (retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER)).toString();
	}



%>

<html>
<head>
	<Title>Change User Data</Title>

	<script Language = "JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>

	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad="document.myForm.FirstName.focus();scrollInit()" onResize="scrollInit()" scroll="no">


<form name=myForm method=post action="ezChangeUser.jsp">

<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
<Tr align="center">
    <Td class="displayheader">Change User Information</Td>
</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
<Tr>
      <Th width="100%" colspan="2">Please go through the following information to change</Th>
</Tr>
<Tr>
      <Td width="50%" class="blankcell" valign="top">
      <Table width="100%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
      <Tr>
            <Td width="43%" class="labelcell">User:</Td>
            <Td width="57%">

<a href = "../User/ezUserDetails.jsp?UserID=<%=userId %>"><%=userId %></a>
		  <input type="hidden" name="UserID" value="<%=userId%>" >
            </Td>
      </Tr>
      <Tr>
            <Td width="43%" class="labelcell">First Name:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="FirstName"  size=20 maxlength=60 value="<%=firstName%>">
              <input type="hidden" name="Password"  value="<%=password%>">
            </Td>
      </Tr>
      <Tr>
            <Td width="43%" class="labelcell">Middle Initial:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="MidInit"  size=1 maxlength=1 value="<%=middleIntial%>" >
            </Td>

      </Tr>
      <Tr>
            <Td width="43%" class="labelcell">Last Name:</Td>
            <Td width="57%">
              <input type=text name="LastName" class = "InputBox" size=20 maxlength=60 value="<%=lastName%>" >
            </Td>
      </Tr>
      <Tr>
            <Td width="43%" class="labelcell">Email:</Td>
            <Td width="57%">
              <input type=text class = "InputBox" name="Email"  size=20 maxlength=40 value="<%=email%>">
            </Td>
      </Tr>
      </Table>
      </Td>
      <Td width="50%" valign="top" class="blankcell">
        <Table  width="100%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
        	<Tr>
         	   <Td width="43%" class="labelcell">User Type:</Td>
         	   <Td width="57%">
   	 	       <select name="UserType" size="1" id = "ListBoxDiv">
         		       <option value="3" <%= selB %>>BusinessUser</option>
         	       </select>
         	   </Td>
         	</Tr>
         	<Tr>         	
        	    
        	    <Td width="43%" class="labelcell">Admin User:</Td>	    
        	    <Td width="57%">
			<label for="cb_<%=0%>">
			<input type="checkbox" id="cb_<%=0%>" <%= disb %> name="Admin" <%= aus %>>
	        	<input type="hidden" name="UserGroup" value="0">           
			</label>
        	   </Td>
        	   
	
        	</Tr>
         	<Tr>
         	   <Td width="43%" class="labelcell">Business Partner:</Td>
         	   <Td width="57%">
            		<%=companyName%>
		        <input type=hidden name=PartnerDesc value=<%=companyName%>>
		    	<input type="hidden" name="BusPartner" value=<%=bpNumber%> >
	 	   </Td>
         	</Tr>
         	<Tr>
         	   <Td class="labelcell">Catalog:</Td>
         	   <Td><%=catalogA%>
    			<input type=hidden name=DisplayCatalog value=<%=catalogA%>>
      			<input type="hidden" name="CatalogNumber"  value=<%=catalogNum%> >

 	 	  </Td>
         	 </Tr>
          </table>
          </td>
          </tr>
          </table>
          <div id="theads">
          <Table id="tabHead" align=center width="80%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
          <Tr align="center">
            <Td colspan="2" class="labelcell"> ERP Customers</Td>
          </Tr>
	 </table></div>
<%
			int custRows = retsoldto.getRowCount();
			int selRows = retsoldtouser.getRowCount();

			String erp_cust_no=null;
			String ezc_cust_no=null;
			String erp_cust_area=null;
			String uArea=null;
			String uCust=null;

%>


 <DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center width="100%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
    if ( custRows > 0)
    {

	for ( int i = 0 ; i < custRows; i++ )
	{

		 erp_cust_no = (String)retsoldto.getFieldValue(i,"EC_ERP_CUST_NO");
		 ezc_cust_no = (String)retsoldto.getFieldValue(i,"EC_NO");
		 erp_cust_area = retsoldto.getFieldValueString(i,"EC_SYS_KEY");
		boolean found = false;

		if (retsoldtouser != null )
		{
			erp_cust_area = erp_cust_area.trim();
			erp_cust_no = erp_cust_no.trim();

			for ( int m = 0 ;m <selRows; m++)
			{
				uArea = retsoldtouser.getFieldValueString(m,"EUD_SYS_KEY").trim();
				uCust = retsoldtouser.getFieldValueString(m,"EUD_VALUE").trim();
				if( uCust.equals(erp_cust_no) && uArea.equals(erp_cust_area))
				{

					found = true;
					break;
				}
				else
				{
					found = false;
				}
			}
		}

		String myCheck=(found)?"checked":"";



%>
		<Tr>
		<label for="cb_<%=i%>">
		<Td colspan = "2" align="left">

		        <input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=erp_cust_no%>#<%=retsoldto.getFieldValueString(i,"EC_SYS_KEY")%>" <%=myCheck%>>
      			<%=retsoldto.getFieldValue(i,ERP_CUST_NAME)%>(<%=erp_cust_no%>)
			<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=myAreaFlag%>&SystemKey=<%=retsoldto.getFieldValue(i,"EC_SYS_KEY")%>">(<%=retsoldto.getFieldValue(i,"EC_SYS_KEY")%>)</a>&nbsp;
	        </Td>
		</label>
		</Tr>

<%
	}

		for(int i=0;i<selRows;i++)
		{
%>
			<input type=hidden name="SelSoldTo" value="<%=retsoldtouser.getFieldValueString(i,"EUD_VALUE")%>">
			<input type=hidden name="SelSysKey" value="<%=retsoldtouser.getFieldValueString(i,"EUD_SYS_KEY")%>">
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



<div id="ButtonDiv" align=center style="position:absolute;top:85%;width:100%;visibility:visible">
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" onClick="checkAll('myForm','ChangeUser'); return document.returnValue;">
    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
  <input type="hidden" name="Area" value=<%=Area%> >
  <input type="hidden" name="WebSysKey" value=<%=websyskey%> >
  <input type=hidden name="fromListByRole" value=<%=fromListByRole%>>
  <input type=hidden name=roleVal value="<%=roleVal%>">
  <input type=hidden name=sysVal value="<%=sysVal%>">

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

