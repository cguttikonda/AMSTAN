<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*,java.util.*" %>
<%@ include file="../../../Includes/JSPs/News/iRepUsers.jsp"%>
<%
	//out.print("repUsersObj::::::::::::::::::::"+repUsersObj.toEzcString());
	int repUsersObjCount = repUsersObj.getRowCount();
	String checkVals	= request.getParameter("valCheck");
	List soldTosList =null;
	Vector soldVect = new Vector();

	if(!"".equals(checkVals)&&!"null".equals(checkVals)&& checkVals != null)
	{		
		String[] chkSold	= checkVals.split("¥");
		soldTosList =  Arrays.asList(chkSold); 
		Iterator itr = soldTosList.iterator();
		while(itr.hasNext()) {
			soldVect.add(itr.next()+"");
		}
	}

%>
<%!
	public ReturnObjFromRetrieve getValueMapByKey(String mapType,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc = null;

		if(mapType!=null && !"null".equalsIgnoreCase(mapType) && !"".equals(mapType))
		{
			ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
			ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
			ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
			miscParams.setIdenKey("MISC_SELECT");
			String query="SELECT * FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='"+mapType+"'";

			miscParams.setQuery(query);
			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
				retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
			}
		}
		return retObjMisc;
	}
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

	#change tr:hover {
    		background-color: #ccc;
    		cursor: pointer;
	}    
</Style>

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
	var  oTable = $('#example').dataTable()
		$('#save').click(function(){
			var sData = oTable.$('input').serialize();
			sData = sData+"";
			sData = replaceAll(sData,"chk=","")
			sData = replaceAll(sData,"&","¥")
			window.opener.myForm.valCheck.value=sData;
			if(sData == 0)
			{
				alert( "No details are selected" );
			}
			else
			{
				window.opener.myForm.checkSolds.value = sData;
				funClose();
			}
		});
	$('#checkall').click( function() {
	    $('input', oTable.fnGetNodes()).attr('checked',this.checked);
	} );
	 $("#salesArea").multiselect();
   });
		
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

<script type="text/javascript">
function replaceAll(txt, replace, with_this) {
	return txt.replace(new RegExp(replace, 'g'),with_this);
}
function searchAreas()
{
	var temp = ""; 
	var multipleValues = $("#salesArea").val() || [];
	for(var i=0;i<multipleValues.length;i++)
	{
		temp +=	multipleValues[i]+"¥";
	}
	window.opener.myForm.chkAreasREP.value =temp;
	var valCheck = document.myForm.valCheck.value;
	document.myForm.action="ezRepUsers.jsp?valCheck="+valCheck;
	document.myForm.submit();
}
function loadSalesArea()
{
	var parentVal = window.opener.myForm.chkAreasREP.value;
	var multipleValues = document.myForm.salesArea;
	var splitVal = parentVal.split("¥");
	
	for(var i=0;i<multipleValues.length;i++)
	{	
		for(var j=0;j<splitVal.length-1;j++)
		{
			if(multipleValues[i].value==splitVal[j])
			{
				$('#ui-multiselect-salesArea-option-'+i).prop('checked', 'true');
			}
		}
	}
	
}
function funClose()
{
	var chChild	= document.myForm.chk;
	var chParent	= window.opener.myForm.checkVal;
	var temp = "";
	for(var i=0;i<chChild.length;i++)
	{
		if(chChild[i].checked == true)
			temp += "Y¥";
		else
			temp += "N¥";
	}
	self.close();
}
</script>

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<Script src="../../Library/Script/popup.js"></Script>

<!----Multiple select box start--->
<script type="text/javascript" src="../../Library/Script/jquery.multiselect1.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery.multiselect.css">
<!----Multiple select box end--->

</head>
<body scroll="auto" onLoad="loadSalesArea();">
<form name=myForm method=post >
<input type="hidden" name="valCheck" value=<%=checkVals%>>
<div class="main-container col2-layout middle account-pages">
<div class="main" style="width:auto !important;">
<div class="col-main roundedCorners" style="width:680px !important; margin-left:30px;">
<div align="center">
<table>
	<Tr>
		<Td>
			<select name="salesArea" id="salesArea" multiple="multiple">
<%	
				ReturnObjFromRetrieve repAgencyList = (ReturnObjFromRetrieve)getValueMapByKey("REPAGENCYCODES",Session);
				if(repAgencyList!=null && repAgencyList.getRowCount()>0)
				{
					for(int ra=0;ra<repAgencyList.getRowCount();ra++)
					{
						String repCode = repAgencyList.getFieldValueString(ra,"VALUE1");
						String repName = repAgencyList.getFieldValueString(ra,"VALUE2");
%>
						<option value="<%=repCode%>">&nbsp;<%=repName%> (<%=repCode%>)</option>
<%
					}
				}
%>
			</select>
		</Td>
		<Td>
			<div class="buttons-set form-buttons">
				<button type="button" class="button" value="Search" title="Search" id="Search" name="Search" onclick="searchAreas();"/><span>Search</span></button>
			</div>
		</Td>
	</Tr>
</table>
</div>

	<table class="data-table" >
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1>Select Sold To's to restrict the visibilty to particular ids</h1>
		</Th>
	</Tr>
	<Tr>
		<Td colspan=4><strong>List Of Users </strong></Td>
	</Tr>
	</table>
	<table class="data-table" id="example">
	<thead>
		<Th><input type="checkbox" name="checkall" id="checkall"></Td>
		<Th>User Id</Th>
		<Th>First Name</Th>
		<Th>Last Name</Th>
	</thead>
	<tbody id="change">
<%
	for (int i = 0 ; i< repUsersObjCount; i++)
	{
		String chkFlg 	= "";
		String userID	= repUsersObj.getFieldValueString(i,"EU_ID");
		userID	 = userID.trim();
		String fname	= repUsersObj.getFieldValueString(i,"EU_FIRST_NAME");
		String lname	= repUsersObj.getFieldValueString(i,"EU_LAST_NAME");
		if(soldVect.contains(userID))
			chkFlg 	= "checked";
%>
		<Tr>
			<Td><input type="checkbox" class="Check_box" name="chk" id="cb_<%=i%>" value="<%=userID%>" <%=chkFlg%>></Td>
			<Td><%=userID%></Td>
			<Td><%=fname%></Td>
			<Td><%=lname%></Td>
		</Tr>
<%
	}
%>
	</tbody>
	</Table>
	<br>
	<div class="buttons-set form-buttons">
		<button type="button" class="button" value="Save" title="Save"  id="save" name="save" /><span>Save</span></button>
		<button type="button" class="button" title="Close" value='Close' onClick="funClose()" /><span>Clear</span></button>
	</div>

</div>
</div>
</div>
</form>
</body>
</html>
