
            <br />
            <table border="0" cellpadding="0" cellspacing="0" class="TopMenuTexts">
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('admin.aspx')">&nbsp;Admin Home<br />&nbsp;Admin Accueil</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                
                <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('admin_regions.aspx')">&nbsp;Regions<br />&nbsp;Régions</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <% End If%>
                
                <% If Session("userRule") = 1 Then%>
                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('admin_users.aspx')">&nbsp;Users<br />&nbsp;Usagers</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <% End If%>

            </table>

