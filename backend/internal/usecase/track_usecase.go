// Package usecase contains application business logic.
package usecase

import (
	"context"
	"errors"

	"github.com/user/audionara/backend/internal/domain"
)

// ErrEmptyVibe is returned when a caller passes a blank search term.
var ErrEmptyVibe = errors.New("vibe must not be empty")

// TrackUseCase orchestrates track search logic.
type TrackUseCase struct {
	repo domain.TrackRepository
}

// NewTrackUseCase constructs a TrackUseCase.
func NewTrackUseCase(repo domain.TrackRepository) *TrackUseCase {
	return &TrackUseCase{repo: repo}
}

// SearchByVibe validates the input and delegates to the repository.
func (uc *TrackUseCase) SearchByVibe(ctx context.Context, vibe string) ([]*domain.Track, error) {
	if vibe == "" {
		return nil, ErrEmptyVibe
	}
	return uc.repo.SearchByVibe(ctx, vibe)
}
