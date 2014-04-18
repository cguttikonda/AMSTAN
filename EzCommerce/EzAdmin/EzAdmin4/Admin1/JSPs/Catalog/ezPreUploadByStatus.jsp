<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%//@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>

<html>
<head>
<style>
inputbox {
	border: none;
	width: 241px;
	height: 20px;
	padding-left: 3px;
	padding-top: 3px;
}
</style>
	
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>


<Script>

function funUpload()
{
	var path = document.myForm.path.value;		
	if(path=="")
	{
		alert("Please Enter or Browse file to Attach.");
		return false;
	}
	else
	{
		var dotPos 	= path.lastIndexOf('.');
		var fileExt	= path.substring(dotPos+1,path.length);

		if(!(fileExt == "xls"))
		{
			alert("Please attach only file of type Excel.");
			return;
		}

		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan") 
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
		}
		document.myForm.action="ezProcessFileByStatus.jsp"; 
		document.myForm.submit();
	}
}

</Script>
<Script>
  var tabHeadWidth=80
  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	
</Head>

<Body  onLoad='scrollInit();'  onresize="scrollInit();" scroll=no>

<Form name="myForm" ENCTYPE="multipart/form-data" method="post">
<br><br><br>
	<Table width=40% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<Tr>
			<Th width ="20%" align= right><nobr>Upload File :</nobr></th>
			<Td width="80%"> <input name="path" class=inputbox type="file" style="width:100%">
			</Td>
		</Tr> 
	</Table>
	<br><br><br><br>
	<Div id="image" align="center" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:50%'>
	<Table>
	<Tr>
		<Td class=blankcell>
			<span id="EzButtonsSpan" >
				<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" onClick="funUpload()" border="none" valign=bottom style="cursor:hand"> 
			</span>
			<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
			</span>
		</Td>
	</Tr>
	</Table>
</Div>
<Div id="MenuSol"></Div>
</Form>
</Body>
</Html>