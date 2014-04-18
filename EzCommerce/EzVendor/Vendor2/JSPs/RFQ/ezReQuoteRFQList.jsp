<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezpreprocurement.client.EzPreProcurementManager" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	String collRfq = request.getParameter("QcfNumber");
	
	EzPreProcurementManager manager = new EzPreProcurementManager();
	EzcParams mainParams = new EzcParams(false);
	mainParams.setLocalStore("Y");
	EziRFQHeaderParams params = new EziRFQHeaderParams();
	params.setExt1("RFQ");
	params.setCollectiveRFQNo(collRfq);
	params.setStatus("Y','R");
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)manager.ezGetRFQList(mainParams);	
	int rowCount = ret.getRowCount();
%>
<html>
<head>
<Script>
var tabHeadWidth=70
var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<title>List of RFqs</title>
<Script>
	function reQuote()
	{
		var flag=false
		var len = document.myForm.chk1.length
		if(isNaN(len))
		{
			if(document.myForm.chk1.checked)
				flag = true
		}
		else
		{
			for(var k=0;k<len;k++)
			{
				if(document.myForm.chk1[k].checked)
					flag = true
			}
		}
		if(flag)
		{
			hideButton();
			document.myForm.action="ezCounterOffer.jsp";
			document.myForm.submit();
		}
		else
		{
			alert("Please select atleast one RFQ for Re-Quote")
		}
	}
</Script>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</head>
<body  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<%
	String display_header = "List of RFQs";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(rowCount==0)
	{
%>
		<br><br><br><br><br>
		<TABLE width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th>No RFQs Quoted to List</th>
		</Tr>
		</Table>
		<br>
		<Center>
    <%
        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
        butActions.add("history.go(-1)");
        out.println(getButtons(butNames,butActions));
    %>
</Center>
<%
	}
	else
	{
%>	
	<br><br>	
	<DIV id="theads">
	<Table id="tabHead" width="70%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<Tr align="center" valign="middle">
		<Th width="10%">&nbsp;</Th>
		<Th width="45%">RFQ No</Th>
	 	<Th width="45%">Vendor</Th>
	 </Tr>
	</Table>
	</DIV>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	for(int i=0;i<rowCount;i++)
	{
%>
		<Tr>
			<Td width="10%"><Input type=checkbox name=chk1 value="<%=ret.getFieldValueString(i,"RFQ_NO")%>¥<%=ret.getFieldValueString(i,"SOLD_TO")%>¥<%=collRfq%>"></Td>
			<Td width="45%"><%=ret.getFieldValueString(i,"RFQ_NO")%></Td>
			<Td width="45%"><%=ret.getFieldValueString(i,"SOLD_TO_NAME")%></Td>
		</Tr>
<%
	}
%>
	</Table>
	</Div>

	<div id="ButtonsDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
	<Span id="EzButtonsSpan" >
        <%
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
          butNames.add("&nbsp;&nbsp;&nbsp;Requote&nbsp;&nbsp;&nbsp;");   
    
          butActions.add("history.go(-1)");
          butActions.add("reQuote()");
          out.println(getButtons(butNames,butActions));

        %>
	</Span>
 			 
 	<Span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
	</Span>			
	</div>
<%
	}

%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
