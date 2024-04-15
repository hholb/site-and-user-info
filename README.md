# Obtaining User and Website Information

## Discovery
In order to gather information about a website or its users, it is helpful
to know what ports are open and what services are running on the target
server. After finding open ports and a webserver, it it helpful to gather
information on the structure of the website.

### nmap
[nmap](https://nmap.org) is a powerful tool for discovering a lot
about a server. It uses various techniques to discover open ports on a
server and attempts to figure out what program is listening on those
ports.

Use nmap to scan for open ports on a Raspberry PI on my network.
```shell
nmap -p- -sV 192.168.0.6
```
![image](https://github.com/hholb/site-and-user-info/assets/111379706/3a4c6ddd-0c88-4538-bebf-6a4032cd277b)

We can see that ports 22, 53, and 80 are listening and the services using them. From here,
we can continute to probe the server for more information.

This was just the tip of the iceberg for what nmap is capable of. Check the 
[nmap website](https://nmap.org) or `man` pages for more info.

### gobuster
[gobuster](https://github.com/OJ/gobuster) is a brute-forcing tool for
discovering directories and files being served, finding subdomains,
virtual host names, and others. It is useful for learing about the
structure of a website.

Using the same server from the nmap example, we can run `gobuster`
against the webserver running on port 80. For a collection of word lists
to use for `gobuster` or other programs, check out [SecLists](https://github.com/danielmiessler/SecLists).
```shell
gobuster -w common.txt -u 192.168.0.6
```
![image](https://github.com/hholb/site-and-user-info/assets/111379706/8cc96969-aae8-4dce-9766-65d9ce889d6c)

We can see that the server is serving a website using php with a `/admin` route.
This is a good starting point for further exploration. Hopefully we can use the
admin route to get more information or use SQL-injection to get some more data.

## SQL-Injection
SQL-Injection is an exploit that uses SQL to retrieve data from the
database behind a website. For example, a login page that doesn't
sanitize what the user types into the username and password fields
might pass user-supplied SQL statement that get executed by the
database. This could lead to the database leaking information, or the
attacker logging in another user.

### Activity
Checkout this excellent
[interactive example](https://www.hacksplaining.com/lessons/sql-injection/start),
credit to [Hackplaining](https://www.hacksplaining.com/)!

## Cross-Site Scripting
Cross-Site Scripting exploits a vulnerability that causes a browser to
execute arbitrary and user supplied JavaScript. If a website allows
users to post comments, for example, the website is taking some user
supplied text and somehow rendering it in the browser for other users
to see. If the website does not sanitize the user input, a malicious
agent could post a comment that would contain JavaScript that could
then be executed by any browser that loads the page.

``` html
<script>
console.log("I am a NOT malicious program!");
do_something_evil();
</script>
```

### hacksplaining
Checkout this
[interactive example](https://www.hacksplaining.com/lessons/xss-stored/start),
credit to [Hacksplaining](https://www.hacksplaining.com/)!

## Controls
### Discovery
### SQL Injection
### Cross-Site Scripting
