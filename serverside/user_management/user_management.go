package user_management

import (
	"encoding/json"
	"net/http"
	"serverside/db"
)

// Add User Handler
func AddUserHandler(w http.ResponseWriter, r *http.Request) {
	username := r.FormValue("newUsername")
	password := r.FormValue("newPassword")

	err := db.CreateUser(username, password)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "user added successfully"})
}

// Remove User Handler
func RemoveUserHandler(w http.ResponseWriter, r *http.Request) {
	username := r.FormValue("removeUsername")

	err := db.RemoveUser(username) // You need to implement this function in your db package
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "user removed successfully"})
}

// Reset Password Handler
func ResetPasswordHandler(w http.ResponseWriter, r *http.Request) {
	username := r.FormValue("resetUsername")
	newPassword := r.FormValue("newPassword")

	err := db.UpdatePassword(username, newPassword)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "password reset successfully"})
}
