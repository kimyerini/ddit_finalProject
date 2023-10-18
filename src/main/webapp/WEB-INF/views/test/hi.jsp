<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 
<link href="./resources/css/demo.css" rel="stylesheet"/> 

<div class="grid-stack"></div> 
<script type="text/javascript"> 
    var items = [ 
	   {w: 3, h:6, float: false, content: '<div style="background-color : white; width:100%; height:100%;, opacity:0.7;"><h1>대기환자목록</h1></div>'}, 
	   {w: 4, h:3, float: false, content: '<div style="background-color : white; width:100%; height:100%;, opacity:0.1;"><h1>환자정보</h1></div>'},
	   {w: 5, h:6, float: false, content: '<div style="background-color : white; width:100%; height:100%;, opacity:1;"><h1>진료차트 작성</h1></div>'},
	   {w: 4, h:3, float: false, content: '<div style="background-color : white; width:100%; height:100%;, opacity:0.4;"><h1>진료내역</h1></div>'}
   ];
   
    var grid = GridStack.init(); grid.load(items);
</script>