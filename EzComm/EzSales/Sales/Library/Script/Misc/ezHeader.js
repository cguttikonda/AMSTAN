
function addToCart_F(num)
{
	
	//document.myFavForm.prodIden.value=num;

	//document.myFavForm.action="../ShoppingCart/ezAddCartItems.jsp";
	//document.myFavForm.submit();
	var catType=document.myFavForm.catType_H.value;
			
	if(catType=='Q')
	{
		alert("Cart contains Quick Ship items. \nPlease remove them to add other items");
		return false;
	}
	else if(catType=='C')
	{
		alert("Cart contains Custom items. \nPlease remove them to add other items");
		return false;
	}
	else
	{
		addToFavHead(num);
	}
	
}
var req
var pcodeh
function addToFavHead(val)
{	
	
	req=Initialize();

	if (req==null)
	{
	alert ("Your browser does not support Ajax HTTP");
	return;
	}			
	
	var url

	var atpfor  = eval("document.myFavForm.prodCode_"+val).value;
	var atpqty  = eval("document.myFavForm.qty_"+val).value;
	var atpdesc = eval("document.myFavForm.prodDesc_"+val).value;
	var atpprice= eval("document.myFavForm.listPrice_"+val).value;
	var atpupc  = eval("document.myFavForm.eanUpc_"+val).value;

	pcodeh=atpfor

	url="../ShoppingCart/ezAddCartItems.jsp";
	url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc;			

	
	if(req!=null)
	{			
		req.onreadystatechange = Processh;
		req.open("GET", url, true);
		req.send(null);
	}			
}

function Processh() 
{	
	
	if (req.readyState == 4)
	{
		var resText     = req.responseText;	 	        	
		if (req.status == 200)
		{			

			var alertCodeh					
			var barCol = '#eb593c'
			if(resText.indexOf("NA")!=-1)
			{
				alertCodeh='could not be'
			}
			else
			{
				alertCodeh='has been successfully'
				barCol = '#71c6aa'
			}
				
			

			new HelloBar( '<span>Product ' +pcodeh+ ' '+alertCodeh+ ' added to Cart.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {

			showWait: 1000,
			positioning: 'sticky',
			fonts: 'Arial, Helvetica, sans-serif',
			forgetful: true,
			helloBarLogo : false,
			barColor : barCol,
			height : 30

			}, 1.0 );					

		}
		else
		{
			if(req.status == 500)	 
			alert("Error in adding product(s)");
		}
		
	}
}

function Initialize()
{

    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }

return null;	
}
function delFav_F(num)
{
	//alert("num::::::::::::::::::::::::::"+num)
	document.myFavForm.favDtl.value=num;

	document.myFavForm.action="../Catalog/ezDelFavItems.jsp";
	document.myFavForm.submit();
}
function getProductDetails(code)
{
	document.myFavForm.prodCode_D.value=code;

	document.myFavForm.action="../Catalog/ezProductDetails.jsp";
	document.myFavForm.submit();
}
function getCatDetails(catId)
{
	document.myFavForm.catIte.value=catId;

	document.myFavForm.action="../Catalog/ezProductsDisplay.jsp";
	document.myFavForm.submit();

}
function funClick(actionPage)
{
	document.myFavForm.action = actionPage;
	document.myFavForm.submit();
}

function funHelp()
{
	document.myFavForm.action="../Misc/ezHelp.jsp";
	document.myFavForm.target = "_blank";
	document.myFavForm.submit();
}


