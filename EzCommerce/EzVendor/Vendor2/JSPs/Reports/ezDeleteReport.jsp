<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iListReport.jsp"%>
<%--
0 :: Field Name : ERI_REPORT_NO ---- Field Value : 15
 0 :: Field Name : ERI_SYSTEM_NO ---- Field Value : 999
 0 :: Field Name : ERI_REPORT_NAME ---- Field Value : ZANOPT33 
0 :: Field Name : ERI_REPORT_DESC ---- Field Value : Test
 0 :: Field Name : ERI_LANG ---- Field Value : EN 
0 :: Field Name : ERI_REPORT_TYPE ---- Field Value : 1
 0 :: Field Name : ERI_EXEC_TYPE ---- Field Value : 1 
0 :: Field Name : ERI_VISIBLE_LEVEL ---- Field Value : 1
 0 :: Field Name : ERI_REPORT_STATUS ---- Field Value : 1 
0 :: Field Name : ERI_EXT1 ---- Field Value :
 0 :: Field Name : ERI_EXT2 ---- Field Value : 

--%>
<html>
<head>
  <title>ezAddReport.htm</title>

  <meta http-equiv="content-type"
 content="text/html; charset=ISO-8859-1">
 
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
     <script src="../../Library/JavaScript/ezTrim.js"></script>
     <script src="../../Library/JavaScript/ezSelSelect.js"></script>
     <script>

     var MSelect = new Array();  // this is Select Box mandactory check variable

     MSelect[0] = "system,Please select System";
     // this is for Select box mandactory  check

     function chkMand()
     {


	/*if(selselect(MSelect[0]))
	{*/
		return true
	/*}else{
		return false
	}*/
     }
     

     function ezfunSubmit()
     {
	  if(chkMand())
	  {
          	document.listForm.submit();
	  }
     }
     function chkDeleteReports()
     {
		obj =document.listForm.chk
		var chkbox = obj.length;
		chkCount=0
		if(isNaN(chkbox))
		{
			if(obj.checked)
			{
				chkCount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.listForm.chk[a].checked)
				{
					chkCount++;
					if(parseInt(chkCount) == parseInt(2) )
						break;
				}
			}
		}

		if(chkCount == 0)
		{
			if(obj=="Edit")
			{
				alert("Please select Report to Edit");
			}else
			{
				alert("Please select Report(s) to Delete");
			}
			return false;
		}else if(chkCount > 1)
		{
			if(obj=="Edit")
			{
				alert("Please check only one Report to Edit");
				return false;
			}
		}
		return true;

     }
  function deleteReports()
  {
	if(chkDeleteReports())
	{
		obj=document.listForm
		pp1=obj.reportDomain.options[obj.reportDomain.selectedIndex].text
		obj.action="ezDeleteReportsPer.jsp?system=<%=system%>&reportDomain="+pp1
		obj.submit()
	}
  }
     </script>
     </head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name="listForm" method="post">
  <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">Delete Reports</Td>
  	</Tr>
</Table>
<%
if(sysRows > 0)
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    	<Tr>
      	<Td width="43%" class="labelcell">System:</Td>
      	<Td width="57%">
		 <select name="system" id=ListBoxDiv>

       		<%
         		String aSysNo,system_desc="";
         		for ( int i = 0 ; i < sysRows ; i++ )
	 		{
				aSysNo = retsys.getFieldValueString(i,SYSTEM_NO);
				system_desc = (String)(retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION));
				if(aSysNo.equals(system))
				{
%>
	       			<option value="<%=aSysNo%>" selected><%=system_desc%> -> <%=aSysNo%></option>
<%
				}else{
				%>
				<option value="<%=aSysNo%>"><%=system_desc%> -> <%=aSysNo%></option>
				<%
				}
			}
%>
        </select>

      	</Td>
	<Td width="20%" class="labelcell">Domain:</Td>
      	<Td width="25%">

	     <select name="reportDomain" id=ListBoxDiv>
       		<option value="1">Sales</option>
		<option value="2">Vendor</option>
		<option value="3">Service</option>
		<option value="4">ReverseAuction</option>
	    </select>
	
      	</Td>
      	<Td width="10%" align="center">
		<img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="ezfunSubmit()">
	</Td>
    	</Tr>
</Table>
<br>
<%
}else
{
%>
<br>
<br>
  <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">System not Available</Td>
  	</Tr>
</Table>
<%
}
if(system != null)
{
	if(retListRows >0)
	{
	%>
	<Div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="95%">
    		<Tr>
			<Th width="10%">Select</Th>
      			<Th width="22%">Report Name</Th>
      			<Th width="30%">Report Description</Th>
			<Th width="12%">Status</Th>
			<Th width="12%">Visibility</Th>
			<Th width="14%">Execution Type</Th>
      		</Tr>
		</Table>
		</Div>
		
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<%
		String repName,repDesc,repNo,status,visibility,exeType="";
		for(int i=0;i<retListRows;i++)
		{
			repName=retList.getFieldValueString(i,"ERI_REPORT_NAME");
			repDesc=retList.getFieldValueString(i,"ERI_REPORT_DESC");
			repNo=retList.getFieldValueString(i,"ERI_REPORT_NO");
			status=retList.getFieldValueString(i,"ERI_REPORT_STATUS");
			visibility=retList.getFieldValueString(i,"ERI_VISIBLE_LEVEL");
			exeType=retList.getFieldValueString(i,"ERI_EXEC_TYPE");

		%>
			<Tr>
				<Td width="10%"><Input type="radio" name="chk" value="<%=repNo%>"></Td>
				<Td width="22%"><%=repName%></Td>
				<Td width="30%"><%=repDesc%></Td>
				<Td width="12%" align="left">
				<%
					if("A".equals(status))
 	  					out.println("Active");
					else if("I".equals(status))
           					out.println("In Active");
        			%>
				</Td>
				<Td width="12%" align="left">
				<%
					if("I".equals(visibility))
 	  					out.println("Internal Users");
					else if("B".equals(visibility))
           					out.println("Business users");
					else if("A".equals(visibility))
           					out.println("All");

        			%>
				</Td>
				<Td width="14%" align="left">
				<%
					if("O".equals(exeType))
 	  					out.println("On-Line");
					else if("B".equals(exeType))
           					out.println("Back Ground");
					else if("A".equals(exeType))
           					out.println("Both");

        %>
				</Td>
			</Tr>
		<%}
		%>
					</Table>
</div>

		<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
		<Table align="center">
		<tr>
		<td align="center" colspan="2" class="blankcell">
			<img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border="none"  title="" onClick='deleteReports()' style="cursor:hand" onMouseover=";window.status=' '; return true" >
		</td>
		</tr>
		</Table>
		</Div>

	<%
	}else
	{
	%>
	<br><br>
    <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">Reports Not Available</Td>
  	</Tr>
</Table>
	<%}
}else
{
%>
	<br><br>
    <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">Select System and Click on Show</Td>
  	</Tr>
</Table>

<%
}

%>
</form>
</body>
</Html>
