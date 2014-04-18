function selectedVendors()
{
	if(document.myForm1.ven1 != null)
	{
		var chkdLength = document.myForm1.ven1.length
		var chkVendors;
		var chkdCount = 0
		if(!isNaN(chkdLength))
		{
			for(i=0;i<chkdLength;i++)
			{
				if(document.myForm1.ven1[i].checked)
				{
					if(chkdCount == 0)
						chkVendors = document.myForm1.ven1[i].value
					else
						chkVendors += "¥"+document.myForm1.ven1[i].value
					chkdCount++;	
				}
			}	
		}
		else
		{
			chkVendors = document.myForm1.ven1.value
		}
		if(chkVendors != null)
		{
			addVendorsToParent(chkVendors)
		}	
	}	
	close()
}
function addVendorsToParent(chkVendors)
{
	var splitVendors = chkVendors.split("¥")
	var splitLength  = splitVendors.length
	var vendString = "";  
	if(splitLength > 0)
	{
		window.opener = window.dialogArguments
		var tabObj = opener.document.getElementById("VendorTab")
		var rowItems = tabObj.getElementsByTagName("tr");
		var rowCountValue = rowItems.length;

		for(var i=rowCountValue;i>0;i--)
		{
			tabObj.deleteRow(rowCountValue-1);
			rowItems = tabObj.getElementsByTagName("tr");
			rowCountValue = rowItems.length;
		}


		var align;
		var colString;
		for(var p=0;p<splitLength;p++)
		{
			
			if(splitLength == 1)
			{
				vendString = chkVendors;
			}	
			else	
			{
				vendString = splitVendors[p];
			}	
			
		
			colString = vendString.split('#')	
				
			rowItems = tabObj.getElementsByTagName("tr");
			rowCountValue = rowItems.length;
			var rowId = tabObj.insertRow(rowCountValue);

			rowItems.value = p

			elementsArray=new Array();
			
			elementsArray[0] = "<input type=checkbox name='chk2' value="+colString[0]+">"
			elementsArray[1] = colString[0]
			elementsArray[2] = colString[1]
			elementsArray[3] = "<input type=text name=qtyVal1 class='Inputbox' value='"+quantity+"'>"
			
			
			elewidth = new Array();
			elewidth[0] = "5%"
			elewidth[1] = "35%"
			elewidth[2] = "50%"
			elewidth[3] = "10%"
			
	
			for(var q=0;q<elementsArray.length;q++)
			{
				cell0Data = elementsArray[q]
				cell0=rowId.insertCell(q);
				cell0.innerHTML=cell0Data;
				cell0.align="center";
				cell0.width= elewidth[q];
			}
			rowCountValue++
		}
		opener.document.getElementById("VendorHeaderDiv").style.visibility='visible'
	}
	close()
}
function setSelected()
{
	window.opener = window.dialogArguments
}