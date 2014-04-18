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

<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iActiveUserList_Labels.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>

<html>
<head>  

<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>

<Script>
	var tabHeadWidth=90
	var tabHeight="50%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<Script>


	var plzFdate_L = '<%=plzFdate_L%>';
	var plzTdate_L = '<%=plzTdate_L%>';	
	
	function getDefaultsFromTo()
	{
<%
		
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		today.setDate(today.getDate()-1); 
		ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();

		
		if (("".equals(fromDate))&&("".equals(toDate)))
		{%> 
			document.myForm.FromDate.value = "<%=format.getStringFromDate(today,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
			document.myForm.ToDate.value = "<%=format.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		<%}%> 
		for(i=0;i<document.myForm.WebSysKey.options.length;i++)
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
			document.myForm.action="ezListWebStatsBySBU.jsp";
			document.myForm.submit();
		}
	}


</Script>
<!-- <Script src="../../Library/JavaScript/WebStats/ezListWebStatsBySBU.js"></Script> -->
</head>

<BODY  scroll="no"  onLoad="getDefaultsFromTo();scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')">
<form name=myForm>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<input type="hidden" name="chkdindex">
<%
	String display_header = viewWsPurA_L;
	FormatDate fD=new FormatDate();
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
							<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'" ><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%							
						}
%>
		     			</select>
		     			</div>

				</Td>
				<Th width="10%"><%=from_L%></Th>
				<Td width="15%">
					    <input type=text name="fromDate" size=12 class="inputbox" value="<%=fromDate%>" readonly ><%=getDateImage("fromDate")%>
				</Td>
				<Th width="10%"><%=to_L%></Th>
				<Td width="15%">
					<input type=text name="toDate" size=12  class="inputbox" value="<%=toDate%>" readonly><%=getDateImage("toDate")%>
				</Td>
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
		</TABLE>  -->
		<%@ include file="../Misc/ezSelectDateWebStats.jsp"%>
		<Script>
				document.myForm.WebSysKey.options[0].value="<%=allopt.toString()%>"
		</Script>
		
<%
		if(WebSysKey!=null)
		{
			String noDataStatement =noUserYet_L;
%>
			<%@ include file="../../../Includes/JSPs/WebStats/iListWebStats.jsp"%>
<%
			
			if(retWebStatsCountList==0)
			{
%>	
				<!-- <br><br><br><br>
				<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
					<Tr>
						<Th><%=noUserYet_L%></Th>
					</Tr>
				</TABLE> -->
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>				

<%
			}
			else
			{
%>

				<DIV id="theads">
					<TABLE   id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
						<Tr>
							<Th width="13%" align=center rowspan=2><%=userId_L%></Th>
							<Th width="19%" align=center  rowspan=2><%=userName_L%></Th>
							<Th width="17%" align=center  rowspan=2><%=IP_L%></Th>
							<Th width="25%" align=center colspan=2><%=logIn_L%></Th>
							<Th width="26%" align=center colspan=2><%=logOut_L%></Th>
						</Tr>
						<Tr>
							<Th width="13%" align="center"><%=date_L%></Th>
							<Th width="12%" align="center"><%=time_L%></Th>
							<Th width="13%" align="center"><%=date_L%></Th>
							<Th width="13%" align="center"><%=time_L%></Th>
						</Tr>
					</TABLE>
				</DIV>
				<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:70%;left:2%">
					<TABLE id="InnerBox1Tab"  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
						String loginDate = "";
						String logotDate = "";
						String loginTime = "";
						String logotTime = "";
						String loggedIn  = "";
						String loggedOut = "";
						String ipAddress = "";
						String className = "";
						String userTemp ="";
						Date tempDate=null;
						java.util.Vector totUsers = new java.util.Vector();
						
						int a=0;
						for(int i=0;i<retWebStatsCountList;i++)
						{
							loggedIn	= retWebStats.getFieldValueString(i,"LOGGED_IN");   //loggedIn2005-09-16 
							loggedOut	= retWebStats.getFieldValueString(i,"LOGGED_OUT"); //loggedOut2005-09-16 
							loggedOut	= (loggedOut==null)||"null".equals(loggedOut)?"&nbsp;       &nbsp;":loggedOut;
							loginDate 	= loggedIn.substring(0,10);
							loginTime 	= loggedIn.substring(11,19);
							
							if(!loggedIn.equals(loggedOut))
							{
								logotDate = loggedOut.substring(0,10);
								logotDate = logotDate.replace('-','/');
								logotDate = fD.getStringFromDate((java.util.Date)new Date(logotDate),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
								logotTime = loggedOut.substring(11,19);
							}
							else
							{
								
								logotDate = "";
								logotTime = "";
							}

							
							if("null".equals(retWebStats.getFieldValue(i,"IP")))
								ipAddress = "&nbsp;";
							else
								ipAddress = retWebStats.getFieldValue(i,"IP")+"&nbsp;";
							
							a++;
							if(a%2==0) className="class=color";
							else className="";
							
							try
							{
								userTemp = retWebStats.getFieldValueString(i,"USER_ID") ;
								if(!totUsers.contains(userTemp.trim()))
									totUsers.add(userTemp.trim());
							}		
							catch(Exception e){}		
							
%>
							<Tr>
								<Td <%=className%> width="13%" align=left><%=retWebStats.getFieldValue(i,"USER_ID")%></Td>
								<Td <%=className%> width="19%" align=left><%=retWebStats.getFieldValue(i,"NAME")%></Td>
								<Td <%=className%> width="17%" align=center><%=ipAddress%></Td>
								<Td <%=className%> width="13%" align=center>
								&nbsp;
								<%=fD.getStringFromDate((java.util.Date)retWebStats.getFieldValue(i,"LOGGED_IN"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>	
								</Td>
								<Td <%=className%> width="12%" align=center><%=loginTime%>&nbsp;</Td>
								<Td <%=className%> width="13%" align=center><%=logotDate%>&nbsp;</Td>
								<Td <%=className%> width="13%" align=center><%=logotTime%>&nbsp;</Td>
							</Tr>
<%
						}
%>
					</TABLE>
				</Div>
				
				<Div id='showTot' align='center' STYLE='Position:Absolute;left:5%;width:78%;height:10%;top:84%'>
					
					<Table align=left width=32% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
						<Tr>
							<Th width="40%"><%=totalUsers_L %></Th>
							<Td width="60%" align=right><font color="#ff0000" size="2" ><b><%=totUsers.size()%></b></font></Td>
						</Tr>
						<Tr>
							<Th width="40%"><%=totLogins_L%></Th>
							<Td width="60%" align=right><font color="#ff0000" size="2" ><b><%=retWebStatsCountList%></b></font></Td>
						</Tr>
					</Table>
				</Div>
<%
			}
		}
		else
		{
%>
			<!-- <br><br><br><br>
			<Table width=60% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Th><%=plzSBUToDate_L%></Th>
				</Tr>
			</Table>  -->
<%
		}
	}
	else
	{
		//out.println(noSBULi_L);
	}

	if(request.getParameter("fromLoginDetails") != null && "Y".equals(request.getParameter("fromLoginDetails")))
	{
%>
		<Script>
			funSubmit();
		</Script>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
