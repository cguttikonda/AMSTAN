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
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iActiveUserList_Labels.jsp"%>
<%!
	public String getFinalString(String users)
	{
		String finalStr = "";
		if(!("".equals(users) && "null".equals(users) && users==null))
		{
			StringTokenizer tokenizer = new StringTokenizer(users,",");
			Vector usersVect = new Vector();
			Hashtable hs = new Hashtable ();
			int cnt = 0;
			while(tokenizer.hasMoreTokens())
			{	
				String userID = tokenizer.nextToken();

				if(!usersVect.contains(userID.trim()))
				{
					hs.put(userID,"1");
					usersVect.add(userID.trim());
				}
				else
				{
					String numOfTimes = (String)hs.get(userID);	
					numOfTimes = (Integer.parseInt(numOfTimes)+1)+"";
					hs.put(userID,numOfTimes);
				}	
			}

			Enumeration enum = hs.keys();

			while(enum.hasMoreElements())
			{

				String usr = (String)enum.nextElement();
				String num = (String)hs.get(usr);
				if(cnt==0)
					finalStr = usr+"¥"+num;
				else
					finalStr = finalStr+"§"+usr+"¥"+num;
				cnt++;	
			}
		}
		return finalStr;
	}
%>
<html>
<head>

<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
	
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
				//document.myForm.WebSysKey.selectedIndex=i;
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
			document.myForm.action="ezTimeStats.jsp";
			document.myForm.submit();
		}
	}
	
	function funShowUsers(hr,users)
	{
	
		myURL="ezTimeStatsUsers.jsp?Users="+ users +"&Hour=" + hr
		ezWin=window.open(myURL,"stats","status=no,toolbar=no,menubar=no,location=no,top=150,left=250,width=500,height=350");
        }
</Script>
<!-- <Script src="../../Library/JavaScript/WebStats/ezTimeStats.js"></Script>  -->
</head>

<BODY  onLoad="getDefaultsFromTo()" scroll="no">
<form name=myForm>
<input type="hidden" name="chkdindex">
<%
	String display_header = timeStatPA_L;
	String clickString = "onclick='funSubmit()'";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<input type=hidden name="Area" value='<%=areaFlag%>'>
<%
	
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
%>
		<!-- <TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
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
							<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
<%							
						}
%>
		     			</select>
		     			</div>
   		     		</Td>


				<Th width="10%"><%=from_L%></Th>
				<Td width="15%"><input type=text class="inputbox" name="fromDate" readonly size=12 value="<%=fromDate%>"><%=getDateImage("fromDate")%></Td>
				<Th width="10%"><%=to_L%></Th>
				<Td width="15%"><input type=text class="inputbox" name="toDate" readonly size=12 value="<%=toDate%>"><%=getDateImage("toDate")%></Td>
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
%>
			<%@ include file="../../../Includes/JSPs/WebStats/iTimeStats.jsp"%>
			<Table align=center width="80%">
				<Tr>
					<Td class=blankcell>
						<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
							<Tr>
								<Th width="50%" align=center><%=time_L%>[10AM-6PM]</Th>
								<Th width="50%"><%=frequency_L%></Th>
							</Tr>
<%
							int mTot=0;
							for(int i=10;i<=17;i++)
							{
								int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
								mTot=mTot+temp;
								String users=retWebStats.getFieldValueString(i,"USERS");
								
								
								String finalStr  = getFinalString(users);
								
%>
								<Tr>
									<Th width="50%" align=center><%=i%>-<%=i+1%></Td>
									<Td width="50%" align=right>
<%
				 					if(temp==0)
				 					{
%>				 					
										<%=temp%>
<%
									}
									else
									{
%>
										<!--<a href='JavaScript:Void(0)' onClick='funShowUsers(<%=i%>,"<%=users%>")'><%=temp%></a>-->
										<a href='#' onClick='funShowUsers(<%=i%>,"<%=finalStr%>")'><%=temp%></a>
<%
									}
%>
									</Td>
								</Tr>
<%
							}
%>
							<Tr>
								<Th width="50%" align=center><%=total_L%></Td>
								<Td width="50%" align=right><b><font size="2" color="red"><%=mTot%></font></b</Td>
							</Tr>
						</TABLE>
					</Td>
					<Td class=blankcell>
						<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
							<Tr>
								<Th width="50%" align=center><%=time_L%>[6PM-2AM]</Th>
								<Th width="50%"><%=frequency_L%></Th>
							</Tr>
<%
							int eTot=0;
							for(int i=18;i<=25;i++)
							{
			  					int tempNum =0;
			  					tempNum =i;
			  					if(i>23)
			  						i= i%24;
			  					
			  					
			  					
			  					int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
			  					eTot=eTot+temp;
			  					String users=retWebStats.getFieldValueString(i,"USERS");
			  					
			  					String finalStr  = getFinalString(users);

%>
								<Tr>
									<Th width="50%" align=center><%=i%>-<%=i+1%></Td>
									<Td width="50%" align=right>
<%
				 						if(temp==0)
				 						{
%>				 						
											<%=temp%>
<%											
										}
										else
										{
%>
											<!--<a href='JavaScript:Void(0)' onClick='funShowUsers("<%=i%>","<%=users%>")'><%=temp%></a>-->
											<a href='#' onClick='funShowUsers(<%=i%>,"<%=finalStr%>")'><%=temp%></a>
<%
										}
%>

									</Td>
								</Tr>
<%
					  			i= tempNum;	
							}
%>
							<Tr>
								<Th width="50%" align=center><%=total_L%></Td>
								<Td width="50%" align=right><b><font size="2" color="red"><%=eTot%></b></font></Td>
							</Tr>
						</TABLE>
					</Td>
					<Td class=blankcell>
						<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
							<Tr>
								<Th width="50%" align=center><%=time_L%>[2AM-10AM]</Th>
								<Th width="50%"><%=frequency_L%></Th>
							</Tr>
<%
							int dTot=0;
							for(int i=2;i<=9;i++)
							{
								int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
								dTot=dTot+temp;
								String users=retWebStats.getFieldValueString(i,"USERS");
								
								String finalStr  = getFinalString(users);
%>								

								<Tr>
									<Th width="50%" align=center><%=i%>-<%=i+1%></Td>
									<Td width="50%" align=right>
<%
										if(temp==0)
										{
%>				 						
											<%=temp%>
<%											
										}
										else
										{
%>
											<!--<a href='JavaScript:Void(0)' onClick='funShowUsers("<%=i%>","<%=users%>")'><%=temp%></a>-->
											<a href='#' onClick='funShowUsers(<%=i%>,"<%=finalStr%>")'><%=temp%></a>
<%
										}
%>

									</Td>
								</Tr>
<%
								
							}
%>
							<Tr>
								<Th width="50%" align=center><%=total_L%></Td>
								<Td width="50%" align=right><b><font size="2" color="red"><%=dTot%></font></b></Td>
							</Tr>
						</TABLE>
					</Td>
					
				</Tr>
			</Table>
<%
		}
		else
		{
%>
			<!-- <br><br><br><br>
			<Table width=60% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<th><%=plzSBUToDate_L%></Th>
				</Tr>
			</Table>  -->
<%
		}
	}
	else
	{
%>
			<br><br><br><br>
			<Table width=60% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<th><%=noSBULi_L%></Th>
				</Tr>
			</Table>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
