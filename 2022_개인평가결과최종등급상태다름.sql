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