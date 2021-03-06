# Speedtest Influx Logger

## Summary

Micro application to run speedtests periodically and send statistics to remote InfluxDB node.

Was created to be run as a self contained daemon script, or within a Docker setup to automatically push speedtest results to a remote InfluxDB node for display within Grafana.

---

Can be run within a script by performing the following:

```python
import speedtest
from speedtest_influx_logger.main import check_speed

check_speed(speedtest.Speedtest())

# 2020-09-27 21:44:27 - Speedtest complete: 166.48/37.67
```

### Statistics

The script sends the following statistic data to Influx:

```json
{
    "measurement": "internet_speed",
    "tags": {
        "host": NODE_NAME,
        "client_version": APP_VERSION
    },
    "fields": {
        "download": float(download),
        "upload": float(upload),
        "ping": float(ping)
    }
}
```

## Installation

```
python3 -m pip install pipx
apt-get install -y python3-venv
pipx install speedtest-influx-logger
```

## Environment Variables

- NODE_NAME
- INFLUX_HOST
- INFLUX_PORT
- INFLUX_USER
- INFLUX_PASS
- INFLUX_DB
- TEST_FREQUENCY

## Links
- [GitHub](https://github.com/danstreeter/speedtest-influx-logger)
- [Docker Hub](https://hub.docker.com/r/danstreeter/speedtest-influx-logger)
- [PyPi](https://pypi.org/project/speedtest-influx-logger/)
