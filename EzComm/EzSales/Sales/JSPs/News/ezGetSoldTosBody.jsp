<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ include file="../../../Includes/JSPs/News/iGetSoldTOs.jsp"%>
<%@ page import="java.util.*"%>
<%
	//out.print("soldTOsListObj::::::::::::::::::::"+soldTOsListObj.toEzcString());
	//out.print("salesAreaListObj::::::::::::::::::::"+salesAreaListObj.toEzcString());
	int soldTOsListObjCount = soldTOsListObj.getRowCount();
	int salesAreaListObjCount = salesAreaListObj.getRowCount();
	String checkVals	= request.getParameter("checkVal");
	List soldTosList =null;
	Vector soldVect = new Vector();
	
	if(!"".equals(checkVals)&&!"null".equals(checkVals)&& checkVals != null)
	{		
		//out.print("checkVals***"+checkVals);
		String[] chkSold	= checkVals.split("¥");
		soldTosList =  Arrays.asList(chkSold); 
		Iterator itr = soldTosList.iterator();
		while(itr.hasNext()) {
			 soldVect.add(itr.next()+"");
			
		}
		//out.print("soldVect"+soldVect);
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
</style>


<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<script type="text/javascript">
function replaceAll(txt, replace, with_this) {
  return txt.replace(new RegExp(replace, 'g'),with_this);

}
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
				//alert(sData);
				
				sData = sData+"";
				//sData = sData.replace("chk=","");
				sData = replaceAll(sData,"chk=","")
				sData = replaceAll(sData,"&","¥")
				//alert(sData);
				window.opener.myForm.checkVal.value=sData;
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
function searchAreas()
{
	var temp = ""; 
	var multipleValues = $("#salesArea").val() || [];
	for(var i=0;i<multipleValues.length;i++)
	{
		temp +=	multipleValues[i]+"¥";
	}
	window.opener.myForm.chkAreas.value =temp;
	var checkVal = document.myForm.checkVal.value;
	document.myForm.action="ezGetSoldTos.jsp?checkVal="+checkVal;
	document.myForm.submit();
}
function loadSalesArea()
{
	var parentVal = window.opener.myForm.chkAreas.value;
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
</script>

<!-- jQuery for sorting & pagination ENDS here -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<Script src="../../Library/Script/popup.js"></Script>

<script type="text/javascript" src="../../Library/Script/jquery.multiselect.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery.multiselect.css">

<Script>
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
	//chParent.value = sData;
	self.close();
}
</script>
</head>
<Style>
#change tr:hover {
    background-color: #ccc;
    cursor: pointer;
}    
</Style>
<body scroll="auto" onLoad="loadSalesArea();">
<form name=myForm method=post >
<input type="hidden" name="checkVal" value=<%=checkVals%>>
<div class="main-container col2-layout middle account-pages">
<div class="main" style="width:auto !important;">
<div class="col-main roundedCorners" style="width:680px !important; margin-left:30px;">
<div align="center">
<table>
	<Tr>
		<Td>
			<select name="salesArea" id="salesArea" multiple="multiple">
<%	
		String testArr[] = request.getParameterValues("salesArea");
		if(testArr != null)
		{
			out.print("salesArea"+testArr.length);
			out.print("salesArea"+testArr[0]);
		}
		
		int k=0;
		String salesAVal="";
		String sysKey="";
		for(int i=0;i<salesAreaListObjCount;i++)
		{
				if(k != 3)
				{
					salesAVal+=salesAreaListObj.getFieldValueString(i,"ECAD_VALUE");
					if(k!=2)
					{
						salesAVal+="-";
						sysKey	=	salesAreaListObj.getFieldValueString(i,"ECAD_SYS_KEY");
					}
				}
				else
				{
%>
					<option value="<%=sysKey%>" >&nbsp;Sales Area:<%=salesAVal%></option>
<%
					salesAVal = "";
					salesAVal+=salesAreaListObj.getFieldValueString(i,"ECAD_VALUE")+"-";
					k=0;
				}
				k++;
		}
%>
			<option value="<%=sysKey%>">&nbsp;Sales Area:<%=salesAVal%></option>
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

<%
	if ( soldTOsListObjCount> 0 )
	{
%>	
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
		<Th>Sold To</Th>
		<Th>Name</Th>
		<Th>City</Th>
		<Th>Region</Th>
	</thead>
	<tbody id="change">
<%
	for (int i = 0 ; i< soldTOsListObjCount; i++)
	{
		String chkFlg 	= "";
		String sold	= soldTOsListObj.getFieldValueString(i,"EC_ERP_CUST_NO");
		String name	= soldTOsListObj.getFieldValueString(i,"ECA_NAME");
		String city	= soldTOsListObj.getFieldValueString(i,"ECA_CITY");
		String region	= soldTOsListObj.getFieldValueString(i,"ECA_STATE");
		if(soldVect.contains(sold))
			chkFlg 	= "checked";
%>
		<Tr>
			<Td><input type="checkbox" class="Check_box" name="chk" id="cb_<%=i%>" value="<%=sold%>" <%=chkFlg%>></Td>
			<Td><%=sold%></Td>
			<Td><%=name%></Td>
			<Td><%=city%></Td>
			<Td><%=region%></Td>
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
