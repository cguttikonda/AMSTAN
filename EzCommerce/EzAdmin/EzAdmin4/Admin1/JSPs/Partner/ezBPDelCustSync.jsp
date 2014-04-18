<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPDelCustSync.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPDelCustSync.js">

</script>

<Title>Delete ERP SoldTos and Partner Functions</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<br>
<body bgcolor="#FFFFF7">
<%
int numBPAreas = 0;
int numEzc = 0;
int textBoxCount = 0;
if(numBPs > 0)
{
%>
<Table  width="60%" border="0" align="center">
  <Tr align="center">
    <Td class="displayheader">ERP <%=cTitle%> Deletion</Td>
  </Tr>
</Table>


<form name=myForm method=post action="ezDelCustSync.jsp">
  <Table  width="65%" border="1" align="center">
    <Tr>
      <Td width="43%" class="labelcell">Business Partner:</Td>
      <Td width="57%" colspan="2" class="blankcell">
      <%@ include file="../../../Includes/Lib/ListBox/LBBusPartner2.jsp"%></Td>
    </Tr>
  </Table>
  <br>
  <Table  width="65%" align="center" cellpadding="1" cellspacing="0">

<%
	numEzc = retFinal.getRowCount();

	// variables starting with a stands for actual, c stands for changed
	String cEzcNo = "";
	String cSysKey = "";
	String aEzcNo,tEzcNo = "";
	String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType  = "";
	String aSysKey, aSysDesc, aErpNo = "";

	/** if getEzcCustomers more than 0 then only print headers **/
	if ( numEzc > 0 )
	{
%>

    <Tr border="1">
      <Th><%=cTitle%>(s)</Th>
      <Th>ERP System</Th>
      <Th>Function</Th>
      <Th>ERP <%=cTitle%></Th>
    </Tr>
<%
		boolean firstTextBox = true;
		for( int i = 0; i < numEzc; i++)
		{
			aEzcType = retFinal.getFieldValueString(i,"EC_PARTNER_FUNCTION").trim();
			aEzcType = aEzcType.trim();
			aEzcNo = retFinal.getFieldValueString(i,"EC_NO").trim()+"<br>";
			aEzcName = retFinal.getFieldValueString(i,"ECA_NAME").trim();
			if (aEzcName.equalsIgnoreCase("null") || aEzcName.length()==0) aEzcName = ""; else aEzcName = aEzcName + "<br>";
			aEzcAddr1 = retFinal.getFieldValueString(i,"ECA_ADDR_1").trim();
			if (aEzcAddr1.equalsIgnoreCase("null") || aEzcAddr1.length()==0) aEzcAddr1 = ""; else aEzcAddr1 = aEzcAddr1 + "<br>";
			aEzcCity = retFinal.getFieldValueString(i,"ECA_CITY").trim();
			if (aEzcCity.equalsIgnoreCase("null") || aEzcCity.length()==0) aEzcCity = ""; else aEzcCity = aEzcCity + "<br>";
			aEzcState = retFinal.getFieldValueString(i,"ECA_STATE").trim();
			if (aEzcState.equalsIgnoreCase("null") || aEzcState.length()==0) aEzcState = ""; else aEzcState = aEzcState + " ";
			aEzcZip = retFinal.getFieldValueString(i,"ECA_PIN").trim();
			if (aEzcZip.equalsIgnoreCase("null") || aEzcZip.length()==0) aEzcZip = "";
			aErpNo  = retFinal.getFieldValueString(i,"EC_ERP_CUST_NO").trim();
%>

<%
			/** If EzcNo changes then only print address depending on function type C or V **/
			if ( !aEzcNo.equals(cEzcNo) )
			{
%>
<Tr height="3">
			<Th colspan="4" bgcolor="#336699"></Th>
			</Tr>
<Tr>
      	<Td valign="top">
      	  <b><%=aEzcNo%></b>
	  				<%=aEzcName%>
          		<%=aEzcAddr1%>
          		<%=aEzcCity%>
          		<%=aEzcState+" "+aEzcZip%>
	</Td>
<%
			}
			else
			{
%>
	<Td></Td>
<%
			} //end if !aEzcNo

			aSysKey = retFinal.getFieldValueString(i,"EC_SYS_KEY");

			String ReadOnly = "";
			aErpNo = aErpNo.trim();
			ReadOnly = (aErpNo.equals(""))?"":"readonly";
%>
    <Td valign="bottom">
      <b><%=aSysKey%></b>
    </Td>
    <Td valign="bottom">
       <input type="checkbox" name="CheckBox_<%=textBoxCount%>" value="<%=FUNCTION%>"><b><%=cDesc%></b>
    </Td>
    <Td valign="bottom">
      <input type="textbox" name="ERPCUST_<%=textBoxCount%>" <%=ReadOnly%> value="<%=aErpNo%>">
    </Td>
    </Tr>
	<input type="hidden" name="EzcCustomer_<%=textBoxCount%>" value="<%=aEzcNo%>">
	<input type="hidden" name="AREA_<%=textBoxCount%>" value="<%=aSysKey%>">
<%
			cEzcNo = aEzcNo;
			textBoxCount++;
%>
			<%@ include file="ezDisplayPartnerFunctions.jsp"%>
<%
			if ( i != (numEzc-1) )
			{
				tEzcNo = retFinal.getFieldValueString(i+1,"EC_NO");
			}

			if ( !aEzcNo.equals(tEzcNo) || (i == numEzc-1) )
			{
%>

<%
			} //end if!aEzcNo.equals(tEzcNo)

		} //end for i < numEzc
%>
<Tr height="3">
			<Th colspan="4" bgcolor="#336699"></Th>
			</Tr>

  </Table>

	<br>
	<div align="center">
		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" onClick="delsync(<%=textBoxCount%>);return document.returnValue" style="cursor:hand;">
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	</div>
		<input type="hidden" name="TotalCount" value=<%=textBoxCount%> >
<%

     	}
     	else
     	{
%>
	<br>
	<div align="center">
	This Business Partner has no ERP <%=cTitle%>
	</div>
<%
     	}//if numEzc > 0
%>

<%
     }
     else
     {
%>
		<br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
		    	<Th>
	      		<div align="center">There are no Business Partners in the system.</div>
	    		</Th>
	  	</Tr>
	  	</Table>
	  	<br>
	  	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
	
<%
     }
%>

	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
</form>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Delete successful');
		</script>
<%
	} //end if
%>

</body>
</html>
