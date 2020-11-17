# wmss-boilerplate
PHP project folder structure for the course Web &amp; Mobile Server-side, part of the Professional Bachelor ICT study program.

## Installation instructions

* Fork this project by pressing the 'Fork' button at the top-right of this page
* Rename the forked repo by pressing Settings > General
* Clone the forked repo on your system e.g.
```shell
git clone https://git.ikdoeict.be/john.doe/my-webshop.git
```
* Open the main folder with an IDE
* Run the environment, using Docker, from your terminal/cmd
```shell
cd my-webshop
docker-compose up
```
* Browse to [http://localhost:8080](http://localhost:8080)
* Stop the environment in your terminal/cmd by pressing <code>Ctrl+C</code>
* In order to avoid conflicts with your lab/slides environment, run from your terminal/cmd
```shell
docker-compose down
```

## Recipes and troubleshooting

### <code>docker-compose up</code> does not start one or more containers
* Look at the output of <code>docker-compose up</code>. When a container (fails and) exits, it is shown as the last line of the container output (colored tags by container)
* Alternatively, start another terminal/cmd and inspect the output of <code>docker-compose ps -a</code>. You can see which container exited, exactly when.
* Probably one of the containers fails because TCP/IP port 8000, 8080 or 3307 is already in use on your system. Stop the environment, change the port in <code>docker-compose.yml</code> en rerun <code>docker-compose up</code>.


