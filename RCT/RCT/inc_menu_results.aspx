
            <br />
            <table border="0" cellpadding="0" cellspacing="0" class="TopMenuTexts">
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results.aspx')">&nbsp;Results Home<br />&nbsp;R&eacute;sultats Accueil</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                
                <% If Session("userRule") = 1 Or Session("userRule") = 2 Or Session("userRule") = 3 Then%>
                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results_add.aspx')">&nbsp;Add<br />&nbsp;Ajouter</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>

                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results_import.aspx')">&nbsp;Import<br />&nbsp;Importer</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                
                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results_add_final.aspx')">&nbsp;Final<br />&nbsp;Finale</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>

                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results_search.aspx')">&nbsp;Search<br />&nbsp;Rechercher</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <% End If%>

                <tr>
                    <td height="5" colspan="3"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" bgcolor="<% Response.Write(sColorUnselect) %>" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results_consult.aspx')">&nbsp;Consult<br />&nbsp;Consulter</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>

            </table>

