<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iListReport.jsp"%>
<%
String sysDesc=request.getParameter("sysDesc");
%>
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
     function setDesc(obj)
     {
	pp1=obj.options[obj.selectedIndex].text

	document.listForm.sysDesc.value=pp1
     }

function loadSelect(j)
{
	var one=j.split(",");
	obj =eval("document.listForm."+one[0]);

	var Length=obj.options.length;
	for(var k=0;k<Length;k++)
	{
		if(obj.options[k].value==one[1])
		{
			obj.options[k].selected=true
			 break;
		}
	}
 }

var selSelect = new Array();
function select1()
{
	loadSelect("reportDomain,<%=reportDomain%>");
}

     </script>
     </head>
<body onLoad="scrollInit();select1()" onResize="scrollInit()" scroll="no">
<form name="listForm" method="post">
  <Table  width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">List Reports</Td>
  	</Tr>
</Table>
<%
if(sysRows > 0)
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="95%">
    	<Tr>
      	<Td class="labelcell" width="20%">System :</Td>
      	<Td width="25%"><input type="hidden" name="sysDesc" value="<%=sysDesc%>">
	        <select name="system" onchange="setDesc(this)" id=ListBoxDiv>

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
	<Td class="labelcell" width="20%">Domain:</Td>
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
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    		<Tr>
      			<Th width="12%">Report Name</Th>
      			<Th width="40%">Report Description</Th>
			<Th width="12%">Status</Th>
			<Th width="12%">Visibility</Th>
			<Th width="12%">Type</Th>
			<Th width="12%">Execution Type</Th>
      		</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<%
		String repName,repDesc,repNo,status,visibility,reportType,exeType="";
		for(int i=0;i<retListRows;i++)
		{
			repName=retList.getFieldValueString(i,"ERI_REPORT_NAME");
			repDesc=retList.getFieldValueString(i,"ERI_REPORT_DESC");
			repNo=retList.getFieldValueString(i,"ERI_REPORT_NO");
			status=retList.getFieldValueString(i,"ERI_REPORT_STATUS");
			visibility=retList.getFieldValueString(i,"ERI_VISIBLE_LEVEL");
			reportType=retList.getFieldValueString(i,"ERI_REPORT_TYPE");
			exeType=retList.getFieldValueString(i,"ERI_EXEC_TYPE");

		%>
			<Tr>
				<Td width="12%" align="left"><a href='ezChangeReport.jsp?reportName=<%=repName%>&system=<%=system%>&sysDesc=<%=sysDesc%>&repNo=<%=repNo%>'><%=repName%></a></Td>
				<Td width="40%" align="left"><a href='ezChangeReport.jsp?reportName=<%=repName%>&system=<%=system%>&sysDesc=<%=sysDesc%>&repNo=<%=repNo%>'><%=repDesc%></a></Td>
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
				<Td width="12%" align="left">
				<%
					if("1".equals(reportType))
 	  					out.println("On-Line");
					else if("2".equals(reportType))
						out.println("Back End");
        			%>
				</Td>
				<Td width="12%" align="left">
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
	if(sysRows > 0)
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
}

%>
</form>
</body>
</Html>

