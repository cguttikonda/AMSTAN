function showATP(ind)
{
	obj=document.generalForm;

	x =obj.prodDesc.length
	if(x>1)
	{
        	schdate = obj.del_sch_date[ind]
		schqty = obj.del_sch_qty[ind]
	}else{

		schdate = obj.del_sch_date
		schqty = obj.del_sch_qty
	}

		prodCode = ""
		prodDesc =""
		reqDate =""
		reqQty =""
		uom=""
		plant=""

		if (obj.product[ind]!=null)
		{
			prodCode = obj.product[ind].value
			prodDesc =obj.prodDesc[ind].value
			reqDate =schdate.value
	 		reqQty =schqty.value
	 		uom=obj.pack[ind].value
			plant=obj.plant[ind].value

		}
		else
		{
			prodCode = obj.product.value
			prodDesc =obj.prodDesc.value
			reqDate =schdate.value
	 		reqQty =schqty.value
	 		uom=obj.pack.value
			plant=obj.plant.value

		}

		myurl ="ezGetATP.jsp?ProductCode="+prodCode+"&ProdDesc="+prodDesc+"&ReqDate="+reqDate+"&ReqQty="+reqQty+"&UOM="+uom+"&plant="+plant

		//retVal=showModalDialog(myurl," ",'center:yes;dialogWidth:25;dialogHeight:14;status:no;minimize:yes')
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=200,width=500,status=no,toolbar=no,menubar=no,location=no")
	}