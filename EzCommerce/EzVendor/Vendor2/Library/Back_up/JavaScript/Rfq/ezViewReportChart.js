 function validate(type)
         {         	
		var flag = true
		

		 if (type == 'RQPA')
		{
		      	if (document.MyForm.rfq.selectedIndex == 0)
		      	{
         			alert('Please Select A Collective RFQ')         		
         			flag = false
         			document.MyForm.rfq.focus()
         		}

		}												
		else if (type == 'VQH' || type == 'VQWH' || type == 'VQRH' || type == 'MAPH' || type == 'MPFH' || type == 'MAQPH' || type == 'PGEH' || type == 'APGEH' || type == 'PGQH' || type == 'APGQH' || type == 'PGFH' || type == 'APGFH')
		{

			if (type == 'PGEH' || type == 'PGQH' || type == 'PGFH')
			{
			      	if (document.MyForm.purarea.selectedIndex == 0)
			      	{
	         			alert('Please Select A Purchase Area')
	         			flag = false
	         			document.MyForm.purarea.focus()
	         		}		
			}         			

		      	if (flag && document.MyForm.time.selectedIndex == 0)
		      	{
         			alert('Please Select A TimePeriod')
         			flag = false
         			document.MyForm.time.focus()
         		}
	
		}         			
		else if (type == 'CVQH')
		{
		      	if (document.MyForm.vendor.selectedIndex == 0)
		      	{
         			alert('Please Select A Vendor')
         			flag = false
         			document.MyForm.vendor.focus()
         		}
	
		}         	
		else if (type == 'MMMP' || type == 'MVQPH' || type == 'MPA')
		{
		      	if (document.MyForm.material.selectedIndex == 0)
		      	{
         			alert('Please Select A Material')
         			flag = false
         			document.MyForm.material.focus()
         		}
	
		}         	

		
       		if(flag && (type == 'VQH' || type == 'VQWH' || type == 'MAPH' || type == 'MPFH' || type == 'PGEH' || type == 'APGEH' || type == 'PGFH' || type == 'APGFH' || type == 'PGQH' || type == 'APGQH' ))
       		{
       			
       			//BAR CHART       			
       			if(type == 'PGQH' || type == 'PGEH' || type == 'PGFH')
       			{
       				timePeriod = document.MyForm.time[document.MyForm.time.selectedIndex].value
       				purAreaVal = document.MyForm.purarea[document.MyForm.purarea.selectedIndex].value       				
       				val = purAreaVal.split('#')
       				PurchaseGrp = val[0]
       				PurchaseOrg = val[1]    								          	                          				
       				obj = window.open('ezNewBarReportChart.jsp?TimePeriod='+timePeriod+'&Report='+type+'&PurchaseGrp='+PurchaseGrp+'&PurchaseOrg='+PurchaseOrg,timePeriod,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			       			
       			}														
       			else
       			{
       				timePeriod = document.MyForm.time[document.MyForm.time.selectedIndex].value
       				obj = window.open('ezNewBarReportChart.jsp?TimePeriod='+timePeriod+'&Report='+type,timePeriod,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			
       			}       			
       		}
       		else if(flag && (type == 'VQRH' || type == 'MMMP' || type == 'MVQPH'))
       		{
       			//STACKED BAR CHART       			
       			if(type == 'VQRH')
       			{
       				timePeriod = document.MyForm.time[document.MyForm.time.selectedIndex].value
       				obj = window.open('ezNewStackedBarReportChart.jsp?TimePeriod='+timePeriod+'&Report='+type,timePeriod,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			
       			}
       			else if(type == 'MMMP' || type == 'MVQPH')
       			{       				
       				material = document.MyForm.material[document.MyForm.material.selectedIndex].value         				
       				obj = window.open('ezNewStackedBarReportChart.jsp?Material='+material+'&Report='+type,"material","resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes");       			       			       			
       			}
       			
       		}
       		else if(flag && (type == 'RQPA' || type == 'MAQPH' || type=='MPA'))
       		{       			
       			//LINE CHART
       			if(type == 'RQPA')
       			{
       				rfqNo = document.MyForm.rfq[document.MyForm.rfq.selectedIndex].value
       				obj = window.open('ezNewLineReportChart.jsp?CollectiveRfq='+rfqNo+'&Report='+type,rfqNo,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			
       			}
       			else if(type == 'MAQPH')
       			{
       				timePeriod = document.MyForm.time[document.MyForm.time.selectedIndex].value
       				obj = window.open('ezNewLineReportChart.jsp?TimePeriod='+timePeriod+'&Report='+type,timePeriod,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			       			
       			}
       			else if(type == 'MPA')
       			{
       				material = document.MyForm.material[document.MyForm.material.selectedIndex].value         				
       				obj = window.open('ezNewLineReportChart.jsp?Material='+material+'&Report='+type,"material","resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes");
       			
       			}
       		}
       		else if(flag && type == 'CVQH')
       		{       			
       			//GENERIC DIAOGRAM
       			vendorCode = document.MyForm.vendor[document.MyForm.vendor.selectedIndex].value
       			obj = window.open('ezVendorAnalysisReport.jsp?Report='+type+'&Vendor='+vendorCode,vendorCode,"resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			
       		}
         }