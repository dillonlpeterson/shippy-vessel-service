build: 
	protoc -I. --go_out=plugins=micro:. proto/vessel/vessel.proto 
	# Builds into this 
	docker build -t dillonlpeterson/vessel:latest .
	docker push dillonlpeterson/vessel:latest
run:
	docker run -d --net="host" \
	-p 50053 \
	-e MICRO_SERVER_ADDRESS:=50053 \ 
	-e DB_HOST=localhost:27017
	-e MICRO_REGISTRY=mdns \
	vessel-service
