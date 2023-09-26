## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>SEARCH_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>SEARCH_TRACING_TYPE | string |  | The type of tracing. Defaults to '', which is the same as 'jaeger'. Allowed tracing types are 'jaeger' and '' as of now.|
| OCIS_TRACING_ENDPOINT<br/>SEARCH_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>SEARCH_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>SEARCH_LOG_LEVEL | string |  | The log level. Valid values are: 'panic', 'fatal', 'error', 'warn', 'info', 'debug', 'trace'.|
| OCIS_LOG_PRETTY<br/>SEARCH_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>SEARCH_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>SEARCH_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| SEARCH_DEBUG_ADDR | string | 127.0.0.1:9224 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| SEARCH_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| SEARCH_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| SEARCH_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| SEARCH_GRPC_ADDR | string | 127.0.0.1:9220 | The bind address of the GRPC service.|
| OCIS_JWT_SECRET<br/>SEARCH_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| OCIS_REVA_GATEWAY | string | com.owncloud.api.gateway | The CS3 gateway endpoint.|
| OCIS_GRPC_CLIENT_TLS_MODE | string |  | TLS mode for grpc connection to the go-micro based grpc services. Possible values are 'off', 'insecure' and 'on'. 'off': disables transport security for the clients. 'insecure' allows using transport security, but disables certificate verification (to be used with the autogenerated self-signed certificates). 'on' enables transport security, including server certificate verification.|
| OCIS_GRPC_CLIENT_TLS_CACERT | string |  | Path/File name for the root CA certificate (in PEM format) used to validate TLS server certificates of the go-micro based grpc services.|
| OCIS_EVENTS_ENDPOINT<br/>SEARCH_EVENTS_ENDPOINT | string | 127.0.0.1:9233 | The address of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture.|
| OCIS_EVENTS_CLUSTER<br/>SEARCH_EVENTS_CLUSTER | string | ocis-cluster | The clusterID of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture. Mandatory when using NATS as event system.|
| OCIS_ASYNC_UPLOADS<br/>SEARCH_EVENTS_ASYNC_UPLOADS | bool | false | Enable asynchronous file uploads.|
| SEARCH_EVENTS_NUM_CONSUMERS | int | 0 | The amount of concurrent event consumers to start. Event consumers are used for searching files. Multiple consumers increase parallelisation, but will also increase CPU and memory demands. The default value is 0.|
| SEARCH_EVENTS_REINDEX_DEBOUNCE_DURATION | int | 1000 | The duration in milliseconds the reindex debouncer waits before triggering a reindex of a space that was modified.|
| OCIS_INSECURE<br/>SEARCH_EVENTS_TLS_INSECURE | bool | false | Whether to verify the server TLS certificates.|
| OCIS_EVENTS_TLS_ROOT_CA_CERTIFICATE<br/>SEARCH_EVENTS_TLS_ROOT_CA_CERTIFICATE | string |  | The root CA certificate used to validate the server's TLS certificate. If provided SEARCH_EVENTS_TLS_INSECURE will be seen as false.|
| OCIS_EVENTS_ENABLE_TLS<br/>SEARCH_EVENTS_ENABLE_TLS | bool | false | Enable TLS for the connection to the events broker. The events broker is the ocis service which receives and delivers events between the services.|
| SEARCH_ENGINE_TYPE | string | bleve | Defines which search engine to use. Defaults to 'bleve'. Supported values are: 'bleve'.|
| SEARCH_ENGINE_BLEVE_DATA_PATH | string | ~/.ocis/search | The directory where the filesystem will store search data. If not defined, the root directory derives from $OCIS_BASE_DATA_PATH:/search.|
| SEARCH_EXTRACTOR_TYPE | string | basic | Defines the content extraction engine. Defaults to 'basic'. Supported values are: 'basic' and 'tika'.|
| OCIS_INSECURE<br/>SEARCH_EXTRACTOR_CS3SOURCE_INSECURE | bool | false | Ignore untrusted SSL certificates when connecting to the CS3 source.|
| SEARCH_EXTRACTOR_TIKA_TIKA_URL | string | http://127.0.0.1:9998 | URL of the tika server.|
| SEARCH_CONTENT_EXTRACTION_SIZE_LIMIT | uint64 | 20971520 | Maximum file size in bytes that is allowed for content extraction.|
| OCIS_MACHINE_AUTH_API_KEY<br/>SEARCH_MACHINE_AUTH_API_KEY | string |  | Machine auth API key used to validate internal requests necessary for the access to resources from other services.|