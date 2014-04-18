<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQuotationComparisionForm.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</head>
<body>
<form name="myForm" method="post">
	<Table width="40%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr align="center">
			<Th class="displayheader">Quotations Comparision Form</td>
		</Tr>
	</Table>
	<Table width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="10%" align=left>Material No</Th>
			<Td width="20%"><%=Integer.parseInt(qcfRet.getFieldValueString(0,"MATNR"))%></Td>
			<Th width="10%" align=left>Material Desc</Th>
			<Td width="20%"><%=qcfRet.getFieldValueString(0,"TXZ01")%></Td>
			<Th width="10%" align=left>Collective <br>RFQ No </Th>
			<Td width="20%"><%=collNo%></Td>
		</Tr>
	</Table>
	<!--<Div id="theads">-->
		<Table id="tabHead" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr align="center" valign="middle">
		<Th width="20%" align=left>&nbsp;</Th>
<%
		String disableByUsrRole="";
		if(!"SP".equals((String)session.getValue("USERROLE")))
			disableByUsrRole = "disabled";
			
		for(int i=0;i<qcfCount;i++)
		{
%>			
			<Th width=<%=80/qcfCount%>%>
			<Table width=100%>
			<Tr>
				<Th align=center colspan=2>
					<font color="black"><%=qcfRet.getFieldValueString(i,"VEND_NAME")%></font>
				</Th>

			</Tr>
			<Tr>
<%
				String Chkd ="";
				for(int k=0;k<myRetCnt;k++)
				{
					String chkPropose = myRet.getFieldValueString(k,"VEND_TYPE");
					if(!"A".equals(chkPropose))
					{
						disableByUsrRole = "disabled";
					}
					if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
						Chkd ="checked";
				}
%>				<Th><input type=checkbox name=propose disabled value="<%=qcfRet.getFieldValueString(i,"EBELN")%>" <%=Chkd%> <%=disableByUsrRole%>><B>Propose</B></Th>
			</Tr>
			</Table>
			</Th>
<%		}
%>
		</Tr>
		</Table>
	<!--</Div>-->
	<!--<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:1%">-->
	<Table id="InnerBox1Tab" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="20%" align=left><b>Quotation</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"EBELN")%></Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Quantity</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"KTMNG")%></Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Vendor</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"LIFNR")%></Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Vendor Name</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"VEND_NAME")%></Td>
<%		}
%>		</Tr>		
		<Tr>
			<Th width="20%" align=left><b>Country</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"COUNTRY")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Manufacturer</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Currency</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=ezCheckForNull(qcfRet.getFieldValueString(j,"WAERS"),"&nbsp;")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Basic Price/unit-Cur</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"NETPR_ORG")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Basic Price/unit(INR)</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"PUNIT")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Excise/CVD % </b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=ezCheckForNull(qcfRet.getFieldValueString(j,"EXCRT"),"&nbsp;")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Central sales Tax %  </b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Local Sales Tax % </b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Customs duty % </b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Exchange Rate</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"WKURS")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Basic price(val) INR</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"ZWERT")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Landed price/CIF(INR)</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"EFFWR")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Landed price/Unt(INR)</b></Th>
<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"NETPR")%></Td>
<%		}
%>		</Tr>			
		<Tr>
			<Th width="20%" align=left><b>Rank (Landed P/Unit)</b></Th>

<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%> <b><%=qcfRet.getFieldValueString(j,"RANK1")%></b></Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Delivery Terms</b></Th>

<%
		for(int j=0;j<qcfCount;j++)
		{
			String inco1 = qcfRet.getFieldValueString(j,"INCO1");
			String inco2 = qcfRet.getFieldValueString(j,"INCO2");
			
%>			<Td align=right width=<%=80/qcfCount%>%><%=ezCheckForNull(inco1,"&nbsp;")%> <%=ezCheckForNull(inco2,"&nbsp;")%></Td>
<%		}
%>		</Tr>		
		<Tr>
			<Th width="20%" align=left><b>terms of payment </b></Th>

<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%><%=qcfRet.getFieldValueString(j,"ZBTXT")%></Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Valuation Type </b></Th>

<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>
		<Tr>
			<Th width="20%" align=left><b>Expiry Date </b></Th>

<%
		for(int j=0;j<qcfCount;j++)
		{
%>			<Td align=right width=<%=80/qcfCount%>%>&nbsp;</Td>
<%		}
%>		</Tr>
	</Table>
<%
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
					<Td width=80%><input type=text value="<%=commentsRet.getFieldValueString(i,"QCF_COMMENTS")%>" class="tx" size=75 readonly></Td>
				</Tr>
<%		}
%>
		</Table>		
<%	}
%>
<!--</Div>-->	
<%!
	public String ezCheckForNull(String str,String defStr)
	{
		if((str==null) || ("null".equals(str)) || ((str.trim()).length() == 0))
			str = defStr;
		return str.trim();
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>	