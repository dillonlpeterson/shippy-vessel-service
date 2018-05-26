build: 
	protoc -I. --go_out=plugins=micro:. proto/vessel/vessel.proto 
	# Builds into this 
	docker build -t dillonlpeterson/vessel:latest .
	docker push dillonlpeterson/vessel:latest
run:
	docker run -p 50052:50051 -e MICRO_SERVER_ADDRESS=:50051 -e MICRO_REGISTRY=mdns -e DB_HOST=localhost:27017 vessel-service