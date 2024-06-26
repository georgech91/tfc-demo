package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/greet", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "Hello world, George!")
	})

	log.Fatal(http.ListenAndServe(":8000", nil))
}
