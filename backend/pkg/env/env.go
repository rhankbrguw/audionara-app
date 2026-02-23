// Package env loads runtime configuration from environment variables,
// falling back to a .env file for local development.
// Production deployments should inject variables directly — never ship a .env.
package env

import (
	"fmt"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

// Load reads .env into the process environment.
// Silent in production: if the file is absent the call is a no-op.
func Load() {
	_ = godotenv.Load()
}

// MustGet returns the value of key or panics.
// Panic is intentional: a missing required variable is a deployment error,
// not a recoverable runtime condition.
func MustGet(key string) string {
	v := os.Getenv(key)
	if v == "" {
		panic(fmt.Sprintf("env: required variable %q is not set", key))
	}
	return v
}

// GetWithDefault returns the value of key, or fallback if unset.
func GetWithDefault(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

// GetInt returns key as an integer, or fallback on parse failure.
func GetInt(key string, fallback int) int {
	v := os.Getenv(key)
	if v == "" {
		return fallback
	}
	n, err := strconv.Atoi(v)
	if err != nil {
		return fallback
	}
	return n
}
