// Package http contains the HTTP delivery adapters.
package http

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/user/audionara/backend/internal/usecase"
)

// envelope is the standard API response shape.
type envelope struct {
	Data  any    `json:"data"`
	Error *string `json:"error"`
}

// Handler handles track requests.
type Handler struct {
	trackUC *usecase.TrackUseCase
}

// NewHandler constructs a new Handler.
func NewHandler(trackUC *usecase.TrackUseCase) *Handler {
	return &Handler{trackUC: trackUC}
}

// RegisterRoutes mounts all handlers onto the provided mux.
func (h *Handler) RegisterRoutes(mux *http.ServeMux) {
	mux.HandleFunc("GET /api/v1/tracks/search", h.searchTracks)
}

// searchTracks handles GET /api/v1/tracks/search?term=<term>.
func (h *Handler) searchTracks(w http.ResponseWriter, r *http.Request) {
	vibe := r.URL.Query().Get("term")
	if vibe == "" {
		vibe = r.URL.Query().Get("vibe")
	}
	if vibe == "" {
		vibe = "synthwave" // Graceful fallback
	}

	tracks, err := h.trackUC.SearchByVibe(r.Context(), vibe)
	if err != nil {
		status := http.StatusInternalServerError
		if errors.Is(err, usecase.ErrEmptyVibe) {
			status = http.StatusBadRequest
		}
		writeJSON(w, status, envelope{Data: nil, Error: strPtr(err.Error())})
		return
	}

	writeJSON(w, http.StatusOK, envelope{Data: tracks, Error: nil})
}

func writeJSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(payload)
}

func strPtr(s string) *string { return &s }
