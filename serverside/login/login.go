package login

import (
	"encoding/json"
	"golang.org/x/crypto/bcrypt"
	"log"
	"net/http"
	"serverside/db"
)

type Credentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type RegisterRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type ResetPasswordRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type CheckUsernameRequest struct {
	Username string `json:"username"`
}

func LoginHandler(w http.ResponseWriter, r *http.Request) {
	var creds Credentials
	err := json.NewDecoder(r.Body).Decode(&creds)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	log.Printf("Received username: %s\n", creds.Username)

	// Fetch hashed password from DB
	storedHashedPassword, err := db.FetchPasswordFromDB(creds.Username)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	// Compare the provided password with the stored hashed password using bcrypt
	err = bcrypt.CompareHashAndPassword([]byte(storedHashedPassword), []byte(creds.Password))
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		json.NewEncoder(w).Encode(map[string]string{"status": "unauthorized"})
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "you are logged in"})
}

func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	var req RegisterRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	// Create user in DB
	err = db.CreateUser(req.Username, req.Password)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "registration successful"})
}

func ResetPasswordHandler(w http.ResponseWriter, r *http.Request) {
	var req ResetPasswordRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	// Update password in DB
	err = db.UpdatePassword(req.Username, req.Password)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "password reset successful"})
}

func CheckUsernameHandler(w http.ResponseWriter, r *http.Request) {
	var req CheckUsernameRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	// Check if username exists in DB
	exists, err := db.CheckUsernameExists(req.Username)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	if exists {
		w.WriteHeader(http.StatusOK)
	} else {
		w.WriteHeader(http.StatusNotFound)
	}
}
