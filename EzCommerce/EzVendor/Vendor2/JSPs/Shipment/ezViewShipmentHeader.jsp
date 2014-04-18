<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iViewShipmentHeader_Labels.jsp"%>
<%@ page import = "ezc.ezcommon.*,java.util.*,java.util.*,ezc.ezparam.*,ezc.ezshipment.params.*,java.text.*" %>
<jsp:useBean id="shipManager" class="ezc.ezshipment.client.EzShipmentManager" />
<%@ include file="../../../Includes/JSPs/Shipment/iModeOfTransport.jsp" %>
<%@ include file="../../../Includes/JSPs/Shipment/iViewShipmentHeader.jsp" %>
<html>

<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="65%"
	function submitIt1()
	{
		if (document.myForm.base.options[document.myForm.base.selectedIndex].value=='' || document.myForm.base.options[0].value=='')
		{
			alert ('<%=plzSelPoNo_L%>');
			document.myForm.base.focus();
			return false;
		}
		else
		{
			document.myForm.showData.value='Y'
			if(document.myForm.orderType[0].checked && 'po'==document.myForm.orderType[0].value)
				document.myForm.orderBase.value = 'po';
									
			if(document.myForm.orderType[1].checked && 'con'==document.myForm.orderType[1].value)
				document.myForm.orderBase.value = 'con';
			
			
			document.myForm.ponum.value=document.myForm.base.options[document.myForm.base.selectedIndex].value
			document.myForm.action  = "ezViewShipmentHeader.jsp" ;
			document.myForm.submit()
		}
	}
function funDetails(ind,status)
{
	shid=''
	stat=''
	tempBase = ''
	
	if(document.myForm.orderBase.value =='')
		tempBase = '<%=orderBase%>';
	else
		tempBase = document.myForm.orderBase.value;
	
	if(isNaN(document.myForm.status.length))
	{
		stat = document.myForm.status.value;
		shid = document.myForm.shipid.value;
	}
	else
	{
		stat = document.myForm.status[ind].value;
		shid = document.myForm.shipid[ind].value;
	}
	if(status=='N')
	{
		document.myForm.action="ezShipmentDetails.jsp?ShipId="+shid+"&Status="+stat+"&ponum="+document.myForm.base.options[document.myForm.base.selectedIndex].value+"&orderBase="+tempBase;
		document.myForm.submit();
	}
	else if(status=='Y')
	{
		document.myForm.action="ezViewShipmentDetails.jsp?ShipId="+shid+"&Status="+stat+"&ponum="+document.myForm.base.options[document.myForm.base.selectedIndex].value+"&orderBase="+tempBase;
		document.myForm.submit();
	}
}	
function funSelect(){
	
	//alert(document.myForm.orderType[0].checked);
	if(document.myForm.orderType[0].checked && 'po'==document.myForm.orderType[0].value){
		document.myForm.orderBase.value = 'po';
		SendQuery('po');
		//document.myForm.submit();
	}
	if(document.myForm.orderType[1].checked && 'con'==document.myForm.orderType[1].value){
		document.myForm.orderBase.value = 'con';
		SendQuery('con');
		//document.myForm.submit();
	}
}
var req;	
function SendQuery(orderBase){
	try{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try{
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req = null;
		}
	}
	if(!req&&typeof XMLHttpRequest!="undefined"){
		req = new XMLHttpRequest();
	}
	var url="http://"+location.host+"/EZP/EzCommerce/EzVendor/Vendor2/JSPs/Shipment/ezViewSelShip.jsp?orderBase="+orderBase+"&noCache='"+((new Date()).valueOf())+"'";
	if(req!=null){
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	}
}
function Process(){
	if (req.readyState == 4)
	{
		var resText = req.responseText;	 	        	
		var resultText	= resText.split("¥");	
		if (req.status == 200)
		{
			if(resultText[0]=="")
				HideDiv("SP"+resultText[1]);
			else
			{
				for(slen=document.myForm.base.options.length-1;slen>0;slen--)
					document.myForm.base.options[slen]=null
				for(i=0;i<(resultText.length-2);i++)
				{
					document.myForm.base.options[i]=new Option(resultText[i+1],resultText[i+1])
					if('<%=ponum%>'== resultText[i+1])
					document.myForm.base.options[i].selected = true;
				}
				//alert(document.myForm.orderBase.value); 
				if(document.myForm.orderBase.value ==''){
					if('<%=orderBase%>'== 'po'){
						document.myForm.orderType[0].checked = true 
						document.myForm.orderType[0].value = 'po'
					}else if('<%=orderBase%>'== 'con'){
						document.myForm.orderType[1].checked = true 
						document.myForm.orderType[1].value = 'con'
					}
				}
				if(document.myForm.orderBase.value == 'po'  ){
				document.myForm.orderType[0].checked = true 
				document.myForm.orderType[0].value = 'po'
				}else if(document.myForm.orderBase.value == 'con'){
				document.myForm.orderType[1].checked = true 
				document.myForm.orderType[1].value = 'con'
				} 
			}
		}
		else
		{
			document.myForm.base.options[0]= new Option('No Orders to select','')

		}
	}
}



</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Shipment/ezViewShipmentHeader.js"></Script>
</head>
<%
	if("con".equals(orderBase))
		forPoNo_L = "For Schedule Agreement";
	String loadCalls="scrollInit()";
	if("Y".equals(showData)){
		loadCalls="scrollInit();SendQuery('"+orderBase+"')";
	}
%>

<body onLoad="<%=loadCalls%>" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type='hidden' name='orderBase' value=''>
<%	
	String fromPage = request.getParameter("FROM");
	int rowCount =0;
	if(rowCount >= 0)
	{
		String display_header = viewShip_L;
		String selected = "";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>

		<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:15%'>
		<Table width="40%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" cellpadding=1 cellspacing=1 class=welcomecell>
				<Tr>
					<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='45%' align=left>
						<Table align=center>
							<Tr align="center"><Td style="background-color:'F3F3F3'" align="left"><input type='radio' name='orderType' value='po' onclick='javascript:funSelect()' >&nbsp;<b><%=purOrder_L%></b></Td><Tr>
							<Tr align="center"><Td style="background-color:'F3F3F3'" align="left"><input type='radio' name='orderType' value='con'onclick='javascript:funSelect()' >&nbsp;<b>Schedule Agreement</b></Td><Tr>
						</Table>	
					</Td>
					<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='45%' align=right>
					<Select name="base" style="width:100%" id="ListBoxDiv1">
						<option value=''><%=select_L%></option>
<%
						/*
						for(int i=0;i<shipPOs.size();i++)
						{
							if(ponum.equals(shipPOs.get(i)))
								selected = "selected";       
							else
								selected = "";
							out.println("<option value='"+shipPOs.get(i)+"' "+selected+">"+shipPOs.get(i)+"</option>");
						}
						*/
%>
					</select>
					</Td>
					<Td style='background:#F3F3F3' align=center>
						<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" border="none" onClick="submitIt1()" onMouseover="window.status=' View  the Shipment '; return true" onMouseout="window.status=' '; return true">
					</Td>
				</TR>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>	
		<input type=hidden name="showData" >
		<input type="hidden" name="ponum">
<%		

		if("Y".equals(showData))
		{
			if (count > 0)
			{
%>		
			<br>
			<DIV id="theads">
			<TABLE id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<tr>
				<th width="15%"><%=invNo_L%></th>
				<th width="15%"><%=invDate_L%></th>
				<th width="15%"><%=shipDate_L%></th>
				<th width="20%"><%=modeOfTrans_L%></th>
				<th width="20%">Inbound Delivery</th>
				<th width="15%"><%=details_L%></th>
			</tr>
			</Table>
			</DIV>

			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
			<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			String modeTpt = "";
			for(int i=0;i< count;i++)
			{
				ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
				Date dcdate	= (Date)finalret.getFieldValue(i,"DC_DATE");
				Date invDate	= (Date)finalret.getFieldValue(i,"INV_DATE");
				Date shipDate	= (Date)finalret.getFieldValue(i,"SHIPMENT_DATE");
				String Status	= finalret.getFieldValueString(i,"STATUS");
				String invNo = "";
				if (finalret.getFieldValue(i,"INV_NUM")!=null && !finalret.getFieldValueString(i,"INV_NUM").equals(""))
					invNo = finalret.getFieldValueString(i,"INV_NUM");
				else	
					invNo = "&nbsp;";

				modeTpt = finalret.getFieldValueString(i,"DC_NR");
				if(modeHash.get(modeTpt) != null)
					modeTpt = (String)modeHash.get(modeTpt);
				else
					modeTpt = finalret.getFieldValueString(i,"DC_NR");				
					
					
					
%>
				<tr align="center">
				<td width="15%" align="left"><%=invNo%></td>
				<td width="15%" align="center"> <%=fd.getStringFromDate(invDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%> </td>
				<td width="15%" align="center"> <%=fd.getStringFromDate(shipDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%> </td>
				<td width="20%" align="left"><%=modeTpt%></td>
				<td width="20%" align="center"><%=finalret.getFieldValueString(i,"EXT1")%>&nbsp;</td>
				<td width="15%" align="center">
					<input type="hidden" name="status" value="<%=finalret.getFieldValueString(i,"STATUS")%>" >
					<input type="hidden" name="shipid" value="<%=finalret.getFieldValueString(i,"SH_ID")%>" >
					<a href="JavaScript:funDetails(<%=i%>,'<%=finalret.getFieldValueString(i,"STATUS")%>')"  onMouseover="window.status='Click to view the Shipment Details '; return true" onMouseout="window.status=' '; return true">click</a>
				</td>
				</tr>
<%
			}
%>
			</table>
			<br><br>
			</div>
			
<%
			}
			else
			{
				String noDataStatement = "<CENTER>"+forPoNo_L+" : ";
				noDataStatement += ponum+"<BR><BR>"+noShipInfo_L+" "+(String)session.getValue("Vendor")+"</CENTER>";
%>
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
			}
		}
		else
		{
			if("MENU".equals(fromPage))
			{
				String noDataStatement = "Please select the Purchase Order / Schedule Agreement to view the Shipment";
%>
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
				<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
				<Center>
<%
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					buttonName.add("Back");
					buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
					out.println(getButtonStr(buttonName,buttonMethod));	
%>
				</Center>
				</Div>	
<%			
			}
		}		
	}
	else
	{
		String noDataStatement = noShipInfo_L+" "+(String)session.getValue("Vendor")+".";
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
%>


<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	
	buttonName.add("Back");
	if("Y".equals(backFlg))
	{
		buttonMethod.add("history.go(-1)");
	}	
	else
	{
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	}	
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>	









</form>
<Div id="MenuSol"></Div>
</body>
</html>