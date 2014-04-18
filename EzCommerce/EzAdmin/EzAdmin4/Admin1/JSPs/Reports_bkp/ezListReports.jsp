<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iListReport.jsp"%>
<%
String sysDesc=request.getParameter("sysDesc");
%>

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

     function funDelele()
     {
	var val=""
	var flag=false
	var len=document.listForm.chk1.length
	if(isNaN(len))
	{
		if(document.listForm.chk1.checked)
		{
			val=document.listForm.chk1.value
			flag=true
		}	
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.listForm.chk1[i].checked)
			{
				val=document.listForm.chk1[i].value
				flag=true
			}
		}
	}
	if(flag)
	{
		var myVal=val.split("¥");
		var system=myVal[1]
		var repNo=myVal[3]

		var domain=document.listForm.reportDomain[document.listForm.reportDomain.selectedIndex].text

		document.location.href="ezDeleteReportsPer.jsp?system="+system+"&reportDomain="+domain+"&chk="+repNo
	}
	else
	{
		alert("Please select Report to delete")
	}

     }

     function ezFunEdit()
     {
	var val=""
	var flag=false
	var len=document.listForm.chk1.length
	if(isNaN(len))
	{
		if(document.listForm.chk1.checked)
		{
			val=document.listForm.chk1.value
			flag=true
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.listForm.chk1[i].checked)
			{
				val=document.listForm.chk1[i].value
				flag=true
			}
		}
	}

	if(flag)
	{
		var myVal=val.split("¥");

		var reportName=myVal[0]
		var system=myVal[1]
		var sysDesc=myVal[2]
		var repNo=myVal[3]

		document.location.href="ezChangeReport.jsp?reportName="+reportName+"&system="+system+"&sysDesc="+sysDesc+"&repNo="+repNo
	}
	else
	{
		alert("Please select Report to edit")
	}
     }

     function funExec()
     {
	var val=""
	var flag=false
	var len=document.listForm.chk1.length
	if(isNaN(len))
	{
		if(document.listForm.chk1.checked)
		{
			val=document.listForm.chk1.value
			flag=true
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.listForm.chk1[i].checked)
			{
				val=document.listForm.chk1[i].value
				flag=true
			}
		}
	}

	if(flag)
	{
		var myVal=val.split("¥");

		var reportName=myVal[0]
		var system=myVal[1]
		var sysDesc=myVal[2]
		var repNo=myVal[3]

		document.location.href="ezChangeReportCU.jsp?reportName="+reportName+"&system="+system+"&sysDesc="+sysDesc+"&repNo="+repNo
	}
	else
	{
		alert("Please select Report to execute")
	}
     }

     function ezfunSubmit()
     {
     	if(document.listForm.system.selectedIndex != 0 && document.listForm.reportDomain.selectedIndex != 0)
	{
	  if(chkMand())
	  {
          	document.listForm.submit();
	  }
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
		if(obj.options[k].value==one[1] || obj.options[k].text==one[1])
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

<%
	if(sysRows == 0)
	{
%>
		<br><br><br><br>
  		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
    			<Td class="displayheader">There are no Systems to List</Td>
  		</Tr>
		</Table><br><center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" onClick="history.go(-1)">
		</center>
<%
		return;
	}
%>

<body onLoad="scrollInit();select1()" onResize="scrollInit()" scroll="no">
<form name="listForm" method="post">
<br>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">List Reports</Td>
  	</Tr>
</Table>
<%
if(sysRows > 0)
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
    	<Tr>
      	<Td class="labelcell" width="20%" align=right>System :</Td>
      	<Td width="25%"><input type="hidden" name="sysDesc" value="<%=sysDesc%>">
	        <select name="system" onchange="setDesc(this);ezfunSubmit()" id=ListBoxDiv>
		<option value="">--Select System--</option>
       		<%
         		String aSysNo,system_desc="";
			retsys.sort(new String[]{SYSTEM_NO_DESCRIPTION},true);
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
	<Td class="labelcell" width="20%" align=right>Domain:</Td>
      	<Td width="25%">
	     <select name="reportDomain" onChange="ezfunSubmit()" id=ListBoxDiv>
	     	<option value="">--Select Domain--</option>
       		<option value="1">Sales</option>
		<option value="2">Vendor</option>
		<option value="3">Service</option>
		<option value="4">ReverseAuction</option>
	    </select>

      	</Td>
    	</Tr>
</Table>

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
			<Th width="4%">&nbsp;</Th>
      			<Th width="16%">Report Name</Th>
      			<Th width="32%">Report Description</Th>
			<Th width="9%">Status</Th>
			<Th width="11%">Visibility</Th>
			<Th width="12%">Type</Th>
			<Th width="15%">Execution Type</Th>
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
			<label for="cb_<%=i%>">

				<Td width="4%"><input type=radio name=chk1 id="cb_<%=i%>" value="<%=repName%>¥<%=system%>¥<%=sysDesc%>¥<%=repNo%>"></Td>
				<Td width="16%" align="left"><%=repName%></Td>
				<Td width="32%" align="left"><%=repDesc%></Td>
				<Td width="9%" align="left">
				<%
					if("A".equals(status))
 	  					out.println("Active");
					else if("I".equals(status))
           					out.println("In Active");
        			%>
				</Td>
				<Td width="11%" align="left">
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
				<Td width="15%" align="left">
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
<%
}
%>
			</Table>
			</div>

	<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
		<a href="ezAddReport.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:ezFunEdit()"><img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" border=none></a>
		<a href="JavaScript:funDelele()"><img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none></a>
		<a href="JavaScript:funExec()"><img src="../../Images/Buttons/<%= ButtonDir%>/execute.gif" border="none"></a>
	</div>


	<%
	}
	else
	{
	%>
	<br><br>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">There are no Reports to List</Td>
	</Tr>
	</Table><br><center>
		<a href="ezAddReport.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
	<%}
}else
{
	if(sysRows > 0)
	{
%>
	<br><br>
    	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">Select System and Domain</Td>
  	</Tr>
	</Table>

<%
	}
}

%>


</form>
</body>
</Html>

