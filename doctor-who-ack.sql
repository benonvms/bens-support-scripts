SELECT
    vpx_alarm.name,
    vpx_entity.name, 
    vpx_alarm_state.ack_user, 
    vpx_alarm_state.ack_time 
FROM vpx_alarm_state
    INNER JOIN vpx_alarm ON (vpx_alarm_state.alarm_id = vpx_alarm.alarm_id)
    INNER JOIN vpx_entity ON (vpx_alarm_state.entity_id = vpx_entity.id)
WHERE vpx_alarm_state.alarm_acknowledged=1;
