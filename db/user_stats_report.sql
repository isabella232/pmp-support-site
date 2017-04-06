-- Query to get document totals for the 5 PMP founding partners for a specific month
-- To get data for June 2016, set the date in the where clause for both 'created_at' expressions to '2016-07-01'
select user_guid,
  CASE
  WHEN user_guid='6140faf0-fb45-4a95-859a-070037fafa01' THEN 'NPR'
  WHEN user_guid='fc53c568-e939-4d9c-86ea-c2a2c70f1a99' THEN 'PBS'
  WHEN user_guid='7a865268-c9de-4b27-a3c1-983adad90921' THEN 'PRI'
  WHEN user_guid='98bf597a-2a6f-446c-9b7e-d8ae60122f0d' THEN 'APM'
  WHEN user_guid='609a539c-9177-4aa7-acde-c10b77a6a525' THEN 'PRX'
  ELSE ''
  END as user_name,
  (story_count + image_count + audio_count + video_count) as user_total
from user_stats
where created_at >= '2016-07-01 00:00:00' and created_at < '2016-07-01 00:30:00';