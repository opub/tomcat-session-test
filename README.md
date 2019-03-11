# Tomcat Session Replication Testing

This provides a basic Docker framework for testing Tomcat session replication using HAProxy as the load balancer and a PostgreSQL backend. The goal of this project was to test Tomcat's JDBCStore implementation for session persistence/replication. The more common multicast and static member implementations don't work well in AWS if you also want to make use of Auto Scaling Groups. 

## Getting Started

The only requirements are to pull this project and to have a working Docker installation that includes Docker Compose.

## Starting System 

All of the Docker containers are configured through the docker-compose.yml. Bringing this up will build and launch all of the containers with the necessary networking.

```
docker-compose up
```

## Testing

* The load balanced Tomcat session details will be visible in a test JSP page that is accessible at [http://localhost](http://localhost).
* A specific Tomcat instance can be loaded by going to port 8081, 8082 or 8083 like [http://localhost:8081](http://localhost:8081).
* The HAProxy stats can be seen on port 1936 like [http://localhost:1936](http://localhost:1936).


## Authors

* **Ted O'Connor** - [opub](https://github.com/opub)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
