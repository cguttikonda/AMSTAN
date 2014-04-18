<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQuotationComparisionForm.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
<html>
<head>
<Script>
	var tabHeadWidth=90
	var tabHeight="45%"
</Script>
<Script>
function setDimensions()
{
	if(screen.height == 600)
	{
		tabHeight="30%"
		var byPassDiv = document.getElementById("byPassDiv")
		if(byPassDiv != null)
		byPassDiv.style.top = "30%"
	}
	else
	{
		tabHeight="45%"
		var byPassDiv = document.getElementById("byPassDiv")
		if(byPassDiv != null)
		byPassDiv.style.top = "50%"
	}
}
function openWin(num)
{
	var url="ezQCFPrint.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=1000,height=650,left=0,top=0,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function SAPView(num)
{
	//var url="ezQcfSAPView.jsp?qcfNumber="+num;
	var url="ezQCFSAPPrint.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</head>
<body  onLoad="setDimensions();scrollInit(100)" onResize="scrollInit(100)" scroll=no>
<form name="myForm" method="post">
<%
	String display_header = "";
	String materialNo = qcfRet.getFieldValueString(0,"MATNR");
	String collectiveRFQNo 	= qcfRet.getFieldValueString(0,"SUBMI");	
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type=hidden name='actionNum'>
<input type=hidden name='QcfNumber' value='<%=collNo%>'>
<input type=hidden name='type' value='<%=type%>'>
<input type=hidden name='prevStatus'>
<input type=hidden name='qcsCommentNo' value='<%=commentNo%>'>
<input type=hidden name='isdelegate' value='<%=isdelegate%>'>
<input type=hidden name='commentType' value=''>
<input type=hidden name='initiator' value='<%=initiator%>'>
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">

	<Table width="40%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr align="center">
			<Th class="displayheader">Quotations Comparision Form</td>
		</Tr>
	</Table>
	<Table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="10%" align=left>Material No</Th>
			<Td width="20%" title='Click Material Code to see the Price Analysis'><a href="javascript:openGraphWin('<%=materialNo%>','MPA')"><%=Integer.parseInt(materialNo)%></a></Td>
			<Th width="10%" align=left>Material Desc</Th>
			<Td width="20%"><%=qcfRet.getFieldValueString(0,"TXZ01")%></Td>
			<Th width="10%" align=left>Collective <br>RFQ No </Th>
			<Td width="20%" title='Click Collective RFQ No to see the Quotation Analysis'><a href="javascript:openGraphWin('<%=collectiveRFQNo%>','RQPA')"><%=collectiveRFQNo%></a><Br>
			</Td>

		</Tr>
	</Table>
	<Div id="theads">
		<Table id="tabHead" width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr align="center" valign="middle">
		<Th width="27%" align=left>&nbsp;</Th>

<%
		//String disableByUsrRole="disabled";
		disableByUsrRole="disabled";
		//boolean globalDisFlg=false;
		globalDisFlg=false;
		
		if(!"SP".equals((String)session.getValue("USERROLE")))
			disableByUsrRole = "disabled";
		
		
		String vendNumber = "";
		String checkVendorNumber = "";
		for(int i=0;i<qcfCount;i++)
		{
			vendNumber = qcfRet.getFieldValueString(i,"LIFNR");
			disableByUsrRole = "";
%>			
			<Th width=24%>
			<Table width=100%>
			<Tr>
				<Th align=center colspan=2>
					<a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendNumber%>')"><font color="white"><%=qcfRet.getFieldValueString(i,"VEND_NAME")%></font></a>
				</Th>

			</Tr>
			<Tr>
<%
				String Chkd ="";
				for(int k=0;k<myRetCnt;k++)
				{
					String chkPropose = myRet.getFieldValueString(k,"VEND_TYPE");
					checkVendorNumber = myRet.getFieldValueString(k,"VENDOR");
					if(checkVendorNumber.equals(vendNumber))
					{

						if(!"A".equals(chkPropose) || "APPROVED".equals(wfStatus))
						{
							disableByUsrRole = "disabled";
						}
					}	
					if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
						Chkd ="checked";
					
				}
				if(!"disabled".equals(disableByUsrRole))
					globalDisFlg=true;
				
				
%>				<Th><input type=checkbox name=propose value="<%=qcfRet.getFieldValueString(i,"EBELN")%>" <%=Chkd%> disabled ><B>Propose</B></Th>
			</Tr>
			</Table>
			</Th>
<%		}
		if(qcfCount<3){
			for(int i=qcfCount;i<3;i++){
%>
				<Th width=24%>
					&nbsp;
				</Th>

<%
			}
		}	
	


%>
		</Tr>
		</Table>
	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:1%">
	<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	
<%
	try
	{
		StringBuffer sb=new StringBuffer();

		int outTableCount = outTable.getRowCount();

		if ( outTable != null )
		{
			for ( int i = 0 ; i < outTableCount; i++ )
			{

				String line = outTable.getLine(i);
				if (line.length() == 257)
					line = line.substring(1,line.length()-1);
				else
					line = line.substring(1,line.length());
				//out.print(line);
				sb.append(line);

			}
		}

		String str=sb.toString();

		str = str.substring(str.indexOf("</tr>")+5);
		str = str.substring(str.indexOf("</tr>")+5);



		int a=str.indexOf("</table>");

		//out.println("<table width='100%' class='list' border=0 cellSpacing=1 cellpadding=1 rules=groups borderColor=black >");
		out.println(str.substring(0,a));






	}catch(Exception e)
	{
	out.println(e);
	out.println("<br><br><br><br><Center><h3> There is no output for passed    parameters </h3></Center>");

	}
	
	
%>
	
	
	
	
	
	
	
<%		
	for(int j=0;j<qcfCount;j++)
	{
%>			
		<input type="hidden" name=allrfqs value='<%=qcfRet.getFieldValueString(j,"EBELN")%>'>

<%		
	}

	if(qcsCount > 0)
	{
%>	
		<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>			
<%
		for(int i=0;i<qcsCount;i++)
		{
			if(i == 0)
			{
%>	
				<Tr><Th width=10%>User</Th><Th width=10%>Date</Th><Th width=80%>Comments</Th></Tr>
<%
			}
%>				<Tr>
					<Td width=10%><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
					<Td width=10%><%=fd.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>
					<Td width=80%><input type=text value="<%=commentsRet.getFieldValueString(i,"QCF_COMMENTS")%>" class="tx" style='width:100%' readonly></Td>
				</Tr>
<%		}
%>
		</Table>		
<%	}
%>

</Div>	
			<%
				if(actionsList.indexOf("SUBMITTED") >= 0 && (!"APPROVED".equals(wfStatus)))
				{
			%>	
					<Div id="byPassDiv" align=center style="position:relative;visibility:visible;width:100%;top:50%">
					<Table width=90% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
					<Tr>
					<td align=right class='blankcell'>
						<!--<input type=checkbox disabled name=bypass value='BYPASS' onclick='openByPassList()'><B>ByPass</B>-->
						<input type=hidden name=hideBypassCount>
					</td>
					</Tr>
					</Table>
					</Div>
			<%
				}
			%>


<%
	//String compGroup = "PURGROUP_HEAD";
	//String compRole  = "DM";
	
	
	//String compGroup = "VICE_PRESIDENT";
	//String compRole  = "VP";
	
	String compGroup = "CEO1";
	String compRole  = "CEO";
	
	
%>



<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:90%">
	<Table>
		<Tr>
			<Td class='blankcell' >
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none style="cursor:hand" border=none onClick="JavaScript:history.go(-1)">     
			</Td>
						
			<Td class='blankcell'>
				<img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none onClick="javascript:SAPView('<%=collectiveRFQNo%>')">
			</Td>
			
			<Td class='blankcell'>
				<img src="../../Images/Buttons/<%=ButtonDir%>/status.gif" style="cursor:hand" border=none valign=bottom onClick="JavaScript:showStatusWindow(<%=qcfRet.getFieldValueString(0,"SUBMI")%>,<%=qcfNetPrice%>)">
			</Td>                    
		</Tr>
	</Table>
</Div>
<Div id="msgDiv" style="position:absolute;top:90%;width:100%;visibility:hidden" align="center">
	<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th  align="center">Your request is being processed. Please wait ...............</th>
		</Tr>
	</Table>
</Div>

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>	