# Example Node App for ICR

```
docker build . -t <image>:<tag>
docker tag <image>:<tag> <region>.icr.io/<namespace>/<image>:<tag>
```

```
ibmcloud login
ibmcloud cr login
ibmcloud cr namespace-add <my_namespace>
ibmcloud cr target us-south
docker push <region>.icr.io/<namespace>/<image>:<tag>
```