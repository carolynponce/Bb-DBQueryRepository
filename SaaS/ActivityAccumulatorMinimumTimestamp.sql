-- Title: Activity Accumulator Minimum Time Stamp
-- Version: SaaS
-- Description: Finds the time and date of the oldest activity in the Activitiy Accumulator.

Select MIN(timestamp) from activity_accumulator
