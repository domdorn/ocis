package config

// App defines the available app configuration.
type App struct {
	Name        string `yaml:"name" env:"COLLABORATION_APP_NAME" desc:"The name of the app" introductionVersion:"%%NEXT%%"`
	Description string `yaml:"description" env:"COLLABORATION_APP_DESCRIPTION" desc:"App description" introductionVersion:"%%NEXT%%"`
	Icon        string `yaml:"icon" env:"COLLABORATION_APP_ICON" desc:"Icon for the app" introductionVersion:"%%NEXT%%"`
	LockName    string `yaml:"lockname" env:"COLLABORATION_APP_LOCKNAME" desc:"Name for the app lock" introductionVersion:"%%NEXT%%"`

	Addr     string `yaml:"addr" env:"COLLABORATION_APP_ADDR" desc:"The URL where the WOPI app is located, such as https://127.0.0.1:8080." introductionVersion:"%%NEXT%%"`
	Insecure bool   `yaml:"insecure" env:"COLLABORATION_APP_INSECURE" desc:"Skip TLS certificate verification when connecting to the WOPI app" introductionVersion:"%%NEXT%%"`

	ProofKeys ProofKeys `yaml:"proofkeys"`
}

type ProofKeys struct {
	Disable  bool   `yaml:"disable" env:"COLLABORATION_APP_PROOF_DISABLE" desc:"Disable the proof keys verification" introductionVersion:"%%NEXT%%"`
	Duration string `yaml:"duration" env:"COLLABORATION_APP_PROOF_DURATION" desc:"Duration for the proof keys to be cached in memory, using time.ParseDuration format. If the duration can't be parsed, we'll use the default 12h as duration" introductionVersion:"%%NEXT%%"`
}
