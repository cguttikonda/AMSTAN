<html>
<%
     String type = request.getParameter("type");
     String prdCode = request.getParameter("prdCode");
     String vendCatalog = request.getParameter("vendCatalog");
     
     String dispStr="";
     
     if("I".equals(type))
     	  dispStr="Image";
     else
          dispStr="Specification";
          
%>

<head><title>Attachment</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

	<script>
	var req;
	var parentObj="";
	var docObj="";
        var type="<%=type%>";
        var prdCode="<%=prdCode%>";
        var vendCatalog="<%=vendCatalog%>";
        
        var attachfile="";
        var dirName="";
        
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
		attach=window.open("ezBulkImageAttach.jsp?index="+i,"UserWindow2","width=350,height=450,left=300,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	}

	function funLoad()
	{
		var uploadFileObj=docObj.myForm.uploadFile;
		if(uploadFileObj!=null){
			var len=uploadFileObj.length
			if(isNaN(len)){
				var newOpt = document.createElement("OPTION")
				newOpt.value=uploadFileObj.value
				newOpt.text=uploadFileObj.value
				document.myForm.attachs.add(newOpt)
			}else{
				for(i=0;i<len;i++){
					var newOpt = document.createElement("OPTION")	
					newOpt.value=uploadFileObj[i].value
					newOpt.text=uploadFileObj[i].value
					document.myForm.attachs.add(newOpt)
				}
			}
		}
		/*var len=docObj.myForm.attachs.length
		for(i=0;i<len;i++)
		{
			var newOpt = document.createElement("OPTION")
			newOpt.value=parentObj.attachs.options[i].value
			newOpt.text=parentObj.attachs.options[i].value
			document.myForm.attachs.add(newOpt)
		}*/
	}


	function addLine(prodInfo,fileName)
	{


			var tabHeadDiv1		= docObj.getElementById("div8")
			tabHeadDiv1.style.visibility='hidden';
			var tabHeadDiv2		= docObj.getElementById("div9")
			tabHeadDiv2.style.visibility='visible';

			var tabHeadDiv		= docObj.getElementById("theads")
			tabHeadDiv.style.visibility='visible';
			var tabObj		= docObj.getElementById("InnerBox1Tab")
			var rowItems 		= tabObj.getElementsByTagName("tr");
			var rowCountValue 	= rowItems.length;

			eleWidth = new Array();
			eleAlign = new Array();
			eleVal   = new Array();

			eleWidth[0]  = "20%";	eleAlign[0] = "center";
			eleWidth[1]  = "40%";	eleAlign[1] = "left";
			eleWidth[2]  = "10%";	eleAlign[2] = "center";
			eleWidth[3]  = "20%";	eleAlign[3] = "left";
			eleWidth[4]  = "10%";	eleAlign[4] = "center";


			var myArray=prodInfo.split("$$");

			eleVal[0] =myArray[0];
			eleVal[1] =myArray[1];
			eleVal[2] =myArray[2];
			eleVal[3] ='<input type="text" name="uploadFile" class="tx" value="'+fileName+'" readonly>';
			eleVal[4] ='<img src="../../Images/Common/Delete.gif" style="cursor:hand" border=0 onClick="deleteImage(\''+fileName+'\','+rowCountValue+')">';


			var rowId = tabObj.insertRow(rowCountValue);
			for(c=0; c<eleVal.length;c++){

				var cell0=rowId.insertCell(c);
				cell0.width = eleWidth[c];
				cell0.align = eleAlign[c];
				cell0.innerHTML =eleVal[c];
			}


	}
        function Initialize()
       	{
       	
       		try
       		{
       			req=new ActiveXObject("Msxml2.XMLHTTP");
       		}
       		catch(e)
       		{
       			try
       			{
       				req=new ActiveXObject("Microsoft.XMLHTTP");
       			}
       			catch(oc)
       			{
       				req=null;
       			}
       		} 
       		if(!req&&typeof XMLHttpRequest!="undefined")
       		{
       			req=new XMLHttpRequest();
       		}
	 }
	function SendQuery(type,attach,dir)
	{
		Initialize();
		var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Uploads/ezSaveMaterialDocs.jsp?type="+type+"&attachFile="+attach+"&prdCode="+prdCode+"&vendCatalog="+vendCatalog+"&dirName="+dir;
                
                if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);

		}
	}
	function Process()
	{
                  
		if (req.readyState == 4)
		{
		   if (req.status == 200)
		   {
				window.close();
		   }
		}
	}	
	function funDone()
	{
		var windClose=true; 

		try{
			windClose=attach.closed;
		}catch(err){}


		if(windClose)
		{
			for(var i=0;i<document.myForm.n1.length;i++)
			{
				if(document.myForm.n1[i].value!=""){
					if(window.navigator.appName =="Microsoft Internet Explorer")
					{
						var myData=document.myForm.docInfo[i].value
						addLine(myData,document.myForm.n1[i].value);		
					}
					else
					{
						parentObj.attachs.options[len]=new Option(document.myForm.n1[i].value,document.myForm.n1[i].value);
					}
				}

			}

			window.close();
		}	
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
	
	function funClose(){
	   attachfile = document.myForm.n1.value;
	   dirName    = document.myForm.dirName.value; 
	   SendQuery(type,attachfile,dirName);
	}
</script>
</head>

<body scroll=no>
<form name="myForm">
<table width="90%">
<tr><td><b>Attach Files</b></td>
<tr><td class="blankcell"><hr></td>
<tr><td class="blankcell">1.Click on 'Attach File' Button to attach files.</td>
</tr></table>
<table width="80%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	int myAttachCount=1;
	for(int i=0;i<myAttachCount;i++){
%>
	<tr>
		<th colspan=3 align="left"><%=(i+1)%>.<%=dispStr%> Document</th>
		</tr>
		<tr>
		<td align="left">
		<input type=text size="25" class=tx  value="" name="n1"></td>
		<input type="hidden" name="dirName" >
		<input type="hidden" name="docInfo">
		<td align="center">

<%	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Attach File");
		buttonMethod.add("funAttach("+i+")");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</td>
	</tr>
<%
	}
%>

</table>

<table width="90%">
<tr><td class="blankcell"><hr></td>
<tr><td class="blankcell">2.Click on 'Done' Button after all the required files attached .</td>
<tr><td class="blankcell">
	
<%	
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("funClose()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</td>
<tr><td class="blankcell"><hr></td>
</tr>
</table>
<Div style="visibility:hidden">
<select name="attachs">
</select>
</Div>
<input type="hidden" name="shipupload" value="<%=request.getParameter("filestring")%>" >
</form>
</body>
</html>
