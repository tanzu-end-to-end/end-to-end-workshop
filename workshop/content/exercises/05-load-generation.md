Set environment variables for use in the following sections
export PETCLINIC_HOST=$(yq r $PARAMS_YAML petclinic.host)
Run locust via docker
docker run -p 8089:8089 -v $PWD:/mnt/locust locustio/locust -f /mnt/locust/traffic-generator/locustfile.py -H https://$PETCLINIC_HOST
Access Locus UI
open http://localhost:8089
Click on 'New Test' and provide the number of users to simulate. I used 10 users with hatch rate 4
Locust Test Setup Locust Running

Check out your nice data flowing through on your custom TO dashboard