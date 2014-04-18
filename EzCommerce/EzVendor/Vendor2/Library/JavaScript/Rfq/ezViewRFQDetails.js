function goToPlantAddr(plant)
{
	window.open("../Misc/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=370,height=350");
}
/*	
function viewSchedules()
{
	document.forms[0].action = "ezViewDeliverySchedules.jsp"
	document.forms[0].submit();
}
*/	
function goBack(type){
	if(type=="InviteGrp"){
		document.forms[0].action ="ezListRFQsToInvite.jsp?type="+type;
	}else if(type=="EditRFQ"){
		document.forms[0].action ="ezGetEditRFQList.jsp?type="+type;
	}else{
		document.forms[0].action ="ezListRFQs.jsp?type="+type;
	}
	document.forms[0].submit();
}