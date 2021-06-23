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

