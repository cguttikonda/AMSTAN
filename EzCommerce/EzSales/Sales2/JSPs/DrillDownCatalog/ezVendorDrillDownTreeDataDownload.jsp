<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iFullVendorCatalog.jsp"%>
<%
	
	
	Vector alphaVect = new Vector();
	Vector alphaVect1 = new Vector();
	Vector hashValVect =null;
	
	
	alphaVect.addElement("A B");
	alphaVect.addElement("C");
	alphaVect.addElement("D E F");
	alphaVect.addElement("G");
	alphaVect.addElement("H I");
	alphaVect.addElement("J K");
	alphaVect.addElement("L M N O");
	alphaVect.addElement("P Q R");
	alphaVect.addElement("S T");
	alphaVect.addElement("U V");
	alphaVect.addElement("W X Y Z");
	
	alphaVect1.addElement("A-B");
	alphaVect1.addElement("C");
	alphaVect1.addElement("D-E-F");
	alphaVect1.addElement("G");
	alphaVect1.addElement("H-I");
	alphaVect1.addElement("J-K");
	alphaVect1.addElement("L-M-N-O");
	alphaVect1.addElement("P-Q-R");
	alphaVect1.addElement("S-T");
	alphaVect1.addElement("U-V");
	alphaVect1.addElement("W-X-Y-Z");
	
	
	
	out.println("<?xml version=\"1.0\"?>");		
	out.println("<tree id='"+id+"'>");
	
		
	
	
	String child ="0";
	String vencatNo ="",venCatDesc="";
	String venCatString="";
	String perCatNo="";
	String perCatDesc="";
	String catType="";
	
	
	if("0".equals(id))
	{
	      out.println("<item child='0' id='VC' text='Manufacturer Catalogs' select='yes'>");
	      for(int i=0;i<alphaVect.size();i++)
	      {
		  child	= "1";
		  out.println("<item child='"+child+"' id='"+alphaVect1.get(i)+"' text='"+alphaVect.get(i)+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");
	      }
	      out.println("</item>"); 	      
	      
              
	}
	
		
		if(venCatalogHT.containsKey(id))
		{    
		 
		    hashValVect =new Vector((Collection)venCatalogHT.get(id));
		   		   
		    String venCatDescT="";
		   	   
		    for(int i=0;i<hashValVect.size();i++)  {
			venCatString = hashValVect.get(i)+"";
			st = new StringTokenizer(venCatString,"$$");
			if(st!=null)
			{
				vencatNo	= st.nextToken(); 
				venCatDesc	= st.nextToken();

				venCatDesc=venCatDesc.replace('\"',' ');
				venCatDesc=venCatDesc.replace('\'',' ');	
				venCatDesc=venCatDesc.replace('<',' ');	
				venCatDesc=venCatDesc.replace('>',' ');	
				venCatDesc=venCatDesc.trim();
				venCatDescT = venCatDesc;
				venCatDescT=venCatDescT.replace('&','@');	

				venCatDesc=replaceChar(venCatDesc,'&');
			}		    	
			child = "0";
			catType="V";

			out.println("<item child='"+child+"' id='"+vencatNo+"$$"+venCatDescT+"$$"+catType+"' text='"+venCatDesc+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");
		    }
		}
		else if(!"0".equals(id))
		{
		        out.println("<item child='0' id='NODATA' text='No catalogs available'></item>");
		}
		
	  
           
	out.println("</tree>");
	
%>


<%!
	public static String replaceChar(String s, char c) 
	{
	      StringBuffer r = new StringBuffer(s.length()+4);
	      r.setLength( s.length()+4); 	       
	      int current = 0;
	      for (int i = 0; i < s.length(); i ++) 
	      {
	           char cur = s.charAt(i);
	           if (cur == c) 
	           {
	            	r.setCharAt(current++,cur);
	            	r.setCharAt(current++,'a');
	            	r.setCharAt(current++,'m');
	            	r.setCharAt(current++,'p');
	            	r.setCharAt(current++,';');
	           }	
	           else
	            	r.setCharAt( current++, cur);
	      }
	      return r.toString();
	}
%>
