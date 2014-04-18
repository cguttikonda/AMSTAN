<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iListBGStatus.jsp"%>
<%
	String sysDesc=request.getParameter("sysDesc");
%>
<%--

 3 ::  Field Name : ERS_COUNTER ----> Field Value : 72
 3 ::  Field Name : ERS_REPORT_NO ----> Field Value : 86
 3 ::  Field Name : ERS_SPOOL_NO ----> Field Value : SP123
 3 ::  Field Name : ERS_SYSTEM_NO ----> Field Value : 999
 3 ::  Field Name : ERS_USER_ID ----> Field Value : EZCADMIN
 3 ::  Field Name : ERS_CREATION_DATE ----> Field Value : 3.6.103
 3 ::  Field Name : ERS_CREATION_TIME ----> Field Value : 1.57.59
 3 ::  Field Name : ERS_REPORT_PATH ----> Field Value : EZCADMIN\SAPREPORT\2003\7\1057696772407_Report.txt
 3 ::  Field Name : ERS_VIEW_FLAG ----> Field Value : N
 3 ::  Field Name : ERS_EMAIL ----> Field Value : EMail
 3 ::  Field Name : ERS_REPORT_FORMAT ----> Field Value : P
 3 ::  Field Name : ERS_EXT1 ----> Field Value :
 3 ::  Field Name : ERS_EXT2 ----> Field Value :
 3 ::  Field Name : ERI_REPORT_NO ----> Field Value : 86
 3 ::  Field Name : ERI_SYSTEM_NO ----> Field Value : 999
 3 ::  Field Name : ERI_REPORT_NAME ----> Field Value : ZANOPT33
 3 ::  Field Name : ERI_REPORT_DESC ----> Field Value : Final test
 3 ::  Field Name : ERI_LANG ----> Field Value : EN
 3 ::  Field Name : ERI_REPORT_TYPE ----> Field Value : 2
 3 ::  Field Name : ERI_EXEC_TYPE ----> Field Value : B
 3 ::  Field Name : ERI_VISIBLE_LEVEL ----> Field Value : A
 3 ::  Field Name : ERI_BUSINESS_DOMAIN ----> Field Value : 1
 3 ::  Field Name : ERI_REPORT_STATUS ----> Field Value : A
 3 ::  Field Name : ERI_EXT1 ----> Field Value :
 3 ::  Field Name : ERI_EXT2 ----> Field Value :
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
	if(document.listForm.system.selectedIndex!=0 && document.listForm.reportDomain.selectedIndex!=0)
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
function ezSpool(obj,filename)
{
	tokens=filename.split('µ');
	filename=""
	for (i=0;i<tokens.length;i++){
		if (i==tokens.length-1)
			filename=filename+tokens[i]
		else
			filename=filename+tokens[i]+"//"
	}
	obj=obj+"&filename="+filename
	document.listForm.action=obj
	document.listForm.submit();
}
     </script>
     </head>
<body  onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=no>
<form name="listForm" method="post">
<br>
  <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">List Back Ground Reports Status</Td>
  	</Tr>
</Table>
<%
if(sysRows > 0)
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
    	<Tr>
      	<Td width="15%" class="labelcell">System :</Td>
      	<Td width="30%"><input type="hidden" name="sysDesc" value="<%=sysDesc%>">

	         <select name="system" onchange="setDesc(this);ezfunSubmit()" id=ListBoxDiv>
	         <Option>--Select System--</Option>

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
	<Td width="20%" class="labelcell">Domain:</Td>
      	<Td width="25%">

	     <select name="reportDomain" id=ListBoxDiv onChange = "ezfunSubmit()">
	     <Option>--Select Domain--</Option>
       		<option value="1">Sales</option>
		<option value="2">Vendor</option>
		<option value="3">Service</option>
		<option value="4">ReverseAuction</option>
	    </select>

      	</Td>
<!--      	<Td width="10%" align="center">
		<img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="ezfunSubmit()">
	</Td>
-->
	</Tr>
</Table>

<%
}else
{
%>
<br><br><br><br>
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
      			<Th width="15%">Execution ID</Th>
      			<Th width="40%">Report Name</Th>
			<Th width="15%">Submission Date</Th>
			<Th width="15%">Submission Time</Th>
                        <Th width="15%">Execution Status</Th>
      		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
		<%
		String repCounter,repDate,repNo,repTime,repName,spool,filename,repDesc="";
		for(int i=0;i<retListRows;i++)
		{
			repCounter=retList.getFieldValueString(i,"ERS_COUNTER");
			repNo=retList.getFieldValueString(i,"ERS_REPORT_NO");
			repName=retList.getFieldValueString(i,"ERI_REPORT_NAME");
			repDesc=retList.getFieldValueString(i,"ERI_REPORT_DESC");
			repTime=retList.getFieldValueString(i,"ERS_CREATION_TIME");
			repDate=retList.getFieldValueString(i,"ERS_CREATION_DATE");
			spool=retList.getFieldValueString(i,"ERS_SPOOL_NO");
			filename=retList.getFieldValueString(i,"ERS_REPORT_PATH");
			filename=filename.replace('\\','µ');

                        if ((spool==null)||(spool.trim().length() ==0)||("null".equals(spool)))
			        spool="NA";
		%>
			<Tr>
                                <%if(!"NA".equals(spool)){%>
                                        <Td width="15%" align="left"><a href='JavaScript:ezSpool("ezSpool.jsp?system=<%=system%>&repCounter=<%=repCounter%>&spool=<%=spool%>","<%=filename%>")'><%= repCounter %></a></Td>
                                <%}else{%>
                                        <Td width="15%" align="left"><a href='ezSpool.jsp?system=<%=system%>&repCounter=<%=repCounter%>'><%= repCounter %></a></Td>
                                <%}%>

				<Td width="40%"><%=repDesc%></Td>
				<Td width="15%" align="center"><%=repDate%></Td>
                                <Td width="15%" align="center"><%=repTime%></Td>
                                <%if("NA".equals(spool)){%>
                                        <Td width="15%">Submitted</Td>
                                <%}else{%>
                                        <Td width="15%">Spooled</Td>
                                <%}%>
			</Tr>
		<%}
		%>
		</Table>
</div>


	<br>
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
    		<Td class="displayheader">Please select System and Domain.</Td>
  	</Tr>
	</Table>

<%
      }
}

%>
</form>
</body>
</Html>

