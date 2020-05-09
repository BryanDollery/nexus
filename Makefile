build:
	docker build --tag bryandollery/nexus .

run:
	docker run -it --rm -v nexus-data:/nexus-data -p 8081:8081 bryandollery/nexus
	
debug:
	docker run -it --rm --entrypoint bash bryandollery/nexus
