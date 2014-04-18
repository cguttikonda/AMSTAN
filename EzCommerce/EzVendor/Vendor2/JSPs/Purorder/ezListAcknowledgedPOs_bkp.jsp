<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListAcknowledgedPO_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iListPOHash.jsp" %>
<%
		String userType	 = (String) session.getValue("UserType");
		String orderType = request.getParameter("type");
		String show = request.getParameter("SHOW");
		String userRole	= (String) session.getValue("USERROLE");
		String header  = "";
		String widths  = "";
		String colTyps = "";
		String aligns  = "";
		String colSort = "";
		
		
		String selAllChk = "<input style='cursor:hand' type=checkbox name=checkAll onclick='selectCheckAll()'  alt='Select/Deselect All'>";
		
		if(orderType.equals("NotAcknowledged"))
		{ 
			if("PH".equals(userRole) && "ALL".equals(show) )
			{
				header  = selAllChk+","+poNum_L+",Pur. Group,Comp.Code,Created on,Ship. Date,"+vend_L;
				widths  = "10,20,11,11,16,16,16";
				aligns  = "center,center,center,center,center,center,center";
				colTyps = "ro,ro,ro,ro,ro,ro,ro";
				colSort = "str,str,str,str,date,str,str";
			}	
			else
			{
				header  = selAllChk+","+poNum_L+",Created on,Ship. Date,"+vend_L;
				widths  = "10,25,25,25,15";
				aligns  = "center,center,center,center,center";
				colTyps = "ro,ro,ro,ro,ro";
				colSort = "str,str,date,str,str";
			}	
		}
		if(orderType.equals("Acknowledged"))
		{ 
			header  = poNum_L+",Created on,Ship. Date,"+ackDat_L;
			widths  = "25,25,25,25";
			aligns  = "center,center,center,center";
			colTyps = "ro,ro,ro,ro";
			colSort = "str,date,str,date";
		}
		if(orderType.equals("Rejected"))
		{ 
			header  = selAllChk+","+poNum_L+",Created on,Ship. Date,"+rejRea_L;
			widths  = "10,25,25,25,15";
			aligns  = "center,center,center,center,center";
			colTyps = "ro,ro,ro,ro,ro";
			colSort = "str,str,date,str,str";
		}
%>
<html>
<head>    
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
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
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezAcknowledgedPosGrid.jsp?type=<%=orderType%>&SHOW=<%=show%>"); 
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>


<script>
var selPO_L 		= '<%=selPO_L%>';
var selBlockPO_L 	= '<%=selBlockPO_L%>';
function funShowReason(arguments)
{
    newWindow = window.showModalDialog("ezShowRejectedPOReasons.jsp",arguments,"center=yes;dialogHeight=26;dialogleft=100;dialogTop=120;dialogWidth=50;help=no;titlebar=no;status=no;resizable=no")
}
function checkVal(stat)
{
	var selectedLength = 0
	var checkObj = document.myForm.chk1
	var reqData = "";
	if(checkObj != null)
	{
		var checkLength = checkObj.length;
		var reqData = "";
		if(isNaN(checkLength))
		{
			if(document.myForm.chk1.checked)
			{
				reqData = document.myForm.chk1.value;
				selectedLength++;
			}	
		}
		else
		{
			for(i=0;i<checkLength;i++)
			{
				if(document.myForm.chk1[i].checked)
				{
					reqData += document.myForm.chk1[i].value+"µ";
					selectedLength++;
				}	
			}
		}	
	}

	if(selectedLength == 0)
	{
		if(stat=='NA')
			alert(selPO_L);
		else
			alert(selBlockPO_L);
	}
	else
	{
		document.myForm.poData.value = reqData;
		if(stat=='NA')
			document.myForm.action="ezSendReminders.jsp";
		else if(stat=='REL')
			document.myForm.action="ezReleasePurchaseOrder.jsp";
		else
			document.myForm.action="ezReleaseOrders.jsp";
		setMessageVisible();
		document.myForm.submit();	
	}
	
	
}

</script>

</head>

<body onLoad="doOnLoad();" scroll=no>
<form name="myForm">
<input type="hidden" name ="chkbox">
<input type="hidden" name=selAllImg value="0">
<%
	String display_header	= (String)hashReqStmt.get(orderType);
	String noDataStatement	= (String)hashReqType.get(orderType);
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<%@ include file="../Misc/ezDisplayGrid.jsp" %>		
		
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

	if(orderType.equals("NotAcknowledged"))
	{
		if(!userType.equals("3"))
		{
			buttonName.add("Send Reminder");
			buttonMethod.add("checkVal(\"NA\")");
		}
		else
		{
			buttonName.add("Acknowledge");
			buttonMethod.add("checkVal(\"A\")");
		}
	}
	if(orderType.equals("Rejected") && !userType.equals("3"))
	{
		buttonName.add("Release");
		buttonMethod.add("checkVal(\"REL\")");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>
<input type=hidden name='poData'>
</form>

<Div id="MenuSol"></Div>
</body>
</html>
