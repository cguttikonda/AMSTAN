<%@ include file="../Lables/iPopUpHelp_Lables.jsp" %>
<script src = ../../Library/JavaScript/Misc/ezSalesHelp.js></script>
<script>
var myKeys= new Array()
myKeys[0]= new EzHelpKeywords("ezListSalesOrders","<%=ezListSalesOrders_H %>")
myKeys[1]= new EzHelpKeywords("ezSOSearchByOrderNo","<%=ezSOSearchByOrderNo_H %>")
myKeys[2]= new EzHelpKeywords("ezSOSearchByPONO","<%=ezSOSearchByPONO_H %>")
myKeys[3]= new EzHelpKeywords("ezSOSearchByProduct","<%=ezSOSearchByProduct_H %>")
myKeys[4]= new EzHelpKeywords("ezListPersMsgs","<%=ezListPersMsgs_H %>")
myKeys[5]= new EzHelpKeywords("ezListFolders","<%=ezListFolders_H %>")
myKeys[6]= new EzHelpKeywords("ezAddSales","<%=ezAddSales_H %>")
myKeys[7]= new EzHelpKeywords("ezOpenInvoices","<%=ezOpenInvoices_H %>")
myKeys[8]= new EzHelpKeywords("ezFullCatalog","<%=ezFullCatalog_H %>")
myKeys[9]= new EzHelpKeywords("ezCatalog","<%=ezCatalog_H %>")
myKeys[10]= new EzHelpKeywords("ezListFavGroups","<%=ezListFavGroups_H %>")
myKeys[11]= new EzHelpKeywords("ezProductSearch","<%=ezProductSearch_H %>")
myKeys[12]= new EzHelpKeywords("ezViewCart","<%=ezViewCart_H %>")
myKeys[13]= new EzHelpKeywords("ezAddSCOrder","<%=ezAddSCOrder_H %>")
myKeys[14]= new EzHelpKeywords("ezCopySalesOrder","<%=ezCopySalesOrder_H %>")
myKeys[15]= new EzHelpKeywords("ezAcCopy","<%=ezAcCopy_H %>")
myKeys[16]= new EzHelpKeywords("ezViewStockInfo","<%=ezViewStockInfo_H %>")
myKeys[17]= new EzHelpKeywords("ezCatalogFinalLevel","<%=ezCatalogFinalLevel_H %>")

myKeys[18]= new EzHelpKeywords("ezListSalesOrdersByMaterial","<%=ezListSalesOrdersByMaterial_H %>")
myKeys[19]= new EzHelpKeywords("ezSelectSoldTo","<%=ezSelectSoldTo_H %>")

myKeys[20]= new EzHelpKeywords("ezAddSelectRF","<%=ezAddSelectRF_H %>")
myKeys[21]= new EzHelpKeywords("ezAddRollingForecast","<%=ezAddRollingForecast_H %>")
myKeys[22]= new EzHelpKeywords("ezViewRollingForecast","<%=ezViewRollingForecast_H%>");
myKeys[23]= new EzHelpKeywords("ezStockAlert","<%=ezStockAlert_H%>");
myKeys[24]= new EzHelpKeywords("ezQuickSearch","<%=ezQuickSearch_H%>");

myKeys[25]= new EzHelpKeywords("ezGetDeliveryNos","<%=ezGetDeliveryNos_H %>")
myKeys[26]= new EzHelpKeywords("ezPassword","<%=ezPassword_H%>")
myKeys[27]= new EzHelpKeywords("ezGetInfo","<%=ezGetInfo_H%>")
myKeys[28]= new EzHelpKeywords("ezAddStockInfo","<%=ezAddStockInfo_H%>")
myKeys[29]= new EzHelpKeywords("ezViewOrders","<%=ezViewOrders_H%>")
myKeys[30]= new EzHelpKeywords("ezViewDispatchInfo","<%=ezViewDispatchInfo_H %>")
myKeys[31]= new EzHelpKeywords("ezViewReceivedDel","<%=ezViewReceivedDel_H %>");
myKeys[32]= new EzHelpKeywords("ezAddProjectionsByCM","<%=ezAddProjectionsByCM_H %>");
myKeys[33]= new EzHelpKeywords("ezEditProjections","<%=ezEditProjections_H %>");
myKeys[34]= new EzHelpKeywords("ezViewProjections","<%=ezViewProjections_H %>");
myKeys[35]= new EzHelpKeywords("ezViewProjectionPerform","<%=ezViewProjectionPerform_H%>");
myKeys[36]= new EzHelpKeywords("ezViewByCountry","<%=ezViewByCountry_H%>");
myKeys[37]= new EzHelpKeywords("ezWelcome","<%=ezWelcome_H%>");
myKeys[38]= new EzHelpKeywords("ezBackEndSOList","<%=ezBackEndSOList_H%>");
myKeys[39]= new EzHelpKeywords("ezBackEndSODetails","<%=ezBackEndSODetails_H%>");
myKeys[40]= new EzHelpKeywords("ezCreditDSS","<%=ezCreditDSS_H%>");
myKeys[41]= new EzHelpKeywords("ezOrdersDSS","<%=ezOrdersDSS_H%>");
myKeys[42]= new EzHelpKeywords("ezProjectionPerformDSS","<%=ezProjectionPerformDSS_H %>");
myKeys[43]= new EzHelpKeywords("ezStockDSS","<%=ezStockDSS_H %>");
myKeys[44]= new EzHelpKeywords("ezMultiEntryBulkSales","<%=ezMultiEntryBulkSales_H %>");
myKeys[45]= new EzHelpKeywords("iGetPricesBulk","<%=iGetPricesBulk_H %>");
myKeys[46]= new EzHelpKeywords("ezDisplay","<%=ezDisplay_H%>");
myKeys[47]= new EzHelpKeywords("ezViewBackEndSalesDetails","<%=ezViewBackEndSalesDetails_H%>");
myKeys[48]= new EzHelpKeywords("ezListViewDelSchedule","<%=ezListViewDelSchedule_H%>");
myKeys[49]= new EzHelpKeywords("ezGetDeliveryBySO","<%=ezGetDeliveryBySO_H%>");
myKeys[50]= new EzHelpKeywords("ezBackEndClosedSOList","<%=ezBackEndClosedSOList_H%>");
myKeys[51]= new EzHelpKeywords("ezListViewDelSchedule","<%=ezListViewDelSchedule_H%>");

myKeys[52]= new EzHelpKeywords("ezAddSalesOrder","<%=ezAddSalesOrder_H%>");
myKeys[53]= new EzHelpKeywords("ezOutMsg","<%=ezOutMsg_H%>");
myKeys[54]= new EzHelpKeywords("ezEditStockInfoByCU","<%=ezEditStockInfoByCU_H%>");
myKeys[55]= new EzHelpKeywords("ezAddReturnSalesOrder","<%=ezAddReturnSalesOrder_H%>");

myKeys[56]= new EzHelpKeywords("ezAddGroup","<%=ezAddGroup_H%>");
myKeys[57]= new EzHelpKeywords("ezGroupDesc","<%=ezGroupDesc_H%>");
myKeys[58]= new EzHelpKeywords("ezPageHelp","<%=ezPageHelp_H%>");
myKeys[59]= new EzHelpKeywords("ezRunProductSearch","<%=ezRunProductSearch_H%>");

myKeys[60]= new EzHelpKeywords("ezListFolder","<%=ezListFolder_H%>");
myKeys[61]= new EzHelpKeywords("ezComposePersMsg","<%=ezComposePersMsg_H%>");
myKeys[62]= new EzHelpKeywords("ezInvoiceDetails","<%=ezInvoiceDetails_H%>");
myKeys[63]= new EzHelpKeywords("ezPaymentDetails","<%=ezPaymentDetails_H%>");
myKeys[64]= new EzHelpKeywords("ezViewDeliveryDetails","<%=ezViewDeliveryDetails_H%>");

myKeys[65]= new EzHelpKeywords("ezInvoicesAging","<%=ezInvoicesAging_H%>");
myKeys[66]= new EzHelpKeywords("ezAddProjections","<%=ezAddProjections_H%>");
myKeys[67]= new EzHelpKeywords("ezDisplayReturn","<%=ezDisplayReturn_H%>");
myKeys[68]= new EzHelpKeywords("ezEditStockInfo","<%=ezEditStockInfo_H%>");
myKeys[69]= new EzHelpKeywords("ezContactInfo","<%=ezContactInfo_H%>");
myKeys[70]= new EzHelpKeywords("ezProductInfo","<%=ezProductInfo_H%>");

myKeys[71]= new EzHelpKeywords("ezGetPricesSh","<%=ezGetPricesSh_H%>");

myKeys[72]= new EzHelpKeywords("ezDeleteStockInfo","<%=ezDeleteStockInfo_H%>");
myKeys[73]= new EzHelpKeywords("ezMatBonusList","<%=ezMatBonusList_H%>");
myKeys[74]= new EzHelpKeywords("ezMatStockBatchList","<%=ezMatStockBatchList_H%>");
myKeys[75]= new EzHelpKeywords("ezMatPriceList","<%=ezMatPriceList_H%>");

myKeys[76]= new EzHelpKeywords("ezMatStockExpiryList","<%=ezMatStockExpiryList_H%>");
myKeys[77]= new EzHelpKeywords("ezMatStockList","<%=ezMatStockList_H%>");
myKeys[78]= new EzHelpKeywords("ezMatStockExpiryBatchList","<%=ezMatStockExpiryBatchList_H%>");
myKeys[79]= new EzHelpKeywords("ezAddDelSchedule","<%=ezAddDelSchedule_H%>");

myKeys[80]= new EzHelpKeywords("ezPersMsgDetails","<%=ezPersMsgDetails_H%>");
myKeys[81]= new EzHelpKeywords("ezReplyPersMsg","<%=ezReplyPersMsg_H%>");
myKeys[82]= new EzHelpKeywords("ezCopyAddSalesOrder","<%=ezCopyAddSalesOrder_H%>");
myKeys[83]= new EzHelpKeywords("ezBackEndFRSList","<%=ezBackEndFRSList_H%>");
myKeys[84]= new EzHelpKeywords("ezBackEndClosedReturnList","<%=ezBackEndClosedReturnList_H%>");
myKeys[85]= new EzHelpKeywords("ezBackEndOpenReturnList","<%=ezBackEndOpenReturnList_H%>");
myKeys[86]= new EzHelpKeywords("ezCustInvoiceDetails","<%=ezCustInvoiceDetails_H%>");
myKeys[87]= new EzHelpKeywords("ezSOPaymentDetails","<%=ezSOPaymentDetails_H%>");
myKeys[88]= new EzHelpKeywords("ezClosedInvoices","<%=ezClosedInvoices_H%>");
myKeys[89]= new EzHelpKeywords("ezFavGroupFinalLevel","<%=ezFavGroupFinalLevel_H%>");
myKeys[90]= new EzHelpKeywords("ezDisclaimer","<%=ezDisclaimer_H%>");
myKeys[91]= new EzHelpKeywords("ezDeleteFavGroup","<%=ezDeleteFavGroup_H%>");
myKeys[92]= new EzHelpKeywords("ezAddSalesSh","<%=ezAddSalesSh_H%>");
myKeys[93]= new EzHelpKeywords("ezAddFolder","<%=ezAddFolder_H%>");
myKeys[94]= new EzHelpKeywords("ezViewDispatchLocal","<%=ezViewDispatchLocal_H%>");
myKeys[95]= new EzHelpKeywords("ezViewDispatches","<%=ezViewDispatches_H%>");
myKeys[96]= new EzHelpKeywords("ezShowInfo","<%=ezShowInfo_H%>");
myKeys[97]= new EzHelpKeywords("ezIndexCU","<%=ezIndexCU_H%>");
myKeys[98]= new EzHelpKeywords("ezViewDespDetails","<%=ezViewDespDetails_H%>"); 
myKeys[99]= new EzHelpKeywords("ezViewDespDetailsLocal","<%=ezViewDespDetailsLocal_H%>");
myKeys[100]= new EzHelpKeywords("ezSavePassword","<%=ezSavePassword_H%>");
myKeys[101]= new EzHelpKeywords("ezAddProducts","<%=ezAddProducts_H%>");

<%----myKeys[102]= new EzHelpKeywords("ezCreateSalesOrder"     ,"Select a catalog and enter Purchase order No , Required Date for the selected product(s) and click on <b>'Prepare Order'</b> button to proceed.....");
myKeys[103]= new EzHelpKeywords("ezProductEntry"         ,"Enter Product No and quantity , Product Description and CaseLot would be visible for the entered product.Click on the <b>'Get Prices'</b> button to proceed. ");
myKeys[104]= new EzHelpKeywords("ezAddProductEntryToCart","Enter PO No(Purchase Order Number), Required Date ,quantity and click on <b>'Get Prices'</b> button to proceed ...... ");
myKeys[105]= new EzHelpKeywords("ezSavedOrdersList"      ,"Saved Orders are orders not yet submitted to SAP,can be edited before submitting.");
myKeys[106]= new EzHelpKeywords("ezGridOpenInvoices"     ,"Displaying <b>'Open Invoice List'</b> along with invoice value. You can view the details of an invoice by clicking on   <b>'Invoice. No'</b>. You can view the Delivery details of an invoice by clicking on   <b>'Delv.Doc.No'</b>.");
myKeys[107]= new EzHelpKeywords("ezGridClosedInvoices"   ,"Displaying <b>'Closed Invoice List'</b> along with invoice value. You can view the details of an invoice by clicking on <b>'Invoice. No'</b>.");
myKeys[108]= new EzHelpKeywords("ezListNews"             ,"To view news corresponding to sales area displayed in the select box .News type 'Global' is for both customer as well as for internal user but 'Private' is only for internal user");
myKeys[109]= new EzHelpKeywords("ezAddNews"              ,"To add  news corresponding to sales area displayed in the select box .News type 'Global' is for both customer as well as for internal user but 'Private' is only for internal user");
myKeys[110]= new EzHelpKeywords("ezEditNews"		 ,"To edit news corresponding to sales area displayed in the select box .News type 'Global' is for both customer as well as for internal user but 'Private' is only for internal user");
myKeys[111]= new EzHelpKeywords("ezEditSales"		 ,"The order can be edited before submitting to SAP or again can saved to local.");
myKeys[112]= new EzHelpKeywords("ezImageUpload"		 ,"To Upload a image click on <b>Attach</b>.A new window will be popped browse the image path and then Click on <b>Add file</b>");
myKeys[113]= new EzHelpKeywords("ezDrillDownCatalog"	 ,"Click on product groups(left) to view the products in that group.To add products to cart select the products and click on <b>Add To Cart</b>.To view products in the cart click on <b>ViewCart</b>");
myKeys[114]= new EzHelpKeywords("ezListFavGroups"	 ,"Click on <b>'Create Group'</b> to create a new Group.Click on <b>'Change description'</b> to change Group description .Click on <b>'Change description'</b> to delete Group .A message will displayed if no groups are created");
myKeys[115]= new EzHelpKeywords("ezRunProductSearch"	 ,"Displaying product you are searching for.Select the product and click on <b>'Add To Card'</b> button to add it to the shopping cart.<br> select the product, group and click on  <b>'Add to My Group' </b>button to add the product in your personalized catalog. Click on the product hyperlink to view product image.");-------%>


myKeys[102]= new EzHelpKeywords("ezCreateSalesOrder"     ,"<%=ezCreateSalesOrder_H%>");
myKeys[103]= new EzHelpKeywords("ezProductEntry"         ,"<%=ezProductEntry_H%>");
myKeys[104]= new EzHelpKeywords("ezAddProductEntryToCart","<%=ezAddProductEntryToCart_H%>");
myKeys[105]= new EzHelpKeywords("ezSavedOrdersList"      ,"<%=ezSavedOrdersList_H%>");
myKeys[106]= new EzHelpKeywords("ezGridOpenInvoices"     ,"<%=ezGridOpenInvoices_H%>");
myKeys[107]= new EzHelpKeywords("ezGridClosedInvoices"   ,"<%=ezGridClosedInvoices_H%>");
myKeys[108]= new EzHelpKeywords("ezListNews"             ,"<%=ezListNews_H%>");
myKeys[109]= new EzHelpKeywords("ezAddNews"              ,"<%=ezAddNews_H%>");
myKeys[110]= new EzHelpKeywords("ezEditNews"		 ,"<%=ezEditNews_H%>");
myKeys[111]= new EzHelpKeywords("ezEditSales"		 ,"<%=ezEditSales_H%>");
myKeys[112]= new EzHelpKeywords("ezImageUpload"		 ,"<%=ezImageUpload_H%>");
myKeys[113]= new EzHelpKeywords("ezDrillDownCatalog"	 ,"<%=ezDrillDownCatalog_H%>");
myKeys[114]= new EzHelpKeywords("ezFaqs" 		 ,"Frequently Asked questions are avialable here.Each query has  (Take a Tour) hyperlink for visual representation.");
myKeys[115]= new EzHelpKeywords("ezShowDetails"		 ,"You can view the details of a particular sales order");
myKeys[116]= new EzHelpKeywords("ezListWebStatsBySBU"	 ,"You can view the login details from a particular sales area or all");
myKeys[117]= new EzHelpKeywords("ezTimeStats"		 ,"You can view the user frequency in between different time periods from a particular sales area or all");
myKeys[118]= new EzHelpKeywords("ezShowDetails"		 ,"You can view the user frequency from a particular sales area or all");


var ezPageHelp = "<%=ezPageHelp_H%>"
</script>
