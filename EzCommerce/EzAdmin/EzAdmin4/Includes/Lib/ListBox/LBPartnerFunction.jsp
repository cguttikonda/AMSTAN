<% 
//*************CUSTOMER********************************************
int custRows = retbpezcust.getRowCount();
String custvalue = null;
String SelPartnerFunction = "";

if ( custRows > 0 ) 
{

	SelPartnerFunction = request.getParameter("PartnerFunction_"+ls);

	if ( SelPartnerFunction == null )
	{

		if ( cSoldTo.equals(erpSoldTo) )
		{
			SelPartnerFunction = genEzc;
		}
		else
		{
			SelPartnerFunction = "C";
		}
		//SelPartnerFunction = retbpezcust.getFieldValueString(0,"EC_NO");
		//SelPartnerFunction = genEzc;
	}

	SelPartnerFunction = SelPartnerFunction.trim();
	
          out.println("<select name=\"PartnerFunction_" + ls + "\" onChange= \"partnerfunctionchange("+ls+")\">"); 

	  boolean showOnlyEzcFlag = false; 
	  String selDesc = "";
	  if ( !cSoldTo.equals(erpSoldTo) )
	  {
	  	//if partner Function Number does not match Sold To - Make this selected defaultly
	  	if ( SelPartnerFunction.equals("C") )selDesc = "selected";
	  	out.println("<option value=\"C\">---CREATE "+arTitle+"---</option>"); 
	  }
	  else
	  {
	  	showOnlyEzcFlag = true;
	  }
	  
	  for ( int z = 0 ; z < custRows ; z++ )
	  {		
		
		String val = ((String)retbpezcust.getFieldValue(z,"EC_NO")).toUpperCase();		

		if(SelPartnerFunction.equals(val.trim()))
		{
	        	out.println("<option selected value=\""+val+"\">"); 
			custvalue = (String)retbpezcust.getFieldValue(z,ERP_CUST_NAME);
			if (custvalue != null)
			{
				out.println(custvalue + "(" + val + ")");
			}
	        	out.println("</option>"); 
		}
		else if ( !showOnlyEzcFlag )
		{
	        	out.println("<option value=\""+(retbpezcust.getFieldValue(z,ERP_CUST_NO))+"\">"); 
			custvalue = (String)retbpezcust.getFieldValue(z,ERP_CUST_NAME);
			if (custvalue != null)
			{
				out.println(custvalue + "(" + val + ")");
			}
	        	out.println("</option>"); 
		}
	  }//End for
        out.println("</select>"); 
}
%>