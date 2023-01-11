--- 2022_개인별_역량평가 결과 
select 
	c.EMP_NM as '성명',
	c.EMP_ID as '사번' ,
	c.POST_NM as '직급',
	d.CDP_NM  as '직무명',
	CATE1.CATE_NM as '역량구분' ,
	f.COMP_TITLE as '카테고리',
	f.COMP_DEFINE as '역량 명',
	e.DEFINE_CD as '역량 코드',
	f.CUSTOM_YN as Custom,
	f.DP_ORDER as '우선 순위',
	case
		when g.MNG1_SCORE_1Q is null  then ''
		when g.MNG1_SCORE_1Q = 0 then ''
		when g.MNG1_SCORE_1Q = 1 then 'Unsatisfactory'
		when g.MNG1_SCORE_1Q = 2 then 'Need'
		when g.MNG1_SCORE_1Q = 3 then 'Meet'
		when g.MNG1_SCORE_1Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS1 1차 평가',
	case
		when g.MNG1_AF_SCORE_1Q is NULL  then ''
		when g.MNG1_AF_SCORE_1Q = 0 then ''
		when g.MNG1_AF_SCORE_1Q = 1 then 'Unsatisfactory'
		when g.MNG1_AF_SCORE_1Q = 2 then 'Need'
		when g.MNG1_AF_SCORE_1Q = 3 then 'Meet'
		when g.MNG1_AF_SCORE_1Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS1 변동 방향' ,
	case
		when g.MNG1_SCORE_2Q is NULL  then ''
		when g.MNG1_SCORE_2Q = 0 then ''
		when g.MNG1_SCORE_2Q = 1 then 'Unsatisfactory'
		when g.MNG1_SCORE_2Q = 2 then 'Need'
		when g.MNG1_SCORE_2Q = 3 then 'Meet'
		when g.MNG1_SCORE_2Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS2 1차 평가' , 
	case
		when g.MNG1_AF_SCORE_2Q is NULL  then ''
		when g.MNG1_AF_SCORE_2Q = 0 then ''
		when g.MNG1_AF_SCORE_2Q = 1 then 'Unsatisfactory'
		when g.MNG1_AF_SCORE_2Q = 2 then 'Need'
		when g.MNG1_AF_SCORE_2Q = 3 then 'Meet'
		when g.MNG1_AF_SCORE_2Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS2 변동 방향' ,
	case
		when g.MNG1_SCORE_3Q is NULL  then ''
		when g.MNG1_SCORE_3Q = 0 then ''
		when g.MNG1_SCORE_3Q = 1 then 'Unsatisfactory'
		when g.MNG1_SCORE_3Q = 2 then 'Need'
		when g.MNG1_SCORE_3Q = 3 then 'Meet'
		when g.MNG1_SCORE_3Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS3 1차 평가' ,
	case
		when g.MNG1_AF_SCORE_3Q is NULL  then ''
		when g.MNG1_AF_SCORE_3Q = 0 then ''
		when g.MNG1_AF_SCORE_3Q = 1 then 'Unsatisfactory'
		when g.MNG1_AF_SCORE_3Q = 2 then 'Need'
		when g.MNG1_AF_SCORE_3Q = 3 then 'Meet'
		when g.MNG1_AF_SCORE_3Q = 4 then 'Exceed'
		ELSE 'SUPEX' end as 'TDS3 변동 방향'
from EVU_EMP a
inner join EVU_STD b on a.EVU_STD_ID = b.EVU_STD_ID 
inner join [USER] c on a.EVU_EMP_ID  = c.EMP_ID
LEFT  join EVU_CDP d on a.CDP_CD = d.CDP_CD 
left join EVU_CDP_COMP e on e.EVU_CDP_CD = d.CDP_CD 
left join evu_comp g on (g.EVU_EMP_NO = a.EVU_EMP_NO  and e.EVU_CDP_COMP_ID = g.EVU_CDP_COMP_ID)
left join EVU_COMP_DEFINE f on e.DEFINE_CD  = f.DEFINE_CD 
LEFT JOIN EVU_COMP_CATE CATE1 ON (f.CATE_CD1 = CATE1.CATE_CD)
LEFT JOIN EVU_COMP_CATE CATE2 ON (f.CATE_CD2 = CATE2.CATE_CD)
LEFT JOIN EVU_COMP_CATE CATE3 ON (f.CATE_CD3 = CATE3.CATE_CD)
where a.EVU_STD_ID ='202201' and CATE1.CATE_NM is not null
ORDER BY CATE1.CATE_NM ASC;