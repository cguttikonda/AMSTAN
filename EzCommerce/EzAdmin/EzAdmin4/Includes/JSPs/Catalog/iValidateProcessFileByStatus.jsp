<%@page import="java.util.*"%>

<%!
        public Object validateExcel(ReturnObjFromRetrieve maindataObj,java.util.Hashtable addValHT,java.util.Hashtable maiValHT,String[] rFields)
	{

	    
	    ezc.ezparam.ReturnObjFromRetrieve outputObj = new ReturnObjFromRetrieve(new String[]{"DATA_OBJ","ERROR_OBJ"});
	    ezc.ezparam.ReturnObjFromRetrieve retObj    = new ReturnObjFromRetrieve(rFields);
	    ezc.ezparam.ReturnObjFromRetrieve errorObj  = new ReturnObjFromRetrieve(rFields);

	    StringTokenizer st = null;
	    int mainDataObjCount            = maindataObj.getRowCount();
	    String cellVal		    = "";
	    String tempHashStr              = "";
	    String validationTypes          = "";
	    String tempLength               ="";
	    int fieldLength		    = 0;
	    boolean retMandFlag  	    = false;
	    boolean retLenFlag   	    = false;
	    boolean flag   	            = false;
	    boolean errorFlag               = false;

            errorObj.append(maindataObj);
            
	    for(int i=mainDataObjCount-1;i>0;i--)
	    {
		errorFlag =  false;
		String oper = maindataObj.getFieldValueString(i,rFields[rFields.length-1]);
		if(oper!=null)oper=oper.trim();
		for(int j=0;j<rFields.length;j++)
		{
		   flag = false;
		   cellVal=maindataObj.getFieldValueString(i,rFields[j]);
                   if("A".equals(oper))
		   	tempHashStr=(String)addValHT.get(rFields[j]);
		   else
		   	tempHashStr=(String)maiValHT.get(rFields[j]);
		   st = new java.util.StringTokenizer(tempHashStr,"¥");

		   while(st.hasMoreTokens())
		   {
			validationTypes = st.nextToken();
			tempLength      = st.nextToken();
			fieldLength     = Integer.parseInt(tempLength);
		   }
		   
		   if("ML".equals(validationTypes)){
			retMandFlag=checkMandatory(cellVal,i,j);
			retLenFlag=checkLength(cellVal,fieldLength,i,j);

			if(retMandFlag && retLenFlag){
			    flag=true;
			}else{
			    flag=false;
			}	
		   }
		   else if("M".equals(validationTypes)){
		        flag=checkMandatory(cellVal,i,j);
		   }
		   else if("L".equals(validationTypes)){
			flag=checkLength(cellVal,fieldLength,i,j);
		   }
		   else if("N".equals(validationTypes))
		   {
		        if(cellVal!=null)
		        cellVal = cellVal.replaceAll(",","");
		        flag=checkNumber(cellVal,i,j); 
		   }
		   if(!flag)
		   {
			errorFlag=true;
		   }
		   
	        }
		if(errorFlag){
		    maindataObj.deleteRow(i);
		}
		else{
		    errorObj.deleteRow(i);
		}
		
	    }
	    
	  errorObj.deleteRow(0);
	 	  
	  outputObj.setFieldValue("DATA_OBJ",maindataObj);
	  outputObj.setFieldValue("ERROR_OBJ",errorObj);

	  outputObj.addRow();
	  return outputObj;

	}

	private boolean checkMandatory(String inVal,int row,int col)
	{
	   if(inVal=="" || "".equals(inVal) || inVal.length()==0)
	     	return false;	
	   else
	     	return true;
	}
	private boolean checkNumber(String inVal,int row,int col)
	{
	   if(inVal!=null && !"".equals(inVal))
	   {
	   	   try
		   {
		       inVal=Double.parseDouble(inVal)+"";
		       return true;
		   }catch(Exception e)
		   {
		      return false;
		   }
	   }else
	   {
	      return true;
	   }
	}
	private boolean checkLength(String inVal,int length,int col,int row)
	{
	   int strLen=0;

	   if(inVal!=null && !"".equals(inVal)){
		strLen=inVal.length();
		if(strLen>length){
		    return false;
		}
		else
		    return true; 
	   }
	   else{
	       return true;
	   }
	   
       }

%>