## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>SETTINGS_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>SETTINGS_TRACING_TYPE | string |  | The type of tracing. Defaults to '', which is the same as 'jaeger'. Allowed tracing types are 'jaeger' and '' as of now.|
| OCIS_TRACING_ENDPOINT<br/>SETTINGS_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>SETTINGS_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>SETTINGS_LOG_LEVEL | string |  | The log level. Valid values are: 'panic', 'fatal', 'error', 'warn', 'info', 'debug', 'trace'.|
| OCIS_LOG_PRETTY<br/>SETTINGS_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>SETTINGS_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>SETTINGS_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| SETTINGS_DEBUG_ADDR | string | 127.0.0.1:9194 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| SETTINGS_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| SETTINGS_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| SETTINGS_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| SETTINGS_HTTP_ADDR | string | 127.0.0.1:9190 | The bind address of the HTTP service.|
| OCIS_HTTP_TLS_ENABLED | bool | false | Activates TLS for the http based services using the server certifcate and key configured via OCIS_HTTP_TLS_CERTIFICATE and OCIS_HTTP_TLS_KEY. If OCIS_HTTP_TLS_CERTIFICATE is not set a temporary server certificate is generated - to be used with PROXY_INSECURE_BACKEND=true.|
| OCIS_HTTP_TLS_CERTIFICATE | string |  | Path/File name of the TLS server certificate (in PEM format) for the http services.|
| OCIS_HTTP_TLS_KEY | string |  | Path/File name for the TLS certificate key (in PEM format) for the server certificate to use for the http services.|
| SETTINGS_HTTP_ROOT | string | / | Subdirectory that serves as the root for this HTTP service.|
| OCIS_CORS_ALLOW_ORIGINS<br/>SETTINGS_CORS_ALLOW_ORIGINS | []string | [*] | A comma-separated list of allowed CORS origins. See following chapter for more details: *Access-Control-Allow-Origin* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin|
| OCIS_CORS_ALLOW_METHODS<br/>SETTINGS_CORS_ALLOW_METHODS | []string | [GET POST PUT PATCH DELETE OPTIONS] | A comma-separated list of allowed CORS methods. See following chapter for more details: *Access-Control-Request-Method* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Method|
| OCIS_CORS_ALLOW_HEADERS<br/>SETTINGS_CORS_ALLOW_HEADERS | []string | [Authorization Origin Content-Type Accept X-Requested-With X-Request-Id] | A blank or comma-separated list of allowed CORS headers. See following chapter for more details: *Access-Control-Request-Headers* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Headers.|
| OCIS_CORS_ALLOW_CREDENTIALS<br/>SETTINGS_CORS_ALLOW_CREDENTIALS | bool | true | Allow credentials for CORS.See following chapter for more details: *Access-Control-Allow-Credentials* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Credentials.|
| SETTINGS_GRPC_ADDR | string | 127.0.0.1:9191 | The bind address of the GRPC service.|
| SETTINGS_STORE_TYPE | string | metadata | Store type configures the persistency driver. Supported values are 'metadata' and 'filesystem'. Note that the value 'filesystem' is considered deprecated.|
| SETTINGS_DATA_PATH | string | ~/.ocis/settings | The directory where the filesystem storage will store ocis settings. If not defined, the root directory derives from $OCIS_BASE_DATA_PATH:/settings.|
| STORAGE_GATEWAY_GRPC_ADDR | string | com.owncloud.api.storage-system | GRPC address of the STORAGE-SYSTEM service.|
| STORAGE_GRPC_ADDR | string | com.owncloud.api.storage-system | GRPC address of the STORAGE-SYSTEM service.|
| OCIS_SYSTEM_USER_ID<br/>SETTINGS_SYSTEM_USER_ID | string |  | ID of the oCIS STORAGE-SYSTEM system user. Admins need to set the ID for the STORAGE-SYSTEM system user in this config option which is then used to reference the user. Any reasonable long string is possible, preferably this would be an UUIDv4 format.|
| OCIS_SYSTEM_USER_IDP<br/>SETTINGS_SYSTEM_USER_IDP | string | internal | IDP of the oCIS STORAGE-SYSTEM system user.|
| OCIS_SYSTEM_USER_API_KEY | string |  | API key for the STORAGE-SYSTEM system user.|
| OCIS_CACHE_STORE<br/>SETTINGS_CACHE_STORE | string | memory | The type of the cache store. Supported values are: 'memory', 'ocmem', 'etcd', 'redis', 'redis-sentinel', 'nats-js', 'noop'. See the text description for details.|
| OCIS_CACHE_STORE_NODES<br/>SETTINGS_CACHE_STORE_NODES | []string | [] | A comma separated list of nodes to access the configured store. This has no effect when 'memory' or 'ocmem' stores are configured. Note that the behaviour how nodes are used is dependent on the library of the configured store.|
| OCIS_CACHE_DATABASE | string | ocis | The database name the configured store should use.|
| SETTINGS_FILE_CACHE_TABLE | string | settings_files | The database table the store should use for the file cache.|
| SETTINGS_DIRECTORY_CACHE_TABLE | string | settings_dirs | The database table the store should use for the directory cache.|
| OCIS_CACHE_TTL<br/>SETTINGS_CACHE_TTL | Duration | 10m0s | Default time to live for entries in the cache. Only applied when access tokens has no expiration. The duration can be set as number followed by a unit identifier like s, m or h. Defaults to '10m' (10 minutes).|
| OCIS_CACHE_SIZE<br/>SETTINGS_CACHE_SIZE | int | 0 | The maximum quantity of items in the cache. Only applies when store type 'ocmem' is configured. Defaults to 512.|
| SETTINGS_BUNDLES_PATH | string |  | The path to a JSON file with a list of bundles. If not defined, the default bundles will be loaded.|
| OCIS_ADMIN_USER_ID<br/>SETTINGS_ADMIN_USER_ID | string |  | ID of the user that should receive admin privileges. Consider that the UUID can be encoded in some LDAP deployment configurations like in .ldif files. These need to be decoded beforehand.|
| OCIS_JWT_SECRET<br/>SETTINGS_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| SETTINGS_SETUP_DEFAULT_ASSIGNMENTS<br/>IDM_CREATE_DEMO_USERS | bool | false | The default role assignments the demo users should be setup.|
| OCIS_SERVICE_ACCOUNT_ID<br/>SETTINGS_SERVICE_ACCOUNT_ID_ADMIN | string | service-user-id | The ID of the service account having the admin role. See the 'auth-service' service description for more details.|
| SETTINGS_DEFAULT_LANGUAGE | string |  | The default language. If not defined, English will be used as default. See the documentation for more details.|