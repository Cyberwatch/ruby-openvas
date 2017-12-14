# Ruby OpenVas

[![Build Status](https://travis-ci.org/Cyberwatch/ruby-openvas.svg?branch=master)](https://travis-ci.org/Cyberwatch/ruby-openvas)
[![Coverage Status](https://coveralls.io/repos/github/Cyberwatch/ruby-openvas/badge.svg?branch=master)](https://coveralls.io/github/Cyberwatch/ruby-openvas?branch=master)
[![Gem Version](https://badge.fury.io/rb/openvas.svg)](https://badge.fury.io/rb/openvas)

A ruby client for OpenVas API OMP 7.0.

## Description

Ruby-Openvas is a ruby interface for OpenVas vulnerability scanner.
Please remember to submit bugs and request features if needed.

## Install

```
gem install openvas
```

## Usage

- Configure the gem

```ruby
require 'openvas'

Openvas.configure do |config|
  config.url = "https://localhost:9390"
  config.username = "admin"
  config.password = "admin"
end
```

- Connect the client to OpenVas

```ruby
Openvas::Client.connect
```

- Authenticate to Openvas

```ruby
Openvas::Auth.login
```

- Retrive all scans and list the results

```ruby
Openvas::Scan.all.each do |scan|
  puts 'Scan Name : ' + scan.name
  puts '-'*40
  scan.last_results.each do |result|
    puts "\t- " +result.name
  end

  puts "-"*40
end
```

```
Scan Name : my vulnerable server
----------------------------------------
	- Apache Web Server Version Detection
	- Apache Web Server Version Detection
	- CGI Scanning Consolidation
	- CGI Scanning Consolidation
	- Check open ports
	- CPE Inventory
	- Database Open Access Vulnerability
	- Determine which version of BIND name daemon is running
	- DIRB (NASL wrapper)
	- DIRB (NASL wrapper)
	- DNS Server Detection (TCP)
	- HTTP Security Headers Detection
	- HTTP Server type and version
	- HTTP Server type and version
	- ICMP Timestamp Detection
	- MySQL/MariaDB Detection
	- Nikto (NASL wrapper)
	- Nikto (NASL wrapper)
	- No 404 check
	- OS Detection Consolidation and Reporting
	- PHP Version Detection (Remote)
	- robot(s).txt exists on the Web Server
	- Service Detection with nmap
	- Services
	- Services
	- Services
	- Services
	- Services
	- Services
	- SSH Protocol Algorithms Supported
	- SSH Protocol Versions Supported
	- SSH Server type and version
	- SSH Weak Encryption Algorithms Supported
	- SSH Weak MAC Algorithms Supported
	- SSL/TLS: Collect and Report Certificate Details
	- SSL/TLS: Report Medium Cipher Suites
	- SSL/TLS: Report Non Weak Cipher Suites
	- SSL/TLS: Report Perfect Forward Secrecy (PFS) Cipher Suites
	- SSL/TLS: Report Supported Cipher Suites
	- SSL/TLS: Report Vulnerable Cipher Suites for HTTPS
	- TCP timestamps
	- Traceroute
----------------------------------------
Scan Name : test
----------------------------------------
	- Ping Host
----------------------------------------
```

## Requirements

- Ruby >= 2.3
- Nokogiri http://github.com/tenderlove/nokogiri

## Note on Patches & Pull Requests

Pull Request are very welcome. Please fork the project, make your feature addition or bug fix
and send a pull request.

## Copyright

Copyright (c) 2017 Cyberwatch. See LICENSE for details.
