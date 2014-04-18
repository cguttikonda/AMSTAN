<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/iEzMain.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%@ page import="ezc.ezsynch.*" %>
<%

	String userId = request.getParameter("UserId");	
	String sector = "";
	if(request.getParameter("Sector") != null)
		sector = request.getParameter("Sector");
	String synchType = request.getParameter("synchtype");	
	String requestType = "";
	
	ezc.ezsfa.params.EziCustomerParams custParams = new ezc.ezsfa.params.EziCustomerParams();
	if("PS".equals(synchType))
		requestType = "PRODSYNCH";
	if("CS".equals(synchType))
	{
		requestType = "CUSTSYNCH";
		custParams.setDeletionFlag(sector);
	}	
		
	System.out.println("REQUEST TYPE :::>>> "+userId+":"+sector+":"+requestType);
	
	try
	{
		EzcSynchBlockParams synchBlock = new EzcSynchBlockParams();
		synchBlock.setUserId(userId);
		synchBlock.setMessageId(String.valueOf(System.currentTimeMillis()));
		synchBlock.setMessageType(requestType+"-REQUEST");
		synchBlock.setMessageStatus("T");
		if("CS".equals(synchType))
			synchBlock.setContainer(custParams);
		EzsSynchExecuteEngine see = new EzsSynchExecuteEngine();
		see.start(synchBlock);
	}
	catch(Exception e)
	{
		out.println("Exception In Actvities Post Patch == "+e);
	}
%>


<Html>
<Div id="HeaderDiv" align=center style="position:absolute;top:25%;width:100%">
<Table width=80% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  >
<Tr>
	<Td class="displayalert" align=center>
		Data being synchronized to the client.............
	</Td>
</Tr>
</Table>
</Div>

<Div id="ButtonDiv" align=center style="position:absolute;top:85%;width:100%">
<Table width=80% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  >
<Tr>
	<Td class="nolabelcell" align=center>
		<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=no  style="cursor:hand"></a>
	</Td>
</Tr>
</Table>
</Div>

</Html>