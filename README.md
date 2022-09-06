# Flask in-memory key-value store HTTP API Service

This project is about hosting a Dockerized Flask app on Ec2 using Terraform.
The Flask app stores key-value in memory with fetching and searching and setting them.

**Note:** If ssh is required then add the device ip address inside terraform/input.tfvars file

## Steps to deploy this project

```bash
cd terraform
terraform init
terraform validate
terraform plan -var-file=input.tfvars
terraform apply
```
**Note:** Terraform will output Public Ip address of Ec2 machine where dockerized flask app is hosted.
This ip address can be used for hitting below endpoints.


## Build Docker Image

```bash
docker build -t key-server-flask:<tag> .
```

## Run Test Cases

Project uses `unittest` python library to write our test cases. The test cases are inside folder [test](./flask_app/test).

There are two folders to separate [unit test](./flask_app/test/unit_tests) and [integration tests](./flask_app/test/integration_tests) .

If you wish to run the test case you can refer the following command.

```bash
docker run -t key-server-flask:<Image Tag> pytest <options>
```

### Examples

Following are some ways to run test cases

#### Run only unit tests

```bash
docker run -t key-server-flask:v2 pytest -m unittest --cache-clear --verbose --disable-warnings
```

#### Run only integration tests

```bash
docker run -t key-server-flask:latest pytest -m integrationtest --cache-clear --verbose --disable-warnings
```


## Endpoints

### Get Specific Key

Make a GET request with a key ID to get it's value

#### Endpoint

> GET /get/\<KEY ID>

#### Parameters

`KEY ID`: Pass the name of the key to URL endpoint.

#### Request

```bash
curl --location --request GET '<IP:5000>/get/<KEY ID>'
```

#### Response

```json
{
  "body": {
      "value": "secretvalue"
  },
  "status_code": 200,
  "success": true
}
```


### Get All Keys


Make a GET request to get all keys

#### Endpoint

> GET /get

#### Parameters

No params required.

#### Request

```bash
curl --location --request GET '<IP:5000>/get'
```

#### Response

```json
{
  "body": {
      "keys": {
          "key1": "idk",
          "key2": "passwd"
      }
  },
  "status_code": 200,
  "success": true
}
```


### Set Key


Make a POST request with desired data to store your key on server.

You can use this method to change the value of existing keys.

#### Endpoint

> POST /set

#### Parameters

`key_name`[REQUIRED]: Name/ID of the key.

`key_value`[REQUIRED]: Value of the key.

#### Request

```bash
curl --location --request POST 'http://<IP:5000>/set' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "key_name": "<key_name>",
    "key_value": "<key_value>"
  }'
```

#### Response

```json
{
  "body": "Key created with ID qwe",
  "status_code": 201,
  "success": true
}  
```

### Search Keys


Make a GET request to fetch key IDs based on prefix and/or suffix search.

#### Endpoint

> GET /search?prefix=\<term>

> GET /search?suffix=\<term>
 
> GET /search?prefix=\<term1>&suffix=\<term2>

#### Parameters

> Atleast one parameter is required.

`prefix`: search based on prefix of the key name.

`suffix`: search based on suffix of the key name.

#### Request

```bash
curl --location --request GET 'http://<IP:5000>/search?prefix=<prefixterm>'
```


#### Response

```json
{
  "body": {
    "keys": ["key1", "key2"]
  },
  "status_code": 200,
  "success": true
}
```

