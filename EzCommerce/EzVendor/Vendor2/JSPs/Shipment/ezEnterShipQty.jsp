<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iEnterShipQty_Labels.jsp"%>
<html>
<head>
<title>Enter Shipment Batch Information</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%
	String index 	= request.getParameter("index");
	String rowCount = request.getParameter("rowCount");
	String coastr 	= request.getParameter("coastr");
	String args 	= request.getParameter("args");
	String type	= request.getParameter("type");
	int dateFormat  = Integer.parseInt((String)session.getValue("DATEFORMAT"));
%>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
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
<script>
	var parentObj="";
	var docObj="";
	if(!document.all)
	{
		parentObj 	= opener.document.myForm	
		docObj 		= opener.document
	}
	else
	{
		parentObj 	= parent.opener.myForm	
		docObj	 	= parent.opener.document
	}

	function funCheckDates()
	{
	    var isInvalid=false;
	    for(var i=0;i<document.myForm.Qty.length;i++)
	    {
                  if(document.myForm.Qty[i].value!="0")
		  {
			if(document.getElementById("mfr"+i).value!="" && document.getElementById("exp"+i).value!="")
			{
				var mfrValue 	= document.getElementById("mfr"+i).value
				mfrValue	= ConvertDate(mfrValue,'<%=dateFormat%>')
				var expValue 	= document.getElementById("exp"+i).value
				expValue	= ConvertDate(expValue,'<%=dateFormat%>')
				mfrDate 	= new Date(mfrValue.substring(6,10),parseInt(mfrValue.substring(3,5),10)-1,mfrValue.substring(0,2))
				expDate 	= new Date(expValue.substring(6,10),parseInt(expValue.substring(3,5),10)-1,expValue.substring(0,2))
				if(mfrDate > expDate)
				{
				    alert("<%=mandtLtExpdt_L%>")
				    isInvalid=true;
				    break;
				}
			}
		  }
	    }
            if(isInvalid)
		return false;
	    else
	        return true;
	}

	function setValues()
	{
		var coastr	= "<%=coastr%>"
		var args	= new Array();
		args[0]	= '<%=args%>'
		args[1]	= '<%=request.getParameter("Qtytobeship")%>'
		args[2]	= '<%=request.getParameter("displayQty")%>'
		
		
		if(args[0].indexOf("¥") != -1)
		{
			args[0] = args[0].replace("¥","-");
			coastr 	= coastr.replace("¥","-");
		}		
		var values=args[0].split("¤");
		for(var i=0;i<10;i++)
		{
			document.getElementById("textn2"+i).style.display="none"
		}
		if(values.length==4)
		{
			document.myForm.lineno.value=values[0];
			document.myForm.matdesc.value=values[1];
			document.myForm.uom.value=values[2];
			document.myForm.matcode.value=values[3];
			
			document.myForm.qtd.value=args[2];
			document.myForm.coastr.value=coastr;
		}
		else
		{
			if(values.length==5)
			{
				document.myForm.lineno.value=values[0];
				document.myForm.matdesc.value=values[1];
				document.myForm.uom.value=values[2];
				document.myForm.matcode.value=values[4];
				document.myForm.qtd.value=args[2];
				document.myForm.coastr.value=coastr;
				var batches=values[3].split("µ");
				for(var i=0;i<batches.length;i++)
				{
					var allfields=batches[i].split("§");
					document.myForm.Batch[i].value=(allfields[0]=="NA")?"":allfields[0];
					document.getElementById("mfr"+i).value=(allfields[1]=="NA")?"":allfields[1];
					document.getElementById("exp"+i).value=(allfields[2]=="NA")?"":allfields[2];
					if(allfields[4]=="NA")
					{
						document.myForm.n1[i].value="";
					}
					else
					{
						document.myForm.n1[i].value=allfields[4];
						document.getElementById("remove"+i).style.visibility="visible";
						document.getElementById("attachment"+i).style.visibility="hidden";
						document.myForm.n1[i].style.visibility="hidden";
						document.getElementById("textn1"+i).style.display="none"
						document.getElementById("textn2"+i).style.display=""
						document.getElementById("attach"+i).style.display="none"
						document.getElementById("del"+i).style.display=""
						document.myForm.n2[i].value=allfields[4];
					}
					document.myForm.Qty[i].value=allfields[3];
				}
			}
		  }
	}

	function TakeValues()
	{
		var totalValues="";
		var args=new Array();
		args[0]="<%=args%>"
		args[1]='<%=request.getParameter("Qtytobeship")%>'
		args[2]='<%=index%>'

		var qtd=args[1];
		var totqty=0;
		bool=true;
		schdflag=parentObj.schdflag.value;
		if(schdflag=="")
			schdflag="N";
		for(var i=0;i<document.myForm.Qty.length;i++)
		{
			if(document.myForm.Qty[i].value!="" && document.myForm.Qty[i].value!=0)
			{
				if(document.myForm.Batch[i].value=="")
					totalValues=totalValues+"NA"+"§";
				else
					totalValues=totalValues+document.myForm.Batch[i].value+"§";
				if(document.getElementById("mfr"+i).value=="")
					totalValues=totalValues+"NA"+"§";
				else
					totalValues=totalValues+document.getElementById("mfr"+i).value+"§";
				if(document.getElementById("exp"+i).value=="")
					totalValues=totalValues+"NA"+"§";
				else
					totalValues=totalValues+document.getElementById("exp"+i).value+"§";


				totalValues=totalValues+document.myForm.Qty[i].value+"§";

				if(document.myForm.n1[i].value=="")
				{
					totalValues=totalValues+"NA"+"§";
				}
				else
				{
					schdflag="Y";
					totalValues=totalValues+document.myForm.n1[i].value;
				}

				totalValues=totalValues+"µ";
				totqty=parseFloat(totqty,10)+parseFloat(document.myForm.Qty[i].value,10);
			}

			if(document.myForm.Batch[i].value!="" || document.getElementById("mfr"+i).value!="" || document.getElementById("exp"+i).value!=""|| document.myForm.n1[i].value!="")
			{
				if(document.myForm.Qty[i].value=="" || document.myForm.Qty[i].value==0)
				{
					alert('<%=plzEntBat_L%>');
					document.myForm.Qty[i].focus();
					bool=false;
					break;
				}
			}
		}

		if(qtd=="" && bool==true && funCheckDates())
		{
			if(isNaN(parentObj.batches.length))
			{
				parentObj.batches.value=totalValues.substring(0,totalValues.length-1);
				parentObj.Quantity.value=totqty;
				parentObj.schdflag.value=schdflag;

					if(totqty>0)
						docObj.getElementById("Entry_0").innerHTML="View"
					else
						docObj.getElementById("Entry_0").innerHTML="Select"

			   	 window.close();
			}
			else
			{
				parentObj.batches[args[2]].value=totalValues.substring(0,totalValues.length-1);
				parentObj.Quantity[args[2]].value=totqty;
				parentObj.schdflag.value=schdflag;
				if(totqty>0)
					docObj.getElementById("Entry_"+args[2]).innerHTML="View"
				else
					docObj.getElementById("Entry_"+args[2]).innerHTML="Select"
				 window.close();
			}
		}
		else
		{
			if(totqty<=parseFloat(qtd) && bool==true && funCheckDates())
			{
				if(isNaN(parentObj.batches.length))
				{
					parentObj.batches.value=totalValues.substring(0,totalValues.length-1);
					parentObj.Quantity.value=totqty;
					parentObj.schdflag.value=schdflag;
					if(totqty>0)
						docObj.getElementById("Entry_0").innerHTML="View"
					else
						docObj.getElementById("Entry_0").innerHTML="Select"

			      	        window.close();
				}
				else
				{
					parentObj.batches[args[2]].value=totalValues.substring(0,totalValues.length-1);
					parentObj.Quantity[args[2]].value=totqty;
					parentObj.schdflag.value=schdflag;

					if(totqty>0)
						docObj.getElementById("Entry_"+args[2]).innerHTML="View"
					else
						docObj.getElementById("Entry_"+args[2]).innerHTML="Select"

					window.close();
				}
			}
			else
			{

				if(totqty>parseFloat(qtd))
				{
					alert("<%=totQtyMore_L%>");
					totqty=0;
				}
			}
		}
	}

	var attach;
	function funAttach(i)
	{
		attach=window.open("ezAttachFile.jsp?index="+i,"UserWindow1","width=350,height=250,left=300,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	}

	function removeFile(x)
	{
		document.myForm.n1[x].value="";
		document.getElementById("remove"+x).style.visibility="hidden";
		document.getElementById("textn1"+x).style.display="block"
		document.getElementById("textn2"+x).style.display="none"
		document.getElementById("attach"+x).style.display="block"
		document.getElementById("attachment"+x).style.visibility="visible";
		document.myForm.n1[x].style.visibility="visible"
		document.getElementById("del"+x).style.display="none"
	}

	function funView(index)
	{
		window.open()
		window.open("../Materials/ezViewTempUploadedFile.jsp?fileName="+document.myForm.n1[index].value)
	}


</script>
</head>
<body scroll=no onLoad="setValues()" bottomMargin=0 topMargin=0>
<form name="myForm">

<table align='center' width='98%'>
<tr>
	<td>
		<%=entBatchMsg1_L%>
		<br>
		<%=entBatchMsg2_L%>
	</td>
</tr>
</table>

<Table border='1' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align='center' width='98%' border =1 >
<tr>
	<th width="8%"><%=line_L%></th>
	<td width="8%"><input type="text"  name="lineno" readonly size="5" class="tx" ></td>
	<th width="13%">Material</th>
	<td width="20%"><input type="text"  name="matcode" readonly size="18" class="tx" ></td>
	<th width="14%">Description</th>
	<td width="35%"><input type="text"  name="matdesc" readonly size="40" class="tx"></td>
</tr>
<tr >
<% 
	if(type.equals("P"))
   	{ 
%>
		<th colspan="3" width="50%"><%=toBeDelQty_L%></th>
		<td colspan="3" width="50%" ><input type="text"  name="qtd" readonly style="text-align:right;" class="tx">&nbsp;<input type="text"  name="uom" readonly  size="4" class="tx"  > </td>
<% 
	}
	else
	{ 
%>
		<input type="hidden"  name="qtd"><input type="hidden"  name="uom">
<% 
	}
%>
</tr>
</table>

<table border='1' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align="center" width="98%">
<tr>
	<th><%=batchNo_L%></th>
	<th><%=mfgDate_L%></th>
	<th>Expire Date</th>
	<th><%=batchQty_L%></th>
	<th colspan=3><%=coaDoc_L%></th>
</tr>
<%
	for(int i=0;i<10;i++)
	{
%>
		<tr>
			<td><input type="Text" class=InputBox  size="15" maxlength="10" name="Batch" ></td>
			<td>
				<input type="text"  class=InputBox  name="mfr<%=i%>" id="mfr<%=i%>" size="15" readonly>
				<%=getDateImage("mfr"+i)%>
			</td>
			<td>
				<input type="text"  class=InputBox  name="exp<%=i%>" id="exp<%=i%>" size="15" readonly>
				<%=getDateImage("exp"+i)%>
			</td>
			<td align="right">
				<input type="text"  class=InputBox  maxlength="16" name="Qty" size="10" value="0" onBlur="verifyField(this)" style="text-align:right">
			</td>
			<td align="left">
				<span id="textn1<%=i%>">
					<input type="text"  name="n1" size="8" readonly class=InputBox >
				</span>
			    	<span id="textn2<%=i%>" style="display:none">
				    	<input type="text"  name="n2" size="12" class=tx readonly>
			    	</span>
		    	</td>
		    	<td align="center">
		    		<span id="attach<%=i%>">
		        		<img id="attachment<%=i%>" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onClick=funAttach("<%=i%>")>
		        	</span>
		        	<span id="del<%=i%>" style="display:none" >
		        		<img  id="remove<%=i%>" alt="delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick=removeFile("<%=i%>")>
		        	</span>
			</td>
		</tr>
<%
	}
%>
</table>
	
<table align="center">
<tr>
	<td align="center" colspan="2" class="blankcell">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Ok");
		buttonMethod.add("TakeValues()");

		buttonName.add("Cancel");
		buttonMethod.add("window.close()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</td>
</tr>
</table>

<input type="hidden" name="coastr" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
