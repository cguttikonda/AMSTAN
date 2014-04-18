//var tabHeadWidth=80
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

function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function setChecked(val) {
	dml=document.forms[0];
	len = dml.elements.length;
	var i=0;
	for( i=0 ; i<len ; i++) {
		dml.elements[i].checked=val;
	}
}