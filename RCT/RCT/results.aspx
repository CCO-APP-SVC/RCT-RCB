<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->
 
 <table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ====================================== -->
            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            
            <!-- #include file="inc_menu_results.aspx" -->

            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            <!-- ====================================== -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
        <br />
        <table border="0" cellpadding="0" cellspacing="0" width="817">
        <tr>
            <td width="50%" class="TXTNormal">
            <% Response.Write(fnGetText("resultsHomePageEn"))%>
            </td>
            <td width="50%" class="TXTNormal">
            <% Response.Write(fnGetText("resultsHomePageFr"))%>
            </td>
        </table>

        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
