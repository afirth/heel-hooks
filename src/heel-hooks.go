package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	fs := http.FileServer(http.Dir("/static"))

	httpAddr := os.Getenv("HTTP_ADDR")
	http.HandleFunc("/healthz", healthz)
	http.HandleFunc("/readyz", readyz)
	http.Handle("/static/", http.StripPrefix("/static/", fs))
	http.HandleFunc("/", readyz)

	log.Printf("HTTP service listening on %s", httpAddr)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func readyz(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Ready for traffic"))
}

func healthz(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Healthy"))
}
