README
======

Bash script to update the ip of an account on no-ip.com

How to use
----------

* Configure the script with the correct username, password, hostname, cache file (current IP), and log file
* Make it executable (`chmod +x`)
* Run it (`./noipupdater.sh`)

Tips!
-----
It may be useful to have DNS dig command installed. On Debian/Ubuntu based systems, install package with: `sudo apt install dnsutils`

Place this in your cron file:

    */15 * * * * /dir/where/file/is/noipupdater.sh

This will run the script every fifteen minutes.

Note: Some users have had problem executing the cron. If that is your case, remove the `.sh` extension.

Happy updating!
