<%@ include file="../../../Includes/Jsps/Purorder/iListPO.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListPO_Labels.jsp"%>


<%!
    public void searchLong(ReturnObjFromRetrieve returnobjfromretrieve, String s, String s1)
    {
        s1 = s1 != null ? s1.toUpperCase() : "null";
        int i = s1.indexOf("*");
        int j = s1.length();
               
        int k = returnobjfromretrieve.getRowCount();
        Object obj = null;
        Object obj1 = null;
        if(s1.length() == 0)
            return ;
        int delcount=0;    
        if(i == -1)
        {
            for(int l = k - 1; l >= 0; l--)
            {
            	try
            	{
                String s2 = returnobjfromretrieve.getFieldValueString(l, s.toUpperCase());
                       
                
                
                
                if(s2 != null && !s2.equals(s1)){
                    System.out.println("POSITION IN RETOBJ = "+l+"***PONUMBER FIELD NAME = "+s+"***PONUMBER =" +s2+"***SEARCHING PO NUMBER ="+s1);
                    returnobjfromretrieve.deleteRow(l);
                    
                    delcount++;
                    
                    
                } 
                } catch(Exception ee){}    
            }

        } else if(i == 0)
        {
            String s5 = s1.substring(1, j);
            for(int i1 = k - 1; i1 >= 0; i1--)
            {
                String s3 = returnobjfromretrieve.getFieldValueString(i1, s.toUpperCase()).trim();
                try
                {
                    s3 = String.valueOf(Long.parseLong(s3));
                }
                catch(Exception exception1)
                {
                    s3 = s3;
                }
                if(s3 != null && !s3.endsWith(s5))
                    returnobjfromretrieve.deleteRow(i1);
            }

        } else  if(i == j - 1)
        {
          
            String s6 = s1.substring(0, j - 1);
            k = returnobjfromretrieve.getRowCount();               	  
            for(int j1 = k - 1; j1 >= 0; j1--)
            {
               
               String s4 = returnobjfromretrieve.getFieldValueString(j1, s.toUpperCase());
                try
                {
                    s4 = String.valueOf(Long.parseLong(s4));
                }
                catch(Exception exception2)
                {
                    s4 = s4;
                }
                if(s4 != null && !s4.startsWith(s6))
                {
                    returnobjfromretrieve.deleteRow(j1);
                    System.out.println("delete Row ID =======>>"+j1);
                    System.out.println("s4 =======>>s6 : "+s4+"========>"+s6);
                }
               
            }                        

        }
    }
%>

<%
	public static String[] fieldNames = {
			"ORDER",
			"ORDERORIGIN",
			"PARTNERIDSUPP",
			"SUPPLIERDESCRIPTION",
			"ORDERTYPE",
			"POSTALCODE",
			"FINANCIALCOMPANY",
			"CONTRACT",
			"ROUTEPLAN",
			"ORDERDATE",
			"DELIVERYDATE",
			"CONFIRMDELIVERYDATE",
			"REFERENCEA",
			"WAREHOUSE",
			"REFERENCEB",
			"ORDERDISCOUNT",
			"DELIVERYTERMS",
			"PAYMENTTERMSID",
			"BUYER",
			"COUNTRY",
			"LANGUAGE",
			"CURRENCY",
			"PURCHASERATE",
			"RATEFACTOR",
			"LATEPAYMENTSURCHARGE",
			"PURCHASEPRICELIST",
			"SUPPLIERPRICE",
			"SUPPLIERTEXT",
			"FORWARDINGAGENT",
			"AREA",
			"LINEOFBUSINESS",
			"TAXYN",
			"REMITTANCEAGREEMENT",
			"GENERATEDFOREDI",
			"FINANCIALSUPPLIER",
			"FROMSITE",
			"RECORDSTATUS",
		   	"VENDOR_NUMBER",
		   	"VENDOR_NAME",
		   	"COST_CENTER",
			"CASHDISCOUNT1",
			"CASHDISCOUNT2",
			"DISCOUNT1",
			"DISCOUNT2",
			"DISCOUNT3",
			"MINPLANNEDDELDAYS",
			"MAXPLANNEDDELDAYS",
			"EXCHANGERATE",
			"NETAMOUNT",
			"COMPCODE"
	
	};
	
	ezc.ezparam.ReturnObjFromRetrieve ret = ezc.ezparam.ReturnObjFromRetrieve(fieldNames);
	
	
	if(hdrXML!=null)
	{
		for(int j=0;j<hdrXML.getRowCount();j++)
		{
			for(int k=0;k<fieldNames.length;k++){
				ret.setFieldValue(fieldNames[k],hdrXML.getFieldValue(j,fieldNames[k]));
			}
			
		
		}
	
	}
	
		searchLong(ret,"ORDER",poToSearch); 

%>

