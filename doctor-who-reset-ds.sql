SELECT 
    vpxv_events.event_id, 
    vpxv_events.create_time, 
   	vpx_alarm.name,
    vpxv_events.username, 
    vpxv_events.datastore_name 
FROM vpxv_events 
INNER JOIN vpx_alarm_runtime ON (vpxv_events.create_time   = vpx_alarm_runtime.created_time)
INNER JOIN vpx_alarm ON (vpx_alarm_runtime.alarm_id = vpx_alarm.alarm_id)
WHERE event_type = 'vim.event.AlarmStatusChangedEvent' 
    AND datastore_name IS NOT NULL;
