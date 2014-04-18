<%@ include file="../../../Includes/JSPs/News/iListNewsDash.jsp"%>
<%
	//out.println("newsValMapRetObj::::::::::::::::::::::"+newsValMapRetObj.toEzcString());
%>
<html>
<head>

<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<script src="../../Library/Script/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<style>
	a {color:#5D87A1; text-decoration:none}
	a:hover {color:#ccc; text-decoration:none}
</style>
<style type="text/css">
#myInstance1abc1 {
	border: 2px solid #6699ff !important;
}
.nicEdit-selected {
	border: 2px solid #6699ff !important;
}
.nicEdit-panel {
	background-color: #fff !important;
}
.nicEdit-button {
	background-color: #fff !important;
}
</style>

<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<!-- Style for New Header -->
<!-- end of style for new header -->
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">
	$(document).ready( function() 
	{		
		$(".fancybox").fancybox(
		{
			closeBtn:true	
		});
	});
	/*bkLib.onDomLoaded(function() {
		var myNicEditor = new nicEditor();
		myNicEditor.setPanel('myNicPanel');
		myNicEditor.addInstance('myInstance1abc1');
	});*/
	function chk1()
	{
		var str	= document.getElementById("myInstance1abc1").innerHTML
		var n=str.replace(/\<BR\>/g,"").replace(/&nbsp;/g,"").replace(/\<P\>\<BR\>\<\/P\>/g,"").replace(/\<P\>\<\/P\>/g,"").replace(/\<P\> \<\/P\>/g,"").replace(/^\s+|\s+$/g,"");;
		var dbText= document.myForm.newsText.value;

		document.myForm.newsText.value=n;
		if(n=="")
		{
			alert("Please enter comments before taking action on the document");
			return false;
		}	
		else
		{

			if(n.length>2000)
			{
				//alert(n.length)
				//alert(nicEditors.findEditor('myInstance1abc1').getContent());
				nicEditors.findEditor('myInstance1abc1').setContent(dbText);
				document.myForm.newsText.value=dbText;
				alert("Length exceeded")
				return false;
			}
		}
		return true;
	}
</script>
<script type="text/javascript">
function funHide(viewAuth)
{
	if(viewAuth=="I")
	{
		document.getElementById("selPart").removeAttribute("href")
		//document.getElementById("selPart1").removeAttribute("href")
		document.getElementById("selPart").style.color="grey"
		//document.getElementById("selPart1").style.color="grey"
	}
	else if(viewAuth=="E")
	{
		document.getElementById("selPart").href="javascript:funSelSoldto('STP')"
		//document.getElementById("selPart1").href="javascript:funSelSoldto('SHP')"
		document.getElementById("selPart").style.color="blue"
		//document.getElementById("selPart1").style.color="blue"
	}
	else if(viewAuth=="RA")
	{
		document.getElementById("selPart").href="javascript:funSelSoldto('RA')"
		//document.getElementById("selPart1").href="javascript:funSelSoldto('SHP')"
		document.getElementById("selPart").style.color="blue"
		//document.getElementById("selPart1").style.color="blue"
	}
	else if(viewAuth=="A")
	{
		document.getElementById("selPart").removeAttribute("href")
		//document.getElementById("selPart1").removeAttribute("href")
		document.getElementById("selPart").style.color="grey"
		//document.getElementById("selPart1").style.color="grey"
	}
}
function funSelSoldto(sel)
{
	var selSys
	var url
	var selSolds= document.myForm.selectedSol.value
	var checkVal = document.myForm.checkVal.value
	var valCheck = document.myForm.valCheck.value
	var chkAreas = document.myForm.chkAreas.value
	var chkAreasREP = document.myForm.chkAreasREP.value
	if(sel=='STP')
	{
		selSys	= document.myForm.WebSysKey.value;
		url	= "ezGetSoldTos.jsp?checkVal="+checkVal+"&chkAreas="+chkAreas;
	}
	if(sel=='RA')
	{
		selSys	= document.myForm.WebSysKey.value;
		url	= "ezRepUsers.jsp?valCheck="+valCheck+"&chkAreasREP="+chkAreasREP;
	}
	/*else
	{
		selSys	= document.myForm.WebSysKey.value;
		url	= "ezGetShipTos.jsp";
	}*/

	var hWnd = window.open(url,"UserWindow",'height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}
function doClear()
{
	document.getElementById("myForm").reset()
}
function createNews()
{
	var Desc 	= document.myForm.Desc.value;
	var newsText 	= document.myForm.newsText.value;
	var fromDate 	= document.myForm.fromDate.value;
	var toDate 	= document.myForm.toDate.value;
	var category 	= document.myForm.category.value;
	var viewAuth 	= document.myForm.viewAuth[0].value;

	if(Desc=="")
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Enter Description");
		document.myForm.Desc.focus();
		return false;
	}
	/*if(newsText=="")
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Enter News Text");
		document.myForm.newsText.focus();
		return false;
	}*/
	if(document.myForm.newsType[0].checked == false && document.myForm.newsType[1].checked == false && document.myForm.newsType[2].checked == false)
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Select News Type");
		return false;
	}
	if(fromDate=="")
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Select From Date");
		document.myForm.fromDate.focus();
		return false;
	}
	if(toDate=="")
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Select To Date");
		document.myForm.toDate.focus();
		return false;
	}
	if(category=="")
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Select Category");
		document.myForm.category.focus();
		return false;
	}
	if(document.myForm.viewAuth[0].checked == false && document.myForm.viewAuth[1].checked == false && document.myForm.viewAuth[2].checked == false && document.myForm.viewAuth[3].checked == false)
	{
		jQuery( "#dialog-alert" ).dialog('open').text("Please Select Visibility");
		return false;
	}
	
	Popup.showModal('modal');
	document.myForm.action="ezAddSaveNews.jsp";
	document.myForm.submit();
}
function ezGetSelected(type)
{
	document.myForm.newsFilter.value = type
	document.myForm.action="ezListNewsDash.jsp"
	document.myForm.submit()	

}
</script>

<!---START TINYMCE--->
<script type="text/javascript" src="tinymce_3.5/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
tinyMCE.init({
        // General options
        mode : "textareas",
        theme : "advanced",
        width : "100%",
        height:"250px",

        plugins : "autolink,lists,spellchecker,table,advhr,advimage,advlink,inlinepopups,media,searchreplace,contextmenu,paste,directionality,visualchars,nonbreaking,xhtmlxtras,template",
	
	// Theme options
	theme_advanced_buttons1 : "newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,|,ltr,rtl,removeformat",
	theme_advanced_buttons2 : "pasteword,|,hr,|,bullist,numlist,|,link,unlink,|,forecolor,backcolor,|,tablecontrols,|,sub,sup",
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        theme_advanced_statusbar_location : "bottom",
        //theme_advanced_resizing : true,

        // Skin options
        skin : "o2k7",
        skin_variant : "silver",

        // Example content CSS (should be your site CSS)
        content_css : "tinymce_3.5/examples/css/content.css",

        // Drop lists for link/image/media/template dialogs
        template_external_list_url : "tinymce_3.5/examples/lists/template_list.js",
        external_link_list_url : "tinymce_3.5/examples/lists/link_list.js",
        external_image_list_url : "tinymce_3.5/examples/lists/image_list.js",
        media_external_list_url : "tinymce_3.5/examples/lists/media_list.js",

        // Replace values for the template plugin
        template_replace_values : {
                username : "Some User",
                staffid : "991234"
        }
});
</script>
<!---END TINYMCE--->
<script>
function getAttachWindow()
{
	var attachedFiles="";
	var val=document.myForm.attachs.value
	if(val != "")
	{
		var arr=val.split('\n')
		for(var i=0;i<arr.length;i++)
		{
			if(arr[i] != "")
			{
				if(attachedFiles == "")
					attachedFiles = arr[i]
				else
					attachedFiles += "&attachedFiles="+arr[i];
			}
		}
	}
	var url = "ezNewsAttachment.jsp?attachedFiles="+attachedFiles;
	var hWnd = 	window.open(url,"UserWindow","width=600,height=325,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}
function doRemove()
{
	var count=0;
	//alert("attachs::::::::::::::::"+document.myForm.attachs.length)
	if(document.myForm.attachs.length==0)
	{
		alert("Currently no attachments in your list");
	}
	else
	{
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please select the files to remove");
		}
		else
		{
			var attachedFiles="";
			var toBeDelFiles="";
			if(document.myForm.attachs.length > 0)
			{
				attachedFiles=document.myForm.attachs.options[0].value
				if(document.myForm.attachs.options[0].selected)
					toBeDelFiles=document.myForm.attachs.options[0].value
			}
			for(var i=1;i<document.myForm.attachs.length;i++)
			{
				attachedFiles += "&allAttachedList="+document.myForm.attachs.options[i].value
				if(document.myForm.attachs.options[i].selected)
				{
					if(toBeDelFiles == "")
						toBeDelFiles = document.myForm.attachs.options[i].value
					else
						toBeDelFiles += "&toBeDelFiles="+document.myForm.attachs.options[i].value
				}
			}

			document.myForm.action="ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles+"&flag=N";
			document.myForm.submit();
		}
	}
}
function funOpenFile()
{
	var dbClickOnFlNm = document.myForm.attachs.value
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../News/ezViewFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");
	}	
}
</script>
<script type="text/javascript">
jQuery(function() {
 	jQuery( "#dialog-alert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				jQuery( this ).dialog( "close" );
			}
		}
	});
});
</script>
</head>
<body>
<div class="block" style="padding: 0px !important;">
	<div class="block-title"><strong><span>Configure News</span></strong></div>
</div>
<form name="myForm" id="myForm" method="post">
<div id="dialog-alert" title="Alert">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please fill out this field.</p>
</div>
<div class="col1-set">
<div class="info-box"><br>
<input type="hidden" name="selectedSol">
<input type="hidden" name="checkSolds">
<input type="hidden" name="checkAreas">
<input type="hidden" name="selectedShip">
<input type="hidden" name="attachString">
<input type="hidden" name="attachflag">
<input type="hidden" name="checkVal" value="NS">
<input type="hidden" name="valCheck" value="RAS">
<input type="hidden" name="chkAreas" value="">
<input type="hidden" name="chkAreasREP" value="">
<input type="hidden" name="chks" value="N">
<input type="hidden" name="WebSysKey" value="<%=session.getValue("SalesAreaCode")%>">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<table class="data-table">
	<Tr>
		<Th colspan=2 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1>Enter News Information</h1>
		</Th>
    	</Tr>
    	<Tr>
		<Td>
			<strong>Description<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<input type="text" name="Desc" size=30 maxlength="100" required>
		</Td>
    	</Tr> 
	<Tr>
		<Td>
			<strong>News Text<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<!--<div id="myNicPanel" style="width: 400px;"></div>
			<div id="myInstance1abc1" style="font-size: 12px;background-color: #FFFFFF;height:100px;padding: 3px; width: 99%;border:solid;overflow:auto"></div>
			<input type="hidden" value="" name="newsText">-->
			<textarea name="newsText"></textarea>
		</Td>
    	</Tr>     	
	<Tr>
		<Td>
			<strong>News Type<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<input type="radio" name="newsType" value="I"  required>&nbsp;Information&nbsp;&nbsp;
			<input type="radio" name="newsType" value="T"  required>&nbsp;Tracking&nbsp;&nbsp;
			<input type="radio" name="newsType" value="TA" required>&nbsp;Track & Acknowledge&nbsp;&nbsp;
		</Td>
    	</Tr>
	<Tr>
		<Td>
			<strong>Valid From<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<input type="text" id="fromDate" name="fromDate" size="12" value="" readonly required><%=getDateImage("fromDate")%>
		</Td>
    	</Tr>
	<Tr>
		<Td>
			<strong>Valid To<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<input type="text" id="toDate" name="toDate" size="12" value="" readonly required><%=getDateImage("toDate")%>
		</Td>
    	</Tr>
    	<Tr>
		<Td>
			<strong>Category<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<div class="input-box">
			<select name="category" id="category" required>
				<option value='' >---Select---</option>
<%
			for(int n=0;n<newsValMapRetObj.getRowCount();n++)
			{
				String categoryS	= newsValMapRetObj.getFieldValueString(n,"VALUE2");
				String categoryOp	= newsValMapRetObj.getFieldValueString(n,"VALUE1");
		
				boolean showOption = false;
				if("PL".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PL_NEWS"))
					showOption = true;
				if("PRODSPEC".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PSPEC_NEWS"))
					showOption = true;
				if("PS".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PS_NEWS"))
					showOption = true;											
				if("NP".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_NPROD_NEWS"))
					showOption = true;				
				if("DP".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_DC_NEWS"))		
					showOption = true;				
				if("PCA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PCHNG_NEWS"))
					showOption = true;				
				if("PA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PROMO_NEWS"))
					showOption = true;			
				if("SLOB".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_SLOB_NEWS"))							
					showOption = true;
				if("GA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_GA_NEWS"))							
					showOption = true;
				
				if(showOption)
				{
%>			
					<option value='<%=categoryOp%>'><%=categoryS%></option>
<%
				}
			}
%>
			</select>
			</div>
		</Td>
    	</Tr>
	<Tr>
		<Th colspan=2 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1>Authorizations</h1>
		</Th>
    	</Tr>
    	<Tr>
		<Td>
			<strong>Visible<em style="color:red">*</em></strong>
		</Td>
		<Td>
			<input type="radio" name="viewAuth" value='I' onClick="funHide('I')" required>&nbsp;Internal&nbsp;&nbsp;
			<input type="radio" name="viewAuth" value='E' onClick="funHide('E')" required>&nbsp;External&nbsp;&nbsp;
			<input type="radio" name="viewAuth" value='RA' onClick="funHide('RA')" required>&nbsp;Rep Agency&nbsp;&nbsp;
			<input type="radio" name="viewAuth" value='A' onClick="funHide('A')" required>&nbsp;All&nbsp;&nbsp;
		</Td>
    	</Tr>
	<Tr>
		<Td>
			<strong>Customers</strong>
		</Td>
		<Td>
			<a id ="selPart">Customers</a>
		</Td>
    	</Tr>
	<!--<Tr>
		<Td>
			<strong>Ship To</strong>
		</Td>
		<Td>
			<a href="javascript:funSelSoldto('SHP')" id ="selPart1">ShipTo</a>
		</Td>
    	</Tr>-->
    	<Tr>
		<Td>
			<strong>Attachments</strong>
		</Td>
		<Td>
			<a class="fancybox" href="#ATTACHFILES">
				<button type="button" class="button btn-update"><span>Attach Docs</span></button>
			</a>
		</Td>
	</Tr>
</Table>
<br>
<div class="buttons-set form-buttons">
	<button type="button" class="button" value="Publish" title="Publish" onClick="createNews()"/><span>Publish</span></button>
	
	<button type="button" class="button" title="Clear" value='Clear' onClick="doClear()" /><span>Clear</span></button>
</div>	
<div id="ATTACHFILES" style="width: 100%; display:none">
	<iframe id="AttachFiles" src="ezAttachFile.jsp?actType=NEWS" width="500" height="380" scrolling="no"></iframe>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="col-left sidebar roundedCorners" style="width:209px !important">
	<div class="block">
	<div class="block-title"><strong><span>News</span></strong></div>
	<div class="block-content">
	<ul>
		<li class="current"><Strong>Configure News</Strong></li>
		<li><a href="ezListConfigNews.jsp">News List</a></li>
	</ul>
	</div>
	</div>
</div>
</div>
</div>
</form>
</body>
</html>