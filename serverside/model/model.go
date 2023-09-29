package model

type Task struct {
	TaskID      int      `json:"task_id"`
	Question    string   `json:"question"`
	Options     []string `json:"options"`
	AnswerIndex int      `json:"answerIndex"`
	Explanation string   `json:"Explanation"`
}

type User struct {
	User_id  int
	Username string
	password string
}

type StatisticInfo struct {
	Task_ID                int `json:"task_id"`
	NumberOfTasksCorrected int
	NumberOfTasksFailed    int
}
