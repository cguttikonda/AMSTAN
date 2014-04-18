<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>

<%@ include file="../../../Includes/JSPs/Catalog/iProductAttributesConfig.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iProductAttributes.jsp"%>
<%
	String productCode = productAttributesObj.getFieldValueString("EPA_PRODUCT_CODE");
	//out.println("productAttributesConObj::"+productAttributesConObj.toEzcString());
	//out.println("productAttributesObj::"+productAttributesObj.toEzcString());
%>

<script src="http://code.jquery.com/jquery-latest.js"></script>
  
<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">
	$(document).ready( function() 
	{		
		$(".fancybox").fancybox(
		{
			closeBtn:true	
		});
	});
	function close()
	{
		event.preventDefault();
		parent.$.fancybox.close();  
		$('saveForm').submit();

	}
</script>
</head>
<body>
<form name="saveForm" method='post'>
<a class="fancybox" href="#addAttribute">Add an Attribute</a>
<div id="addAttribute" style="display:none">
	Test....
</div>
<div>
<table width="100%">
	<tbody>
		<tr>
			<td valign="top" width="80%">
			<div>
				<fieldset>
				<legend>Product Code : <%=productCode%> </legend>
				<table >
					<tr>
						<td valign="top" width="60%">
						<div style=" width: 850px; height: 400px; z-index:10000; " >
						<fieldset>
						<legend>Product Attributes</legend>
						<table align="center" id="attributes">
						<thead>
							
							<tr>
								<th>Attribute Code</th>
								<th>Attribute Value</th>
								<th>Description</th>
							</tr>
						</thead>
						<tbody align="center">
<%
						for(int i=0;i<productAttributesObj.getRowCount();i++)
						{		
							String attrCode		= productAttributesObj.getFieldValueString(i,"EPA_ATTR_CODE");
							String attrValue	= productAttributesObj.getFieldValueString(i,"EPA_ATTR_VALUE");
							String attrDesc		= productAttributesObj.getFieldValueString(i,"EAC_DESC");
%>		
							<tr>
								<td><input type="text" name="attrCode" value="<%=attrCode%>"></td>
								<td><input type="text" name="attrValue" value="<%=attrValue%>"></td>
								<td><input type="text" name="attrDesc" value="<%=attrDesc%>"></td>
								<input type="hidden" name="productCode" id="productCode" value="<%=productCode%>">
							</tr>
<%
						}
%>						
						</tbody>
						</table>
						</fieldset>
						</div>
						</td>
					</tr>
				</table>
				</fieldset>
			</div>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>
</body>