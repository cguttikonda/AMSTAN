<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	String prodID = request.getParameter("prodID");
	String imagePath = request.getParameter("imagePath");
	int retDetCnt = 0,retExtCnt = 0;
	
	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	
	cnetParams.setStatus("GET_PRDDET_BOTHSPECS");
	cnetParams.setProdID(prodID);
	cnetParams.setQuery("");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	ReturnObjFromRetrieve retBoth = (ReturnObjFromRetrieve)CnetManager.ezGetCnetPrdDetailsByStatus(ezcpparams);	
	ReturnObjFromRetrieve retDet = (ReturnObjFromRetrieve)retBoth.getFieldValue(0,"MAIN");
	ReturnObjFromRetrieve retExt = (ReturnObjFromRetrieve)retBoth.getFieldValue(0,"EXTENDED");
	
	if(retDet!=null && retDet.getRowCount()>0)
		retDetCnt = retDet.getRowCount();
	if(retExt!=null && retExt.getRowCount()>0)
		retExtCnt = retExt.getRowCount();
		

		
	
%>
<html>
<head> <title>Product Details</title> 
 <style type="text/css">

      body { background-color: white; }

      #tabs {

        display: block;

        float: left;

        width: 100%;
        
        margin-left: 2px;

      }

      a.tab {

        border-collapse: collapse;

        border-style: solid solid none solid;

        border-color: black;

        border-width: 1px 1px 1px 1px;

        background-color: #227A7A;

        padding: 5px 1em 5px 1em;

        margin-top: 4px;

        margin-right: 2px;

        font-family: arial;

        text-decoration: none;

        float: left;

      }

      a.tab:hover {

        border-color: black;

        background-color: black;

      }
      a.tab:active {background-color: #0b305f}//488AC7

      .panel { border: solid 1px  #227A7A; background-color: #ffff; padding: 10px; height: 300px; overflow: auto;}

    

	#spacer
	{
	clear: both;
	padding: 0;
	width: 100%;
	height: 5px;
	background: #24618E;
	border-top: 1px solid #fff;
	margin-top: 2px ;
	border-bottom: 1px solid #fff;
	margin-bottom: 5px ;
	}   
</style>
<Script>
	function changeOption(option)
	{
		if(option =="A")
		{
			document.getElementById("div1").style.visibility = "visible";
			document.getElementById("div2").style.visibility = "hidden";
			document.getElementById("div3").style.visibility = "hidden";
			document.getElementById("div4").style.visibility = "hidden";
			document.getElementById("div5").style.visibility = "hidden";
		}
		if(option =="B")
		{
			document.getElementById("div1").style.visibility = "hidden";
			document.getElementById("div2").style.visibility = "visible";
			document.getElementById("div3").style.visibility = "hidden";
			document.getElementById("div4").style.visibility = "hidden";
			document.getElementById("div5").style.visibility = "hidden";
		}
		if(option =="C")
		{
			document.getElementById("div1").style.visibility = "hidden";
			document.getElementById("div2").style.visibility = "hidden";
			document.getElementById("div3").style.visibility = "visible";
			document.getElementById("div4").style.visibility = "hidden";
			document.getElementById("div5").style.visibility = "hidden";
		}
		if(option =="D")
				{
					document.getElementById("div1").style.visibility = "hidden";
					document.getElementById("div2").style.visibility = "hidden";
					document.getElementById("div3").style.visibility = "hidden";
					document.getElementById("div4").style.visibility = "visible";
					document.getElementById("div5").style.visibility = "hidden";
		}
		if(option =="E")
				{
					document.getElementById("div1").style.visibility = "hidden";
					document.getElementById("div2").style.visibility = "hidden";
					document.getElementById("div3").style.visibility = "hidden";
					document.getElementById("div4").style.visibility = "hidden";
					document.getElementById("div5").style.visibility = "visible";
		}
	}
</Script>
</head>
<body scroll=no>
<form name="myForm">
<%
	String noDataStatement ="No details present";  
	if(retDetCnt>0)
	{
%>
		<!--
		<Div id='theads'>
			<Table  width="100%" id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr align="left" valign="middle">
			<Th width="100%" colspan=2 style="text-align:left">Product Specifications</Th>
			</Tr>
			</Table>
		</div>
		-->
		
		<div id="tabs" style="position:absolute;top:2%;width:100%;">
		
			<a href="javascript:changeOption('A')" class="tab" title="Main specifications" ><span><B><font color="#ffffff"size="1px" face="Verdana">Main specifications</font></B></span></a>
			<a href="javascript:changeOption('B')"  class="tab" title="Extended specifications" ><span><B><font color="#ffffff" size="1px" face="Verdana">Extended specifications</font></B></span></a>
			<a href="javascript:changeOption('C')" class="tab"  title="Image" ><span><B><font color="#ffffff" size="1px" face="Verdana">Image</font></B></span></a>
			<a href="javascript:changeOption('D')" class="tab" title="Related Products" ><span><B><font color="#ffffff"size="1px" face="Verdana">Related Products</font></B></span></a>
			<a href="javascript:changeOption('E')" class="tab" title="Replacement Item" ><span><B><font color="#ffffff"size="1px" face="Verdana">Replacement Item</font></B></span></a>
		</div>
		<div id="spacer"><img src="../../Images/Buttons/CRI/spacer.gif" /></div>
<%
	}
	else
	{
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
<%
	}
%>
	<Div  id="div1" class="panel" style="visibility:visible;overflow:auto;position:absolute;height:80%;top:9%;width:100%;border:solid 1px #227A7A" >
	<br>
	<Table width='80%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Font color='#227A7A' size='2px'  face="Verdana"><b> Main Specs :</b></font>
<%
	for(int i=0;i<retDetCnt;i++)
	{
		String headerText = retDet.getFieldValueString(i,"HeaderText");
		String bodyText = retDet.getFieldValueString(i,"BodyText");
%>
		<Tr>
		<Td style="width:40%;height:40;text-align:left"><b><%=headerText%></b>&nbsp;</Td>
		<Td style="width:60%;height:40;text-align:left"><b><%=bodyText%></b>&nbsp;</Td>
		</Tr>
<%
	}
%>
	</Table>
	</Div>
	<Div  id="div2"  class="panel" style="visibility:hidden;overflow:auto;position:absolute;height:80%;top:9%;width:100%;border:solid 1px #227A7A">
	<br>
<%
	if(retExtCnt>0)
	{
%>
	<Table width='80%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Font color='#227A7A' size='2px'  face="Verdana"><b> Extended Specs :</b></font>
<%
		for(int k=0;k<retExtCnt;k++)
		{
%>
			<Tr>
			<Td style="width:40%;height:40;text-align:left"><b><%=retExt.getFieldValueString(k,"SectText")%>/<%=retExt.getFieldValueString(k,"HeaderText")%></b></Td>
			<Td style="width:60%;height:40;text-align:left"><b><%=retExt.getFieldValueString(k,"BodyText")%></b>&nbsp;</Td>
			</Tr>
<%
		}
%>
	</Table>
<%
	}
	else
	{
		noDataStatement ="No Extended Specifications for this Product";
%>
		<br><br><br><br>
		<Table width="60%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr height=100px>
			<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'ABCDCE';font-size:12px" valign=middle align=center>
				<b><%=noDataStatement%></b>
			</Td>
			<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		<%//@ include file="../Misc/ezDisplayNoData.jsp"%> 
<%
	}
%>
	</Div>
	<Div  id="div3" class="panel"  style="visibility:hidden;overflow:auto;position:absolute;height:80%;top:9%;width:100%;border:solid 1px #227A7A">
	<br>
	<Table width='80%' align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td style="width:100%;height:50;background-color:white;text-align:center"><img src="<%=imagePath%>"></Td>
	</Tr>
	</Table>
	</Div>
	<Div  id="div4" class="panel"  style="visibility:hidden;overflow:auto;position:absolute;height:80%;top:9%;width:100%;border:solid 1px #227A7A">
	<br><br><br>
		
<%
				noDataStatement ="No  Related Products";

%>
	<Table width="60%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
			<Tr>
				<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
				<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
				<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
			</Tr>
			<Tr height=100px>
				<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
				<Td style="background-color:'ABCDCE';font-size:12px" valign=middle align=center>
					<b><%=noDataStatement%></b>
				</Td>
				<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
			</Tr>
			<Tr>
				<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
				<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
				<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
			</Tr>
		</Table>
		
	</Div>
	<Div  id="div5" class="panel"  style="visibility:hidden;overflow:auto;position:absolute;height:80%;top:9%;width:100%;border:solid 1px #227A7A">
		<br><br><br>
		<%
						noDataStatement ="No Alternates/Replacements";
		
		%>
			<Table width="60%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
					<Tr>
						<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
						<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
						<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
					</Tr>
					<Tr height=100px>
						<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
						<Td style="background-color:'ABCDCE';font-size:12px" valign=middle align=center>
							<b><%=noDataStatement%></b>
						</Td>
						<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
					</Tr>
					<Tr>
						<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
						<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
						<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
					</Tr>
			</Table>
				

	</Div>
	<center>
	<DIV style='position:absolute;top:92%;align:center'>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Close");
		buttonMethod.add("window.close()");

		out.println(getButtonStr(buttonName,buttonMethod));	
%>
	</div>
	</center>
</form>
</body>
</html>