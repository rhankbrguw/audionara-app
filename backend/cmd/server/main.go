package main

import (
	"fmt"
	"net/http"
	"github.com/user/audionara/backend/pkg/env"
)

func main() {
	env.Load()
	port := env.GetWithDefault("APP_PORT", "8080")

	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "AudioNara Backend is Live")
	})

	fmt.Printf("Server starting on port %s...\n", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		panic(err)
	}
}