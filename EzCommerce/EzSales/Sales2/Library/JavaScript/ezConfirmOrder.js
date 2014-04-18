function showTab(tabToShow)
{
	obj1=document.getElementById("div1")
	obj3=document.getElementById("theads")
	obj4a=document.getElementById("InnerBox1Div")
	obj5=document.getElementById("div5")
	obj6=document.getElementById("div6")
	obj7=document.getElementById("buttonDiv")
	obj8=document.getElementById("showTot");
	scrollInit('SHOWTOT');
	if(tabToShow=="1")
	{
		obj1.style.visibility="visible";
		obj3.style.visibility="visible";
		obj4a.style.visibility="visible";
		obj5.style.visibility="visible";
		obj6.style.visibility="hidden";
		obj7.style.visibility="hidden";
	}
	else if(tabToShow=="2")
	{
		obj1.style.visibility="hidden";
		obj6.style.visibility="visible";
		obj7.style.visibility="visible";
		obj3.style.visibility="hidden";
		obj4a.style.visibility="hidden";
		obj5.style.visibility="hidden";
		obj8.style.visibility="hidden";
	}
}

function showConditions()
{

	var netDiv=document.getElementById("ezItemsConditons");
	if(netDiv==null)
	{
		ezDiv=document.createElement("DIV");
		with(ezDiv)
		{
				id="ezItemsConditons";
				style.position="absolute";
				style.zIndex=500;
				style.visibility="inherit";
				style.top=25;
				style.left=200;
				style.backgroundColor="#ffffee"
				innerHTML=ezCondString;

		}
		document.body.appendChild(ezDiv);
	}else{
		netDiv.style.visibility="visible"

	}
}

function HideNetDiv()
{
	var netDiv=document.getElementById("ezItemsConditons");
	netDiv.style.visibility="hidden"
}
function verifyQty(field,val,prd)
{
var fValue=field.value
if((val!="")&&(!isNaN(val)))
{
	if((fValue%val)!=0)
	{
		alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
		field.value=0;

		field.focus();
	}

}
}


function qtyFocus()
{
   document.generalForm.desiredQty.focus();
}


function mselect(j)
{
	var one=j.split(",");

	if(eval("document.generalForm."+one[0]+".selectedIndex")==0)
	{
	alert(one[1]);
 	return false;
	}
	else{
	return true;
	}

}
function chkDiscount(obj)
{

}
function openNewWindow(obj,i)
{
	x=(eval("document.generalForm.del_sch_date.length"))
	if(x>1)
	{
		deldate = eval("document.generalForm.del_sch_date["+i+"]");
		delqty = eval("document.generalForm.del_sch_qty["+i+"]");
	}else{
		deldate = eval("document.generalForm.del_sch_date");
		delqty = eval("document.generalForm.del_sch_qty");

	}
	obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value

	newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=400,width=400,status=no,toolbar=no,menubar=no,location=no")
}
