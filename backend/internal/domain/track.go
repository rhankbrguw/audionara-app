package domain

import "context"

// Track represents the core audio track entity in the AudioNara domain.
// It is a pure data structure with no dependencies on infrastructure.
type Track struct {
	ID        string `json:"id"`
	Title     string `json:"title"`
	Artist    string `json:"artist"`
	StreamURL string `json:"stream_url"`
	CoverArt  string `json:"cover_art"`
}

// TrackRepository defines the contract for Track data persistence.
// Concrete implementations live in internal/repository.
type TrackRepository interface {
	FindByID(ctx context.Context, id string) (*Track, error)
	FindAll(ctx context.Context) ([]*Track, error)
	Save(ctx context.Context, track *Track) error
	Delete(ctx context.Context, id string) error
}
