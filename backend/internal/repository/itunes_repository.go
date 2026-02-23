package repository

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strconv"
	"time"

	"github.com/user/audionara/backend/internal/domain"
)

const (
	itunesSearchURL = "https://itunes.apple.com/search"
	itunesLimit     = 20
	itunesTimeout   = 10 * time.Second
)

type itunesSearchResponse struct {
	ResultCount int            `json:"resultCount"`
	Results     []itunesResult `json:"results"`
}

type itunesResult struct {
	TrackID     uint64 `json:"trackId"`
	TrackName   string `json:"trackName"`
	ArtistName  string `json:"artistName"`
	PreviewURL  string `json:"previewUrl"`
	ArtworkURL  string `json:"artworkUrl100"`
}

// ITunesRepository provides access to track data via the Apple iTunes Search API.
type ITunesRepository struct {
	httpClient *http.Client
}

// NewITunesRepository creates a new ITunesRepository.
func NewITunesRepository() *ITunesRepository {
	return &ITunesRepository{
		httpClient: &http.Client{Timeout: itunesTimeout},
	}
}

// SearchByVibe queries the iTunes API for tracks matching the given vibe.
func (r *ITunesRepository) SearchByVibe(ctx context.Context, vibe string) ([]*domain.Track, error) {
	reqURL, err := url.Parse(itunesSearchURL)
	if err != nil {
		return nil, fmt.Errorf("itunes: parse base URL: %w", err)
	}

	q := reqURL.Query()
	q.Set("term", vibe)
	q.Set("entity", "song")
	q.Set("limit", strconv.Itoa(itunesLimit))
	reqURL.RawQuery = q.Encode()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, reqURL.String(), nil)
	if err != nil {
		return nil, fmt.Errorf("itunes: build request: %w", err)
	}

	resp, err := r.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("itunes: do request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("itunes: unexpected status %d", resp.StatusCode)
	}

	var payload itunesSearchResponse
	if err := json.NewDecoder(resp.Body).Decode(&payload); err != nil {
		return nil, fmt.Errorf("itunes: decode response: %w", err)
	}

	tracks := make([]*domain.Track, 0, len(payload.Results))
	for _, r := range payload.Results {
		if r.PreviewURL == "" {
			continue
		}
		tracks = append(tracks, mapITunesToDomain(r))
	}
	return tracks, nil
}

func mapITunesToDomain(r itunesResult) *domain.Track {
	return &domain.Track{
		ID:        strconv.FormatUint(r.TrackID, 10),
		Title:     r.TrackName,
		Artist:    r.ArtistName,
		StreamURL: r.PreviewURL,
		CoverArt:  r.ArtworkURL,
	}
}

func (r *ITunesRepository) FindByID(_ context.Context, _ string) (*domain.Track, error) {
	return nil, domain.ErrNotSupported
}

func (r *ITunesRepository) FindAll(_ context.Context) ([]*domain.Track, error) {
	return nil, domain.ErrNotSupported
}

func (r *ITunesRepository) Save(_ context.Context, _ *domain.Track) error {
	return domain.ErrNotSupported
}

func (r *ITunesRepository) Delete(_ context.Context, _ string) error {
	return domain.ErrNotSupported
}
