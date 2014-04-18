<%@ include file="../../../Includes/JSPs/Categories/iCategoriesList.jsp"%>
<%
	String catStatus   = "";
	String catVisible  = "";
	String catImage    = "";
	String catThumb    = "";

%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main">
<div class="my-account">
<div class="dashboard">


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

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/colResizable-1.3.min.js"></script>
 


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
			"sDom": '<"H"Tfr>t<"F"ip>',
			"oTableTools": {
				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
				"aButtons": [
				{
				    "sExtends":    "csv",
				    "sButtonText": "Download CSV",
				    "sFileName": "Order List - *.csv"
				}
				]
			}

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
		onResize:onSampleResized});

});

</script>

<!-- jQuery for sorting & pagination ENDS here -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<h2 class="sub-title"></h2>

<script type="text/javascript">
	function funCheckBox()
	{
		var chkObj=document.myForm.catgID;
		if(document.myForm.categoryId.checked==true)
		{
			//alert(chkObj.length)
			if(isNaN(chkObj.length))
			 chkObj.checked=true;
			else
			{
				for(i=0;i<=chkObj.length;i++)
				chkObj[i].checked=true;
			 }
		}

		else
		{
			if(isNaN(chkObj.length))
			chkObj.checked=false;
			else
			{
				for(i=0;i<=chkObj.length;i++)
				chkObj[i].checked=false;
			}

		}
	}
	function funEdit()
	{
		var chkObj=document.myForm.catgID;
		var Count=0;
		if(!isNaN(chkObj.length))
		{
			for(i=0;i<chkObj.length;i++)
			{
				if(chkObj[i].checked)Count++;
			}

		 }
		if(Count==0)
		{
			alert("Please select a row to edit");
			return false;
		}
		if(Count>1)
		{
			alert("Please select only one row to edit");
			return false;
		}
		if(Count==1)
		{
			document.myForm.action="ezEditCategory.jsp";
			document.myForm.submit();
		}		
	}
	function funDelete()
	{
		var chkObj=document.myForm.catgID;
		var Count=0;
		if(!isNaN(chkObj.length))
		{
			for(i=0;i<chkObj.length;i++)
			{
				if(chkObj[i].checked)Count++;
			}

		 }
		if(Count==0)
		{
			alert("Please select atlest a row to delete");
			return false;
		}
		if(Count>=1)
		{
			var r=confirm("Do you want to delete?");
			if (r==true)
			  {
				//document.myForm.action="ezDeleteCategories.jsp";
				//document.myForm.submit();
			  }
			else
			{
				return false;
			}			
		}
	}	
</script>
<form name="myForm" method="post">
<input type="hidden" name="searchStat" value="Y">
<%
	if(cntRetCatgsList>0)
	{
%>
		<div class="col1-set" style="position:absolute;width:80%;left:10%">
		<div class="info-box"><br>

			<!-- <table class="display" id="example"> -->
			<table class="data-table" id="example" >
			<thead>
			<tr>
				<th width=4%><Input type="checkbox" name="categoryId" onclick="funCheckBox()"></th>
				<th width=20%>Category</th>
				<th width=20%>Category Parent</th>
				<th width=20%>Status</th>
				<th width=20%>Visibility</th>
				<th width=20%>Image</th>
				<th width=20%>Thumbnail</th>

			</tr>
			</thead>

			<tbody >
<%
			for(int i=0;i<cntRetCatgsList;i++)
			{
				catStatus=retCatgsList.getFieldValueString(i,"EC_STATUS");
				if(catStatus.equals("A"))catStatus="Active";
				if(catStatus.equals("I"))catStatus="Inactive";
				if(catStatus.equals("D"))catStatus="Deleted";
				
				catVisible=retCatgsList.getFieldValueString(i,"EC_VISIBLE");
				if(catVisible.equals("Y"))catVisible="Yes";
				if(catVisible.equals("N"))catVisible="No";
				
				catImage=retCatgsList.getFieldValueString(i,"EC_IMAGE");
				if(catImage==null || "null".equals(catImage) || "".equals(catImage))catImage="-";
				
				catThumb=retCatgsList.getFieldValueString(i,"EC_THUMB");
				if(catThumb==null || "null".equals(catThumb) || "".equals(catThumb))catThumb="-";
				
%>	
				<tr>
					<td width=5%><Input type="checkbox" name="catgID" value="<%=retCatgsList.getFieldValueString(i,"EC_CODE")%>¥<%=retCatgsList.getFieldValueString(i,"EC_PARENT")%>¥<%=catStatus%>¥<%=catVisible%>¥<%=catImage%>¥<%=catThumb%>"></td>
					<td width=20%>&nbsp;<%=retCatgsList.getFieldValueString(i,"EC_CODE")%></td>
					<td width=20%>&nbsp;<%=retCatgsList.getFieldValueString(i,"EC_PARENT")%></td>
					<td width=20%>&nbsp;<%=catStatus%></td>
					<td width=20%>&nbsp;<%=catVisible%></td>
					<td width=20%>&nbsp;<%=catImage%></td>
					<td width=20%>&nbsp;<%=catThumb%></td>
					
				</tr>
<%
			}
%>			
			</tbody>
			</table>
		</div>
		</div>
		<script>
		$("#it").click(function () {
		document.getElementById("");
		$("#display").toggle( "slow" );
		});
		</script>
<%
	}
	
%>
</form>
</div>
</div>
</div>
</div>
</div>
	<div align="center" style="position:absolute;width:45%;left:28%;top:84%">

		<a href="ezAddCategory.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>	
		<a href="JavaScript:funEdit()"><img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" border=none></a>
		<a href="JavaScript:funDelete()"><img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none></a>	
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
<%
	String status = request.getParameter("status");
	if ( status != null)
	{
		if(status.equals("D"))status="Deleted";
		if(status.equals("A"))status="Added";
		if(status.equals("U"))status="Updted";
%>
		<script language="JavaScript">
			alert('<%=status%> successfully');
		</script>
<%
	} //end if
%>	