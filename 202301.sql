
select
	DISTINCT T1.empNm as '이름',
	T1.empId as '사번',
	T1.postNm as '직급',
	c.CDP_NM as '직무 명',
	CATE1.CATE_NM as '역량 구분',
	CATE2.CATE_NM as '카테고리',
	f.COMP_TITLE as '역량명',
	e.DEFINE_CD as '역량 코드',
	f.CUSTOM_YN as custom,
	case 
		when e.PRIORITY = 0 then 'N'
		when e.PRIORITY = 1 then 'Y'
	end as '우선 순위',
	T1.TDS1 as'TDS1 1차 평가',
	T1.TDS1_AF as 'TDS1 변동 방향',
	T1.TDS2 as 'TDS2 1차 평가',
	T1.TDS2_AF as 'TDS2 변동 방향' ,
	T1.TDS3 as 'TDS3 1차 평가',
	T1.TDS3_AF as 'TDS3 변동 방향'
from (
	SELECT 
		TOP (100) PERCENT
		b.EMP_NM as empNm,
		b.EMP_ID as empId,
		b.POST_CD as postCd,
		b.POST_NM as postNm,
		a.CDP_CD as cdpCd,
		a.EVU_EMP_NO as evuEmpNo,
		i.EVU_CDP_COMP_ID  as evuCompId,
		a.CUR_STEP_CD as curStepCd,
		a.CHASU  as chasu, 
		a.EVU_STAT_CD as evuStatCd,
		a.EVU_STD_ID as evuStdId,
		case
		when i.MNG1_SCORE_1Q = 5 then 'SUPEX'
		when i.MNG1_SCORE_1Q = 4 then 'Exceed'
		when i.MNG1_SCORE_1Q = 3 then 'Meet'
		when i.MNG1_SCORE_1Q = 2 then 'Need'
		when i.MNG1_SCORE_1Q = 1 then 'Unsatisfactory'
		ELSE '' end as TDS1 ,
	case
		when i.MNG1_AF_SCORE_1Q = 0 then '-'
		when i.MNG1_AF_SCORE_1Q = 3 then '개선'
		when i.MNG1_AF_SCORE_1Q = 2 then '유지'
		when i.MNG1_AF_SCORE_1Q = 1 then '하락'
		ELSE '-' end as TDS1_AF ,
	case
		when i.MNG1_SCORE_2Q = 5 then 'SUPEX'
		when i.MNG1_SCORE_2Q = 4 then 'Exceed'
		when i.MNG1_SCORE_2Q = 3 then 'Meet'
		when i.MNG1_SCORE_2Q = 2 then 'Need'
		when i.MNG1_SCORE_2Q = 1 then 'Unsatisfactory'
		ELSE '' end as TDS2 , 
	case
		when i.MNG1_AF_SCORE_2Q = 0 then '-'
		when i.MNG1_AF_SCORE_2Q = 3 then '개선'
		when i.MNG1_AF_SCORE_2Q = 2 then '유지'
		when i.MNG1_AF_SCORE_2Q = 1 then '하락'
		ELSE '-' end as TDS2_AF ,
	case
		when i.MNG1_SCORE_3Q = 5 then 'SUPEX'
		when i.MNG1_SCORE_3Q = 4 then 'Exceed'
		when i.MNG1_SCORE_3Q = 3 then 'Meet'
		when i.MNG1_SCORE_3Q = 2 then 'Need'
		when i.MNG1_SCORE_3Q = 1 then 'Unsatisfactory'
		ELSE '' end as TDS3 ,
	case
		when i.MNG1_AF_SCORE_3Q = 0 then '-'
		when i.MNG1_AF_SCORE_3Q = 3 then '개선'
		when i.MNG1_AF_SCORE_3Q = 2 then '유지'
		when i.MNG1_AF_SCORE_3Q = 1 then '하락'
		ELSE '-' end as TDS3_AF  
	FROM EVU_EMP a
	INNER JOIN [USER] b on a.EVU_EMP_ID = b.EMP_ID 
	INNER JOIN EVU_COMP i on (i.EVU_EMP_NO = a.EVU_EMP_NO and i.EVU_STD_ID='202201')  
	where b.POST_CD not in ('GB1','GB2','GB3','GB4','GB5','GBS1')  and a.EVU_STD_ID ='202201'
	order by b.EMP_ID 
	) as T1
inner join EVU_CDP c on c.CDP_CD = T1.cdpCd 
INNER JOIN EVU_STD S ON (T1.evuStdId = S.EVU_STD_ID)
inner join EVU_EMP_CDP d on (d.CDP_CD = c.CDP_CD and T1.curStepCd = d.STEP_CD)  --- 현재 step 기준으로 
inner join EVU_CDP_COMP e on (e.EVU_CDP_CD = d.CDP_CD and e.EVU_CDP_COMP_ID = T1.evuCompId)
inner join EVU_COMP_DEFINE f on f.DEFINE_CD = e.DEFINE_CD 
LEFT JOIN EVU_COMP_CATE CATE1 ON (f.CATE_CD1 = CATE1.CATE_CD)
LEFT JOIN EVU_COMP_CATE CATE2 ON (f.CATE_CD2 = CATE2.CATE_CD)
LEFT JOIN EVU_COMP_CATE CATE3 ON (f.CATE_CD3 = CATE3.CATE_CD)
LEFT JOIN EVU_STAT ST ON (T1.curStepCd = ST.EVU_STEP_CD AND T1.chasu = ST.CHASU AND T1.evuStatCd = ST.EVU_STAT_CD)
LEFT JOIN EVU_STEP SP ON (ST.EVU_STEP_CD = SP.EVU_STEP_CD AND SP.EVU_STD_ID = S.EVU_STD_ID)
where c.EVU_STD_ID ='202201' and ST.EVU_STAT_SEQ ='228'
order by  T1.empId  asc;