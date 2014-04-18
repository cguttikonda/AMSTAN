<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListRejectedMaterials_Labels.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<% 
	String header 		= "&nbsp;,"+RejMatno_L+","+RejMatDesc_L+","+RejMatGrno_L+","+RejMatQty_L+","+RejMatValue_L+","+RejMatPono_L+","+RejReason_L; 
	String display_header	= statRejMat_L;
	String noDataStatement  = forVendor_L+session.getValue("Vendor")+noRejMat_L;
%>
<Script>
	var radioData = ""
	function doOnCheck(rowId,cellInd,state)
	{
		radioData = rowId;		
	}

	function doOnLoad()
	{
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader('<%=header%>')
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("5,12,29,11,8,15,10,10")
		mygrid.setColAlign("center,left,left,left,right,right,left,center")
		mygrid.setColTypes("ra,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("str,str,str,str,int,int,str,str")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.setOnCheckHandler(doOnCheck);
		mygrid.init();
		mygrid.loadXML("ezListRejectedMaterialsGrid.jsp");
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	

	function openWindow(arguments)
	{
	    newWindow = window.showModalDialog("ezViewRemarks.jsp",arguments,"center=yes;dialogHeight=20;dialogleft=200;dialogTop=200;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
	}
	function funSubmit()
	{
		if(radioData != null && radioData != "")
		{
			document.myForm.chk1.value=radioData
			document.myForm.action="../Purorder/ezComposeRejectMsg.jsp";
			var url = "../Purorder/ezSelectUsers.jsp";
			var hWnd = window.open(url,"UserWindow","width=300,height=300,resizable=yes,scrollbars=yes");
			if ((document.window != null) && (!hWnd.opener))
				hWnd.opener = document.window;
		}
		else
		{
			alert("Please select atleast 1 material to send your response")	
		}
	}
</script>
</head>
<body onLoad="doOnLoad();" scroll=no>
<form name="myForm" method="post">
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%@ include file="../Misc/ezDisplayGrid.jsp" %>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	
	buttonName.add("Respond");
	buttonMethod.add("funSubmit()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
		
<input type="hidden" name="toUser" value="">
<input type="hidden" name="flag" value="">
<input type="hidden" name="chk1" value="">
</form>
<%@ include file="../Misc/backButton.jsp" %>
<Div id="MenuSol"></Div>
</body>
</html>
