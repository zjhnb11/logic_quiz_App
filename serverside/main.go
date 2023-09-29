package main

import (
	"github.com/gorilla/mux"
	"net/http"
	"serverside/admin"
	"serverside/db"
	"serverside/login"
	"serverside/user_management"
)

func main() {
	db.InitDB()
	router := mux.NewRouter()

	// API router
	router.HandleFunc("/api/task", db.GetTask).Methods("GET")
	router.HandleFunc("/api/submit", db.SubmitStatistics).Methods("POST")
	router.HandleFunc("/api/topusers", db.FetchTopUsers).Methods("GET")

	// Admin router
	router.HandleFunc("/admin", admin.AdminPageHandler).Methods("GET")
	router.HandleFunc("/admin/add", admin.AddTask).Methods("POST")
	router.HandleFunc("/admin/remove", admin.RemoveTask).Methods("POST")
	router.HandleFunc("/admin/update", admin.UpdateTask).Methods("POST")

	//login router
	router.HandleFunc("/api/login", login.LoginHandler).Methods("POST")
	router.HandleFunc("/api/register", login.RegisterHandler).Methods("POST")
	router.HandleFunc("/api/resetpassword", login.ResetPasswordHandler).Methods("POST")
	router.HandleFunc("/api/checkusername", login.CheckUsernameHandler).Methods("POST")

	// User Management Routes
	router.HandleFunc("/user_management/adduser", user_management.AddUserHandler).Methods("POST")
	router.HandleFunc("/user_management/removeuser", user_management.RemoveUserHandler).Methods("POST")
	router.HandleFunc("/user_management/resetuserpassword", user_management.ResetPasswordHandler).Methods("POST")

	http.ListenAndServe(":8080", router)
}
