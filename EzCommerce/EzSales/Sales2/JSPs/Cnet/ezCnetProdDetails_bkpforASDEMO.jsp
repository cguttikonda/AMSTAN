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
<script>
		  var tabHeadWidth=95
 	   	  var tabHeight="70%"

</script> 
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body onLoad="scrollInit();" onresize="scrollInit()" scroll=no>
<form name="myForm">

<%

	String noDataStatement ="No details present";  
	if(retDetCnt>0)
	{
%>
	<BR>
	<Div id='theads'>
	<Table  width="95%" id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr align="center" valign="middle">
	<Th width="100%" colspan=2 style="text-align:left">Product Specifications</Th>
	</Tr>
	</Table>
	</div>

	<DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:95%;height:70%'>
	<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
	<Th style="width:100%;text-align:left" colspan=3>Main Specs</Td>
	</Tr>
<%
		String wid="",cs="";
		for(int i=0;i<retDetCnt;i++)
		{
			String headerText = retDet.getFieldValueString(i,"HeaderText");
			String bodyText = retDet.getFieldValueString(i,"BodyText");
			if(i>3)
			{
				wid="60";
				cs="colspan=2";
			}
			else
				wid="40";
%>

			<!--<img src="<%=imagePath%>">-->
			<Tr>
			<Td style="width:20%;height:50;text-align:left"><b><%=headerText%></b></Td>
			<Td style="width:<%=wid%>%;height:50;text-align:left" <%=cs%>><%=bodyText%></Td>
<%
			if(i==0)
			{
%>
			<Td style="width:40%;height:50;text-align:left" rowspan=4><img src="<%=imagePath%>"></Td>
<%
			}
%>
			</Tr>
<%
		}
		if(retDetCnt<4)
		{
			for(int k=0;k<4-retDetCnt;k++)
			{
%>
				<Tr>
				<Td style="width:20%;height:50;text-align:left">&nbsp;</Td>
				<Td style="width:40%;height:50;text-align:left">&nbsp;</Td>
				</Tr>
<%
			}
		}
		if(retExtCnt>0)
		{
%>
			<Tr>
			<Th style="width:100%;text-align:left" colspan=3>Extended Specs</Td>
			</Tr>
<%
			for(int k=0;k<retExtCnt;k++)
			{
%>

				<Tr>
				<Td style="width:20%;height:50;text-align:left"><b><%=retExt.getFieldValueString(k,"SectText")%>/<%=retExt.getFieldValueString(k,"HeaderText")%></b></Td>
				<Td style="width:60%;height:50;text-align:left" colspan=2><%=retExt.getFieldValueString(k,"BodyText")%>&nbsp;</Td>
				</Tr>
<%
			}
		}
%>

	</Table>
	</Div>
<%
	}
	else
	{
%>


	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 


<%
	}
%>

	


<br>	
	
   <DIV style='overflow:auto;position:absolute;top:90%;left:42%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  </div>   

</form>
</body>
</html>