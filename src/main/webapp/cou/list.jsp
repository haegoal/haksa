<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 <div class="row">
        <div class="col my-3">
            <h1 class="text-center">강좌목록</h1>
            <div class="row">
            	<form class="col-6" name="frm">
            	<div class="input-group">
            		<select class="form-select" name="key">
	            		<option value="lcode">강좌코드</option>
	            		<option selected value="lname">강좌이름</option>
	            		<option value="room">강의실</option>
	            		<option value="pname">교수이름</option>
            		</select>&nbsp;
            		<input class="form-control" name="query" placeholder="검색어">
            		<input class="btn btn-primary" value="검색" type="submit">
            		</div>
            	</form>
            	<div class="col text-end" id="btn-btn">
             		<button class="btn btn-primary">등록</button>
             		</div>
            </div>
             <div id="div_pro"></div>
             <div id="pagination" class="pagination justify-content-center"></div>
        </div>
</div>
<!-- Modal -->
<div class="modal fade" id="list" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<jsp:include page="/cou/insert.jsp"/>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>

<script id="temp_pro" type="text/x-handlebars-template">
    <table class="table">
		<tr>
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>강의시수</th>
			<th>강의실</th>
			<th>교수이름</th>
			<th>총인원</th>
			<th>수강인원</th>
			<th>점수입력</th>
		</tr>
        {{#each .}}
        <tr>
            <td>{{lcode}}></td>
            <td><a href="/cou/update?lcode={{lcode}}">{{lname}}</a></td>
          	<td>{{hours}}</td>
            <td>{{room}}</td>
            <td>{{pname}}({{instructor}})</td>
            <td>{{capacity}}</td>
 			<td>{{persons}}</td>
			<td>
			<a href="/cou/grade?lcode={{lcode}}">
			<button class="btn btn-success btn-sm">점수입력</button>
			</a>
			</td>
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
    
    $("#div_pro").on("click", ".update", function(){
    	const lcode= $(this).attr("lcode");
    	location.href="/cou/update?lcode=" + lcode;
    });
    
    $("#btn-btn").on("click", function(){
    	$("#list").modal("show");
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
            url:"/cou/total",
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
            url:"/cou/list.json",
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