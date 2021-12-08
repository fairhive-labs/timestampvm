# Timestamp Virtual Machine 
[![Lint+Test+Build+Docker](https://github.com/fairhive-labs/timestampvm/actions/workflows/lint_test_build_docker.yml/badge.svg)](https://github.com/fairhive-labs/timestampvm/actions/workflows/lint_test_build_docker.yml)

Avalanche is a network composed of multiple blockchains. Each blockchain is an instance of a [Virtual Machine (VM)](https://docs.avax.network/learn/platform-overview#virtual-machines), much like an object in an object-oriented language is an instance of a class. That is, the VM defines the behavior of the blockchain.

TimestampVM defines a blockchain that is a timestamp server. Each block in the blockchain contains the timestamp when it was created along with a 32-byte piece of data (payload). Each block’s timestamp is after its parent’s timestamp. This VM demonstrates capabilities of custom VMs and custom blockchains. For more information, see: [Create a Virtual Machine](https://docs.avax.network/build/tutorials/platform/create-a-virtual-machine-vm)

TimestampVM is served over RPC with [go-plugin](https://github.com/hashicorp/go-plugin).

## 🚀 Start the custom VM (on fuji network)

```
docker run --privileged -ti -d -p 9650:9650 -p 9651:9651 -v ~/.avalanchego:/root/.avalanchego fairhivelabs/timestampvm /avalanchego/build/avalanchego --http-host 0.0.0.0 --network-id fuji --dynamic-public-ip ifconfig
```

## 🙈 Encode static service 

```
curl -s -X POST --data '{
    "jsonrpc": "2.0",
    "method": "timestampvm.encode",
    "params":{
        "data":"acme custom vm",
	"length": 32
    },
    "id": 1
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/vm/n6B2UdbyGWn8modJUZQ1RivVUbVdn5hwcFKnE9bf1KLZGPjNX | jq
```

you should get :

```
{
  "jsonrpc": "2.0",
  "result": {
    "bytes": "jtf2eXz63ezRvMHcZXke7BsDftSEHWRQ9AYvQdUuMw6VekRgj",
    "encoding": "cb58"
  },
  "id": 1
}
```

## 🐵 Decode static service
```
curl -s -X POST --data '{
    "jsonrpc": "2.0",
    "method": "timestampvm.decode",
    "params":{
        "bytes": "tGas3T58KzdjLHhBDMnH2TvrddhqTji5iZAMZ3RXs2NLpSnhH"
    },
    "id": 1
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/vm/n6B2UdbyGWn8modJUZQ1RivVUbVdn5hwcFKnE9bf1KLZGPjNX | jq
```

and you should get :

```
{
  "jsonrpc": "2.0",
  "result": {
    "data": "timestamp\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000",
    "encoding": "cb58"
  },
  "id": 1
}
```

For further details 👉 [Medium article](https://medium.com/fairhive/docker-avalanches-custom-virtual-machine-5f650005c7d7)
