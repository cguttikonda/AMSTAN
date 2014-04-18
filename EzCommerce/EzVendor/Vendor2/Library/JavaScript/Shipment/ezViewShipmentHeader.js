	
function funReceipts(dc)
{
	document.myForm.action="ezShipPOReceiptDetails.jsp?DCNo="+dc
	document.myForm.submit();
}
