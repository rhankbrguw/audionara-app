package main

import (
	"fmt"
	"log"
	"net/http"

	delivery "github.com/user/audionara/backend/internal/delivery/http"
	"github.com/user/audionara/backend/internal/repository"
	"github.com/user/audionara/backend/internal/usecase"
	"github.com/user/audionara/backend/pkg/env"
)

func main() {
	env.Load()

	iTunesRepo := repository.NewITunesRepository()
	trackUC := usecase.NewTrackUseCase(iTunesRepo)
	handler := delivery.NewHandler(trackUC)

	mux := http.NewServeMux()
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, `{"status":"ok"}`)
	})
	handler.RegisterRoutes(mux)

	port := env.GetWithDefault("APP_PORT", "8080")
	log.Printf("server listening on :%s", port)
	if err := http.ListenAndServe(":"+port, mux); err != nil {
		log.Fatalf("server: %v", err)
	}
}