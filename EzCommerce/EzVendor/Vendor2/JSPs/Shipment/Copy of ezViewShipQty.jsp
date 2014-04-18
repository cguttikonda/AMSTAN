<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iViewShipQty_Labels.jsp"%>
<html>
<head>
<title>View Shipment Batch Info  --Powered By Answertink</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<%
	String index 	= request.getParameter("index");
	String rowCount = request.getParameter("rowCount");
%>
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
	docObj 		= parent.opener.document
}

function funOpenFile(serverFileInd)
{
	serverFile = eval("document.myForm.upFile"+serverFileInd).value
	var fVal = serverFile.split('*')
	sFile="";
	for(var i=0;i<fVal.length;i++)
	{
		sFile = sFile+fVal[i]+"/"
	}
	sFile = sFile.substring(0,sFile.length-1)
	window.open("../Misc/ezViewFile.jsp?filename=<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=no");
}
</script>
</head>
<body scroll="No">
<form name="myForm">
<script>
	function qaWindow(addFile)
	{
		window.open(addFile,"MyNewtest1","center=yes,height=500,left=50,top=20,width=700,titlebar=no,status=no,resizable,scrollbars,status=yes")
	}
	var args=new Array();
	args[0]="<%=request.getParameter("args")%>"
	args[1]='<%=request.getParameter("sfiles")%>'
	var coastr="<%=request.getParameter("coastr")%>"
	
	if(args[0].indexOf("¥") != -1)
	{
		args[0] = args[0].replace("¥","-");
		coastr 	= coastr.replace("¥","-");
	}	
	
<%
	if(!rowCount.equals("1"))
	{
%>
		var data = parentObj.coaData['<%=index%>'].value
<%
	}
	else
	{
%>
		var data = parentObj.coaData.value
<%
	}
%>
        var fieldValues = data.split("¥");
	var values=args[0].split("¤");
	
	var batches=values[3].split("µ");
	var sfiles=args[1].split("µ");
	var matcode='';
	if(values.length==4)
		matcode = values[3]
	else if(values.length==5)
		matcode = values[4]
	
	document.write ("<table align='center' width='100%' border='1' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>");
	document.write ("<tr><th width='10%'><%=line_L%> </th><td width='10%'>");
	document.write(values[0]);
	document.write("</td>");
	document.write ("<th width='14%'>Material</th><td width='23%'>");
	document.write(matcode);
	document.write("</td>");
	document.write ("<th width='18%'><%=desc_L%></th><td width='35%'>");
	document.write(values[1]);
	document.write("</td></tr></Table><br>");

	document.write("<table border='1' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align='center' width='100%'><tr><th width='20%'><%=batch_no_L%></th><th width='20%'><%=mfg_date_L%></th><th width='20%'><%=exp_date_L%></th><th width='10%'><%=batch_qty_L%></th><th width='20%'><%=coa_doc_L%></th></tr>");
	for(var i=0;i<batches.length;i++)
	{
		var allfields=batches[i].split("§");

		if(allfields[0]=="NA")
		{
			coastr=coastr+"¤"+"-";
		}
		else
		{
			coastr=coastr+"¤"+allfields[0];
		}

		if(allfields[3]=="NA")
		{
			coastr=coastr+"¤"+"-";
		}
		else
		{
			coastr=coastr+"¤"+allfields[3];
		}

		batch = (allfields[0]=='NA')?'&nbsp;':allfields[0]
		seperator='<%=(String)session.getValue("DATESEPERATOR")%>'
		mfgDate = (allfields[1]=='NA' || allfields[1]=="01"+seperator+"01"+seperator+"1900")?'&nbsp;':allfields[1]
		expDate = (allfields[2]=='NA' || allfields[2]=="01"+seperator+"01"+seperator+"1900")?'&nbsp;':allfields[2]
		attachment = (allfields[4]=='NA')?"":allfields[4];
		serverpath= (sfiles[i]=='NA')?"&nbsp;":sfiles[i];
		document.write("<Tr>");
		document.write("<Td width=19%>"+batch+"</Td>");
		document.write("<Td align='center' width=17%>"+mfgDate+"</Td>")
		document.write("<Td align='center' width=17%>"+expDate+"</Td>")
		document.write("<Td  width=17% align='right'>"+allfields[3]+"</Td>")
 		document.write("<Td align='left' width=30%><input type='hidden' name='upFile"+i+"' value='"+serverpath+"'><a href='javascript:funOpenFile("+i+")'>"+attachment+"</a>&nbsp;&nbsp;");
		if(fieldValues[i]!="-")
		{
			n=i+1;
			document.write("</Td>")
		}
		else
		{
			document.write("&nbsp;</Td>")
		}
			document.write("</Tr>");
	}
	document.write ("</table><br><br>");
	</script>

<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("window.close()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
