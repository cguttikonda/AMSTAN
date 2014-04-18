<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iConfirmCopyUser.jsp"%>
<html>
<head>
<script Language = "JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Confirm Copy User</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveCopyUser.jsp">
<br>
	<Table  width="89%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
	  <Tr align="center">
	    <Td class="displayheader">Copy User</Td>
	  </Tr>
	</Table>

	<div id="theads">
	 <Table id="tabHead" width="80%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
	    <Tr>
	      <Th width="100%" colspan="2"> Please go through the following information
        to copy user</Th>
	    </Tr>
	   </Table>
  	</div>  
  	 <div id="InnerBox1Div">
  	 <Table id="InnerBox1Tab" width="80%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
  	 <Tr>
  	   <Td width="50%" class="blankcell" valign = "top">
  	 <Table  width="100%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>
  	  <Tr>
  	   <Td class="labelcell" align="right">User:</Td>
  	   	<Td width="57%"><%=new_user%>
  		     <input type=hidden name="UserID" value="<%=new_user%>" >
  		</Td>
  	  </Tr>
          <Tr>
            <Td class="labelcell" align="right">Password*:</Td>
            	 <Td width="57%">
            	  <input type="password" style = "width:100%" class = "InputBox" name="InitialPassword" size="10" maxlength="10" >
               </Td>
          </Tr>
          <Tr>
            	<Td class="labelcell" align="right">Confirm Password*:</Td>
          	  <Td width="57%">
          	    <input type="password"  style = "width:100%"  class = "InputBox" name="ConfirmPassword" size="10" maxlength="10" >
          	  </Td>
          </Tr>
          <Tr>
               <Td class="labelcell" align="right">First Name*:</Td>
                 <Td width="57%">
          	    <input type=text class = "InputBox"  style = "width:100%" name="FirstName"  size=20 maxlength=60 value="">
          	  </Td>
          </Tr>
          <Tr>
                <Td class="labelcell" align="right">Middle Initial:</Td>
          	  <Td width="57%">
          	    <input type=text class = "InputBox" style = "width:100%"  name="MidInit"  size=1 maxlength=1 value="">
          	 </Td>
          </Tr>
          <Tr>
          	 <Td class="labelcell" align="right">Last Name*:</Td>
          	  <Td width="57%">
          	    <input type=text class = "InputBox" style = "width:100%"  name="LastName"  size=20 maxlength=60 value="">
          	  </Td>
          </Tr>
          <Tr>
          	 <Td class="labelcell" align="right">Email*:</Td>
          	  <Td width="57%">
          	    <input type=text class = "InputBox" style = "width:100%"  name="Email"  size=20 maxlength=40 value="">
          	  </Td>
          </Tr>

        </Table>

      	 </Td>
      		<Td width="50%" valign="top" class="blankcell">
      	<Table  width="100%" border="1" align="center" bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2>

	<%
		String uType = ret.getFieldValueString(0,USER_TYPE);
		String aType = ret.getFieldValueString(0,USER_BUILT_IN);
		String selB = "";
		String selI = "";
		String aus = "";
		String disb = "";
		if ( uType.equals("3") )
		{
		      selB = "selected";
		}
		else
		{
		      selI = "selected";
		}
		if ( uType.equals("2") && aType.equals("Y") )
		{
		    aus = "checked";
		}
		else
		{
		    disb = "disabled";
		}
%>
          <Tr>
            <Td class="labelcell" align="right">User Type:</Td>
            <Td width="57%">
              <input type = "hidden" name="UserType" value = "3">
                BusinessUser
            </Td>
          </Tr>
          <Tr>
            <Td class="labelcell" align="right">Admin User:</Td>
            <Td width="57%">
              <input type="checkbox" <%= disb %> name="Admin" <%= aus %>>
            </Td>
          </Tr>

	  <input type="hidden" name="UserGroup" value="0">

          <Tr>
            <Td width="43%" class="labelcell" align="right">Business Partner:</Td>
            <Td width="57%">
<%
			int bpRows = retbp.getRowCount();
			String companyName = null;
			String bpNumber = null;
			String Bus_Partner = (String)(ret.getFieldValue(0,USER_BUSINESS_PARTNER));
			if ( bpRows > 0 ) {
				for ( int i = 0 ; i < bpRows ; i++ ){
				String val = (retbp.getFieldValue(i,BP_NUMBER)).toString();
				if(Bus_Partner.equals(val)){
					companyName = (String)retbp.getFieldValue(i,BP_COMPANY_NAME);
					bpNumber = (String)retbp.getFieldValue(i,BP_NUMBER);
				}
			}

		if (companyName != null){
%>
		        <%=companyName%>
		        <input type=hidden name=PartnerDesc value=<%=companyName%>>
		        <input type="hidden" name="BusPartner" value=<%=bpNumber%> >
<%
		}
	}
%></Td>
          </Tr>

          <Tr>
            <Td  class="labelcell" align="right">Catalog:</Td>
            <Td>
<%
		String catalogA = "";
		String catalogNum = "";
		if ( retcatuser != null && retcatuser.getRowCount() > 0 )
		{
			catalogNum = (retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER)).toString();
			catalogA = (String)(retcatuser.getFieldValue(0,CATALOG_DESC));
		}
		else
		{
			catalogNum = "0";
			catalogA = "No Catalog Exists";
		}
%>
 		<%=catalogA%>
 		<input type=hidden name=DisplayCatalog value=<%=catalogA%>>
		<input type="hidden" name="CatalogNumber"  value=<%=catalogNum%> >
 </Td>
          </Tr>
          <Tr align="center">
            <Td colspan="2" class="labelcell"> ERP Customers </Td>
          </Tr>
<%
			int custRows = retsoldto.getRowCount();
			int selRows = retsoldtouser.getRowCount();


			if ( custRows > 0 ) {
				for ( int i = 0 ; i < custRows; i++ ){
%>
		<Tr>
		<Td colspan = "2" align="left">
<%
		String ERPCustomerNo = retsoldto.getFieldValueString(i,ERP_CUST_NAME);
		ERPCustomerNo.trim();
		String ERPCustomerArea = retsoldto.getFieldValueString(i,"EC_SYS_KEY");
		ERPCustomerArea.trim();
		if (retsoldtouser != null  && retsoldtouser.find(ERP_CUST_NAME,ERPCustomerNo))
		{
		int rowId = retsoldto.getRowId(ERP_CUST_NAME,ERPCustomerNo);
		String foundArea = retsoldto.getFieldValueString(rowId,"EC_SYS_KEY");
		foundArea.trim();
	  if(foundArea.equals(ERPCustomerArea)){
%>
		<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=retsoldto.getFieldValueString(i,"EC_SYS_KEY")%>" checked >
<%
		}
			else
				{
%>
		<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=retsoldto.getFieldValueString(i,"EC_SYS_KEY")%>" >
<%
				}
		} else{
%>
		<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=retsoldto.getFieldValueString(i,"EC_SYS_KEY")%>" >
<%
		}
%>
	     <%=retsoldto.getFieldValue(i,ERP_CUST_NAME)%>(<%=retsoldto.getFieldValue(i,"EC_ERP_CUST_NO")%>)
        </Td>
		</Tr>
<%
	}
%>
	<input type="hidden" name="OldUser" value=<%=user_id%> >
<%
}
%>
        </Table>
	
  	    </Td>
  	  </Tr>
  	</Table>
       </div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%;visibility:visble">
	    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/createuser.gif" name="Submit" value="Create User" onClick="checkAll('myForm','ConfirmCopyUser');return document.returnValue">
	    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


	 </div>
</form>
	<script language = "javascript">
	document.myForm.InitialPassword.focus();
	</script>
</body>
</html>