# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

___

## `0.0.7` - 2021-05-11

- Updated to publish to pypi

## `0.0.6` - 2021-05-11

- Missed requirements file caused invalid 0.0.5 image.

## `0.0.5` - 2021-05-11

- Upgraded the speedtest-cli package to 2.1.3 to address bugs it has with returned data.

## `0.0.4` - 2020-10-24

### Changed

- Implemented Requests (HTTP) write of InfluxDB data rather than direct InfluxDB library as was easier to get around reverse HTTP proxies this way

## `0.0.3` - 2020-09-27

### Added

- Added packaged version which can be installed via pipx as submitted to PyPi

## `0.0.2` - 2020-09-27

### Changed

- Changed the speedtest library to the Python version rather than a system binary (which is the python version)

## `0.0.1` - 2020-03-30

Initial working version