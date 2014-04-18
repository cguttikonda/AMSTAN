<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustSync.jsp"%>
<html>
<head>
 <script src="../../Library/JavaScript/Partner/ezBPCustSync.js">
 </script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Synchronize Base ERP SoldTos</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()'  onresize='scrollInit()' scroll="no">
<br>
<%
int numBPAreas = 0;
int numEzc = 0;
int textBoxCount = 0;
if(numBPs > 0)
{
%>

<form name=myForm method=post action="ezConfirmBPCustSync.jsp">
  <Table  width="65%" border="1" align="center">
    <Tr>
      <Td width="43%" class="labelcell">Business Partner:</Td>
      <Td width="57%" colspan="2" class="blankcell">
      <%@ include file="../../../Includes/Lib/ListBox/LBBusPartner2.jsp"%></Td>
    </Tr>
  </Table>
  <br>

<%
	numBPAreas = retbpareas.getRowCount();
	numEzc = retFinal.getRowCount();

	String[] sortArr = {"EC_NO"};
	retFinal.sort(sortArr,true);

	// variables starting with a stands for actual, c stands for changed
	String cEzcNo = "";
	String aEzcNo,tEzcNo = "";
	String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType, aEzcCountry  = "";
	String aSysKey, aSysDesc, aErpNo = "";
	if ( numBPAreas > 0 )
	{
		/** if getEzcCustomers more than 0 then only print headers **/
		if ( numEzc > 0 )
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">ERP <%=cTitle%> Data Synchronization</Td>
  </Tr>
</Table>
	<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    	 <Tr border="1">
    	 <Th><%=cTitle%>(s)</Th>
         <Th>ERP System/Organization</Th>
      	 <Th>ERP <%=cTitle%></Th>
    </Tr>
    </Table>
    </div>

<%
			boolean firstTextBox = true;
			for( int i = 0; i < numEzc; i++)
			{
				aEzcType = retFinal.getFieldValueString(i,"EC_PARTNER_FUNCTION").trim();
				aEzcType = aEzcType.trim();
				aEzcNo = retFinal.getFieldValueString(i,"EC_NO").trim();
				aEzcName = "<br>"+retFinal.getFieldValueString(i,"ECA_NAME").trim();
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


<DIV id="InnerBox1Div">

<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
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
      <input type="radio" name="SysKey" value="<%=textBoxCount%>"><%=aSysKey%>
    </Td>
    <Td valign="bottom">
      <input type="textbox" name="ERPCUST_<%=textBoxCount%>" <%=ReadOnly%> value="<%=aErpNo%>">
    </Td>
    </Tr>
	<input type="hidden" name="EzcCustomer_<%=textBoxCount%>" value="<%=aEzcNo%>">
	<input type="hidden" name="AREA_<%=textBoxCount%>" value="<%=aSysKey%>">
<%
				if ( firstTextBox && ReadOnly.equals("") )
				{
%>
	<input type="hidden" name="FIRST" value="<%=textBoxCount%>">
<%
					firstTextBox = false;
				}
				cEzcNo = aEzcNo;
				textBoxCount++;

				if ( i != (numEzc-1) )
				{
					tEzcNo = retFinal.getFieldValueString(i+1,"EC_NO");
				}

				if ( !aEzcNo.equals(tEzcNo) || (i == numEzc-1) )
				{
%>

<%
				} //end if checkChange
%>

<%

			} //end for i < numEzc
%>
			<Tr height="3">
			<Th colspan="4" bgcolor="#336699"></Th>
			</Tr>
<%

	     	} //if numEzc > 0
	     	else
	     	{
%>

		<br>
		<br>
		<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No Customers are Synchronized for this Partner</div>
	    </Td>
	  </Tr></Table>

<%
	     	}
	}
	else
	{
	
	} //end if retbpareas > 0
%>
  </Table>
  </div>


<%
	}//end if BPs >0
	else
		{
%>				<br>
		<br>
		<br>
			
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No Partners to List</div>
	    </Td>
	  </Tr></Table>
	  <br>
	  <center><a href="#"><img src = "../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none onClick = "javascript:history.go(-1)"></a></center>
<%		
	}
%>	
<%
	if ( numBPAreas > 0  )
	{
%>
	<br>

	<div align=center style="position:absolute;top:70%;left:25%">
<%   if ( numEzc > 0 ) { %>

		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif"  onClick="checkAll(<%=textBoxCount%>);return document.returnValue">
<% } %>

		<a href="#"><img src="../../Images/Buttons/<%= ButtonDir%>/addcustomer.gif" onClick="addcust('<%=FUNCTION%>')"  border=none></a>
<%   if ( numEzc > 0 ) { %>

<% } %>
	</div>
<%
	} //end if retbpareas
%>
	<input type="hidden" name="TotalCount" value=<%=textBoxCount%> >

<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
</form>
</body>
</html>
