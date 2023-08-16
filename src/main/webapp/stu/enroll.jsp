<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <div class="row">
        <div class="col">
            <h1 class="text-center">수강신청</h1>
            <div class="card p-3">
             <div class="row">
                <div class="col">학생번호:${vo.scode}</div>
                <div class="col">학생이름:${vo.sname}</div>
                <div class="col">학생학과:${vo.dept}</div>
                <div class="col">학생학년:${vo.year}</div>
                <div class="col">지도교수:${vo.pname}(${vo.advisor})</div>
            </div>
            </div>
            <hr>
            <div class="card p-3 my-5">
            <div class="row">
            	<div class="col" id="div_c">
            	</div>
            	<div class="col">
            	<button class="btn btn-primary" id="btn-en">수강신청</button>
            	</div>
            </div>
            </div>
            <hr>
            <div id="div_enroll"></div>
        </div>
    </div>
    
    <script id="temp_c" type="text/handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
		<option value="{{lcode}}" {{dis persons capacity}}>
		{{lname}} {{persons}}/{{capacity}}
		</option>
		{{/each}}
	<select>
	</script>
	
    <script id="temp_enroll" type="text/handlebars-template">
	<table class="table">
		<tr>
			<th>강의번호</th>
			<th>강의이름</th>
			<th>점수</th>
			<th>수강날짜</th>
			<th>강의시간</th>
			<th>강의실</th>
			<th>교수이름</th>
			<th>총원</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{grade}}</td>	
			<td>{{edate}}</td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{pname}}</td>
			<td>{{persons}}/{{capacity}}</td>
			<td><button class="btn btn-danger btn-sm" lcode="{{lcode}}">수강취소</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("dis", function(persons, capacity){
		if(persons>=capacity) return "disabled";
	})
</script>
	<script>
	const scode="${vo.scode}";
	
	
	$("#div_enroll").on("click", ".btn-danger", function(){
		const lcode=$(this).attr("lcode");
		if(confirm(lcode+ "강좌를 수강취소하시겠습니까?")){
			$.ajax({
				type:"post",
				data:{scode:scode,lcode:lcode},
				url:"/enroll/delete",
				success:function(){
					alert("수강이 취소되었습니다.");
					getList();
					getClist();
				}
			})
		}
	})
	
	$("#btn-en").on("click", function(){
		const lcode=$("#lcode").val();
		if(confirm(lcode + "강좌를 수강신청하겠습니까?")){
			$.ajax({
				type:"get",
				data:{"scode":scode,"lcode":lcode},
				url:"/enroll/insert",
				success:function(data){
					if(data==0){
						alert("수강신청이완료되었습니다.");
						getList();
						getClist();
					}else{
						alert("이미신청한과목입니다.");
						
					}
				}
				
			})
		}
	})
	
	getList();
	getClist();
	
	 function getClist(){
	        $.ajax({
	            type:"get",
	            url:"/cou/all.json",
	            dataType:"json",
	            success:function(data){
	                console.log(data);
	                const temp = Handlebars.compile($("#temp_c").html());
	                $("#div_c").html(temp(data));
	            }
	        })
	    }
	 
    function getList(){
        $.ajax({
            type:"get",
            url:"/stu/enroll.json",
            dataType:"json",
            data:{"scode":scode},
            success:function(data){
                console.log(data);
                const temp = Handlebars.compile($("#temp_enroll").html());
                $("#div_enroll").html(temp(data));
            }
        })
    }
	</script>
	
	