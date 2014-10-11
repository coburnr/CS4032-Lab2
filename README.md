CS4032-Lab2
===========

Robin Coburn - 11534207
--

Ruby Required
-

Compile.sh just echos instructions for startup

Run start.sh to startup server, takes 2 parameters; port & max users

- Default port is 8000 and max users is 10
- ./start.sh 8080 = start server on port 8080 with max 10 users
- ./start.sh 8080 20 = start server on port 8080 with max 20 users


On startup server has max users amount of threads waiting in the threadpool.

As clients connect these threads take over client interaction and will loop waiting for client messages

As per spec, if the max amount of clients are connected no other clients will be able to connect and their session will be killed instantly. If client runs KILL_SESSION command the whole server will shut down and all client interaction stops also as per spec.


