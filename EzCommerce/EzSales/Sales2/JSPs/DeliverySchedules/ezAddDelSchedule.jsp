<%@ include file="../../Library/Globals/ezCacheControl.jsp" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iAddDeliverySchedule.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddDelSchedule_Lables.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="40%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	function pageSubmit()
	{
		if((document.forms[0].lrRrAirNo.value=='') ||(document.forms[0].shipDate.value=='')||(document.forms[0].carName.value=='')||(document.forms[0].arrDate.value==''))
		{
			alert("<%=plzEnterAlert_A%>");
		}else{
		    if(chkDate()){
				//document.body.style.cursor="wait"
			      document.ADSForm.action="ezAddSaveDelSchedule.jsp"
			      //alert("This dispatch will be Acknowdleged");
				document.ADSForm.submit();
                }
		}
	}
	function chkDate()
	{
		var shdate=document.forms[0].shipDate.value
		var ardate=document.forms[0].arrDate.value
		var dd=parseInt(shdate.substring(0,2));
		var mm=parseInt(shdate.substring(3,5));
		var yy=shdate.substring(6,shdate.length);
		var sDate=new Date(yy,mm,dd);
		dd=parseInt(ardate.substring(0,2));
		mm=parseInt(ardate.substring(3,5));
		yy=ardate.substring(6,shdate.length);
		var aDate=new Date(yy,mm,dd);
		if(sDate < aDate){
		    return true
		}else{
		    alert("Exp.Delivary Date should be more then Shipment Date")
		    return false
		}
	}
	function showSpan(spid)
	{
		obj=document.getElementById("SP"+spid);
		if (obj!=null){
			if(obj.style.display=="none")
				obj.style.display="block";
			else if(obj.style.display=="block")
				obj.style.display="none";
		}
	}
	function goBack()
	{
		document.body.style.cursor="wait"
		document.ADSForm.action="ezGetDeliveryNos.jsp"
		document.ADSForm.submit();
	}
</script>
</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form  method="post" name="ADSForm" onSubmit="return false" onLoad="adjustWidth()">
<input type="hidden" name="base" value="SalesOrder">
<input type="hidden" name="SalesOrder" value="<%=soNum%>|<%=poNum%>|<%=soDate%>">
<input type="hidden" name="status">
<input type="hidden" name="sendMail">
<%
	String display_header = disDet_L+delNo; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<table  width="95%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%

	for (int z=0;z<delivHeadCount;z++)
	{
		String sap_delno=delivHead.getFieldValueString(z,"DelivNumb");

		if (sap_delno.equals(delNo))
		{

		%>
		<tr>
		<!--	<th align="left" width="20%"><%=soNo_L%>:</th> -->
			<th align="left" width="20%">Sample Order No</th>
			<td width="20%"><% try{out.println(Integer.parseInt(soNum));}catch(Exception e){out.println(soNum);}%>
			<input type="hidden" name="soNo" value="<%=soNum%>">
			<input type="hidden" name="poNo" value="<%=poNum%>">
			<input type="hidden" name="delvNo" value="<%=sap_delno%>">
			</td>
		<!--	<th width="20%" align="left"><%=soDate_L%>:</th>  -->
			<th width="20%" align="left">Order Date</th>
			<td width="20%"><input type="hidden" name="sDate" value="<%=soDate%>"><%=soDate%></td>
		</tr>
		<tr>
			<th align="left"  width="20%"><%=dcNo_L%></th>
			<td width="20%"><input type="hidden" name="dcNo" value="<%=delivHead.getFieldValueString(z,"DelivNumb")%>"><%=delivHead.getFieldValueString(z,"DelivNumb")%>&nbsp;</td>
			<th align="left"  width="20%"><%=dcDate_L%></th>
			<td width="20%">
			<% Date dcDate = new Date();%>
			<input type="hidden" name="dcDate"  value="<%=fd.getStringFromDate((Date)delivHead.getFieldValue(z,"DelivDate"),".",fd.DDMMYYYY)%>" >
			<%
				String DelivDate = fd.getStringFromDate((Date)delivHead.getFieldValue(z,"DelivDate"),".",fd.DDMMYYYY);
				if(DelivDate.length() ==10)
					out.println(DelivDate);
				else
					out.println("&nbsp;");
			%>
			</td>
		</tr>
		<tr>
			<th align="left"  width="20%"><%= lrNo_L%></th>
			<td  width="20%"><input type="text" class=InputBox size=15  maxlength=30 name="lrRrAirNo" value="<%=delivHead.getFieldValueString(z,"Ext1")%>"></td>
			<th align="left"  width="20%"><%=ShipDate_L%></th>
			<td  width="20%">
			<input type=text name="shipDate" class=InputBox value=""  size=12 maxlength="10" readonly><%=getDateImage("shipDate")%>
			</td>
		</tr>
		<tr>
			<th align="left"  width="20%"><%=caName_L%></th>
			<td  width="20%"><input type="text"  class=InputBox name="carName"  size=15  maxlength=50 value="<%=delivHead.getFieldValueString(z,"Ext2")%>"></td>
			<th align="left"  width="20%"><%=exAvaDate_L%></th>
			<td  width="20%">
			<input type="hidden" name="soldTo" value="<%=delivHead.getFieldValue(z,"SoldToParty")%>">
			<input type="hidden" name="shipTo" value="<%=delivHead.getFieldValue(z,"ShipToParty")%>">
			<input type=text name="arrDate" class=InputBox value=""  size=12 maxlength="10" readonly><%=getDateImage("arrDate")%>
			</td>
		</tr>
		<tr>
			<th align="left"  width="20%"><%=remark_L%></th>
			<td width="60%" colspan=3>
			<TextArea style="overflow:auto" class=txarea name="HeadText" rows=1 cols=58></TextArea>
			</td>
		</tr>
	<%}
	}
%>
	</table>
	<Div id="theads">
	<table  width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="10%"><%=lineNo_L %></th>
		<th width="18%"><%=batNo_L%></th>
		<th width="35%"><%=proddesc_L%></th>
		<th width="5%"><%=uom_L%></th>
		<th width="12%"><%=qty_L%></th>
	</tr></table>
	</Div>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:40%;left:2%">
	<Table align=center  id="InnerBox1Tab"  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 width="100%">
<%
	String line=null;
	String batch=null;
	String matNo=null;
	String matDesc=null;
	String UOM=null;
	String QTY=null;
	String Ext1=null;
	String Ext2=null;
	String Plant=null;
	int spanCount=0;

	for (int i=0;i<delivTableCount;i++)
	{
		line=delivTable.getFieldValueString(i,"DelivItem");
		matNo=delivTable.getFieldValueString(i,"Material");
		matDesc=delivTable.getFieldValueString(i,"ShortText");
		UOM=delivTable.getFieldValueString(i,"SalesUnit");
		QTY=delivTable.getFieldValueString(i,"DlvqtySalesUnt");
		batch=delivTable.getFieldValueString(i,"Batch");
		Ext1=delivTable.getFieldValueString(i,"Ext1");
		Ext2=delivTable.getFieldValueString(i,"Ext2");
		Plant=delivTable.getFieldValueString(i,"Plant");
		if ("Multiple Batchs".equals(Ext2))
		{%>
			<Tr><Td>
			<span>
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<td width='10%'>&nbsp;<input type=hidden name=Line_<%=i%> value="<%=line%>"><%=line%></td>
				<td width='18%'>
				<input type=hidden name=Material_<%=i%> value="<%=matNo%>">
				<input type=hidden name=Batch_<%=i%> value="<%=batch%>">
				<input type=hidden name=EXT_<%=i%> value="MultiBatch">
				<input type="hidden" name="Plant_<%=i%>" value="<%=Plant%>">
				<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
				<a href='JavaScript:showSpan("<%=spanCount%>")'><%=multiBat_L%></a>
				</td>
				<td width='35%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=matDesc%>"><%=matDesc%></td>
				<td width='5%'><input type=hidden name="UOM_<%=i%>" value="<%=UOM%>"><%=UOM%></td>
				<td width='12%'  align='right'><input type=hidden name="QTY_<%=i%>" value="<%=QTY%>"><%=QTY%></td>
			</Tr>
			</Table>
			</span>
			<span id="SP<%=spanCount%>"  style="display:none">
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<%for (int j=i+1;j<delivTableCount;j++)
			{
				try{
				if (Integer.parseInt(line)==Integer.parseInt(delivTable.getFieldValueString(j,"Ext2")))
				{	i++;
				%>
				<tr>
					<td width='10%'>&nbsp;<input type=hidden name=Line_<%=i%> value="<%=delivTable.getFieldValueString(j,"DelivItem")%>"></td>
					<td width='18%'>
					<input type=hidden name=Material_<%=i%> value="<%=delivTable.getFieldValueString(j,"Material")%>">
					<input type=hidden name=Batch_<%=i%> value="<%=delivTable.getFieldValueString(j,"Batch")%>">
					<input type=hidden name=EXT_<%=i%> value="<%=delivTable.getFieldValueString(j,"Ext2")%>">
					<input type="hidden" name="Plant_<%=i%>" value="<%=delivTable.getFieldValueString(j,"Plant")%>">
					<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
					<%=delivTable.getFieldValueString(j,"Batch")%>
					</td>
					<td width='35%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=delivTable.getFieldValueString(j,"ShortText")%>">&nbsp;<%=delivTable.getFieldValueString(j,"ShortText")%></td>
					<td width='5%'><input type=hidden name="UOM_<%=i%>" value="<%=delivTable.getFieldValueString(j,"SalesUnit")%>">&nbsp;<%=delivTable.getFieldValueString(j,"SalesUnit")%></td>
					<td width='12%' align='right'><input type=hidden name="QTY_<%=i%>" value="<%=delivTable.getFieldValueString(j,"DlvqtySalesUnt")%>">&nbsp;<%=delivTable.getFieldValueString(j,"DlvqtySalesUnt")%></td>
				</tr>
				<%
				}
				}catch(Exception e)
				{
					System.out.println("An Exception Occured :"+e);
					break;
				}
				if ("Multiple Batchs".equals(delivTable.getFieldValueString(j+1,"Ext2")))
				{
					break;
				}
			}%>
			</Table>
			</span>
			</Td></Tr>
		<%	spanCount++;
		}
		else
		{%>
			<Tr><Td>
			<span>
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<td width='10%'><input type=hidden name=Line_<%=i%> value="<%=line%>">&nbsp;<%=line%></td>
				<td width='18%'>&nbsp;
				<input type=hidden name=Material_<%=i%> value="<%=matNo%>">
				<input type=hidden name=Batch_<%=i%> value="<%=batch%>">
				<input type=hidden name=EXT_<%=i%> value="<%=Ext2%>">
				<input type="hidden" name="Plant_<%=i%>" value="<%=Plant%>">
				<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
				<%=batch%>
				</td>
				<td width='35%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=matDesc%>">&nbsp;<%=matDesc%></td>
				<td width='5%'><input type=hidden name="UOM_<%=i%>" value="<%=UOM%>">&nbsp;<%=UOM%></td>
				<td width='12%'  align='right'><input type=hidden name="QTY_<%=i%>" value="<%=QTY%>">&nbsp;<%=QTY%></td>
			</Tr>
			</Table>
			</span>
			</Td></Tr>
		<%}
	}%>
	</Table>
	</Div>
	<input type="hidden" name="totLines" value="<%=delivTable.getRowCount()%>">
	<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Save");
		buttonMethod.add("pageSubmit()");
		buttonName.add("Back");
		buttonMethod.add("goBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</div>
	
	
	<input type="hidden" name="onceSubmit" value=0>
	</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
