package domain

import "time"

// Stock representa la información de un valor bursátil.
type Stock struct {
	ID         int64     `gorm:"primaryKey" json:"id"`
	Ticker     string    `gorm:"not null" json:"ticker"`
	Company    string    `gorm:"not null" json:"company"`
	Brokerage  string    `gorm:"not null" json:"brokerage"`
	Action     string    `gorm:"not null" json:"action"`
	RatingFrom string    `gorm:"not null" json:"rating_from"`
	RatingTo   string    `gorm:"not null" json:"rating_to"`
	TargetFrom float64   `gorm:"not null" json:"target_from"`
	TargetTo   float64   `gorm:"not null" json:"target_to"`
	Currency   string    `gorm:"not null;default:'USD'" json:"currency"`
	Time       time.Time `gorm:"not null" json:"time"`
}
