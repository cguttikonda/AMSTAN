<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iEditShipQty_Labels.jsp"%>
<html>
<head>
<title>Enter Shipment Batch Information --Powered By Answerthink</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<%
	String index 	= request.getParameter("index");
	String rowCount = request.getParameter("rowCount");
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
	var seperator='<%=(String)session.getValue("DATESEPERATOR")%>'
	var parentObj="";
	var docObj="";
	if(!document.all)
	{
	  parentObj = opener.document.myForm
	  docObj = opener.document
	}
	else
	{
	  parentObj = parent.opener.myForm
	  docObj = parent.opener.document
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

				var mfrValue = document.getElementById("mfr"+i).value
				mfrValue=ConvertDate(mfrValue,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
				var expValue = document.getElementById("exp"+i).value
				expValue=ConvertDate(expValue,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
				mfrDate = new Date(mfrValue.substring(6,10),parseInt(mfrValue.substring(3,5),10)-1,mfrValue.substring(0,2))
				expDate = new Date(expValue.substring(6,10),parseInt(expValue.substring(3,5),10)-1,expValue.substring(0,2))

				if(mfrDate>expDate)
				{
				    alert("Manufacturing Date should be less than Expiry Date")
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

	function setValues(){
		//var args=parent.dialogArguments;

		//COA FUNCTION COMMENTED
		//setCOAValues() //This is added by Sudhir for COA

		var args=new Array();
		args[0]="<%=request.getParameter("args")%>";
		args[1]="<%=request.getParameter("Qtytobeship")%>"
		args[2]="<%=request.getParameter("sfiles")%>"
		args[3]="<%=request.getParameter("displayQty")%>"
		
		var coastr='<%=request.getParameter("coastr")%>'
		

		if(args[0].indexOf("¥") != -1)
		{
			args[0] = args[0].replace("¥","-");
			coastr 	= coastr.replace("¥","-");
		}		
		
		for(var i=0;i<10;i++)
		{
			document.getElementById("textn2"+i).style.display="none"
		}
		
		var values=args[0].split("¤");
		var svalues=args[2].split("µ");

		if(values.length==3)
		{
			document.myForm.lineno.value=values[0]
			document.myForm.matdesc.value=values[1]
			document.myForm.uom.value=values[2];
			document.myForm.qtd.value=args[3];
			document.myForm.coastr.value=coastr;
		}
		else
		{
			if(values.length==4)
			{
				document.myForm.lineno.value=values[0]
				document.myForm.matdesc.value=values[1]
				document.myForm.uom.value=values[2];
				document.myForm.qtd.value=args[3];
				document.myForm.coastr.value=coastr;

				var batches=values[3].split("µ");
				for(var i=0;i<batches.length;i++)
				{

					var allfields=batches[i].split("§");
					document.myForm.Batch[i].value=(allfields[0]=="NA")?"":allfields[0];
					document.getElementById("mfr"+i).value=(allfields[1]=="NA" || allfields[1]=="01"+seperator+"01"+seperator+"1900")?"":allfields[1];
					document.getElementById("exp"+i).value=(allfields[2]=="NA" || allfields[2]=="01"+seperator+"01"+seperator+"1900")?"":allfields[2];
					//document.myForm.n1[i].value=(allfields[4]=="NA")?"":allfields[4];
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
						document.myForm.orgfile[i].value=allfields[4];
					}
					document.myForm.Qty[i].value=allfields[3];
					document.myForm.sfiles[i].value=(svalues[i]=="NA")?"":svalues[i];
				}
			}
		}
	}
	function TakeValues(){
		var totalValues="";
		var args=new Array();
		args[0]='<%=request.getParameter("args")%>'
		args[1]='<%=request.getParameter("Qtytobeship")%>'
		args[2]='<%=index%>'
		args[3]='<%=request.getParameter("sfiles")%>'

	//COA FUNCTION COMMENTED
	// funCarryCoa(args[2]); //This is added by Sudhir for COA

		var values=args[0].split("¤");

		var batches=new Array();
		if(values.length>3)
		{
			 batches=values[3].split("µ");
		}

		cfiles=new Array();
		var allfields=""
		var cnt=0;
		for(var i=0;i<batches.length;i++)
		{
			allfields=batches[i].split("§");
			cfiles[i]=allfields[4];
			//alert(cfiles[i])
		}

		var qtd=args[1];
		var totqty=0;
		bool=true;;
		var sfiles="";
		var schdflag=parentObj.schdflag.value;

		for(var i=0;i<document.myForm.Qty.length;i++){
			if(document.myForm.Qty[i].value!="" && document.myForm.Qty[i].value!=0){

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



				if(document.myForm.sfiles[i].value=="")
				{
						sfiles=sfiles+"NA"+"µ";				//for server files

				}
				else
				{
					//if(cfiles[i]!=document.myForm.n1[i].value || document.myForm.orgfile.value=="")
					if(document.myForm.orgfile[i].value=="")
					{
						//alert(cfiles[i]+"*********"+document.myForm.n1[i].value);
						sfiles=sfiles+"NA"+"µ";
					}
					else
					{
						sfiles=sfiles+document.myForm.sfiles[i].value+"µ";
					}
				}

			}

			if(document.myForm.Batch[i].value!="" || document.getElementById("mfr"+i).value!="" || document.getElementById("exp"+i).value!=""|| document.myForm.n1[i].value!=""){
				if(document.myForm.Qty[i].value=="" || document.myForm.Qty[i].value==0)	{
					alert("Please Enter Batch Qty.");
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
				parentObj.serverfiles.value=sfiles.substring(0,sfiles.length-1);
				//alert(parent.opener.myForm.serverfiles.value);
				parentObj.schdflag.value=schdflag;


				window.close();
			}
			else
			{
				parentObj.batches[args[2]].value=totalValues.substring(0,totalValues.length-1);
				parentObj.Quantity[args[2]].value=totqty;
				parentObj.serverfiles[args[2]].value=sfiles.substring(0,sfiles.length-1);
				parentObj.schdflag.value=schdflag;
				//docObj.getElementById("Entry_"+args[2]).innerHTML="View"
				//alert(parent.opener.myForm.serverfiles.value);
				window.close();
			}
		}
		else
		{
			if(totqty<=parseFloat(qtd) && bool==true && funCheckDates()){

				if(isNaN(parentObj.batches.length))
				{
					parentObj.batches.value=totalValues.substring(0,totalValues.length-1);
					parentObj.Quantity.value=totqty;
					parentObj.serverfiles.value=sfiles.substring(0,sfiles.length-1);
					parentObj.schdflag.value=schdflag;
					//alert(parent.opener.myForm.serverfiles.value);
					
					window.close();
				}
				else
				{
					parentObj.batches[args[2]].value=totalValues.substring(0,totalValues.length-1);
					parentObj.Quantity[args[2]].value=totqty;
					parentObj.serverfiles[args[2]].value=sfiles.substring(0,sfiles.length-1);
					parentObj.schdflag.value=schdflag;
					//docObj.getElementById("Entry_"+args[2]).innerHTML="View"
					//alert(parent.opener.myForm.serverfiles.value);
					window.close();
				}
			}
			else{
				if(totqty>parseFloat(qtd)){
					alert("Total Qty of all Batches is greater than the To Be Delivered Qty.");
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
	 //  alert(document.myForm.orgfile[x].value);
	   document.myForm.orgfile[x].value="";
	   document.getElementById("remove"+x).style.visibility="hidden";
	   document.getElementById("textn1"+x).style.display=""
	   document.getElementById("textn2"+x).style.display="none"
	   document.getElementById("attach"+x).style.display=""
	   document.getElementById("attachment"+x).style.visibility="visible";
	   document.myForm.n1[x].style.visibility="visible"

	   document.getElementById("del"+x).style.display="none"
	}


	function funView(index)
	{
		//alert(document.myForm.n1[index].value);
		if(document.myForm.sfiles[index].value!="")
		{
			window.open();
			var tempwin=window.open("../Materials/ezViewUploadedFile.jsp?fileName="+document.myForm.sfiles[index].value)
			//tempwin.close()
		}
		else
		{
			window.open();
			var tempwin=window.open("../Materials/ezViewTempUploadedFile.jsp?fileName="+document.myForm.n1[index].value)
			//tempwin.close()
		}
	}


	</script>

</head>
<body onLoad="setValues()" bottomMargin=0 topMargin=0 scroll=no>
<form name="myForm">
	<table border='1' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align='center' width='98%'>
	<tr>
	<td>Please enter the Batch Details and Batch Qty. for Purchase Order Item.<br>
	For Non Packing Materials Click on  'Attach File' Button to Upload Files.</td>
	</tr>
	</table><br>

	<Table align='center' width='98%' border =1>
	<tr>
	<th width="10%">Line</th>
	<td width="10%"><input type="text"  name="lineno" readonly size="5" class="tx" ></td>
	<th width="15%">Description</th>
	<td width="30%"><input type="text"  name="matdesc" readonly size="20" class="tx"></td>

<%
	String type=request.getParameter("type");
	if("P".equals(type))
	{
%>
		<th width="20%">To Be Del. Qty</th>
		<td width="15%" align="left"><input type="text"  name="qtd" readonly size="8"  style="text-align:right;" class="tx">&nbsp;<input type="text"  name="uom" readonly  size="4" class="tx"  > </td>
<%
	}
	else
	{
%>
		<input type="hidden"  name="qtd" ><input type="hidden"  name="uom" >
<%
	}
%>
	</tr>
	</table>
<br>
	<table align="center" width="98%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<th>Batch No</th>
	<th>Mfg. Date</th>
	<th>Expire Date</th>
	<th>Batch Qty</th>
	<th colspan=3>COA Document</th>
	</tr>
	<%
	for(int i=0;i<10;i++){
	%>
		<tr>
		<td><input type="Text"  size="8" maxlength="10" name="Batch" class=InputBox></td>
		<td align="left">
			<input type="text"  name="mfr<%=i%>" id="mfr<%=i%>" class=InputBox  size="15" readonly>
			<%=getDateImage("mfr"+i)%>
		</td>
		<td align="left"><input type="text"  name="exp<%=i%>" id="exp<%=i%>" class=InputBox  size="15" readonly>
			<%=getDateImage("exp"+i)%>
		</td>
		<td align="right"><input type="text"  maxlength="16"  class=InputBox  name="Qty" size="10" value="0" onBlur="verifyField(this)"   style="text-align:right;">
		</td>
		</td>

		<td align="left">
	    	<span id="textn1<%=i%>">
			<input type="text"  name="n1" size="8"  readonly class=InputBox >
		</span>
		<span id="textn2<%=i%>">
	        	<input type="text"  name="n2" size="12"  readonly class=tx >
			<input type="hidden" name="orgfile" >
	        </span>

	        </td>
	        <td align="center">
	        <input type="hidden" name="sfiles">
	        <span id="attach<%=i%>">
	        	<img id="attachment<%=i%>" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onClick="funAttach(<%=i%>)">
	        </span>

		   <span id="del<%=i%>" style="display:none" >
	        	<img id="remove<%=i%>" alt="delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(<%=i%>)" >
	        </span>
	        </td>
<!--	COA CODE COMMENTED
	        <td>
	        /<a href="javascript:qaWindow('<%=i%>')">QA</a>
		<input type="hidden" name="coaData" value="">
  		<input type="hidden" name="coaLong" value="">
  		</td>
-->
		</tr>
	<%
	}
	%>
	</table>
	<Table align="center">
	<Tr>
	<td align="center" colspan="2" class="blankcell">
	<input type="hidden" name="coastr" value="">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
	
		buttonName.add("Ok");
		buttonMethod.add("TakeValues()");
	
		buttonName.add("Cancel");
		buttonMethod.add("window.close()");
	
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</Td>
	</Tr>
	</Table>

<!--	<input type="hidden" name="TotalBatches" >-->
<input type="hidden" name="coastr" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
