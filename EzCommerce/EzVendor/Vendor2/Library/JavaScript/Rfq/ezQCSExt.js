
	function funOpenFile()
	{
		var filename = document.myForm.attachs.value
		if(filename!= null || filename!= "")
		{
			if(filename.length > 0)
			{
				window.open(filename,"newwin","width=800,height=650,left=0,top=0,resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,minimize=yes,status=yes");		
			}	
		}	
	}
	function goBack(type)
	{
		if(type == 'RFQLINK')
			location.href='ezRFQLinkageReport.jsp'
		else
			history.go(-1)
	}
	function setDimensions()
	{
		if(screen.height == 600)
		{
			tabHeight="40%"
			var byPassDiv = document.getElementById("byPassDiv")
			if(byPassDiv != null)
			byPassDiv.style.top = "30%"
		}
		else
		{
			tabHeight="65%"
			var byPassDiv = document.getElementById("byPassDiv")
			if(byPassDiv != null)
				byPassDiv.style.top = "50%"
		}
	}
	function openWin(num)
	{
		var url="ezQCFPrint.jsp?qcfNumber="+num;
		var sapWindow=window.open(url,"newwin","width=800,height=650,left=0,top=0,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function SAPView(num)
	{
		var url="ezQCFSAPPrint.jsp?qcfNumber="+num;
		var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
