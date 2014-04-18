
/**
 * @(#) ezsortTableData.js V3.0	July 19,2002
 *
 * Copyright (c) 2002 EzCommerce Inc. All Rights Reserved.
 * @ author Srinivasulu K
 * This js file can be used to sort table data in front-end
 * see one model jsp file to use this file.
 **/
 

//=====================user can change following part============//

/***
  
  if table data is having date field then mention
  separator and format
  
***/

var separator="."  // possible values----> '-','.' etc..

var formatType="DD"+separator+"MM"+separator+"YYYY"
            
            //possible values----->MM/DD/YY,DD/MM/YYYY,DD/MM/YY etc...
            
//=====================end of user changeable part===============//            


//==========key variable declaration==================//

var firstClick=true
var rowCount=0
isCaseSensitive=false
var givenElements=null;
var prevIndex=null;
var type=null

var initialData= new Array()
var dataArray = new Array()
var rowArray=null;

//======================end of key variable declaration ======//

/***
 PURPOSE        :  This function is to initialize th required data and 
                   to store initial table data
 IN_PARAMETERS  :  If data is case-sensitive pass true else no need
                   to pass argument
 OUT_PARAMETERS :  --
***/

function ezInitSorting(isCaseSensitive)
{
     	
     	var InnerdivId=document.getElementById("InnerBox1Div")
	
   if(InnerdivId!=null) //if rowCount!=0
   {

	  rowCount=dataArray.length
	  if(isCaseSensitive==null || isCaseSensitive=="")
		isCaseSensitive=false
	   else
		isCaseSensitive=true

	  try
	  {
	       tabObj=InnerBox1Div.getElementsByTagName("table")
	       tabObj[0].id="InnerBox1Tab"

	       	for(t=0;t<rowCount;t++)
		{
	       		initialData[t]=InnerBox1Tab.rows(t).outerHTML
		}
	}catch(varError)
  	{
  	  	alert(varError)
  	  	return
  	}

   }//main if close
}

//=====================end of ezInitSorting ==================//


/***
 PURPOSE        :  This function is one private function to set data
                   and serial-no to that data
 IN_PARAMETERS  :  value,sno

 OUT_PARAMETERS :  --
***/


function ezSetData(val,sNo)
{
this.val=val
this.sNo=sNo

}

//===================end of setData=================//

/***
 PURPOSE        :  This function is to sort data on required column

 IN_PARAMETERS  :  pass column no on which user clicked and type of
 		   column if it is date type pass '_DATE'  or if alpha-
 		   numaric pass '_APLPHANUM' other wise not necessary
 		   to pass any argument

 OUT_PARAMETERS :  --
***/


function  ezSortElements(index,type)
{

    givenElements =new Array();
    this.type=type

    for(i=0;i<rowCount;i++)
    {
       //if it is number
      
       if(type=="_DATE"){ //if it is date type
              givenElements[i]=new ezSetData(ezBuildDateObj(dataArray[i][index]),i)
       }else{
       		if(type=="_ALPHANUM"){ //if it alpha-numeric
        		givenElements[i]=new ezSetData(ezGetNumPart(dataArray[i][index]),i)
       		}else{
       			if(!isNaN(new Number(dataArray[i][index]))){
          			givenElements[i]= new ezSetData(new Number(dataArray[i][index]),i)
       			}else{       //if it is string
	        		if(isCaseSensitive){
        		 		givenElements[i]=new ezSetData(dataArray[i][index],i)
         			}else{
         				givenElements[i]=new ezSetData(((dataArray[i][index]).toUpperCase()),i)
				}
			}
		}
	}
    }

    if(prevIndex==index)
     firstClick=!firstClick
    else
      firstClick=true
     prevIndex=index

     ezSortColumns(0,rowCount-1)
     ezWriteData()
 }

//============================end of ezSortElements===========//

/***
 PURPOSE        :  This is private function and it contains the
 		   quick sort logic

 IN_PARAMETERS  :  lowerbound,upperbound

 OUT_PARAMETERS :  sorted data
***/


//these varibles are useful for this function
var left, right, median, temp;

function  ezSortColumns(lo,hi)
  {

   if( hi > lo )
    {
      left=lo; right=hi;
      median=givenElements[lo].val;


      while(right >= left)
       {
         if(firstClick)
         {
             while(givenElements[left].val < median)
              left++;
             while(givenElements[right].val > median)
              right--;
         }
         else
         {
              while(givenElements[left].val > median)
              left++;
	      while(givenElements[right].val < median)
	      right--;
         }

        if(left > right) break;

         temp=givenElements[left].val;
         givenElements[left].val=givenElements[right].val;
         givenElements[right].val=temp; //swap

         temp=givenElements[left].sNo;
	 givenElements[left].sNo=givenElements[right].sNo;
         givenElements[right].sNo=temp; //swap
         left++;
         right--;

       }

       ezSortColumns(lo, right);// divide and conquer
       ezSortColumns(left,hi);

    }
    return

 }/*quicksort*/

 //======================end of ezSortColumns===============//

 /***
  PURPOSE        : This private function will be used if data is alphanumeric
                   i.e if data is in the form INDIA1,INDIA,INDIA3,
                   INDIA12 etc..it means text part is same but
                   diff numbers
  IN_PARAMETERS  : given Column data

  OUT_PARAMETERS : number part
 ***/


function ezGetNumPart(givenStr)
{
	var numPart=givenStr
   	numChars="0123456789"
   	ch=0
   	while(numChars.indexOf(givenStr.charAt(ch))==-1)
    	{
    		ch++
    		if(ch==givenStr.length)
    			break
    	}
    	if(ch!=givenStr.length)
    	  numPart=givenStr.substring(ch,givenStr.length)
    	if(givenStr!=numPart)
	return new Number(numPart)
	else
	return givenStr

}

//========================end of ezGetNumPart================//

/***
  PURPOSE        : This private function will be used to get date
  		   object for passed string

  IN_PARAMETERS  : given Column data(in above specified format)

  OUT_PARAMETERS : date Object
 ***/

gDateDay="";
gDateMonth="" ;
gDateYear="";

function ezBuildDateObj(gDate)
{

	dateArr=gDate.split(separator)
	switch(formatType)
	{
		case "MM"+separator+"DD"+separator+"YYYY" :
		case "MM"+separator+"DD"+separator+"YY"   :
                	gDateMonth =dateArr[0]
			gDateDay   =dateArr[1]
                	gDateYear  =dateArr[2]
                	break
		case "DD"+separator+"MM"+separator+"YYYY" :
		case "DD"+separator+"MM"+separator+"YY"  :
                	gDateDay   =dateArr[0]
                	gDateMonth =dateArr[1]
                	gDateYear  =dateArr[2]
                        break

	} //switch  end

	return new Date(gDateYear,gDateMonth,gDateDay,0,0,0,0)
}

//====================end of ezBuildDateObj================//

/***
  PURPOSE        : This function is to write back sorted data
  IN_PARAMETERS  : -
                    
  OUT_PARAMETERS : sorted table
 
***/

function ezWriteData()
{

       /* d= new Date();
	min=d.getMinutes();
	sec=d.getSeconds();
	alert(min + "...." + sec)*/
	
	tabData='<table border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%" id="InnerBox1Tab">'
	try
	{
	        for(i=0;i<rowCount;i++)
	        tabData+=initialData[givenElements[i].sNo]
		tabData+='</Table>'
		InnerBox1Div.innerHTML=tabData
		
	}catch(varError)
  	{
		alert(varError)
  	    //alert("Some of the variable declaration missing")
  	    return
  	}
  	
  	/*d= new Date();
	min=d.getMinutes();
	sec=d.getSeconds();
	alert(min + "...." + sec)*/
}	
	
	
//================end of ezWriteData()========================//
