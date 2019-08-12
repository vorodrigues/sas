proc fedsql sessref=sascas1;
create table INVOICES.ABT_INVOICES_ALIMENTOS{options replace=true} as select
	a.*,
	_Col1_,
	_Col2_,
	_Col3_,
	_Col4_,
	_Col5_,
	_Col6_,
	_Col7_,
	_Col8_,
	_Col9_,
	_Col10_,
	_Col11_,
	_Col12_,
	_Col13_,
	/*_Col14_,
	_Col15_,
	_Col16_,
	_Col17_,
	_Col18_,
	_Col19_,
	_Col20_,
	_Col21_,
	_Col22_,
	_Col23_,
	_Col24_,
	_Col25_,*/
	case when b._concept_ is not null then 1 else 0 end as ALIMENTO
from INVOICES.ABT_INVOICES_ISSUED_ORIGINAL_ID as a
left join (
	select
		doc_id,
		_concept_
	from INVOICES.INVOICES_CONCEPTS
	where _concept_ = 'nlpAlimentos'
	group by
		doc_id,
		_concept_) as b
	on a.doc_id = b.doc_id
left join INVOICES.INVOICES_TOPICS as c
	on a.doc_id = c.doc_id;
quit;

proc casutil sessref=sascas1;
promote incaslib=INVOICES casdata="ABT_INVOICES_ALIMENTOS"
		outcaslib=INVOICES casout="ABT_INVOICES_ALIMENTOS";
run;