-- Title: AttemptFileSizeByTerm-PGSQL-SAAS
-- Author: Ricardo Schons Cirio
-- Version: SaaS
-- Description: maximum and average file upload size in assessment attempts by term.

select
    term.name as term,
    max(arf.file_size)/1048576 as max_file_size_mb,
    avg(arf.file_size/1048576) as avg_file_size_mb

from attempt_receipt_file as arf
    join attempt_receipt as ar on ar.pk1 = arf.attempt_receipt_pk1
    join course_main as cm on cm.pk1 = ar.crs_main_pk1
    join course_term as ct on ct.crsmain_pk1 = ar.crs_main_pk1
    join term as term on term.pk1 = ct.term_pk1

group by term.name
