<% 
int jobRows = retbp.getRowCount();
String jobDesc = null;
      if ( jobRows > 0 ) 
      {
          out.println("<select name=\"jobid\" onChange= \"myalert()\">"); 
	    for ( int i = 0 ; i < jobRows ; i++ )
          {		
		  String val = (retbp.getFieldValue(i,JOB_ID)).toString();	
              if( jobid.equals(val.trim()) )
              {
	            out.println("<option selected value="+retbp.getFieldValue(i,JOB_ID)+">"); 
              }
              else
              {
                  out.println("<option value="+retbp.getFieldValue(i,JOB_ID)+">"); 
              }                   
		  jobDesc = (retbp.getFieldValue(i,JOB_DESC)).toString();	
              out.println(jobDesc);
              out.println("</option>"); 

	    }//End for
         out.println("</select>"); 
	}
%>