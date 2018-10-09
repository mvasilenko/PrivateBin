This directory contains very basic kubernetes helm chart for PrivateBin app


#### Prerequisites:
- `kubernetes` cluster
- `helm` - kubernetes package manager
- ingress controller installed at kubernetes cluster
(nginx is used in this demo)
- `kube-lego` - LetsEncrypt certificate manager for kubernetes



#### Install
How to install PrivateBin to your kubernetes cluster:

Build docker image - run this command at PrivateBin source root

```
$ docker build -t dockeruser/privatebin .
```

Push docker image to your docker registry:

```
$ docker push dockeruser/privatebin
```


Choose domain name for your PrivateBin install - `privatebin.domain.com`

Provision DNS A-record for domain name, poiniting to kubernetes ingress

Edit `values.yaml` - change domain names, `StorageClass` if needed

Install helm chart, in `privatebin` namespace, for example

```
$ helm upgrade --debug --install --debug privatebin --namespace privatebin -f values.yaml .`
```

Check install results

```
$ helm list

NAME          	REVISION	UPDATED                 	STATUS  	CHART           	NAMESPACE
bunking-shrimp	1       	Sat Oct  6 23:23:36 2018	DEPLOYED	kube-lego-0.4.2 	default
privatebin    	5       	Tue Oct  9 18:02:21 2018	DEPLOYED	privatebin-0.1.0	privatebin
```

Verify pod/volume status

```
$ kubectl -n privatebin get pods,pv,pvc

NAME                              READY     STATUS    RESTARTS   AGE
pod/privatebin-86c54776bd-hhknx   1/1       Running   0          1h

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                       STORAGECLASS   REASON    AGE
persistentvolume/pvc-de4c4703-cbd3-11e8-b240-02bae27f9ce6   1Gi        RWO            Delete           Bound     privatebin/privatebin       gp2                      1h

NAME                               STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/privatebin   Bound     pvc-de4c4703-cbd3-11e8-b240-02bae27f9ce6   1Gi        RWO            gp2            1h
```

Try to access <http://privatebin.example.com> in your browser

Done!


# Troubleshooting

verify certificate status provisioning at kube-lego pod logs



