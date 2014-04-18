<html>

<head>	
	
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
		.bodyBg
		{
		     background-color: #ECF5FC
		
		}
	</style>	
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXTree.css">
	<Script src="../../Library/JavaScript/Tree/dhtmlXCommon.js"></Script>
	<Script src="../../Library/JavaScript/Tree/dhtmlXTree.js"></Script>
	<script>
	
	var addProduct=parent.document.myForm.addProduct.value;
	var FavGroup  =parent.document.myForm.FavGroup.value;
	var GroupDesc =parent.document.myForm.GroupDesc.value;

	var tree = null;
	function onNodeSelect(id)
	{		
		if(id!='NODATA')
		{
			if(id=='FAVLIST'){
				parent.document.getElementById("subDisplay").src="../BusinessCatalog/ezListFavGroupsDT.jsp";
				
			}else if(id=='VC' || id=='BP' ||id=='OF'){
				parent.document.getElementById("subDisplay").src="ezDrillDownDisplay.jsp";
			}else{
					
				 var qryString = "ezCatalogSearchDisplaytagDownload.jsp?catalogStr="+id;
				 parent.document.getElementById("subDisplay").src=qryString;
			}
	        }
		
	}
	
	function doOnLoad()
	{
		tree=new dhtmlXTreeObject("TreeBox","100%","100%",0);
		tree.setImagePath("../../Images/ImagesTree/");
		tree.setXMLAutoLoading("ezVendorDrillDownTreeData.jsp");
		tree.loadXML("ezVendorDrillDownTreeDataDownload.jsp?id=0&addProduct="+addProduct); 
		tree.setOnClickHandler(onNodeSelect);  
		
	}	
	function selectDefaultTreeNode()
	{
		var callFunctionAgain = false;
		if(tree != null)
		{
			var selectedItem = tree.getSelectedItemId();
			if(selectedItem != null && selectedItem != '' && selectedItem == 'VC')
			{
				tree.openItem("VC");
				callFunctionAgain = false;
			}
			else
			{
				callFunctionAgain = true
			}
		}
		else
		{
			callFunctionAgain = true;
		}
		if(callFunctionAgain)
		{
			setTimeout ("selectDefaultTreeNode()", 2000 );
		}           
	}

	</script>
</head>
<Body onLoad="doOnLoad();selectDefaultTreeNode()" >
	<div id="TreeBox" style="width:100%; height:100%;border:0 "/></div>  
<Div id="MenuSol"></Div>
</Body>
</html>
