
function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}

}



function CheckSel(){
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("Select Sold To(s) To Synchronize");
		document.returnValue = false;
	}else{
		document.returnValue = true;
	}
}


/*function checkAll(sCnt)
{
	var selCnt = 0;
	for( i = 0; i < sCnt; i++)
	{
		if ( !document.myForm.elements['CheckBox_'+i].disabled && document.myForm.elements['CheckBox_'+i].checked )
		{
			selCnt = 1;
			break;
		}
	}

	if ( selCnt == 0 )
	{
		alert('Select one Partner Function for Synchronization');
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}*/

function checkAll()
{
	var cnt=0
	var len=document.myForm.CheckBox.length;
	if(isNaN(len))
	{
		if(!document.myForm.CheckBox.disabled && document.myForm.CheckBox.checked)
		{
			document.returnValue=true;	
		}
		else
		{
			alert('Select one Partner Function for Synchronization');
			document.returnValue=false;
			return;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.CheckBox[i].checked)
			{
				cnt++;
				document.returnValue=true;
			}
			else
			{
				document.returnValue=false;	
			}
		}
		if(cnt==0)
		{
			alert('Select one Partner Function for Synchronization');
			document.returnValue=false;
		}
		else
		{
			document.returnvalue=true;
		}
		
	}
}

function partnerfunctionchange()
{
    var param = "PartnerFunction";
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SysKey=" + document.forms[0].SysKey.value + "&";
	mUrl3 = "BusPartner=" + document.forms[0].BusPartner.value + "&";
	mUrl4 = param+"=" + document.forms[0].elements[param].value;
	mUrl =  mUrl1 + mUrl2 + mUrl3+mUrl4+"&param=";
	document.forms[0].action=mUrl;
	document.forms[0].submit();
}
