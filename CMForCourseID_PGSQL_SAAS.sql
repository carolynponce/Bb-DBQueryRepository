-- Title: CM for Course ID
-- Version: SaaS
-- Description: Search for informaiton concerning a course(s) based on Course ID.
-- Display/Output: Displays PK1, UUID, Date Created, etc. 

select * from course_main cm 
where course_id = '[Insert Course_ID]'
