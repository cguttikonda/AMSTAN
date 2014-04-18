<%@ include file="../../Library/Globals/errorPagePath.jsp"%>


<html>
<head>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<title>File Attachments --Powered By EzCommerce Inc</title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<script>

var parentObj="";
var docObj="";
var k=0;
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

	function openBrowse(i)
	{
		eval("document.myForms.f"+i).click()
	}
	function setFname(j)
	{
		var path = eval('document.myForms.f'+j).value
	   	var x = path.lastIndexOf('\\')
	   	var fileName=path.substring(x+1,path.length);
	   	document.myForms.attachs.options[k]=new Option(fileName,fileName);
	   	k++;
	   	//eval('document.myForms.n'+j).value=fileName
	}
	function funRemove()
	{		
			docObj.myForm.attachs.value="";
			var docObjVal=docObj.myForm.attachs.value
			var attachments=new Array();
			var j=0;
			var count=0;
			if(document.myForms.attachs.length>0)
			{
				//alert(document.myForms.attachs.length)
				for(var i=0;i<document.myForms.attachs.length;i++)
				{
					if(document.myForms.attachs.options[i].selected==true)
					{
						count++;
					}
				}
				
				if(count==0)
				{
					alert("Please Select a File To Delete");
					//return false;
				}
			}
			else
			{
				alert("No Attachments To Remove");
				//return false;
			}
			for(var i=0;i<document.myForms.attachs.length;i++)
			{
				if(document.myForms.attachs.options[i].selected==false)
				{	
					docObjVal=docObj.myForm.attachs.value
					attachments[j]=document.myForms.attachs.options[i].value;
					if(docObjVal!="")
					 docObj.myForm.attachs.value=docObjVal+"##"+attachments[j];
					else
					 docObj.myForm.attachs.value=attachments[j];
					j++;
				}
				
			}
	
			for(var i=document.myForms.attachs.length;i>=0;i--)
			{
				document.myForms.attachs.options[i]=null;
			}
			for(var i=0;i<attachments.length;i++)
			{
				document.myForms.attachflag.value="true"
				document.myForms.attachs.options[i]=new Option(attachments[i],attachments[i]);
			}
	}
	function funClose()
	{
		var path = document.myForms.f1.value
		
		if(funTrim(path)=="")
		{
			alert("Please Enter or browse the file to Attach");
			return false;
		}
		else
		{
			
			var x = path.lastIndexOf('\\')
			
			var fileName=path.substring(x+1,path.length);
			//var len = document.myForms.attachs.length
			var attachValue = docObj.myForm.attachs.value
			var attachsValues = attachValue.split('##')
			len =attachsValues.length
			//alert(docObj.myForm.attachs.value)
			//alert(len);
			for(var i=0;i<len;i++)
			{
				alert(attachsValues[i]+"****"+fileName)
				//if(document.myForms.attachs.options[i].value==fileName)
				if(attachsValues[i]==fileName)
				{
					alert("File with this name is already attached")
					return;
				}
			}
			document.getElementById("attachment").style.visibility="hidden";
			setTimeout("funWait()","200");
			document.myForms.action="ezUploadFiles.jsp";
			document.myForms.submit();
		}
	}

	function funWait()
	{
		document.getElementById("image").style.visibility="visible";
		document.body.style.cursor='wait'
	}

</script>
</head>
<body>
<%
	String index=request.getParameter("index");
	session.putValue("INDEX",index);
%>
<form name="myForms" ENCTYPE="multipart/form-data" method="POST" >
<input type=hidden name="attachflag" value="">
<div id="attachment" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:5%'>
	<TABLE border=0 width="95%" align="left">
  		
 		 <Tr><td class="blankcell">1. <b>Find File</b></Td></Tr>
  		<Tr><td class="blankcell">Click on the 'Browse' button to select the file.</td></Tr>
 		<Tr><td class="blankcell"><input type=file   value="" name="f1" onPropertyChange="setFname(1)"></td></Tr>
 		 <Tr><td class="blankcell"><hr></Tr>
 		 <Tr><td class="blankcell">2. <b>Add File</b></Td></Tr>
 		 <Tr><td class="blankcell">Click on the 'Add File' button. Please wait till you get confirmation.</Td></Tr>
 		 <Tr><td class="blankcell"><input type="button" name="done" value="Add File" onClick="funClose()" ></Td></Tr>
 		 <Tr><td class="blankcell"><hr></Tr>
 		 <tr><td class="blankcell">3. <b>Attached Files</b></td>
		   		<tr><td class="blankcell"><b>
		 			<script>
		 				var attachvalues =  docObj.myForm.attachs.value
		 				var attachsvalues = attachvalues.split('##')
		 				var len = attachsvalues.length
		 				document.write('<select name="attachs" style="width:100%" size="5" multiple="5">');
		 					for(i=0;i<len;i++)
		 					{	if(attachsvalues[i]!='')
		 						document.write("<Option value="+"'"+attachsvalues[i]+"'"+">"+attachsvalues[i]+"</Option>");
		 					}
		 				document.write('</select>')
		 			</script>
		 		</b></td></tr>
		 		<Tr><td class="blankcell"><input type="button" name="remove" value="Remove" onClick="funRemove()" ></Td></Tr>
  		<Tr><td class="blankcell"><hr></Tr>
</Table>
</div>
<div id="image" style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
<br><br><br>
<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/retAttachNoStop.gif">
</center>
</div>
</form>
</body>
</html>
