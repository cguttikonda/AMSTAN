<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListAcknowledgedPO_Labels.jsp"%>
<%@page import="ezc.ezutil.*,java.util.*"%>

<%	
	String header  = "";
	String widths  = "";
	String colTyps = "";
	String aligns  = "";
	String colSort = "";
	
	header  = "Contract No,Order Date";
	widths  = "50,50";
	aligns  = "center,center";
	colTyps = "ro,ro";
	colSort = "str,date";

%>

<html>
<head>
<title>List of Blocked Purchase Orders in Portal</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>

<script>
 	var tabHeadWidth=80
 	var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script src="../../Library/JavaScript/Purorder/ezListBlockedPOs.js"></Script>
<script>

function getAgmtDtl(agmtNo)
{
	//var url="../RFQ/ezGetAgreementDetails.jsp?agmtNo="+agmtNo;
	//var sapWindow=window.open(url,"newwin","width=500,height=350,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	hideButton();
	document.myForm.action="../RFQ/ezGetAgrmtDetails.jsp?agmtNo="+agmtNo+"&viewType=VIEW";
	document.myForm.submit();
}
function ezBack()
{
	document.myForm.action = '../Misc/ezSBUWelcome.jsp'
	document.myForm.submit();
}
</script>
<Script>
	function doOnLoad()
	{
		
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader("<%=header%>");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("<%=widths%>")
		mygrid.setColAlign("<%=aligns%>")
		mygrid.setColTypes("<%=colTyps%>");
		mygrid.setColSorting("<%=colSort%>")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(100);
		mygrid.init();
		mygrid.loadXML("ezGetContractsListGrid.jsp"); 
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>
</head>
<%
	String vendorName = (String)session.getValue("Vendor");
	String display_header = "View Contracts For "+vendorName;
	String dispMsg = "No Contracts Exist For "+vendorName ;
	String noDataStatement	= "No Contracts Exist For "+vendorName ;
%>
<body bgcolor="#FFFFF7" onLoad="doOnLoad();scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')" scroll=no>
<form name="myForm" method="POST">
<%@ include file="../Misc/ezDisplayHeader.jsp"%> 
<%@ include file="../Misc/ezDisplayGrid.jsp" %>	
  
	<input type="hidden" name="fromPortal" value="FROMCONTRREL">
	<input type="hidden" name="POrCON" value="CONTRACT">
	
<Div align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<span id="EzButtonsSpan" >
</span>
		<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td >Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
</span>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>