#!/bin/bash

_assign_super_user_role_bindings() {
  curl -s -X GET $1/lookup/rolebindings/principal/User:my_super_user -H "Authorization: Bearer $2" -H "Content-Type: application/json" -H "Accept: application/json" | jq .
}

_assign_client_role_bindings() {
  curl -X POST $1/principals/User:kafka_client/roles/ResourceOwner/bindings -H "Authorization: Bearer $2" -i -H "Content-Type: application/json" -H "Accept: application/json" \
    -d '{
          "scope":{"clusters":{"kafka-cluster":"MkU3OEVBNTcwNTJENDM2Qk"}},
          "resourcePatterns":[
            {"resourceType":"Group", "name":"demo", "patternType":"LITERAL"},
            {"resourceType":"Topic", "name":"_schemas", "patternType":"LITERAL"},
            {"resourceType":"Cluster", "name":"kafka-cluster", "patternType":"LITERAL"}
          ]
        }'
  curl -X PUT $1/principals/User:kafka_client/roles/ClusterAdmin -H "Authorization: Bearer $2" -i -H "Content-Type: application/json" -H "Accept: application/json" -d '{"clusters":{"kafka-cluster":"MkU3OEVBNTcwNTJENDM2Qk"}}'

  curl -s -X GET $1/lookup/rolebindings/principal/User:kafka_client -H "Authorization: Bearer $2" -H "Content-Type: application/json" -H "Accept: application/json" | jq .
}

# Assign application role bindings
assign_role_bindings()
{
auth_token=$(curl -s \
  -d "client_id=my_super_user" \
  -d "client_secret=my_super_user_secret" \
  -d "grant_type=client_credentials" \
  http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/token | jq -r .access_token)
echo $auth_token

MDS_RBAC_ENDPOINT=http://broker1:8091/security/1.0

#_assign_super_user_role_bindings $MDS_RBAC_ENDPOINT $auth_token
_assign_client_role_bindings $MDS_RBAC_ENDPOINT $auth_token
}

create_topic(){
  kafka-topics --bootstrap-server broker1:9092 --topic $1 --create --command-config client.properties
}

# Run it
assign_role_bindings

create_topic _schemas