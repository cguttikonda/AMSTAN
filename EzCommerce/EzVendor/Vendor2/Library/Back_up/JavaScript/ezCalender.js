<!-- Begin
/**
 * @(#) ezCalender.js V1.2	July 19,2002
 *
 * Copyright (c) 2003 EzCommerce Inc. All Rights Reserved.
 * @ author Krishna Prasad V
 *
 **/
 //=====================user can change following part============//
 //========== variable declaration==================//

var ListBox_StartYear=1950;var ListBox_EndYear=2050;var Default_Top=50;var Default_Left=250;var CellTableWidth=180;var CellHeight=15;var CellWidth=15;
//========== variable declaration for tool tip==================//
// --------this is only displaying purpus-----------------------//

	aDay = new Array();aDay[0] = "Sunday";aDay[1] = "Monday";aDay[2] = "Tuesday";aDay[3] = "Wednesday";aDay[4] = "Thursday";aDay[5] = "Friday";aDay[6] = "Saturday";
	aDayShort = new Array();aDayShort[0] = "Sun";aDayShort[1] = "Mon";aDayShort[2] = "Tue";aDayShort[3] = "Wed";aDayShort[4] = "Thu";aDayShort[5] = "Fri";aDayShort[6] = "Sat";
	Months = new Array();Months[1]="January";Months[2]="February";Months[3]="March";Months[4]="April";Months[5]="May";Months[6]="June";Months[7]="July";Months[8]="August";Months[9]="September";Months[10]="October";Months[11]="November";Months[12]="December";
	var todaytxt = "Today";	var clear = "Clear";
//==========end variable declaration for tool tip==================//

//This fields for today's date
var curDate="";var curMonth="";var curYear="";
//This fields for selected date
var showDate="";var showMonth="";var showYear="";
//This field for visibility flag
var visibilityFlsg=true;var calShowFlag=false;
function hideCalDiv(){ezDiv.style.visibility="hidden";ezDiv.innerHTML="";visibilityFlsg=true;
	//Following code is to display back previously hided list boxes
	listBoxIds=document.getElementsByTagName("select")
	if(listBoxIds!=null)
	{
	   for(i=0;i<listBoxIds.length;i++)
	   {
	     if(listBoxIds[i].id=="CalendarDiv")
	     listBoxIds[i].style.visibility="visible"
	   }
	}
	//End of listbox visible
}
function fClearField(fldObj)
{
	retField=eval(fldObj)
	retField.value=""   //clear the date field
	hideCalDiv()
}
function fSelTodayDate(fldObj)
{
	var tDate=curDate
	var tMonth=curMonth
	var tYear=curYear

	if (tMonth<10)
		tMonth = "0" + tMonth;
	if (tDate<10)
		tDate = "0" + tDate;
	retDateValue(fldObj,tDate,tMonth,tYear);
	hideCalDiv()
}
function fSelDate(fldObj,myElement)
{
	if (myElement.id == "calCell")
	{
		var fVal=myElement.innerHTML
		if (!isNaN(fVal)&&fVal>0)
		{
			var rDate=fVal;
			var rYear=document.calendarForm.selYear.value;
			var rMonth=document.calendarForm.selMonth.value;
			if (rMonth<10)
				rMonth = "0" + rMonth;
			if (rDate<10)
				rDate = "0" + rDate;
			retDateValue(fldObj,rDate,rMonth,rYear);
			hideCalDiv()
		}
	}
}
function retDateValue(fldObj,rd,rm,ry)
{
	var retDateStr="";

	//for globalization
	for(i=0;i<3;i++)
	{
		if(dFormat[i] == "DD")
			retDateStr=retDateStr+rd+DateFarmat
		if(dFormat[i] == "MM")
			retDateStr=retDateStr+rm+DateFarmat
		if(dFormat[i] == "YY")
			retDateStr=retDateStr+ry+DateFarmat
	}
	retDateStr=retDateStr.substring(0,10);
	fldObj.value=retDateStr
}
function fTodayTextOver(myElement)
{
	myElement.className = "caltdtodatover";
}
function fTodayTextOut(myElement)
{
	myElement.className = "caltdtoday";
}
function fDateFieldOver(myElement)
{
	sDate=myElement.innerHTML
	sYear=document.calendarForm.selYear.value
	sMonth=document.calendarForm.selMonth.value
	if (!isNaN(sDate)&&(sDate>0)) 
	{
		
		if (myElement.id == "calCell") 
		{
		
			if ((sDate==eval(showDate)) && (sMonth==eval(showMonth)) && (sYear==eval(showYear))) 
			{
				myElement.className = "caltdtodaydateover";
			}
			else{
				if(myElement.className == "caltdsunsatdates")	
					myElement.className = "caltdsunsatdatesOver";
				else
					myElement.className = "caltdover";
			}
		}
	}
}
function fDateFieldOut(myElement)
{
	sDate=myElement.innerHTML
	sYear=document.calendarForm.selYear.value
	sMonth=document.calendarForm.selMonth.value
	//sDate=eval(sDate)
	if (!isNaN(sDate)&&(sDate>0)) 
	{
		if (myElement.id == "calCell") 
		{
			if ((sDate==eval(showDate)) && (sMonth==eval(showMonth)) && (sYear==eval(showYear))) 
			{
				myElement.className = "caltdtodaydate";
				
			}	
			else{
				if(myElement.className == "caltdsunsatdatesOver")
					myElement.className = "caltdsunsatdates";
				else
					myElement.className = "caltd";
			}
		}
	}
}

//These function for functionality

function fGetDaysInMonth(iMonth, iYear) 
{
	var dPrevDate = new Date(iYear, iMonth, 0);
	return dPrevDate.getDate();
}
function fBuildCal(iYear, iMonth) 
{
	
	var dCalDate = new Date(iYear, iMonth-1, 1);
	var iDayOfFirst = dCalDate.getDay();
	var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
	var iVarDate = 1;
	var i, d, w;

	var aMonth = new Array();
	aMonth[0] = new Array(7);
	aMonth[1] = new Array(7);
	aMonth[2] = new Array(7);
	aMonth[3] = new Array(7);
	aMonth[4] = new Array(7);
	aMonth[5] = new Array(7);
	aMonth[6] = new Array(7);

		aMonth[0][0] = aDayShort[0];
		aMonth[0][1] = aDayShort[1];
		aMonth[0][2] = aDayShort[2];
		aMonth[0][3] = aDayShort[3];
		aMonth[0][4] = aDayShort[4];
		aMonth[0][5] = aDayShort[5];
		aMonth[0][6] = aDayShort[6];

	for (d = iDayOfFirst; d < 7; d++) 
	{
		aMonth[1][d] = iVarDate;
		iVarDate++;
	}
	for (w = 2; w < 7; w++) 
	{
		for (d = 0; d < 7; d++) 
		{
			if (iVarDate <= iDaysInMonth) 
			{
				aMonth[w][d] = iVarDate;
				iVarDate++;
			}
		}
	}
	return aMonth;
}

function showCal(fieldName,dTop,dLeft,CD,CM,CY)  
{
	var popUpCal=document.getElementById("ezCalendar");	//GETTING THE DIV OBJECI
	var calTop=dTop;					//GETTING THE TOP POSITION OF OBJECT
	var calLeft=dLeft;					//GETTING THE LEFT POSITION OF OBJECT
	var fieldObj="";
	var showFlag=true;
	showDate="";
	showMonth="";
	showYear="";
        
	if(popUpCal==null)
		calShowFlag=true;
	else	if((popUpCal.style.visibility=="hidden")&&(visibilityFlsg))
			calShowFlag=true;
		else
			calShowFlag=false;
	if(eval(calShowFlag))
	{
		//THIS CODE FOR HIDING THE LIST BOXES
		visibilityFlsg=false;
		var listBoxIds=document.getElementsByTagName("select")
		if(listBoxIds != null)
		{
	 		 for(i=0;i<listBoxIds.length;i++)
	   		{
			     if(listBoxIds[i].id=="CalendarDiv")
			     	listBoxIds[i].style.visibility="hidden";
	     		   } 
		}
		
		//END OF HIDING THE LIST BOXES
		//ASSGNING TOP & LEFT POSITIONS
		
		if((calTop==null)||(calLeft==null))
		{
		  			calTop=Default_Top;
		    			calLeft=Default_Left;		
		}
		//End of assigning top&left positions
		//Assgning Current Date,Month,Year else system date
		
		if((CD!=null) && (CD!='<%=cDate%>') && (CM!=null) && (CM!='<%=cMonth%>') && (CY!=null) && (CY!='<%=cYear%>'))
		{
			curDate=CD;
			curMonth=parseInt(CM)+1;//Because it starts from 0
			curYear=CY;
		}else
		{
			var dateObj= new Date();
			curDate=dateObj.getDate();
			curMonth=dateObj.getMonth()+1;//Because it starts from 0
			curYear=dateObj.getFullYear();;
		}
		
		//End of Assigning Dates
		
		fieldObj=eval(fieldName);
		
		if (fieldObj)
			fieldValue=fieldObj.value;
		else
			showFlag=false;
			
		if(showFlag)   	
		{
			if(fieldValue != "")
			{

				var sdc=0;//these varibles for caliculate index position of date,month,year 
				var edc=2;

					for(dt=0;dt<3;dt++)
					{
						if(dFormat[dt] == "DD")
						{
							showDate=fieldValue.substring(sdc,edc);
							sdc=parseInt(sdc)+parseInt(3);
							edc=parseInt(edc)+parseInt(3);
						}
						else
							if(dFormat[dt] == "MM")
							{
								showMonth=fieldValue.substring(sdc,edc);
								sdc=parseInt(sdc)+parseInt(3);
								edc=parseInt(edc)+parseInt(3);
							}
							else
								if(dFormat[dt] == "YY")
								{
									edc=parseInt(edc)+parseInt(2);
									showYear =fieldValue.substring(sdc,edc);
									sdc=parseInt(sdc)+parseInt(5);
									edc=parseInt(edc)+parseInt(5);
								 }


					}
			}else{
				showDate =curDate;
				showMonth=curMonth;
				showYear =curYear;
			}
			
			//TO CALICULATE CURRENT MONTH DATES
			
			var myMonth;
			myMonth = fBuildCal(showYear,showMonth)
			
			//TO CALICULATE TODAY DATE FOR DISPLAY PURPUS
			
			var dispToday="";
			for(dt=0;dt<3;dt++)
			{
				if(dFormat[dt] == "DD")
					dispToday=dispToday+curDate+DateFarmat
				if(dFormat[dt] == "MM")
					dispToday=dispToday+curMonth+DateFarmat
				if(dFormat[dt] == "YY")
					dispToday=dispToday+curYear+DateFarmat
			}
			dispToday =dispToday.substring(0,dispToday.length-1);


			//CREATE CALENDAR STRING

			var text =""
			text +='<form name="calendarForm">'
			text +="<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center class='caltable' width='" + CellTableWidth + "'><Tr><Td align=center class='caltd' width=100%>"
			text +="<Table width=100% class='caltable'><Tr>"	 //SELECTBOX TABLE
			text +="<Td width=90% align=center class='caltd'>"
			text +='<nobr><select id=selMonth1 name=selMonth  onchange="fUpdateCal(document.calendarForm.selYear.value,document.calendarForm.selMonth.value)">'
			for(var i=1;i<=12;i++)
			{
				if(i == showMonth)
					text +='<option value="'+i+'" selected>' +Months[i]+ '</option>'
				else
					text +='<option value="'+i+'">' +Months[i]+ '</option>'
			}
			text +='</select>&nbsp;'
			text +='<Select id=selYear1  name=selYear   onchange="fUpdateCal(document.calendarForm.selYear.value,document.calendarForm.selMonth.value)">'
			for(i=ListBox_StartYear;i<ListBox_EndYear;i++)
			{
				if(i == showYear)
					text +='<option value="'+i+'" selected>' + i +'</option>'
				else
					text +='<option value="'+i+'">' + i +'</option>'
			}
			text +='</Select></nobr>'
			text +="</Td><Td align=right valign=top class='caltd' style='cursor:pointer;cursor:hand;'onClick=hideCalDiv() title='Close' >X</Td>"
			text +="</Tr></Table>"					 //END OF SELECTBOX TABLE
			text +="</Td></Tr><Tr><Td class='caltd' width=100%>"		 //START BUILDING OF CALENDAR
										 //WEEK NAMES & DATES TABLE
			text +="<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center  class='caltable' width=100%>"
			text +="<Tr>"
			for (p = 0; p <7; p++)
			{
				text +="<Td width=25 align='center'  class='caltdweeknames'  title="+aDay[p]+">" + myMonth[0][p] + "</Td>"
			}
			text +="</Tr>"
			for (w = 1; w <7; w++)
			{
				text +='<Tr>'
				for (d = 0; d < 7; d++)
				{
					text +="<Td align='center' valign='top' width='" + CellWidth + "' height='" + CellHeight + "' id='calCell' onMouseOver='fDateFieldOver(this)' onMouseOut='fDateFieldOut(this)' onClick='fSelDate("+ fieldName +",this)'  class='caltd'>"
					if (!isNaN(myMonth[w][d]))
					{
						text += myMonth[w][d]
					} else {
						text += "&nbsp;"
					}
					text +="</Td>"
				}
				text +="</Tr>"
			}
			text +="<Tr><Td align='center'  class='caltd' colspan=7 width=100%>"
							//Start clear & today
			text +="<Table border=1 height='"+CellHeight+"' borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center width=100% class='caltable'  width=100%>"
			text +="<Tr><Td align='center'  onMouseOver='fTodayTextOver(this)' onMouseOut='fTodayTextOut(this)' onClick='fClearField("+ fieldName +")' title='"+clear+"'  class='caltdtoday'  width=30%>"+clear+"</Td>"
			text +="<Td  align='center' onMouseOver='fTodayTextOver(this)' onMouseOut='fTodayTextOut(this)' onClick='fSelTodayDate("+ fieldName +")' title='"+ todaytxt +"'  class='caltdtoday' width=70%>" + todaytxt + " &nbsp;:&nbsp;&nbsp;" + dispToday +"</Td></Tr></Table>"
							//END CLEAR & TODAY
			text +="</Td></Tr>"
			text +="</Table>"
							//END DATES TABLE
			text +="</Td></Tr></Table>"	//END CALENDAR TABLE
			text +="</form>"		//END FORM

			ezDiv=document.createElement("DIV");//CREATION OF DIVISION
			ezDiv.id="ezCalendar";
			ezDiv.innerHTML=text;
			document.body.appendChild(ezDiv);
			ezDiv.style.position="absolute";
			ezDiv.style.zIndex=50;
			ezDiv.style.visibility="visible"
			ezDiv.style.top=parseInt(calTop);
			ezDiv.style.left=parseInt(calLeft);

			//UPDATE FOR CURRENT CALENDAR
			fUpdateCal(showYear, showMonth);
		}
	}
}
var calCell =new Array();
var calDateText =new Array();
function fUpdateCal(icurYear, icurMonth)
{

	myMonth = fBuildCal(icurYear, icurMonth);
	var tdId=document.getElementsByTagName("td")
	var tdCount=0;

	for(var j=0;j<tdId.length;j++)
	{

		if(tdId[j].id == 'calCell')
		{
			calCell[tdCount]=tdId[j];
			tdCount++;
		}
	}

	for (w = 1; w < 7; w++)
	{
		for (d = 0; d < 7; d++)
		{
			calCell[((7*w)+d)-7].className="caltd";
			calCell[((7*w)+d)-7].title="";
			if (!isNaN(myMonth[w][d]))
			{

				calCell[((7*w)+d)-7].innerHTML = myMonth[w][d];
				calCell[((7*w)+d)-7].title=aDay[d]+",  "+Months[eval(icurMonth)]+" "+myMonth[w][d]+" , "+icurYear
				calCell[((7*w)+d)-7].style.cursor="hand"
				if ((d==0)||(d==6))
				{
					calCell[((7*w)+d)-7].className = "caltdsunsatdates";
					
				}
				if ((eval(myMonth[w][d])==eval(showDate)) && (eval(icurMonth)==eval(showMonth)) && (eval(icurYear)==eval(showYear))) 
				{
					
					calCell[((7*w)+d)-7].className = "caltdtodaydate";
				}
			} else {
				calCell[((7*w)+d)-7].innerHTML = "&nbsp;";
				calCell[((7*w)+d)-7].className="caltd";
				calCell[((7*w)+d)-7].style.cursor=""
		        }
      		}
	}
	
}
// End -->
