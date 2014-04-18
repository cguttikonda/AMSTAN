function compareDates(strtDate,endDate)
{

	startDt=strtDate.split("/");
	endDt=endDate.split("/");

	tempStartDate=startDt[0]+"/"+startDt[1]+"/"+startDt[2];
	tempEndDate=endDt[0]+"/"+endDt[1]+"/"+endDt[2];

	strtDateObj = new Date(tempStartDate);
	endDateObj = new Date(tempEndDate);

	if(strtDateObj > endDateObj)
	{
		return false;
	}
	else
	{
		return true;
	}
}

function funValidations()
 {
	var startDate = document.myForm.newsStrtDate.value;
	var endDate = document.myForm.newsEndDate.value;

	if(document.myForm.news.value=="")
	{
		alert("Please enter news");
		document.myForm.news.focus();
		return false;
	}

	if(startDate=="")
	{
		alert("Please select Start Date");
		document.myForm.newsStrtDate.focus();
		return;
	}

	if(endDate=="")
	{
		alert("Please select End Date");
		document.myForm.newsEndDate.focus();
		return;
	}

	if(!compareDates(startDate,endDate))
	{
		alert("End Date should be greater than or equals to Start Date.");	
		return false;
	}

	if(document.myForm.syskey.value=="")
	{
		alert("Please select Purchase Area");
		document.myForm.syskey.focus();
		return;
	}

	if(document.myForm.newsType.value=="")
	{
		alert("Please select News Type");
		document.myForm.newsType.focus();
		return;
	}
	
	return true;
 }
