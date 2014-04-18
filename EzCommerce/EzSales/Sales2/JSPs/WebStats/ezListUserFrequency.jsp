<%--
***************************************************************
       /* =====================================
        * Copyright Notice 
	* This file contains proprietary information of Answerthink India Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 
	=====================================*/

       /* =====================================
        * Author : Girish Pavan Cherukuri
	* Team : EzcSuite
	* Date : 16-09-2005
	* Copyright (c) 2005-2006 
	=====================================*/
***************************************************************
--%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/JSPs/WebStats/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iActiveUserList_Labels.jsp"%>
<html>
<head>
	<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
	
<Script>
	var tabHeadWidth=70
	var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>	
<Script>



	var plzFdate_L = '<%=plzFdate_L%>';
	var plzTdate_L = '<%=plzTdate_L%>';	
	function getDefaultsFromTo()
	{

<%		
		
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		tomorrow.setDate(today.getDate()+1);

		ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();

		if (("".equals(fromDate))&&("".equals(toDate)))
		{%> 
			document.myForm.FromDate.value ="<%=format.getStringFromDate(today,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
			document.myForm.ToDate.value ="<%=format.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		<%}%>
		var len = 0 ;
		if(document.myForm.WebSysKey!=null)
			len =document.myForm.WebSysKey.options.length;
		for(i=0;i<len;i++)
		{
			if(document.myForm.WebSysKey.options[i].value=="<%=WebSysKey%>")
			{
				document.myForm.WebSysKey.selectedIndex='<%=request.getParameter("chkdindex")%>';
				break;
			}
		}

	}
	function funSubmit()
	{
		if(document.myForm.FromDate.value=="")
		{
			alert(plzFdate_L)
				return false;
		}		
		else if(document.myForm.ToDate.value=="")
		{
			alert(plzTdate_L)
				return false;
		}
		else
		{
			document.myForm.chkdindex.value=document.myForm.WebSysKey.selectedIndex;
			document.myForm.action="ezListUserFrequency.jsp";
			document.myForm.submit();
		}
        }
</Script>
<!-- <Script src="../../Library/JavaScript/WebStats/ezListUserFrequency.js"></Script>   -->
</head>

<BODY onLoad="scrollInit();getDefaultsFromTo();" onResize="scrollInit()"  scroll=no>
<form name=myForm>

<input type="hidden" name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<input type="hidden" name="chkdindex">
<%
	String display_header =usrFreqPA_L;
	String clickString = "onclick='funSubmit()'";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
%>
		<!-- <TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr align="center">
				<Th width="25%"><%=sbu_L%></Th>
				<Td width="15%">
					<div id="listBoxDiv1">
						<select name="WebSysKey" class="control">
						<option value="">All</option>
<%
							StringBuffer all=new StringBuffer("");
							
							for(int i=0;i<sysRows;i++)
							{
								if(i==0)
								{
									all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
								}
								else
								{
									all.append(",");
									all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
								}
%>								
								<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'" ><%= ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION) %></option>
<%								
							}
%>
		     				</select>
		     			</div>    
		     		  
   		     		</Td>
		   		<Th width="10%"><%=from_L%></Th>
		   		<Td width="15%"><input type=text  class=inputbox  name="fromDate" readonly size=12 value="<%=fromDate%>"><%=getDateImage("fromDate")%></Td>
		   		<Th width="10%"><%=to_L%></Th>
		   		<Td width="15%"><input type=text class=inputbox  name="toDate" readonly size=12 value="<%=toDate%>"><%=getDateImage("toDate")%></Td>
		   		<Td class="blankcell" width="10%">
				<%
						buttonName = new ArrayList();
						buttonMethod = new ArrayList();
						buttonName.add("Go");
						buttonMethod.add("funSubmit()");
						out.println(getButtonStr(buttonName,buttonMethod));
				%>
		   		</Td>
		  	</Tr>
		</TABLE>   -->
		<%@ include file="../Misc/ezSelectDateWebStats.jsp"%>
		<Script>
			document.myForm.WebSysKey.options[0].value="<%=allopt.toString()%>"
  		</Script>
		
<%
		if(WebSysKey!=null)
		{
			String noDataStatement =noUserYet_L;
%>
			<%@ include file="../../../Includes/JSPs/WebStats/iListUserFrequency.jsp"%>
<%
			
			
			if(retWebStatsCount==0)
			{
%>
				 <!-- <TABLE width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
					<Tr>
						<Th><%=noUserYet_L %></Th>
					</Tr>
				</TABLE>   -->
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
				
<%
			}
			else
			{
%>			
				    <DIV id="theads">
					<table id="tabHead" width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
						<Tr>
							<Th width="20%" align=center><%=userId_L%></Th>
							<Th width="60%" align=center><%=userName_L%></Th>
							<Th width="20%" align=center><%=frequency_L%></Th>
						</Tr>
					</Table>
				</DIV>
				<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:10%;left:2%">
				<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
					String className = "";
					int a=0;
					for(int i=0;i<retWebStatsCount;i++)
					{
						a++;
						if(a%2==0) className="class=color";
						else className="";
%>
						<Tr>
							<Td <%=className%> width="20%" align=left><%=retWebStats.getFieldValue(i,"USER_ID")%></Td>
							<Td <%=className%> width="60%" align=left><%=retWebStats.getFieldValue(i,"NAME")%></Td>
							<Td <%=className%> width="20%" align=right><%=retWebStats.getFieldValue(i,"FREQUENCY")%></Td>
						</Tr>
<%
					}
			}
%>
				</TABLE>
				</DIV>
<%
		}
		else
		{
%>
			<!-- <br><br>
			<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Th><%=plzSBUToDate_L%></Th>
				</Tr>
			</TABLE>     -->
<%
		}
	}
	else
	{
%>
		<br><br>
		<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th><%=noSBULi_L%></Th>
			</Tr>
		</TABLE>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
