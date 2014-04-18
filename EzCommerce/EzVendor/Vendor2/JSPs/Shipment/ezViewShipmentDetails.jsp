<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iViewShipmentDetails_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Shipment/iModeOfTransport.jsp" %>
<%@  include file="../../../Includes/JSPs/Shipment/iViewShipmentDetails.jsp" %>
<%@ page import="ezc.ezutil.*,java.util.*,java.text.*" %>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=94
var tabHeight="18%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

	<script src="../../Library/JavaScript/ezTrim.js"></script>
	<script>
		
		
		var refdGtSdt_L = '<%=refdGtSdt_L%>'
		var invdGteSdt_L = '<%=invdGteSdt_L%>'
		var sdtGteOdt_L = '<%=sdtGteOdt_L%>'
		var arrdtGteSdt_L = '<%=arrdtGteSdt_L%>'
		var arrdtGteTdt_L = '<%=arrdtGteTdt_L%>'
		var refdLteSdt_L = '<%=refdLteSdt_L%>'
		var plzVldQty_L = '<%=plzVldQty_L%>'
		var plzQtyZero_L = '<%=plzQtyZero_L%>'
		var plzEnRdcno_L = '<%=plzEnRdcno_L%>'
		var plzEnRdcdt_L = '<%=plzEnRdcdt_L%>'
		var plzEnInvNo_L = '<%=plzEnInvNo_L%>'
		var plzEnInvdt_L = '<%=plzEnInvdt_L%>'
		var plzEnLrno_L = '<%=plzEnLrno_L%>'
		var plzShDate_L = '<%=plzShDate_L%>'
		var plzEnCrrn_L = '<%=plzEnCrrn_L%>'
		var plzExparrDt_L = '<%=plzExparrDt_L%>'
		var plzEnShdet_L = '<%=plzEnShdet_L%>'
		var plzEnShOneDet_L = '<%=plzEnShOneDet_L%>'
		var plzShLine_L = '<%=plzShLine_L%>'
		var plzAtlOneSh_L = '<%=plzAtlOneSh_L%>'
		var plsActDel_L = '<%=plsActDel_L%>'
		var thisDelBatch_L = '<%=thisDelBatch_L%>'
	
	
	</script>
	<script src="../../Library/JavaScript/ezShipValidations.js"></script>
<%
	String poDate="";
	String ss="";
	String orderDate="";
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	if (retHead.getRowCount () > 0){
			Date dd=new Date();
			ss=fd.getStringFromDate(dd,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			orderDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"PO_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	}
%>

<script>
	var totalbatches="";
	var attach="";
	function addBatches(index)
	{
		var args="";
		var lineNo="";
		var matdesc="";
		var Qtytobeship="";
		var batches="";
		var uom="";
		var sfiles="";
		var matcode="";
		//MaterialNr
		if(isNaN(document.myForm.UOM.length))
		{
			lineNo=document.myForm.Line.value;
			matdesc=document.myForm.matdesc.value;
			uom=document.myForm.UOM.value;
			matcode=document.myForm.MaterialNr.value;
			Qtytobeship=document.myForm.tobedelqty.value;
			displayQty=document.myForm.displayQty.value;
			sfiles=document.myForm.serverfiles.value;
			if(document.myForm.batches.value!="")
			{
				batches=escape(document.myForm.batches.value);
				args=lineNo+"@@@"+matdesc+"@@@"+uom+"@@@"+batches+"@@@"+matcode;
			}
			else
			{
				args=lineNo+"@@@"+matdesc+"@@@"+uom+"@@@"+matcode;
			}
		}
		else
		{
			lineNo=document.myForm.Line[index].value;
			sfiles=document.myForm.serverfiles[index].value;
			matdesc=document.myForm.matdesc[index].value;
			uom=document.myForm.UOM[index].value;
			matcode=document.myForm.MaterialNr[index].value;
			Qtytobeship=document.myForm.tobedelqty[index].value;
			displayQty=document.myForm.displayQty[index].value;
			if(document.myForm.batches[index].value!="")
			{
				batches=escape(document.myForm.batches[index].value);
				args=lineNo+"@@@"+matdesc+"@@@"+uom+"@@@"+batches+"@@@"+matcode;
			}
			else
			{
				args=lineNo+"@@@"+matdesc+"@@@"+uom+"@@@"+matcode;
			}
		}
		var dcno=document.myForm.DeliveryChallan.value;
		var dcdate=document.myForm.DCDate.value;
		if(dcno=="")
		{
			dcno="-";
		}
		if(dcdate=="")
		{
			dcdate="-";
		}
		if(isNaN(document.myForm.UOM.length))
		{
			coastr=dcno+"@@@"+document.myForm.matdesc.value+"@@@"+dcdate;
		}
		else
		{
			coastr=dcno+"@@@"+document.myForm.matdesc[index].value+"@@@"+dcdate;
		}
			var type=document.myForm.Type.value;
		specChrsStr = "#&";
		function spChar(strkey){
			var nLength=specChrsStr.length;
			for(nLoop=0;nLoop<nLength;nLoop++){
				pChar=specChrsStr.charAt(nLoop);
				if (strkey.indexOf(pChar)>0){
					strkey 	= strkey.replace(pChar,"¥");
				}
			}
			return 	strkey;	
		}	
		/*	
		if(args.indexOf("#") != -1)
		{
			args = args.replace("#","¥");
			coastr 	= coastr.replace("#","¥");
		}
		*/
		args 	= spChar(args);
		coastr 	= spChar(coastr);

		totalbatches= window.open("ezViewShipQty.jsp?args="+args+"&Qtytobeship="+Qtytobeship+"&index="+index+"&sfiles="+sfiles+"&rowCount=<%=retLinesCount%>&shipId=<%=shipid%>"+"&coastr="+coastr+"&displayQty="+displayQty+"&type="+type,"UserWindow","width=500,height=400,left=50,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
	}

	function openViewUploadWindow()
	{
		var filestring=document.myForm.shipuploads.value
		var serverfiles=document.myForm.shipserverfiles.value;
		attach=window.open("ezViewAttachmentFile.jsp?filestring="+filestring+"&serverfiles="+serverfiles,"UserWindow1","width=420,height=330,left=150,top=100,resizable=yes,scrollbars=no,toolbar=no,menubar=no");
	}
	function funPopup()
	{
		
		window.open("../Misc/ezPopup.jsp","UserWindow1","width=650,height=270,left=150,top=250,resizable=yes,scrollbars=no,toolbar=no,menubar=no");
	}
	function funUnLoad()
	{
		if(totalbatches!=null && totalbatches.open)
		{
			totalbatches.close();
		}
		if(attach!=null && attach.open)
		{
			attach.close();
		}
	}


</script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no onUnLoad="funUnLoad()">
<form name="myForm" method="post" onSubmit="return false">
<input type="hidden"  name="status">
<input type="hidden"  name="shipId" value="<%=shipid%>">
<input type=hidden name=sendMail value="No">
<input type="hidden" value="<%= ponum %>" name="baseValue">
<input type="hidden" value="<%= base %>" name="base">
<input type="hidden" value="<%= OrderValue %>" name="OrderValue">
<input type="hidden" value="<%= orderCurrency%>" name="orderCurrency">
<input type="hidden" value="<%= currency%>" name="currency">
<%
	int headCount=retHead.getRowCount();
	String modeTpt = "";
	if ( headCount > 0)
	{
		poDate  =fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"PO_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		modeTpt = retHead.getFieldValueString(0,"DC_NR");
		if(modeHash.get(modeTpt) != null)
			modeTpt = (String)modeHash.get(modeTpt);
		//else
		//modeTpt = "";
		String display_header ="";
		try{
	 		if("con".equals(orderBase))
	 		shipDetPono_L = "Shipment Details for Schedule Agreement";
	 		display_header = shipDetPono_L+" : "+Long.parseLong(ponum);
	 	}catch(Exception e3){ display_header = shipDetPono_L+" : "+(ponum); }
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<BR>
		<Table width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr valign="middle">
			<th align="left" width="25%"><%=modeOfTrans_L%></th>
			<td  align="left" width="25%" >
				<%=modeTpt%>
				<input type="hidden" name="DeliveryChallan" value='<%=modeTpt%>'>
			</td>
			<th align="left" width="25%"><%=dnoteDate_L%></th>
			<td  align="left" width="25%" >
<%
				String dcDate="";
				if (retHead.getFieldValue(0,"DC_DATE")!=null)
					dcDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"DC_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
					<%=dcDate%>
					<input type="hidden" name="DCDate" value="<%=dcDate%>">
			</td>
    		</tr>
		<tr>
		<th align="left" width="25%"><%=invNo_L%></th>
		<td width="25%">
<%
		String invNum="";
		if (retHead.getFieldValue(0,"INV_NUM")!=null)
			invNum=retHead.getFieldValueString(0,"INV_NUM");
%>
		<%=invNum%>&nbsp;
		</td>
		<th align="left" width="25%"><%=invDate_L%> </th>
		<td width="25%">
<%
		String invDate="";
		if (retHead.getFieldValue(0,"INV_DATE")!=null)
			invDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"INV_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		if(invDate.equals("01.01.1900"))
			invDate="";
%>
			<%=invDate%>&nbsp;
   		</td>
	</tr>
	<tr>
		<th align="left" width="25%"><%=llrBillNo_L%> </th>
		<td width="25%">
			<%=retHead.getFieldValue(0,"LR_RR_AIR_NR")%>
		</td>
		<th align="left" width="25%"><%=shipDate_L%></th>
		<td width="25%">
<%
		String shipDate="";
		if (retHead.getFieldValue(0,"SHIPMENT_DATE")!=null)
			shipDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"SHIPMENT_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
			<%=shipDate%>&nbsp;
    		</td>
	</tr>
    	<tr>
      		<th align="left" width="25%"><%=carrName_L%> </th>
		<td width="25%">
	      		<%=retHead.getFieldValue(0,"CARRIER")%>
		</td>
      		<th width="25%" align="left"><%=expArrDt_L%> </th>
      		<td width="25%">
<%
		String arrDate="";
		if (retHead.getFieldValue(0,"EXP_ARIVAL_TIME")!=null)
			arrDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"EXP_ARIVAL_TIME"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
		<%=arrDate%>
		</td>
	</tr>
	<Tr>
	      	<th align="left"width="25%">Inbound Delivery</th>
		<Td width="25%">
<%
		String ibd="";
		if (retHead.getFieldValue(0,"EXT1")!=null)
			ibd=retHead.getFieldValueString(0,"EXT1");
		out.println(ibd+"&nbsp;");
%>
		&nbsp;
		</Td>
		
	      	<th align="left"width="25%"><%=genText_L%> </th>
		<Td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;
<%
		String hText="";
		if (retHead.getFieldValue(0,"TEXT")!=null)
			hText=retHead.getFieldValueString(0,"TEXT");
		   //out.println(hText+"&nbsp;");
%>
		<a href="javascript:funPopup()"><img src="../../Images/Others/text.gif" border=0></a>
		<input type="hidden" name="genText" value="<%=hText%>">
		</Td>
		</Tr>
<%
} //End Of headCount If
%>
</Table>
<%
if (lineCount > 0)
{
%>
<DIV id="theads">
<TABLE id="tabHead" width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr>
          	<th align="center" width="12%"><%=line_L%></th>
<%	if("P".equals(doctype))
	{
%>		<th align="center" width="15%"><%=mat_L%></th>
          	<th align="center" width="38%"> <%=desc_L%></th>
          	<th align="center" width="8%"><%=ordQty_L%></th>
          	<th align="center" width="12%"><%=qty_L%></th>
<%	}
	else
	{
%>
		<th align="center" width="22%"><%=mat_L%></th>
		<th align="center" width="42%"> <%=desc_L%></th>
		<th align="center" width="12%"><%=ordQty_L%></th>
		<th align="center" width="12%"><%=qty_L%></th>
 <%
 	}
 %>


        </Tr>
</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:94%;height:18%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
String tempStr = "";
String serverfiles="";
ReturnObjFromRetrieve retfiles =null;
StringTokenizer stf=null;
double tobedelqty=0;
String lineNo="";
String matnum="";
String matDesc="";
String uomQty="";
String ToBeDelQty="";

///ezc.ezcommon.EzLog4j.log("MY CHK VALUE"+retLines.toEzcString(),"I");
for (int i = 0; i < lineCount ; i ++ )
{
	
	lineNo=(String)retLines.getFieldValueString(i,"LINE_NR");
	matnum=(String)retLines.getFieldValueString(i,"MAT_NR");
	matDesc=(String)retLines.getFieldValueString(i,"MAT_DESC");
	uomQty=(String)retLines.getFieldValueString(i,"TOTAL_QTY");
	try{
		retfiles=(ReturnObjFromRetrieve)UploadLines.get(shipid+lineNo);
	}catch(Exception e){
	retfiles = null;
	}
	int SCount = retSchd.getRowCount() ;
	for(int j=0;j< SCount ;j++)
	{
		String stempfiles="NA";
		if(lineNo.equals(retSchd.getFieldValueString(j,"LINE_NR")))
		{
			String schNo = retSchd.getFieldValueString(j,"SCHD_LINE");
			String mfgDate ="NA";
			if (retSchd.getFieldValue(j,"MFG_DATE")!=null)
			mfgDate=FormatDate.getStringFromDate((Date) retSchd.getFieldValue(j,"MFG_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			String expDate ="NA";
			if (retSchd.getFieldValue(j,"EXP_DATE")!=null)
			expDate =FormatDate.getStringFromDate((Date) retSchd.getFieldValue(j,"EXP_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			String batch ="NA";
			if (retSchd.getFieldValue(j,"BATCH")!=null && !retSchd.getFieldValue(j,"BATCH").equals(""))
			batch =retSchd.getFieldValueString(j,"BATCH");
			String UfileName="NA";
			if (retfiles!=null)
			{
				int fcount = retfiles.getRowCount();
				for (int k=0; k< fcount; k++)
				{
					if (schNo.equals(retfiles.getFieldValueString(k,"TYPE")))
					{
						UfileName = retfiles.getFieldValueString(k,"CLIENTFILENAME");
						stempfiles= retfiles.getFieldValueString(k,"SERVERFILENAME");
						break;
					}
				}
			}
			tempStr = tempStr+batch+"$$$"+mfgDate+"$$$"+expDate+"$$$"+getNumberFormat(retSchd.getFieldValueString(j,"BATCH_QTY"),0)+"$$$"+UfileName+"!!!";
			serverfiles =serverfiles+stempfiles+"!!!";
		}
	}

%>
		<Tr>
			<td width="12%"><input type="hidden" name="Line" value="<%=lineNo%>"><%=lineNo%>
			</td>
<%
if(matnum==null || "".equals(matnum) || "null".equals(matnum))
{
	matnum="";
}
try{
	matnum = String.valueOf(Long.parseLong(matnum));
}catch(Exception e){}
if("P".equals(doctype))
{
	/*
	NumberFormat nfmt = NumberFormat.getInstance();
	try{
		nfmt.setMaximumFractionDigits(2);
		nfmt.setMinimumFractionDigits(2);
		ToBeDelQty = nfmt.format(tobedelqty);
	}catch(Exception e){}	
	*/
	ToBeDelQty = getNumberFormat(tobedelqty+"",0);
	uomQty = getNumberFormat(uomQty,0);
%>
			<td width="15%"><input type="hidden" name="MaterialNr" value="<%=matnum%>"><%=matnum%>&nbsp;</td>
			<td width="38%"><input type="hidden" name="matdesc" value="<%=matDesc%>"><input type="text" class="tx" style="width:100%" value="<%=matDesc%>" readonly></td>
			<td width="8%" align="right"><input type="hidden" name="UOM" value="<%=uomQty%>"><%=uomQty%>
			<input type="hidden" name="tobedelqty" value="<%=tobedelqty%>">
			<input type="hidden" name="displayQty" value="<%=ToBeDelQty%>">
			</td>
<%
}
else
{
%>
			<td width="22%"><input type="hidden" name="MaterialNr" value="<%=retLines.getFieldValue(i,"MAT_NR")%>"><%=matnum%>&nbsp;</td>
			<td width="42%"><input type="hidden" name="matdesc" value="<%=retLines.getFieldValue(i,"MAT_DESC")%>" readonly><%=retLines.getFieldValue(i,"MAT_DESC")%></td>
			<td width="12%"  align="right">
			<input type="hidden" name="tobedelqty" value="">
			<input type="hidden" name="displayQty" value="">
			<input type="hidden" name="UOM" value="<%=retLines.getFieldValue(i,"TOTAL_QTY")%>"><%=getNumberFormat(retLines.getFieldValueString(i,"TOTAL_QTY"),0)%></td>
<%
}
%>
			<td width="12%" align=center>
			<input type="hidden" name="Quantity">

			<input type="hidden" name="batches" value="<%=(tempStr.length()>0)?tempStr.substring(0,tempStr.length()-3):tempStr%>"><a href="JavaScript:addBatches('<%=i%>')" >View</a>
			<input type="hidden" name="serverfiles" value="<%=(serverfiles.length()>0)?serverfiles.substring(0,serverfiles.length()-3):serverfiles%>">
			</td>
	</Tr>
		<input type=hidden name=coaData value="<%=mainCoaData[i]%>">
		<input type=hidden name=coaLong value="<%=mainCoaLong[i]%>">
<%
		tempStr = "" ;
		serverfiles="";
	}


}
%>
	</table>
	</div>
	
	
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"ezViewShipmentHeader.jsp?showData=Y&ponum="+ponum+"&orderBase="+orderBase+"\")");
	
	if(shipflag.equals("Y"))
	{
		buttonName.add("View Documents");
		buttonMethod.add("openViewUploadWindow()");
	}	
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>	
	
	<input type="hidden" name="shipuploads" value="<%=fstring%>" >
	<input type="hidden" name="shipserverfiles" value="<%=sfstr%>">
	<input type="hidden" name="schdflag" value="<%=schdflag%>" >
	<input type="hidden" name="shipflag" value="<%=shipflag%>">
	<input type="hidden" name="Type" value="<%=doctype%>" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
