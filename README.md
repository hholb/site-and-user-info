# Obtaining User and Website Information

## Discovery
The first step in gathering information about a website or user
information is to find out what services are running on the target
server.

### nmap
[nmap](https://nmap.org) is a powerful tool for discovering a lot
about a server. It uses various techniques to discover open ports on a
server and attempts to figure out what program is listening to those
ports.

TODO nmap example

### gobuster
[gobuster](https://github.com/OJ/gobuster) is a brute-forcing tool for
discovering directories and files being served, finding subdomains,
virtual host names, and others.

TODO gobuster example

## SQL-Injection
SQL-Injection is an exploit that uses SQL to retrieve data from the
database behind a website. For example, a login page that doesn't
sanitize what the user types into the username and password fields
might pass user-supplied SQL statement that get executed by the
database. This could lead to the database leaking information, or the
attacker logging in another user.

### Activity
Checkout
[this](https://www.hacksplaining.com/lessons/sql-injection/start)
excellent interactive example, credit to [Hackplaining](https://www.hacksplaining.com/)!

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
Checkout
[this](https://www.hacksplaining.com/lessons/xss-stored/start)
interactive example, credit to
[Hacksplaining](https://www.hacksplaining.com/)!

## Controls
### Discovery
### SQL Injection
### Cross-Site Scripting
