# Johns Hopkins Test Solr Container

This project demonstates a functionig Solr docker container running in AWS ECS. 

Notes: 
  an ECS enabled AMI must be used
 
Todo:
  health checks were failing from Solr, a separate Flask service is running for keep-alive. Not ideal, needs to be revisited.

Terraform included in the infrastructure folder
