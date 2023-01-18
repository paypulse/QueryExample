select 
	u.EMP_NM ,
	et.TOT_GRD_1Q ,
	et.TOT_GRD_2Q ,
	et.TOT_GRD_3Q ,
	et.TOT_GRD_4Q ,
	et.TOT_CFM_GRD_1Q ,
	et.TOT_CFM_GRD_2Q ,
	et.TOT_CFM_GRD_3Q ,
	et.TOT_CFM_GRD_4Q 
from [USER] u 
inner join EVU_EMP ee on (u.EMP_ID= ee.EVU_EMP_ID)
left join EVU_TOT et on (ee.EVU_EMP_NO = et.EVU_EMP_NO)
where ee.EVU_STD_ID ='202201' and et.EVU_TYPE ='C' and et.TOT_GRD_3Q != et.TOT_CFM_GRD_3Q 
order by u.EMP_ID 

/**
위의 상황 시나리오는 
ADMIN에서 개인 평가/결과 확인 메뉴에서
평가 확정/완료 인 사람에 한해 결과를 변경 해버렸는데. 
이미 프론트에서 피평가자가 확인 하기에는 변경 전 결과로 보여지기 때문에 
변경된 건에 대해서 다시 공지를 하고자 위와 같은 데이터가 필요 
**/