-- Title:CourseArchives-Manual
-- Author: (insert developer name)
-- Version: SaaS
-- Specific Blackboard Database: cms_doc
-- Description: list manually created exports and archives

SELECT
  furl.file_id
  ,furl.file_name
  ,ROUND(ffile.file_size/1024/1024,2) as size_Mb
  ,ffile.last_update_date
  ,ffile.mime_type
  ,furl.full_path
FROM xyf_urls furl
 JOIN xyf_files ffile on ffile.file_id = furl.file_id
 WHERE file_type_code = 'F'
  AND furl.full_path like '/internal/%/archive/%'   --this is the path to manual archive files
 --and ffile.last_update_date < to_date('2022-01-01','YYYY-MM-DD')
  ORDER BY ffile.file_size DESC