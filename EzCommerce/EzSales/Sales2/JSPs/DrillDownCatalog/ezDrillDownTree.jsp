
<html>
<head>	
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<style>
		div{
			Scrollbar-3dlight-color:#d5f1ff;
			Scrollbar-arrow-color:#000000;
			Scrollbar-base-color:#d5f1ff;
			Scrollbar-darkshadow-color:#d5f1ff;
			Scrollbar-highlight-color:#d5f1ff;
			Scrollbar-shadow-color:#000000;
			Scrollbar-Track-Color :f5f5f5
		}
	</style>	
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXTree.css">
	<Script src="../../Library/JavaScript/Tree/dhtmlXCommon.js"></Script>
	<Script src="../../Library/JavaScript/Tree/dhtmlXTree.js"></Script>
	<script>
	function onNodeSelect(id)
	{
		/*
			CatalogDescription
			ProductGroup
			GroupLevel
			GroupDesc
		*/
		if(id!='NODATA'){
			//parent.document.getElementById("gridFrame").src="ezCatalogFinalLevel.jsp?id="+id+"&CatalogDescription=MTucker Catalog"+"&ProductGroup=00001"+"&GroupLevel=1"+"&GroupDesc=Tabletop";
			parent.document.getElementById("gridFrame").src="ezCatalogFinalLevel.jsp?id="+id+"&alertStr=S";
		}	
	}
	
	function doOnLoad()
	{
		
		tree=new dhtmlXTreeObject("TreeBox","100%","100%",0);
		tree.setImagePath("../../Images/ImagesTree/");
		tree.setXMLAutoLoading("ezDrillDownTreeData.jsp");
		tree.loadXML("ezDrillDownTreeData.jsp?id=0");		
		tree.setOnClickHandler(onNodeSelect); 
	}
	</script>
</head>
<Body onLoad="doOnLoad();" class='iframebody'>
	<div id="TreeBox" style="width:100%; height:100%;border:0 solid Silver;"/></div>  
<Div id="MenuSol"></Div>
</Body>
</html>
