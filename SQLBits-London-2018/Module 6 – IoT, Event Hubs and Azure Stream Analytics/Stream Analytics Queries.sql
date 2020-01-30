--Job 1
SELECT
    [deviceid] AS 'DeviceId',
    [measurename] AS 'SensorType',
    [value] AS 'SensorReading',
    [timecreated] AS 'ReadingDateTime'
INTO
    [SQLDB] --OUTPUT
FROM
    [IoTHub]  --INPUT
TIMESTAMP BY
    [timecreated]
	
	
	
--Job 2
SELECT
    [deviceid] AS 'DeviceId',
    [value] AS 'SensorReading',
    [timecreated] AS 'ReadingDateTime'
INTO
    [PiLightSensor] --OUTPUT1
FROM
    [IoTHub] --INPUT
TIMESTAMP BY
    [timecreated]
WHERE
    [measurename] = 'Light'


SELECT
    [deviceid] AS 'DeviceId',
    [value] AS 'SensorReading',
    [timecreated] AS 'ReadingDateTime'
INTO
    [PiTempSensor] --OUTPUT2
FROM
    [IoTHub] --INPUT
TIMESTAMP BY
    [timecreated]
WHERE
    [measurename] = 'Temperature'
	
	
	
--Job 3
SELECT
    MIN([value]) AS 'MINSensorReading',
	MAX([value]) AS 'MAXSensorReading',
	AVG([value]) AS 'AVGSensorReading'
INTO
    [PiLightTWindow] --OUTPUT1
FROM
    [IoTHub] --INPUT
TIMESTAMP BY
    [timecreated]
WHERE
    [measurename] = 'Light'
GROUP BY
	TumblingWindow(Duration(second, 30), Offset(millisecond, -1))