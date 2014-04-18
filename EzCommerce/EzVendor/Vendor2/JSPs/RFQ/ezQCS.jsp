<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQcs.jsp" %>


<jsp:useBean id="EzGlobal" class="ezc.ezbasicutil.EzGlobal" scope="session" /> 
<html>
<head>
<Script>
	var tabHeadWidth=90
	var tabHeight="65%"
	
</Script>
<script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>	
<Title>Quotation Comparative Statement-- Powered by EzCommerce India(An Answerthink Company)</Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

</head>
<body  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type=hidden name='actionNum'>
<input type=hidden name='QcfNumber' value='<%=colectiveNo%>'>
<input type=hidden name='type' value='<%=type%>'>
<input type=hidden name='prevStatus'>
<input type=hidden name='qcsCommentNo' value='<%=commentNo%>'>
<input type=hidden name='isdelegate' value='<%=isdelegate%>'>
<input type=hidden name='commentType' value=''>
<input type=hidden name='initiator' value='<%=initiator%>'>

<%
	String display_header = "";
%>	

<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<%
	if(intEkko.getNumRows() ==0)
	{
%>
		<br><br><br>
		<TABLE width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th class="displayheader"> No Qutoation Entered Yet</Th>
		</Tr>
		</Table>
		<div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="funBack();">
		</div>
<%
	}
	else
	{
%>
		<input type=hidden name="collectiveRFQNo" value="<%=colectiveNo%>">
		<TABLE width="40%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr align="center">
			<Th class="displayheader">Quotations Comparision Form</td>
		</tr>
		</Table>
		<TABLE width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="20%">Collective <br>RFQ No </Th>
			<Td width="30%"><%=colectiveNo%></Td>
			<Th width="20%">Material</Th>
			<Td width="30%"><%=retDetails.getFieldValueString("MATDESC")%></Td>
		</Tr>
		<Tr>
			<Th width="20%">Qty </Th>
			<Td width="30%"><%=retDetails.getFieldValueString("QTY")%></Td>
			<%

				if(actionsList.indexOf("SUBMITTED") >= 0)
				{
			%>	
					<td colspan=2 align=left>
						<input type=checkbox name=bypass value='BYPASS' onclick='openByPassList()'><B>ByPass</B>
						<input type=hidden name=hideBypassCount>
					</td>
			<%
				}
			%>
			
			
			
		</Tr>
		</Table>

		<DIV id="theads">
		<Table id="tabHead" width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr align="center" valign="middle">
			<Th width="20%">Price break up</Th>
	

<%
		String disableByUsrRole="";
		if(!"SP".equals((String)session.getValue("USERROLE")))
			disableByUsrRole = "DISABLED";
		for(int i=0;i<retHeader.getRowCount();i++)
		{
%>
			<Th width=<%=80/retHeader.getRowCount()%>%>
			<Table width=100%>
			<Tr>
				<Th align=center colspan=2>
					<a href = "ezVendorContactDetails.jsp?SysKey=<%=(String)session.getValue("SYSKEY")%>&SoldTo=<%=retHeader.getFieldValueString(i,"VENDOR_NO")%>"><font color="white"><%=retHeader.getFieldValueString(i,"VENDOR_NAME")%></font></a>
				</Th>

			</Tr>
			<Tr>
				<Th align=left>Quotation#  <%=retHeader.getFieldValueString(i,"QUOTE_NO")%></Th>
<%
				String Chkd ="";
				if(myRetCnt>0)
				{
					for(int k=0;k<myRetCnt;k++)
					{
						if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(retHeader.getFieldValueString(i,"QUOTE_NO").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
							Chkd ="checked";
					}
%>					<Th><input type=checkbox name=propose value="<%=retHeader.getFieldValueString(i,"QUOTE_NO")%>" <%=Chkd%> <%=disableByUsrRole%>><B>Propose</B></Th>			
<%				}
%>
			</Tr>
			</Table>
			</Th>
<%		}

%>
		</Tr>
		</table>
		</DIV>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:1%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
		int myRowCount= myFinalRet.getRowCount();
		int myColCount= myFinalRet.getColumnCount()-2;
		for(int i=0;i<myRowCount-1;i++)
		{
%>
			<Tr>
			<Td width="20%"><b><%=myFinalRet.getFieldValueString(i,"DESC")%></b></Td>
		
<%
			for(int j=0;j<myColCount;j++)
			{

			String myValue = myFinalRet.getFieldValueString(i, "VAL"+(j+1));
			if(myValue==null || "null".equals(myValue))
			 myValue="0";
		
%>
			<Td align=right width=<%=80/myColCount%>%><%=myFormat.getCurrencyString(myValue)%></Td>
<%
			}
%>
			</Tr>
<%		}
%>
<%--		<Tr>
		<Td width="20%"><b>Landed Cost</b></Td>
<%
		for(int i=0;i<retDetails.getRowCount();i++)
		{
%>
			<Td align=right width=<%=80/myColCount%>%><%=myFormat.getCurrencyString(retDetails.getFieldValueString(i,"NETPR"))%></Td>
<%
		}
%>
		</Tr>
		<Tr>
		<Td width="20%"><b>Discount</b></Td>
<%
		for(int j=0;j<myColCount;j++)
		{
			String myValue = myFinalRet.getFieldValueString(myFinalRet.getRowCount()-1, "VAL"+(j+1));
			if(myValue==null || "null".equals(myValue))
			myValue="0";		
%>
			<Td align=right width=<%=80/myColCount%>%><%=myValue%></Td>
<%
		}
%>
		</Tr>
--%>
		<Tr>
		<Td width="20%"><b>Net Price</b></Td>
		
<%
		for(int i=0;i<retDetails.getRowCount();i++)
		{
		
			double myDiscount= 0;
			double netPrice=0;
			double exDuty=0;
			   
			try
			{
				String temp1=myFinalRet.getFieldValueString(myFinalRet.getRowCount()-1, "VAL"+(i+1));
				String temp2=retDetails.getFieldValueString(i,"NETPR");
				String temp3=myFinalRet.getFieldValueString(1, "VAL"+(i+1));
				
				if(temp1!=null && !"null".equals(temp1))
				{
					myDiscount=Double.parseDouble(temp1);
				}
				if(temp3!=null && !"null".equals(temp3))
				{
					exDuty= Double.parseDouble(temp3);
				}
					
				netPrice=Double.parseDouble(temp2);
				
				netPrice=netPrice-exDuty+myDiscount;
			}
			catch(Exception e)
			{
				//netPrice=Double.parseDouble(retDetails.getFieldValueString(i,"NETPR"));
			}
				
		
%>
			<Td align=right width=<%=80/myColCount%>%><%=myFormat.getCurrencyString(netPrice)%></Td>
<%
		}
%>
		</Tr>		
		<Tr>
		<Td width="20%"><b>Net Value</b></Td>
<%
		for(int i=0;i<retDetails.getRowCount();i++)
		{
			
%>
			<Td align=right width=<%=80/myColCount%>%><%=myFormat.getCurrencyString(retDetails.getFieldValueString(i,"NETVALUE"))%></Td>
<%
		}
%>
		</Tr>

		<Tr>
		<Td width="20%"><b>RANK</b></Td>
		
<% 		for(int i=0;i<retHeader.getRowCount();i++)
		{
			
			ranksHash.put(retHeader.getFieldValueString(i,"QUOTE_NO"),retHeader.getFieldValueString(i,"RANK"));
%>			
			<input type=hidden name="ranks" value="<%=retHeader.getFieldValueString(i,"QUOTE_NO")+"¥"+ retHeader.getFieldValueString(i,"RANK")%>">
			<Td align=right width=<%=80/myColCount%>%><%=retHeader.getFieldValueString(i,"RANK")%></Td>
<%
		}
		session.putValue("rankHash",ranksHash);
%>
		</Tr>
		</Table>


<%
	if(qcsCount > 0)
	{
%>	
		<TABLE width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >			
<%
		for(int i=0;i<qcsCount;i++)
		{
			if(i == 0)
			{
		%>	
				<Tr><Th width=10%>User</Th><Th width=10%>Date</Th><Th width=80%>Comments</Th></Tr>
		<%
			}
		%>
				<Tr>
					<Td width=10%><%=qcsRet.getFieldValueString(i,"QCF_USER")%></Td>
					<Td width=10%><%=fd.getStringFromDate((Date)qcsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>
					<Td width=80%><input type=text value="<%=qcsRet.getFieldValueString(i,"QCF_COMMENTS")%>" class="tx" size=75 readonly></Td>
					
				</Tr>
				
<%
		}
%>
		</Table>		
<%
	}
%>

	<TABLE width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >			
	<Tr>
		<%if(! "100067".equals(actionCheck)){%>
		<Th width=6%>Comments</Th><Th width=40%><textarea style='width:100%' rows=3 name=qcfComments ></textarea></Th>
		<%//}%>
		
		<th align="center" width=10%><a href="JavaScript:funAttach()" title="Click To Attach A File"><Font color="white">Attach File</Font></a></th>
		<Td align="center" width=34% valign="bottom">
			<select name="attachs" style="width:100%" size=4>
			</select>
		</Td> 
<%		
		}
		if(noOfDocs>0)
		{
%>		
			<Th class='blankcell' width=10%  align='center'><img src="../../Images/Buttons/<%=ButtonDir%>/attachment.gif" border=none width="25" height="25" style="cursor:hand" border=none onClick="javascript:showAttchdFiles('<%=colectiveNo%>')" title="Click To See Attached Files"></Th>       	
<%
		}    
%>		
	</Tr>
	</Table>		
	</Div>	
<%	
	if(! "100067".equals(actionCheck))		
	{	
%>
<div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:95%">
<TABLE id='ButtonTab' width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=1 >			
<Tr>
	<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none style="cursor:hand" border=none onClick="JavaScript:history.go(-1)"></Td>      
<%
	if((actionsList.indexOf("APPROVED") >= 0  && !"SUPERVISOR".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")) || "VP".equals((String)session.getValue("USERROLE")))
	{
%>
		<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/Approve.gif" style="cursor:hand" border=none onClick="funSubmit('100067')"></Td>                     
<%
	}
	if((actionsList.indexOf("SUBMITTED") >= 0 && ! "VICE_PRESIDENT".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")))
	{
%>
		<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="funSubmit('100066')"></Td>                      
<%
	}
	if((actionsList.indexOf("REJECTED") >= 0  && ! "PUR_PERSON".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")))
	{
%>
		<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/rejected.gif" style="cursor:hand" border=none onClick="funSubmit('100068')"></Td>                    
<%
	}
%>
	<Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/requote.gif" style="cursor:hand" border=none valign=bottom onClick="JavaScript:reQuote()"></Td>                    
	<Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none valign=bottom onClick="funPrint()"></Td>                                
	<Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none valign=bottom onClick="document.myForm.reset()"></Td>                   
	<Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/Cancel.gif" style="cursor:hand" border=none valign=bottom onClick="window.close()"></Td>                           
	<Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/remove1.gif" border=none style="cursor:hand" valign=bottom border=none onClick="JavaScript:funRemove()"></Td>      
<%
	if(!"PUR_PERSON".equals((String)session.getValue("ROLE")))
	{
%>		<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/addquery.gif" border=none style="cursor:hand" border=none onClick="JavaScript:funOpenWin()"></Td>      
<%	}
%>	
</Tr>
</Table>
</div>
<%	
	}
	else
	{
%>
<div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:90%">
<TABLE id='ButtonTab' width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=1 >			
<Tr>
	<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none style="cursor:hand" border=none onClick="JavaScript:history.go(-1)"></Td>      
	<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()"></Td>
	<Td class='blankcell' ><img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none onClick="funPrint()"></Td>
</Tr>
</Table>
</Div>
<%
	}
	}
%>

<div id="msgDiv" style="position:absolute;top:90%;width:100%;visibility:hidden" align="center">
<table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<tr>
<th  align="center">Your request is being processed. Please wait ...............</th>
</tr>
</table>
</div>

<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
