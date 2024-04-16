# Obtaining User and Website Information

## Setup
Follow these steps to setup a docker environment where you can run the commands
in a safe environment.

## Docker
Run `docker --version` to make sure you have docker installed and running.

![image](https://github.com/hholb/site-and-user-info/assets/111379706/394cf307-0842-4724-9664-7824c81efb17)

If you do not see the docker version printed follow the instrucions on the [docker website](https://docs.docker.com/get-docker/).

### Docker Compose
If you are running an older version of docker, you will also need to install docker-compose.
New versions of docker have docker-compose available out of the box.

## Clone the repo
Clone this repo and enter the directory:
```shell
git clone https://github.com/hholb/site-and-user-info.git
cd site-and-user-info
```

![image](https://github.com/hholb/site-and-user-info/assets/111379706/655d451e-8d2b-4164-9fd0-5b9ac3c4ae25)

## Run the containers
Run the containers:
```shell
docker compose up
```

This may take some time the first time you run it as docker needs to build the container image.
You will see a bunch of output as docker builds the image and creates the containers. When
it has finished you should see some output that looks like this:

![image](https://github.com/hholb/site-and-user-info/assets/111379706/2989deab-2c4d-4aa9-b6b7-49e57b47e19d)

Docker has created 2 containers, `site-and-user-info-server-1` and `site-and-user-info-client-1`.
The terminal running `docker compose up` will keep spitting out logs from both containers as long as
it it running.
These containers are both running the same code, so it does not matter which one you connect to in
the next step.

## Connect to the client
In a separate terminal, connect to the client container. This is where
we will run the commands from.
```shell
docker exec -it site-and-user-info-client-1 bash
```

![image](https://github.com/hholb/site-and-user-info/assets/111379706/28748f9e-dc97-48f7-9839-4540d323867e)

You can see the prompt change to `root@<some-container-id>:/app#` telling us we are now running a shell
inside the container.

Test the connection to the server container:
```shell
curl server
```

![image](https://github.com/hholb/site-and-user-info/assets/111379706/f1035ed7-fb90-41cb-acff-bcd8f22ab483)

We get a "Not found" response from the server.

On terminal running `docker compose up` we should see a new line of output from the server:
![image](https://github.com/hholb/site-and-user-info/assets/111379706/01093f9a-40f4-4711-85f7-510839dfa429)

This shows us that the server got the request from the client and returned a `404 Not Found` response, which
matches what we see on the client.

Now we have everything setup, let's see what we can find out about the server.

## Discovery
To gather information about a website or its users, it is helpful
to know what ports are open and what services are running on the target
server. After finding open ports, it it helpful to gather
information on the structure of the website.

### nmap
[nmap](https://nmap.org) is a powerful tool for discovering information
about a server. It uses various techniques to discover open ports on a
server and attempts to figure out what program is listening on those
ports.

Use nmap to scan for open ports on the server. Docker automatically maps the hostname 'server' to the other container.
```shell
nmap -p- -sV server
```

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
gobuster -w common.txt -u server
```
We can see that the server is serving a website using php with a `/admin` route.
This is a good starting point for further exploration. Hopefully we can use the
admin route to get more information or use SQL-injection to get some more data.

### Cleanup
Type `exit` in the client container to exit.
In the terminal running the docker compose command, hit CTRL-C to exit and stop the containers.
Run `docker compose down` to clean up the containers and network.

From the `site-and-user-info` directory:
```shell
cd ../
rm -r site-and-user-info
```

## SQL-Injection
SQL-Injection is an exploit that uses SQL to retrieve data from the
database behind a website. For example, a login page that doesn't
sanitize what the user types into the username and password fields
might pass user-supplied SQL statement that get executed by the
database. This could lead to the database leaking information, or the
attacker logging in another user.

### Example
Checkout this excellent
[interactive example](https://www.hacksplaining.com/lessons/sql-injection/start),
credit to [Hackplaining](https://www.hacksplaining.com/)!

## Cross-Site Scripting
Cross-Site Scripting exploits a vulnerability that causes a browser to
execute arbitrary and user supplied JavaScript. If a website allows
users to post comments, for example, the website is taking some user
supplied text and rendering it in the browser.
If the website does not sanitize the user input, a maliciousagent could
post a comment that would contain JavaScript that couldthen be 
executed by any browser that loads the page.

``` html
<script>
console.log("I am a NOT malicious program!");
do_something_evil();
</script>
```

### Example
Checkout this
[interactive example](https://www.hacksplaining.com/lessons/xss-stored/start),
credit to [Hacksplaining](https://www.hacksplaining.com/)!

## Controls
### Discovery
### SQL Injection
### Cross-Site Scripting
