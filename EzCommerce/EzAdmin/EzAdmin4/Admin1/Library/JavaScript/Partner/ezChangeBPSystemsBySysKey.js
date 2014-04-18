
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
function selectSystems(Aval)
{
    var form = document.forms[0];
    var totCnt = document.ChangeBPSystems.TotalCount.value;
    var selBox = 0;

    for(i=0;i<totCnt;i++)
    {
        var newVal = form.elements['ChkSys_'+i].value;
        if ( Aval == newVal )
        {
            form.elements['ChkSys_'+i].checked = true;
        }
    }
}

function CHG(fieldname, cBox)
{
     var AreaBox = 'ChkSys_'+cBox;
     if ( document.forms[0].elements[AreaBox].value != null )
     {
	     document.forms[0].elements[AreaBox].checked = true;
     }

      var newField = fieldname+'_CHG';
	var form = document.forms[0];
	for (i = 0; i < form.elements.length; i++) {
	if (form.elements[i].type == "hidden"  )
            {
		  if ( form.elements[i].name == newField )
              {
               var getVal = form.elements[i].value;
               if ( getVal == "Y" ) {getVal = "N";} else {getVal = "Y";}
               form.elements[i].value = getVal;
               //alert(form.elements[i].name+ ' '+form.elements[i].value);
                 }
		}//End if
	}//End for
}

function checkAll()
{
    var form = document.forms[0];
    var totCnt = document.ChangeBPSystems.TotalCount.value;
    var areacnt = document.ChangeBPSystems.AreaCount.value;

    var selBox = 0;
    for(i=0;i<totCnt;i++)
    {
        if ( !form.elements['ChkSys_'+i].disabled )
        {
           if ( form.elements['ChkSys_'+i].checked )
           {
			selBox = 1;
                  break;
           }
        }
    }

    for(i=0;i<areacnt;i++)
    {
           if ( form.elements['OrgArea_'+i+'_CHG'].value == 'Y' )
           {
			selBox = 1;
                  break;
           }
	}

    if ( selBox == 0 )
    {
       alert('Select atleast one system or organization');
       document.returnValue = false;
    }
    else
    {
       document.returnValue = true;
    }

} //end checkAll



function funsubmit()
{
	document.ChangeBPSystems.BusinessPartner.options[0].selected=true;
	document.ChangeBPSystems.action="ezChangeBPSystemsBySysKey.jsp";
	document.ChangeBPSystems.submit();
}

function funsubmit1()
{
	if(document.ChangeBPSystems.BusinessPartner.options[document.ChangeBPSystems.BusinessPartner.selectedIndex].value=="sel" && document.ChangeBPSystems.WebSysKey.options[document.ChangeBPSystems.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and BussinessPartner");
		return;
	}

	if(document.ChangeBPSystems.BusinessPartner.options[document.ChangeBPSystems.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.ChangeBPSystems.action="ezChangeBPSystemsBySysKey.jsp";
		document.ChangeBPSystems.submit();
	}
}


