<%@ include file="ezATPInputs.jsp"%>

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes quotetable in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<STYLE type="text/css">
	.expanded-group{
		background: url("../../Library/images/details_close.png") no-repeat scroll left center transparent;
		padding-left: 15px !important
	}

	.collapsed-group{
		background: url("../../Library/images/details_open.png") no-repeat scroll left center transparent;
		padding-left: 15px !important
	}
</STYLE>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script>  
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script>

<script type="text/javascript" src="../../Library/Script/jquery.dataTables.rowGrouping1.js"></script>
<SCRIPT type="text/javascript" charset="utf-8">
$(document).ready( function () 
{	
	$('#example').dataTable({ 

	"bJQueryUI": true,
	"bPaginate": false,		
	"bSort" : false,
	"bStateSave":true,

	"aoColumnDefs": [ 
			      { "bVisible": false, "aTargets": [ 1,2] }
	    ],
	"sDom": '<"H"Tfr>t<"F"ip>',		
	"oTableTools": {
	"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
	"sInfo":"Use Browser Print and press Esc. When done",
	"aButtons": [
			{
			    "sExtends":    "csv",
			    "sButtonText": "Download CSV",
			    "sFileName" : "NetworkATP.csv",
			    "mColumns": [ 1, 2, 3,4 ]
			}
		]
	}

	}).rowGrouping({bExpandableGrouping: true});
} );

</script>

<%
	if(prdsLen>0)
	{
		for(int i=0;i<prdsLen;i++)
		{
			String prodCodes = selectedPrdsSplitArr[i].split("¥")[0];
			String prodQty   = selectedPrdsSplitArr[i].split("¥")[1];

			atpQtyPrdRet.setFieldValue("PROCODES",prodCodes);
			atpQtyPrdRet.setFieldValue("ORD_QTY","9999999");	
			atpQtyPrdRet.addRow();
		}
	}
	
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","PLANTDESC","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	stAtpStr= "*";
	atpSTP	= "";
	atpSHP	= "";
	
	/************ Setting inputs to FM ***********************/
	
	atpInputsRet.setFieldValue("SALESORG",atpSOr);
	atpInputsRet.setFieldValue("DIST_CHANNEL",atpDtc);	
	atpInputsRet.setFieldValue("DIVISON",atpDiv);
	atpInputsRet.setFieldValue("SOLDTO",atpSTP);	
	atpInputsRet.setFieldValue("SHIPTO",atpSHP);
	atpInputsRet.setFieldValue("REGION",stAtpStr);	
	atpInputsRet.addRow();
	
	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);

	/********************End******************************/	

	if(atpForStr!=null && !"null".equals(atpForStr) && !"".equals(atpForStr))
	{				
%>
	<%@ include file="ezATPJCO.jsp"%>
<%
	}		
%>

<h2><%=pageTitle%></h2> 	
</div>

	<table class="display" id="example" border="0">
	<thead>
	<tr width='90%'>
		
		<td width=50%>Material </td>
		<td width=10%>Code</td>
		<td width=10%>Desc </td>
		<td width=30%>Plant</td>		
		<td width=20%>Current Availability</td>						
	</tr>
	</thead>
	<tbody>
	
<%	
		String notInclude	= "Not Include in Your Portfolio or Default Ship-To Account";
		Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");

		ArrayList totAL = new ArrayList();
		double sumMat = 0;
		String dummyMat ="";
		int indx = 0;

		ReturnObjFromRetrieve retAtpLocalDB = null;
		if(prodCodeStr!=null && !"".equals(prodCodeStr))
		{
			EzcParams mainParamsAtp = new EzcParams(false);
			EziMiscParams miscParamsAtp = new EziMiscParams();

			String query="SELECT EZP_PRODUCT_CODE,EZP_PROD_ATTRS,EZP_SALES_ORG FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+prodCodeStr+"')";
			miscParamsAtp.setQuery(query);
			miscParamsAtp.setIdenKey("MISC_SELECT");

			mainParamsAtp.setLocalStore("Y");
			mainParamsAtp.setObject(miscParamsAtp);
			Session.prepareParams(mainParamsAtp);

			try
			{
				retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
			}
			catch(Exception e){}
		}

		for(int a=0;a<atpResultRet.getRowCount();a++)
		{
			String atpRetMat   = nullCheck(atpResultRet.getFieldValueString(a,"MATERIAL"),"");

			String prod_Attr   = "";
			String matSalesOrg = "";

			if(retAtpLocalDB.find("EZP_PRODUCT_CODE",atpRetMat))
			{
				int row = retAtpLocalDB.getRowId("EZP_PRODUCT_CODE",atpRetMat);

				prod_Attr = nullCheck(retAtpLocalDB.getFieldValueString(row,"EZP_PROD_ATTRS"),"");
				matSalesOrg = nullCheck(retAtpLocalDB.getFieldValueString(row,"EZP_SALES_ORG"),"");
			}

			boolean mat = false;
			indx++; 
			if(atpRetMat!=null && !"null".equals(atpRetMat) && !"".equals(atpRetMat))
			{
				if(!totAL.contains(atpRetMat) || indx==atpResultRet.getRowCount())
				{
					totAL.add(atpRetMat);
					dummyMat = sumMat+"";
					sumMat = 0;
					if(a!=0)
					{
						mat = true;
					}
				}
			}
			
			String atpRetQty   = atpResultRet.getFieldValueString(a,"AVAILQTY");
			String atpPlant    = nullCheck(atpResultRet.getFieldValueString(a,"PLANT"),"");
			String plantDes    = nullCheck(atpResultRet.getFieldValueString(a,"PLANTDESC"),"");		
			String atpMatDesc  = nullCheck(atpResultRet.getFieldValueString(a,"MATERIALDESC"),"");

			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

			String atpReqQty="",atpAvail="",listPrice="",points="",kitCombo="",prodStatus="",luxury="";

			boolean prdAllowed = true;
			boolean quaShows = true;
			String custAttr ="";
			if(!"2".equals(userTyp))
			{
				try
				{
					custAttr	= (String)custAttrsHT.get(matSalesOrg);
					prdAllowed	= checkAttributes(prod_Attr,custAttr);
				}
				catch(Exception e){}
			}
			
			if(prdAllowed)
			{
				if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
				{
					atpRetQty=eliminateDecimals(atpRetQty);
				}
			}
			else
			{
				quaShows = false;
			}
%>
			<tr>
				<td width=50%><p style="margin-left:5px"><%=atpRetMat%>, <%=atpMatDesc%></p></td>
				<td width=10%><p style="margin-left:5px"><%=atpRetMat%></p></td>
				<td width=10%><p style="margin-left:5px"><%=atpMatDesc%></p></td>
				<td width=30%><p><%=atpPlant%>, <%=plantDes%></p></td>		
				<td width=20%><p><%if(quaShows){%><%=atpRetQty%><%}else{%><%=notInclude%><%}%></p></td>
			</tr>
		
<%		
			if(!true)
			{														
%>		
				<tr>
					<td width=25% colspan=3>&nbsp;</td>	
					<td width=10%>TOTAL : </td>			
					<td width=10%><p><%=eliminateDecimals(dummyMat)%></p></td>

				</tr>

<%@ include file="ezATPGA.jsp"%>
<%		
			}						
		}
%>
	</tbody>
	</table>