<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<Html>
<Head>

<title>Create Sales Order -- Powered by EzCommerce Inc</title>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
  var tabHeadWidth=80
  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<Body  onLoad='scrollInit();'  onresize="scrollInit();" scroll=no>
<Form name="myForm" ENCTYPE="multipart/form-data" method="post">
<%
	String display_header = "Maintain Vendor Catalogs";	
	
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Table width=40% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<Tr>
	<Th width =20% class="labelcell" align="center" colspan=3>Upload File</th>
	<Td width =80% nowrap colspan=3 align="center">
	<input name="path" class=inputbox type="file" style="width:100%">
	</Td>
</Tr>	
</Form>
</Body>
</Html>