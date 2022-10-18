--- 인사 db : 배치 잡으로 매일 업데이트 

-- 인사 정보 
select * 
from [USER] u;

--경력 정보
select * 
from USER_CAREER uc;

--학력 정보
select * 
from USER_SCHL us;

-- 평가 설정
select * 
from EVU_STD;

--년도별 평가 단계 설정
select * 
from EVU_STEP es;

-- 직무별 CDP
select * 
from EVU_CDP ec;

-- CDP별 역량 매핑
select * 
from EVU_CDP_COMP ecc;
 
-- 역량 정의
select * 
from EVU_COMP_DEFINE ecd;

-- 평가
select * 
from EVU_MNG;

select *
from EVU_TASK et;

select *
from EVU_TOT et;

select * 
from EVU_FEEDBACK ef;


	