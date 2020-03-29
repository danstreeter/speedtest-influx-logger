# System Imports
import os
import re
import subprocess
import time

# Framework / Library Imports
from influxdb import InfluxDBClient
import schedule

# Application Imports

# Local Imports


INFLUX_HOST = os.environ.get('INFLUX_HOST', None)
INFLUX_PORT = os.environ.get('INFLUX_PORT', None)
INFLUX_USER = os.environ.get('INFLUX_USER', None)
INFLUX_PASS = os.environ.get('INFLUX_PASS', None)
INFLUX_DB = os.environ.get('INFLUX_DB', None)
TEST_FREQUENCY = int(os.environ.get('TEST_FREQUENCY', 60))

def check_speed():
    print("Running speedtest")
    response = subprocess.Popen(
        '/usr/local/bin/speedtest-cli --simple',
        shell=True,
        stdout=subprocess.PIPE
    ).stdout.read().decode('utf-8')

    ping = re.findall('Ping:\s(.*?)\s', response, re.MULTILINE)
    download = re.findall('Download:\s(.*?)\s', response, re.MULTILINE)
    upload = re.findall('Upload:\s(.*?)\s', response, re.MULTILINE)

    ping = ping[0].replace(',', '.')
    download = download[0].replace(',', '.')
    upload = upload[0].replace(',', '.')

    speed_data = [{
        "measurement": "internet_speed",
        "tags": {
            "host": "srv1"
        },
        "fields": {
            "download": float(download),
            "upload": float(upload),
            "ping": float(ping)
        }
    }]

    client = InfluxDBClient(INFLUX_HOST, INFLUX_PORT, INFLUX_USER, INFLUX_PASS, INFLUX_DB)

    client.write_points(speed_data)
    print("Speedtest complete: " + str(download) + "/" + str(upload))

schedule.every(TEST_FREQUENCY).minutes.do(check_speed)

print("Starting Scheduler")
print("Speedtest runs every " + str(TEST_FREQUENCY) + " minutes")

check_speed()

while True:
    schedule.run_pending()
    time.sleep(1)