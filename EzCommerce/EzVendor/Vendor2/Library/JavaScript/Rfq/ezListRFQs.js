function viewDetails(orderNo,closeDate)
{
	document.myForm.PurchaseOrder.value = orderNo
	document.myForm.EndDate.value = closeDate
	document.myForm.action = "ezViewRFQDetails.jsp"
	document.myForm.submit()
}
function viewQuoteDetails(orderNo,closeDate,orderDate)
{
	document.myForm.PurchaseOrder.value = orderNo
	document.myForm.EndDate.value = closeDate
	document.myForm.OrderDate.value = orderDate
	document.myForm.action = "ezViewQuoteDetails.jsp"
	document.myForm.submit()
}
function goToPlantAddr(plant)
{
	window.open("../Purorder/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=300,height=280");
}