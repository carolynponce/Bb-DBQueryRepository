/*----------
  jeff.kelley@blackboard.com  27 Feb 2021
  no warranty or support
  use with the _cms_doc database
  lists the paths and files of the largest 1000 files on the system.
  Excluding manual and automatic archives
  To run - highlight query and click play
  -----
*/

SELECT
  fver.blob_id,          -- blob ID is the key value of the unique file on the file system
  furl.file_id,
  furl.file_name,
  ROUND(ffile.file_size/1024/1024,2) AS size_mb,
  ffile.last_update_date,
  ffile.mime_type,
  furl.full_path

FROM xyf_urls furl
 INNER JOIN xyf_files ffile ON ffile.file_id = furl.file_id
 INNER JOIN xyf_file_versions fver ON fver.file_id = ffile.file_id
 
WHERE ffile.file_type_code = 'F'                            --F for Files and not D for directory
 AND furl.full_path NOT LIKE '/internal/autoArchive/%'     -- no automatic archives (in *_cms_doc)
 AND SPLIT_PART(furl.full_path,'/',5) != 'archive%'         -- no manual archives (in *_cms_doc)
 and furl.full_path like '%courseID%'

ORDER BY ffile.file_size DESC

FETCH FIRST 1000 ROWS ONLY
