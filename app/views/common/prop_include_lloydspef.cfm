
<style>
body, p {font-size:12px !important; line-height:16px;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px; text-align:left;}

</style>
<cfoutput>
<p style="text-align:center;">
THIS ENDORSEMENT CHANGES THE POLICY. PLEASE READ IT CAREFULLY.
</p>
<p style="text-align:center;">
<b>COMMERCIAL PROPERTY EXTENSION</b>
</p>
<p style="text-align:center;">
This endorsements modifies insurance provided under the following:<br>
<b>BUILDING AND PERSONAL PROPERTY COVERAGE FORM<br>
CAUSES OF LOSS - SPECIAL FORM</b>
</p>
<p style="text-align:center; padding-top:30px;">
<b>SCHEDULE</b>
</p>
<table style="width:100%;" cellpadding="2" cellspacing="0">
<tr>
  <th>COVERAGE</th>
  <th>LIMIT OF INSURANCE</th>
</tr>
<tr>
	<td>Accounts Receivable</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Computer Equipment</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Outdoor Signs</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Spoilage</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Valuable Papers</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Money and Securities</td>
  <td>$10,000</td>
</tr>
<tr>
	<td>Water Backup or Overflow of Sewers and Drains</td>
  <td>$5,000</td>
</tr>
<tr>
	<td>Employee Dishonesty</td>
  <td>$10,000</td>
</tr>
</table>

<ol type="a">
	<li>Test</li>
  <li>Test 2</li>
</ol>
<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#
<cfif client.epli_prioracts eq 1><p><p>Coverage includes Full Prior Acts</p></p></cfif>

</cfoutput>