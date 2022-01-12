-- Title: Version History of SaaS Updates
-- Author: Heather Crites, CSCC
-- Version: SaaS
-- Specific Blackboard Database: uses _admin database
-- Description: Allows the user to search for Version History with Install Date.

select *
from system_history
order by pk1 desc
