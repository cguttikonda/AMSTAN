<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iAttachmentFile_Labels.jsp"%>
<html>
<head><title>Attachment</title>
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
	attach=window.open("../Shipment/ezAttachFile.jsp?index="+i,"UserWindow2","width=450,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}

function funLoad()
{
	var filestr=document.myForm.shipupload.value;

	if(filestr!="")
	{

		var filearr=filestr.split("§");

		for(var i=0;i<document.myForm.n1.length;i++)
		{
			if(filearr[i]=="NA")
			{
				finalval="";

			}
			else
			{
				finalval=filearr[i];
				document.getElementById("remove"+i).style.visibility="visible"
				document.getElementById("attachment"+i).style.visibility="hidden";
			}
			document.myForm.n1[i].value=finalval;
		}
	}
}

function funDone()
{
	finalstr=""
	shipflag="N";
	for(var i=0;i<document.myForm.n1.length;i++)
	{
		if(document.myForm.n1[i].value!="")
		{
			finalstr=finalstr+document.myForm.n1[i].value+"§";
			shipflag="Y";
		}
		else
		{
			finalstr=finalstr+"NA"+"§";
		}

	}

	finalstr=finalstr.substring(0,finalstr.length-1);
	parentObj.shipupload.value=finalstr;
	parentObj.shipflag.value=shipflag;
	window.close();
}

	function removeFile(x)
	{
	   document.myForm.n1[x].value="";
	   document.getElementById("remove"+x).style.visibility="hidden"
	   document.getElementById("attachment"+x).style.visibility="visible";
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

<body onLoad="funLoad()"  onUnLoad="funUnLoad()" scroll=no>
<form name="myForm">
	<table width="90%">
	<tr><td><b><%=attachFiles_L%></b></td>
	<tr><td class="blankcell"><hr></td>
	<tr><td class="blankcell">1.<%=clickAttachFile_L%></td>
	</tr></table>
	<table width="80%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<th colspan=3 align="left"><%=dc_Doc_L%></th>
	</tr>
	<tr>

<td align="left"><input type=text size="25" class=InputBox  value="" name="n1"></td>
<td align="center">
	<img id="attachment0" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onclick="funAttach(0)" >
	<img id="remove0" alt="Delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(0)" ></td>
</tr>

<tr>
<th colspan=3 align="left"><%=lr_Doc_L%></th>
</tr>
<tr>

<td align="left"><input type=text size="25" class=InputBox  value="" name="n1"></td>
<td align="center"><img id="attachment1" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onclick="funAttach(1)" >
 <img id="remove1" alt="delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(1)" ></td>
</tr>

<tr>
<th colspan=3 align="left"><%=pack_Doc_L%></th>
</tr>
<tr>

<td align="left"><input type=text size="25" class=InputBox  value="" name="n1"></td>
<td align="center"><img id="attachment2" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onclick="funAttach(2)" >
<img id="remove2" alt="delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(2)" ></td>
</tr>

<tr>
<th colspan=3 align="left"><%=inv_Doc_L%></th>
</tr>
<tr>

<td align="left"><input type=text size="25" class=InputBox  value="" name="n1"></td>
<td align="center"><img id="attachment3" src="../../../../EzCommon/Images/Body/attachfile.jpg" style="cursor:hand" border=none onclick="funAttach(3)" >
<img id="remove3" alt="delete Attachment"  src='../../../../EzCommon/Images/Body/remove.gif' style='cursor:hand;visibility:hidden' border=none onClick="removeFile(3)" ></td>
</tr>
</table>

<table width="90%">
<tr><td class="blankcell"><hr></td>
<tr><td class="blankcell">2.<%=clkDone_L%></td>
<tr><td class="blankcell">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Done");
	buttonMethod.add("funDone()");

	buttonName.add("Cancel");
	buttonMethod.add("window.close()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</td>
<tr><td class="blankcell"><hr></td>
</tr></table>

<input type="hidden" name="shipupload" value="<%=request.getParameter("filestring")%>" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
