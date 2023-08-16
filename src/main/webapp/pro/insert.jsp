<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form name="frm1">
	<div class="input-group mb-2">
		<span class="input-group-text">교수이름</span>
		<input name="pname" class="form-control">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수학과</span>
		<select name="dept" class="form-select">
			<option value="전산">전자계산학과</option>
			<option value="컴정">컴퓨터정보공학</option>
			<option value="전자">전자공학</option>
			<option value="건축">건축공학과</option>
		</select>
	</div>
	<div class="input-group mb-2 pt-2">
		<span class="input-group-text">교수직급</span>&nbsp;&nbsp;
		<input type="radio" name="title" value="정교수">
		<span class="pt-2">정교수</span>&nbsp;&nbsp;
		<input type="radio" name="title" value="부교수" checked>
		<span class="pt-2">부교수</span>&nbsp;&nbsp;
		<input type="radio" name="title" value="정교수">
		<span class="pt-2">조교수</span>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수급여</span>
		<input name="salary" class="form-control" value="0">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">임용일자</span>
		<input name="hiredate" class="form-control" type="date">
	</div>
	<div class="text-center mt-5">
		<input type="submit" value="교수등록" class="btn btn-primary">
		<input type="reset" value="등록취소" class="btn btn-secondary">
	</div>
</form>
<script>
	$(frm1).on("submit", function(e){
		e.preventDefault();
		const pname=$(frm1.pname).val();
		const salary=$(frm1.salary).val();
		const title=$(frm1.title).val();
		const dept=$(frm1.dept).val();
		const hiredate=$(frm1.hiredate).val();
		if(pname==""){
			alert("교수이름을 입력하세요!");
			$(frm1.pname).focus();
		}else if(salary.replace(/[0-9]/g, '')){
			alert("급여를 숫자로 입력하세요!");
			$(frm1.salary).val("");
			$(frm1.salary).focus();
		}else{
			if(confirm("새로운 교수를 등록하실래요?")){
				$.ajax({
					type:"post",
					data:{"pname":pname, "salary":salary, "title":title, "hiredate":hiredate, "dept":dept},
					url:"/pro/insert",
					success:function(data){
						console.log(data);
						getTotal();
						$("#insert").modal("hide");
					}
				})
			}
		}
	});
	
	$(frm1).on("reset", function(){
		$("#insert").modal("hide")
	});
</script>