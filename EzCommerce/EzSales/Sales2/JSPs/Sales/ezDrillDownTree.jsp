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
			if(id!='NODATA'){
				//var soNumAndSoldto  = id.split("¥") 
				parent.document.getElementById("gridFrame").src="ezDrillDownSODetails.jsp?SONumber="+id+"&orderType=Open&status=O";			
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
<Body onLoad="doOnLoad();">
	<div id="TreeBox" style="width:107%; height:104%;background-color:white;border:0 solid Silver;"/></div>
	<Div id="MenuSol"></Div>
</Body>
</html>