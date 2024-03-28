with hopital_bed_prep as 
(
SELECT
LPAD(cast(provider_ccn as text),'6', '0')as provider_ccn_new,
hospital_name,
to_date(fiscal_year_begin_date,'MM/DD/YYYY')AS fiscal_year_begin_date,
to_date(fiscal_year_end_date, 'MM/DD/yyyy')AS fiscal_year_end_date,
number_of_beds,
  row_number() over(partition by provider_ccn order by to_date(fiscal_year_end_date, 'MM/DD/yyyy')desc) as uniq_row
FROM "Hospital_Data".hospital_beds
)
select 
LPAD(cast(facility_id as text),'6', '0')as provider_ccn_new,
to_date(start_date,'MM/DD/YYYY')AS start_date_converted,
to_date(end_date, 'MM/DD/yyyy')AS end_date_converted,
hbp.fiscal_year_begin_date as hbp_start_report_period,
hbp.fiscal_year_end_date as hbp_start_report_period,
hbp.number_of_beds 
hcahp,*
from "Hospital_Data".hcahps_data as hcahp
	left join hopital_bed_prep as hbp
	on LPAD(cast(facility_id as text),'6', '0')=hbp.provider_ccn_new
	where uniq_row=1

	
	
	

