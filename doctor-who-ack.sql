SELECT state.alarm_id, 
	alarm.name, 
    state.entity_id, 
    state.alarm_acknowledged,
    state.ack_user, 
    state.ack_time 
FROM vpx_alarm_state AS state 
INNER JOIN vpx_alarm as alarm ON (state.alarm_id = alarm.alarm_id) 
WHERE state.alarm_acknowledged=1;
