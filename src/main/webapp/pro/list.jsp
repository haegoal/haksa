<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="row">
        <div class="col my-3">
            <h1 class="text-center">교수목록</h1>
            <div class="row">
            	<form class="col-6" name="frm">
            	<div class="input-group">
            		<select class="form-select" name="key">
	            		<option value="pcode">코드</option>
	            		<option selected value="pname">이름</option>
	            		<option value="dept">학과</option>
	            		<option value="title">직급</option>
            		</select>&nbsp;
            		<input class="form-control" name="query" placeholder="검색어">
            		<input class="btn btn-primary" value="검색" type="submit">
            		</div>
            	</form>
            	<div class="col text-end">
            		<button class="btn btn-primary text-end" id="btn-in">등록</button>
            	</div>
            </div>
             <div id="div_pro"></div>
             <div id="pagination" class="pagination justify-content-center"></div>
        </div>
</div>
<!-- Modal -->
<div class="modal fade" id="insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">교수등록</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <jsp:include page="/pro/insert.jsp"/>
      </div>
    </div>
  </div>
</div>

<script id="temp_pro" type="text/x-handlebars-template">
    <table class="table">
		<tr>
			<th>교수번호</th>
			<th>교수이름</th>
			<th>학과</th>
			<th>입사일</th>
			<th>교수직책</th>
			<th>급여</th>
		</tr>
        {{#each .}}
        <tr>
            <td>{{pcode}}</td>
            <td><a href="/pro/update?pcode={{pcode}}">{{pname}}</a></td>
            <td>{{dept}}</td>
            <td>{{hiredate}}</td>
            <td>{{title}}</td>
            <td>{{salary}}</td>
        </tr>
        {{/each}}
        </table>
</script>
<script>
    let page=1;
    let query="";
    let key=$(frm.key).val();
    //getList(1);
    getTotal();
    
    $("#btn-in").on("click", function(){
    	$("#insert").modal("show");
    })
    
    $(frm).on("submit", function(e){
    	e.preventDefault();
    	query=$(frm.query).val();
    	key=$(frm.key).val();
    	getTotal();
    })
    
    function getTotal(){
        $.ajax({
            type:"get",
            url:"/pro/total",
            data:{"query":query, "key":key},
            success:function(data){
            	console.log(data);
            	const totalPages = Math.ceil(data/5);
            	if(totalPages==0){
            		$("#div_pro").hide();
            		$("#pagination").hide();
            	}else{
            		$("#div_pro").show();
            		$("#pagination").show();
            		$("#pagination").twbsPagination("changeTotalPages", totalPages, 1)
            	} 	
            }
        })
    }

    function getList(page){
        $.ajax({
            type:"get",
            url:"/pro/list.json",
            data:{"page":page, "query":query, "key":key},
            dataType:"json",
            success:function(data){
                let temp=Handlebars.compile($("#temp_pro").html());
                $("#div_pro").html(temp(data));
            }
        })
    }
    
   
    $('#pagination').twbsPagination({
	    totalPages:21,	// 총 페이지 번호 수
	    visiblePages: 10,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, page) {
	    	getList(page);
	    }
	});
    
</script>