package admin

import (
	"fmt"
	"html/template"
	"net/http"
	"serverside/db"
)

type Statsinfo struct {
	HardestTaskID int
	EasiestTaskID int
}

func AdminPageHandler(w http.ResponseWriter, r *http.Request) {
	// Get the hardest and easiest tasks from the database first
	hardestTaskID, err := db.GetHardestTask()
	if err != nil {
		http.Error(w, "Failed to get hardest task", http.StatusInternalServerError)
		return
	}
	fmt.Println(hardestTaskID)

	easiestTaskID, err := db.GetEasiestTask()
	if err != nil {
		http.Error(w, "Failed to get easiest task", http.StatusInternalServerError)
		return
	}
	fmt.Println(easiestTaskID)

	// Initialize the statsinfo structure with data obtained from the database
	statsinfo := Statsinfo{
		HardestTaskID: hardestTaskID,
		EasiestTaskID: easiestTaskID,
	}
	fmt.Println("3")

	// Load HTML template
	tmpl, err := template.ParseFiles("admin.html")
	if err != nil {
		http.Error(w, "Could not load admin page", http.StatusInternalServerError)
		return
	}
	fmt.Println("4")

	// Pass the statsinfo structure to the HTML template and execute it
	err = tmpl.Execute(w, statsinfo)
	if err != nil {
		http.Error(w, "Failed to write response", http.StatusInternalServerError)
	}
}

func AddTask(w http.ResponseWriter, r *http.Request) {
	// Parse form data
	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	// Get form data
	question := r.FormValue("question")
	option1 := r.FormValue("option1")
	option2 := r.FormValue("option2")
	option3 := r.FormValue("option3")
	option4 := r.FormValue("option4")
	answerIndex := r.FormValue("answerIndex")
	explanation := r.FormValue("explanation")

	// Call the insertRowDemo function in db.go to insert data
	taskID, err := db.InsertRowDemo(question, option1, option2, option3, option4, answerIndex, explanation)
	if err != nil {
		http.Error(w, "Database insert failed", http.StatusInternalServerError)
		return
	}

	// Return success information
	fmt.Fprintf(w, "Task successfully added with ID %d", taskID)
}

func UpdateTask(w http.ResponseWriter, r *http.Request) {

	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	taskID := r.FormValue("updateTaskID")
	newQuestion := r.FormValue("newQuestion")
	newOption1 := r.FormValue("newOption1")
	newOption2 := r.FormValue("newOption2")
	newOption3 := r.FormValue("newOption3")
	newOption4 := r.FormValue("newOption4")
	newAnswerIndex := r.FormValue("newAnswerIndex")
	newExplanation := r.FormValue("newExplanation")

	err = db.UpdateRowDemo(taskID, newQuestion, newOption1, newOption2, newOption3, newOption4, newAnswerIndex, newExplanation)
	if err != nil {
		http.Error(w, "Database update failed", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "Task successfully updated")
}

func RemoveTask(w http.ResponseWriter, r *http.Request) {
	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	taskID := r.FormValue("id")

	err = db.RemoveRowDemo(taskID)
	if err != nil {
		http.Error(w, "Database removal failed", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "Task successfully removed")

}
