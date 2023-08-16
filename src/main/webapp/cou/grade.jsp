<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">점수입력</h1>
		<div class="card p-3">
			<div class="row">
				<div class="col">강좌번호:${vo.lcode}</div>
				<div class="col-4">강좌이름:${vo.lname}</div>
				<div class="col">담당교수:${vo.pname}</div>
				<div class="col">강의시수:${vo.hours}</div>
				<div class="col">수강인원:${vo.persons}/${vo.capacity}</div>
			</div>
		</div>
		<hr>
		<div id="div_grade"></div>
	</div>
</div>
<!-- 성적목록 템플릿-->
<script id="temp_grade" type="text/x-handlebar-templates">
	<table class="table">
		{{#each .}}
		<tr>
			<td class="scode">{{scode}}</td>
			<td>{{sname}}</td>
			<td>{{dept}}</td>
			<td>{{edate}}</td>
			<td width="100">
				<input class="grade form-control text-end" value="{{grade}}" 
						oninput="isNumber(this)"></td>
			<td><button class="btn btn-primary btn-sm">수정</td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	const lcode="${vo.lcode}";
	getList();
	
	$("#div_grade").on("click", ".btn-primary", function(){
		const row=$(this).parent().parent();
		const scode=row.find(".scode").text();
		const grade=row.find(".grade").val();
		if(confirm(scode + "학생의 점수를 " + grade + "로 수정하실래요?")){
			$.ajax({
				type:"post",
				url:"/grade/update",
				data:{lcode:lcode, scode:scode, grade:grade},
				success:function(){
					alert("점수가 수정되었습니다.");
					getList();
				}
			});
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cou/grade.json",
			data:{lcode:lcode},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_grade").html());
				$("#div_grade").html(temp(data));
			}
		});
	}
	
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>