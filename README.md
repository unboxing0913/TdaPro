#프로젝트 주제

실내건축 디자인 +신입개발자의 기본소양인 CRUD를 구현한 게시판을 만들기

제작동기 모든 웹사이트를 만들때 뿌리가 게시판이기 때문에 직접 프로젝트를 통한 경험습득이 목표 학원 공부와 추가적인 개인공부를 통해 얻은 지식을 바탕으로 실제 프로젝트에 적용해 보기위함

개발환경 개발 도구 : sts3

언어 : java

Front Bootstrap 3 , Jquery

Back jdk1.8 , lombok , oracleSQL , Mybatis , Tomcat(9) , Maven , juit, ajax ,hikariCP(커넥션 풀) , security (회원권한) springframwork 5.0.7 RELEASE 버전

■■■■■■■■■■■■■■■2021-06-16■■■■■■■■■■■■■■■

Bootstrap3 사용하여 View의 각 필요한 페이지 HTML 설계

메인페이지 (홈)

회원 가입 페이지 ( member )

회원 정보 페이지 (수정)

회원 관리 페이지 (회원등급 변경)

로그인 페이지 , 로그아웃 페이지

공지사항 게시판 페이지 (admin 권한)

자유 게시판 페이지 (admin , member 권한)

QnA 게시판 페이지 (admin , member 권한)

첨부파일 게시판 페이지 (admin , member 권한)

현재 메인페이지 완료 header , footer 설정

컨트롤러 매핑 연결하고나서 bootstrap 샘플로 전체 view 페이지 설계할 예정

메인페이지의 header와 footer 모두 반응형으로 제작

main 페이지 상단에는 bootstrap 컴포넌트인 carousel 을 사용하여 슬라이더 효과를 줌

main 페이지 하단에는 그리드를 4로 나누어 필요한 정보와 상담링크 태그를 적용

추후 개발시 수정가능성이 있음

■■■■■■■■■■■■■■■2021-06-17■■■■■■■■■■■■■■■

스프링 프레임워크 5.0.7 RELEASE 버전 (xml설정 이용)

간단한코드와 테스트를위해 lombok설치후 라이브러리 추가

버전호환때문인지 log4j 버전을 낮추어줌

SrpingLegacyProject로 생성된 프로젝트이기때문에 서블릿2.5 -> 서블릿 3.0으로 수정

메이븐 컴파일 옵션 1.8 변경

테스트를위한 Junit버전 -> 4.12 변경 , spring-test 라이브러리 추가

오라클연결을 위한 오라클 데이터베이스 생성 + 오라클 데이터베이스 포트번호 9090으로 변경

오라클 데이터베이스 11g 는 Maven지원이 안되기때문에 직접 ojdbc8.jar 파일 프로젝트에 추가

JDBC 테스트 코드 작성으로 연결테스트

커넥션풀을 사용하기위한 HikariCP 라이브러리 추가 (버전 2.7.4)

dataSource 연결 테스트

SQL을 빠르게 처리하기위한 구조를 만들기위해 MyBatis 라이브러리 추가 및 연동

Mybatis-spring 의 Mapper를 이용하기위한 코드 추가

mapper패키지에 테스트하기위한 mapper인터페이스 와

추후에 사용할 mapper.xml을 위한 공간 확보 및 생성 그리고 테스트

SQL 로그를 제대로 확인하기위해 log4jdbc-log4j2 라이브러리 추가,

로그 설정 파일을 추가

log4jdbc 를 사용하기위해 JDBC 드라이버와 URL 정보 수정

mapper 테스트 코드로 확인




■■■■■■■■■■■■■■■2021-06-18■■■■■■■■■■■■■■■



sts와 깃허브연동중 status 일부만 연동해서 올려야하는것을 전부다 저장소에 올리는 실수를함
git revert를 했지만 잘 사용하지못하고 pom.xml이 없어지는 현상발생
저번에 저장소를 이용해서 최소한의 코드를 가져온뒤 오늘 작업한 코드까지 추가해서
새로운 저장소에 저장

현재 View 페이지
공지사항(입력,수정/삭제,목록) , 로그인 , 회원가입 , 견적게시판(입력,수정/삭제,목록) , 후기게시판(입력,수정/삭제,목록) 진행
추후에 디자인적으로 추가될수있음


■■■■■■■■■■■■■■■2021-06-21■■■■■■■■■■■■■■■


JSON데이터를 만들어내는 용도인 jackson-databind 라이브러리 추가

AOP를 이용한 방식으로 ControllerAdvice를 사용해 예외페이지컨트롤러 작성 (예외페이지 View 작성)

시퀀스 -> ROWNUM 방식사용할예정

데이터베이스 review_board테이블 작성

create sequence rv_seq_board;

create table review_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
    );

alter table review_board add constraint pk_review_board primary key(bno);


review_board 테이블 반영하는 ReviewVO 클래스 생성
ReviewMapper 인터페이스 생성
Mapper.xml 작성하기전 ReviewMapperTests 클래스만든후 JUnit 으로 테스트 

테스트 성공후 src/main/resources -> org/unboxing/mapper/ReviewMapper.xml 생성

영속영역의 CRUD 구현 (ReviewMapper)

JUnit 테스트코드 작성으로 동작테스트

깃허브 연동후 커밋을했는데 워크트리에 안보이는현상발견 내일 한번 찾아볼예정



■■■■■■■■■■■■■■■2021-06-22■■■■■■■■■■■■■■■

깃허브 sts push오류 해결 ( 정상적으로 동작 ) 

Review 게시판 비즈니스 계층 구현 (service)

ReviewService 인터페이스 구현 ReviewServiceImpl 구조설정 완료

JUnit 테스트 코드 작성으로 동작테스트



■■■■■■■■■■■■■■■2021-06-23■■■■■■■■■■■■■■■

프레젠테이션(웹)계층의 CRUD 구현

Review Controller 분석

▶리뷰목록
URL : /review/list 
Method : GET

▶리뷰등록
URL : /review/register
Method : POST
Parameter : 모든항목
From : 입력화면 필요
URL이동 : 이동

▶리뷰조회
URL : /review/read
Mehtod : GET
Parameter : (ex) bno = 123

▶리뷰삭제
URL : /review/remove
Method : POST
Parameter : bno
From : 입력화면 필요
URL이동 : 이동

▶리뷰수정
URL : /review/modify
Method : POST
Parameter : 모든항목
From : 입력화면 필요
URL이동 : 이동


Review 컨트롤러 작성

JUnit 테스트코드 작성으로 동작테스트

만들어 놓은 Review 페이지의 View 페이지들과 경로 연결

Review list 페이지 전달받은 list로 데이터베이스 내용 테스트 완료

Review resiter페이지 get방식으로 호출 후 post방식으로 전달되어 데이터베이스에 전송되는 테스트 완료
(한글깨지는 문제는 web.xml의 filter 처리로 해결 ) 

resiter 페이지 등록시 ( Modal 설정 )

list 페이지에서 resiter 페이지로 이동할수있는 등록 버튼 생성 
등록버튼 스크립트 사용으로 클릭시 동작 설정 

조회페이지 Controller에서 받아온 board값으로 value설정 ( get페이지에서 수정불가하게 readonly="readonly" 읽기전용설정 )

조회페이지 수정버튼 클릭시 /review/get?bno=? 형식으로 게시물 번호를 피라미터로 전달받게함

목록페이지에서 조회페이지 이동시 <a>태그로 이동할수있게 처리

조회페이지에서의 목록페이지로 돌아가는 버튼과 수정버튼 추가

뒤로가기시 실행되는 모달창을 설정하기위해 history객체 사용 스크립트 추가

게시물 수정/삭제처리 페이지 

수정페이지도 get방식( 매핑get과 동일 ) 추가해준뒤 Controller로 전달받은 데이터로 값 수정후 버튼생성

JavaScript를 활용한 수정/삭제/목록 버튼의 동작 추가 (버튼 별 다른 명령)

조회페이지의 form처리 ( 수정/삭제 , 목록 페이지로 보내기위한 script form 처리 ) 
    
    
■■■■■■■■■■■■■■■2021-06-24■■■■■■■■■■■■■■■

데이터베이스 페이징처리 
테이블 재귀 복사를 통해 데이터양 500개 추가
insert into review_board (bno,title,content,writer)
(select rv_seq_board.nextval,title,content,writer from review_board);

페이징처리를 위해 order by 를 사용하기보다
오라클의hint와 index를 사용 (데이터의 양이 많을때 실행시간을 단축시키기위함)

ROWNUM을 사용해 게시글 넘버링을 해줌

10개씩 페이징 처리하기위해 index를 역순으로 rownum번호를 매긴뒤 조건문추가

select
/*+INDEX_DESC(review_board pk_review_board)*/
 rownum rn , bno , title , content
from review_board where rownum <= 10


1페이지는 문제없지만 2페이지 처리하는데에서 rownum이 1을포함하지못해 출력되지않는 문제발생 (rownum은 반드시1이 포함)
-->2페이지는 인라인 뷰로 처리

select 
bno , title , content
from(
select
/*+INDEX_DESC(review_board pk_review_board)*/
 rownum rn , bno , title , content
from review_board where rownum <= 20
)
where rn > 10;



MyBatis와 스프링에서 페이징 처리를위해  domain패키지안에 Criteria 클래스를 작성

ReviewMapper 인터페이스에 페이징 처리 메소드(Criteria타입을 피라미터로받는) 추가

ReviewMapperTests에서 기본값으로 테스트 확인 
--> mybatis 의 xml안에서 세미콜론(;) 사용해 오류 발생함...

매퍼 xml 페이징처리 부분 수정 (Criteria 클래스의 pageNum , amount 필드값을 가지고 처리하도록) 
<select id="getListWithPaging" resultType="org.unboxing.domain.ReviewVO">
<![CDATA[
select 
	bno , title , content , writer , regdate , updatedate
	from(
		select
			/*+INDEX_DESC(review_board pk_review_board)*/
 			rownum rn , bno , title , content , writer , regdate , updatedate
			from review_board where rownum <= #{pageNum} * #{amount}
		)
	where rn > (#{pageNum}-1) * #{amount}
]]>

</select>


ReviewSerivce 수정 (목록 페이징처리한 매퍼로 수정) --> Service수정시 testService 는 오류가나오기때문에 맞춰서 수정
ReviewController 또한 페이징처리클래스인 Criteria 를 매개변수로 받을수있도록 수정 -> 컨트롤러 테스트


페이징 화면처리를 위한 page(현재) , prev(이전) , next(다음) , startPage(시작번호) , endPage(끝번호)

▶endPage(끝번호) 계산 (페이지번호 10개씩 보인다는 가정)
this.endPage = (int)(Math.ceil( 페이지번호 / 10.0)) * 10;

▶startPage(시작번호) 계산 (페이지번호 10개씩 보인다는 가정)
this.startPage = this.endPage - 9;

▶total을 통한endPage 재계산 (끝번호와 한페이지당출력되는 데이터수의 곱이 전체데이터수보다 클때)
realEnd = (int)(Math.ceil((total * 1.0) / amount) );
if(realEnd < this.endPage){
  this.endPage = realEnd;
}

▶prev(이전) 계산
this.prev = this.startPage > 1;

▶next(다음) 계산
this.next = this.endPage < realEnd;


페이징 처리를 위한 클래스 설계
PageDTO 클래스를 만들어 startPage , endPage , prev , next , total , cri 변수를 만들고 계산법을 사용해 값을 계산해줌

ReviewController 클래스의 list 수정 ( pageMaker 라는 이름으로 PageDTO 전달 )

Review list.jsp 안에 page번호 Bootstrap으로 추가 

JavaScript로 페이지 번호 이벤트처리 

get.jsp에서 목록이동버튼 클릭시 1페이지로만 이동하는 증상 페이징 처리 (파라미터 같이전송하기위해 list.jsp 수정)
---> 제목 눌렀을시 페이지이동하는 <a>태그를 수정해주고 스크립트로 처리
---> list.jsp 수정후 ReviewController의 /get 매핑부분 수정 ( pageNum과 amount를 받아줄 @ModelAttribute("cri") Criteria cri 매개변수 추가 )
---> get.jsp 받아온 정보를 form 안의 input 의 hidden타입으로 저장


조회 페이지에서 수정 버튼을통해 수정/삭제 페이지 이동시에도 목록으로 이동하는 버튼이 존재하지만 
/get 매핑에서 /get과 /modify를 같이 처리하기때문에 별도의 처리가 필요없음 (파라미터들은 자동으로 같이전송됨)
--->전송된 Criteria 의 정보들을 modify.jsp의 form안에 hidden타입의 input 태그로 저장
--->수정/삭제 처리를 하기위해 ReviewController안의 페이지관련 파라미터 처리해줌 (수정/삭제이후 기존에 보던 페이지로 이동하기위함)


수정/삭제 를 취소하고 목록페이지로 이동했을때 form태그의 pageNum과 amount를 제외한 다른내용은 삭제하고 필요한 내용만 추가하기위해
modify.jsp 의 javaScript부분을 수정

MyBatis에서 전체 데이터 개수 처리 ( 현재는 임시로 123으로 받고있었음 )
---> ReviewMapper 인터페이스에 getTotalCount 메서드생성 (Criteria를 매개변수로받음)
---> ReviewMapper.xml 에 total을 구할수있는 SQL문 작성 
<select id="getTotalCount" resultType="int">
	select count(*) from review_board where bno > 0
</select>

---> service에 전체 데이터수를 구하는 서비스생성
---> ReviewController 이동후 임시로 사용했던 123대신 service 메서드를 사용후 total을 구한뒤 전체데이터수 pageDTO에 담아 전달 (pageMaker)
     
	
■■■■■■■■■■■■■■■2021-06-25■■■■■■■■■■■■■■■

검색조건처리 

MyBatis XML에서 동적태그를 이용해  OGNL 표현식을 이용해 조건문을 생성

페이징처리했던 Criteria 클래스에 검색조건 처리도 같이 해주기위해 코드추가

ReviewMapper.xml에서의 getListWithPaging() 수정을 통해 동적 SQL을 처리 ( <sql>태그 사용 <include> 적용 )

ReviewMapperTests 클래스에서 테스트 ( 실행할때 만들어지는 SQL이 정상작동하는지 )

화면에서 검색조건을 처리하기위한 view 수정 

view에서 검색조건처리가 잘되는지 테스트 ( 영문과 한글 )

검색버튼 스크립트 이벤트처리 (페이지가 1페이지로 보이도록수정 , 입력안했을시 경고창 출력)

검색했을시 검색조건과 키보드가 노출될수있도록 list.jsp 수정

페이지 번호 이동시 검색조건과 키워드도 같이 전달되어야하므로 form 안에 Type , Keyword 추가
 
조회 페이지에도 검색처리 get.jsp의  ( form 안에 Type , Keyword 추가 )

수정/삭제 페이지에도 검색처리 modify.jsp의  ( form 안에 Type , Keyword 추가 )
---> 수정/삭제 처리는 ReviewController에서 redirect방식으로 동작하기때문에 컨트롤러에서 type, keyword 조건을 같이 포함
---> 관련된 JavaScript 코드 수정

Criteria 클래스 안에 UriComponentsBuilder 를 사용해 피라미터들을 URL형태로 만들어 컨트롤에서 리다이렉트시 코드길이를 줄여주는 메서드 추가
---> 새로만든 메서드를 ReviewController에 적용해서 코드양을 줄임



REST 방식의 Ajax를 사용하여 Review의 댓글처리
--->테스트하기위해 Restlet Client 도구 사용

▶댓글 처리를 위한 테이블 생성
create table rv_reply(
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
 );

▶댓글 처리시 사용할 시퀀스
create sequence rv_seq_reply;

▶rv_reply 테이블 권한 설정 (pk)
alter table rv_reply add constraint pk_reply primary key (rno);
    
▶rv_reply 테이블과 review_board 테이블의 (bno)값으로 fk 설정 
alter table rv_reply add constraint fk_review_reply foreign key (bno) references review_board(bno);


domain패키지에 Review_ReplyVO 클래스 생성 테이블값을 변수로 생성

Review_ReplyMapper 인터페이스와 XML 생성 및 처리

Review_ReplyMapper 테스트


---------------------------------------------------------------------------------------------------
Review_ReplyMapper를 이용한 CRUD 작업 및 테스트

댓글 목록작업 및 테스트 (@Param 어노테이션을 이용하는 방식)
-->SQL사용시 '#{}' 의 이름으로 사용이가능 	
	
■■■■■■■■■■■■■■■2021-06-26■■■■■■■■■■■■■■■

서비스 영역과 Controller 처리
Review_ReplyService 인터페이스와 구현한 Impl 클래스로 서비스 명령처리

Review_ReplyController 설계

▶등록 
URL : /review/replies/new
HTTP 전송방식 : POST
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 추가된것 확인

▶조회 
URL : /review/replies/:rno
HTTP 전송방식 : GET
---> 처리후 http://localhost:8080/review/replies/pages/900/1 주소에 값을입력해 잘 전달되는것 확인(값은 게시글번호)

▶삭제 
URL : /review/replies/:rno
HTTP 전송방식 : DELETE
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 삭제된것 확인

▶수정 
URL : /review/replies/:rno
HTTP 전송방식 : PUT or PATCH
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 수정된것 확인 (bno안에있는 {rno} 가 맞아야 수정되는것 확인)


▶목록 
URL : /review/replies/pages/:bno/page
HTTP 전송방식 : GET
---> 처리후 http://localhost:8080/review/replies/10 주소에 값을입력해 잘 전달되는것 확인 (값은 댓글번호)

	
■■■■■■■■■■■■■■■2021-06-28 ~ 2021-06-29■■■■■■■■■■■■■■■
어제 깃허브에 커밋을 올리지못하고 종료 오늘 이어서 2일치 

서비스 영역과 Controller 처리
Review_ReplyService 인터페이스와 구현한 Impl 클래스로 서비스 명령처리

Review_ReplyController 설계

▶등록 
URL : /review/replies/new
HTTP 전송방식 : POST
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 추가된것 확인

▶조회 
URL : /review/replies/:rno
HTTP 전송방식 : GET
---> 처리후 http://localhost:8080/review/replies/pages/900/1 주소에 값을입력해 잘 전달되는것 확인(값은 게시글번호)

▶삭제 
URL : /review/replies/:rno
HTTP 전송방식 : DELETE
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 삭제된것 확인

▶수정 
URL : /review/replies/:rno
HTTP 전송방식 : PUT or PATCH
---> 처리후 Yet Another REST Client를 이용해 테스트
      정상적으로 데이터베이스 수정된것 확인 (bno안에있는 {rno} 가 맞아야 수정되는것 확인)


▶목록 
URL : /review/replies/pages/:bno/page
HTTP 전송방식 : GET
---> 처리후 http://localhost:8080/review/replies/10 주소에 값을입력해 잘 전달되는것 확인 (값은 댓글번호)

-----------------------------------------------------
#2021-06-28

JavaScript 준비 (Review 의 Reply 에 대한 스크립트) 
resources / js (폴더를만들고) / review_reply.js 라는 전용으로 처리할 스크립트 파일을 만들어줌
--->get.jsp에 테스트 스크립트를 추가해주고 잘적용되는지 테스트

review_reply.js 내에는 등록 , 목록 , 삭제 , 수정 , 조회 처리를 스크립트에서 (객체,콜백)형태로 전달 호출

▶등록 : Ajax를 이용해 POST방식으로 호출하는 코드로 작성 

▶목록 : jQuery의 getJSON() 을 이용해 댓글의 전체 댓글 목록을 가져오는 처리 
------>param이라는 객체를 통해 필요한 파라미터를 전달받아 JSON 목록을 호출

▶삭제 : DELETE방식을 통해 해당 URL을 호출하는방식 (ajax를 이용해 타입을 구체적으로 delete 로 지정

▶수정 : 수정하는 내용과 함께 댓글의 번호전송 , JSON형태로 전송하기때문에 등록과 유사함

get.jsp에서 <script> 태그를 이용해 테스트후 주석처리 

-----------------
이벤트 처리와 HTML처리
---> 화면에서 버튼으로 발생하는 이벤트를 감지하고 Ajax호출의 결과를 화면에 반영

결과를 반영하기위해 get.jsp에 댓글목록을 보여줄수있는 화면을 추가


게시글 조회페이지가 열리면 자동으로 댓글목록을 가져와서 <li>태그를 구성하게하기위한 스크립트처리
--->댓글조회후 JSON 형태인 데이터를 오늘작성한 데이터는 시/분 아닌 데이터는 년/월/일 로 바꿔줄수있도록 review_reply.js 에서 수정

get.jsp 의 댓글 공간 상단에는 사용자를 위한 새로운댓글 달수있는 버튼을 추가

댓글추가는 모달창(bootstrap)을 이용해 처리하도록 get.jsp코드를 추가

댓글등록 버튼 클릭시 modal관련된 자바스크립트를 통해 모달창이 보여지게 처리

버튼등록클릭시 이벤트처리 이후 갱신처리

특정댓글의 클릭이벤트처리

댓글 수정이벤트처리 (모달창에있는 data-rno 값으로)

댓글 삭제이벤트처리 (모달창에있는 data-rno 값으로)

댓글의 페이징처리 (인덱스를 생성해 구조를만듬)
---> Review_ReplyMapper.xml 에서 페이징처리를 통한 목록처리후 테스트
---> 테스트를 하기위한 게시글번호에 댓글을 20개이상 작성

해당 게시물 댓글의 전체 숫자를 파악해 화면에 보이게만들어 주기위한 Review_ReplyMapper 인터페이스 추가 xml 입력
---> 댓글 목록과 함께 전체 댓글의 수를 같이 전달하기위한 Review_ReplyPageDTO 클래스 작성해준다
---> Review_ReplyService 인터페이스와 구현클래스 Impl 구조를 Review_ReplyPageDTO를 전달 받도록 변경
---> Review_ReplyController에서 새롭게 추가된 getListPage() 호출후 데이터를 전송하는 형태로 수정


댓글의 화면처리 
--> 가장 오래된 댓글이 1페이지 보여지도록 
--> 1페이지 게시물 가져올때 해당게시물의 숫자를 파악 댓글페이지 번호를 출력
--> 댓글이 추가되면 댓글 숫자만을 가져와서 최종페이지를 찾아 이동
--> 댓글의 수정과 삭제후 다시 동일페이지 호출

review_reply.js 의 getList 함수 부분 수정 (DTO를 가져오게끔)

댓글의 화면처리할부분을 만들고 JavaScript를 사용하여 기존의 Java로만들었던 PageMaker를 만들어준다.

: 현재 날짜별로 시간이 저장이안되는문제 발생 추후에 해결할예정
	
	

■■■■■■■■■■■■■■■2021-06-30■■■■■■■■■■■■■■■

: 현재 날짜별로 시간이 저장이안되는문제 발생 추후에 해결할예정
----> Review_ReplyMapper.xml 안에 인덱스를 넣어 SQL문을 처리했는데 idx를 안만들어주고 처리함
----> create index idx_reply on rv_reply (bno desc,rno asc);  데이터베이스에 인덱스를 만들어주어 처리완료 정상작동 

----------------

댓글과 댓글 수에대한 처리 

게시글의 댓글수에 대한 처리를 트랜잭션으로 하기위해 트랜잭션 설정을 추가해준다.
---> root-context.xml안의 <tx:annotation-driven> 태그를 등록

ReviewVO 와 ReviewMapper 안에 댓글의 숫자를 의미하는 인스턴스 변수를 추가
---->데이터베이스에도 replyCnt라는 칼럼을 추가해준다
alter table review_board add (replyCnt number default 0);

기존에 존재하고있는 댓글을 반영하기 위한 쿼리또한 실행시켜준다.
update review_board set replyCnt = ( 
	select count(rno) from rv_reply where rv_reply.bno = review_board.bno
	);

ReviewMapper.xml 안에 replycnt 칼럼이 업데이트 될수있도록 인터페이스메소드를 xml로 구현 해준다.
---> ReviewMapper.xml 안의 게시물 목록을 처리하는 부분또한 replyCnt 칼럼을 가져오도록 수정해준다.

Review_ReplyServiceImpl 의 트랜잭션처리
---> 게시물에 새로운 댓글이 추가되거나 삭제되는 상황에서 ReviewMapper와 Review_ReplyMapper를 같이이용해 처리 (트랜잭션)

화면처리
--->화면에서 댓글의 숫자(replyCnt)가 출력될수있도록 수정
--->화면처리가 잘되지않고 등록 수정에 문제가 생겨 무슨일인가 했지만 데이터베이스 commit을 안해서 생긴 실수


----------------

파일 업로드 처리 (Ajax를 이용하는 방식)
실제 서버가 동작하는 머신내에 있는 폴더에 업로드 시키기위해 

c드라이브 -> upload 폴더 -> review 파일을 저장할 review 폴더 생성  (web.xml의 임시저장소는 c->upload->temp)

web.ml 상단의 네임스페이스 2.5버전을 찾아서 수정

ReviewController안에 파일업로드를 위한 매핑 추가

파일 업로드를 할수있는 uploadAjax.jsp 추가 (실제 홈페이지와 연결전 첨부파일처리 테스트를 하기위함 +매핑연결 테스트)

업로드한 파일을 받아 저장처리를 할수있는 매핑추가

파일 업로드 상세처리 
---> 확장자 , 크기 사전처리  script함수로 구현해서 처리
---> 한 폴더내의 너무많은 파일의 생성문제를 막기위한 년/월/일 폴더로 첨부파일 보관 (ReviewController에서 메소드추가 적용)
---> 중복되는 이름 UUID를 이용해 랜덤문자열 생성 처리

업로드한 파일 섬네일 이미지생성
---> Thumbnailator 라이브러리를 사용 (pom.xml에 추가)
---> 섬네일화 할 파일이 이미지파일인지 타입을 검사하는 메서드추가
---> 파일 업로드 매핑시 섬네일화 할수있는 메서드 추가 수정

별도의 객체를 생성해 업로드 객체를 반환
--->  jacson-databind 관련 라이브러리들이 존재하는지 확인
---> 첨부파일 정보를 저장하는 클래스 작성 (Review_AttachFileDTO)
---> ReviewController의 첨부파일 매핑부분에서 첨부파일정보를 저장한 클래스를 반환하는 구조로변경 
---> uploadAjax.jsp 에서 결과데이터를 json으로 반환된 정보를 처리할수있도록 수정 (dataType : 'json') 

브라우저에서 섬네일처리
---> 게시판페이지 연결전 테스트하기위한 uploadAjax.jsp를 사용
---> 네일처리 , 이름출력 , 일반파일처리(이미지X) , 업로드후 다운로드 , 한글값 인코딩 처리 , 이벤트처리 , 삭제처리 테스트


* 현재 첨부파일 테스트 페이지 링크 클릭시 다운로드가 안되는 현상발생 (시간을 너무 뺏겨 내일 수정계획) 
* 깃허브 push시 cannot open git-receive-pack 오류 발생 ( 내일 해결 예정 ) --> push또한 내일 한번에 2일치 올릴예정
	
	
■■■■■■■■■■■■■■■2021-07-01■■■■■■■■■■■■■■■

* 현재 첨부파일 테스트 페이지 링크 클릭시 다운로드가 안되는 현상발생 (시간을 너무 뺏겨 내일 수정계획) 
---> ReviewController의 resource 주소  수정 하니 정상작동

* 깃허브 push시 cannot open git-receive-pack 오류 발생 ( 내일 해결 예정 ) --> push또한 내일 한번에 2일치 올릴예정
--->해결 ( 컴퓨터 재시작하니 해결된듯 )

이미지 클릭시 다운로드되는것을 확인
---> UUID 를 제거하고 본래의 파일이름으로 저장될수있도록 컨트롤러 수정
---> subString을 사용 본래 이미지 이름이 다운로드될수있도록 해결 
 
이미지는 다운로드 대신 섬네일 클릭시 원본이미지보여줄 <div>처리  
---> script , css , html 처리 원본이미지 애니메이션효과
---> 원본클릭시 점차사라지도록 스크립트 설정

첨부파일 삭제처리
---> 화면에서 삭제처리를 할수있도록 이미지파일 옆에<span> 태그의 data-file과 data-type을 추가 클릭할수있도록  X 추가
---> span클릭시 ajax로 컨트롤러에 전송 , 컨트롤러에서 data type에 맞게 삭제처리


이제 테스트와 컨트롤러 들은 손을 보았고 첨부파일 등록시에 데이터베이스와 화면에 적용
---> 첨부파일의 정보를 위해 테이블을 설계
▶첨부파일 테이블
create table review_attach(
	uuid varchar2(100) not null,
	uploadPath varchar2(200) not null,
	fileName varchar2(100) not null,
	filetype char(1) default 'I',
	bno number(10,0)
);

▶첨부파일 pk , fk 설정
alter table review_attach add constraint pk_rv_attach primary key(uuid);
alter table review_attach add constraint fk_rv_attach foreign key(bno) references review_board(bno);



테이블에 맞게 ReviewAttachVO 클래스 추가
---> 테스트시 만들었던 Review_AttachFileDTO를 수정할까했지만 테스트해두었던 파일들이 문제가생기기때문에 (인스턴스변수) 새로만들기로함
---> 기존의 ReviewVO 또한 Review_AttachFileVO를 처리할수있도록 데이터를 추가해준다.

첨부파일을 위한 Mapper처리
---> 첨부파일같은경우는 insert() 와 delete() 의 작업을 이용해 처리
---> 특정 게시물의 번호를 구해와 첨부파일을 찾는 작업을 해야하기때문에 특정게시물 번호를 찾는 메서드 정의

등록을 위한 화면처리
---> 첨부파일 처리 Ajax를 이용
---> 게시물 등록버튼을 클릭했을때 서버 업로드된 파일의 정보를 input 태그의 hidden을 이용해 전송
---> 등록하기위한 화면처리부터 하기위해 register.jsp 수정
---> upload css 적용

등록시 JavaCript처리
---> 게시글 등록시 첨부관련 처리를 하도록 
---> test시에 업로드 매핑처리됬던 /uploadAjaxAction 으로 데이터 전송 (업로드 결과처리)

첨부파일 변경처리
---> 업로드 결과처리 할때 삭제버튼 도입 <svg> 부트스트랩 아이콘으로 도입후 버튼안에 삽입
---> 휴지통 버튼 클릭시 자바스크립트를통해 서버에서 삭제하도록 이벤트처리 ( 테스트시만들어두었던 deleteFile 매핑으로 전송 )

게시물 등록 , 첨부파일 데이터베이스 처리
---> <input>의 hidden태그를 사용해 처리하기때문에 첨부파일 정보를 태그로생성할때 첨부파일과 관련된 정보추가 (data-uuid,data-filename,data-type)
---> 입력 버튼을 통해 전송시 이미 업로드된 항목들의 관련된 정보가  <input>의 hidden태그를 통해 같이전송 되도록 코드 추가
---> 테스트로 만들어 두었던 /uploadAjaxAction 매핑안의 Attach를 담을수있는 클래스를 ReviewAttachVO로 수정 (구조 전체적으로 변경)
---> image라는 파라미터를 제외했으므로 테스트시 업로드결과 반영시 test 했던 파일과 다르게 (조건을 obj.fileType)으로 해주어야한다.

ReviewServiceImpl 처리
--->게시물 등록시 review_board 테이블과 review_attach 테이블 양쪽 insert가 필요하기때문에 트랜잭션처리를 해줌
--->게시물등록시 review_board 테이블에 게시물 먼저등록후 게시글번호를 가져와 review_attach에 데이터를 추가

게시물 조회와 첨부파일
---> 게시글정보는  review_board  테이블 , 첨부파일정보는 review_attach 에 두 테이블의 정보를 얻기위해 join 을 사용하기로함
---> ReviewService에 코드추가 (ReviewAttachMapper 안에 게시글번호 조회하는 메서드가 있기때문에 사용하기위해)
---> ReviewController 변경 (첨부파일 관련된 데이터를 JSON으로 반환하도록)

게시물 조회 화면처리
---> 조회후 게시글의 첨부파일을 자동으로 가져오는도록 동작하게 처리
---> 제일먼저 정보를 가져오는것을 테스트 성공, 첨부파일이 보여질 파일영역을 get.jsp에 만들어줌
---> 영역안에 JSON으로 가져온 첨부파일 데이터를 보이도록 처리해주는 스크립트 작성
---> (클릭시)첨부파일의 이미지의 경우 원본이미지 보이기 , 일반파일의 경우 다운로드 할수있도록 스크립트처리


게시물 삭제했을경우 첨부파일 같이 삭제하기
---> ReviewAttachMapper 클래스 안에 전체 첨부파일을 삭제하는 매퍼추가 (xml에 전체데이터를 삭제하는 SQL추가)
---> ReviewServiceImpl 으로 이동후 실제게시물 삭제시 첨부파일을 전체 다 삭제하도록 트랜잭션 실행후 전체삭제 매퍼호출

컨트롤로 호출후 게시물 삭제시 데이터 베이스 먼저삭제 호출후에 첨부파일을 삭제하기
---> 파일을 삭제하기위해선 게시물의 첨부파일 목록이 필요 
---> 첨부파일의 목록을 구한다해도 이미지파일의 경우 섬네일 파일이 생성되어있음 이에대한 처리가 필요
---> 해당게시물의 첨부파일 정보를 미리준비한뒤에 데이터베이스상 게시물과 첨부파일 데이터 삭제 후 첨부파일정보를 이용해 해당 폴더내용 삭제

첨부파일 정보 구하고 삭제구현
--->Criteria 에 만들어둔 getListLink()메소드(UriComponentsBuilder) 를 수정해 쿼리스트링을 처리     
---> ReviewController에 첨부파일 전체삭제 메서드추가 /remove 매핑내용을 수정

게시물 수정과 첨부파일
---> 게시물 수정은 /review/modify.jsp 에서 처리
---> 게시물 조회와 유사한처리 ( + 삭제버튼 ) , 확대나 다운로드기능은 필요없다.
---> modify 화면 영역은 get.jsp와 동일
---> 수정페이지가 로딩되면 첨부파일을 가져오는 처리
---> 가져온 첨부파일정보 영역에 표시될수있게 스크립트처리

첨부파일 삭제 이벤트
---> 사용자가 첨부파일중 일부를 삭제한 상태에서 수정하지않고 나가는 상황 방지
---> 첨부파일삭제시 화면에서만 삭제 --> 최종 수정시에 반영

수정시에 첨부파일을 추가할수있도록 처리
---> 기존 게시물 등록처리와 동일
---> 수정버튼 이벤트처리추가

서버 측 게시물 수정
---> 첨부파일 목록을 일일이 알기 복잡하기때문에 전부를지우고 다시 첨부파일목록을 (추가,삭제된것) 불러오는 방식으로 처리
---> 주기적으로 파일과 데이터베이스를 비교하는 방법을 사용해 처리 (Quaryz 라이브러리)

현재 데이터베이스에서는 삭제가 정상작동하지만 업로드된 파일은 그대로 남아있는 현상발생
--->잘못 업로드된 파일을 정리하기위해서 Quartz 라이브러리 설정 추가
---> 라이브러리 추가후 root-context.xml 네임스페이스 task 추가 + 설정
---> Task 작업의 처리 org.unboxing.task 패키지를 만들고 FileCheckTask 클래스 작성 
---> Task 정상작동 확인후 어제파일을 검색할수있는 매퍼설정 (ReviewAttachMapper)
---> FileCheckTask 클래스는 매일 새벽2시에 동작
---> 어제 사용된 파일의 목록을 얻어온뒤 해당폴더의 파일목록에서 데이터베이스에 없는 파일을 찾아내 삭제하는순서로 구성
---> 매일 새벽2시에 작동하도록 Task 설정
	
