# Logging and Error Messages

## Read the Log

### Log in the Application

The log files are displayed in the config menu.

### Log as Text Files

FreshRSS logs are located in:
* user related: `./FreshRSS/data/users/*/log.txt`
* general/system related: `./FreshRSS/data/users/_/log.txt`

### More Logging Information

More logs can be generated by enabling `'environment' => 'development'` (default: `'production'`), in `./FreshRSS/data/config.php`

## Error Message

If there is an 'Application Problem' or 'Fatal Error', then a HTTP 500 error message is shown with more information.

## Often the Cause of Problems

A typical problem is wrong file permissions in the `./FreshRSS/data/` folder so make sure the Web server can write there and in sub-directories.

## Common locations for additional logs

Adapt names and paths according to your local setup.

* If using Docker: `docker logs -f freshrss`
* To check Web server logs on a Linux system using systemd: `journalctl -xeu apache2` and if you are using php-fpm: `journalctl -xeu php-fpm`
* Otherwise, Web server logs are typically located in `/var/log/apache2/` or similar
* System logs may also contain relevant information in `/var/log/syslog`, or if using systemd: `sudo journalctl -xe`

Running the feed update script (with the same user and PHP version as your Web server) might provide other hints, e.g.: `sudo -u www-data /usr/bin/php ./FreshRSS/app/actualize_script.php`

## Help needed

see: [Report a bug](https://freshrss.github.io/FreshRSS/en/contributing.html)