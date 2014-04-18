<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head><title>Upload File</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<script>

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

var attach;
function funAttach(i)
{
	attach=window.open("../Shipment/ezAttachFile.jsp?index="+i,"UserWindow2","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}

function funLoad()
{
	var filestr=document.myForm.shipupload.value;
	var serverfiles=document.myForm.shipserver.value
	var sfinal="";
	if(filestr!="")
	{

		var filearr=filestr.split("§");
		var sfilearr=serverfiles.split("µ");


		for(var i=0;i<document.myForm.n1.length;i++)
		{
			if(filearr[i]=="NA")
			{
				finalval="";
				sfinal="";
			}
			else
			{
				finalval=filearr[i];
				sfinal=sfilearr[i];
				document.getElementById("remove"+i).style.visibility="visible"
				document.getElementById("attachment"+i).style.visibility="hidden"
			}
			document.myForm.n1[i].value=finalval;
			document.myForm.serverfile[i].value=sfinal;
			//document.myForm.orgfile[i].value=finalval;
			

		}
	}
}

function funDone()
{
	finalstr=""
	sfinalstr="";

	shipflag="N";
	var filestr='<%=request.getParameter("filestring")%>'
	
	var filearr=filestr.split("§");
	for(var i=0;i<document.myForm.n1.length;i++)
	{
		if(document.myForm.n1[i].value!="")
		{
			finalstr=finalstr+document.myForm.n1[i].value+"§";
			
			if(filearr[i]==document.myForm.n1[i].value)
			{
				sfinalstr=sfinalstr+document.myForm.serverfile[i].value+"µ";
			}
			else
			{
				sfinalstr=sfinalstr+"NA"+"µ";
			}
			shipflag="Y";

		}
		else
		{
			finalstr=finalstr+"NA"+"§";
			sfinalstr=sfinalstr+"NA"+"µ";
		}
	}
	finalstr=finalstr.substring(0,finalstr.length-1);
	sfinalstr=sfinalstr.substring(0,sfinalstr.length-1);


	parentObj.shipuploads.value=finalstr;
	parentObj.shipserverfiles.value=sfinalstr;
	
	parentObj.shipflag.value=shipflag;
		window.close();



}

	function removeFile(x)
	{
	   document.myForm.n1[x].value="";
	   document.myForm.orgfile[x].value="";
	   document.getElementById("remove"+x).style.visibility="hidden"
	   document.getElementById("attachment"+x).style.visibility="visible"
	}
function funCancel()
{
	window.close();
}


function funUnLoad()
{
	if(attach!=null && attach.open)
	{
		attach.close();
	}
}
</script>
</head>

<body onLoad="funLoad()" onUnLoad="funUnLoad()" >
<form name="myForm">
<table width="50%" align=center border=0>
<tr><td align="center" class="displayheader" align=center>Upload</td>
</tr></table>

<br>
<table width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

<tr>
<th colspan=3 align="left">DC Document</th>
</tr>
<tr>

<td align="left">
<input type=text size="25" class="tx"  value="" name="n1">
<input type="hidden"   value="" name="serverfile">
<input type="hidden"   value="" name="orgfile">
</td>
<td align="center"><img id="attachment0" src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(0)" >
<img id="remove0" alt="delete Attachment"  src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(0)" ></td>
</tr>

<tr>
<th colspan=3 align="left">LR Document</th>
</tr>
<tr>

<td align="left">
<input type=text size="25" class="tx"  value="" name="n1">
<input type="hidden"  value="" name="serverfile">
<input type="hidden"  value="" name="orgfile">
</td>
<td align="center"><img id="attachment1" src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(1)" >
<img id="remove1" alt="delete Attachment"  src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(1)" ></td>
</tr>

<tr>
<th colspan=3 align="left">Packing Document</th>
</tr>
<tr>

<td align="left">
<input type=text size="25" class="tx"  value="" name="n1">
<input type="hidden" value="" name="serverfile">
<input type="hidden" value="" name="orgfile">
</td>
<td align="center"><img id="attachment2" src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(2)" >
<img id="remove2" alt="delete Attachment"  src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(2)" ></td>
</tr>

<tr>
<th colspan=3 align="left">Invoice (Excise) Document</th>
</tr>
<tr>

<td align="left">
<input type=text size="25" class="tx"  value="" name="n1">
<input type="hidden"  value="" name="serverfile">
<input type="hidden"  value="" name="orgfile">
</td>
<td align="center"><img id="attachment3" src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(3)" >
<img id="remove3" alt="delete Attachment"  src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(3)" ></td>
</tr>
</table><br>


<div id="attachments" align="center" style="postion:absolute;visibility:hidden;top=200">
</div>

<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/done.gif" style="cursor:hand" border=none onClick="funDone()">
<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none onClick="funCancel()">
</center>

<input type="hidden" name="shipupload" value="<%=request.getParameter("filestring")%>" >
<input type="hidden" name="shipserver" value="<%=request.getParameter("serverfiles")%>" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
