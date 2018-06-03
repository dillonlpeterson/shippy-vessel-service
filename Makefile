build: 
	protoc -I. --go_out=plugins=micro:. proto/vessel/vessel.proto 
	# Builds into this 
	#docker build -t vessel-service .
	docker build -t us.gcr.io/shippy-freight-205815/vessel:latest . 
	docker push us.gcr.io/shippy-freight-205815/vessel:latest
	#docker push dillonlpeterson/vessel:latest
	# -d means run contains in background 
run:
	docker run --net="host" \
		-p 50053 \
		-e MICRO_SERVER_ADDRESS=:50053 \
		-e MICRO_REGISTRY=mdns \
		-e DB_HOST=localhost:27017 \
		vessel-service

// shippy-vessel-service/Makefile
deploy:
	sed "s/{{ UPDATED_AT }}/$(shell date)/g" ./deployments/deployment.tmpl > ./deployments/deployment.yml
	kubectl replace -f ./deployments/deployment.yml
