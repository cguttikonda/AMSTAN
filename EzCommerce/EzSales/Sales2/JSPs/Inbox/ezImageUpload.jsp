<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<HTML>
<HEAD>
<Script>
	  var tabHeadWidth=80
	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
var attach;
function funDelete(file)
{
	attach=window.open("ezDeleteImage.jsp?file="+file,"UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}	
function funAttach()
{
	attach=window.open("ezBulkImageUpload.jsp","UserWindow1","width=350,height=450,left=300,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}

function deleteImage(myImage,myIndex){

	funDelete(myImage);
	
	var tabObj		= document.getElementById("InnerBox1Tab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	if(rowItems>1){
		for(i=0;i<document.myForm.uploadFile.length;i++){
			if(myImage==document.myForm.uploadFile[i].value)
			myIndex=i;
		}
	}else{
		myIndex=0;
	}	
	var rowId = tabObj.deleteRow(myIndex);
	rowCountValue 	= rowItems.length;
	if(rowCountValue==0){
		var tabHeadDiv		= document.getElementById("theads")
		tabHeadDiv.style.visibility='hidden';
		var tabHeadDiv1		= document.getElementById("div8")
		tabHeadDiv1.style.visibility='visible';
		var tabHeadDiv2		= document.getElementById("div9")
		tabHeadDiv2.style.visibility='hidden';
		
		
		
	}
	
	
}

</script>	
</HEAD>
<BODY  onLoad='scrollInit();'  onresize="scrollInit();" scroll=no>
<FORM name=myForm method=post >
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
<% 
	String display_header="Image Upload"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br><br>
<Div id="theads" style="visibility:hidden;">
	<Table  width="80%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Th width="20%">Product</Th>
		<Th width="40%">Description</Th>
		<Th width="10%">UOM</Th> 
		<Th width="20%">Image Doc</Th>
		<Th width="10%">Delete</Th>
		
	</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

</Table>		
</Div>

<br><br><br><br>
<div id="div8" style="visibility:visible;position:absolute;left:0%;top:45%;width:100%">
	<table align="center">
		<Tr>
			<Td style="background:transparent" align='center'><b>* Attach Images to describe product in your catalog,<font color=blue>File Name must be Product Code.</font></Td>
		</Tr>
	</Table>
</div>
<div id="div9" style="visibility:hidden;position:absolute;left:0%;top:80%;width:100%">
	<table align="center">
		<Tr>
			<Td style="background:transparent" align='center'>* Attach Images to describe product in your catalog,<font color=blue>File Name must be Product Code.</font></Td>
		</Tr>
	</Table>
</div>
			
<div id="div7" style="visibility:visible;position:absolute;left:0%;top:85%;width:100%">
	<table align="center">
		<Tr>
			<Td style="background:transparent" align='center'>
	<%	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Attach");
		buttonMethod.add("funAttach()");
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
</Td>
		</Tr>
	</Table>
</div>
</FORM>
<Div id="MenuSol"></Div>
</BODY>

</HTML>   