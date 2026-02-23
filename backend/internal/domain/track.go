package domain

import (
	"context"
	"errors"
)

// ErrNotSupported signals that an operation is valid in the domain
// but has no concrete implementation for this repository backend.
var ErrNotSupported = errors.New("operation not supported by this repository")

// Track is the canonical audio entity. All upstream SDKs
// map into this struct.
type Track struct {
	ID        string `json:"id"`
	Title     string `json:"title"`
	Artist    string `json:"artist"`
	StreamURL string `json:"stream_url"`
	CoverArt  string `json:"cover_art"`
}

// TrackRepository defines the interface for track operations.
type TrackRepository interface {
	SearchByVibe(ctx context.Context, vibe string) ([]*Track, error)
	FindByID(ctx context.Context, id string) (*Track, error)
	FindAll(ctx context.Context) ([]*Track, error)
	Save(ctx context.Context, track *Track) error
	Delete(ctx context.Context, id string) error
}
