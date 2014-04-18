<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<HTML>
<HEAD>
	<script>
	var attach;
function funAttach()
{
	attach=window.open("ezImageAttach.jsp","UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}

function funRemove()
{

	var plzSelFileDel_L = 'Please Select a File To Delete';
	var noAttachRem_L = 'No Attachments To Remove';
	var attachments=new Array();
	var j=0;
	var count=0;
	if((document.myForm.attachs.length)>0)
	{
		for(var i=0;i<(document.myForm.attachs.length);i++)
		{
			if(document.myForm.attachs.options[i].selected==true)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert(plzSelFileDel_L);
			//return false;
		}
	}
	else
	{
		alert("No files to Remove");
		//return false;
	}
	for(var i=0;i<document.myForm.attachs.length;i++)
	{
		if(document.myForm.attachs.options[i].selected==false)
		{
			attachments[j]=document.myForm.attachs.options[i].value;
			j++;
		}
	}

	for(var i=document.myForm.attachs.length;i>=0;i--)
	{
		document.myForm.attachs.options[i]=null;
	}
	for(var i=0;i<attachments.length;i++)
	{
		document.myForm.attachflag.value="true"
		document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
	}
}
</script>	
</HEAD>
<BODY scroll=no>
<FORM name=myForm method=post>
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
<% 
	String display_header="Image Upload"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br><br><br>
<Table width="50%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<Tr>
	<Td  width="100%" rowspan="2" valign="bottom" align="center">
		<select name="attachs" style="width:100%" size=10>
		</select>
    	</Td>
</Tr>

</Table>
<br><br><br><br>
<center>
	<%					
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Attach");
		buttonMethod.add("funAttach()");

		buttonName.add("Remove");
		buttonMethod.add("funRemove()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
<center>
</FORM>
<Div id="MenuSol"></Div>
</BODY>

</HTML>