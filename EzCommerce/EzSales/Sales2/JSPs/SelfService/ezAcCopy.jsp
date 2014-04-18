<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iAcCopy_Lables.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%//@ include file="../../../Includes/JSPs/SelfService/iAcCopy.jsp"%>
<%
String forkey 	= (String)session.getValue("formatKey");
String fd = request.getParameter("FromDate");
String td = request.getParameter("ToDate");
String lineCount = request.getParameter("lineCount");

String browser = (String)session.getValue("BROWSER");
String allignLeft="2%";
if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser))) 
	allignLeft="40%"; 

ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

if(fd == null || td == null || "null".equals(fd) || "null".equals(td))
{
	td = formatDate.getStringFromDate(new Date(),forkey,ezc.ezutil.FormatDate.MMDDYYYY);
	if(cMonth>2)
		fd = formatDate.getStringFromDate(new Date(cYear-1900,03,01),forkey,ezc.ezutil.FormatDate.MMDDYYYY);
	else	
		fd = formatDate.getStringFromDate(new Date(cYear-1901,03,01),forkey,ezc.ezutil.FormatDate.MMDDYYYY);
}
%>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	
	<!--
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	-->
	
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxcommon.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgrid.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgridcell.js"></Script>	

	<script language="javascript">
	function formSubmit()
	{
		y = chkDates();
		if(eval(y)){
			document.myForm.submit();
		}
	}
	function gotoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
	function chkDates()
	{
		fd = document.myForm.FromDate.value;
		td = document.myForm.ToDate.value;

		if(fd=="")
		{
			alert("Please Select From Date");
			return false;
		}
		else if(td=="")
		{
			alert("Please Select To Date");
			return false;
		}


		a=fd.split('<%=forkey%>');
		b=td.split('<%=forkey%>');
		fd1=new Date(a[2],a[0]-1,a[1])
		td1=new Date(b[2],b[0]-1,b[1])
		if(fd1 > td1)
		{
			alert("<%=fromLessTo_A%>");
			document.myForm.FromDate.focus();
			return false;
		}
		return true;
	}

	function doOnLoad()
	{
		var fd = document.myForm.FromDate.value;
		var td = document.myForm.ToDate.value;
		
		/*
		mygrid = new dhtmlXGridObject('gridbox');			
		mygrid.imgURL = "../../Images/Grid/";	
		mygrid.setHeader("<%=transDate_L%>,<%=particulars_L%>,<%=docNo_L%>,<%=debit_L%>,<%=credit_L%>,<%=bal_L%>[USD]");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("16,17,16,17,17,17")
		mygrid.setColAlign("center,left,right,right,right,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("date,str,int,int,int,int")
		mygrid.setColumnColor(",,,,,#D5F1FF")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(250);
		mygrid.init();
		mygrid.loadXML("ezAcCopyDetails.jsp?FromDate="+fd+"&ToDate="+td);
		*/
		
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.setImagePath("../../Images/Grid_2.5BA/");
		mygrid.setHeader("Transaction Date,<%=particulars_L%>,<%=docNo_L%>,<%=debit_L%>,<%=credit_L%>,<%=bal_L%>[USD]");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("16,17,16,17,17,17")
		mygrid.setColAlign("center,left,right,right,right,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("date,str,int,int,int,int")
		//mygrid.setColumnColor(",#D5F1FF,,,,")
		mygrid.setStyle('background-Color:#227A7A;font-weight:600;',"","","")
		mygrid.setSkin("dhx_skyblue");
		//mygrid.enableBuffering(250);
		mygrid.init();
		mygrid.loadXML("ezAcCopyDetails.jsp?FromDate="+fd+"&ToDate="+td);
	}
	function doOnUnLoad()
	{
		if (mygrid) 
			mygrid=mygrid.destructor();
	}
	
</script> 
<body onLoad="doOnLoad()" onUnLoad="doOnUnLoad()" scroll=no>
<form  method="post" name="myForm"  action="ezAcCopy.jsp">
<input type="hidden" name="checkBrow" value="">
<%
	String display_header = "Statement of A/C as in Account Books";
	String noDataStatement= "No entries in A/C Book";


%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<Div id='inputDiv' style='position:relative;align:center;width:100%;'>
<Table width="50%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>

	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>

		 <Table align="center" border="0" valign=middle width="100%" cellPadding=0 cellSpacing=0 >
		 <Tr align="center">
			<Th><%=fromDate_L%></Th>
			<Td>
				<input type=text name="FromDate" id="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%>
			</Td>
			<Th><%=toDate_L%></Th>
			<Td>
				<input type=text name="ToDate" id="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%>
			</Td>
			<Td>
<%

				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();

				buttonName.add("Go");
				buttonMethod.add("formSubmit()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>

			</Td>
		</Tr>
		</Table>
		</td>
	
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
</Table>
</Div>		

<%@ include file="../Misc/ezDisplayGrid.jsp"%>

<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	//buttonName.add("Back");
	//buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>