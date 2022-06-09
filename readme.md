To deploy flaski edit the docker-compose.yml accordingly and then:
```
docker-compose up -d --build
```

If running myapp on development mode you will have to start flask from inside the server container:
```
docker-compose exec server flask run --host 0.0.0.0 --port 8000
```