package arodenymachineloadbalancer

test_input_disallowed_create {
  input := { "review": get_input("internal") }
  results := violation with input as input
  count(results) == 1
}

test_input_allowed_create {
  input := { "review": get_input("") }
  results := violation with input as input
  count(results) == 0
}

get_input(ilb) = output {
  output = {
    "operation": "CREATE",
    "name": "test-pod",
    "object": {
      "apiVersion": "machine.openshift.io/v1beta1",
      "kind": "MachineSet",
      "metadata": {
        "name": "worker",
        "namespace": "openshift-machine-api",
        "labels": {
          "machine.openshift.io/cluster-api-cluster": "testCluster",
          "machine.openshift.io/cluster-api-machine-role": "worker",
          "machine.openshift.io/cluster-api-machine-type": "worker"
        }
      },
      "spec": {
        "replicas": 1,
        "selector": {
          "matchLabels": {
            "machine.openshift.io/cluster-api-cluster": "testCluster",
            "machine.openshift.io/cluster-api-machineset": "worker"
          }
        },
        "template": {
          "metadata": {
            "labels": {
              "machine.openshift.io/cluster-api-cluster": "testCluster",
              "machine.openshift.io/cluster-api-machine-role": "worker",
              "machine.openshift.io/cluster-api-machine-type": "worker",
              "machine.openshift.io/cluster-api-machineset": "worker"
            }
          },
          "spec": {
            "providerSpec": {
              "value": {
                "osDisk": {
                  "diskSizeGB": 128,
                  "managedDisk": {
                    "storageAccountType": "Premium_LRS"
                  },
                  "osType": "Linux"
                },
                "networkResourceGroup": "networkrg",
                "internalLoadBalancer": ilb,
                "publicLoadBalancer": "testCluster",
                "userDataSecret": {
                  "name": "worker-user-data"
                },
                "vnet": "testvnet",
                "credentialsSecret": {
                  "name": "azure-cloud-credentials",
                  "namespace": "openshift-machine-api"
                },
                "zone": "3",
                "publicIP": false,
                "resourceGroup": "rg",
                "kind": "AzureMachineProviderSpec",
                "location": "eastus",
                "vmSize": "Standard_D2s_v3",
                "image": {
                  "offer": "aro4",
                  "publisher": "azureopenshift",
                  "resourceID": "",
                  "sku": "aro_410",
                  "version": "410.84.20220125"
                },
                "subnet": "workersubnet",
                "apiVersion": "machine.openshift.io/v1beta1"
              }
            }
          }
        }
      }
    },
    "userInfo": "testuser"
  }
}
