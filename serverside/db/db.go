package db

import (
	"database/sql"
	"encoding/json"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
	"log"
	"net/http"
	"serverside/model"
)

var db *sql.DB

func InitDB() {
	var err error
	db, err = sql.Open("mysql", "root:zhao887700@tcp(127.0.0.1:3306)/logic_app")
	if err != nil {
		log.Fatal(err)
	}

}

// Single query
func QueryRowDemo(taskID int) (model.Task, error) {

	var task model.Task
	var option1, option2, option3, option4 string

	sqlStr := "SELECT `task_id`, `Question`,`Option1`,`Option2`,`Option3`,`Option4`, `AnswerIndex`, `Explanation` FROM `tasks` WHERE `task_id` = ?"
	err := db.QueryRow(sqlStr, taskID).Scan(&task.TaskID, &task.Question, &option1, &option2, &option3, &option4, &task.AnswerIndex, &task.Explanation)
	if err != nil {
		log.Fatal("error:", err)
		return task, err
	}

	task.Options = []string{option1, option2, option3, option4}

	return task, nil
}

// Insert data
func InsertRowDemo(question, option1, option2, option3, option4, answerIndex, explanation string) (int64, error) {
	sqlStr := `insert into tasks(Question, Option1, Option2, Option3, Option4, AnswerIndex, Explanation) values (?, ?, ?, ?, ?, ?, ?)`
	ret, err := db.Exec(sqlStr, question, option1, option2, option3, option4, answerIndex, explanation)
	if err != nil {
		return 0, fmt.Errorf("insert failed, err:%v", err)
	}

	theID, err := ret.LastInsertId()
	if err != nil {
		return 0, fmt.Errorf("get lastinsert ID failed, err:%v", err)
	}

	return theID, nil
}

// Update data
func UpdateRowDemo(taskID, newQuestion, newOption1, newOption2, newOption3, newOption4, newAnswerIndex, newExplanation string) error {
	sqlStr := `UPDATE tasks SET Question = ?, Option1 = ?, Option2 = ?, Option3 = ?, Option4 = ?, AnswerIndex = ?, Explanation = ? WHERE task_id = ?`
	_, err := db.Exec(sqlStr, newQuestion, newOption1, newOption2, newOption3, newOption4, newAnswerIndex, newExplanation, taskID)
	if err != nil {
		return fmt.Errorf("update failed, err:%v", err)
	}
	return nil
}

// Delate tasks
func RemoveRowDemo(taskID string) error {
	sqlStr := `DELETE FROM tasks WHERE task_id = ?`
	_, err := db.Exec(sqlStr, taskID)
	if err != nil {
		return fmt.Errorf("removal failed, err:%v", err)
	}
	return nil
}

// Fetch password from the database based on username
func FetchPasswordFromDB(username string) (string, error) {
	var password string
	sqlStr := "SELECT `password` FROM `user` WHERE `username` = ?"
	err := db.QueryRow(sqlStr, username).Scan(&password)
	if err != nil {
		return "", err
	}
	return password, nil
}

// CreateUser creates a new user in the database
func CreateUser(username, password string) error {
	// Hash the password using bcrypt
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	// Store the hashed password in the database
	sqlStr := `INSERT INTO user(username, password) VALUES (?, ?)`
	_, err = db.Exec(sqlStr, username, hashedPassword)
	if err != nil {
		return fmt.Errorf("create user failed, err:%v", err)
	}
	return nil
}

func UpdatePassword(username, newPassword string) error {
	// Hash the new password using bcrypt
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(newPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	// Update the hashed password in the database

	sqlStr := `UPDATE user SET password = ? WHERE username = ?`
	_, err = db.Exec(sqlStr, hashedPassword, username)
	if err != nil {
		return fmt.Errorf("password update failed, err:%v", err)
	}
	return nil
}

func CheckUsernameExists(username string) (bool, error) {
	var exists bool
	sqlStr := "SELECT EXISTS(SELECT 1 FROM user WHERE username = ?)"
	err := db.QueryRow(sqlStr, username).Scan(&exists)
	if err != nil {
		return false, err
	}
	return exists, nil
}

// RemoveUser removes a user from the database
func RemoveUser(username string) error {
	sqlStr := `DELETE FROM user WHERE username = ?`
	_, err := db.Exec(sqlStr, username)
	if err != nil {
		return fmt.Errorf("removal failed, err:%v", err)
	}
	return nil
}

type Statistics struct {
	Username           string       `json:"username"`
	Score              float64      `json:"score"`
	CorrectQuestions   []int        `json:"correctQuestions"`
	IncorrectQuestions []int        `json:"incorrectQuestions"`
	Accuracy           float64      `json:"accuracy"`
	TaskID             map[int]bool `json:"task_id"` // The key is task_id and the value is the status of the task (true means correct, false means wrong)
}

func SubmitStatistics(w http.ResponseWriter, r *http.Request) {
	var stats Statistics
	if err := json.NewDecoder(r.Body).Decode(&stats); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	fmt.Println("Received statistics:", stats)

	// calculate score
	score := stats.Accuracy * 10

	// Store scores into user table
	_, err := db.Exec("UPDATE user SET score = ? WHERE username = ?", score, stats.Username)

	if err != nil {
		http.Error(w, "Failed to update score in database", http.StatusInternalServerError)
		return
	}

	// Update task status in statistical_info table
	for taskID, isCorrect := range stats.TaskID {
		if isCorrect {
			_, err = db.Exec("UPDATE statistical_info SET number_of_tasks_corrected = number_of_tasks_corrected + 1 WHERE task_id = ?", taskID)
		} else {
			_, err = db.Exec("UPDATE statistical_info SET number_of_tasks_failed = number_of_tasks_failed + 1 WHERE task_id = ?", taskID)
		}
		if err != nil {
			http.Error(w, "Failed to update task status in database", http.StatusInternalServerError)
			return
		}
	}

	w.WriteHeader(http.StatusOK)
}

type TopUser struct {
	Username string  `json:"username"`
	Score    float64 `json:"score"`
}

func FetchTopUsers(w http.ResponseWriter, r *http.Request) {
	var users []TopUser
	rows, err := db.Query("SELECT username, score FROM user ORDER BY score DESC LIMIT 3")
	if err != nil {
		http.Error(w, "Database query failed", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	for rows.Next() {
		var user TopUser
		if err := rows.Scan(&user.Username, &user.Score); err != nil {
			http.Error(w, "Row parsing error", http.StatusInternalServerError)
			return
		}
		users = append(users, user)
	}

	if err := rows.Err(); err != nil {
		http.Error(w, "Row parsing error", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(users)
	fmt.Println(users)
}

func GetTask(w http.ResponseWriter, r *http.Request) {
	// Define a slice to hold the tasks
	var tasks []model.Task

	// Execute the SQL query
	rows, err := db.Query("SELECT task_id, Question, Option1, Option2, Option3, Option4, AnswerIndex, Explanation FROM tasks ORDER BY RAND() LIMIT 10")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	// Scan the rows into the tasks slice
	for rows.Next() {
		var task model.Task
		var opt1, opt2, opt3, opt4 string
		if err := rows.Scan(&task.TaskID, &task.Question, &opt1, &opt2, &opt3, &opt4, &task.AnswerIndex, &task.Explanation); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		task.Options = []string{opt1, opt2, opt3, opt4}
		tasks = append(tasks, task)
	}

	// Check for errors from iterating over rows.
	if err := rows.Err(); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// Encode tasks to JSON and send to the client
	fmt.Println(tasks)
	json.NewEncoder(w).Encode(tasks)
}

func GetHardestTask() (int, error) {
	query := `
        SELECT task_id
        FROM statistical_info
        ORDER BY number_of_tasks_corrected / (number_of_tasks_corrected + number_of_tasks_failed) ASC
        LIMIT 1;
    `
	row := db.QueryRow(query)
	var taskID int
	err := row.Scan(&taskID)
	return taskID, err
}

func GetEasiestTask() (int, error) {
	query := `
        SELECT task_id
        FROM statistical_info
        ORDER BY number_of_tasks_corrected / (number_of_tasks_corrected + number_of_tasks_failed) DESC
        LIMIT 1;
    `
	row := db.QueryRow(query)
	var taskID int
	err := row.Scan(&taskID)
	return taskID, err
}
