<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 
<link href="../resources/css/demo.css" rel="stylesheet"/> 
<link href="../resources/css/hospitalization.css" rel="stylesheet"/>
<style>
.mygrid{
	border : 1px solid black;
}
.mygrid-title{
	text-align : right;
	font-size : 0.8 rem;
}
.gs-id-0 > .grid-stack-item[gs-h="5"] {
    height: 108%;
}
.gs-id-0 > .grid-stack-item[gs-x="6"] {
    left: 930px;
}
.gs-id-0 > .grid-stack-item[gs-y="0"] {
    top: -10px;
}
.gs-id-0 > .grid-stack-item[gs-x="0"] {
    left : -27px;
}
.gs-12>.grid-stack-item[gs-w="6"] {
     width: 52%; 
} 
#outHosReceiptDoc {
	position: fixed;
	width: 1100px;
	height: 750px;
	background-color: white;
	display: none;
	left: 21.5%;
	top: 12%;
	z-index: 9999;
	box-shadow: 2px 2px 2px 2px gray;
	padding : 30px 50px;
}

</style>
<div class="grid-stack"></div>
<!-- /////////////////////////////////////////////////////////////////퇴원 영수증 모달 시작////////////////////////////////////////////////////////////////// -->
<div  id="outHosReceiptDoc">
<table class="MsoTableGrid" border="1" cellspacing="0" cellpadding="0" style="width : 100%; height : 90%; border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt; overflow-y: scroll; display: block;">
 <tbody><tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes">
  <td width="912" colspan="8" valign="top" style="width:684.35pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span style="font-size:16.0pt">외래 입원<span lang="EN-US">(</span>퇴원<span lang="EN-US">) </span>진료비 계산서 </span><span style="font-size:16.0pt;mso-bidi-font-family:굴림">· 영수증</span><span lang="EN-US" style="font-size:16.0pt"><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:1">
  <td width="220" colspan="2" valign="top" style="width:165.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">환자등록번호</p>
  </td>
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">환자성명</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">진료기간</p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">병실</p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">비고</p>
  </td>
  <td width="116" valign="top" style="width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">영수증 번호</p>
  </td>
  <td width="115" valign="top" style="width:86.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">기타</p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:2">
  <td width="220" colspan="2" valign="top" style="width:165.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatNo"></span></p>
  </td>
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatName"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatTime"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatRoom"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatRemark"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oHosNo"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="115" valign="top" style="width:86.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oHosETC"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:3">
  <td width="338" colspan="3" valign="top" style="width:253.15pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">항목</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="a" align="center" style="text-align:center"><span style="font-family:
  굴림;mso-ascii-font-family:함초롬바탕">총액</span><span style="mso-fareast-font-family:
  함초롬바탕;mso-hansi-font-family:함초롬바탕;mso-bidi-font-family:함초롬바탕">①</span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="a" align="center" style="text-align:center"><span style="font-family:
  굴림;mso-ascii-font-family:함초롬바탕">공단부담금</span><span style="mso-fareast-font-family:
  함초롬바탕;mso-hansi-font-family:함초롬바탕;mso-bidi-font-family:함초롬바탕">②</span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="a" align="center" style="text-align:center"><span style="font-family:
  굴림;mso-ascii-font-family:함초롬바탕; font-size : 0.7rem;">본인부담금</span><span style="mso-fareast-font-family:
  함초롬바탕;mso-hansi-font-family:함초롬바탕;mso-bidi-font-family:함초롬바탕">①<span lang="EN-US">-</span>②</span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="a" align="center" style="text-align:center"><span style="font-family:
  굴림;mso-ascii-font-family:함초롬바탕">납부금액</span><span style="mso-fareast-font-family:
  함초롬바탕;mso-hansi-font-family:함초롬바탕;mso-bidi-font-family:함초롬바탕">③</span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:4">
  <td width="220" colspan="2" rowspan="6" valign="top" style="width:165.3pt;border:
  solid windowtext 1.0pt;border-top:none;mso-border-top-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">필수항목</p>
  </td>
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">진 찰 료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRClinicPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRClinicPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRClinicPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRClinicPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:5">
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">검 사 료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRInspcPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRInspcPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRInspcPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRInspcPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:6">
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">처 치 료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTreatPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTreatPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTreatPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTreatPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:7">
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">물리치료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPhysioPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPhysioPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPhysioPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPhysioPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:8">
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">처방료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPresPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPresPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPresPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRPresPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:9">
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">입원료</p>
  </td>
  <td width="111" valign="top" style="width:83.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRHosptzPayTotal"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRHosptzPayCorp"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRHosptzPaySelf"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRHosptzPayment"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:10">
  <td width="912" colspan="8" valign="top" style="width:684.35pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:11" id="vTr">
  <td width="111" valign="top" style="width:83.55pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">항목</p>
  </td>
  <td width="109" valign="top" style="width:81.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">일자</p>
  </td>
  <td width="117" valign="top" style="width:87.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">수납코드</p>
  </td>
  <td width="227" valign="top" style="width:170.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">명칭</p>
  </td>
  <td width="116" valign="top" style="width:87.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">금액</p>
  </td>

  <td width="116" valign="top" style="width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">공단부담금</p>
  </td>
  <td width="115" valign="top" style="width:86.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">본인부담금</p>
  </td>
  <td width="115" valign="top" style="width:86.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">납부금액</p>
  </td>
 </tr></tbody>
 <tbody id="tbodySec2" >
 </tbody>
 <tbody>
 <tr style="mso-yfti-irow:19" id="lastTR1">
  <td width="338" colspan="3" valign="top" style="width:253.15pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="344" colspan="3" valign="top" style="width:257.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="left" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal;tab-stops:120.0pt"><span lang="EN-US">총 액</span></p>
  </td>
  <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="right" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTotalPrice"></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:20" id="lastTR2">
  <td width="338" colspan="3" valign="top" style="width:253.15pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="344" colspan="3" valign="top" style="width:257.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US">총 납부금액</span></p>
  </td>
    <td width="231" colspan="2" valign="top" style="width:173.4pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="right" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:right;line-height:normal"><span lang="EN-US" id="oRTotalSelfPrice"></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:21;mso-yfti-lastrow:yes" id="lastTR3">
  <td width="338" colspan="3" valign="top" style="width:253.15pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="344" colspan="3" valign="top" style="width:257.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="116" valign="top" style="width:87.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal">성명</p>
  </td>
  <td width="115" valign="top" style="width:86.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
  text-align:center;line-height:normal"><span lang="EN-US" id="oRPatName2"><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
</tbody></table>
<div style="text-align : right; margin-top : 20px;">
	<button class="btn btn-primary" onclick="fOutHosReceipt()">수납</button>
	<button class="btn btn-secondary" onclick="fModalClose()">닫기</button>
</div>
</div>
<!-- /////////////////////////////////////////////////////////////////퇴원 영수증 모달 끝////////////////////////////////////////////////////////////////// -->
<script>
const oRPatNo            = $('#oRPatNo');
const oRPatName          = $('#oRPatName');
const oRPatTime          = $('#oRPatTime');
const oRPatRoom          = $('#oRPatRoom');
const oRPatRemark        = $('#oRPatRemark');
const oHosNo             = $('#oHosNo');
const oHosETC            = $('#oHosETC');
const oRClinicPayTotal   = $('#oRClinicPayTotal');
const oRClinicPayCorp    = $('#oRClinicPayCorp');
const oRClinicPaySelf    = $('#oRClinicPaySelf');
const oRClinicPayment    = $('#oRClinicPayment');
const oRInspcPayTotal    = $('#oRInspcPayTotal');
const oRInspcPayCorp     = $('#oRInspcPayCorp');
const oRInspcPaySelf     = $('#oRInspcPaySelf');
const oRInspcPayment     = $('#oRInspcPayment');
const oRTreatPayTotal    = $('#oRTreatPayTotal');
const oRTreatPayCorp     = $('#oRTreatPayCorp');
const oRTreatPaySelf     = $('#oRTreatPaySelf');
const oRTreatPayment     = $('#oRTreatPayment');
const oRPhysioPayTotal   = $('#oRPhysioPayTotal');
const oRPhysioPayCorp    = $('#oRPhysioPayCorp');
const oRPhysioPaySelf    = $('#oRPhysioPaySelf');
const oRPhysioPayment    = $('#oRPhysioPayment');
const oRPresPayTotal     = $('#oRPresPayTotal');
const oRPresPayCorp      = $('#oRPresPayCorp');
const oRPresPaySelf      = $('#oRPresPaySelf');
const oRPresPayment      = $('#oRPresPayment');
const oRHosptzPayTotal   = $('#oRHosptzPayTotal');
const oRHosptzPayCorp    = $('#oRHosptzPayCorp');
const oRHosptzPaySelf    = $('#oRHosptzPaySelf');
const oRHosptzPayment    = $('#oRHosptzPayment');
const oRTotalPrice       = $('#oRTotalPrice');
const oRTotalSelfPrice       = $('#oRTotalSelfPrice');
const oRPatName2         = $('#oRPatName2');
const tbodySec2 = $('#tbodySec2');
const lastTR1 = $('#lastTr1');
const lastTR2 = $('#lastTr2');
const lastTR3 = $('#lastTr3');
const gr1 = 
	`
	<div style="padding : 30px; height : 100%;">
		<div style="text-align : left; margin-bottom : 20px;">
			<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:102px;">입/퇴원 관리</h5>
		</div>
		<div style="height : 93%;">
			<div class="nav-align-top mb-4" style="height : 100%;">
		      <ul class="nav nav-tabs" role="tablist">
		        <li class="nav-item" role="presentation">
		          <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#inHosptailzation" aria-controls="navs-top-home" aria-selected="true">입원</button>
		        </li>
		        <li class="nav-item" role="presentation">
		          <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#outHosptailzation" aria-controls="navs-top-profile" aria-selected="false" tabindex="-1">퇴원</button>
		        </li>
		
		      </ul>
		      <div class="tab-content" style="height : 100%;">
		        <div class="tab-pane fade show active" id="inHosptailzation" role="tabpanel">
		            <table class="table table-hover">
			            <thead>
			               <tr>
			                  <th>순번</th>
			                  <th>입원코드</th>
			                  <th>환자코드</th>
			                  <th>환자명</th>
			                  <th>퇴원예정일</th>
			                  <th>수속</th>
			               </tr>
			            </thead>
			            <tbody class="table-border-bottom-0" id="inHosBody">
			               <tr>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			               </tr>
			            </tbody>
		         	</table>
		        </div>
		        <div class="tab-pane fade" id="outHosptailzation" role="tabpanel">
		            <table class="table table-hover">
			            <thead>
			               <tr>
			                  <th>순번</th>
			                  <th>입원코드</th>
			                  <th>환자코드</th>
			                  <th>환자명</th>
			                  <th>입원일자</th>
			                  <th>퇴원</th>
			               </tr>
			            </thead>
			            <tbody class="table-border-bottom-0" id="outHosBody">
			               <tr>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			               </tr>
			            </tbody>
	         		</table>		          
		        </div>
		       
		      </div>
		    </div>
		</div>
	</div>
	`;
const gr2 = 
	`
	<div id="gr2Div" style="padding : 30px; height : 100%;">
		<div style="display : flex;">
			<div style="text-align : left; margin-bottom : 20px; width : 70%;">
				<h5>입/퇴원 제증명</h5>
				<hr>
			</div>
			<div style="text-align : right; margin-bottom : 20px; width : 30%;">
				<div id="inHosBtnDiv">
					<button class="btn btn-primary" onclick="fSavePdf('in')">다운로드 및 출력</button>
					<button class="btn btn-info" onclick="fCheckInPat()">수속</button>
				</div>
				<div id="outHosBtnDiv" style="display : none;">
					<button class="btn btn-primary" onclick="fSavePdf('out')">다운로드 및 출력</button>
					<button class="btn btn-info" onclick="fOpenOutPatDoc()">영수증</button>
				</div>
			</div>
		</div>
		
		<div class="hpa" id="inHosDocument" style="width: 210mm; height: 297mm;">
			<div class="hcD" style="left: 15mm; top: 10mm;">
				<input type="hidden" id="inHosPatCode"/>
				<div class="hcI">
					<div class="hls ps0"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 0mm;"></div>
					<div class="hls ps4"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 234.77mm; height: 3.53mm; width: 180mm;"></div>
					<div class="hls ps5"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 240.42mm; height: 3.53mm; width: 180mm;">
						<span class="hrt cs2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신청일
							:
							<span id="hosReqDate"></span></span>
					</div>
					<div class="hls ps5"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 246.06mm; height: 3.53mm; width: 180mm;">
						<span class="hrt cs2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</div>
					<div class="hls ps5"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 251.71mm; height: 3.53mm; width: 180mm;">
						<span class="hrt cs2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서약인(인)
							: <span id="hosReqPerson"></span></span>
					</div>
					<div class="hls ps5"
						style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 257.35mm; height: 3.53mm; width: 180mm;"></div>
					<div class="hls ps6"
						style="line-height: 4.44mm; white-space: nowrap; left: 0mm; top: 262.91mm; height: 5.29mm; width: 180mm;">
						<span class="hrt cs19">대덕 아작(나)스 병원</span>
					</div>
				</div>
			</div>
			<div class="htb"
				style="left: 16.01mm; width: 180.69mm; top: 11.01mm; height: 234.95mm;">
				<svg class="hs" viewBox="-2.50 -2.50 185.69 239.95"
					style="left: -2.50mm; top: -2.50mm; width: 185.69mm; height: 239.95mm;">
					<path d="M0,0 L0,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M21.66,43.14 L21.66,79.18"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M46.23,43.14 L46.23,55.16"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M64.98,43.14 L64.98,55.16"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M97.70,43.14 L97.70,79.18"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M123.33,43.14 L123.33,79.18"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M178.68,0 L178.68,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,0 L178.83,0"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,43.14 L178.83,43.14"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,55.16 L178.83,55.16"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M21.51,67.17 L178.83,67.17"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,79.18 L178.83,79.18"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,232.94 L178.83,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M178.68,0 L178.68,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M0,0 L0,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,232.94 L178.83,232.94"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path>
					<path d="M-0.15,0 L178.83,0"
						style="stroke:#000000;stroke-linecap:butt;stroke-width:0.30;"></path></svg>
				<div class="hce"
					style="left: 0mm; top: 0mm; width: 178.68mm; height: 43.14mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 8.77mm;">
							<div class="hls ps3"
								style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: -0.19mm; height: 3.88mm; width: 175.08mm;"></div>
							<div class="hls ps3"
								style="line-height: 4.80mm; white-space: nowrap; left: 0mm; top: 5.93mm; height: 5.64mm; width: 175.08mm;">
								<span class="hrt cs4">입 원 서 약 서</span>
							</div>
							<div class="hls ps3"
								style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 15.05mm; height: 3.88mm; width: 175.08mm;"></div>
							<div class="hls ps1"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 21.29mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입원일자
									: &nbsp;</span><span class="hrt cs1" id="inHosDate">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 0mm; top: 43.14mm; width: 21.66mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 18.06mm;">
								<span class="hrt cs6">성 명</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 21.66mm; top: 43.14mm; width: 24.57mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 20.97mm;">
								<span id="inHosName"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 46.23mm; top: 43.14mm; width: 18.75mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 1.38mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 15.14mm;">
								<span class="hrt cs6">입원</span>
							</div>
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 4.92mm; height: 3.17mm; width: 15.14mm;">
								<span class="hrt cs6">등록번호</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 64.98mm; top: 43.14mm; width: 32.72mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 29.11mm;">
								<span id="inHosNo"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 97.70mm; top: 43.14mm; width: 25.63mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 22.03mm;">
								<span class="hrt cs6">담당의</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 123.33mm; top: 43.14mm; width: 55.35mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 51.75mm;">
								<span id="inHosDoctor"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 0mm; top: 55.16mm; width: 21.66mm; height: 24.02mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 9.93mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 18.06mm;">
								<span class="hrt cs6">주 소</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 21.66mm; top: 55.16mm; width: 76.04mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 72.43mm;">
								<span id="inHosAddr"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 97.70mm; top: 55.16mm; width: 25.63mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 22.03mm;">
								<span class="hrt cs6">주민등록번호</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 123.33mm; top: 55.16mm; width: 55.35mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 51.75mm;">
								<span id="inHosIhid"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 21.66mm; top: 67.17mm; width: 76.04mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 72.43mm;">
								<span id="inHosDtlAddr"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 97.70mm; top: 67.17mm; width: 25.63mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 22.03mm;">
								<span class="hrt cs6">연락처</span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 123.33mm; top: 67.17mm; width: 55.35mm; height: 12.01mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 3.92mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 51.75mm;">
								<span id="inHosTel"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="hce"
					style="left: 0mm; top: 79.18mm; width: 178.68mm; height: 153.76mm;">
					<div class="hcD" style="left: 1.80mm; top: 0.49mm;">
						<div class="hcI" style="top: 11.58mm;">
							<div class="hls ps3"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: -0.16mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs18">본인은 귀원에 입원함에 있어서 아래 사항을 엄수하며,&nbsp;</span>
							</div>
							<div class="hls ps3"
								style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 4.90mm; height: 3.53mm; width: 175.08mm;">
								<span class="hrt cs18">이를 위배 할 때에는 귀원의 어떠한 조치에도 이의를 제기하지
									않음을 서약합니다. &nbsp;</span><span class="hrt cs7">&nbsp;&nbsp;</span><span
									class="hrt cs8">&nbsp;&nbsp;&nbsp;</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 10.57mm; height: 3.17mm; width: 175.08mm;"></div>
							<div class="hls ps2"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 15.65mm; height: 3.17mm; width: 175.08mm;">
								<div class="hhe"
									style="display: inline-block; margin-left: 0mm; width: 3.17mm; height: 3.17mm;">
									<span class="hrt cs8" style="font-size: 9pt;">-</span>
								</div>
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;아
									&nbsp;&nbsp;&nbsp;래 &nbsp;&nbsp;-</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 20.73mm; height: 3.17mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 25.81mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.
									입원 기간 중 의료기관에서 제시한 제반 규칙을 준수함은 물론, 치료와 퇴원 등 의료진(또는 직원)</span><span
									class="hrt cs10">의</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 30.89mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs11">&nbsp;&nbsp;</span><span class="hrt cs12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs11">&nbsp;&nbsp;</span><span class="hrt cs13">&nbsp;</span><span
									class="hrt cs8">정당한 지시에 따르겠습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 1.31mm; white-space: nowrap; left: 0mm; top: 36.04mm; height: 1.76mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 38.79mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs15">2. 의료기관의 정당한 진료지침이나 교육에 반하는 무단외출, 외박으로
									인하여 발생하는 환자의 손해에</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 43.87mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;</span><span class="hrt cs11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs8">대한 책임은 원칙적으로 환자에게 있습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 1.31mm; white-space: nowrap; left: 0mm; top: 49.02mm; height: 1.76mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 51.77mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.
									입원료 및 기타 입원기간 동안 발생하는 진료비는 의료기관에서 정하는 납부기한 내에 환자와 연대보증인이</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 56.85mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs8">연대하여 납부해야 하며, 정당한 이유 없이 체납될 때에는 채권확보를 위한
									법적 조치를 취하겠습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 1.31mm; white-space: nowrap; left: 0mm; top: 62mm; height: 1.76mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 64.75mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.
									입원 기간 중 환자와 보호자는 의료기관의 비품 및 기물을 고의 또는 과실로 망실, 훼손한 때에는 이를</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 69.83mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;변상합니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 1.31mm; white-space: nowrap; left: 0mm; top: 74.98mm; height: 1.76mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 77.73mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.
									입원 기간 중 환자 또는 보호자가 병원에 보관을 의뢰하지 않은 현금 및 기타 귀중품의 분실, 훼손에&nbsp;</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 82.81mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대하여
									병원은 배상책임이 없습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 1.31mm; white-space: nowrap; left: 0mm; top: 87.97mm; height: 1.76mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 90.72mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs17">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.
									진료상 발생하는 문제에 분쟁이 생겼을 때에는 의료법에 따라 원인이 발생한 날로부터 1년 이내에</span><span
									class="hrt cs10">&nbsp;</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 95.80mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
									class="hrt cs8">시·도지사에게 의료심사조정위원회의 조정을 신청할 수 있습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 100.88mm; height: 3.17mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 105.96mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7.
									음주 및 가무시에 임의 퇴원 시켜도 이의를 제기 하지 않겠습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 111.04mm; height: 3.17mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 116.12mm; height: 3.17mm; width: 175.08mm;">
								<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.
									환자의 안정을 위하여 방문객의 오후 10시 30분 이후 출입을 금하겠습니다.</span>
							</div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 121.20mm; height: 3.17mm; width: 175.08mm;"></div>
							<div class="hls ps0"
								style="line-height: 2.48mm; white-space: nowrap; left: 0mm; top: 126.28mm; height: 3.17mm; width: 175.08mm;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="hpa" id="outHosDocument" style="width: 210mm; height: 297mm; display: none;">
		<div class="Section1" style="padding-top : 30px;">
			<p class="a0" style="font-weight : bold; font-size : 1.3rem;">퇴원 확인서</p>
		</div>
		<input type="hidden" id="outHosPatCode"/>
		<table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" style="margin : auto; border-collapse:collapse;border:none;mso-border-alt:
			 solid windowtext .75pt;mso-padding-alt:0cm .6pt 0cm .6pt;mso-border-insideh:
			 .75pt solid windowtext;mso-border-insidev:.75pt solid windowtext">
			 <tbody><tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:34.15pt">
			  <td width="141" style="width:105.55pt;border:solid windowtext 1.0pt;mso-border-alt:
			  solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span style="mso-bidi-font-family:굴림">발 급 번 호<span lang="EN-US"><o:p></o:p></span></span></p>
			  </td>
			  <td width="488" colspan="3" style="width:366.3pt;border:solid windowtext 1.0pt;
			  border-left:none;mso-border-left-alt:solid windowtext .75pt;mso-border-alt:
			  solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span id="outHosNo" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:1;height:34.15pt">
			  <td width="141" style="width:105.55pt;border:solid windowtext 1.0pt;border-top:
			  none;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
			  padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span style="mso-bidi-font-family:굴림">환<span lang="EN-US"><span style="mso-spacerun:yes">&nbsp;&nbsp; </span></span>자<span lang="EN-US"><span style="mso-spacerun:yes">&nbsp;&nbsp; </span></span>명<span lang="EN-US"><o:p></o:p></span></span></p>
			  </td>
			  <td width="211" style="width:158.05pt;border-top:none;border-left:none;
			  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
			  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
			  mso-border-alt:solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span id="outHosName" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  </td>
			  <td width="109" style="width:81.4pt;border-top:none;border-left:none;
			  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
			  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
			  mso-border-alt:solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span style="mso-bidi-font-family:굴림">주민등록번호</span><span style="font-size:1.0pt;
			  line-height:92%"> <span lang="EN-US"><o:p></o:p></span></span></p>
			  </td>
			  <td width="169" style="width:126.85pt;border-top:none;border-left:none;
			  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
			  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
			  mso-border-alt:solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span id="outHosIhid"lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:2;height:34.15pt">
			  <td width="141" rowspan="2" style="width:105.55pt;border:solid windowtext 1.0pt;
			  border-top:none;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
			  solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span style="mso-bidi-font-family:굴림">주<span lang="EN-US"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>소<span lang="EN-US"><o:p></o:p></span></span></p>
			  </td>
			  <td width="488" colspan="3" style="width:366.3pt;border-top:none;border-left:
			  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
			  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
			  mso-border-alt:solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span id="outHosAddr" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:3;height:34.15pt">
			  <td width="488" colspan="3" style="width:366.3pt;border-top:none;border-left:
			  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
			  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
			  mso-border-alt:solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:34.15pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span id="outHosDtlAddr" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:4;height:51.2pt">
			  <td width="629" colspan="4" style="width:471.85pt;border:solid windowtext 1.0pt;
			  border-top:none;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
			  solid windowtext .75pt;padding:auto;height:51.2pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span lang="EN-US">내</span></span><span lang="EN-US" style="font-family:
			  굴림;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:굴림;
			  color:black;text-transform:none;layout-grid-mode:both;text-decoration:none;
			  text-underline:none"><span lang="EN-US"> </span></span><span lang="EN-US" style="font-family:굴림;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:
			  굴림;color:black;text-transform:none;layout-grid-mode:both;text-decoration:
			  none;text-underline:none"><span lang="EN-US">용</span></span></a></span><span lang="EN-US" style="font-size:1.0pt;line-height:92%;mso-bidi-font-family:굴림"><o:p></o:p></span></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:5;height:309.6pt">
			  <td width="629" colspan="4" style="width:471.85pt;border:solid windowtext 1.0pt;
			  border-top:none;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
			  solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:309.6pt">
			 	<p class="110" id="outHosContent"></p>
			  </td>
			 </tr>
			 <tr style="mso-yfti-irow:6;mso-yfti-lastrow:yes;height:118.65pt">
			  <td width="629" colspan="4" style="width:471.85pt;border:solid windowtext 1.0pt;
			  border-top:none;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
			  solid windowtext .75pt;padding:0cm .6pt 0cm .6pt;height:118.65pt">
			  <p class="110" style="mso-element:frame;mso-element-frame-width:476.05pt;
			  mso-element-frame-height:618.95pt;mso-element-wrap:no-wrap-beside;mso-element-anchor-vertical:
			  paragraph;mso-element-anchor-horizontal:margin;mso-element-left:2.95pt"><span style="mso-bidi-font-family:굴림">위와 같이 환자의 입·퇴원을 확인함<span lang="EN-US"><o:p></o:p></span></span></p>
			  <p class="110"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  <p class="110"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  <p class="110"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  <p class="110" id="outHosDate"></p>
			  <p class="110"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
			  <p class="110" align="right" style="margin-right:5.0pt;text-align:right"><span lang="EN-US" style="mso-bidi-font-family:굴림"><o:p>&nbsp;</o:p></span></p>
			  </td>
			 </tr>
			</tbody></table>
		<div class="Section1" style="padding-top : 30px;">
			<p class="a0" style="font-weight : bold; font-size : 1.3rem;">아작(나)스 병원</p>
		</div>
		</div>
	</div>
	`;

var items = [ 
	   {w: 6, h:5, x:0, y:0, content: gr1, noResize : true, noMove : true, locked : true},
	   {w: 6, h:5, x:7, y:0, content: gr2, noResize : true, noMove : true, locked : true}
];

var grid = GridStack.init(); grid.load(items);


$(function(){
	fHospitalizationList();
	
	$('.nav-link').on('click',function(){
		let toggleAttr = $(this).attr("data-bs-target");
		if(toggleAttr == '#inHosptailzation'){
			inHosBtnDiv.css("display","block");
			outHosBtnDiv.css("display","none");
			inHosDocument.css("display","block");
			outHosDocument.css("display","none");
		}else if(toggleAttr == '#outHosptailzation'){
			inHosBtnDiv.css("display","none");
			outHosBtnDiv.css("display","block");
			inHosDocument.css("display","none");
			outHosDocument.css("display","block");
		}
	});
});
const outHosBody = $('#outHosBody');
const inHosBody = $('#inHosBody');
const inHosDate = $('#inHosDate');
const hosReqDate = $('#hosReqDate');
const hosReqPerson = $('#hosReqPerson');
const inHosName = $('#inHosName');
const inHosNo = $('#inHosNo');
const inHosDoctor = $('#inHosDoctor');
const inHosAddr = $('#inHosAddr');
const inHosIhid = $('#inHosIhid');
const inHosDtlAddr = $('#inHosDtlAddr');
const inHosTel = $('#inHosTel');
const inHosDocument = $ ('#inHosDocument');
const inHosBtnDiv = $('#inHosBtnDiv');
const outHosBtnDiv = $('#outHosBtnDiv');
const outHosDocument = $('#outHosDocument');
const inHosPatCode = $('#inHosPatCode');
const outHosNo =$('#outHosNo');
const outHosName  =$('#outHosName');
const outHosIhid  =$('#outHosIhid');
const outHosAddr  =$('#outHosAddr');
const outHosDtlAddr  =$('#outHosDtlAddr');
const outHosDate  =$('#outHosDate');
const outHosContent  =$('#outHosContent');
const outHosPatCode =$('#outHosPatCode');

function fHospitalizationList(){
	$.ajax({
		url : "/reqHospitalizaton/list",
		type : "get",
		dataType : "json",
		success : function(result){
			console.log(result);
			let inTxt = ""; 
			let outTxt = "";
			let inIndex = 1;
			let outIndex = 1;
			for(let i=0; i<result.length; i++){
				let r = result[i];
				if(r.patHsptlzStatus == '2'){
					inTxt +=
						`
						<tr>
		                    <td>\${inIndex}</td>
		                    <td>\${r.hsptlzNo}</td>
		                    <td>\${r.patCode}</td>
		                    <td>\${r.patName}</td>
		                    <td>\${r.patHsptlzOutPlan}</td>
		                    <td><button class="btn btn-sm btn-primary" onclick="fPrintCheckInDoc('\${r.hsptlzNo}','\${r.patCode}')">수속</button></td>
			            </tr>
						`;
					inIndex++;
				}else if(r.patHsptlzStatus == '5'){
					outTxt +=
						`
						<tr>
		                    <td>\${outIndex}</td>
		                    <td>\${r.hsptlzNo}</td>
		                    <td>\${r.patCode}</td>
		                    <td>\${r.patName}</td>
		                    <td>\${r.hsptlzInDate}</td>
		                    <td><button class="btn btn-sm btn-primary" onclick="fPrintCheckOutDoc('\${r.hsptlzNo}','\${r.patCode}')">퇴원</button></td>
			            </tr>						
						`;
					outIndex++;
				}
			}
			inHosBody.html(inTxt);
			outHosBody.html(outTxt);
		}
	});
}

function fPrintCheckInDoc(hsptlzNo,patCode){
	inHosPatCode.val(patCode);
	fCleanCheckOutDoc();
	$.ajax({
		url :"/reqHospitalizaton/get/"+hsptlzNo,
		type : "get",
		dataType : "json",
		success : function(r){
			console.log("서류:",r);
			
			hosReqDate.html(r.patHsptlzInDate);
			inHosDate.html(r.patHsptlzInDate);
			hosReqPerson.html(r.patName);
			inHosName.html(r.patName);
			inHosNo.html(r.hsptlzNo);
			inHosDoctor.html(r.empNm);
			inHosAddr.html(r.patAddr);
			inHosDtlAddr.html(r.patDtlAddr);
			inHosIhid.html(r.patIhidnum);
			inHosTel.html(r.patTel);
		}
	});
}

function fPrintCheckOutDoc(hsptlzNo,patCode){
	let date = new Date();
	let year = date.getFullYear();
	let month = ("0" + (1 + date.getMonth())).slice(-2);
	let day = ("0" + date.getDate()).slice(-2);
	let vDate = year + "년 " + month + "월 " + day +"일";
	fCleanCheckInDoc();
	outHosPatCode.val(patCode);
	$.ajax({
		url :"/reqHospitalizaton/get/"+hsptlzNo,
		type : "get",
		dataType : "json",
		success : function(r){
			let txt = `위 환자는 </br> \${r.hsptlzInDate} 부터 \${vDate}까지 </br> 입원을 진행하였습니다.`
			console.log(r);
			outHosNo.html(r.hsptlzNo);
			outHosName.html(r.patName);
			outHosIhid.html(r.patIhidnum);
			outHosAddr.html(r.patAddr);
			outHosDtlAddr.html(r.patDtlAddr);
			outHosDate.html(vDate);
			outHosContent.html(txt);
			
		}
	});
}

function fCleanCheckInDoc(){
	inHosDate.html("");
	hosReqDate.html("");
	hosReqPerson.html("");
	inHosName.html("");
	inHosNo.html("");
	inHosDoctor.html("");
	inHosAddr.html("");
	inHosIhid.html("");
	inHosDtlAddr.html("");
	inHosTel.html("");
	inHosPatCode.val("");
}

function fCleanCheckOutDoc(){
	outHosNo.html("");
	outHosName.html("");
	outHosIhid.html("");
	outHosAddr.html("");
	outHosDtlAddr.html("");
	outHosDate.html("");
	outHosContent.html("");
	outHosPatCode.val("");
}
let jsPDF = jspdf.jsPDF;


function fSavePdf(inOrOut){
	let iPatCode = inHosPatCode.val();
	let oPatCode = outHosPatCode.val();
	let containerId = "";
	let pdfName = "";
	let hosNo = "";
	if(inOrOut == 'in'){
		if(iPatCode == null || iPatCode == ""){
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '입원 수속할 환자를 선택해주세요',
			});
			return;
		}
		containerId = "inHosDocument"
		pdfName = "_입원서약서.pdf";
		hosNo = inHosNo.text()+"IN";
	} else if (inOrOut == 'out'){
		if(oPatCode == null || oPatCode == ""){
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '퇴원 처리할 환자를 선택해주세요',
			});
			return;
		}
		containerId = "outHosDocument"
		pdfName = "_퇴원확인서.pdf";
		hosNo =outHosNo.text()+"OUT";
	}
	console.log("pdf체킁",containerId,pdfName,hosNo)
	mkPdf(containerId,pdfName,hosNo);
	
}



function mkPdf(containerId, pdfName,hosNo){
	html2canvas($(`#\${containerId}`)[0]).then(function (canvas) {
		// 캔버스를 이미지로 변환
		const imgData = canvas.toDataURL("image/png");
	
		const imgWidth = 210; // 가로(mm) (A4)
		const pageHeight = imgWidth * 1.414; // 세로 길이 (A4)
		const imgHeight = (canvas.height * imgWidth) / canvas.width;
	
		const doc = new jsPDF({
			orientation: "p",
			unit: "mm",
			format: "a4",
		});
	
		let heightLeft = imgHeight;
		let position = 0;
	
		// 첫 페이지 출력
		doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
		heightLeft -= pageHeight;
	
		// 한 페이지 이상일 경우 루프 돌면서 출력
		while (heightLeft >= 20) {
			position = heightLeft - imgHeight;
			doc.addPage();
			doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
			heightLeft -= pageHeight;
		}
	
		var blobPDF = doc.output('blob');
		console.log("체킁2:", blobPDF);
		let fileName = hosNo.substring(0, 5);
		let formData = new FormData();
		formData.append("pdfFile", blobPDF);
		formData.append("fileName", fileName + pdfName);  //H0001_입원~~~
		formData.append("hosNo", hosNo);				  //H0001IN
	
	
		let xhr = new XMLHttpRequest();
		xhr.open("post", "/reqHospitalizaton/pdfUpload");
		//xhr.setRequestHeader(header, token);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4 && xhr.status == 200) {
				console.log(xhr.responseText);
				window.open("/pdffiles/"+fileName + pdfName);
			}
		}
		xhr.send(formData);
	
// 		issuedDocu(reqDocumentNo);

	});
}

function fCheckInPat(){
	let patCode = inHosPatCode.val();
	if(patCode == null || patCode == ""){
		Swal.fire({
			icon: 'error',
			title: '실패!',
			text: '입원 수속할 환자를 선택해주세요',
		});
		return;
	}
	let hsptlzNo = inHosNo.html();
	console.log(patCode,hsptlzNo);
	let data = {
			'patCode' : patCode,
			'hsptlzNo' : hsptlzNo
	}
	$.ajax({
		url : "/reqHospitalizaton/inHospt",
		type : "POST",
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(data),
		success : function(result){
			console.log(result);
			Swal.fire({
				icon: 'success',
				title: '완료!',
				text: '입원수속이 완료되었습니다.',
			});
			fHospitalizationList();
			let msg = {
						to : "원무과",
						from : "간호",
						cmd : "okHosp"
					  } 
			webSocket.send(JSON.stringify(msg)); 
		}
	});
}
const outHosReceiptDoc = $('#outHosReceiptDoc');
function fOpenOutPatDoc(){
	//const 배열 객체 초기화
	detailNoList.length = 0;
	outHosReceiptDoc.css("display","block");
	let hsptlzNo = outHosNo.html();
	console.log("hsptlzNo",hsptlzNo)
	$.ajax({
		url : "/receiption/hospitalization/"+hsptlzNo,
		type : "get",
		dataType : "json",
		//let selfVal = new Intl.NumberFormat('ko-KR').format(Math.floor(pTotal * 0.4));  
		success : function(result){
			let clinicTotal = result.length * 15000;
			let vClinicTotal = new Intl.NumberFormat('ko-KR').format(clinicTotal);
			let vClinicSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(clinicTotal * 0.4));  
			let vClinicCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(clinicTotal * 0.6));  
			console.log("영수증!!!",result);
			oRPatNo.html(result[0].patCode);
			oRPatName.html(result[0].patName);
			oRPatTime.html(result[0].hsptlzInDate+"-"+result[0].hsptlzOutDate);
			oRPatRoom.html(result[0].sckrmNo);
			oRPatRemark.html("");
			oHosNo.html(hsptlzNo);
			oHosETC.html("");
			oRClinicPayTotal.html(vClinicTotal);
			oRClinicPayCorp.html(vClinicCorp);
			oRClinicPaySelf.html(vClinicSelf);
			oRClinicPayment.html(vClinicSelf + "원");
			let inspcTotal = 0;
			let treatTotal = 0;
			let physioTotal = 0;
			let prescriptionTotal = 0;
			let hsptlzTotal = result[0].hosRoomTotalPrice;
			let vHsptlzTotal = new Intl.NumberFormat('ko-KR').format(hsptlzTotal);
			let vHsptlzSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(hsptlzTotal * 0.4));  
			let vHsptlzCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(hsptlzTotal * 0.6));  
			console.log(result);
			let text = "";
			let no = 12;
			for(let i = 0; i<result.length; i++){
				detailNoList.push(result[i].detailNo);
				let inspc = result[i].hosRInspcVOList;
				let treat = result[i].hosRTreatVOList;
				let physio = result[i].hosRPhysioVOList;
				let prescription = result[i].hosRPrescriptionVOList;
				//검사
				//row,category,date,code,name,cost
				for(let j = 0; j<inspc.length; j++){
					//console.log(no,"검사비",inspc[j].detailRegDate,inspc[j].inspcCode,inspc[j].inspcType,inspc[j].inspcCost)
 					text += getTbodyText(no,"검사비",inspc[j].detailRegDate,inspc[j].inspcCode,inspc[j].inspcType,inspc[j].inspcCost);
					no = no +1;
					inspcTotal += parseInt(inspc[j].inspcCost);
				}
				for(let j = 0; j<treat.length; j++){
					//console.log(no,"처치비",treat[j].detailRegDate,treat[j].treCode,treat[j].treContent,treat[j].treCosts)
 					text += getTbodyText(no,"처치비",treat[j].detailRegDate,treat[j].treCode,treat[j].treContent,treat[j].treCosts);
					no = no +1;
					treatTotal += parseInt(treat[j].treCosts);
				}
				for(let j = 0; j<physio.length; j++){
					//console.log(no,"치료비",physio[j].detailRegDate,physio[j].physioCode,physio[j].physioContent,physio[j].physioCost)
 					text += getTbodyText(no,"치료비",physio[j].detailRegDate,physio[j].physioCode,physio[j].physioContent,physio[j].physioCost);
					no = no +1;
					physioTotal += parseInt(physio[j].physioCost);
				}
				for(let j = 0; j<prescription.length; j++){
					//console.log(no,"처방비",prescription[j].detailRegDate,prescription[j].mediItemCode,prescription[j].mediItemName,prescription[j].mediTotal)
 					text += getTbodyText(no,"처방비",prescription[j].detailRegDate,prescription[j].mediItemCode,prescription[j].mediItemName,prescription[j].mediTotal);
					no = no +1;
					prescriptionTotal += parseInt(prescription[j].mediTotal);
				}
				
			}
			tbodySec2.html(text);
			vInspcTotal = new Intl.NumberFormat('ko-KR').format(inspcTotal);
			vInspcSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(inspcTotal * 0.4));
			vInspcCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(inspcTotal * 0.6));
			vTreatTotal = new Intl.NumberFormat('ko-KR').format(treatTotal);
			vTreatSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(treatTotal * 0.4));
			vTreatCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(treatTotal * 0.6));
			vPhysioTotal = new Intl.NumberFormat('ko-KR').format(physioTotal);
			vPhysioSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(physioTotal * 0.4));
			vPhysioCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(physioTotal * 0.6));
			vPrescriptionTotal = new Intl.NumberFormat('ko-KR').format(prescriptionTotal);
			vPrescriptionSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(prescriptionTotal * 0.4));
			vPrescriptionCorp = new Intl.NumberFormat('ko-KR').format(Math.ceil(prescriptionTotal * 0.6));
			let allTotal = clinicTotal +hsptlzTotal + inspcTotal + treatTotal + physioTotal + prescriptionTotal;
			let vAllTotal = new Intl.NumberFormat('ko-KR').format(allTotal);
			let vAllTotalSelf = new Intl.NumberFormat('ko-KR').format(Math.floor(allTotal * 0.4));
			oRInspcPayTotal.html(vInspcTotal);
			oRInspcPayCorp.html(vInspcCorp);
			oRInspcPaySelf.html(vInspcSelf);
			oRInspcPayment.html(vInspcSelf + "원");
			oRTreatPayTotal.html(vTreatTotal);
			oRTreatPayCorp.html(vTreatCorp);
			oRTreatPaySelf.html(vTreatSelf);
			oRTreatPayment.html(vTreatSelf + "원");
			oRPhysioPayTotal.html(vPhysioTotal);
			oRPhysioPayCorp.html(vPhysioCorp);
			oRPhysioPaySelf.html(vPhysioSelf);
			oRPhysioPayment.html(vPhysioSelf + "원");
			oRPresPayTotal.html(vPrescriptionTotal);
			oRPresPayCorp.html(vPrescriptionCorp);
			oRPresPaySelf.html(vPrescriptionSelf);
			oRPresPayment.html(vPrescriptionSelf + "원");
			oRHosptzPayTotal.html(vHsptlzTotal);
			oRHosptzPayCorp.html(vHsptlzCorp);
			oRHosptzPaySelf.html(vHsptlzSelf);
			oRHosptzPayment.html(vHsptlzSelf + "원");
			oRTotalPrice.html(vAllTotal + "원");
			oRTotalSelfPrice.html(vAllTotalSelf + "원");
			oRPatName2.html(result[0].patName);
			
			
		}
	});
}


function fRModalClean(){
	oRPatNo.html("");
	oRPatName.html("");
	oRPatTime.html("");
	oRPatRoom.html("");
	oRPatRemark.html("");
	oHosNo.html("");
	oHosETC.html("");
	oRClinicPayTotal.html("");
	oRClinicPayCorp.html("");
	oRClinicPaySelf.html("");
	oRClinicPayment.html("");
	oRInspcPayTotal.html("");
	oRInspcPayCorp.html("");
	oRInspcPaySelf.html("");
	oRInspcPayment.html("");
	oRTreatPayTotal.html("");
	oRTreatPayCorp.html("");
	oRTreatPaySelf.html("");
	oRTreatPayment.html("");
	oRPhysioPayTotal.html("");
	oRPhysioPayCorp.html("");
	oRPhysioPaySelf.html("");
	oRPhysioPayment.html("");
	oRHosptzPayTotal.html("");
	oRHosptzPayCorp.html("");
	oRHosptzPaySelf.html("");
	oRHosptzPayment.html("");
	oRTotalPrice.html("");
	oRPatName2.html("");
}
function fModalClose(){
	outHosReceiptDoc.css("display","none");
	fRModalClean();
}

const detailNoList = [];
function fOutHosReceipt(){
	console.log("체크",detailNoList);
	let data = {
			'detailNoList' : detailNoList,
			'hsptlzNo' : oHosNo.html(),
			'patCode' : oRPatNo.html()
	}
	console.log(data);
	$.ajax({
		url : "/receiption/outHosReceiption",
		type : "post",
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		success: function(result) {
		    console.log(result);
		    Swal.fire({
				icon: 'success',
				title: '성공!',
				text: '퇴원 수납이 완료되었습니다.',
			});
		    outHosReceiptDoc.css("display","none");
		    fRModalClean();
		    fCleanCheckOutDoc
		    fHospitalizationList();
		}
	});
	
}
function getTbodyText(row,category,date,code,name,cost){
	let total = parseInt(cost);
	let vTotal = new Intl.NumberFormat('ko-KR').format(total);
	let selfCost = new Intl.NumberFormat('ko-KR').format(Math.floor(total * 0.4));
	let corpCost = new Intl.NumberFormat('ko-KR').format(Math.ceil(total * 0.6));
	
	let txt = 
		`
		<tr style="mso-yfti-irow:\${row}">
			<td width="111" valign="top" style="width:83.55pt;border:solid windowtext 1.0pt; border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt; padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:center;line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${category}</span>
				</p>
			</td>
			<td width="109" valign="top" style="width:81.75pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:center;line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${date}</span>
				</p>
			</td>
			<td width="117" valign="top" style="width:87.85pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:left;line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${code}</span>
				</p>
			</td>
			<td width="227" valign="top" style="width:170.7pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:left; line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${name}</span>
				</p>
			</td>
			<td width="116" valign="top" style="width:87.15pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:right; line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${vTotal}</span>
				</p>
			</td>
			
			<td width="116" valign="top" style="width:87.2pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:right; line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${corpCost}</span>
				</p>
			</td>
			<td width="115" valign="top" style="width:86.2pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt; text-align:right; line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${selfCost}</span>
				</p>
			</td>
			<td width="115" valign="top" style="width:86.2pt;border-top:none;border-left: none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt; mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt">
				<p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:right;line-height:normal">
					<span lang="EN-US" style="font-size:8.0pt">\${selfCost}</span>
				</p>
			</td>
		</tr>
		`;
	return txt;
}
//--------------------------- 웹소켓-------------------------------------
function fMessage(){ // 받는쪽에 작성
	let serverMsg = JSON.parse(event.data);

	if(serverMsg.cmd =="alarm"){
		getNotiList();
	}
	if(serverMsg.cmd =="plzHosp"){
		fHospitalizationList();
	}
	if(serverMsg.cmd =="endHosp"){
		fHospitalizationList();
	}
}
// --------------------------- /웹소켓 ------------------------------------- 
</script>