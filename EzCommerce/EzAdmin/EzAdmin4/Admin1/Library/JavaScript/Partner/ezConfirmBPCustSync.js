function checkThis(cBox)
{
	document.myForm.elements[cBox].checked=true;
}
function checkAll(sCnt)
{
	if ( !document.myForm.elements['CheckBox'+sCnt+'_0'].checked )
	{
		alert('Select Sold To Party for Synchronization');
		document.returnValue = false;
		document.myForm.elements['CheckBox'+sCnt+'_0'].focus();
	}
	else
	{
		document.returnValue = true;
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