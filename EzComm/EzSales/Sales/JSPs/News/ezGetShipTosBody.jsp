<%@ include file="../../../Includes/JSPs/News/iListConfigNews.jsp"%>
<jsp:useBean id="BPManager1" class="ezc.client.CEzBussPartnerManager" scope="session"></jsp:useBean>
<%
	String selSysKey	= request.getParameter("WebSysKey");
	//out.println("selSysKey:::::::::::::::::"+selSysKey);
	if("All".equals(selSysKey)) 
	{
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(i==0)
			{
				selSysKey="'"+ret.getFieldValueString(i,"ESKD_SYS_KEY")+"'";
			}
			else
			{
				selSysKey=selSysKey+",'"+ret.getFieldValueString(i,"ESKD_SYS_KEY")+"'";
			}
		}
	}
	ReturnObjFromRetrieve ret1 = null;
	if((selSysKey!=null))
	{
		EzcBussPartnerParams bparams = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
		bnkparams.setSys_key(selSysKey);
		//out.println("getSys_key::::::"+bnkparams.getSys_key());
		bnkparams.setLanguage("EN");
		bparams.setObject(bnkparams);
		Session.prepareParams(bparams);
		// Get Business Partners

		ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey","D");
		ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
		ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey","D");
	}	
	int rCount = ret1.getRowCount();
	//out.println("ret1:::::::::::::::::"+ret1.toEzcString());
	ret1.sort(new String[]{"EBPC_BUSS_PARTNER"},true);
%>
<html>
<head>
<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 

<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );

		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}

	$(document).ready( function() {
		fnFeaturesInit();
		$('#example').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bStateSave":true,
			"bSort" : true
			
		} );
 				


	} );
</script>


<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized
		
		
		});
	
	
});
</script>

<!-- jQuery for sorting & pagination ENDS here -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script src="../../Library/Script/popup.js"></Script> 
<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<Script>
function funSelectedSolto()
{
	var chkLen = document.myForm.chk.length
	var count=0
	var chkObj  ="";
	for(i=0;i<chkLen;i++)
	{
		if(document.myForm.chk[i].checked)
		{
			//alert(chkObj.length)	
			chkObj = (chkObj +(chkObj.length > 0 ? "*" : "") +funTrim(document.getElementById("cb_"+i).value));	
			count++;
		}	
	}
	if(count==0)
	{
		alert("No details are selected ")
		return;
	}	
	else
	{
		//alert(chkObj)
		opener.document.myForm.selectedShip.value=chkObj
		//alert(eval("opener.document.myForm.selectedShip"))
		self.close()
	}
}
function funClose()
{
	self.close()
}
</script>
</head>
<Style>
#change tr:hover {
    background-color: #ccc;
    cursor: pointer;
}    
</Style>
<body scroll="auto">
<form name=myForm method=post>
<div class="main-container col2-layout middle account-pages">
<div class="main" style="width:auto !important;">
<div class="col-main roundedCorners" style="width:680px !important; margin-left:30px;">
<%
	if ( rCount > 0 )
	{
%>
	<table class="data-table" >
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
			<h1>Select Ship To's to restrict the visibilty to particular ids</h1>
		</Th>
	</Tr>
	<Tr>
		<Td colspan=4><strong>List Of Users </strong></Td>
	</Tr>
	</table>
	<table class="data-table" id="example">
	<thead>
		<Th width="5%">&nbsp;</Td>
		<Th width="15%" align = "center">Ship To</Th>
		<Th width="68%" align = "center">Company  Name</Th>
	</thead>
	<tbody id="change">
<%
	for (int i = 0 ; i < rCount; i++)
	{
%>
		<Tr align="left">
			<Td width="5%" align=center>
				<input type="checkbox" name="chk" id="cb_<%=i%>" value="<%=ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")%>" >
			</Td>
			<Td width="15%">
				<%=ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")%>
			</Td>
			<Td width="68%" id="compName">
				<%=ret1.getFieldValueString(i,"ECA_COMPANY_NAME")%>
			</Td>
		</Tr>
<%
	}
%>
	</tbody>
	</Table>
	<br>
	<div class="buttons-set form-buttons">
		<button type="button" class="button" value="Save" title="Save" onClick="funSelectedSolto()" /><span>Ok</span></button>
		<button type="button" class="button" title="Close" value='Close' onClick="funClose()" /><span>Close</span></button>
	</div>
<%
	}
	else
	{
%>
		 <div class="block" style="padding-left:0px; width:100%;">
			<div class="block-title">
				<strong><span>NO Users to list</span></strong>
			</div>
		</div>
		<br>
		<div class="buttons-set form-buttons">
			<button type="button" class="button" title="Close" value='Close' onClick="funClose()" /><span>Close</span></button>
		</div>
<%
	}
%>
</div>
</div>
</div>
</form>
</body>
</html>