# Simple Application Deployment

Provides an easy chart to create simple application deployments. Especially good local testing simplified single replica deployments.

* Ony `Deployment` supported. Does not support `StatefulSets` or `DaemonSets`.
* Inject files mounted from `ConfigMaps`.
* Ingress declaration.
* Service declaration.